/* SPDX-License-Identifier: GPL-3.0-only */

{
  description = "iommutests dev flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    libvfn.url = "github:Joelgranados/libvfn/cc68647b8a4d95d3cb101e036a5662dbb0f696d5";
    env_shell.url = "github:Joelgranados/nix_envs?dir=env_shell";
  };

  outputs = { self, nixpkgs, libvfn, env_shell, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      system = "x86_64-linux";
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          libvfn.packages.${system}.default
          meson
          ninja
          git
          gnumake
          pkg-config
          cmake
          clang-tools
          nodePackages.pyright
          man-pages
          python311Packages.pytest
          python311Packages.pyudev
          git-filter-repo
          clang-tools
          man-pages
        ];
        hardeningDisable = ["fortify"];

        shellHook = ''
          export _prompt_sorin_prefix="%F{green}(I8S)"
        ''
        + env_shell.devShells.${system}.default.shellHook
        ;
      };
    };
}
