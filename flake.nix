{
  description = "Flake for minecraft-dmenu, a script that uses dmenu as a minecraft launcher";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    minecraft-json = {
      url = "github:ninlives/minecraft.json";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minecraft = {
      url = "github:ninlives/minecraft.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        metadata.follows = "minecraft-json";
      };
    };
  };
  
  outputs = inputs@{ nixpkgs, minecraft, minecraft-json, self }:

    let

      pkgs = import nixpkgs { system = "x86_64-linux"; };

    in {

      legacyPackages.x86_64-linux.minecraft-dmenu = pkgs.callPackage ./package.nix {};
    
    };
}
