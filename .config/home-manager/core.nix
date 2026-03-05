{ inputs, lib, config, pkgs, ... }: {

  imports = [
    ./modules/common.nix
    ./modules/shell.nix
    ./modules/sysadmin.nix
  ];

  home.stateVersion = "24.11";

}

