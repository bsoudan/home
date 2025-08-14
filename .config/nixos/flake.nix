{
  description = "System Configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # nixos-hardware has no inputs

    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
    nixos-grub-themes.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix/3633fc4acf03f43b260244d94c71e9e14a2f6e0d";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = { nixpkgs, ... }@inputs: {

    nixosConfigurations.carbon = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.sops-nix.nixosModules.sops

        ./modules/common.nix
        ./modules/gui.nix
        ./modules/gaming.nix

        ./carbon
        ./modules/systemd-boot.nix
      ];
    };

    nixosConfigurations.core = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.sops-nix.nixosModules.sops

        ./modules/common.nix

        ./core
        ./modules/systemd-boot.nix
      ];
    };

    nixosConfigurations.x1-extreme = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # pass the inputs into the configuration modules
      modules = [
        inputs.sops-nix.nixosModules.sops
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme-gen4
        inputs.nixos-hardware.nixosModules.common-gpu-nvidia

        ./modules/common.nix
        ./modules/gui.nix
        ./modules/gaming.nix

        ./extreme
        # boots using manual grub configuration

        # lenovo laptops don't seem to have this? but i had it in my old configuration.nix?
        # <nixos-hardware/common/pc/laptop>
      ];
    };
  };
}
