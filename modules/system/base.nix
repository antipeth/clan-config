{
  pkgs,
  host,
  ...
}:
{
  boot = {
    # Kernel
    kernelModules = [ "tcp_bbr" ];
    kernel = {
      sysctl = {
        # bbr
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.core.default_qdisc" = "fq";
        "net.core.wmem_max" = 1073741824;
        "net.core.rmem_max" = 1073741824;
        "net.ipv4.tcp_rmem" = "4096 87380 1073741824";
        "net.ipv4.tcp_wmem" = "4096 87380 1073741824";
      };
    };
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    btop
    curl
    fastfetch
    git
    lm_sensors
    lsof
    vim
    wget
  ];

  environment.variables = {
    # KUBECONFIG = /etc/rancher/k3s/k3s.yaml;
  };

  # Services to start
  services.openssh = {
    enable = true;
    ports = [ 222 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "root" ]; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = false;
      X11Forwarding = false;
      PermitRootLogin = "yes"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      222
      443
    ];
  };

  system.stateVersion = "25.05";
}
