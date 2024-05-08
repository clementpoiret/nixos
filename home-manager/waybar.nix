{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [ inputs.nix-colors.homeManagerModules.default ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  programs.waybar = {
    enable = true;
    settings = [
      {
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

        "hyprland/workspaces" = {
          "format" = "{icon} {name}";
          "format-icons" = {
            "active" = "";
            "default" = "";
          };
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
          "on-click" = "activate";
        };
        "custom/notifications" = {
          "tooltip" = false;
          "format" = "{icon}";
          "format-icons" = {
            "notification" = "<span foreground='red'><sup></sup></span>";
            "none" = "";
            "dnd-notification" = "<span foreground='red'><sup></sup></span>";
            "dnd-none" = "";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          "exec" = "swaync-client -swb";
          "on-click" = "swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          "escape" = true;
        };
        "custom/power" = {
          "format" = "";
          "on-click" = "~/.config/wlogout/launch.sh";
        };
        "hyprland/window" = {
          "format" = "{}";
          "separate-outputs" = true;
          "max-length" = 35;
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 15;
        };
        "clock" = {
          "timezone" = "Europe/Paris";
          "format" = "  {:%A, %B %d, %Y (%V) | %H:%M:%S}";
          "format-alt" = "  {:%a, %b %d, %Y | %H:%M}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "interval" = 1;
        };
        "cpu" = {
          "format" = "{usage}% ";
          "tooltip" = true;
          "interval" = 1;
        };
        "disk" = {
          "format" = "{used}/{total} ";
          "tooltip" = true;
          "interval" = 1;
        };
        "memory" = {
          "format" = "{}% ";
          "tooltip" = true;
          "on-click" = "gnome-system-monitor";
          "interval" = 1;
        };
        "temperature" = {
          # "thermal-zone" = 2;
          "hwmon-path" = "/sys/class/hwmon/hwmon7/temp1_input";
          "critical-threshold" = 40;
          "format-critical" = "{temperatureC}°C {icon}";
          "format" = "{temperatureC}°C {icon}";
          "format-icons" = [
            ""
            ""
            ""
          ];
          "tooltip" = true;
          "on-click" = "gnome-system-monitor";
          "interval" = 1;
        };
        "backlight" = {
          # "device" = "acpi_video1";
          "format" = "{percent}% {icon}";
          "format-icons" = [
            ""
            ""
          ];
          "on-scroll-up" = "/home/cp264607/.config/hypr/scripts/tools/brightness_ctl.sh up";
          "on-scroll-down" = "/home/cp264607/.config/hypr/scripts/tools/brightness_ctl.sh down";
          "interval" = 1;
        };
        "battery" = {
          "states" = {
            "good" = 100;
            "warning" = 40;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% 󱐋";
          "format-plugged" = "{capacity}%  ";
          "format-alt" = "{time} {icon}";
          # "format-good" = ""; # An empty format will hide the module
          # "format-full" = "";
          "format-icons" = [
            " "
            " "
            " "
            " "
            " "
          ];
          "interval" = 1;
        };
        "network" = {
          # "interface" = "wlp2*"; # (Optional) To force the use of this interface
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = "{ipaddr}/{cidr} 󰈀";
          "tooltip-format" = "{ifname} via {gwaddr} 󰖟";
          "format-linked" = "{ifname} (No IP) 󰌷";
          "format-disconnected" = "Disconnected ⚠";
          # "format-alt" = "{ifname} = {ipaddr}/{cidr}"
          "format-alt" = " {bandwidthUpBytes} |  {bandwidthDownBytes}";
          "interval" = 1;
        };
        "pulseaudio" = {
          # "scroll-step" = 1, # %, can be a float
          "format" = "{volume}% {icon} {format_source}";
          "format-bluetooth" = "{volume}% {icon} {format_source}";
          "format-bluetooth-muted" = " {icon} {format_source}";
          "format-muted" = " {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = " ";
          "format-icons" = {
            "headphone" = " ";
            "hands-free" = " ";
            "headset" = "󰋎 ";
            "phone" = " ";
            "portable" = " ";
            "car" = " ";
            "default" = [
              ""
              ""
              " "
            ];
          };
          "on-click" = "pavucontrol";
        };
      }
    ];
    style = ''
            /* Universal Styling */
            * {
              border = none;
      	border-radius = 0;
      	font-family = 'Fira Mono Nerd Font';
      	font-size = 12px;
      	min-height = 0;
            }

            /* Bar styling */
            #waybar {
              background = transparent;
      	color = ${config.colorScheme.palette.base05};
      	margin = 5px 0;
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
