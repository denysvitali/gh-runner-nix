FROM ghcr.io/actions/actions-runner:latest

USER root

RUN apt-get update && apt-get install -y xz-utils curl

RUN groupadd nix && usermod -aG nix runner

USER runner

RUN curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install -o /tmp/install.sh && sh /tmp/install.sh --no-daemon

# Fix nix store permissions for the nix group
RUN chmod -R g+w /nix/var/nix/profiles/default /nix/var/nix/gc-schema /nix/var/nix/temproots && \
    chgrp -R nix /nix/var/nix/profiles/default /nix/var/nix/gc-schema /nix/var/nix/temproots

ENV PATH="/home/runner/.nix-profile/bin:/nix/var/nix/profiles/default/bin:${PATH}"

RUN nix-env --quiet -j8 -iA cachix -f https://cachix.org/api/v1/install

RUN nix-env --install --attr devenv -f https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable

RUN devenv --version

RUN nix --version