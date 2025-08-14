{ home-manager, pkgs, ... }@x :
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  modules = [
    ./modules/common.nix
    ./modules/shell.nix
    ./modules/sysadmin.nix
    ./modules/gui.nix

    ./extreme
  ];
}
