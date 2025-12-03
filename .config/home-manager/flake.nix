{
  description = "home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      util = import ./util.nix home-manager pkgs;
    in
    {
      homeConfigurations = {
        "bsoudan@bsoudan-carbon" = util.homeDefinition ./meta-carbon.nix;
        "bsoudan@carbon" = util.homeDefinition ./carbon.nix;
        "bsoudan@core" = util.homeDefinition ./core.nix;
        "bsoudan@extreme" = util.homeDefinition ./extreme.nix;
      };
    };
}

