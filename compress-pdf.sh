#!/usr/bin/env bash

print_error() {
	echo -e "\033[31m$1\033[0m" >&2
}

# Verifica se o caminho foi informado
if [ -z "$1" ]; then
	print_error "Erro: Informe o caminho do arquivo PDF."
	exit 1
fi

PDF_PATH="$1"

# Verifica se o arquivo existe
if [ ! -f "$PDF_PATH" ]; then
	print_error "Erro: Arquivo não encontrado: '$PDF_PATH'."
	exit 1
fi

# Verifica se o arquivo é um PDF (checa extensão e cabeçalho)
if [[ "${PDF_PATH##*.}" != "pdf" ]]; then
	print_error "Erro: Arquivo não possui extensão .pdf: '$PDF_PATH'."
	exit 1
fi

if ! head -c 4 "$PDF_PATH" | grep -q "%PDF"; then
	print_error "Erro: Arquivo não parece ser um PDF válido: '$PDF_PATH'."
	exit 1
fi

OUT_PATH="${PDF_PATH%.pdf}-compressed.pdf" # Monta o nome do arquivo de saída

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
	-sOutputFile="$OUT_PATH" \
	"$PDF_PATH"
