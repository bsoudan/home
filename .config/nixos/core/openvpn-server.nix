{ config, ... }:
let
  domain = "soudan.net";
  vpn-dev = "tun0";
  port = 1194;
in {

  sops.secrets.openvpn-secret = {};

  networking.firewall.trustedInterfaces = [ vpn-dev ];
  networking.firewall.allowedUDPPorts = [ port ];

  environment.etc."openvpn/carbon-client.ovpn" = {
    text = ''
      dev tun
      remote "soudan.net"
      port ${toString port}
      redirect-gateway def1

      cipher AES-256-CBC
      auth-nocache

      comp-lzo
      keepalive 10 60
      resolv-retry infinite
      nobind
      persist-key
      persist-tun
      secret ${config.sops.secrets.openvpn-secret.path}

      ifconfig 10.8.0.2 10.8.0.1
    '';

    mode = "600";
  };

  services.openvpn.servers.stoneledge-server.config = ''
    dev ${vpn-dev}
    proto udp
    secret ${config.sops.secrets.openvpn-secret.path}
    port ${toString port}

    cipher AES-256-CBC
    auth-nocache

    comp-lzo
    keepalive 10 60
    ping-timer-rem
    persist-tun
    persist-key

    ifconfig 10.8.0.1 10.8.0.2
  '';

}
