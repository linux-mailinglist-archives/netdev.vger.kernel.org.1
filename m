Return-Path: <netdev+bounces-120633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F42395A0E8
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80EC6B21227
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B20136348;
	Wed, 21 Aug 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1GGnuJt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309F84E1C;
	Wed, 21 Aug 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252827; cv=none; b=UcSBoV8DdNUgvuQGx1cH475Oqvk5l7W3BXMWfTT5ipKSVs8zAXi4tHagy7b0Q38z8K3aNcF263W0yaHBxYb3xnRY1dQS2uHeXDJH3GB3oHlWWmadTIklpJwXH31tQjgcv86GfFaiu47xQa/C7xmaaQ9YKmtrNAO8xQVoYBXDt8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252827; c=relaxed/simple;
	bh=x+WoOn6PC6SQ9Q/BAgJI5en/94dawkxansxzliMTw4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKzuWlJW8uslAUvqcsSSB+rs8e4FOvu5hAIby2LoTaoL0Ip6cJX/qNLVY7aUyrPwh/hb9sOcZlYNFxp4mMiHmVrmK7z3bVFvcGUkiCEjj59d5siOx1lH5crDMqbr287hCPFs22PZkgz5cc0LS7YQeQP/MCKJdA5CnCuoZ9m8PHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1GGnuJt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724252826; x=1755788826;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x+WoOn6PC6SQ9Q/BAgJI5en/94dawkxansxzliMTw4M=;
  b=Q1GGnuJtUGoskpzEbs9uX4lRKHPFtcsXtIm6Jo5pMN1J1+J5FuF3SPz1
   PqSnB5WpoSbMVJ1LuCVnR6HiD5APS5FrOc9KHhgev947ReGvplQsiUttb
   YnyvpwDu6GI1lJZ/2UV+dj/GnLYjUo1vgtlAa9K74Sy8ij2+vK7pC2OOr
   2crl/CESwpXirbdBTbshhCwacYAS2yf0x+a8iSi0Lgx8bwrY2RAnPj9iy
   qTzLpYACsjtrhfXElg2ekoq7uF2dckiBAnvmGlp26ru8p5Fi2z2TYVqGG
   M+2+gpqfhdS2/AA6y4BkTOFMw1eLG7TY1xtdYKAja6DdSo42WjMifzx4K
   Q==;
X-CSE-ConnectionGUID: +ysTcH6/RkqIicawi9ihXA==
X-CSE-MsgGUID: X5ohaiAER/OxFTJhD3tfMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22769193"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22769193"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:07:05 -0700
X-CSE-ConnectionGUID: PeZTTbiPTfCQ/0z7Wh7opA==
X-CSE-MsgGUID: Doejf1WtS32M3hDVk2nb0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="84291245"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2024 08:07:02 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/6] netdev_features: start cleaning netdev_features_t up
Date: Wed, 21 Aug 2024 17:06:54 +0200
Message-ID: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETDEV_FEATURE_COUNT is currently 64, which means we can't add any new
features as netdev_features_t is u64.
As per several discussions, instead of converting netdev_features_t to
a bitmap, which would mean A LOT of changes, we can try cleaning up
netdev feature bits.
There's a bunch of bits which don't really mean features, rather device
attributes/properties that can't be changed via Ethtool in any of the
drivers. Such attributes can be moved to netdev private flags without
losing any functionality.

Start converting some read-only netdev features to private flags from
the ones that are most obvious, like lockless Tx, inability to change
network namespace etc. I was able to reduce NETDEV_FEATURE_COUNT from
64 to 60, which mean 4 free slots for new features. There are obviously
more read-only features to convert, such as highDMA, "challenged VLAN",
HSR (4 bits) - this will be done in subsequent series.
Please note that netdev features are not uAPI/ABI by any means. Ethtool
passes their names and bits to the userspace separately and there are no
hardcoded names/bits in the userspace, so that new Ethtool could work
on older kernels and vice versa. Even shell scripts won't most likely
break since the removed bits were always read-only, meaning nobody would
try touching them from a script.

Alexander Lobakin (6):
  netdevice: convert private flags > BIT(31) to bitfields
  netdev_features: remove unused __UNUSED_NETIF_F_1
  netdev_features: convert NETIF_F_LLTX to dev->lltx
  netdev_features: convert NETIF_F_NETNS_LOCAL to dev->netns_local
  netdev_features: convert NETIF_F_FCOE_MTU to dev->fcoe_mtu
  netdev_features: remove NETIF_F_ALL_FCOE

 .../networking/net_cachelines/net_device.rst  |  7 +++-
 Documentation/networking/netdev-features.rst  | 15 -------
 Documentation/networking/netdevices.rst       |  4 +-
 Documentation/networking/switchdev.rst        |  4 +-
 drivers/net/ethernet/tehuti/tehuti.h          |  2 +-
 include/linux/netdev_features.h               | 14 +------
 include/linux/netdevice.h                     | 42 +++++++++++++------
 drivers/net/amt.c                             |  4 +-
 drivers/net/bareudp.c                         |  2 +-
 drivers/net/bonding/bond_main.c               |  8 ++--
 drivers/net/dummy.c                           |  3 +-
 drivers/net/ethernet/adi/adin1110.c           |  2 +-
 drivers/net/ethernet/chelsio/cxgb/cxgb2.c     |  3 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c   |  6 +--
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |  3 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 ++---
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  4 +-
 .../ethernet/marvell/prestera/prestera_main.c |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  3 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  6 ++-
 .../ethernet/microchip/lan966x/lan966x_main.c |  2 +-
 .../net/ethernet/netronome/nfp/nfp_net_repr.c |  3 +-
 drivers/net/ethernet/pasemi/pasemi_mac.c      |  5 ++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |  2 +-
 drivers/net/ethernet/rocker/rocker_main.c     |  3 +-
 drivers/net/ethernet/sfc/ef100_rep.c          |  4 +-
 drivers/net/ethernet/tehuti/tehuti.c          |  4 +-
 drivers/net/ethernet/ti/cpsw_new.c            |  3 +-
 drivers/net/ethernet/toshiba/spider_net.c     |  3 +-
 drivers/net/geneve.c                          |  2 +-
 drivers/net/gtp.c                             |  2 +-
 drivers/net/hamradio/bpqether.c               |  2 +-
 drivers/net/ipvlan/ipvlan_main.c              |  3 +-
 drivers/net/loopback.c                        |  4 +-
 drivers/net/macsec.c                          |  4 +-
 drivers/net/macvlan.c                         |  6 ++-
 drivers/net/net_failover.c                    |  4 +-
 drivers/net/netkit.c                          |  3 +-
 drivers/net/nlmon.c                           |  4 +-
 drivers/net/ppp/ppp_generic.c                 |  2 +-
 drivers/net/rionet.c                          |  2 +-
 drivers/net/team/team_core.c                  |  8 ++--
 drivers/net/tun.c                             |  5 ++-
 drivers/net/veth.c                            |  2 +-
 drivers/net/vrf.c                             |  4 +-
 drivers/net/vsockmon.c                        |  4 +-
 drivers/net/vxlan/vxlan_core.c                |  5 ++-
 drivers/net/wireguard/device.c                |  2 +-
 drivers/scsi/fcoe/fcoe.c                      |  4 +-
 drivers/staging/octeon/ethernet.c             |  2 +-
 lib/test_bpf.c                                |  3 +-
 net/8021q/vlan_dev.c                          | 10 +++--
 net/8021q/vlanproc.c                          |  4 +-
 net/batman-adv/soft-interface.c               |  5 ++-
 net/bridge/br_device.c                        |  6 ++-
 net/core/dev.c                                |  8 ++--
 net/core/dev_ioctl.c                          |  9 ++--
 net/core/net-sysfs.c                          |  3 +-
 net/core/rtnetlink.c                          |  2 +-
 net/dsa/user.c                                |  3 +-
 net/ethtool/common.c                          |  3 --
 net/hsr/hsr_device.c                          | 12 +++---
 net/ieee802154/6lowpan/core.c                 |  2 +-
 net/ieee802154/core.c                         | 10 ++---
 net/ipv4/ip_gre.c                             |  4 +-
 net/ipv4/ip_tunnel.c                          |  2 +-
 net/ipv4/ip_vti.c                             |  2 +-
 net/ipv4/ipip.c                               |  2 +-
 net/ipv4/ipmr.c                               |  2 +-
 net/ipv6/ip6_gre.c                            |  7 ++--
 net/ipv6/ip6_tunnel.c                         |  4 +-
 net/ipv6/ip6mr.c                              |  2 +-
 net/ipv6/sit.c                                |  4 +-
 net/l2tp/l2tp_eth.c                           |  2 +-
 net/openvswitch/vport-internal_dev.c          | 11 ++---
 net/wireless/core.c                           | 10 ++---
 net/xfrm/xfrm_interface_core.c                |  2 +-
 tools/testing/selftests/net/forwarding/README |  2 +-
 83 files changed, 205 insertions(+), 195 deletions(-)

---
From v3[0]:
* 0001: fix kdoc for priv_flags_fast (it doesn't support describing
  struct_groups()s yet) (Jakub);
* 0006: fix subject prefix (make it consistent with the rest).

From v2[1]:
* rebase on top of the latest net-next;
* 0003: don't remove the paragraph saying "LLTX is deprecated for real
  HW drivers" (Willem);
* 0006: new, remove %NETIF_F_ALL_FCOE used only 2 times in 1 file
  (Jakub);
* no functional changes.

From v1[2]:
* split bitfield priv flags into "hot" and "cold", leave the first
  placed where the old ::priv_flags is and move the rest down next
  to ::threaded (Jakub);
* document all the changes in Documentation/networking/net_cachelines/
  net_device.rst;
* #3: remove the "-1 cacheline on Tx" paragraph, not really true (Eric).

From RFC[3]:
* drop:
  * IFF_LOGICAL (as (LLTX | IFF_NO_QUEUE)) - will be discussed later;
  * NETIF_F_HIGHDMA conversion - requires priv flags inheriting etc.,
    maybe later;
  * NETIF_F_VLAN_CHALLENGED conversion - same as above;
* convert existing priv_flags > BIT(31) to bitfield booleans and define
  new flags the same way (Jakub);
* mention a couple times that netdev features are not uAPI/ABI by any
  means (Andrew).

[0] https://lore.kernel.org/netdev/20240808152757.2016725-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/netdev/20240703150342.1435976-1-aleksander.lobakin@intel.com
[2] https://lore.kernel.org/netdev/20240625114432.1398320-1-aleksander.lobakin@intel.com
[3] https://lore.kernel.org/netdev/20240405133731.1010128-1-aleksander.lobakin@intel.com
-- 
2.46.0


