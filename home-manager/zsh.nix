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

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    antidote = {
      enable = true;
      plugins = [
        "belak/zsh-utils path:completion"
        "belak/zsh-utils path:editor"
        "belak/zsh-utils path:history"
        "belak/zsh-utils path:prompt"
        "belak/zsh-utils path:utility"
        "romkatv/powerlevel10k"
	"zdharma-continuum/fast-syntax-highlighting kind:defer"
	"zsh-users/zsh-autosuggestions"
	"zsh-users/zsh-completions"
      ];
    };
    initExtra = ''
      [[ ! -f ~/.dotfiles/files/.p10k.zsh ]] || source ~/.dotfiles/files/.p10k.zsh

      # Colors
      if [ "$TERM" = "linux" ]; then
        echo -en "\e]P0${config.colorScheme.palette.base00}" # black, ansi 0
        echo -en "\e]P8${config.colorScheme.palette.base02}" # darkgray, ansi 8
        echo -en "\e]P1${config.colorScheme.palette.base09}" # darkred, ansi 1
        echo -en "\e]P9${config.colorScheme.palette.base09}" # red, ansi 9
        echo -en "\e]P2${config.colorScheme.palette.base0B}" # darkgreen, ansi 2
        echo -en "\e]PA${config.colorScheme.palette.base0B}" # green, ansi 10
        echo -en "\e]P3${config.colorScheme.palette.base06}" # brown, ansi 3
        echo -en "\e]PB${config.colorScheme.palette.base0A}" # yellow, ansi 11
        echo -en "\e]P4${config.colorScheme.palette.base0D}" # darkblue, ansi 4
        echo -en "\e]PC${config.colorScheme.palette.base0D}" # blue, ansi 12
        echo -en "\e]P5${config.colorScheme.palette.base0E}" # darkmagenta, ansi 5
        echo -en "\e]PD${config.colorScheme.palette.base0E}" # magenta, ansi 13
        echo -en "\e]P6${config.colorScheme.palette.base07}" # darkcyan, ansi 6
        echo -en "\e]PE${config.colorScheme.palette.base07}" # cyan, ansi 14
        echo -en "\e]P7${config.colorScheme.palette.base05}" # lightgrey, ansi 7
        echo -en "\e]PFFFFFFF" # white
	clear
      fi
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
