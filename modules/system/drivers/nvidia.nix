{
  flake.nixosModules.nvidia-driver = { pkgs, ... }: {
    hardware.graphics.enable = true;

    # For offloading, `modesetting` is needed additionally,
    # otherwise the X-server will be running permanently on nvidia,
    # thus keeping the GPU always on (see `nvidia-smi`).
    services.xserver.videoDrivers = [
      "nvidia"
    ];

    # https://nixos.wiki/wiki/Nvidia
    hardware.nvidia = {
      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      open = true; # see the note above
      modesetting.enable = true;
      prime = {
        reverseSync.enable = true;
        sync.enable = true;
        offload.enable = true;
        offload.enableOffloadCmd = true;
      };

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # FIXME: nix shell nixpkgs#pciutils -c lspci | grep 'VGA'
      # intelBusId = "PCI:00:02:0";
      # amdgpuBusId = "PCI:0:0:0";
      # nvidiaBusId = "PCI:01:00:0";
    };
  };
}
