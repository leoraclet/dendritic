{
  flake.nixosModules.fonts = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      font-awesome
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      nerd-fonts.jetbrains-mono
      fira-mono
      iosevka
    ];

    fonts.fontconfig.defaultFonts = {
      monospace = [
        "JetBrainsMono Nerd Font"
      ];
    };
  };
}
