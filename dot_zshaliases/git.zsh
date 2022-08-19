g() {
	if [ "$#" -eq 0 ]; then
		git status --short --branch
	else
		git "$@"
	fi
}
