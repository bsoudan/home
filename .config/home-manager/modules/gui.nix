{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # fonts
    cascadia-code

    # gnome
    gnome-tweaks

    godot_4

    wl-clipboard

    zoom

    obsidian
    telegram-desktop
  ];

  # dconf watch /
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = 4179;
    };

    "org/gnome/desktop/interface" = {
      font-hinting = "slight";
      font-antialiasing = "rgba";
      interface-font-name = "Ubuntu 11";
      document-font-name = "Ubuntu 11";
      monospace-font-name = "Ubuntu Mono 12";
    };
    "org/gnome/desktop/peripherals/mouse" = {
      speed = -0.3; # -1 to 1
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout =  "appmenu:minimize,maximize,close";
    };

    "org/gnome/shell" = {
      app-switcher = "current-workspace-only";
    };
  };


  #fonts.enableDefaultPackages = true;

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.vscode = {
    enable = true;
    #extensions = with pkgs.vscode-extensions; [
    #  dracula-theme.theme-dracula
    #  vscodevim.vim
    #  yzhang.markdown-all-in-one
    #];
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
    ];
  };
  # manual: disable password manager

}

