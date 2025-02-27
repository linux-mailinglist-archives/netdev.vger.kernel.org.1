Return-Path: <netdev+bounces-170366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9359A485BB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5654176865
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116EE1B3943;
	Thu, 27 Feb 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kexlJpzn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4EB1C36;
	Thu, 27 Feb 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674465; cv=none; b=T8eWMcQKlkD+2airPHmR0dC8K9DWXjqjb66IomtWRnK+GnwHx80OokVv9pNOcmb7t0lpru7oodk5301GQP+lHrFrA5IIogFbT51wZxfvIeAZQ6viRJpMSN28eu9mic4bK8zpotrQef8d7xr1KPDhbpPV1GFJYdo4n5b5w1t+N+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674465; c=relaxed/simple;
	bh=rckz/q7pIYlvVhINqFR0AJWmC2bxmbeg/qRYzgjj9dE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KQtjMAPGEPesvbOD3/eblqoMEL0A/f8bEPdZ/6IUjzALpWNpUPYLeTl1vU/YUM4AIhCaql3/xBlcx7ztui8jF75qhTug6vgxaj9PUin9Dl204QIvH0w+NlAptmJnhxydd1n2nWwXqjYuK5vVwoEmXO8RShw2waTzsyx4XgArnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kexlJpzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21799C4CEE6;
	Thu, 27 Feb 2025 16:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740674464;
	bh=rckz/q7pIYlvVhINqFR0AJWmC2bxmbeg/qRYzgjj9dE=;
	h=From:To:Cc:Subject:Date:From;
	b=kexlJpzn0ctUGzeGuqsLm0k592G2drmX/Im+JqjqA5hOQb/4zK9yUR7+QRp4CV7az
	 AumjowILGk6fPJmM2qaVu7Gu4mmw3N+U8HjSjVisC5yWucqXtu7ombbfzL/7wHOC6i
	 KqXQv763g2Z5Z72iIwEpiGBNpBH2Af648zS9O3w2RUHmhdmtOzdEGzlGlwaISLEmp7
	 8WGLplU/K61o0/29kvkzGKmeb2UD3wROzmnAMn0M9b2oAghH8jL/qzmGIJ5olH3cRc
	 d3H2tyJgW1Lfc3rUZAUqkcydox2XD3JRa6G53CKsqWvLOqxCfnqXhG/Xk+9WURhdBo
	 Kv3Y3WDslCVQQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.14-rc5
Date: Thu, 27 Feb 2025 08:41:03 -0800
Message-ID: <20250227164103.3599252-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

You'll see a prompt for NET_DSA_REALTEK_RTL8366RB_LEDS.
We should probably hide it from the user, and just use the default.
I'm following up with Linus W, but I don't supposed this is a big deal.

The following changes since commit 27eddbf3449026a73d6ed52d55b192bfcf526a03:

  Merge tag 'net-6.14-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-02-20 10:19:54 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.14-rc5

for you to fetch changes up to 54e1b4becf5e220be03db4e1be773c1310e8cbbd:

  net: ti: icss-iep: Reject perout generation request (2025-02-27 08:09:02 -0800)

----------------------------------------------------------------
Including fixes from bluetooth. We didn't get netfilter or wireless PRs
this week, so next week's PR is probably going to be bigger. A healthy
dose of fixes for bugs introduced in the current release nonetheless.

Current release - regressions:

 - Bluetooth: always allow SCO packets for user channel

 - af_unix: fix memory leak in unix_dgram_sendmsg()

 - rxrpc:
   - remove redundant peer->mtu_lock causing lockdep splats
   - fix spinlock flavor issues with the peer record hash

 - eth: iavf: fix circular lock dependency with netdev_lock

 - net: use rtnl_net_dev_lock() in register_netdevice_notifier_dev_net()
   RDMA driver register notifier after the device

Current release - new code bugs:

 - ethtool: fix ioctl confusing drivers about desired HDS user config

 - eth: ixgbe: fix media cage present detection for E610 device

Previous releases - regressions:

 - loopback: avoid sending IP packets without an Ethernet header

 - mptcp: reset connection when MPTCP opts are dropped after join

Previous releases - always broken:

 - net: better track kernel sockets lifetime

 - ipv6: fix dst ref loop on input in seg6 and rpl lw tunnels

 - phy: qca807x: use right value from DTS for DAC_DSP_BIAS_CURRENT

 - eth: enetc: number of error handling fixes

 - dsa: rtl8366rb: reshuffle the code to fix config / build issue
   with LED support

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Adrian Huang (1):
      af_unix: Fix memory leak in unix_dgram_sendmsg()

Carolina Jubran (2):
      net/mlx5: Fix vport QoS cleanup on error
      net/mlx5: Restore missing trace event when enabling vport QoS

David Howells (5):
      rxrpc: rxperf: Fix missing decoding of terminal magic cookie
      rxrpc: peer->mtu_lock is redundant
      rxrpc: Fix locking issues with the peer record hash
      afs: Fix the server_list to unuse a displaced server rather than putting it
      afs: Give an afs_server object a ref on the afs_cell object it points to

Eric Dumazet (3):
      net: better track kernel sockets lifetime
      ipvlan: ensure network headers are in skb linear part
      idpf: fix checksums set in idpf_rx_rsc()

Frederic Weisbecker (1):
      net: Handle napi_schedule() calls from non-interrupt

George Moussalem (1):
      net: phy: qcom: qca807x fix condition for DAC_DSP_BIAS_CURRENT

Harshal Chaudhari (1):
      net: mvpp2: cls: Fixed Non IP flow, with vlan tag flow defination.

Harshitha Ramamurthy (1):
      gve: unlink old napi when stopping a queue using queue API

Hsin-chen Chuang (1):
      Bluetooth: Always allow SCO packets for user channel

Ido Schimmel (1):
      net: loopback: Avoid sending IP packets without an Ethernet header

Jacob Keller (1):
      iavf: fix circular lock dependency with netdev_lock

Jakub Kicinski (9):
      Merge branch 'rxrpc-afs-miscellaneous-fixes'
      Merge tag 'for-net-2025-02-21' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      MAINTAINERS: fix DWMAC S32 entry
      net: ethtool: fix ioctl confusing drivers about desired HDS user config
      selftests: drv-net: test XDP, HDS auto and the ioctl path
      Merge branch 'mptcp-misc-fixes'
      Merge branch 'intel-wired-lan-driver-updates-2025-02-24-ice-idpf-iavf-ixgbe'
      Merge branch 'net-enetc-fix-some-known-issues'
      Merge branch 'mlx5-misc-fixes-2025-02-25'

Jiri Slaby (SUSE) (1):
      net: set the minimum for net_hotdata.netdev_budget_usecs

Joe Damato (1):
      selftests: drv-net: Check if combined-count exists

Justin Iurman (2):
      net: ipv6: fix dst ref loop on input in seg6 lwt
      net: ipv6: fix dst ref loop on input in rpl lwt

Kuniyuki Iwashima (1):
      net: Use rtnl_net_dev_lock() in register_netdevice_notifier_dev_net().

Linus Walleij (1):
      net: dsa: rtl8366rb: Fix compilation problem

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response

Marcin Szycik (2):
      ice: Fix deinitializing VF in error path
      ice: Avoid setting default Rx VSI twice in switchdev setup

Matthieu Baerts (NGI0) (2):
      mptcp: reset when MPTCP opts are dropped after join
      mptcp: safety check before fallback

Meghana Malladi (1):
      net: ti: icss-iep: Reject perout generation request

Mohammad Heib (1):
      net: Clear old fragment checksum value in napi_reuse_skb

Nikita Zhandarovich (1):
      usbnet: gl620a: fix endpoint checking in genelink_bind()

Paolo Abeni (2):
      mptcp: always handle address removal under msk socket lock
      Merge branch 'fixes-for-seg6-and-rpl-lwtunnels-on-input'

Philo Lu (1):
      ipvs: Always clear ipvs_property flag in skb_scrub_packet()

Piotr Kwapulinski (1):
      ixgbe: fix media cage present detection for E610 device

Qunqin Zhao (1):
      net: stmmac: dwmac-loongson: Add fix_soc_reset() callback

Sascha Hauer (1):
      net: ethernet: ti: am65-cpsw: select PAGE_POOL

Sean Anderson (1):
      net: cadence: macb: Synchronize stats calculations

Shay Drory (1):
      net/mlx5: IRQ, Fix null string in debug print

Stanislav Fomichev (1):
      tcp: devmem: don't write truncated dmabuf CMSGs to userspace

Wang Hai (1):
      tcp: Defer ts_recent changes until req is owned

Wei Fang (8):
      net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()
      net: enetc: keep track of correct Tx BD count in enetc_map_tx_tso_buffs()
      net: enetc: correct the xdp_tx statistics
      net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC
      net: enetc: update UDP checksum when updating originTimestamp field
      net: enetc: add missing enetc4_link_deinit()
      net: enetc: remove the mm_lock from the ENETC v4 driver
      net: enetc: fix the off-by-one issue in enetc_map_tx_tso_buffs()

Willem de Bruijn (1):
      MAINTAINERS: socket timestamping: add Jason Xing as reviewer

 MAINTAINERS                                        |   5 +-
 drivers/bluetooth/btusb.c                          |   6 +-
 drivers/net/dsa/realtek/Kconfig                    |   6 +
 drivers/net/dsa/realtek/Makefile                   |   3 +
 drivers/net/dsa/realtek/rtl8366rb-leds.c           | 177 ++++++++++++++
 drivers/net/dsa/realtek/rtl8366rb.c                | 258 +--------------------
 drivers/net/dsa/realtek/rtl8366rb.h                | 107 +++++++++
 drivers/net/ethernet/cadence/macb.h                |   2 +
 drivers/net/ethernet/cadence/macb_main.c           |  12 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       | 103 +++++---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c   |   2 +-
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |   7 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |   2 +
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  12 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |   3 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |   5 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |   8 +
 .../net/ethernet/intel/ice/ice_vf_lib_private.h    |   1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      |   2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c     |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  14 ++
 drivers/net/ethernet/ti/Kconfig                    |   1 +
 drivers/net/ethernet/ti/icssg/icss_iep.c           |  21 +-
 drivers/net/ipvlan/ipvlan_core.c                   |  21 +-
 drivers/net/loopback.c                             |  14 ++
 drivers/net/netdevsim/ethtool.c                    |   2 +
 drivers/net/phy/qcom/qca807x.c                     |   2 +-
 drivers/net/usb/gl620a.c                           |   4 +-
 fs/afs/server.c                                    |   3 +
 fs/afs/server_list.c                               |   4 +-
 include/linux/socket.h                             |   2 +
 include/net/sock.h                                 |   1 +
 include/trace/events/afs.h                         |   2 +
 net/bluetooth/l2cap_core.c                         |   9 +-
 net/core/dev.c                                     |  14 +-
 net/core/gro.c                                     |   1 +
 net/core/scm.c                                     |  10 +
 net/core/skbuff.c                                  |   2 +-
 net/core/sock.c                                    |  27 ++-
 net/core/sysctl_net_core.c                         |   3 +-
 net/ethtool/common.c                               |  16 ++
 net/ethtool/common.h                               |   6 +
 net/ethtool/ioctl.c                                |   4 +-
 net/ethtool/rings.c                                |   9 +-
 net/ipv4/tcp.c                                     |  26 +--
 net/ipv4/tcp_minisocks.c                           |  10 +-
 net/ipv6/rpl_iptunnel.c                            |  14 +-
 net/ipv6/seg6_iptunnel.c                           |  14 +-
 net/mptcp/pm_netlink.c                             |   5 -
 net/mptcp/protocol.h                               |   2 +
 net/mptcp/subflow.c                                |  20 +-
 net/netlink/af_netlink.c                           |  10 -
 net/rds/tcp.c                                      |   8 +-
 net/rxrpc/ar-internal.h                            |   1 -
 net/rxrpc/input.c                                  |   2 -
 net/rxrpc/peer_event.c                             |   9 +-
 net/rxrpc/peer_object.c                            |   5 +-
 net/rxrpc/rxperf.c                                 |  12 +
 net/smc/af_smc.c                                   |   5 +-
 net/sunrpc/svcsock.c                               |   5 +-
 net/sunrpc/xprtsock.c                              |   8 +-
 net/unix/af_unix.c                                 |   1 +
 tools/testing/selftests/drivers/net/hds.py         | 145 +++++++++++-
 tools/testing/selftests/drivers/net/queues.py      |   7 +-
 tools/testing/selftests/net/lib/Makefile           |   3 +
 tools/testing/selftests/net/lib/xdp_dummy.bpf.c    |  13 ++
 69 files changed, 792 insertions(+), 461 deletions(-)
 create mode 100644 drivers/net/dsa/realtek/rtl8366rb-leds.c
 create mode 100644 drivers/net/dsa/realtek/rtl8366rb.h
 create mode 100644 tools/testing/selftests/net/lib/xdp_dummy.bpf.c

