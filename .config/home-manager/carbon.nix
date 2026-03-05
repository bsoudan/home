{ inputs, lib, config, pkgs, ... }: {

  imports = [
    ./modules/common.nix
    ./modules/shell.nix
    ./modules/sysadmin.nix
    ./modules/gui.nix
  ];

  home.stateVersion = "24.11";

}
