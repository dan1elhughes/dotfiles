if which o >/dev/null 2>&1; then
	unalias o
fi

if which oc >/dev/null 2>&1; then
	unalias oc
fi

alias o="opencode"
alias oc="opencode --continue"

ralph-linear() {
	if [ "$#" -ne 1 ]; then
		echo "usage: ralph-linear <LINEAR_ID>"
		return 2
	fi

	local linear_id="$1"
	local output_file status iteration
	iteration=1

	while true; do
		echo "ralph-linear: iteration ${iteration} for ${linear_id}"
		output_file="$(mktemp -t ralph-linear.XXXXXX)" || return 1
		opencode run "/ralph-linear ${linear_id}" 2>&1 | tee "$output_file"
		status=$pipestatus[1]

		if grep -q '=== ALL TASKS COMPLETE ===' "$output_file"; then
			rm -f "$output_file"
			return 0
		fi

		if grep -q '=== BLOCKED ===' "$output_file"; then
			rm -f "$output_file"
			return 1
		fi

		rm -f "$output_file"

		if [ "$status" -ne 0 ]; then
			echo "ralph-linear: opencode exited with status ${status} before emitting a completion semaphore"
			return "$status"
		fi

		iteration=$((iteration + 1))
	done
}
