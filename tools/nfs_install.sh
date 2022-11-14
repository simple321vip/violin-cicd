#!/bin/bash

################################################################
# ubuntu nfs installation document
# ubuntu linux version: Ubuntu 20.04
# author xiang.wei.guan
################################################################

# PARAMETER SETTINGS
# $1 CLIENT!=1 SERVER=1
# default is client install

# 1. CONSTANT DEFINITION
NFS_COMMON_CONF=/etc/default/nfs-common
NFS_SERVER_CONF=/etc/default/nfs-kernel-server
NFS_SYSCTL_CONF=/etc/sysctl.conf
STATD=31000
MOUNTD=31001
NLOCKMGE=31002

apt-get install nfs-common
mkdir /opt/nfs-volume

# 3. edit nfs-common file
STATDOPTS="\"--port ${STATD}\""
sed -i -e "s:STATDOPTS=.*:STATDOPTS=${STATDOPTS}:g" ${NFS_COMMON_CONF}

# 4. edit nfs-kernel-server file
RPCMOUNTDOPTS="\"--manage-gids -p ${MOUNTD}\""
sed -i -e "s:RPCMOUNTDOPTS=.*:RPCMOUNTDOPTS=${RPCMOUNTDOPTS}:g" ${NFS_SERVER_CONF}

# 5. edit /etc/sysctl.conf
UDPPORT="fs.nfs.nlm_udpport=${NLOCKMGE}"
TCPPORT="fs.nfs.nlm_tcpport=${NLOCKMGE}"
echo ${UDPPORT} >> ${NFS_SYSCTL_CONF}
echo ${TCPPORT} >> ${NFS_SYSCTL_CONF}

# 6. enable sysctl
/sbin/sysctl -p

# 7. restart nfs service
systemctl restart nfs-blkmap.service
systemctl restart nfs-config.service
systemctl restart nfs-idmapd.service
systemctl restart nfs-mountd.service
systemctl restart nfs-utils.service
systemctl restart nfs-server.service
systemctl reload nfs-server

# 8. view port infomation
rpcinfo -p

# 9. mount
mount -t nfs 49.233.4.79:/data/nfs-volume /opt/nfs-volume

# 10. confirm mount status
df -h | tail -1

