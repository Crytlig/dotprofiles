{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "nixbox-shell";
  buildInputs = with pkgs; [
    gnumake
    helix
    zellij
    zsh
    oh-my-zsh
    git
    neovim
    ripgrep
    unzip
    docker
    nixFlakes
    nixUnstable
  ];

  shellHook = ''
    echo "Hi Mom!";
  '';
}


# stdenv.mkDerivation {
#   name = "nixbox-shell";
#   buildInputs = [
#     gnumake
#     packer
#     ruby
#     vagrant
#     helix
#     zellij
#     zsh
#     oh-my-zsh
#     git
#     neovim
#     clang
#     gcc
#     ripgrep
#     unzip
#     docker
#   ];
# }
