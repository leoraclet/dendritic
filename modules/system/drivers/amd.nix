{
  flake.nixosModules.amd-driver = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      mesa
      rocmPackages.rocm-smi
      rocmPackages.rocminfo
      vulkan-tools
    ];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          libvdpau-va-gl
          rocmPackages.clr.icd
        ];
      };
      amdgpu = {
        legacySupport.enable = true;
        opencl.enable = true;
        initrd.enable = true;
      };
    };

    environment.variables = {
      ROC_ENABLE_PRE_VEGA = "1";
      AMD_VULKAN_ICD = "RADV";
    };

    services.lact.enable = true;
    services.xserver.videoDrivers = [ "amgpu" ];

    boot.kernelParams = [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];

    # For rOCM
    systemd.tmpfiles.rules = [
      "L+ /opt/rocm - - - - ${pkgs.rocmPackages.clr}"
    ];
  };
}
