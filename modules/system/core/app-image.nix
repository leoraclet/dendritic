{
  flake.nixosModules.app-image = { pkgs, ... }: {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    environment.systemPackages = with pkgs; [
      appimage-run # To run AppImages
    ];
  };
}
