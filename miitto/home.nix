{ config, pkgs, inputs, ... }:

{
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

  home.packages = with pkgs; [
    lazygit
    starship
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      eval "$(starship init zsh)"
    '';

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch --flake ~/.config/nix";
      ns = "nix-shell --run zsh";
      nsp = "nix-shell --pure";
      gowindows = ''efibootmgr | grep "Windows Boot Manager" | sed -r 's/^Boot([[:digit:]]{4}).*/\1/' | xargs sudo efibootmgr --bootnext && systemctl reboot'';
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
  };

  home.file = {
    ".local/share/icons/Twilight-cursors/".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix/miitto/Twilight-cursors";
    ".local/share/icons/default/".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix/miitto/Twilight-cursors";
  };

  home.sessionVariables = {
    "EDITOR" = "nvim";
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";
    # enable native Wayland support for most Electron apps
    "ELECTRON_OZONE_PLATFORM_HINT" = "auto";
    # misc
    "QT_WAYLAND_DISABLE_WINDOWDECORATION" = "1";
    "QT_QPA_PLATFORM" = "wayland";
    "SDL_VIDEODRIVER" = "wayland";
    "GDK_BACKEND" = "wayland";
    "XDG_SESSION_TYPE" = "wayland";
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "miitto";
  home.homeDirectory = "/home/miitto";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
