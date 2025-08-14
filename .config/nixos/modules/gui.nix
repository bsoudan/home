{ pkgs, ... }: {

  networking.networkmanager.enable = true;

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

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    #videoDrivers = [ "intel" ];
  };

 # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # unity apps using fmod don't have sound because they try to output to the hdmi port instead
  # of the default port
  #
  # https://qa.fmod.com/t/unity3d-2022-linux-popos-not-sound-play/20888
  # https://issuetracker.unity3d.com/issues/linux-no-audio-output-when-playing-audio
  #
  # to fix, run pavucontrol after starting app and set proper output

  environment.systemPackages = with pkgs; [
    steam-run

    # desktop
    telegram-desktop
    discord
    godot_4

    # pulseaudio tools
    pamixer
    pavucontrol
    paprefs

    # pipewire tools
    helvum
    qpwgraph
  ];

  environment.sessionVariables = {
    # https://nixos.wiki/wiki/Wayland
    # Enable ozone wayland support in chromium/electron based apps
    NIXOS_OZONE_WL = "1";
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
}

