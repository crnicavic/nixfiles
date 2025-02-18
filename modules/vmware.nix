{pkgs, lib, inputs, ...} : {
	nixpkgs.config.allowUnfreePredicate = pkg:
		builtins.elem (lib.getName pkg) [
			"vmware-workstation"
		];

	virtualisation.vmware.host.enable = true;
	users.users.user.packages = with pkgs; [
		inputs.nixpkgs_2405.legacyPackages.x86_64-linux.vmware-workstation
	];
}
