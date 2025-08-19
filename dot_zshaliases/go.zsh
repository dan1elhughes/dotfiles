# Watch all files for changes, and run tests when they change.
watchtests() {
    if ! command -v fd &> /dev/null; then
        echo "fd not installed"
        return 1
    fi
    if ! command -v entr &> /dev/null; then
        echo "entr not installed"
        return 1
    fi

    # Find the closest .env upwards
	envfile=$(pwd)
	while [ "$envfile" != "/" ]; do
		if [ -f "$envfile/.env" ]; then
			break
		fi
		envfile=$(dirname "$envfile")
	done

    fd -e go | entr -c sh -c "set -a; [ -f $envfile/.env ] && source $envfile/.env; go test -short -p=1 ./... && echo ✅ || echo ❌"
}

watchtest() {
    if ! command -v fd &> /dev/null; then
        echo "fd not installed"
        return 1
    fi
    if ! command -v entr &> /dev/null; then
        echo "entr not installed"
        return 1
    fi

    # Find the closest .env upwards
	envfile=$(pwd)
	while [ "$envfile" != "/" ]; do
		if [ -f "$envfile/.env" ]; then
			break
		fi
		envfile=$(dirname "$envfile")
	done

    testName=$1
    if [ -z "$testName" ]; then
        echo "Usage: watchtest <testName>"
        return 1
    fi

    fd -e go | entr -c sh -c "set -a; [ -f $envfile/.env ] && source $envfile/.env; go test ./... -short -p=1 -run $testName && echo ✅ || echo ❌"
}

# Watch all files for changes, and build when they change.
watchbuild() {
    if ! command -v fd &> /dev/null; then
        echo "fd not installed"
        return 1
    fi
    if ! command -v entr &> /dev/null; then
        echo "entr not installed"
        return 1
    fi

    fd -e go | entr -c sh -c "go build ./... && echo ✅ || echo ❌"
}

# Watch all files for changes, and run linter when they change.
watchlint () {
        if ! command -v fd &> /dev/null
        then
                echo "fd not installed"
                return 1
        fi
        if ! command -v entr &> /dev/null
        then
                echo "entr not installed"
                return 1
        fi
        if ! command -v golangci-lint &> /dev/null
        then
                echo "golangci-lint not installed"
                return 1
        fi
        fd -e go | entr -c sh -c "golangci-lint run && echo ✅ || echo ❌"
}
