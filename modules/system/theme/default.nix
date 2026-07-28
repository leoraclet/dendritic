{ self, ... }: {
  flake.nixosModules.theme = { pkgs, ... }: {
    imports = with self.nixosModules; [
      cursor
      fonts
    ];

    environment.systemPackages = with pkgs; [
      # Icon theme
      papirus-folders
      papirus-icon-theme

      # Apps to customize looks
      nwg-look
      adw-gtk3
      kdePackages.qt6ct
    ];
  };
}
