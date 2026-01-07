{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./sddm.nix
  ];

  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    niri
    wezterm
    swaylock
    mako
    swayidle
    quickshell
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    xwayland-satellite

    # core for niri
    nautilus
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    gnome-keyring
    polkit
    polkit_gnome
    inputs.niri-scratchpad-flake.packages.${pkgs.system}.niri-scratchpad

    # additional stuff
    wlsunset
    brightnessctl
    gpu-screen-recorder
    pavucontrol

    # for config
    kdlfmt
  ];

  security.polkit.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
