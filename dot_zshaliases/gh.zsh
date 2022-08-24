function copypr() {
    echo "⏳ Reading pull request $1..."
    content=$(gh pr view $1 --json additions,deletions,title,url)

    title=$(echo $content | jq -r '.title')
    url=$(echo $content | jq -r '.url')
    additions=$(echo $content | jq -r '.additions')
    deletions=$(echo $content | jq -r '.deletions')

    echo -e ":github-green: $title (+$additions, -$deletions)\n:pr-arrow-darkmode: $url" | pbcopy

    echo "✅ Pull request copied to clipboard in Slack format."
}

function waitmerge() {
    pr=$1

    gh pr merge $1 --squash --delete-branch > /dev/null 2>&1
    while [ $? -ne 0 ]; do
        echo -n "."
        sleep 5
        gh pr merge $1 --squash --delete-branch > /dev/null 2>&1
    done

    echo
}
