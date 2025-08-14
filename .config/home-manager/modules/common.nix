{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.username = "bsoudan";
  home.homeDirectory = "/home/bsoudan";

  home.packages = with pkgs; [
    go
    gopls
    vscode
    magika # ai filetype detection
    yad # simple command line guy tool
    xsel # x clipboard integration
  ];
}
