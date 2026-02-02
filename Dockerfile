FROM ghcr.io/actions/actions-runner:latest

USER root

# Install dependencies
RUN apt-get update && apt-get install -y xz-utils curl && rm -rf /var/lib/apt/lists/*

# Install Nix using Determinate Systems installer in single-user mode
# This avoids the need for a running nix-daemon during build
RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
    sh -s -- install linux --no-confirm --init none --extra-conf "trusted-users = root runner"

# Set PATH for subsequent RUN commands
ENV PATH="/nix/var/nix/profiles/default/bin:${PATH}"

# Give runner user ownership of nix directories for single-user operation
RUN chown -R runner:runner /nix

# Switch to runner user for package installations
USER runner

# Install packages using nix profile (modern approach)
RUN nix profile install nixpkgs#cachix

RUN nix profile install nixpkgs#devenv

# Update PATH for runner user's nix profile
ENV PATH="/home/runner/.nix-profile/bin:${PATH}"

# Verify installations
RUN nix --version && cachix --version && devenv --version
