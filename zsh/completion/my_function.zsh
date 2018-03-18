my_function() {
	typeset -a modes

	help() {
		echo "help"
	}

	version() {
		echo "version"
	}

	while [ $1 ]; do
		case $1 in
			help)
				help
				return
				;;
			version)
				version
				return
				;;
			*)
				modes=($modes[*] $1)
				;;
		esac
		shift
	done

	if (( $#modes == 0 )); then
		help
		return
	fi

	for mode in $modes;do
		if type $mode > /dev/null 2>&1; then
			$mode
		else
			echo "not found \"$mode\""
		fi
	done
}
