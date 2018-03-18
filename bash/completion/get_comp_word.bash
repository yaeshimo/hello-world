# _get_comp_words_by_ref() from bash_completion

get_comp_word() {
	echo "get_comp_word"
}

_get_comp_word() {
	local cur prev cword
	_get_comp_words_by_ref -n : cur prev cword
	echo ""
	echo "cur:${cur}"
	echo "prev:${prev}"
	echo "cword:${cword}"
}

complete -F _get_comp_word get_comp_word
