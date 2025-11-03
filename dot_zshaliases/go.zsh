# Helper function to check if a command is installed
check-installed() {
    local cmd=$1
    if ! command -v "$cmd" &> /dev/null; then
        echo "$cmd not installed"
        return 1
    fi
}

runtests() {
    local envfile=$(git rev-parse --show-toplevel)/.env
    local envfile_local=$(git rev-parse --show-toplevel)/.env.local

    zsh -c "set -a; [ -f $envfile ] && source $envfile; [ -f $envfile_local ] && source $envfile_local; go test -p=1 ./... && echo ✅ || echo ❌"
}

# Watch all files for changes, and run tests when they change.
watchtests() {
    check-installed fd || return 1
    check-installed entr || return 1

    local envfile=$(git rev-parse --show-toplevel)/.env
    local envfile_local=$(git rev-parse --show-toplevel)/.env.local

    fd -e go | entr -c sh -c "set -a; [ -f $envfile ] && source $envfile; [ -f $envfile_local ] && source $envfile_local; go test -p=1 ./... && echo ✅ || echo ❌"
}

watchtest() {
    local testName=$1
    if [ -z "$testName" ]; then
        echo "Usage: watchtest <testName>"
        return 1
    fi

    check-installed fd || return 1
    check-installed entr || return 1

    local envfile=$(git rev-parse --show-toplevel)/.env
    local envfile_local=$(git rev-parse --show-toplevel)/.env.local

    fd -e go | entr -c zsh -c "set -a; [ -f $envfile ] && source $envfile; [ -f $envfile_local ] && source $envfile_local; go test -p=1 ./... -run '$testName' && echo ✅ || echo ❌"
}

runtest() {
    local testName=$1
    if [ -z "$testName" ]; then
        echo "Usage: runtest <testName>"
        return 1
    fi

    local envfile=$(git rev-parse --show-toplevel)/.env
    local envfile_local=$(git rev-parse --show-toplevel)/.env.local

    zsh -c "set -a; [ -f $envfile ] && source $envfile; [ -f $envfile_local ] && source $envfile_local; go test -p=1 ./... -run '$testName' && echo ✅ || echo ❌"
}

# Watch all files for changes, and build when they change.
watchbuild() {
    check-installed fd || return 1
    check-installed entr || return 1

    fd -e go | entr -c sh -c "go build ./... && echo ✅ || echo ❌"
}

# Watch all files for changes, and run linter when they change.
watchlint () {
    check-installed fd || return 1
    check-installed entr || return 1
    check-installed golangci-lint || return 1

    fd -e go | entr -c sh -c "golangci-lint run && echo ✅ || echo ❌"
}
