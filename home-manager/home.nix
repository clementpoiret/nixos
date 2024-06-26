{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Other home-manager modules
  imports = [
    ./hyprland.nix
    ./yazi.nix
    ./zsh.nix

    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  nixpkgs = {
    overlays = [];

    # Config nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "clementpoiret";
    homeDirectory = "/home/clementpoiret";
  };

  programs.git = {
    enable = true;
    userName = "Clement POIRET";
    userEmail = "poiret.clement@outlook.fr";
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # Fonts
    (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })

    # Packages
    floorp
    hyprpaper
    hyprpicker
    kitty
    neovim
    qutebrowser
    vlc
    swaylock
    wofi
  ];

  # To have nice colors in the TTY :)
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      if [ "$TERM" = "linux" ]; then
        echo -en "\e]P${config.colorScheme.palette.base00}"
        echo -en "\e]P${config.colorScheme.palette.base02}"
        echo -en "\e]P${config.colorScheme.palette.base09}"
        echo -en "\e]P${config.colorScheme.palette.base09}"
        echo -en "\e]P${config.colorScheme.palette.base0B}"
        echo -en "\e]P${config.colorScheme.palette.base0B}"
        echo -en "\e]P${config.colorScheme.palette.base06}"
        echo -en "\e]P${config.colorScheme.palette.base0A}"
        echo -en "\e]P${config.colorScheme.palette.base0D}"
        echo -en "\e]P${config.colorScheme.palette.base0D}"
        echo -en "\e]P${config.colorScheme.palette.base0E}"
        echo -en "\e]P${config.colorScheme.palette.base0E}"
        echo -en "\e]P${config.colorScheme.palette.base07}"
        echo -en "\e]P${config.colorScheme.palette.base07}"
        echo -en "\e]P${config.colorScheme.palette.base05}"
        echo -en "\e]PFFFFFFF"
	clear #for background artifacting
      fi
    '';
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
