{ config, lib, pkgs, modulesPath, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva-utils
      vdpauinfo
      intel-media-driver
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.driversi686Linux; [
      vdpauinfo
      intel-media-driver
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
}
