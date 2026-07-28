{
  flake.nixosModules.swap = { ... }: {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      priority = 100;
      memoryPercent = 100;
    };

    boot.kernel.sysctl = {
      "vm.swappiness" = 50;
    };

    systemd.oomd.enable = true;
  };
}
