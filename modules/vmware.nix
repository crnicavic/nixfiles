{pkgs, lib, ...} : {
	nixpkgs.config.allowUnfreePredicate = pkg:
		builtins.elem (lib.getName pkg) [
			"vmware-workstation"
		];

	virtualisation.vmware.host.enable = true;
	users.users.user.packages = with pkgs; [
		vmware-workstation
	];
}
