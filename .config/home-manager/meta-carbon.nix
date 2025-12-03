
{ inputs, lib, config, pkgs, ... }: {

  imports = [
    ./modules/common.nix
    ./modules/shell.nix
    ./modules/sysadmin.nix
    ./modules/gui.nix
  ];

  home.stateVersion = "25.05";

  # extraSpecialArgs = {
  #   Optionally use extraSpecialArgs
  #   to pass through arguments to home.nix
  # }

}

