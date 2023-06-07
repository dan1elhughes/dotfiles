# Watch all files for changes, and run tests when they change.
watchtests() {
    if ! command -v fd &> /dev/null; then
        echo "fd not installed"
        return 1
    fi
    if ! command -v entr &> /dev/null; then
        echo "fd not installed"
        return 1
    fi

    fd -e go | entr -c sh -c "go test -short ./... && echo ✅ || echo ❌"
}

# Watch all files for changes, and build when they change.
watchbuild() {
    if ! command -v fd &> /dev/null; then
        echo "fd not installed"
        return 1
    fi
    if ! command -v entr &> /dev/null; then
        echo "fd not installed"
        return 1
    fi

    fd -e go | entr -c sh -c "go build ./... && echo ✅ || echo ❌"
}
