
# Notes

~/.config/home-manager > home-manager expire-generations '-180 days'
Removing generation 1
Removing generation 4
Removing generation 7
Removing generation 3
Removing generation 6
Removing generation 2
Removing generation 5

~/.config/home-manager > home-manager generations

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
