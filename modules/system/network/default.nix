{ self, ... }: {
  flake.nixosModules.network = { pkgs, ... }: {
    imports = with self.nixosModules; [
      dns
      ntp
      printer
      scanner
      ssh

    ];

    networking = {
      hostName = "nixos";
      networkmanager = {
        enable = true;
        wifi.powersave = true;
      };
      enableIPv6 = false;
      wireless.iwd.enable = false;

      nat = {
        enable = false;
        internalInterfaces = [ "virbr0" ];
      };

      extraHosts =
        let
          hostsPath = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
          hostsFile = builtins.fetchurl {
            url = hostsPath;
            # nix-prefetch-url --type sha256 "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            sha256 = "05n76jr9mj88lbqm597bklsn1r99alsvqwwyir4mcnxf8ya5yy1n";
          };
        in
        builtins.readFile "${hostsFile}";
    };

    # slows down boot time
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
