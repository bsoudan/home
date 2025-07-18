# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# TODO:
#  * /root/.config/micro/settings.json & bindings.json manually linked to ~bsoudan/.config/micro/
#

{ pkgs, ... }: {

  imports =
    [ # Include the results of the hardware scan.
      ./carbon/hardware-configuration.nix
    ];

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

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     steam-run
     home-manager
     micro
  ];

  environment.sessionVariables = {
    EDITOR = "micro";

    # https://nixos.wiki/wiki/Wayland
    # Enable ozone wayland support in chromium/electron based apps
    NIXOS_OZONE_WL = "1";
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  services.openvpn.servers = {
    stoneledge = { config = '' config /etc/nixos/openvpn-carbon.conf ''; };
  };

  fonts.packages = with pkgs; [
  	noto-fonts
  	noto-fonts-cjk-sans
  	noto-fonts-emoji
  	ubuntu_font_family
  	corefonts
  ];

  fonts.enableDefaultPackages = true;

  fonts.fontconfig = {
    enable = true;
    antialias = true;
    hinting.enable = true;
    hinting.style = "slight";  # Ubuntu uses 'slight'
    subpixel.rgba = "rgb";     # most common LCD arrangement
    subpixel.lcdfilter = "default";  # or "light" if you prefer
    cache32Bit = true;             # lets 32-bit Electron builds see the cache
    defaultFonts = {
      sansSerif = [ "Ubuntu" "Noto Sans" ];
      serif     = [ "Noto Serif" ];
      monospace = [ "Ubuntu Mono" ];
      emoji     = [ "Noto Color Emoji" ];
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

}
