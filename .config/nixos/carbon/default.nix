# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# TODO:
#  * /root/.config/micro/settings.json & bindings.json manually linked to ~bsoudan/.config/micro/
#

{ config, pkgs, ... }: {

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot = {
    plymouth = {
      enable = true;
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority/3"
      "rd.systemd.show_status=auto"
    ];

    loader.timeout = 0;
  };

  networking.hostName = "carbon"; # Define your hostname.

  system.stateVersion = "24.11"; # Did you read the comment?

  environment.etc."openvpn/carbon-client.ovpn" = {
    text = ''
      dev tun
      remote "soudan.net"
      port 1194
      redirect-gateway def1

      cipher AES-256-CBC
      auth-nocache

      comp-lzo
      keepalive 10 60
      resolv-retry infinite
      nobind
      persist-key
      persist-tun
      secret ${config.sops.secrets.openvpn-secret.path}

      ifconfig 10.8.0.2 10.8.0.1
    '';

    mode = "600";
  };

  sops.secrets.openvpn-secret = {};

  services.openvpn.servers = {
    stoneledge = { config = '' config /etc/openvpn/carbon-client.ovpn ''; };
  };
}
