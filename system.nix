{
  lib,
  pkgs,
  user,
  inputs,
  ...
}:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "miitto"; # Define your hostname.
  networking.networkmanager.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "miitto";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  console.keyMap = "uk";

  users.users.miitto = {
    isNormalUser = true;
    description = "Miitto";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.swaylock = {};
  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.lact.enable = true;
  hardware.amdgpu.overdrive.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [

    ];
  };

  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [
# Core
    wget
    git
    corefonts # ms-corefonts
    zip
    unzip
    polkit
# Niri stuff
    niri
    wezterm
    swaylock
    mako
    swayidle
    quickshell
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    xwayland-satellite
# Dev
    cmake
    llvmPackages_latest.lldb
    gdb
    clang-tools
    llvmPackages_latest.libstdcxxClang
    cppcheck
    llvmPackages_latest.libllvm
    valgrind
    llvmPackages_latest.libcxx
# Useful
    fzf
    tealdeer
    nps
    tree
    ripgrep
    nixd
    nil
    helix
  ];

  services.flatpak.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.niri.enable = true;
  programs.neovim.enable = true;
  programs.xwayland.enable = true;

  system.stateVersion = "25.11";
}

