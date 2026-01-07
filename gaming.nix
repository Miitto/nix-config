{
  inputs,
  lib,
  config,
  ...
}:

let
  cfg = config.gaming;
in
{
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  options.gaming.vr = {
    enable = lib.mkEnableOption "VR Support (WiVRn)";
  };

  config = lib.mkMerge [
    # general gaming stuff
    {
      services.pipewire.lowLatency.enable = true;
      programs.gamemode.enable = true;
      programs.steam = {
        enable = true;
        platformOptimizations.enable = true;
        gamescopeSession.enable = true;
      };
    }

    # VR gaming
    # https://wiki.nixos.org/wiki/VR
    (lib.mkIf cfg.vr.enable {
      services.wivrn = {
        enable = true;
        openFirewall = true;
        defaultRuntime = true;
        autoStart = true;
      };
    })
  ];
}

