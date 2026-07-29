{
  flake.nixosModules.firmware = { ... }: {
    # Firmware update daemon, useful for updating firmware of devices like SSDs, GPUs, etc.
    # https://nixos.wiki/wiki/Fwupd
    services.fwupd.enable = true;
    hardware.enableRedistributableFirmware = true;
  };
}
