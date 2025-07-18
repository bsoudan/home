# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "core"; 
    domain = "soudan.net";
    hostId = "c0dec08e";
  };

  # Pick only one of the below networking options.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #networking.wireless.networks.Soudan.psk = "bleepbloopblop";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  services.printing.enable = true;


  environment.systemPackages = with pkgs; [
    smartmontools
    parted
    lsscsi
    pciutils
    hwloc
    fio
    hdparm
    powertop
    lm_sensors
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  powerManagement.powertop.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # https://www.smtp2go.com/setupguide/postfix/
  #
  # can run postconf afterwards to check configuration
  services.postfix = {
    enable = true;
    relayHost = "mail.smtp2go.com";
    relayPort = 2525;
    domain = "soudan.net";
    origin = "soudan.net";
    config = {
      smtp_use_tls = "yes";
      smtp_sasl_auth_enable = "yes";
      smtp_sasl_security_options = "noanonymous";
      smtp_sasl_password_maps = "texthash:${config.sops.secrets."postfix/sasl_passwd".path}";
      virtual_alias_maps = "inline:{ {root=bill@soudan.net} {bsoudan=bill@soudan.net} }";
    };
  };

  services.unifi = {
    enable = true;
    openFirewall = true;
  };

  # https://wiki.nixos.org/wiki/Blocky
  services.blocky = {
    enable = true;

    settings = {

      queryLog.type = "none"; # comment out and dns queries will be logged to journal

      ports.dns = 53;

      # don't block reverse dns, and .home, etc since we want it to pass through to the USG dns server
      specialUseDomains.enable = false;

      upstreams.groups.default = [
        "172.27.1.1"
        #"https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
      ];

      clientLookup.upstream = "172.27.1.1";

      bootstrapDns = {
        upstream = "172.27.1.1";
        ips = [ "1.1.1.1" "1.0.0.1" ];
      };

      blocking = {
        denylists = {
          ads = ["https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"];
        };
        clientGroupsBlock = {
          default = [ "ads" ];
        };
      };

      caching = {
        minTime = "5m";
        maxTime = "30m";
        prefetching = true;
      };
    };
  };

  services.cockpit = {
    enable = true;
    allowed-origins = [
      "https://*"
    ];
  };

  services.scrutiny = {
    enable = true;
    settings.web.listen.port = 8090;
    collector.enable = true;
  };

  services.homepage-dashboard = {
    enable = true;
    allowedHosts = "*";
    listenPort = 80;

    # https://github.com/NixOS/nixpkgs/blob/5dbc8a39b5e8ef70341156f3898616d1280b73b3/nixos/modules/services/misc/homepage-dashboard.nix#L78
    # https://dashboardicons.com/
    bookmarks = {
    };

    services = [
      { 
        "Services" = [
          {
            scrutiny = {
              icon = "scrutiny";
              href = "http://core.home:8090";
              description = "Scrutiny Description";
            };
          }
          {
            unifi = {
              icon = "unifi-controller";
              href = "https://core.home:8443";
              description = "UniFi Controller";
            };
          }
          {
            cockpit = {
              icon = "cockpit";
              href = "https://core.home:9090";
              description = "Cockpit Admin Console";
            };
          }
          {
            zwave-js-ui = {
              icon = "zwave";
              href = "http://core.home:8091";
              description = "ZWave JS UI";
            };
          }
        ];
      }
    ];

    widgets = [
      {
        greeting = {
          text = "|";
        };
      } 
      {
        greeting = {
          text = "core.soudan.net";
        };
      } 
      {
        greeting = {
          text = "|";
        };
      } 
      {
        resources = {
          cpu = true;
          cputemp = true;
          tempmin = 0;
          tempmax = 200;
          units = "imperial";
          memory = true;
          uptime = true;
        };
      }
      {
        greeting = {
          text = "|";
        };
      } 
      {
        resources = {
          disk = "/";
          label = "root";
        };
      }
      {
        resources = {
          disk = "/srv/vault";
          label = "vault";
        };
      }
      {
        resources = {
          disk = "/srv/storage";
          label = "storage";
        };
      }
      {
        greeting = {
          text = "|";
        };
      } 
      {
        openmeteo = {
          cache = 5;
          timezone = "America/New_York";
          format = {
            maximumFractionDigits = 1;
          };
          units = "imperial";
          latitude = 43.130341;
          longitude = -77.475548;
        };
      }
    ];

  };


  services.zwave-js-ui = {
    enable = true;
    serialPort = "/dev/serial/by-id/usb-Zooz_800_Z-Wave_Stick_533D004242-if00";

    # https://zwave-js.github.io/zwave-js-ui/#/guide/env-vars
    settings = {
      DEFAULT_USERNAME = "bsoudan";
      DEFAULT_PASSWORD = "admin";

      KEY_S0_Legacy = "F9B412999E8F8BCB6D82CB9AE375D495";
      KEY_S2_Unauthenticated = "38A027EBE716488D38417D1552FBEC48";
      KEY_S2_Authenticated = "B5FA83A5DE14FCE156A0E8643F5BEE61";
      KEY_S2_AccessControl = "8AF1199CEE462C4E2F5CA3D38FD834FF";
      KEY_LR_S2_Authenticated = "126FAA2798F3BE3472745C8A26736083";
      KEY_LR_S2_AccessControl = "927397A10AD41586416CB0378AEA8710"; 
    };
  };



  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

