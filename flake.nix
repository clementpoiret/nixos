{
  description = "Main configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";

    #hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS config entrypoint
    # Available through nixos-rebuild --flake .#hostname
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
	modules = [./nixos/configuration.nix];
      };
    };

    # home-manager configuration entrypoint
    # Available through home-manager --flake .#username@hostname
    homeConfigurations = {
      "clementpoiret@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
	extraSpecialArgs = {inherit inputs outputs home-manager;};
	modules = [./home-manager/home.nix];
      };
    };
  };
}
