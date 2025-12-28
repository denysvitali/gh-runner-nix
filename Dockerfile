FROM ghcr.io/actions/actions-runner:latest

USER root

RUN apt-get update && apt-get install -y xz-utils curl

RUN groupadd nix && usermod -aG nix runner

USER runner

RUN curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install -o /tmp/install.sh && sh /tmp/install.sh --no-daemon

# Ensure /nix is accessible (single-user install already chowns to runner)
RUN chmod 755 /nix

ENV PATH="/home/runner/.nix-profile/bin:/nix/var/nix/profiles/default/bin:${PATH}"

RUN nix-env --quiet -j8 -iA cachix -f https://cachix.org/api/v1/install

RUN nix-env --install --attr devenv -f https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable

RUN devenv --version

RUN nix --version