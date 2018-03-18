# bash completion example

# source ${this_file}
# original_<tab>

original_function() {
	case $1 in
		help) echo "show help";;
		version) echo "version 0.0.0";;
	esac
}

_original_function() {
	COMPREPLY=(help version)
}

# complete is bash builtin function
complete -F _original_function original_function
