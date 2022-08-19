function copypr() {
    echo "⏳ Reading pull request $1..."
    content=$(gh pr view $1)

    title=$(echo $content | grep "title:" | cut -d$'\t' -f2)
    url=$(echo $content | grep "url:" | cut -d$'\t' -f2)

    echo -e ":github-green: $title\n:pr-arrow-darkmode: $url" | pbcopy

    echo "✅ Pull request copied to clipboard in Slack format."
}

function waitmerge() {
    pr=$1

    gh pr merge $1 --squash --delete-branch > /dev/null 2>&1
    while [ $? -ne 0 ]; do
        echo -n "."
        gh pr merge $1 --squash --delete-branch > /dev/null 2>&1
    done

    echo
}
