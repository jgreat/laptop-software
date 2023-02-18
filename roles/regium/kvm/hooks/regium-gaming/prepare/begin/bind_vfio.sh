#!/bin/bash

## Load the config file
source "/etc/libvirt/hooks/kvm.conf"

## Unload nvidia
modprobe -r nvidia_drm
modprobe -r nvidia_uvm
modprobe -r nvidia_modeset

## Load vfio
modprobe vfio
modprobe vfio_iommu_type1
modprobe vfio_pci

## Unbind gpu from nvidia and bind to vfio
virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO
## Unbind USB controller
virsh nodedev-detach $VIRSH_USB
