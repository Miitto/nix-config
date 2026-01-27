{ pkgs, inputs, ...}: {
environment.systemPackages = with pkgs; [
    renderdoc
    vesktop
    nodejs_25
    blender
  ];

}
