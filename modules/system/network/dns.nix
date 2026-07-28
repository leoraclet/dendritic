{
  flake.nixosModules.power = { lib, ... }: {
    # https://wiki.nixos.org/wiki/Unbound
    services.unbound = {
      enable = false;
      settings.server = {
        access-control = [ ];
        interface = [ ];
      };
    };

    # Enable Encrypted DNS
    networking = {
      # Configure DNS servers manually (this example uses Cloudflare and Google DNS)
      # IPv6 DNS servers can be used here as well.
      nameservers = [
        "127.0.0.1"
        "[::1]"
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
      ];

      # These options are unnecessary when managing DNS ourselves
      useDHCP = false;
      dhcpcd = {
        enable = false; # disable, because enabled by default
        extraConfig = "nohook resolv.conf";
      };

      # Disable NetworkManager's internal DNS resolution
      networkmanager.dns = "none";

      # If using resolvconf:
      resolvconf = {
        enable = true; # FIXME: remember to delete /etc/resolv.conf if you disable `resolvconf`
        useLocalResolver = true;
      };

      # If using iwd:
      wireless.iwd.settings.Network.NameResolvingService = "none";
    };

    services.dnscrypt-proxy = {
      enable = true;
      settings = {
        listen_addresses = [
          "127.0.0.1:53"
          "[::1]:53"
        ];

        ipv4_servers = true;
        ipv6_servers = false;
        block_ipv6 = false;
        doh_servers = true;

        require_nolog = true;
        require_nofilter = false; # quad9 has some nice security filters
        require_dnssec = true;

        enable_hot_reload = true;

        # Add this to test if dnscrypt-proxy is actually used to resolve DNS requests
        query_log.file = "/var/log/dnscrypt-proxy/query.log";

        forwarding_rules = "${./rules/forwarding-rules.txt}";
        captive_portals.map_file = "${./rules/captive-portals.txt}";
        blocked_names.blocked_names_file = "${./rules/blocked-names.txt}";

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          refresh_delay = 72;
          cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        sources.quad9-resolvers = {
          urls = [
            "https://quad9.net/dnscrypt/quad9-resolvers.md"
            "https://raw.githubusercontent.com/Quad9DNS/dnscrypt-settings/main/dnscrypt/quad9-resolvers.md"
          ];
          minisign_key = "RWQBphd2+f6eiAqBsvDZEBXBGHQBJfeG6G+wJPPKxCZMoEQYpmoysKUN";
          cache_file = "/var/lib/dnscrypt-proxy/quad9-resolvers.md";
          refresh_delay = 72;
          prefix = "quad9-";
        };

        # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
        server_names = [
          "cloudflare"
          "cloudflare-ipv6"
          "cloudflare-security"
          "cloudflare-security-ipv6"
          "adguard-dns"
          "adguard-dns-doh"
          "mullvad-adblock-doh"
          "mullvad-doh"
          "nextdns"
          "nextdns-ipv6"
          "quad9-dnscrypt-ipv4-filter-pri"
          "google"
          "google-ipv6"
          "ibksturm"
        ];
      };
    };

    # https://github.com/NixOS/nixpkgs/issues/170573
    # TLDR: when using StateDirectory, systemd will strong arm control for it.
    # it creates a /var/lib/private thing, confusing, bind mounting that will
    # freak out because it's using a dynamic user. Last thing we want
    # is for DNS to not work on the system. Setting ReadWritePaths gives
    # us full control, and allows us to persist it correctly.
    systemd.services.dnscrypt-proxy2.serviceConfig = {
      StateDirectory = lib.mkForce "";
      ReadWritePaths = "/var/lib/dnscrypt-proxy";
    };

    # Make sure this directory exists so the service doesn't fail on boot
    systemd.tmpfiles.rules = [ "d /var/lib/dnscrypt-proxy 0777 root root -" ];
  };
}
