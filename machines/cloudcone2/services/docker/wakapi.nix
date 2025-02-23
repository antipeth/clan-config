{
  image = "ghcr.io/muety/wakapi:latest";

  volumes = [
    "/etc/wakapi:/data"
    "/etc/localtime:/etc/localtime:ro"
  ];

  ports = [
    "127.0.0.1:3000:3000"
  ];

  environment = {
    WAKAPI_PASSWORD_SALT = "4gaGQyuSlRCAHKwaLa0umTUHDDHlykBHfLNVSp0AFr0XhOgAN";
    WAKAPI_ALLOW_SIGNUP = "false";
    WAKAPI_PUBLIC_URL = "https://wakapi.0pt.icu";
  };

  user = "root";
}
