#!/usr/bin/env bash

RED="\033[31m"
RESET="\033[0m"

log_error() {
	echo -e "${RED}[Error]${RESET} $1" >&2
}

JAR_PATH="$1"

if [ ! -f "$JAR_PATH" ]; then
	log_error "Arquivo não encontrado: '$JAR_PATH'."
	exit 1
fi

command -v java >/dev/null 2>&1 || {
	log_error "Java não encontrado no sistema"
	exit 1
}

nohup java -jar $JAR_PATH > /dev/null 2>&1 &
