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
        echo -en "\e]P${config.colorScheme.palette.base00}" # black
        echo -en "\e]P${config.colorScheme.palette.base02}" # darkgray
        echo -en "\e]P${config.colorScheme.palette.base09}" # darkred
        echo -en "\e]P${config.colorScheme.palette.base09}" # red
        echo -en "\e]P${config.colorScheme.palette.base0B}" # darkgreen
        echo -en "\e]P${config.colorScheme.palette.base0B}" # green
        echo -en "\e]P${config.colorScheme.palette.base06}" # brown
        echo -en "\e]P${config.colorScheme.palette.base0A}" # yellow
        echo -en "\e]P${config.colorScheme.palette.base0D}" # darkblue
        echo -en "\e]P${config.colorScheme.palette.base0D}" # blue
        echo -en "\e]P${config.colorScheme.palette.base0E}" # darkmagenta
        echo -en "\e]P${config.colorScheme.palette.base0E}" # magenta
        echo -en "\e]P${config.colorScheme.palette.base07}" # darkcyan
        echo -en "\e]P${config.colorScheme.palette.base07}" # cyan
        echo -en "\e]P${config.colorScheme.palette.base05}" # lightgrey
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
