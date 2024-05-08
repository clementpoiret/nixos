{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  programs.waybar = {
    enable = true;
    settings = [{
      "layer" = "top";
      "position" = "top";
      "height" = 30;
      # "output" = ["DVI-I-1"];
      "spacing" = 15;

      "modules-left" = [ "hyprland/workspaces" ];
      "modules-center" = [ "clock" ];
      "modules-right" = [
        "pulseaudio"
	"battery"
	"custom/power"
      ];
    }];
    style = ''
      /* Universal Styling */
      * {
        border: none;
	border-radius: 0;
	font-family: 'Fira Mono Nerd Font';
	font-size: 12px;
	min-height: 0;
      }

      /* Bar styling */
      #waybar {
        background: transparent;
	color: ${config.colorScheme.palette.base05};
	margin: 5px 0;
      }

      /* Workspaces */

      /* Main Modules */

      /* System Monitoring Modules */

      /* Clock Module */

      /* Battery Module */

      /* Backlight Module */

      /* Idle Module */

      /* PulseAudio Module */
    '';
  };
}
