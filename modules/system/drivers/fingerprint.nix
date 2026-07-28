{
  flake.nixosModules.power = { pkgs, ... }: {
    #! Disabled it because it cause problems with SDDM (login, unlock, ...)
    # https://wiki.nixos.org/wiki/Fingerprint_scanner
    # https://wiki.nixos.org/wiki/SDDM
    # https://github.com/NixOS/nixpkgs/issues/171136
    services.fprintd = {
      enable = false;
      package = pkgs.fprintd-tod;
      tod = {
        enable = true;
        # Search for "libfprint" in packages to find other drivers
        driver = pkgs.libfprint-2-tod1-broadcom;
      };
    };

    pam.services.swaylock = { };
    pam.services.login.fprintAuth = false;
  };
}
