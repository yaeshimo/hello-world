
comp() {
	case $1 in
		hello) echo "hello";;
		world) echo "world";;
	esac
}

_comp() {
	local cur prev opts
	_get_comp_words_by_ref -n : cur prev
	opts="hello world"

	COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
}

complete -F _comp comp
