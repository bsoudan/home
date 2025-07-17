{ home-manager, pkgs }:
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;

  modules = [
    ./modules/common.nix
    ./modules/shell.nix
    ./modules/sysadmin.nix
  ];

  # extraSpecialArgs = {
  #   Optionally use extraSpecialArgs
  #   to pass through arguments to home.nix
  # }
}

