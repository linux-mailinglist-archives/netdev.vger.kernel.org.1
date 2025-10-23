Return-Path: <netdev+bounces-232168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3755BC01FDB
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3AC94FC59F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FCD32ED3B;
	Thu, 23 Oct 2025 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+JI8x2S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13E32AAC8;
	Thu, 23 Oct 2025 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231716; cv=none; b=b68XOx19s2sU68Q47HagJkgDBKxr7UZbw8eFlfj6Q8oCaiUuRaj+9Cf0y181L+Mb3V04sFSWexzbpoQqExtIsxB9x0x6LoaMzmp6KpLqz5zWtIGiTZzKUCxO1WSWfZ4PBP4S87zUpJYZa0oe7OLaNzr9YBKv/owX8bDiAkttWhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231716; c=relaxed/simple;
	bh=F2b9gqkX1yV+MACqtaIDs32Jt0xkHc9ac6F1bohNmPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pt6SVjMGTqhvon4DY5FI9nHLEoM2T4vBTB+5OYYXkWhpBgcg81BhyTWgnE5aVWhVCKKwH7tm3z2oReedVRSVHR75qzpE/flrKT7wJIPi6Vah1OijtPHy59n9NpdwiWgH5oz6F2vxxzXqVKCpwrERO/R97hPW8El2+EtNiXt08Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+JI8x2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC41C4CEF7;
	Thu, 23 Oct 2025 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761231716;
	bh=F2b9gqkX1yV+MACqtaIDs32Jt0xkHc9ac6F1bohNmPI=;
	h=From:To:Cc:Subject:Date:From;
	b=O+JI8x2SFECprqxC2CYvlXUbxTLEqKiDsTHOiUcHr2p5cGBWG80baIG2vFCrken+6
	 yAHKmYRpiFlH6i3gntNUf7AYLCR8b536dPRQl4Mavk671yjWLtCAoOMfD1csFLmPhb
	 w45KdA1EkxIBCCZvC+5RU7c82Pp0djfUN1UGSrGgRoRR0MpnFhNhVn8s3hR73l7MsJ
	 C1/S0tvBqB3fiDEuaz/E3HKcophVIesGO7xhK/+98fOVyT5KtwlBwBWnmNi7FwUkkn
	 qD94tMObgZwM5rXVocYXWk5q4CXYXa6EOhUaEwM9Y1T8W9M9LBsSssB2xx+neDme6w
	 9K5LAtNojzyvw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.18-rc3
Date: Thu, 23 Oct 2025 08:01:54 -0700
Message-ID: <20251023150154.1295917-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 634ec1fc7982efeeeeed4a7688b0004827b43a21:

  Merge tag 'net-6.18-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-16 09:41:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.18-rc3

for you to fetch changes up to cb68d1e5c51870601be9394fbb5751fc6532c78e:

  Merge branch 'mlx5-misc-fixes-2025-10-22' (2025-10-23 07:14:39 -0700)

----------------------------------------------------------------
Including fixes from can. Slim pickings, I'm guessing people haven't
really started testing.

Current release - new code bugs:

 - eth: mlx5e:
   - psp: avoid 'accel' NULL pointer dereference
   - skip PPHCR register query for FEC histogram if not supported

Previous releases - regressions:

 - bonding: update the slave array for broadcast mode

 - rtnetlink: re-allow deleting FDB entries in user namespace

 - eth: dpaa2: fix the pointer passed to PTR_ALIGN on Tx path

Previous releases - always broken:

 - can: drop skb on xmit if device is in listen-only mode

 - gro: clear skb_shinfo(skb)->hwtstamps in napi_reuse_skb()

 - eth: mlx5e
   - RX, fix generating skb from non-linear xdp_buff if program
     trims frags
   - make devcom init failures non-fatal, fix races with IPSec

Misc:

 - some documentation formatting "fixes"

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aksh Garg (1):
      net: ethernet: ti: am65-cpts: fix timestamp loss due to race conditions

Aleksander Jan Bajkowski (1):
      net: phy: realtek: fix rtl8221b-vm-cg name

Alexei Lazar (2):
      net/mlx5: Add PPHCR to PCAM supported registers mask
      net/mlx5e: Skip PPHCR register query if not supported by the device

Alexey Simakov (1):
      sctp: avoid NULL dereference when chunk data buffer is missing

Amery Hung (2):
      net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy RQ
      net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for striding RQ

Bagas Sanjaya (2):
      net: rmnet: Fix checksum offload header v5 and aggregation packet formatting
      Documentation: net: net_failover: Separate cloud-ifupdown-helper and reattach-vf.sh code blocks marker

Cosmin Ratiu (1):
      net/mlx5e: psp, avoid 'accel' NULL pointer dereference

Eric Dumazet (2):
      net: gro: clear skb_shinfo(skb)->hwtstamps in napi_reuse_skb()
      net: gro_cells: fix lock imbalance in gro_cells_receive()

Fernando Fernandez Mancera (1):
      net: hsr: prevent creation of HSR device with slaves from another netns

Heiner Kallweit (1):
      net: hibmcge: select FIXED_PHY

Ioana Ciornei (1):
      dpaa2-eth: fix the pointer passed to PTR_ALIGN on Tx path

Jakub Kicinski (5):
      Merge branch 'fix-generating-skb-from-non-linear-xdp_buff-for-mlx5'
      Merge branch 'mptcp-handle-late-add_addr-selftests-skip'
      Merge tag 'linux-can-fixes-for-6.18-20251020' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'net-ravb-fix-soc-specific-configuration-and-descriptor-handling-issues'
      Merge branch 'mlx5-misc-fixes-2025-10-22'

Jason Wang (1):
      virtio-net: zero unused hash fields

Jianpeng Chang (1):
      net: enetc: fix the deadlock of enetc_mdio_lock

Jiasheng Jiang (1):
      ptp: ocp: Fix typo using index 1 instead of i in SMA initialization loop

Johannes Wiesböck (1):
      rtnetlink: Allow deleting FDB entries in user namespace

Lad Prabhakar (2):
      net: ravb: Enforce descriptor type ordering
      net: ravb: Ensure memory write completes before ringing TX doorbell

Marc Kleine-Budde (5):
      can: bxcan: bxcan_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: esd: acc_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      can: rockchip-canfd: rkcanfd_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
      Merge patch series "can: drivers: drop skb in xmit if device is in listen only mode"
      can: netlink: can_changelink(): allow disabling of automatic restart

Matthieu Baerts (NGI0) (5):
      mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
      selftests: mptcp: join: mark 'flush re-add' as skipped if not supported
      selftests: mptcp: join: mark implicit tests as skipped if not supported
      selftests: mptcp: join: mark 'delete re-add signal' as skipped if not supported
      selftests: mptcp: join: mark laminar tests as skipped if not supported

Michal Pecio (1):
      net: usb: rtl8150: Fix frame padding

Nathan Chancellor (1):
      net/mlx5e: Return 1 instead of 0 in invalid case in mlx5e_mpwrq_umr_entry_size()

Paolo Abeni (1):
      Merge branch 'fix-poll-behaviour-for-tcp-based-tunnel-protocols'

Patrisious Haddad (2):
      net/mlx5: Refactor devcom to return NULL on failure
      net/mlx5: Fix IPsec cleanup over MPV device

Ralf Lici (3):
      net: datagram: introduce datagram_poll_queue for custom receive queues
      espintcp: use datagram_poll_queue for socket readiness
      ovpn: use datagram_poll_queue for socket readiness in TCP

Randy Dunlap (1):
      Documentation: networking: ax25: update the mailing list info.

Robert Marko (1):
      net: phy: micrel: always set shared->phydev for LAN8814

Sebastian Reichel (1):
      net: stmmac: dwmac-rk: Fix disabling set_clock_selection

Stefano Garzarella (1):
      vsock: fix lock inversion in vsock_assign_transport()

Tonghao Zhang (2):
      net: bonding: update the slave array for broadcast mode
      net: bonding: fix possible peer notify event loss or dup issue

Wang Liang (1):
      net/smc: fix general protection fault in __smc_diag_dump

Wei Fang (1):
      net: enetc: correct the value of ENETC_RXB_TRUESIZE

Xin Long (1):
      selftests: net: fix server bind failure in sctp_vrf.sh

Yeounsu Moon (1):
      net: dlink: use dev_kfree_skb_any instead of dev_kfree_skb

 Documentation/networking/ax25.rst                  |  7 ++-
 .../device_drivers/cellular/qualcomm/rmnet.rst     | 12 +++-
 Documentation/networking/net_failover.rst          |  6 +-
 drivers/net/bonding/bond_main.c                    | 47 +++++++-------
 drivers/net/can/bxcan.c                            |  2 +-
 drivers/net/can/dev/netlink.c                      |  6 +-
 drivers/net/can/esd/esdacc.c                       |  2 +-
 drivers/net/can/rockchip/rockchip_canfd-tx.c       |  2 +-
 drivers/net/ethernet/dlink/dl2k.c                  |  2 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  3 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       | 25 ++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h       |  2 +-
 drivers/net/ethernet/hisilicon/Kconfig             |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |  2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |  5 ++
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         | 25 +++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  8 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 51 ++++++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |  7 ++-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  7 +--
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   | 53 ++++++++--------
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  5 +-
 drivers/net/ethernet/renesas/ravb_main.c           | 24 ++++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  9 +--
 drivers/net/ethernet/ti/am65-cpts.c                | 63 +++++++++++++------
 drivers/net/ovpn/tcp.c                             | 26 ++++++--
 drivers/net/phy/micrel.c                           |  4 +-
 drivers/net/phy/realtek/realtek_main.c             | 16 ++---
 drivers/net/usb/rtl8150.c                          | 11 +++-
 drivers/ptp/ptp_ocp.c                              |  2 +-
 include/linux/mlx5/mlx5_ifc.h                      |  4 +-
 include/linux/skbuff.h                             |  3 +
 include/linux/virtio_net.h                         |  4 ++
 net/core/datagram.c                                | 44 ++++++++++---
 net/core/gro.c                                     | 10 ++-
 net/core/gro_cells.c                               |  5 +-
 net/core/rtnetlink.c                               |  3 -
 net/hsr/hsr_netlink.c                              |  8 ++-
 net/mptcp/pm_kernel.c                              |  6 ++
 net/sctp/inqueue.c                                 | 13 ++--
 net/smc/smc_inet.c                                 | 13 ----
 net/vmw_vsock/af_vsock.c                           | 38 +++++------
 net/xfrm/espintcp.c                                |  6 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 18 +++---
 tools/testing/selftests/net/sctp_hello.c           | 17 +----
 tools/testing/selftests/net/sctp_vrf.sh            | 73 +++++++++++++---------
 50 files changed, 451 insertions(+), 263 deletions(-)

