# Fedora Sericea with Sway - Docker Image

This Docker image is based on Fedora Sericea, an immutable Fedora spin that is similar to Fedora Silverblue, with the key difference being the usage of the Sway tiling window manager. This Docker image comes pre-configured with many base configurations and additional tools, aimed at providing an efficient and smooth workflow.

## Features

- **Fedora Sericea:** This Docker image is built on the base of Fedora Sericea, providing an immutable and reliable Fedora experience.
- **Sway Window Manager:** Fedora Sericea in this Docker image uses the Sway tiling window manager as its base, perfect for efficient and resource-friendly window management.
- **Automatic Update Policy Configuration:** The automatic update policy is pre-configured in this Docker image, providing a stable and updated system environment.
- **SDDM with Custom Themes:** The Docker image comes pre-loaded with SDDM as the display manager, and has been configured with custom themes.
- **Essential Tools Pre-installed:** This Docker image comes with essential tools pre-installed, including the AWS CLI, Docker, vim, zsh, NetworkManager-tui, ansible, and more.
- **Cleanup and State Commit:** The Docker image is cleaned up and committed for state preservation, reducing clutter and saving storage.

### Rebasing to the Docker Image

Users can rebase their systems to this Docker image, which will set up Fedora Sericea with all the pre-configurations and tools included in this image.

You can use this command to achieve this:-
```sh
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/lukejcollins/fedora-sericea-docker-build/sericea-custom-build:v1
```

## Contributing

Contributions to improve this Docker image are always welcome. Ensure to test your changes locally before submitting a pull request.

## Acknowledgments

- Thanks to the Fedora Project for providing the base Fedora Sericea image.
- Thanks to SwayWM for the Sway tiling window manager.
