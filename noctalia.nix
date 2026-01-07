{ pkgs, inputs, ... }: {
  home-manager.users.miitto = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell.enable = true;
  };
}
