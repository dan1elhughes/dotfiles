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
	local output_file opencode_status iteration prompt prompt_file
	iteration=1
	prompt_file="${RALPH_LINEAR_PROMPT_FILE:-${XDG_CONFIG_HOME:-$HOME/.config}/opencode/ralph-linear-prompt.md}"

	while true; do
		echo "ralph-linear: iteration ${iteration} for ${linear_id}"

		if [ ! -r "$prompt_file" ]; then
			echo "ralph-linear: prompt file is not readable: ${prompt_file}"
			return 1
		fi

		prompt="$(cat "$prompt_file")
${linear_id}"

		output_file="$(mktemp -t ralph-linear.XXXXXX)" || return 1
		opencode run "$prompt" 2>&1 | tee "$output_file"
		opencode_status=$pipestatus[1]

		if grep -q '=== ALL TASKS COMPLETE ===' "$output_file"; then
			rm -f "$output_file"
			return 0
		fi

		if grep -q '=== BLOCKED ===' "$output_file"; then
			rm -f "$output_file"
			return 1
		fi

		if grep -q '=== CONTINUE ===' "$output_file"; then
			rm -f "$output_file"
			iteration=$((iteration + 1))
			continue
		fi

		rm -f "$output_file"

		if [ "$opencode_status" -ne 0 ]; then
			echo "ralph-linear: opencode exited with status ${opencode_status} before emitting a completion semaphore"
			return "$opencode_status"
		fi

		echo "ralph-linear: opencode exited without emitting a completion semaphore"
		return 1
	done
}
