{
  flake.nixosModules.audio = { pkgs, ... }: {
    security.rtkit.enable = true;
    services.pulseaudio = {
      enable = false;
      extraConfig = "
        load-module module-switch-on-connect
      ";
    };

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    environment.systemPackages = with pkgs; [
      alsa-utils
      playerctl
      pulseaudio # Audio control
      pwvucontrol # Pavucontrol for Pipewire
      pavucontrol
    ];
  };
}
