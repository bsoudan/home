
# 🏠 home

  * .config/home-manager: home-manager configuration
  * .config/nixos: system configuration


## Aliases

  * e -- edit file
  * home -- git alias to manage home directory
  * ehome -- edit .config/home-manager/home.nix && home-manager switch


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
