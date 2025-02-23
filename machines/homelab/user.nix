{
  users = {
    mutableUsers = false;
    users = {
      root = {
        hashedPassword = "$y$j9T$C2J6aO1jUHb3OHBwIFk8a/$L92R8BMd/.XSlEXGz/r.eawijb9t.8otEbkLyQ1lwK5";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4QAvLJJuxAaayqIBU8n6P0D0KHHSEjnqe3Ey7GZvFK"
        ];
      };
      atp = {
        isNormalUser = true;
        createHome = false;
        useDefaultShell = false;
      };
    };
  };
}
