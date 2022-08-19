unalias g
g() {
	if [ "$#" -eq 0 ]; then
		hub status --short --branch
	else
		hub "$@"
	fi
}
