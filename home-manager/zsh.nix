{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
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
      [[ ! -f ~/.dotfiles/home-manager/.p10k.zsh ]] || source ~/.dotfiles/home-manager/.p10k.zsh
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
