#!/usr/bin/env bash
set -euo pipefail

#######################################
# Configurações e utilitários
#######################################

VERBOSE=false

BLUE="\033[34m"
CYAN="\033[36m"
RED="\033[31m"
YELLOW="\033[33m"
RESET="\033[0m"

log_info() {
	echo -e "${BLUE}[Info]${RESET} $1" >&2
}

log_warn() {
	echo -e "${YELLOW}[Warn]${RESET} $1" >&2
}

log_error() {
	echo -e "${RED}[Error]${RESET} $1" >&2
}

log_debug() {
	if $VERBOSE; then
		echo -e "${CYAN}[Debug]${RESET} $1"
	fi
}

#######################################
# Parsing de argumentos
#######################################

usage() {
	echo "Uso: $0 [-v] <diretório>"
	echo "  -v   Modo verboso (debug)"
	exit 1
}

while getopts ":v" opt; do
	case $opt in
		v) VERBOSE=true ;;
		*) usage ;;
	esac
done
shift $((OPTIND -1))

if [ $# -ne 1 ]; then
	usage
fi

ROOT_DIR="$(realpath "$1")"

#######################################
# Validações
#######################################

if [ ! -d "$ROOT_DIR" ]; then
	log_error "Diretório não encontrado: '$ROOT_DIR'"
	exit 1
fi

command -v gs >/dev/null 2>&1 || {
	log_error "Ghostscript (gs) não encontrado no sistema."
	exit 1
}

#######################################
# Funções auxiliares
#######################################

compress_pdf() {
	local input="$1"
	local output="$2"

	gs -sDEVICE=pdfwrite \
		-dCompatibilityLevel=1.7 \
		-dNOPAUSE -dQUIET -dBATCH \
		-dDownsampleGrayImages=true \
		-dDownsampleMonoImages=true \
		-dDownsampleColorImages=true \
		-dGrayImageDownsampleType=/Average \
		-dMonoImageDownsampleType=/Subsample \
		-dColorImageDownsampleType=/Average \
		-dGrayImageResolution=300 \
		-dMonoImageResolution=300 \
		-dColorImageResolution=300 \
		-sOutputFile="$output" \
		"$input"
}

dir_size_bytes() {
	find "$1" \
		-type f \
		-name '*.pdf' \
		! -path '*/uncompressed/*' \
		-exec stat -c '%s' {} + 2>/dev/null |
		awk '{s+=$1} END {print s+0}'
}


#######################################
# Medição inicial
#######################################

log_info "Calculando tamanho inicial dos PDFs..."
SIZE_BEFORE=$(dir_size_bytes "$ROOT_DIR")

#######################################
# Renomeação para -uncompressed
#######################################

log_info "Renomeando PDFs para sufixo -uncompressed..."

find "$ROOT_DIR" -type f -name '*.pdf' ! -name '*-uncompressed.pdf' | while read -r pdf; do
	if head -c 4 "$pdf" | grep -q "%PDF"; then
		base="${pdf%.pdf}"
		new="${base}-uncompressed.pdf"

		log_info "Renomeando: '$new'"
		log_debug "'$pdf' -> '$new'"

		mv "$pdf" "$new"
	else
		log_warn "Ignorando (não parece PDF válido): '$pdf'"
	fi
done

#######################################
# Compressão
#######################################

log_info "Comprimindo PDFs..."

find "$ROOT_DIR" -type f -name '*-uncompressed.pdf' | while read -r pdf; do
	output="${pdf%-uncompressed.pdf}.pdf"

	log_info "Comprimindo: '$output'"
	log_debug "'$pdf' -> '$output'"

	compress_pdf "$pdf" "$output"

	size_original=$(stat -c %s "$pdf")
	size_compressed=$(stat -c %s "$output")
	log_debug "original: $size_original bytes, comprimido: $size_compressed bytes"

	if [ "$size_compressed" -ge "$size_original" ]; then
		log_warn "Compressão piorou, mantendo original: '$output'"

		rm "$output"
		mv "$pdf" "$output"
	fi

done

#######################################
# Organização dos uncompressed
#######################################

UNCOMPRESSED_DIR="$ROOT_DIR/uncompressed"
log_info "Movendo arquivos uncompressed para '$UNCOMPRESSED_DIR'"

find "$ROOT_DIR" -type f -name '*-uncompressed.pdf' | while read -r pdf; do
	rel="${pdf#$ROOT_DIR/}"
	target_dir="$UNCOMPRESSED_DIR/$(dirname "$rel")"

	mkdir -p "$target_dir"

	log_info "Movendo: '$pdf'"
	log_debug "'$pdf' -> '$target_dir/'"

	mv "$pdf" "$target_dir/"
done


#######################################
# Medição final
#######################################

log_info "Calculando tamanho final dos PDFs..."
SIZE_AFTER=$(dir_size_bytes "$ROOT_DIR")

#######################################
# Relatório
#######################################

DELTA=$((SIZE_BEFORE - SIZE_AFTER))

echo
echo "Resumo:"
echo "----------------------------------------"
echo "Tamanho antes : $(numfmt --to=iec "$SIZE_BEFORE")"
echo "Tamanho depois: $(numfmt --to=iec "$SIZE_AFTER")"

if [ "$DELTA" -ge 0 ]; then
    echo "Economia:       $(numfmt --to=iec "$DELTA")"
else
    echo "Diferença:      -$(numfmt --to=iec "$((-DELTA))")"
fi

echo "----------------------------------------"
