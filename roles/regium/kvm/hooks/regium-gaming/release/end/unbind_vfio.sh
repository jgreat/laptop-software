#!/bin/bash

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

## Unbind gpu from vfio and bind to nvidia
virsh nodedev-reattach $VIRSH_GPU_VIDEO
virsh nodedev-reattach $VIRSH_GPU_AUDIO
## Unbind USB hub from vfio
virsh nodedev-reattach $VIRSH_USB

## Unload vfio
modprobe -r vfio_pci
modprobe -r vfio_iommu_type1
modprobe -r vfio

## Load nvidia
modprobe nvidia_modeset
modprobe nvidia_uvm
modprobe nvidia_drm
