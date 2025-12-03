{ inputs, lib, config, pkgs, ... }: {

  imports = [
    ./modules/common.nix
    ./modules/shell.nix
    ./modules/sysadmin.nix
    ./modules/gui.nix
  ];

  home.stateVersion = "24.05";

  home.packages = [
    pkgs.qbittorrent
    pkgs.rclone
  ];
}

  # 221  rclone -v --drive-impersonate bills@soudan.net ls gdrive:
  # 222  rclone -v --drive-impersonate bills@soudan.net ls gdrive:
  # 224  rclone -v --drive-impersonate bills@soudan.net cp x1-extreme-config.tar.gz gdrive:
  # 225  rclone -v --drive-impersonate bills@soudan.net copy x1-extreme-config.tar.gz gdrive:
  # 226  rclone -v --drive-impersonate bills@soudan.net ls gdrive:

