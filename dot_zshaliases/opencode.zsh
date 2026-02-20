if which o >/dev/null 2>&1; then
	unalias o
fi

if which oc >/dev/null 2>&1; then
	unalias oc
fi

alias o="opencode"
alias oc="opencode --continue"
