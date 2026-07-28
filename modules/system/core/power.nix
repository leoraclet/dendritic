{
  flake.nixosModules.power = { ... }: {
    ervices = {
      upower.enable = true; # Power management daemon, required for battery and power management
      thermald.enable = true; # Thermal management daemon, useful for laptops to prevent overheating
      tlp.enable = true; # TLP is a power management tool for Linux, useful for laptops to extend battery life

      # ERROR: conflicts with services.tlp
      power-profiles-daemon.enable = false;

      # Enable Thunderbolt
      # https://nixos.wiki/wiki/Thunderbolt
      hardware.bolt.enable = true;
    };

    powerManagement = {
      enable = true;
      powertop.enable = true;
    };
  };
}
