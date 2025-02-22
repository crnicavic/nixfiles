{
  description = "A very basic flake";

	inputs = {
		nixpkgs_unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
		nixpkgs_2405.url = "github:nixos/nixpkgs?rev=1bde3e8e37a72989d4d455adde764d45f45dc11c";
	};

	outputs = { nixpkgs, ... } @ inputs: 
	{
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
			system = "x86_64-linux";
			specialArgs = {
				pkgs_2405 = import inputs.nixpkgs_2405 {
					inherit system;
					config.allowUnfree = true;
				};
			};
			modules =
			[
				./configuration.nix
			];
		};
	};
}
