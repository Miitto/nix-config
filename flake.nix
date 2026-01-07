{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming/4199abcbc86b52e6878d1021da61c4e8e308e00e";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x84_64-linux.hello;
    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    nixosConfigurations.miitto = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./system.nix
        ./gaming.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.miitto = ./miitto/home.nix;
        }
        ./noctalia.nix
        ./miitto
      ];
    };
  };
}
