# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ./opengl.nix
      ./nvidia.nix
    ];

  # boot using ubuntu secure boot stub, make sure nixos doesn't touch!
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
  };
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "extreme"; # Define your hostname.

  system.stateVersion = "23.05"; # Did you read the comment?
}

