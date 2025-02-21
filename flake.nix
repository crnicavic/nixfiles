{
  description = "A very basic flake";

	inputs = {
		nixpkgs_unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		nixpkgs.url = "github:nixos/nixpkgs";
		nixpkgs_2405.url = "github:nixos/nixpkgs?rev=1bde3e8e37a72989d4d455adde764d45f45dc11c";
	};

	outputs = { nixpkgs, ... } @ inputs: 
	{
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules =
			[
				./configuration.nix
			];
		};
	};
}
