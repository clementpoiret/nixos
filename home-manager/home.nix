{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Other home-manager modules
  imports = [
    ./zsh.nix
    ./hyprland.nix
  ];

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

  home.packages = with pkgs; [
    hyprpaper
    hyprpicker
    kitty
    neovim
    swaylock
    wofi
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
