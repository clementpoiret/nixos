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
        echo -en "\e]P${config.colorScheme.palette.base00}"
        echo -en "\e]P${config.colorScheme.palette.base01}"
        echo -en "\e]P${config.colorScheme.palette.base02}"
        echo -en "\e]P${config.colorScheme.palette.base03}"
        echo -en "\e]P${config.colorScheme.palette.base04}"
        echo -en "\e]P${config.colorScheme.palette.base05}"
        echo -en "\e]P${config.colorScheme.palette.base06}"
        echo -en "\e]P${config.colorScheme.palette.base07}"
        echo -en "\e]P${config.colorScheme.palette.base08}"
        echo -en "\e]P${config.colorScheme.palette.base09}"
        echo -en "\e]P${config.colorScheme.palette.base0A}"
        echo -en "\e]P${config.colorScheme.palette.base0B}"
        echo -en "\e]P${config.colorScheme.palette.base0C}"
        echo -en "\e]P${config.colorScheme.palette.base0D}"
        echo -en "\e]P${config.colorScheme.palette.base0E}"
        echo -en "\e]P${config.colorScheme.palette.base0F}"
	clear
      fi
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
