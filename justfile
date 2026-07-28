default:
    @just --list

run:
    nix build ./#nixosConfigurations.vm.config.system.build.vm
    QEMU_NET_OPTS="hostfwd=tcp::2222-:22" ./result/bin/run-nixos-vm

clean:
    rm -rf ./nixos.qcow2
    rm -rf ./result/
