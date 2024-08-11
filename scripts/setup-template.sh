#!/bin/bash
#Replace the variables if you need

ID=100
NAME=fcos-template
STORAGE=zfs-intel
CPU=4
RAM=16384
NET_TYPE=virtio
BRIDGE=vmbr0
ADD_STORAGE=112G

/usr/sbin/qm create $ID --name $NAME --cores $CPU --memory $RAM --net0 $NET_TYPE,bridge=$BRIDGE
/usr/sbin/qm importdisk $ID fedora-coreos.qcow2 $STORAGE
/usr/sbin/qm set $ID --scsihw virtio-scsi-pci --scsi0 $STORAGE:vm-$ID-disk-0
/usr/sbin/qm set $ID --boot c --bootdisk scsi0
/usr/sbin/qm resize $ID scsi0 +$ADD_STORAGE
/usr/sbin/qm template $ID
