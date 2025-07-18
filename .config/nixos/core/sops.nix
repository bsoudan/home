
{
  sops.defaultSopsFile = ./secrets.yaml;
  sops.secrets = {
    "postfix/sasl_passwd" = {};
  };
}


