
# 🏠 home

  * .config/home-manager: home-manager configuration
  * .config/nixos: system configuration
  * .local/bin/: scripts & binaries


## Aliases

  * e -- edit file
  * home -- git alias to manage home directory
  * ehome -- edit .config/home-manager/home.nix && home-manager switch


## generations & cleanup

    # show all generations
    nix-env --list-generations --profile /nix/var/nix/profiles/system/

    # cleanup old generations
    nix-collect-garbage --delete-older-than 180d


# Initial setup

    # https://github.com/emilyst/home#setup

    alias home='git --work-tree=$HOME --git-dir=$HOME/.local/var/git-home'
    mkdir ~/.local/var
    home init
    home config set --local status.showUntrackedFiles no
    home remote add origin ssh://git@github.com/bsoudan/home
    home fetch --all
    home reset --hard origin/main
    home checkout -b main
    home branch -d master

    # create new configuration in .config/home-manager/bsoudan-$HOSTNAME.nix
    ln -s .config/home-manager/bsoudan-$HOSTNAME.nix .config/home-manager/bsoudan.nix

    nix run home-manager/release-25.05 -- switch
=======
# ♾️  home

## Initial setup

- adapted from https://github.com/emilyst/home#setup

```
cd ~
alias home='git --work-tree=$HOME --git-dir=$HOME/.local/var/home.git'
home init
home branch -m main
home config core.excludesfile /home/bsoudan/.gitignore.home
home remote add origin ssh://bsoudan.sb/home/bsoudan/.local/var/home.git
home branch --set-upstream-to=origin/main main
home pull
source .bashrc.home
home-install
```
>>>>>>> 56848b0 (add basics)
