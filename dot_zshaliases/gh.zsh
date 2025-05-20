function copypr() {
    echo "⏳ Reading pull request $1..."
    content=$(gh pr view $1 --json additions,deletions,title,url)

    title=$(echo $content | jq -r '.title')
    url=$(echo $content | jq -r '.url')
    additions=$(echo $content | jq -r '.additions')
    deletions=$(echo $content | jq -r '.deletions')

    echo -e ":github: [$title (+$additions, -$deletions)]($url)" | pbcopy

    echo "✅ Pull request copied to clipboard in Slack format."
}

function watchchecks() {
    pr=$1

    content=$(gh pr view $1 --json title)
    title=$(echo $content | jq -r '.title')

    gh pr checks --watch $1

    osascript -e "display notification \"$title\" with title \"PR checks done\""
}

function sendit() {
    gp -u && gh pr create --fill && gh pr merge --squash --auto
}
