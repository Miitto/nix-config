{ pkgs, ...}: {
  imports = [
    inputs.youtube-music.homeManagerModules.default
  ];

  programs.youtube-music = {
    enable = true;
    options = {
        tray = true;
        startAtLogin = true;
    };
    plugins = {
        precise-volume.enable = true;
    };
  };
}
