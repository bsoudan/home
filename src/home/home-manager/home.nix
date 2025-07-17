{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "bsoudan";
  home.homeDirectory = "/home/bsoudan";

  home.sessionVariables = {
    GOPATH = "$HOME/.local/go";
    EDITOR = "micro";
  };

  home.shellAliases = {
    e = "$EDITOR";
    ehome = "$EDITOR ~/.config/home-manager/home.nix && home-manager switch";
  };

  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # keyboardio atreus
    qmk

    # fonts
    cascadia-code

    # gnome
    gnome-tweaks

    go
    jc

    godot_4

    wl-clipboard
    bitwarden-cli

    zoom

    obsidian
    telegram-desktop
  ];

  # dconf watch /
  dconf.settings = {
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

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Bill Soudan";
    userEmail = "bill@soudan.net";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    settings = {
      # https://starship.rs/config/
      format = "$env_var$username$hostname$shlvl$shlvl$directory$git_branch$jobs$battery$shell$character";
      directory.truncate_to_repo = false;
      line_break.disabled = true;
      env_var.NIX_DEVSHELL = {
        format = "<$env_value>($style) ";
      };
      #golang.format = "[$symbol]($style)";
      #cpp.format = "[$symbol]($style)";
      character.format = "$symbol ";
      character.success_symbol = "[>](bold_green)";
      character.error_symbol = "[>](bold_red)";
    };
  };

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

  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.local/go/bin"
    '';

  };

  programs.vscode = {
    enable = true;
    #extensions = with pkgs.vscode-extensions; [
    #  dracula-theme.theme-dracula
    #  vscodevim.vim
    #  yzhang.markdown-all-in-one
    #];
  };

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      desktop = "$HOME/doc/desktop";
      download = "$HOME/doc/downloads";
      documents = "$HOME/doc";
      templates = "$HOME/doc/templates";
      music = "$HOME/doc/music";
      videos = "$HOME/doc/videos";
      pictures = "$HOME/doc/pictures";
      publicShare = "$HOME/doc/public";
    };
  };

  home.file.".config/nano/nanorc".text = ''
    set positionlog
    set minibar
    set multibuffer
  '';

  programs.micro = {
    enable = true;
    settings = {
  	  # https://github.com/zyedidia/micro/blob/master/runtime/help/options.md
  	  autosu = true;
  	  colorcolumn = 120;
  	  diffgutter = true;
  	  rmtrailingws = true;
  	  parsecursor = true;
  	  ruler = false;
  	  savecursor = true;
  	  saveundo = true;
  	};
  };

  home.file.".config/micro/bindings.json".text = ''
  {
    "Ctrl-p": "CommandMode"
  }
  '';

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
    ];
  };
  # manual: disable password manager

  home.stateVersion = "24.11";
}

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};
