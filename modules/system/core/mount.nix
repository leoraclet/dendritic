{
  flake.nixosModules.mount = { pkgs, ... }: {
    services = {
      devmon.enable = true; # Automatically mount removable devices
      udisks2.enable = true; # Disk management daemon, required for mounting and unmounting disks
      gvfs.enable = true; # Mount, trash, and other functionalities
    };
  };
}
