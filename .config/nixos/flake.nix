{
  description = "System Configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    sops-nix.url = "github:Mic92/sops-nix/3633fc4acf03f43b260244d94c71e9e14a2f6e0d";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, sops-nix, ... }: {
    nixosConfigurations.carbon = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/common.nix
        ./carbon.nix
      ];
    };
    nixosConfigurations.core = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        sops-nix.nixosModules.sops
        ./core/sops.nix
        ./modules/common.nix
        ./core
      ];
    };
  };
}
