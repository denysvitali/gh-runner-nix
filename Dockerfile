FROM ghcr.io/actions/actions-runner:latest

USER root

RUN apt-get update && apt-get install -y xz-utils

RUN curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate --no-confirm

RUN groupadd nix && usermod -aG nix runner

RUN echo "trusted-users = root runner" >> /etc/nix/nix.conf

ENV PATH="/nix/var/nix/profiles/default/bin:${PATH}"

RUN nix-daemon & sleep 2 && nix-env --install --attr devenv -f https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable

USER runner

RUN devenv --version

RUN nix --version