{
  flake.nixosModules.sddm =
    { pkgs, ... }:
    let
      custom-sddm-astronaut = pkgs.sddm-astronaut.override {
        embeddedTheme = "black_hole";
      };
    in
    {
      services.displayManager = {
        sddm = {
          enable = true;
          autoNumlock = true;
          theme = "sddm-astronaut-theme";
          package = pkgs.kdePackages.sddm;
          wayland.enable = true;
          settings = {
            General = {
              Numlock = "on";
              DisplayServer = "Wayland";
            };
            Theme = {
              Current = "sddm-astronaut-theme";
              CursorTheme = "Bibata-Modern-Ice"; # the cursor name here matters
              # I would always go check the source nix file
              # to see how the maintainers built and named it
              CursorSize = 24;
            };
            Wayland = {
              CompositorCommand = "cage";
            };
            X11 = {
              CursorTheme = "Bibata-Modern-Ice";
              CursorSize = 24;
            };
          };
          extraPackages = [
            custom-sddm-astronaut
          ];
        };
        autoLogin = {
          enable = false;
          user = "leonne"; # Replace with the desired user
        };
      };

      environment.systemPackages = [
        # SDDM Theme
        custom-sddm-astronaut
        pkgs.cage
      ];
    };
}
