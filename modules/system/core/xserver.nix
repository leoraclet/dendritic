{
  flake.nixosModules.xserver = { pkgs, ... }: {
    # https://nixos.wiki/wiki/Xorg
    services.xserver = {
      enable = true;
      updateDbusEnvironment = true;
      excludePackages = with pkgs; [
        xterm
      ];
    };
  };
}
