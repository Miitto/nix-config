{
  inputs,
  config,
  pkgs,
  ...
}:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      bigclock = "en";
    };
  };
}
