Return-Path: <netdev+bounces-183841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF191A92349
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40DD17B276B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3E31D86D6;
	Thu, 17 Apr 2025 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnO/thSu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67484186E2E;
	Thu, 17 Apr 2025 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909261; cv=none; b=rqe31+pJnr9PulxKPFkSog9Lpo8HwMtsgabdSb0nRBgrdG0y6Jj5iydOu5gE+fI4XJRCOgb3S8Y9J5K9dvPnvs+LomuQV3P6lr1BExfVGWFIx4foAJZzo4fW0mF1VF6hNBXsDQ/uGLfC3GAspE81ZFkVMxj0RbH66lHV0locbY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909261; c=relaxed/simple;
	bh=yki21CE/K9OnkYZd8bEGLviArYgHVfjnuMBHqgrosSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mWA6F2jwdNc43SStR8uQ7NIZPYTrFQTiDTNGEEfrU3C8FGyeZZ+WM4roT5t73xSlKrsYOUR9qPjCX4hAcHDKd5j7v+V9lp2gvz6upWSJfPsriqpria76lcFSKAogyaHEExpcwzNML8V3Zp98d5IR45b7hoyQMMEP4aZssLSsGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnO/thSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89140C4CEE4;
	Thu, 17 Apr 2025 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744909260;
	bh=yki21CE/K9OnkYZd8bEGLviArYgHVfjnuMBHqgrosSA=;
	h=From:To:Cc:Subject:Date:From;
	b=EnO/thSuyOYRJhXJK64cTvTJQvIIgQUL3qBrEc2z37XkakUizRHvWWj3/iPlJGXpR
	 JZ03BVoqvtkpnSE40bWxRB0VXmRqJdZhQYQ2CEyk2jqz5+QCKFJyXGAxUzCa1EtECs
	 vSj6482XNMN9Y3W9cZOSGmZC37vQy4rqAFYuaBVIJxm9A7OmWYHgrPKXkLjGHDXQ5z
	 jL0HVMdA1id1zkuVu1LDPrFcJOZaDQde8A9kJaBYplXxiaxEpCOyRTnaKHumhARxUQ
	 82hwy+uW3Ez5KScLH55dEbITRPep1j3u+FnIJfTo3G8k9fdVsqPmqJ0AWcoa1YsXVJ
	 ooqRyKhj0IFTw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.15-rc3
Date: Thu, 17 Apr 2025 10:00:59 -0700
Message-ID: <20250417170059.4012070-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit ab59a8605604f71bbbc16077270dc3f39648b7fc:

  Merge tag 'net-6.15-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-04-10 08:52:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc3

for you to fetch changes up to 1b66124135f5f8640bd540fadda4b20cdd23114b:

  net: ethernet: mtk_eth_soc: revise QDMA packet scheduler settings (2025-04-17 08:13:41 -0700)

----------------------------------------------------------------
Including fixes from Bluetooth, CAN and Netfilter.

Current release - regressions:

 - 2 fixes for the netdev per-instance locking

 - batman-adv: fix double-hold of meshif when getting enabled

Current release - new code bugs:

 - Bluetooth: increment TX timestamping tskey always for stream sockets

 - wifi: static analysis and build fixes for the new Intel sub-driver

Previous releases - regressions:

 - net: fib_rules: fix iif / oif matching on L3 master (VRF) device

 - ipv6: add exception routes to GC list in rt6_insert_exception()

 - netfilter: conntrack: fix erroneous removal of offload bit

 - Bluetooth:
  - fix sending MGMT_EV_DEVICE_FOUND for invalid address
  - l2cap: process valid commands in too long frame
  - btnxpuart: Revert baudrate change in nxp_shutdown

Previous releases - always broken:

 - ethtool: fix memory corruption during SFP FW flashing

 - eth: hibmcge: fixes for link and MTU handling, pause frames etc.

 - eth: igc: fixes for PTM (PCIe timestamping)

 - dsa: b53: enable BPDU reception for management port

Misc:

 - fixes for Netlink protocol schemas

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Abdun Nihaal (7):
      wifi: at76c50x: fix use after free access in at76_disconnect
      wifi: brcmfmac: fix memory leak in brcmf_get_module_param
      wifi: wl1251: fix memory leak in wl1251_tx_work
      pds_core: fix memory leak in pdsc_debugfs_add_qcq()
      net: ngbe: fix memory leak in ngbe_probe() error path
      cxgb4: fix memory leak in cxgb4_init_ethtool_filters() error path
      net: txgbe: fix memory leak in txgbe_probe() error path

Arnd Bergmann (1):
      iwlwifi: mld: fix building with CONFIG_PM_SLEEP disabled

Bo-Cun Chen (3):
      net: ethernet: mtk_eth_soc: reapply mdc divider on reset
      net: ethernet: mtk_eth_soc: correct the max weight of the queue limit for 100Mbps
      net: ethernet: mtk_eth_soc: revise QDMA packet scheduler settings

Chenyuan Yang (1):
      octeontx2-pf: handle otx2_mbox_get_rsp errors

Christopher S M Hall (6):
      igc: fix PTM cycle trigger logic
      igc: increase wait time before retrying PTM
      igc: move ktime snapshot into PTM retry loop
      igc: handle the IGC_PTP_ENABLED flag correctly
      igc: cleanup PTP module if probe fails
      igc: add lock preventing multiple simultaneous PTM transactions

Damodharam Ammepalli (1):
      ethtool: cmis_cdb: use correct rpl size in ethtool_cmis_module_poll()

Dan Carpenter (2):
      wifi: iwlwifi: mld: silence uninitialized variable warning
      Bluetooth: btrtl: Prevent potential NULL dereference

David Wei (1):
      io_uring/zcrx: enable tcp-data-split in selftest

Davide Caratti (1):
      can: fix missing decrement of j1939_proto.inuse_idx

Dmitry Baryshkov (1):
      Bluetooth: qca: fix NV variant for one of WCN3950 SoCs

Florian Westphal (1):
      netfilter: conntrack: fix erronous removal of offload bit

Frédéric Danis (2):
      Bluetooth: l2cap: Check encryption key size on incoming connection
      Bluetooth: l2cap: Process valid commands in too long frame

Ido Schimmel (2):
      net: fib_rules: Fix iif / oif matching on L3 master device
      selftests: fib_rule_tests: Add VRF match tests

Ilya Maximets (1):
      net: openvswitch: fix nested key length validation in the set() action

Jakub Kicinski (20):
      Merge tag 'for-net-2025-04-10' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'wireless-2025-04-11' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'there-are-some-bugfix-for-hibmcge-driver'
      net: don't mix device locking in dev_close_many() calls
      netlink: specs: ovs_vport: align with C codegen capabilities
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      eth: bnxt: fix missing ring index trim on error path
      Merge branch 'fib_rules-fix-iif-oif-matching-on-l3-master-device'
      Merge tag 'linux-can-fixes-for-6.15-20250415' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      tools: ynl-gen: don't declare loop iterator in place
      tools: ynl-gen: move local vars after the opening bracket
      tools: ynl-gen: individually free previous values on double set
      tools: ynl-gen: make sure we validate subtype of array-nest
      netlink: specs: rt-link: add an attr layer around alt-ifname
      netlink: specs: rtnetlink: attribute naming corrections
      netlink: specs: rt-link: adjust mctp attribute naming
      netlink: specs: rt-neigh: prefix struct nfmsg members with ndm
      Merge branch 'ynl-avoid-leaks-in-attr-override-and-spec-fixes-for-c'
      Merge branch 'collection-of-dsa-bug-fixes'
      net: don't try to ops lock uninitialized devs

Jijie Shao (7):
      net: hibmcge: fix incorrect pause frame statistics issue
      net: hibmcge: fix incorrect multicast filtering issue
      net: hibmcge: fix the share of irq statistics among different network ports issue
      net: hibmcge: fix wrong mtu log issue
      net: hibmcge: fix the incorrect np_link fail state issue.
      net: hibmcge: fix not restore rx pause mac addr after reset issue
      net: hibmcge: fix multiple phy_stop() issue

Johannes Berg (4):
      wifi: iwlwifi: mld: fix PM_SLEEP -Wundef warning
      wifi: add wireless list to MAINTAINERS
      wifi: iwlwifi: pcie: set state to no-FW before reset handshake
      Revert "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Jonas Gorski (2):
      net: b53: enable BPDU reception for management port
      net: bridge: switchdev: do not notify new brentries as changed

Kees Cook (1):
      Bluetooth: vhci: Avoid needless snprintf() calls

Kuniyuki Iwashima (1):
      smc: Fix lockdep false-positive for IPPROTO_SMC.

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address

Lukas Wunner (1):
      wifi: iwlwifi: mld: Restart firmware on iwl_mld_no_wowlan_resume() error

Matt Johnston (1):
      net: mctp: Set SOCK_RCU_FREE

Meghana Malladi (3):
      net: ti: icssg-prueth: Fix kernel warning while bringing down network interface
      net: ti: icssg-prueth: Fix possible NULL pointer dereference inside emac_xmit_xdp_frame()
      net: ti: icss-iep: Fix possible NULL pointer dereference for perout request

Michael Walle (1):
      net: ethernet: ti: am65-cpsw: fix port_np reference counting

Neeraj Sanjay Kale (2):
      Bluetooth: btnxpuart: Revert baudrate change in nxp_shutdown
      Bluetooth: btnxpuart: Add an error message if FW dump trigger fails

Paolo Abeni (3):
      Merge branch 'bug-fixes-from-xdp-and-perout-series'
      Merge tag 'for-net-2025-04-16' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'nf-25-04-17' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Pauli Virtanen (1):
      Bluetooth: increment TX timestamping tskey always for stream sockets

Remi Pommarel (2):
      wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()
      wifi: mac80211: Purge vif txq in ieee80211_do_stop()

Sagi Maimon (1):
      ptp: ocp: fix start time alignment in ptp_ocp_signal_set

Stanislav Fomichev (1):
      bonding: hold ops lock around get_link

Sven Eckelmann (1):
      batman-adv: Fix double-hold of meshif when getting enabled

Toke Høiland-Jørgensen (1):
      selftests/tc-testing: Add test for echo of big TC filters

Vladimir Oltean (5):
      net: dsa: mv88e6xxx: avoid unregistering devlink regions which were never registered
      net: dsa: mv88e6xxx: fix -ENOENT when deleting VLANs and MST is unsupported
      net: dsa: clean up FDB, MDB, VLAN entries on unbind
      net: dsa: free routing table on probe failure
      net: dsa: avoid refcount warnings when ds->ops->tag_8021q_vlan_del() fails

Weizhao Ouyang (1):
      can: rockchip_canfd: fix broken quirks checks

Xin Long (1):
      ipv6: add exception routes to GC list in rt6_insert_exception

Yedidya Benshimol (1):
      wifi: iwlwifi: mld: reduce scope for uninitialized variable

 Documentation/netlink/specs/ovs_vport.yaml         |   4 +-
 Documentation/netlink/specs/rt_link.yaml           |  20 ++--
 Documentation/netlink/specs/rt_neigh.yaml          |  14 +--
 MAINTAINERS                                        |   6 ++
 drivers/bluetooth/btnxpuart.c                      |  21 ++--
 drivers/bluetooth/btqca.c                          |   2 +-
 drivers/bluetooth/btrtl.c                          |   2 +
 drivers/bluetooth/hci_vhci.c                       |  10 +-
 drivers/net/bonding/bond_main.c                    |  13 ++-
 drivers/net/can/rockchip/rockchip_canfd-core.c     |   7 +-
 drivers/net/dsa/b53/b53_common.c                   |  10 ++
 drivers/net/dsa/mv88e6xxx/chip.c                   |  13 ++-
 drivers/net/dsa/mv88e6xxx/devlink.c                |   3 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c        |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   4 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_common.h    |   8 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_debugfs.c   |  11 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_diagnose.c  |   2 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c   |   3 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c    |   7 ++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c   |  24 +++--
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c  |   8 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c  |  11 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h   |   3 +
 drivers/net/ethernet/intel/igc/igc.h               |   1 +
 drivers/net/ethernet/intel/igc/igc_defines.h       |   6 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c           | 113 +++++++++++++-------
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |   2 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  49 +++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |   1 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  15 ++-
 drivers/net/ethernet/ti/icssg/icss_iep.c           | 117 ++++++++++-----------
 drivers/net/ethernet/ti/icssg/icssg_common.c       |   9 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   3 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   3 +-
 drivers/net/wireless/atmel/at76c50x-usb.c          |   2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   7 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   8 +-
 drivers/net/wireless/ti/wl1251/tx.c                |   4 +-
 drivers/ptp/ptp_ocp.c                              |   1 +
 include/net/fib_rules.h                            |   2 +
 include/net/flow.h                                 |   1 +
 include/net/l3mdev.h                               |  27 +++++
 net/batman-adv/hard-interface.c                    |   1 -
 net/bluetooth/hci_conn.c                           |   8 +-
 net/bluetooth/hci_event.c                          |   5 +-
 net/bluetooth/l2cap_core.c                         |  21 +++-
 net/bridge/br_vlan.c                               |   4 +-
 net/can/j1939/socket.c                             |   1 +
 net/core/dev.c                                     |  19 +++-
 net/core/fib_rules.c                               |  48 +++++++--
 net/core/rtnetlink.c                               |   5 +-
 net/dsa/dsa.c                                      |  59 +++++++++--
 net/dsa/tag_8021q.c                                |   2 +-
 net/ethtool/cmis_cdb.c                             |   2 +-
 net/ipv6/route.c                                   |   1 +
 net/l3mdev/l3mdev.c                                |   4 +-
 net/mac80211/iface.c                               |   3 +
 net/mctp/af_mctp.c                                 |   3 +
 net/netfilter/nf_flow_table_core.c                 |  10 +-
 net/openvswitch/flow_netlink.c                     |   3 +-
 net/smc/af_smc.c                                   |   5 +
 tools/net/ynl/pyynl/ynl_gen_c.py                   |  96 ++++++++++++-----
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py |   4 +
 tools/testing/selftests/net/fib_rule_tests.sh      |  34 ++++++
 .../tc-testing/tc-tests/infra/actions.json         |  22 ++++
 72 files changed, 684 insertions(+), 276 deletions(-)

