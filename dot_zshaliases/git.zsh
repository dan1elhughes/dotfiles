# This alias seems to be inconsistent, so unalias it if it exists.
if which g >/dev/null 2>&1; then
	unalias g
fi

function g() {
	if [ "$#" -eq 0 ]; then
		git status --short --branch
	else
		git "$@"
	fi
}

function gcai() {
	opencode run /commit "$@"
}
