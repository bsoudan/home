{ pkgs, ... }: {

  home.stateVersion = "24.05";

  # 221  rclone -v --drive-impersonate bills@soudan.net ls gdrive:
  # 222  rclone -v --drive-impersonate bills@soudan.net ls gdrive:
  # 224  rclone -v --drive-impersonate bills@soudan.net cp x1-extreme-config.tar.gz gdrive:
  # 225  rclone -v --drive-impersonate bills@soudan.net copy x1-extreme-config.tar.gz gdrive:
  # 226  rclone -v --drive-impersonate bills@soudan.net ls gdrive:

  home.packages = [
    pkgs.qbittorrent
    pkgs.rclone
  ];
}
