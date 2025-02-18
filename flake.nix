{
  description = "A very basic flake";

  inputs = {
    nixpkgs_unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
	nixpkgs.url = "github:nixos/nixpkgs";
	nixpkgs_2405.url = "github:nixos/nixpkgs?rev=1bde3e8e37a72989d4d455adde764d45f45dc11c";
  };

  outputs = { nixpkgs, ... } @ inputs: {
    packages.x86_64-linux.hello_2405 = inputs.nixpkgs_2405.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = inputs.nixpkgs.legacyPackages.x86_64-linux.hello;

  };
}
