#!/bin/sh

nix build ".#controller"
cp -v result/nixos.qcow2 images/controller.qcow2
nix build ".#worker"
cp -v result/nixos.qcow2 images/worker.qcow2
