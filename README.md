# My dotfiles

This directory contains the dotfiles for my systems.

## Deploy Script

The `deploy.sh` script is used to create symlinks or copy config files or directories into $HOME similar to `GNU stow`. But in contrast to stow the git-repository has not to lie in the home dir.

__Because of relative paths, the deploy-script must be called from the containing dir.__

The script checks if the source path exists and if not, the user has to handle this error. Furthermore the script also quits, if the target already exists and is not a symlink.

Three functions are defined in `functions.sh` which can be used in `deploy.sh`.

- `cmd_exists`: Check if a command exists like `ìf cmd_exists md; then do_stuff; fi`
- `link`: Links the first argument th the same path relative to $HOME.
- `copy`: Copies the first argument to the same path relative to $HOME.
