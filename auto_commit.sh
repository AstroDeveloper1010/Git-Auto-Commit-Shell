# This shell script will automate git commit

# configuration
REPO_DIR = "https://github.com/AstroDeveloper1010/Git-Auto-Commit-Shell.git"
BRANCH = "main"
COMMIT_MESSAGE = "updated"

# function to check if git repository is clean
is_clean_repo() {
    cd "$REPO_DIR" || exit 1
    git diff --quiet && git diff --staged --quiet
}

# function to commit and push
commit() {
    cd "$REPO_DIR" || exit 1
    git add .

    if git commit -m "$1"; then
        if git push origin "$BRANCH"; then
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
}

# main logic
if is_clean_repo; then
    echo "Code has no changes to commit"
else
    TIMESTAMP = $(date + "%Y-%m-%d %H:%M:%S")
    COMMIT_MESSAGE = "$COMMIT_MESSAGE - $TIMESTAMP"

    if commit "$COMMIT_MESSAGE"; then
        echo "commit successful return 0"
    else
        echo "commit failed return -1"
    fi
fi
