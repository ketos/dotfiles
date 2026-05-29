#!/usr/bin/bash
# Deploy script for config files and directories, similar to gnu stow.
cd "$(dirname "${BASH_SOURCE[0]}")"
source functions.sh || exit 1
# Syntax: <func> <src> [dest]
#         <func> = link|copy
# Add config files and folders after this line

# You can deploy host specific configs with a fallback
if [ -e ".profile.$HOST" ];
then link ".profile.$HOST" .profile;
else link .profile; fi

link .bashrc

# You can conditionally deploy config files
if cmd_exists "helix"; then link .config/helix; fi
if cmd_exists "fish"; then
    link .config/fish/config.fish
    link .config/fish/functions
fi

# You can deploy host specific config file sets
if [ "$HOST" != "haven.local" ]; then
    link .config/gtk-3.0/settings.ini
    link .config/git/config

    if cmd_exists "fastfetch"; then link .config/fastfetch/config.jsonc; fi
    if cmd_exists "mpv"; then link .config/mpv; fi
    if cmd_exists "zeditor"; then link .config/zed; fi

    link .local/bin/pacman-disowned-dirs
    link .local/bin/pacman-disowned-files 
fi
