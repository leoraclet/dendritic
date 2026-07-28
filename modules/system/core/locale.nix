{
  flake.nixosModules.locale = { ... }: {
    services.automatic-timezoned.enable = true;
    time.hardwareClockInLocalTime = true;
    # time.timeZone = "Europe/Paris"; # Set your timezone manually

    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        # LC_ALL = "fr_FR.UTF-8"; # This overrides all other LC_* settings.
        LC_CTYPE = "fr_FR.UTF8";
        LC_ADDRESS = "fr_FR.UTF-8";
        LC_IDENTIFICATION = "fr_FR.UTF-8";
        LC_MEASUREMENT = "fr_FR.UTF-8";
        LC_MONETARY = "fr_FR.UTF-8";
        LC_NAME = "fr_FR.UTF-8";
        LC_NUMERIC = "fr_FR.UTF-8";
        LC_PAPER = "fr_FR.UTF-8";
        LC_TELEPHONE = "fr_FR.UTF-8";
        LC_TIME = "fr_FR.UTF-8";
        LC_MESSAGES = "fr_FR.UTF-8";
        LC_COLLATE = "fr_FR.UTF-8";
      };

      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "fr_FR.UTF-8/UTF-8"
      ];
    };

    services.xserver.xkb = {
      layout = "fr";
      variant = "azerty";
    };
    console = {
      earlySetup = true;
      useXkbConfig = true;
    };
  };
}
