{ config, pkgs, lib, ... }:

{
  home.sessionVariables = {
    EDITOR = "micro";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.local/go/bin"

      # set window title
      # https://starship.rs/advanced-config/#change-window-title
      function set_win_title(){
          echo -ne "\033]0; $USER@$HOSTNAME \007"
      }
      starship_precmd_user_func="set_win_title"
    '';

  };

  home.shellAliases = {
    e = "$EDITOR";
    home = "git --work-tree=$HOME --git-dir=$HOME/.local/var/lib/git-home";
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

    # misc
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    bitwarden-cli
    jc

    # productivity
    glow # markdown previewer in terminal

    nixd
  ];

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
      format = "$env_var$shlvl$directory$git_branch$jobs$battery$shell$character";
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

  programs.helix = {
    enable = true;
  };
}
