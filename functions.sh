# Idea from: https://github.com/rexim/dotfiles/blob/master/deploy.sh
HOST=$(uname -n)
echo "--- Deploying dotfiles for '$HOST' ---"

# checks if a command exists
cmd_exists() {
    return $(command -v $1 &> /dev/null)
}

# Symlinks a script-local file path to $HOME.
# Examples:
#  - link file.txt
#    Links './file.txt' to '$HOME/file.txt'.
#  - link file_a.txt file.txt
#    Links './file_a.txt' to '$HOME/file.txt'.
link() {
    src="$PWD/$1" # source is always relative to current working dir
    dest="$HOME/$1"

    # If $2 is supplied, use it as target path
    if [ $# -gt 1 ]; then dest="$HOME/$2"; fi

    if [ ! -e "$src" ]; then
        echo "[ERR]  LINK: '$src' does not exists. Exiting!"
        exit 1
    fi

    if [ -L "$dest" ]; then
        if [ ! -e "$dest" ] ; then
            echo "[WARN] LINK: Removing '$dest' because it is a broken symlink."
            rm -r "$dest"
        else
            echo "[WARN] LINK: '$dest' already symlinked."
            return
        fi
    fi

    if [ -e "$dest" ]; then
        echo "[ERR]  LINK: '$1' exists but it's not a symlink. Please fix that manually. Exiting!"
        exit 1
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "[OK]   LINK: '$1' -> '$dest'"
}

# like link but copies files or directories
copy() {
    src="$PWD/$1" # source is always relative to current working dir
    dest="$HOME/$1"

    # If $2 is supplied, use it as target path
    if [ $# -gt 1 ]; then dest="$HOME/$2"; fi

    if [ ! -e "$src" ]; then
        echo "[ERR]  COPY: '$src' does not exists. Exiting!"
        exit 1
    fi

    if [ -e "$dest" ]; then
        echo "[WARN] COPY: '$1' already exists. Skipping!"
        return
    fi

    mkdir -p "$(dirname "$dest")"
    cp -r "$src" "$dest"
    echo "[OK]   COPY: '$1' -> '$dest'"
}
