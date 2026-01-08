Return-Path: <netdev+bounces-248202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DA9D051B5
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6725C3026493
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166113033E0;
	Thu,  8 Jan 2026 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQoLpry0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15BF3033D9;
	Thu,  8 Jan 2026 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893415; cv=none; b=hDDyscSHPHTEweSJVa8qLpet91ShuOPmICeyUXzbkrqoHWVqr/MltAxjJ+dhJkrCLG2jlIwZFcMJvHJXtHqa+pSy/j9X9IOzRfqUROq+2QfIXCl0ZZArWZzpnH7mu9/+lN6veNld3yNect3wI/owc4YlCaKQ2/oDONcEsaa84t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893415; c=relaxed/simple;
	bh=yHdkx9eYOLp6BAehDNFPQTbutOeyvc51maBBYFUx758=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qILDSXfyf8afW0M8U5sf83v6rNhxlEDOof7kaL0+fxNZn6xeIfESWeOE90GhbkZcNXIwjCcZ79uPZ7so9n55r020qzP2uA9w54ouUrBIFZewvW2+F8jCEpriVR/BzvGsEH9OHQ3wYDB+RtWbcQMNhoMMpb9sPsmmW5q6nJmFShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQoLpry0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32508C116C6;
	Thu,  8 Jan 2026 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767893414;
	bh=yHdkx9eYOLp6BAehDNFPQTbutOeyvc51maBBYFUx758=;
	h=From:To:Cc:Subject:Date:From;
	b=CQoLpry0ubatULnTIv8iJqwK7GZP1Zo3Gd3Q1zG/QbY5xSbXnEv+H1ZfcEUe7XaRZ
	 5+BnxSd88mQLp4ZYMqRQUnm55Y2Tq1Cg+doJklTMMu0jYYoQy7OB+lJFjCdBF4wxGw
	 UzLL0Kde4dE/l75DYJ43Am+vIUJwNGijJFCKK6SQR4GdAko87MV0ye/gnW295dO6zH
	 blizCoKQQdg9bfS2EULKh5ToX04C39SSVnmMKTqdoGC20MBQDeyIH+TMNfivQBnSVM
	 QjQQXJwJTNFKil8uVX+hEGrXNEo9u4KywTHCPBXueySl5UWoYq5bgkup2dHUGyvGTO
	 OcGnt5RTe5JyA==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.19-rc5
Date: Thu,  8 Jan 2026 09:30:13 -0800
Message-ID: <20260108173013.2849487-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit dbf8fe85a16a33d6b6bd01f2bc606fc017771465:

  Merge tag 'net-6.19-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-12-30 08:45:58 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.19-rc5

for you to fetch changes up to c92510f5e3f82ba11c95991824a41e59a9c5ed81:

  arp: do not assume dev_hard_header() does not change skb->head (2026-01-08 09:04:24 -0800)

----------------------------------------------------------------
Including fixes from netfilter and wireless.

Current release - fix to a fix:

 - net: do not write to msg_get_inq in callee

 - arp: do not assume dev_hard_header() does not change skb->head

Current release - regressions:

 - wifi: mac80211: don't iterate not running interfaces

 - eth: mlx5: fix NULL pointer dereference in ioctl module EEPROM

Current release - new code bugs:

 - eth: bnge: add AUXILIARY_BUS to Kconfig dependencies

Previous releases - regressions:

 - eth: mlx5: dealloc forgotten PSP RX modify header

Previous releases - always broken:

 - ping: fix ICMP out SNMP stats double-counting with ICMP sockets

 - bonding: preserve NETIF_F_ALL_FOR_ALL across TSO updates

 - bridge: fix C-VLAN preservation in 802.1ad vlan_tunnel egress

 - eth: bnxt: fix potential data corruption with HW GRO/LRO

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexandre Knecht (1):
      bridge: fix C-VLAN preservation in 802.1ad vlan_tunnel egress

Alexei Lazar (1):
      net/mlx5e: Don't gate FEC histograms on ppcnt_statistical_group

Alok Tiwari (1):
      net: marvell: prestera: fix NULL dereference on devlink_alloc() failure

Ankit Khushwaha (1):
      selftests: mptcp: Mark xerror and die_perror __noreturn

Baochen Qiang (1):
      wifi: mac80211: collect station statistics earlier when disconnect

Benjamin Berg (2):
      wifi: mac80211_hwsim: fix typo in frequency notification
      wifi: mac80211_hwsim: disable BHs for hwsim_radio_lock

Breno Leitao (1):
      bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable during error cleanup

Cosmin Ratiu (1):
      net/mlx5e: Dealloc forgotten PSP RX modify header

Daniel Gomez (1):
      netfilter: replace -EEXIST with -EBUSY

Di Zhu (1):
      netdev: preserve NETIF_F_ALL_FOR_ALL across TSO updates

Emil Tantilov (5):
      idpf: keep the netdev when a reset fails
      idpf: detach and close netdevs while handling a reset
      idpf: fix memory leak in idpf_vport_rel()
      idpf: fix memory leak in idpf_vc_core_deinit()
      idpf: fix error handling in the init_task on load

Eric Dumazet (3):
      udp: call skb_orphan() before skb_attempt_defer_free()
      wifi: avoid kernel-infoleak from struct iw_point
      arp: do not assume dev_hard_header() does not change skb->head

Erik Gabriel Carrillo (1):
      idpf: fix issue with ethtool -n command display

Fernando Fernandez Mancera (2):
      netfilter: nft_synproxy: avoid possible data-race on update operation
      netfilter: nf_conncount: update last_gc only when GC has been performed

Florian Westphal (3):
      netfilter: nft_set_pipapo: fix range overlap detection
      selftests: netfilter: nft_concat_range.sh: add check for overlap detection bug
      inet: frags: drop fraglist conntrack references

Frank Liang (1):
      net/ena: fix missing lock when update devlink params

Gal Pressman (3):
      net/mlx5e: Fix NULL pointer dereference in ioctl module EEPROM query
      net/mlx5e: Don't print error message due to invalid module
      selftests: drv-net: Bring back tool() to driver __init__s

Jakub Kicinski (9):
      Merge branch 'mlx5-misc-fixes-2025-12-25'
      Merge tag 'nf-26-01-02' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'vsock-fix-so_zerocopy-on-accept-ed-vsocks'
      Merge branch 'net-sched-fix-memory-leak-on-mirred-loop'
      netlink: specs: netdev: clarify the page pool API a little
      Merge branch 'net-netdevsim-fix-inconsistent-carrier-state-after-link-unlink'
      tools: ynl: don't install tests
      Merge tag 'wireless-2026-01-08' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Jamal Hadi Salim (1):
      net/sched: act_mirred: Fix leak when redirecting to self on egress

Jerry Wu (1):
      net: mscc: ocelot: Fix crash when adding interface under a lag

Johannes Berg (1):
      wifi: mac80211: restore non-chanctx injection behaviour

Joshua Hay (1):
      idpf: cap maximum Rx buffer size

Justin Iurman (1):
      MAINTAINERS: Update email address for Justin Iurman

Kommula Shiva Shankar (1):
      virtio_net: fix device mismatch in devm_kzalloc/devm_kfree

Larysa Zaremba (1):
      idpf: fix aux device unplugging when rdma is not supported by vport

Lorenzo Bianconi (2):
      net: airoha: Fix npu rx DMA definitions
      net: airoha: Fix schedule while atomic in airoha_ppe_deinit()

Markus Blöchl (1):
      net: bnge: add AUXILIARY_BUS to Kconfig dependencies

Maxime Chevallier (1):
      net: sfp: return the number of written bytes for smbus single byte access

Michal Luczaj (2):
      vsock: Make accept()ed sockets use custom setsockopt()
      vsock/test: Test setting SO_ZEROCOPY on accept()ed socket

Miri Korenblit (1):
      wifi: mac80211: don't iterate not running interfaces

Mohammad Heib (1):
      net: fix memory leak in skb_segment_list for GRO packets

Patrisious Haddad (1):
      net/mlx5: Lag, multipath, give priority for routes with smaller network prefix

Petko Manolov (1):
      net: usb: pegasus: fix memory leak in update_eth_regs_async()

Shivani Gupta (1):
      net/sched: act_api: avoid dereferencing ERR_PTR in tcf_idrinfo_destroy

Shyam Sundar S K (1):
      MAINTAINERS: Add an additional maintainer to the AMD XGBE driver

Sreedevi Joshi (5):
      idpf: fix memory leak of flow steer list on rmmod
      idpf: Fix RSS LUT NULL pointer crash on early ethtool operations
      idpf: Fix RSS LUT configuration on down interfaces
      idpf: Fix RSS LUT NULL ptr issue after soft reset
      idpf: Fix error handling in idpf_vport_open()

Srijit Bose (1):
      bnxt_en: Fix potential data corruption with HW GRO/LRO

Stefano Radaelli (1):
      net: phy: mxl-86110: Add power management and soft reset support

Thomas Fourier (2):
      net: 3com: 3c59x: fix possible null dereference in vortex_probe1()
      atm: Fix dma_free_coherent() size

Victor Nogueira (1):
      selftests/tc-testing: Add test case redirecting to self on egress

Vladimir Oltean (1):
      Revert "dsa: mv88e6xxx: make serdes SGMII/Fiber tx amplitude configurable"

Wei Fang (1):
      net: enetc: fix build warning when PAGE_SIZE is greater than 128K

Weiming Shi (1):
      net: sock: fix hardened usercopy panic in sock_recv_errqueue

Willem de Bruijn (1):
      net: do not write to msg_get_inq in callee

Xiang Mei (1):
      net/sched: sch_qfq: Fix NULL deref when deactivating inactive aggregate in qfq_reset

Yohei Kojima (2):
      net: netdevsim: fix inconsistent carrier state after link/unlink
      selftests: netdevsim: add carrier state consistency test

Zilin Guan (2):
      netfilter: nf_tables: fix memory leak in nf_tables_newrule()
      net: wwan: iosm: Fix memory leak in ipc_mux_deinit()

yuan.gao (1):
      inet: ping: Fix icmp out counting

 .mailmap                                           |   1 +
 Documentation/netlink/specs/netdev.yaml            |   6 +-
 MAINTAINERS                                        |   3 +-
 drivers/atm/he.c                                   |   3 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  23 --
 drivers/net/dsa/mv88e6xxx/chip.h                   |   4 -
 drivers/net/dsa/mv88e6xxx/serdes.c                 |  46 ----
 drivers/net/dsa/mv88e6xxx/serdes.h                 |   5 -
 drivers/net/ethernet/3com/3c59x.c                  |   2 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |   9 +-
 drivers/net/ethernet/amazon/ena/ena_devlink.c      |   4 +
 drivers/net/ethernet/broadcom/Kconfig              |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  21 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   4 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |   4 +-
 drivers/net/ethernet/intel/idpf/idpf.h             |   7 +-
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |  92 ++++---
 drivers/net/ethernet/intel/idpf/idpf_idc.c         |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         | 274 ++++++++++++---------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |  46 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |  13 +-
 .../ethernet/marvell/prestera/prestera_devlink.c   |   2 +
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c |  14 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c   |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |   9 +-
 drivers/net/ethernet/mscc/ocelot.c                 |   6 +-
 drivers/net/netdevsim/bus.c                        |   8 +
 drivers/net/phy/mxl-86110.c                        |   3 +
 drivers/net/phy/sfp.c                              |   2 +-
 drivers/net/usb/pegasus.c                          |   2 +
 drivers/net/virtio_net.c                           |   6 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   6 +-
 drivers/net/wwan/iosm/iosm_ipc_mux.c               |   6 +
 include/linux/netdevice.h                          |   3 +-
 include/linux/soc/airoha/airoha_offload.h          |   8 +-
 net/bridge/br_vlan_tunnel.c                        |  11 +-
 net/bridge/netfilter/ebtables.c                    |   2 +-
 net/core/skbuff.c                                  |   8 +-
 net/core/sock.c                                    |   7 +-
 net/ipv4/arp.c                                     |   7 +-
 net/ipv4/inet_fragment.c                           |   2 +
 net/ipv4/ping.c                                    |   4 +-
 net/ipv4/tcp.c                                     |   8 +-
 net/ipv4/udp.c                                     |   1 +
 net/mac80211/chan.c                                |   3 +
 net/mac80211/sta_info.c                            |   7 +-
 net/mac80211/tx.c                                  |   2 +
 net/netfilter/nf_conncount.c                       |   2 +-
 net/netfilter/nf_log.c                             |   4 +-
 net/netfilter/nf_tables_api.c                      |   3 +-
 net/netfilter/nft_set_pipapo.c                     |   4 +-
 net/netfilter/nft_synproxy.c                       |   6 +-
 net/netfilter/x_tables.c                           |   2 +-
 net/sched/act_api.c                                |   2 +
 net/sched/act_mirred.c                             |  26 +-
 net/sched/sch_qfq.c                                |   2 +-
 net/unix/af_unix.c                                 |   8 +-
 net/vmw_vsock/af_vsock.c                           |   4 +
 net/wireless/wext-core.c                           |   4 +
 net/wireless/wext-priv.c                           |   4 +
 tools/net/ynl/Makefile                             |   1 -
 .../selftests/drivers/net/hw/lib/py/__init__.py    |   4 +-
 .../selftests/drivers/net/netdevsim/peer.sh        |  59 +++++
 tools/testing/selftests/net/lib/py/__init__.py     |   4 +-
 tools/testing/selftests/net/mptcp/Makefile         |   1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |   3 +-
 tools/testing/selftests/net/mptcp/mptcp_diag.c     |   3 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c      |   5 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c  |   5 +-
 .../selftests/net/netfilter/nft_concat_range.sh    |  45 +++-
 .../tc-testing/tc-tests/actions/mirred.json        |  47 ++++
 tools/testing/vsock/vsock_test.c                   |  32 +++
 74 files changed, 638 insertions(+), 373 deletions(-)

