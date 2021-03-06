{ release ? import ./release.nix { }
}:

with release.pkgs;
with llvmPackages;

stdenv.mkDerivation {
  name = "nix-shell";
  propagatedBuildInputs = [ release.substrate-ros-msgs ];
  nativeBuildInputs = [ clang ];
  buildInputs = [ release.rust-nightly ];
  LIBCLANG_PATH = "${clang-unwrapped.lib}/lib";
  PROTOC = "${protobuf}/bin/protoc";
}
