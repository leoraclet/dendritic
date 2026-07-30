# Dendritic

This NixOS configuration follows the [**dendritic pattern**](https://github.com/mightyiam/dendritic).
It also uses **wrappers** to enable direct execution of packages
from the GitHub repository, bundled with their respective configuration.

## Goal

The long-term goal of this configuration is to replace my current [setup](https://github.com/leoraclet/nixos-config)
and provide most of its programs as ready-to-use packages. These packages will
include their configurations and could be launched from anywhere using a single
Nix command.

## Usage

> [!warning]
> This configuration is a work in progress. While some wrapped programs are
> already usable, the overall setup is not yet functional and remains mainly untested.

### Run wrapped programms

To run a wrapped program, start by cloning this repository:

```bash
git clone https://github.com/leoraclet/dendritic
cd dendritic/
```

Then, execute any package using:

```bash
nix run ./#${PACKAGE}  # Replace ${PACKAGE} with one of the exposed outputs in the flake
```

Currently, here are the available wrapped programs / features :

- My Kitty configuration: `nix run ./#kitty`
- My desktop setup with **Niri** and **Noctalia Shell**: `nix run ./#desktop`
- My standalone **Niri** configuration: `nix run ./#niri`

To explore all available outputs, modules, and packages in this flake, use:

```bash
nix flake show
```

### Use config

> [!caution]
> Since I'm still experimenting with this new configuration, there may be errors
> or unexpected behavior. **I do not recommend using it yet** unless you are familiar
> with troubleshooting and prepared to fix issues. For now, these are just
> template/boilerplate commands to test the configuration directly on a
> system or in a VM.

## Libraries

Powered by :

- [nixpkgs](https://github.com/NixOS/nixpkgs/)
- [flake-parts](https://github.com/hercules-ci/flake-parts)
- [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules)
- [import-tree](https://github.com/denful/import-tree)
- [home-manager](https://github.com/nix-community/home-manager)

## References

This configuration took inspirations from :

- [GaetanLepage/nix-config](https://github.com/GaetanLepage/nix-config)
- [voidarc/nixos](https://git.voidarc.co.uk/voidarc/nixos/src/branch/dendritic/)
- [vimjoyer/nixconf](https://github.com/vimjoyer/nixconf)
