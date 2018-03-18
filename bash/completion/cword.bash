
# source ${this_file}
# comp_cword <tab>
# <C-l>
# comp_cword hello world <tab>
# <C-l>

comp_cword() {
	echo "comp_cword"
}

_comp_cword() {
	echo
	echo COMP_CWORD:${COMP_CWORD}
	echo COMP_WORDS:${COMP_WORDS[@]}
	echo Current cursor:${COMP_CWORD[${COMP_CWORD}]}
	echo Previous cursor:${COMP_CWORD[${COMP_CWORD}-1]}
}

complete -F _comp_cword comp_cword
