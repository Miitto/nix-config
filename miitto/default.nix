{ pkgs, inputs, ...}: {
environment.systemPackages = with pkgs; [
    vesktop
    nodejs_25
  ];

}
