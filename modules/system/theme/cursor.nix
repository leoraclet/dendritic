{
  flake.nixosModules.cursor = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      bibata-cursors
    ];

    environment.variables = {
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "24";
    };

    programs = {
      xfconf.enable = true;
      dconf = {
        enable = true;
        profiles.user.databases = [
          {
            lockAll = false;
            settings = {
              "org/gnome/desktop/interface" = {
                icon-theme = "Papirus";
                color-scheme = "prefer-dark";
                cursor-theme = "Bibata-Modern-Ice";
                font-name = "FiraMono Nerd Font 11";
              };
            };
          }
        ];
      };
    };
  };
}
