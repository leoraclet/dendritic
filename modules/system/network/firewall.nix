{
  flake.nixosModules.firewall = { pkgs, ... }: {
    # Open ports in the firewall.
    networking = {
      nftables.enable = true;
      firewall = {
        enable = true;

        logReversePathDrops = true;
        checkReversePath = "loose";

        allowPing = false;
        allowedTCPPorts = [ 3000 ];
        allowedUDPPorts = [ 3000 ];

      };
    };
  };
}
