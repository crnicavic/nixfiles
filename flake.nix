{
  description = "A very basic flake";

	inputs = {
		nixpkgs_unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
		nixpkgs_2405.url = "github:nixos/nixpkgs?rev=1bde3e8e37a72989d4d455adde764d45f45dc11c";
	};

	outputs = { nixpkgs, ... } @ inputs: 
	{
		nixosConfigurations = {
			nixpc = nixpkgs.lib.nixosSystem rec {
				system = "x86_64-linux";
				modules =
				[
					./hosts/pc-conf.nix
				];
			};
				
			nix-t14 = nixpkgs.lib.nixosSystem rec {
				system = "x86_64-linux";
				modules =
				[
					./hosts/t14-conf.nix
				];
			};
		};
	};
}
