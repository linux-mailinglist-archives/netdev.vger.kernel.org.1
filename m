Return-Path: <netdev+bounces-187284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7FBAA6171
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 18:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5543E1BC1161
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9A520E026;
	Thu,  1 May 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQALpLZo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310420D51A;
	Thu,  1 May 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117441; cv=none; b=I9yPlaq9mu9BLGFmXb6mfZhkTjYpVI4OBWgizVLgR8AN5u4bUtzADj7MLqRnzmaRpmk0+vssUbKZ8YBCU3pjF3WM4CJcgi8d0pUr1Ul218R4fQvhrz/cIjWzILRN/Fx/75i/olruMqmTvR6Mr3c0lO0GQ16Kc9+FPaN5d5+e1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117441; c=relaxed/simple;
	bh=UFKG35B9L3fXHrixK4gXQEx+P0NgCp9KHiKNXcvZ8Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tORT5ZPrtZRdypu3wwNA+EHjYEgqelbe8bqm+TO+JkEZ+laklwASB+D5GGFQ8P4/JLjuh9LyDOPtTmkuwbdhgWbjgVac+AwoMPilqKos/uflfUwxPVpFRc71+RLeuEwsFlGGCbEfBjS4VLidjLRHhvaMaAzsLfRYkxDz/mqybSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQALpLZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F2CC4CEE9;
	Thu,  1 May 2025 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746117438;
	bh=UFKG35B9L3fXHrixK4gXQEx+P0NgCp9KHiKNXcvZ8Bc=;
	h=From:To:Cc:Subject:Date:From;
	b=WQALpLZoTmWCxUOY5IfKEw6XqNNh3vJ3I+5aY7bjZozri9DDB5J5jteqqwmMKPQ7D
	 wb554tYYi5XokuuqPWUV+SNdq0/206WpnGRZeKbCgZbP0NMSLQlqD4QB1sy5k4suaj
	 2qz8M00W5ITrLsBIAk+HoZzN0JXwP4ctGvLb9bhhYCN+m9TawVaa5quEDR1MlKjbPH
	 DGkMszy3NnogI+SHEfhvt5B9Ko1h/4zd5Ol2XNgHWS2KtRznHXJ6Ws9uq8nz5nJKcs
	 etFTypIY3JBkIg3OEdO8coYyywISHzbXunLhdaIcMleLtGtB8TpldaG+12Cjp1B1sT
	 XlG0f+w2K1Zfg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.15-rc5
Date: Thu,  1 May 2025 09:37:17 -0700
Message-ID: <20250501163717.3002314-1-kuba@kernel.org>
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

The following changes since commit e72e9e6933071fbbb3076811d3a0cc20e8720a5b:

  Merge tag 'net-6.15-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-04-24 09:14:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc5

for you to fetch changes up to 1daa05fdddebc8ea5f09d407a74ba88f6d0cfdbf:

  Merge branch 'net-vertexcom-mse102x-fix-rx-handling' (2025-05-01 07:24:09 -0700)

----------------------------------------------------------------
Happy May Day.

Things have calmed down on our end (knock on wood), no outstanding
investigations. Including fixes from Bluetooth and WiFi.

Current release - fix to a fix:

 - igc: fix lock order in igc_ptp_reset

Current release - new code bugs:

 - Revert "wifi: iwlwifi: make no_160 more generic", fixes regression
   to Killer line of devices reported by a number of people

 - Revert "wifi: iwlwifi: add support for BE213", initial FW is too buggy

 - number of fixes for mld, the new Intel WiFi subdriver

Previous releases - regressions:

 - wifi: mac80211: restore monitor for outgoing frames

 - drv: vmxnet3: fix malformed packet sizing in vmxnet3_process_xdp

 - eth: bnxt_en: fix timestamping FIFO getting out of sync on reset,
   delivering stale timestamps

 - use sock_gen_put() in the TCP fraglist GRO heuristic, don't assume
   every socket is a full socket

Previous releases - always broken:

 - sched: adapt qdiscs for reentrant enqueue cases, fix list corruptions

 - xsk: fix race condition in AF_XDP generic RX path, shared UMEM
   can't be protected by a per-socket lock

 - eth: mtk-star-emac: fix spinlock recursion issues on rx/tx poll

 - btusb: avoid NULL pointer dereference in skb_dequeue()

 - dsa: felix: fix broken taprio gate states after clock jump

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Benjamin Berg (1):
      wifi: iwlwifi: mld: only create debugfs symlink if it does not exist

Chad Monroe (1):
      net: ethernet: mtk_eth_soc: fix SER panic with 4GB+ RAM

Chris Lu (2):
      Bluetooth: btmtksdio: Check function enabled before doing close
      Bluetooth: btmtksdio: Do close if SDIO card removed without close

Chris Mi (1):
      net/mlx5: E-switch, Fix error handling for enabling roce

Christian Heusel (1):
      Revert "rndis_host: Flag RNDIS modems as WWAN devices"

Cosmin Ratiu (1):
      net/mlx5e: Fix lock order in mlx5e_tx_reporter_ptpsq_unhealthy_recover

Da Xue (1):
      net: mdio: mux-meson-gxl: set reversed bit when using internal phy

Daniel Borkmann (1):
      vmxnet3: Fix malformed packet sizing in vmxnet3_process_xdp

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: sync mtk_clks_source_name array

David S. Miller (1):
      Merge branch 'bnxt_en-fixes'

Emmanuel Grumbach (2):
      wifi: iwlwifi: don't warn if the NIC is gone in resume
      wifi: iwlwifi: fix the check for the SCRATCH register upon resume

En-Wei Wu (1):
      Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()

Felix Fietkau (1):
      net: ipv6: fix UDPv6 GSO segmentation with NAT

Hao Lan (1):
      net: hns3: fixed debugfs tm_qset size

Ido Schimmel (1):
      vxlan: vnifilter: Fix unlocked deletion of default FDB entry

Itamar Shalev (1):
      wifi: iwlwifi: restore missing initialization of async_handlers_list

Jacob Keller (1):
      igc: fix lock order in igc_ptp_reset

Jakub Kicinski (10):
      Merge tag 'wireless-2025-04-24' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'mlx5-misc-fixes-2025-04-23'
      Merge branch 'net-ethernet-mtk-star-emac-fix-several-issues-on-rx-tx-poll'
      Merge tag 'for-net-2025-04-25' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'net_sched-adapt-qdiscs-for-reentrant-enqueue-cases'
      Merge branch 'intel-net-queue-100GbE'
      Merge branch 'fix-felix-dsa-taprio-gates-after-clock-jump'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'
      Merge branch 'net-vertexcom-mse102x-fix-rx-handling'

Jian Shen (2):
      net: hns3: store rx VLAN tag offload state for VF
      net: hns3: defer calling ptp_clock_register()

Jianbo Liu (1):
      net/mlx5e: TC, Continue the attr process even if encap entry is invalid

Jibin Zhang (1):
      net: use sock_gen_put() when sk_state is TCP_TIME_WAIT

Johannes Berg (3):
      wifi: mac80211: restore monitor for outgoing frames
      wifi: iwlwifi: back off on continuous errors
      wifi: iwlwifi: mld: fix BAID validity check

Justin Lai (1):
      rtase: Modify the condition used to detect overflow in rtase_calc_time_mitigation

Kalesh AP (1):
      bnxt_en: Fix ethtool selftest output in one of the failure cases

Kashyap Desai (2):
      bnxt_en: call pci_alloc_irq_vectors() after bnxt_reserve_rings()
      bnxt_en: delay pci_alloc_irq_vectors() in the AER path

Kiran K (2):
      Bluetooth: btintel_pcie: Avoid redundant buffer allocation
      Bluetooth: btintel_pcie: Add additional to checks to clear TX/RX paths

Kory Maincent (1):
      netlink: specs: ethtool: Remove UAPI duplication of phy-upstream enum

Larysa Zaremba (1):
      idpf: protect shutdown from reset

Louis-Alexis Eyraud (2):
      net: ethernet: mtk-star-emac: fix spinlock recursion issues on rx/tx poll
      net: ethernet: mtk-star-emac: rearm interrupts in rx_poll only when advised

Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
      Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync

Madhu Chittim (1):
      idpf: fix offloads support for encapsulated packets

Maor Gottlieb (1):
      net/mlx5: E-Switch, Initialize MAC Address for Default GID

Mattias Barthel (1):
      net: fec: ERR007885 Workaround for conventional TX

Michael Chan (1):
      bnxt_en: Fix ethtool -d byte order for 32-bit values

Michal Swiatkowski (1):
      idpf: fix potential memory leak on kcalloc() failure

Miri Korenblit (4):
      Revert "wifi: iwlwifi: add support for BE213"
      Revert "wifi: iwlwifi: make no_160 more generic"
      wifi: iwlwifi: mld: properly handle async notification in op mode start
      wifi: iwlwifi: mld: inform trans on init failure

Murad Masimov (1):
      wifi: plfxlc: Remove erroneous assert in plfxlc_mac_release

Paul Greenwalt (1):
      ice: fix Get Tx Topology AQ command error on E830

Pauli Virtanen (1):
      Bluetooth: L2CAP: copy RX timestamp to new fragments

Sagi Maimon (1):
      ptp: ocp: Fix NULL dereference in Adva board SMA sysfs operations

Sathesh B Edara (2):
      octeon_ep_vf: Resolve netdevice usage count issue
      octeon_ep: Fix host hang issue during device reboot

Shannon Nelson (1):
      pds_core: remove write-after-free of client_id

Shravya KN (1):
      bnxt_en: Fix error handling path in bnxt_init_chip()

Shruti Parab (2):
      bnxt_en: Fix coredump logic to free allocated buffer
      bnxt_en: Fix out-of-bound memcpy() during ethtool -w

Simon Horman (1):
      net: dlink: Correct endianness handling of led_mode

Somnath Kotur (1):
      bnxt_en: Add missing skb_mark_for_recycle() in bnxt_rx_vlan()

Stefan Wahren (4):
      net: vertexcom: mse102x: Fix possible stuck of SPI interrupt
      net: vertexcom: mse102x: Fix LEN_MASK
      net: vertexcom: mse102x: Add range check for CMD_RTS
      net: vertexcom: mse102x: Fix RX error handling

Thangaraj Samynathan (1):
      net: lan743x: Fix memleak issue when GSO enabled

Vadim Fedorenko (2):
      bnxt_en: improve TX timestamping FIFO configuration
      bnxt_en: fix module unload sequence

Victor Nogueira (5):
      net_sched: drr: Fix double list add in class with netem as child qdisc
      net_sched: hfsc: Fix a UAF vulnerability in class with netem as child qdisc
      net_sched: ets: Fix double list add in class with netem as child qdisc
      net_sched: qfq: Fix double list add in class with netem as child qdisc
      selftests: tc-testing: Add TDC tests that exercise reentrant enqueue behaviour

Vishal Badole (1):
      amd-xgbe: Fix to ensure dependent features are toggled with RX checksum offload

Vlad Dogaru (1):
      net/mlx5e: Use custom tunnel header for vxlan gbp

Vladimir Oltean (6):
      net: mscc: ocelot: delete PVID VLAN when readding it as non-PVID
      selftests: net: bridge_vlan_aware: test untagged/8021p-tagged with and without PVID
      net: dsa: felix: fix broken taprio gate states after clock jump
      selftests: net: tsn_lib: create common helper for counting received packets
      selftests: net: tsn_lib: add window_size argument to isochron_do()
      selftests: net: tc_taprio: new test

Wentao Liang (1):
      wifi: brcm80211: fmac: Add error handling for brcmf_usb_dl_writeimage()

Xuanqiang Luo (1):
      ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()

Yonglong Liu (1):
      net: hns3: fix an interrupt residual problem

e.kubanski (2):
      xsk: Fix race condition in AF_XDP generic RX path
      xsk: Fix offset calculation in unaligned mode

 Documentation/netlink/specs/ethtool.yaml           |   4 +-
 drivers/bluetooth/btintel_pcie.c                   |  57 +--
 drivers/bluetooth/btmtksdio.c                      |  12 +-
 drivers/bluetooth/btusb.c                          | 101 +++--
 drivers/net/dsa/ocelot/felix_vsc9959.c             |   5 +-
 drivers/net/ethernet/amd/pds_core/auxbus.c         |   1 -
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c          |   9 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |  24 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |  11 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h               |   4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  35 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c |  30 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  38 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |  29 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h      |   1 +
 drivers/net/ethernet/dlink/dl2k.c                  |   2 +-
 drivers/net/ethernet/dlink/dl2k.h                  |   2 +-
 drivers/net/ethernet/freescale/fec_main.c          |   7 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  82 ++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |  13 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  25 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   1 +
 drivers/net/ethernet/intel/ice/ice_ddp.c           |  10 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c |   5 +
 drivers/net/ethernet/intel/idpf/idpf.h             |  18 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |  76 ++--
 drivers/net/ethernet/intel/idpf/idpf_main.c        |   1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c           |   6 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |   2 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.c  |   4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  18 +-
 drivers/net/ethernet/mediatek/mtk_star_emac.c      |  13 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |   6 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c  |  32 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   5 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/rdma.c     |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/rdma.h     |   4 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |   8 +-
 drivers/net/ethernet/microchip/lan743x_main.h      |   1 +
 drivers/net/ethernet/mscc/ocelot.c                 |   6 +
 drivers/net/ethernet/realtek/rtase/rtase_main.c    |   4 +-
 drivers/net/ethernet/vertexcom/mse102x.c           |  36 +-
 drivers/net/mdio/mdio-mux-meson-gxl.c              |   3 +-
 drivers/net/usb/rndis_host.c                       |  16 +-
 drivers/net/vmxnet3/vmxnet3_xdp.c                  |   2 +-
 drivers/net/vxlan/vxlan_vnifilter.c                |   8 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   2 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |  16 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  16 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  28 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  14 +-
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |   6 +-
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |   5 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |  13 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   1 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |  11 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   5 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 245 ++++++------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   9 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  16 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |  15 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c         |   1 -
 drivers/ptp/ptp_ocp.c                              |  52 ++-
 include/net/bluetooth/hci.h                        |   4 +-
 include/net/bluetooth/hci_core.h                   |  20 +-
 include/net/bluetooth/hci_sync.h                   |   3 +
 include/net/xdp_sock.h                             |   3 -
 include/net/xsk_buff_pool.h                        |   4 +-
 include/uapi/linux/ethtool_netlink_generated.h     |   5 -
 net/bluetooth/hci_conn.c                           | 181 +--------
 net/bluetooth/hci_event.c                          |  15 +-
 net/bluetooth/hci_sync.c                           | 150 +++++++-
 net/bluetooth/iso.c                                |  26 +-
 net/bluetooth/l2cap_core.c                         |   3 +
 net/ipv4/tcp_offload.c                             |   2 +-
 net/ipv4/udp_offload.c                             |  61 ++-
 net/ipv6/tcpv6_offload.c                           |   2 +-
 net/mac80211/status.c                              |   8 +-
 net/sched/sch_drr.c                                |   9 +-
 net/sched/sch_ets.c                                |   9 +-
 net/sched/sch_hfsc.c                               |   2 +-
 net/sched/sch_qfq.c                                |  11 +-
 net/xdp/xsk.c                                      |   6 +-
 net/xdp/xsk_buff_pool.c                            |   1 +
 .../testing/selftests/drivers/net/dsa/tc_taprio.sh |   1 +
 tools/testing/selftests/drivers/net/ocelot/psfp.sh |   8 +-
 .../selftests/net/forwarding/bridge_vlan_aware.sh  |  96 ++++-
 .../testing/selftests/net/forwarding/tc_taprio.sh  | 421 +++++++++++++++++++++
 tools/testing/selftests/net/forwarding/tsn_lib.sh  |  26 ++
 .../tc-testing/tc-tests/infra/qdiscs.json          | 186 +++++++++
 96 files changed, 1786 insertions(+), 737 deletions(-)
 create mode 120000 tools/testing/selftests/drivers/net/dsa/tc_taprio.sh
 create mode 100755 tools/testing/selftests/net/forwarding/tc_taprio.sh

