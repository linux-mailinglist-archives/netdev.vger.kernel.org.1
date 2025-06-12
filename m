Return-Path: <netdev+bounces-197116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7284AD7870
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751481735AC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41684299AB5;
	Thu, 12 Jun 2025 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7h8B2Cd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774A1F3BB0;
	Thu, 12 Jun 2025 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746685; cv=none; b=FeJek+s/ZGaRC6wwqBV/6JZpK64WrXBus/EBqsNmFoaGGHD91xJ6Rpxo/Vjhy+mBLeAmImRlAODg3pzPrt0Rxmkxhu+JRsH1Yehopd0bID0AaR1DRTrkI3Nz3Eh1Bb3Cv8q10JHmOg5NiLDa1pykN8KofTxsXl20ZBFEDsxZ/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746685; c=relaxed/simple;
	bh=1FD3lhi236r/xRmCrB1chAj3xsVQe75ErnRi8vQ29Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C6M93c+vofRkNMQged78qxJIuTwVGP0Yle4yjLq1QGblrMHIZSC7wK2636pRtO7s9oTSQtz39MMA8QzycH8/I67Zddj/BUD15lGU9I8GfXeHMBqFnTDHgpJly2rhLbFznTQwIKUmvooIDUUG6dBoZa/asOPoT7CTUaBbcYqeUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7h8B2Cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6429EC4CEEA;
	Thu, 12 Jun 2025 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749746684;
	bh=1FD3lhi236r/xRmCrB1chAj3xsVQe75ErnRi8vQ29Sk=;
	h=From:To:Cc:Subject:Date:From;
	b=V7h8B2CdVPu3igOBPy2QgOccstkidpwPhyS0ryAbAi0IWyMzHvwB3upx1BTNMHQvX
	 ys4gvfv2fiXMDyhToglOajaIy791fWEH9vfHvk6Sc9Gtyq22tUj23BWQFHwPV76g4G
	 gxc06bV3Qj7SvapSah+qR/wEXaTI/bzigX5+wlSqTru8JuXkc+F/Yj8ctceTb9fsDf
	 3IfJOC5sQAJZ+KX/Sl1f3FpcP8Mb8e6wQsXF3FVcKj/XpxT/slEUXgVVjCrPyGiKd7
	 PsTXPgNbHRQ9aUzrZcQQAws5pg7BES1u28wwJxzLbNWXmqFIxOvgP8dMNbiYAKtsBs
	 AF/b6DcWHSBJA==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.16-rc2
Date: Thu, 12 Jun 2025 09:44:43 -0700
Message-ID: <20250612164443.2565743-1-kuba@kernel.org>
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

The following changes since commit 2c7e4a2663a1ab5a740c59c31991579b6b865a26:

  Merge tag 'net-6.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-05 12:34:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc2

for you to fetch changes up to d5705afbaca2f5b3fb8766391ca6c43105d229b2:

  Merge tag 'wireless-2025-06-12' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2025-06-12 08:16:47 -0700)

----------------------------------------------------------------
Including fixes from bluetooth and wireless.

Current release - regressions:

 - af_unix: allow passing cred for embryo without SO_PASSCRED/SO_PASSPIDFD

Current release - new code bugs:

 - eth: airoha: correct enable mask for RX queues 16-31

 - veth: prevent NULL pointer dereference in veth_xdp_rcv when peer
   disappears under traffic

 - ipv6: move fib6_config_validate() to ip6_route_add(), prevent invalid
   routes

Previous releases - regressions:

 - phy: phy_caps: don't skip better duplex match on non-exact match

 - dsa: b53: fix untagged traffic sent via cpu tagged with VID 0

 - Revert "wifi: mwifiex: Fix HT40 bandwidth issue.", it caused transient
   packet loss, exact reason not fully understood, yet

Previous releases - always broken:

 - net: clear the dst when BPF is changing skb protocol (IPv4 <> IPv6)

 - sched: sfq: fix a potential crash on gso_skb handling

 - Bluetooth: intel: improve rx buffer posting to avoid causing issues
   in the firmware

 - eth: intel: i40e: make reset handling robust against multiple requests

 - eth: mlx5: ensure FW pages are always allocated on the local NUMA
   node, even when device is configure to 'serve' another node

 - wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST definition for WCN7850,
   prevent kernel crashes

 - wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
   for 3 sec if fw_stats_done is not set

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Ahmed Zaki (1):
      iavf: fix reset_task for early reset event

Amir Tzin (1):
      net/mlx5: Fix ECVF vports unload on shutdown flow

Anton Nadezhdin (1):
      ice/ptp: fix crosstimestamp reporting

Baochen Qiang (8):
      wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
      wifi: ath11k: don't use static variables in ath11k_debugfs_fw_stats_process()
      wifi: ath11k: don't wait when there is no vdev started
      wifi: ath11k: move some firmware stats related functions outside of debugfs
      wifi: ath11k: adjust unlock sequence in ath11k_update_stats_event()
      wifi: ath11k: move locking outside of ath11k_mac_get_fw_stats()
      wifi: ath11k: consistently use ath11k_mac_get_fw_stats()
      wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST definition for WCN7850

Carlos Fernandez (1):
      macsec: MACsec SCI assignment for ES = 0

Casey Connolly (1):
      ath10k: snoc: fix unbalanced IRQ enable in crash recovery

Chandrashekar Devegowda (2):
      Bluetooth: btintel_pcie: Increase the tx and rx descriptor count
      Bluetooth: btintel_pcie: Reduce driver buffer posting to prevent race condition

Dan Carpenter (1):
      net/mlx5: HWS, Add error checking to hws_bwc_rule_complex_hash_node_get()

Emmanuel Grumbach (1):
      wifi: iwlwifi: fix merge damage related to iwl_pci_resume

Eric Dumazet (7):
      net_sched: sch_sfq: fix a potential crash on gso_skb handling
      net_sched: sch_sfq: reject invalid perturb period
      net_sched: prio: fix a race in prio_tune()
      net_sched: red: fix a race in __red_change()
      net_sched: tbf: fix a race in tbf_change()
      net_sched: ets: fix a race in ets_qdisc_change()
      net_sched: remove qdisc_tree_flush_backlog()

Francesco Dolcini (1):
      Revert "wifi: mwifiex: Fix HT40 bandwidth issue."

Gal Pressman (2):
      net: ethtool: Don't check if RSS context exists in case of context 0
      selftests: drv-net: rss_ctx: Add test for ntuple rules targeting default RSS context

Gustavo Luiz Duarte (1):
      netconsole: fix appending sysdata when sysdata_fields == SYSDATA_RELEASE

Jakub Kicinski (10):
      Merge tag 'for-net-2025-06-05' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'mlx5-misc-fixes-2025-06-10'
      net: clear the dst when changing skb protocol
      selftests: net: add test case for NAT46 looping back dst
      Merge branch 'net_sched-no-longer-use-qdisc_tree_flush_backlog'
      net: drv: netdevsim: don't napi_complete() from netpoll
      Merge tag 'for-net-2025-06-11' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'fix-ntuple-rules-targeting-default-rss'
      Merge tag 'wireless-2025-06-12' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jakub Raczynski (2):
      net/mdiobus: Fix potential out-of-bounds read/write access
      net/mdiobus: Fix potential out-of-bounds clause 45 read/write access

Jeff Johnson (1):
      wifi: ath12k: Fix hal_reo_cmd_status kernel-doc

Jeongjun Park (1):
      ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()

Jesper Dangaard Brouer (1):
      veth: prevent NULL pointer dereference in veth_xdp_rcv

Jianbo Liu (1):
      net/mlx5e: Fix leak of Geneve TLV option object

Joe Damato (1):
      e1000: Move cancel_work_sync to avoid deadlock

Johannes Berg (1):
      Merge tag 'ath-current-20250608' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Jonas Gorski (1):
      net: dsa: b53: fix untagged traffic sent via cpu tagged with VID 0

Kiran K (1):
      Bluetooth: btintel_pcie: Fix driver not posting maximum rx buffers

Kuniyuki Iwashima (3):
      MAINTAINERS: Update Kuniyuki Iwashima's email address.
      ipv6: Move fib6_config_validate() to ip6_route_add().
      af_unix: Allow passing cred for embryo without SO_PASSCRED/SO_PASSPIDFD.

Loic Poulain (1):
      wifi: ath10k: Avoid vdev delete timeout when firmware is already down

Lorenzo Bianconi (1):
      net: airoha: Enable RX queues 16-31

Lucas Sanchez Sagrado (1):
      net: usb: r8152: Add device ID for TP-Link UE200

Luiz Augusto von Dentz (8):
      Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete
      Bluetooth: MGMT: Protect mgmt_pending list with its own lock
      Bluetooth: Fix NULL pointer deference on eir_get_service_data
      Bluetooth: hci_sync: Fix broadcast/PA when using an existing instance
      Bluetooth: eir: Fix possible crashes on eir_create_adv_data
      Bluetooth: ISO: Fix using BT_SK_PA_SYNC to detect BIS sockets
      Bluetooth: ISO: Fix not using bc_sid as advertisement SID
      Bluetooth: MGMT: Fix sparse errors

Maxime Chevallier (1):
      net: phy: phy_caps: Don't skip better duplex macth on non-exact match

Miaoqing Pan (1):
      wifi: ath12k: fix uaf in ath12k_core_init()

Michal Luczaj (1):
      net: Fix TOCTOU issue in sk_is_readable()

Moshe Shemesh (1):
      net/mlx5: Ensure fw pages are always allocated on same NUMA

Patrisious Haddad (1):
      net/mlx5: Fix return value when searching for existing flow group

Pauli Virtanen (1):
      Bluetooth: hci_core: fix list_for_each_entry_rcu usage

Robert Malz (2):
      i40e: return false from i40e_reset_vf if reset is in progress
      i40e: retry VFLR handling if there is ongoing VF reset

Rodrigo Gobbi (1):
      wifi: ath11k: validate ath11k_crypto_mode on top of ath11k_core_qmi_firmware_ready

Sebastian Gottschall (1):
      wil6210: fix support for sparrow chipsets

Shahar Shitrit (1):
      net/mlx5e: Fix number of lanes to UNKNOWN when using data_rate_oper

Vlad Dogaru (2):
      net/mlx5: HWS, Init mutex on the correct path
      net/mlx5: HWS, make sure the uplink is the last destination

Wei Fang (1):
      net: enetc: fix the netc-lib driver build dependency

Yevgeny Kliteynik (1):
      net/mlx5: HWS, fix missing ip_version handling in definer

Zilin Guan (1):
      wifi: cfg80211: use kfree_sensitive() for connkeys cleanup

 .mailmap                                           |   3 +
 MAINTAINERS                                        |   6 +-
 drivers/bluetooth/btintel_pcie.c                   |  31 +++--
 drivers/bluetooth/btintel_pcie.h                   |  10 +-
 drivers/net/dsa/b53/b53_common.c                   |   6 +-
 drivers/net/ethernet/airoha/airoha_regs.h          |   3 +-
 drivers/net/ethernet/freescale/enetc/Kconfig       |   6 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c      |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  11 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  11 ++
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  17 +++
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  21 +--
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |   2 +-
 .../mellanox/mlx5/core/steering/hws/action.c       |  14 +-
 .../mellanox/mlx5/core/steering/hws/bwc_complex.c  |  19 ++-
 .../mellanox/mlx5/core/steering/hws/definer.c      |   3 +
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       |   5 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h      |   1 +
 drivers/net/macsec.c                               |  40 +++++-
 drivers/net/netconsole.c                           |   3 +-
 drivers/net/netdevsim/netdev.c                     |   3 +-
 drivers/net/phy/mdio_bus.c                         |  12 ++
 drivers/net/phy/phy_caps.c                         |  18 ++-
 drivers/net/usb/r8152.c                            |   1 +
 drivers/net/veth.c                                 |   4 +-
 drivers/net/wireless/ath/ath10k/mac.c              |  33 +++--
 drivers/net/wireless/ath/ath10k/snoc.c             |   4 +-
 drivers/net/wireless/ath/ath11k/core.c             |  29 ++--
 drivers/net/wireless/ath/ath11k/core.h             |   4 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          | 148 ++-------------------
 drivers/net/wireless/ath/ath11k/debugfs.h          |  10 +-
 drivers/net/wireless/ath/ath11k/mac.c              | 127 ++++++++++++------
 drivers/net/wireless/ath/ath11k/mac.h              |   4 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  49 ++++++-
 drivers/net/wireless/ath/ath12k/core.c             |  10 +-
 drivers/net/wireless/ath/ath12k/hal.h              |   3 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   6 +
 drivers/net/wireless/ath/ath12k/hw.h               |   2 +
 drivers/net/wireless/ath/ath12k/pci.c              |   6 +-
 drivers/net/wireless/ath/ath12k/pci.h              |   4 +-
 drivers/net/wireless/ath/wil6210/interrupt.c       |  26 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  24 +++-
 drivers/net/wireless/marvell/mwifiex/11n.c         |   6 +-
 drivers/ptp/ptp_private.h                          |  12 +-
 include/net/bluetooth/hci_core.h                   |  11 +-
 include/net/bluetooth/hci_sync.h                   |   4 +-
 include/net/sch_generic.h                          |   8 --
 include/net/sock.h                                 |   7 +-
 net/bluetooth/eir.c                                |  17 ++-
 net/bluetooth/eir.h                                |   2 +-
 net/bluetooth/hci_conn.c                           |  31 ++++-
 net/bluetooth/hci_core.c                           |  32 +++--
 net/bluetooth/hci_sync.c                           |  45 +++++--
 net/bluetooth/iso.c                                |  17 ++-
 net/bluetooth/mgmt.c                               | 140 +++++++++----------
 net/bluetooth/mgmt_util.c                          |  32 ++++-
 net/bluetooth/mgmt_util.h                          |   4 +-
 net/core/filter.c                                  |  19 ++-
 net/ethtool/ioctl.c                                |   3 +-
 net/ipv6/route.c                                   | 110 +++++++--------
 net/sched/sch_ets.c                                |   2 +-
 net/sched/sch_prio.c                               |   2 +-
 net/sched/sch_red.c                                |   2 +-
 net/sched/sch_sfq.c                                |  15 ++-
 net/sched/sch_tbf.c                                |   2 +-
 net/unix/af_unix.c                                 |   3 +-
 net/wireless/nl80211.c                             |   2 +-
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |  59 +++++++-
 tools/testing/selftests/net/Makefile               |   1 +
 tools/testing/selftests/net/nat6to4.sh             |  15 +++
 74 files changed, 818 insertions(+), 555 deletions(-)
 create mode 100755 tools/testing/selftests/net/nat6to4.sh

