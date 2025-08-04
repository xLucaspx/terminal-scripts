#!/bin/bash

JAR_PATH="$1"

if [ ! -f "$JAR_PATH" ]; then
	echo -e "\e[31mFile not found:\e[0m '$JAR_PATH'"
	exit 1
fi

nohup java -jar $JAR_PATH > /dev/null 2>&1 &
