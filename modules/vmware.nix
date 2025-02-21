{pkgs, config, inputs, pkgs_2405, lib, ...} : {
	nixpkgs.config.allowUnfreePredicate = pkg:
		builtins.elem (lib.getName pkg) [
			"vmware-workstation"
		];
	_module.args.pkgs_2405 = import inputs.nixpkgs_2405 {
		inherit (pkgs.stdenv.hostPlatform) system;
		inherit (config.nixpkgs) config;
	};

	users.users.user.packages = [
		pkgs_2405.vmware-workstation	
	];
}
