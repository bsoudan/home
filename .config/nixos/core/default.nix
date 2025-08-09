# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./openvpn-server.nix
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
  sops.secrets."postfix/sasl_passwd" = {};

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

  #services.cockpit = {
  #  enable = true;
  #  allowed-origins = [
  #    "https://*"
  #  ];
  #};

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
        "Media" = [
          {
            transmission = {
              icon = "transmission";
              href = "http://core.home:9091";
              description = "Transmission Web Bittorrent Client";
              widget = {
                type = "transmission";
                url = "http://core.home:9091";
              };
            };
          }
          {
            plex = {
              icon = "Plex";
              href = "http://core.home:32400";
              description = "Plex Media Portal";
              widget = {
                type = "plex";
                url = "http://core.home:32400";
                key = "trsxVHp6j3_BBwLeV7ZD";
              };
            };
          }
        ];
      }
      {
        "Home" = [
          {
            "brother laser printer" = {
              icon = "printer";
              href = "http://core.home:631";
              description = "CUPS Web Portal";
            };
          }
          {
            zwave-js = {
              icon = "zwave";
              href = "http://core.home:8091";
              description = "ZWave Web Portal";
            };
          }
        ];
      }
      {
        "Admin" = [
          {
            netdata = {
              icon = "netdata";
              href = "http://core.home:19999";
              description = "NetData Web UI";
              widget = {
                type = "netdata";
                url = "http://core.home:19999";
              };
            };
          }
          {
            unifi = {
              icon = "unifi-controller";
              href = "https://core.home:8443";
              description = "UniFi Controller";
              # https://core.home:8443/api/stat/sites seems to give data, but the portal is adding /proxy/network
              # widget = {
              #   type = "unifi";
              #   url = "https://core.home:8443";
              #   key = "uB7u4Z1Fqm5WRDyI7D2B_k1h6tn9CznU";
              # };
            };
          }
          {
            scrutiny = {
              icon = "scrutiny";
              href = "http://core.home:8090";
              description = "Hard Drive monitor";
              widget = {
                type = "scrutiny";
                url = "http://core.home:8090";
              };
            };
          }
          #{
          #  cockpit = {
          #    icon = "cockpit";
          #    href = "https://core.home:9090";
          #    description = "Cockpit Admin Console";
          #  };
          #}
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
          text = "core.home";
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

  # to add to windows, http://core.home:631/printers/brother
  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];

    # sharing
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;

    # allow http connections from any name so http://core.home:631 works
    extraConf = ''
      ServerAlias *
    '';
  };

  hardware.printers.ensurePrinters = [{
    name = "brother";
    location = "127 Stoneledge Way";
    deviceUri = "usb://Brother/HL-L2320D%20series?serial=U63877L6N225309"; # lpinfo -v
    model = "drv:///brlaser.drv/brl2320d.ppd"; # lpinfo -m | grep brlaser
  }];
  hardware.printers.ensureDefaultPrinter = "brother";

  # no declarative smbpasswd, need to run 'smbpasswd -a username' to add
  services.samba = {
    enable = true;
    package = pkgs.samba4Full;
    openFirewall = true;
    settings = {
      homes = {
        comment = "Home Directories";
        browseable = "no";
        "read only" = "no";
        "valid users" = "%S";
      };
      storage = {
        comment = "Storage";
        browseable = "yes";
        writeable = "true";
        path = "/srv/storage";
        "create mask" = 0664;
        "force create mode" = 0664;
        "directory mask" = 2775;
        "force directory mode" = 2775;
        "valid users" = "bsoudan";
      };
      media = {
        comment = "Media";
        browseable = "yes";
        writeable = "true";
        path = "/srv/storage/media";
        "create mask" = 0664;
        "force create mode" = 0664;
        "directory mask" = 2775;
        "force directory mode" = 2775;
      };
    };
  };

  services.ntp = {
    enable = true;
    servers = [ "0.north-america.pool.ntp.org" "1.north-america.pool.ntp.org" "2.north-america.pool.ntp.org" "3.north-america.pool.ntp.org" ];
  };

  services.transmission = {
    enable = true;
    # https://github.com/transmission/transmission/blob/main/docs/Editing-Configuration-Files.md
    # /var/lib/transmission/.config/transmission-daemon/settings.json
    # https://github.com/eternnoir/transmission/blob/master/settings.json

    settings = {
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "*";
      rpc-host-whitelist = "*";
      ratio-limit = 2;
      ratio-limit-enabled = true;
      download-dir = "/srv/storage/media/downloads";

      # 2025/08/09 -- greenlight is 570 Mbps up & down
      #   400 Mb/s -> 50000 kB/s

      speed-limit-down = 50000;
      speed-limit-down-enabled = true;
      speed-limit-up = 50000;
      speed-limit-up-enabled = true;
    };
    webHome = pkgs.flood-for-transmission;
  };

  # on first run, web interface was empty, only online plex resources
  #
  # had to 'claim' the media server by logging in and running
  # curl -X POST 'http://127.0.0.1:32400/myplex/claim?token=claim-s2fNs1zvMCYHJzjrPG57'
  # claim token came from https://account.plex.tv/claim
  # validated with curl http://localhost:32400/identity
  #   <?xml version="1.0" encoding="UTF-8"?>
  #   <MediaContainer size="0" apiVersion="0.2.0" claimed="1" machineIdentifier="7920f7dbf88b58df1f41ec1f11db692769a0927a" version="1.41.6.9685-d301f511a">
  #   </MediaContainer>
  # claimed was 0 before
  # then, when i logged into web interface, setup wizard ran to set up media server

  services.plex.enable = true;
  users.users.plex.extraGroups = [ "storage" ];

  users.users.kyle = {
    uid = 1010;
    isNormalUser = true;
    description = "Kyle Gotowka";
    extraGroups = [ "storage" ];
    hashedPassword = "$y$j9T$P.afKWIQkjI7LszgF4JO7/$9ajt0SbkggUCBWwi3Q2YbpfgQHfA/Os5LzvJtdEIVRC";
  };

  # fileSystems."/mnt/storage" = {
  #     device = "//nas/storage";
  #     fsType = "cifs";
  #     options = let
  #         # this line prevents hanging on network split
  #         automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  #     in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  # };

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

# {
#   imports = [ ./hardware-configuration.nix ./openvpn-server.nix ];
# #  imports = [ ./hardware-configuration.nix ./valheim.nix];

#   environment.systemPackages = with pkgs; [
#     git
#     tcpdump
#     strace
#     binutils
#     lsof
#     netcat
#     traceroute
#     file
#     which
#     screen
#     wget
#     curl
#     unzip
#     bzip2
#     gnupg1
#     zip
#     patchelf
#     micro
#     steamcmd
#     tmux
#     iotop
#     iftop
#     nethogs
#     python3
#     sysstat
#   ];

#   #  consoleFont = "lat9w-16";
#   console = {
#     font = "Lat2-Terminus16";
#     keyMap = "dvorak";
#   };

#   networking = {

#     interfaces.ens3 = {
#       useDHCP = false;
#       ipv4.addresses = [
#         { address = "172.27.1.3"; prefixLength = 24; }
#       ];
#     };

#     defaultGateway = "172.27.1.1";
#     nameservers = ["8.8.8.8"];

#     firewall.enable = false;

#     extraHosts = ''
#         172.27.1.2 nas
#     '';
#   };

#   services.openssh.enable = true;

#   nixpkgs.config.allowUnfree = true;
#   nix.readOnlyStore = false;

#   services.avahi = {
#     enable = true;
#     nssmdns = true;
#     openFirewall = true;
#     publish = {
#       enable = true;
#       addresses = true;
#       domain = true;
#       hinfo = true;
#       userServices = true;
#       workstation = true;
#     };
#   };

#   environment.shellAliases = {
#     "sys" = "systemctl";
#     "j" = "journalctl";
#     "xyz" = builtins.getEnv "XYZ";
#   };

#  services.unifi = {
#    enable = true;
#    unifiPackage = pkgs.unifi8;
#  };


  # virtualisation.docker.enable = true;
  # users.extraGroups.docker.members = [ "bsoudan" ];

#  services.home-assistant = {
#    enable = true;
#
#    package = (pkgs.home-assistant.override {
#      extraPackages = ps: [
#        ps.python_openzwave
#      ];
#    });
#
#    config.homeassistant = {
#      name = "127 Stoneledge Way";
#      latitude = "45.154425";
#      longitude = "-77.471735";
#      elevation = "152";
#      unit_system = "imperial";
#      time_zone = "America/New_York";
#    };
#
#    config.zwave = {
#      usb_path = "/dev/ttyUSB0";
#      network_key = "0x97, 0x07, 0xAB, 0x9E, 0x53, 0x3C, 0x66, 0x92, 0x21, 0xF8, 0xEE, 0xF3, 0x4E, 0xC8, 0x52, 0x9B";
#    };
#  };

#  services.terraria = {
#    enable = true;
#    password = "sparkle585";
#    messageOfTheDay = "Welcome to The Dirty Hinterlands!  No noobs allowed.";
#    autoCreatedWorldSize = "medium";
#    openFirewall = true;
#  };
#  users.users.terraria.group = "terraria";

#   nixpkgs.config = {
#     packageOverrides = super: let self = super.pkgs; in {
#       terraria-server = super.terraria-server.overrideAttrs (oldAttrs: rec {
#           version = "1.4.3.6";
#           urlVersion = "1436";
#           src = super.fetchurl {
#               url = "https://terraria.org/api/download/pc-dedicated-server/terraria-server-${urlVersion}.zip";
#               sha256 = "sha256-OFI7U6Mqu09pIbgJQs0O+GS8jf1uVuhAVEJhYNYXrBE=";
#           };
#       });
#     };
#   };

#   services.syncthing = {
#     enable = true;
#     openDefaultPorts = true;

#     settings.gui = {
#       user = "myuser";
#       password = "mypassword";
#     };
#   };
# }
