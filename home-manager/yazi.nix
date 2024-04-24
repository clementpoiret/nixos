{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
	sort_by = "modified";
	sort_dir_first = true;
	sort_reverse = true;
	linemode = "size";
      };
    };
  };
}
