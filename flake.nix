{
  description = "Hyades VM Generators";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-generators, ... }: {
    packages.x86_64-linux = {
      controller = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          (nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")
          ./configurations/controller.nix
        ];
        format = "qcow";
      };
      worker = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          (nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")
          ./configurations/worker.nix
        ];
        format = "qcow";
      };
    };
  };
}
