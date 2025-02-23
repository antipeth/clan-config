{
  config,
  pkgs,
  host,
  ...
}:
{
  systemd.services.traefik.environment = {
    # Please check this url https://go-acme.github.io/lego/dns/
    NETLIFY_TOKEN = "nfp_d8AyMXdr2bKq3AvJ3sEnftfS9LCheKgMb633";
    # or
    # CLOUDFLARE_DNS_API_TOKEN_FILE = "/path/to/File";
  };

  services.traefik = {
    enable = true;
    staticConfigOptions = {
      # log = {
      # level = "INFO";
      # filePath = "${config.services.traefik.dataDir}/traefik.log";
      # format = "json";
      # };
      entryPoints = {
        # web = {
        #   address = ":80";
        # };
        websecure = {
          address = ":443";
          http.tls = {
            certResolver = "myresolver";
            domains = {
              main = "0pt.icu";
              sans = [ "*.0pt.icu" ];
            };
          };
        };
      };

      certificatesResolvers.myresolver.acme = {
        dnsChallenge = {
          provider = "netlify";
          delayBeforeCheck = "10";
        };
        email = "0pt@disroot.org";
        storage = "${config.services.traefik.dataDir}/acme.json";
        # httpChallenge.entryPoint = "web";
      };

      # certificatesResolvers.myresolver.acme = {
      #   tlschallenge = true;
      #   email = "youremail@domain.com";
      #   storage = "${config.services.traefik.dataDir}/acme.json";
      #   # httpChallenge.entryPoint = "web";
      # };

      api.dashboard = false;
      # Access the Traefik dashboard on <Traefik IP>:8080 of your server
      api.insecure = false;
    };

    dynamicConfigOptions = {
      http = {
        routers = {
          # syncthing = {
          #   entryPoints = [ "websecure" ];
          #   rule = "Host(`sync.0pt.icu`)";
          #   service = "syncthing";
          #   tls.certresolver = "myresolver";
          # };
          alist = {
            entryPoints = [ "websecure" ];
            rule = "Host(`alist.0pt.icu`)";
            service = "alist";
            tls.certresolver = "myresolver";
          };
          #netdata = {
          #  entryPoints = [ "websecure" ];
          #  rule = "Host(`data.0pt.icu`)";
          #  service = "netdata";
          #  tls.certresolver = "myresolver";
          #  # middlewares = "auth";
          #};
          cockpit = {
            entryPoints = [ "websecure" ];
            rule = "Host(`monitor.0pt.icu`)";
            service = "cockpit";
            tls.certresolver = "myresolver";
            middlewares = "auth";
          };
          wakapi = {
            entryPoints = [ "websecure" ];
            rule = "Host(`wakapi.0pt.icu`)";
            service = "wakapi";
            tls.certresolver = "myresolver";
            # middlewares = "auth";
          };
        };
        middlewares.auth.basicauth.users = "oj3s41wep9mwty:$2y$10$zvfCtPjNvbwNWYcAy/CFmupw40vRuwNr.3VAnzm2ZC9yoFSZP/Tky";
        services = {
          # syncthing = {
          #   loadBalancer = {
          #     servers = [
          #       {
          #         url = "http://localhost:8384";
          #       }
          #     ];
          #     passHostHeader = false;
          #   };
          # };
          alist = {
            loadBalancer = {
              servers = [
                {
                  url = "http://localhost:5244";
                }
              ];
            };
          };
          # netdata = {
          #   loadBalancer = {
          #     servers = [
          #       {
          #         url = "http://localhost:19999";
          #       }
          #     ];
          #   };
          # };
          cockpit = {
            loadBalancer = {
              servers = [
                {
                  url = "http://localhost:9090";
                }
              ];
            };
          };
          wakapi = {
            loadBalancer = {
              servers = [
                {
                  url = "http://localhost:3000";
                }
              ];
            };
          };
        };
      };
    };
  };
}
