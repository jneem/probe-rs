{
  description = "Devshell for esp32c3 dev";

  inputs = {
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ (import rust-overlay) ];
        };
        rust-toolchain = pkgs.rust-bin.nightly.latest.default.override {
          extensions = [ "llvm-tools-preview" "rust-src" ];
        };
      in
      {
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
#            rustup
            rust-toolchain
            rust-analyzer
            cargo-espflash
            cargo-expand
            cargo-outdated
            taplo
            pkg-config
            udev
            openssl
          ];
        };
      }
    );
}
