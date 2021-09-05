{ moz_overlay ? builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz
, ros_overlay ? builtins.fetchTarball https://github.com/lopsided98/nix-ros-overlay/archive/master.tar.gz
}:

let
  pkgs = import <nixpkgs> {
    overlays = [
      (import moz_overlay)
      (import "${ros_overlay}/overlay.nix")
    ];
  };
  rust-nightly = pkgs.rustChannelOfTargets "nightly" "2021-06-29" [ "wasm32-unknown-unknown" ];
in
  with pkgs;
  with rosPackages.noetic;
rec {
  substrate-ros-msgs = callPackage ./msgs/substrate_ros_msgs { };
  inherit pkgs rust-nightly;
}
