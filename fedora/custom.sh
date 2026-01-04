# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# for GPG to work properly
export GPG_TTY=$(tty)

# LaTeX
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:${PATH}"
export MANPATH="/usr/local/texlive/2025/texmf-dist/doc/man:${MANPATH}"
export INFOPATH="/usr/local/texlive/2025/texmf-dist/doc/info:${INFOPATH}"

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\e[32m\u@\h \e[35m\]$(basename $SHELL) \[\e[34m\]\w\[\e[36m\]\$(parse_git_branch)\[\e[00m\]\n$ "
