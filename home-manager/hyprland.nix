{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        ",preferred,0x0,0.8"
      ];
      "$mod" = "SUPER";
      bind = [
        "$mod, RETURN, exec, xfce4-terminal"
	"$mod, W, exec, firefox"
      ]
      ++ (
        # workspaces
	builtins.concatLists (builtins.genList (
        x: let
	  ws = let
	    c = (x + 1) / 10;
	  in
	  builtins.toString (x + 1 - (c * 10));
	in [
          "$mod, ${ws}, workspace, ${toString (x + 1)}"
	  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
	]
	)
	10)
      );
    };
  };
}
