
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

    # adapted from https://github.com/emilyst/home#setup

    ssh-keygen
    # upload public key in .ssh/ to github

    mkdir -p .local/var
    git clone --bare ssh://git@github.com/bsoudan/home ~/.local/var/home.git
    git --work-tree=$HOME --git-dir=$HOME/.local/var/home.git checkout
    source .bashrc.home
    home init

    # create new configuration in .config/home-manager/bsoudan-$HOSTNAME.nix
    ln -s .config/home-manager/bsoudan-$HOSTNAME.nix .config/home-manager/bsoudan.nix

    nix run home-manager/release-25.05 -- switch
