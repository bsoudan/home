# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# TODO:
#  * /root/.config/micro/settings.json & bindings.json manually linked to ~bsoudan/.config/micro/
#

{ pkgs, ... }: {

  sops.defaultSopsFile = ../secrets.yaml;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "@wheel" ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # https://ar.al/2022/08/30/dear-linux-privileged-ports-must-die/
    kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 0;
  };

  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  console.keyMap = "dvorak";

  users.mutableUsers = false;
  users.users = {
    # run mkpasswd to create a new password
    # https://mynixos.com/nixpkgs/option/users.users.%3Cname%3E.hashedPassword
    root.hashedPassword = "$y$j9T$QugK5WbhgmlVeNDTe.zxh/$id64LnpmYZKrzlG6HWZZ6AwnFhFumKuQlGGGDHt.bD8";

    bsoudan = {
      uid = 1000;
      isNormalUser = true;
      description = "Bill Soudan";
      # dialout -- qmk flashing for /dev/ttyACM0
      extraGroups = [ "networkmanager" "wheel" "dialout" "storage" ];
      hashedPassword = "$y$j9T$QugK5WbhgmlVeNDTe.zxh/$id64LnpmYZKrzlG6HWZZ6AwnFhFumKuQlGGGDHt.bD8";
      subUidRanges = [{ startUid = 100000; count = 65536; }];
      subGidRanges = [{ startGid = 100000; count = 65536; }];
    };

    storage = {
      uid = 9999;
      isSystemUser = true;
      description = "storage user";
      group = "storage";
    };
  };

  users.groups.storage.gid = 9999;

  environment.systemPackages = with pkgs; [
     git
     home-manager
     micro
     wget
     curl
     #sops
     file
     mosh
     tcpdump
  ];

  environment.variables = {
    EDITOR = "micro";
  };

  environment.extraInit = ''
    umask 002
  '';

  # mounts /usr/bin and provides all system executables
  services.envfs.enable = true;

  # https://www.reddit.com/r/NixOS/comments/1g4g1mp/how_to_get_nixld_working/
  programs.nix-ld = {
    enable = true;
    #libraries = pkgs.steam-run.args.multiPkgs pkgs;
  };

  # https://fzakaria.com/2025/02/26/nix-pragmatism-nix-ld-and-envfs

  environment.shellAliases = {
      e = "$EDITOR";
  };

  services.netdata.enable = true;
  services.netdata.package = pkgs.netdata.override {
    withCloudUi = true;
  };
}
