{
  flake.nixosModules.intel-driver = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      mesa
      vulkan-tools
    ];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD"; # Prefer the modern iHD backend
      # VDPAU_DRIVER = "va_gl";      # Only if using libvdpau-va-gl
    };

    services.xserver.videoDrivers = [ "modesetting" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        # Required for modern Intel GPUs (Xe iGPU and ARC)
        intel-media-driver # VA-API (iHD) userspace
        vpl-gpu-rt # oneVPL (QSV) runtime
        intel-vaapi-driver
        libva-vdpau-driver
        intel-ocl

        # Optional (compute / tooling):
        intel-compute-runtime # OpenCL (NEO) + Level Zero for Arc/Xe
        # NOTE: 'intel-ocl' also exists as a legacy package; not recommended for Arc/Xe.
        # libvdpau-va-gl       # Only if you must run VDPAU-only apps
        vpl-gpu-rt # or intel-media-sdk for QSV
      ];
    };

    boot = {
      kernelParams = [
        # Intel CPU
        "intel_iommu=on"
        "i915.enable_guc=3"
      ];
      initrd.kernelModules = [
        "i915" # replace or remove with your device's driver as needed
      ];
      extraModprobeConfig = ''
        options kvm_intel nested=1
      '';
    };

    # May help if FFmpeg/VAAPI/QSV init fails (esp. on Arc with i915):
    hardware.enableRedistributableFirmware = true;
  };
}
