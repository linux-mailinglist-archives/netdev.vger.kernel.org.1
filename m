Return-Path: <netdev+bounces-215726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B55CB300D0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 19:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD49D5E2DD9
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141993054C2;
	Thu, 21 Aug 2025 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoeKT9Ck"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06491DFCE;
	Thu, 21 Aug 2025 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796603; cv=none; b=nXTsD/X+ROq0cKAOLRBwfX5wzSa57rG1DB6xe/U/cu2tyQdmiayuqc/cmSg/nouSfOS5FFtmIJ7QCf7FOYUNBYkp4D0Y0x5bdvvuoWszYzw3cy6eQ8sXWZ631WK/FyqJZ0ro7MSs51jLJZ1fKoIy7oEJTS0tYSC1VamJOiDuM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796603; c=relaxed/simple;
	bh=tG6P3RhqH+K4uJqyb3zYDGzHj68B6dZ4rXOkjf0arss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QGNtggS9HwX9n98vExoNsMRK0U/9aqDsVsnpAzRF7lNKRgTpCS1aJ4UnXmTK3hPofeeg7sgf7FwnnTH3OjvHCdmFexCSlJAtkGKbb4sfoUSzTcTartZ2GM/SlWT6h3Q4j2I9te7mSw7Ed52WTZ5yXvAPPi7hNneHKSt8OQasOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoeKT9Ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B292C4CEEB;
	Thu, 21 Aug 2025 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796602;
	bh=tG6P3RhqH+K4uJqyb3zYDGzHj68B6dZ4rXOkjf0arss=;
	h=From:To:Cc:Subject:Date:From;
	b=CoeKT9CkpgO3ZcWCKgniny0CbgvKcDAGcC7AmRl+qiu7n59m4JaKgBZTC2l1tZo2F
	 XC8chUecYZNOB7KGxwX6vsC85l0vMVfTJF1hKrBhk8DUpI62aQMo0Y8/Yy4scibKNv
	 Q0fs2v4qWMTAj2OiZ4H68VLMuaKMd/iRo051hAzcmpMQOdWWYXl5rKfysgy2T1BsE/
	 lfXOVWcpDh0GzDblk9JD35Dxij1GMTQR4vKT2lo5JkMX4dcB4A01/BfcdkLbSO5ERl
	 0utyueVLbhpFhkwexNZ0711BVnqKNLQYsmDw8TTJA+wHbJfFkWkNQmkRKWuwxfGPPx
	 CKcyN7lcDqUQQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.17-rc3
Date: Thu, 21 Aug 2025 10:16:41 -0700
Message-ID: <20250821171641.2435897-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 63467137ecc0ff6f804d53903ad87a2f0397a18b:

  Merge tag 'net-6.17-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-08-14 07:14:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc3

for you to fetch changes up to 91a79b792204313153e1bdbbe5acbfc28903b3a5:

  netfilter: nf_reject: don't leak dst refcount for loopback packets (2025-08-21 10:02:00 -0700)

----------------------------------------------------------------
Including fixes from Bluetooth.

Current release - fix to a fix:

 - usb: asix_devices: fix PHY address mask in MDIO bus initialization

Current release - regressions:

 - Bluetooth: fixes for the split between BIS_LINK and PA_LINK

 - Revert "net: cadence: macb: sama7g5_emac: Remove USARIO CLKEN flag",
   breaks compatibility with some existing device tree blobs

 - dsa: b53: fix reserved register access in b53_fdb_dump()

Current release - new code bugs:

 - sched: dualpi2: run probability update timer in BH to avoid deadlock

 - eth: libwx: fix the size in RSS hash key population

 - pse-pd: pd692x0: improve power budget error paths and handling

Previous releases - regressions:

 - tls: fix handling of zero-length records on the rx_list

 - hsr: reject HSR frame if skb can't hold tag

 - bonding: fix negotiation flapping in 802.3ad passive mode

Previous releases - always broken:

 - gso: forbid IPv6 TSO with extensions on devices with only IPV6_CSUM

 - sched: make cake_enqueue return NET_XMIT_CN when past buffer_limit,
   avoid packet drops with low buffer_limit, remove unnecessary WARN()

 - sched: fix backlog accounting after modifying config of a qdisc
   in the middle of the hierarchy

 - mptcp: improve handling of skb extension allocation failures

 - eth: mlx5:
   - fixes for the "HW Steering" flow management method
   - fixes for QoS and device buffer management

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alex Vesker (1):
      net/mlx5: HWS, Fix table creation UID

Alexandra Winter (1):
      MAINTAINERS: update s390/net

Alexei Lazar (1):
      net/mlx5e: Query FW for buffer ownership

Armen Ratner (1):
      net/mlx5e: Preserve shared buffer capacity during headroom updates

Carolina Jubran (5):
      net/mlx5: Remove default QoS group and attach vports directly to root TSAR
      net/mlx5e: Preserve tc-bw during parent changes
      net/mlx5: Destroy vport QoS element when no configuration remains
      net/mlx5: Fix QoS reference leak in vport enable error path
      net/mlx5: Restore missing scheduling node cleanup on vport enable failure

Chandra Mohan Sundar (1):
      net: libwx: Fix the size in RSS hash key population

Christoph Paasch (1):
      mptcp: drop skb if MPTCP skb extension allocation fails

D. Wythe (1):
      net/smc: fix UAF on smcsk after smc_listen_out()

Daniel Jurgens (1):
      net/mlx5: Base ECVF devlink port attrs from 0

Eric Biggers (1):
      ipv6: sr: Fix MAC comparison to be constant-time

Florian Westphal (1):
      netfilter: nf_reject: don't leak dst refcount for loopback packets

Geliang Tang (3):
      mptcp: remove duplicate sk_reset_timer call
      mptcp: disable add_addr retransmission when timeout is 0
      selftests: mptcp: disable add_addr retrans in endpoint_tests

Hangbin Liu (3):
      bonding: update LACP activity flag after setting lacp_active
      bonding: send LACPDUs periodically in passive mode after receiving partner's LACPDU
      selftests: bonding: add test for passive LACP mode

Hariprasad Kelam (1):
      Octeontx2-af: Skip overlap check for SPI field

Horatiu Vultur (1):
      phy: mscc: Fix timestamping for vsc8584

Ido Schimmel (2):
      mlxsw: spectrum: Forward packets with an IPv4 link-local source IP
      selftest: forwarding: router: Add a test case for IPv4 link-local source IP

Jakub Acs (1):
      net, hsr: reject HSR frame if skb can't hold tag

Jakub Kicinski (10):
      Merge branch 'mlxsw-spectrum-forward-packets-with-an-ipv4-link-local-source-ip'
      Merge tag 'for-net-2025-08-15' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      selftests: tls: make the new data_steal test less flaky
      Merge branch 'mptcp-misc-fixes-for-v6-17-rc'
      Merge branch 'mlx5-hws-fixes-2025-08-17'
      Merge branch 'fixes-on-the-microchip-s-lan865x-driver'
      Merge branch 'intel-wired-lan-driver-updates-2025-08-15-ice-ixgbe-igc'
      tls: fix handling of zero-length records on the rx_list
      selftests: tls: add tests for zero-length records
      Merge branch 'mlx5-misx-fixes-2025-08-20'

Jakub Ramaseuski (1):
      net: gso: Forbid IPv6 TSO with extensions on devices with only IPV6_CSUM

Jason Xing (1):
      ixgbe: xsk: resolve the negative overflow of budget in ixgbe_xmit_zc

Jiande Lu (1):
      Bluetooth: btmtk: Fix wait_on_bit_timeout interruption during shutdown

Jonas Gorski (1):
      net: dsa: b53: fix reserved register access in b53_fdb_dump()

Jordan Rhee (1):
      gve: prevent ethtool ops after shutdown

Justin Lai (1):
      rtase: Fix Rx descriptor CRC error bit definition

Kory Maincent (2):
      net: pse-pd: pd692x0: Fix power budget leak in manager setup error path
      net: pse-pd: pd692x0: Skip power budget configuration when undefined

Lorenzo Bianconi (1):
      net: airoha: ppe: Do not invalid PPE entries in case of SW hash collision

Lubomir Rintel (1):
      cdc_ncm: Flag Intel OEM version of Fibocom L850-GL as WWAN

Luiz Augusto von Dentz (7):
      Bluetooth: hci_sync: Fix scan state after PA Sync has been established
      Bluetooth: ISO: Fix getname not returning broadcast fields
      Bluetooth: hci_conn: Fix running bis_cleanup for hci_conn->type PA_LINK
      Bluetooth: hci_conn: Fix not cleaning up Broadcaster/Broadcast Source
      Bluetooth: hci_core: Fix using {cis,bis}_capable for current settings
      Bluetooth: hci_core: Fix using ll_privacy_capable for current settings
      Bluetooth: hci_core: Fix not accounting for BIS/CIS/PA links separately

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix HSR and switch offload Enablement during firwmare reload.

Maciej Fijalkowski (1):
      ixgbe: fix ndo_xdp_xmit() workloads

Matthieu Baerts (NGI0) (4):
      mptcp: pm: kernel: flush: do not reset ADD_ADDR limit
      selftests: mptcp: pm: check flush doesn't reset limits
      selftests: mptcp: connect: fix C23 extension warning
      selftests: mptcp: sockopt: fix C23 extension warning

Michael Chan (1):
      bnxt_en: Fix lockdep warning during rmmod

Minhong He (1):
      ipv6: sr: validate HMAC algorithm ID in seg6_hmac_info_add

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Uses threaded IRQ for host wakeup handling

Paolo Abeni (1):
      Merge branch 'bonding-fix-negotiation-flapping-in-802-3ad-passive-mode'

Parthiban Veerasooran (2):
      microchip: lan865x: fix missing netif_start_queue() call on device open
      microchip: lan865x: fix missing Timer Increment config for Rev.B0/B1

Pauli Virtanen (1):
      Bluetooth: hci_event: fix MTU for BN == 0 in CIS Established

Qingfang Deng (2):
      net: ethernet: mtk_ppe: add RCU lock around dev_fill_forward_path
      ppp: fix race conditions in ppp_fill_forward_path

Ryan Wanner (1):
      Revert "net: cadence: macb: sama7g5_emac: Remove USARIO CLKEN flag"

Sergey Shtylyov (1):
      Bluetooth: hci_conn: do return error from hci_enhanced_setup_sync()

Suraj Gupta (1):
      net: xilinx: axienet: Fix RX skb ring management in DMAengine mode

Tristram Ha (1):
      net: dsa: microchip: Fix KSZ9477 HSR port setup issue

ValdikSS (1):
      igc: fix disabling L1.2 PCI-E link substate on I226 on init

Victor Nogueira (1):
      net/sched: sch_dualpi2: Run prob update timer in softirq to avoid deadlock

Vlad Dogaru (1):
      net/mlx5: CT: Use the correct counter offset

Wang Liang (1):
      net: bridge: fix soft lockup in br_multicast_query_expired()

William Liu (4):
      net/sched: Fix backlog accounting in qdisc_dequeue_internal
      selftests/tc-testing: Check backlog stats in gso_skb case
      net/sched: Make cake_enqueue return NET_XMIT_CN when past buffer_limit
      net/sched: Remove unnecessary WARNING condition for empty child qdisc in htb_activate

Yang Li (2):
      Bluetooth: hci_sync: Avoid adding default advertising on startup
      Bluetooth: hci_sync: Prevent unintended PA sync when SID is 0xFF

Yao Zi (1):
      net: stmmac: thead: Enable TX clock before MAC initialization

Yevgeny Kliteynik (5):
      net/mlx5: HWS, fix bad parameter in CQ creation
      net/mlx5: HWS, fix simple rules rehash error flow
      net/mlx5: HWS, fix complex rules rehash error flow
      net/mlx5: HWS, prevent rehash from filling up the queues
      net/mlx5: HWS, don't rehash on every kind of insertion failure

Yuichiro Tsuji (1):
      net: usb: asix_devices: Fix PHY address mask in MDIO bus initialization

 Documentation/networking/mptcp-sysctl.rst          |   2 +
 MAINTAINERS                                        |   2 +-
 drivers/bluetooth/btmtk.c                          |   7 +-
 drivers/bluetooth/btnxpuart.c                      |   8 +-
 drivers/net/bonding/bond_3ad.c                     |  67 +++--
 drivers/net/bonding/bond_options.c                 |   1 +
 drivers/net/dsa/b53/b53_common.c                   |   2 +-
 drivers/net/dsa/microchip/ksz_common.c             |   6 +
 drivers/net/ethernet/airoha/airoha_ppe.c           |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   2 +-
 drivers/net/ethernet/cadence/macb_main.c           |   3 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c          |  14 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  34 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |   4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |   4 +-
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c    |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h |   1 -
 .../ethernet/mellanox/mlx5/core/en/port_buffer.c   |  18 +-
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |  12 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  | 183 ++++++------
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   5 -
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  20 ++
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c |  81 ++++--
 .../mellanox/mlx5/core/steering/hws/bwc_complex.c  |  41 ++-
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.c |   1 +
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.h |   1 +
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       |   1 +
 .../mellanox/mlx5/core/steering/hws/matcher.c      |   5 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h      |   1 +
 .../mellanox/mlx5/core/steering/hws/send.c         |   1 -
 .../mellanox/mlx5/core/steering/hws/table.c        |  13 +-
 .../mellanox/mlx5/core/steering/hws/table.h        |   3 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   2 +
 drivers/net/ethernet/mellanox/mlxsw/trap.h         |   1 +
 drivers/net/ethernet/microchip/lan865x/lan865x.c   |  21 ++
 drivers/net/ethernet/realtek/rtase/rtase.h         |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  |   9 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  72 +++--
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c     |   2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   8 +-
 drivers/net/phy/mscc/mscc.h                        |  12 +
 drivers/net/phy/mscc/mscc_main.c                   |  12 +
 drivers/net/phy/mscc/mscc_ptp.c                    |  49 +++-
 drivers/net/ppp/ppp_generic.c                      |  17 +-
 drivers/net/pse-pd/pd692x0.c                       |  63 ++++-
 drivers/net/usb/asix_devices.c                     |   2 +-
 drivers/net/usb/cdc_ncm.c                          |   7 +
 include/net/bluetooth/bluetooth.h                  |   4 +-
 include/net/bluetooth/hci_core.h                   |  44 ++-
 include/net/bond_3ad.h                             |   1 +
 include/net/sch_generic.h                          |  11 +-
 net/bluetooth/hci_conn.c                           |  17 +-
 net/bluetooth/hci_event.c                          |  15 +-
 net/bluetooth/hci_sync.c                           |  25 +-
 net/bluetooth/iso.c                                |  16 +-
 net/bluetooth/mgmt.c                               |  12 +-
 net/bridge/br_multicast.c                          |  16 ++
 net/bridge/br_private.h                            |   2 +
 net/core/dev.c                                     |  12 +
 net/hsr/hsr_slave.c                                |   8 +-
 net/ipv4/netfilter/nf_reject_ipv4.c                |   6 +-
 net/ipv6/netfilter/nf_reject_ipv6.c                |   5 +-
 net/ipv6/seg6_hmac.c                               |   6 +-
 net/mptcp/options.c                                |   6 +-
 net/mptcp/pm.c                                     |  18 +-
 net/mptcp/pm_kernel.c                              |   1 -
 net/sched/sch_cake.c                               |  14 +-
 net/sched/sch_codel.c                              |  12 +-
 net/sched/sch_dualpi2.c                            |   5 +-
 net/sched/sch_fq.c                                 |  12 +-
 net/sched/sch_fq_codel.c                           |  12 +-
 net/sched/sch_fq_pie.c                             |  12 +-
 net/sched/sch_hhf.c                                |  12 +-
 net/sched/sch_htb.c                                |   2 +-
 net/sched/sch_pie.c                                |  12 +-
 net/smc/af_smc.c                                   |   3 +-
 net/tls/tls_sw.c                                   |   7 +-
 .../testing/selftests/drivers/net/bonding/Makefile |   3 +-
 .../drivers/net/bonding/bond_passive_lacp.sh       | 105 +++++++
 tools/testing/selftests/drivers/net/bonding/config |   1 +
 tools/testing/selftests/net/forwarding/router.sh   |  29 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |   5 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c      |   5 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   1 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c  |   5 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |   1 +
 tools/testing/selftests/net/tls.c                  | 312 ++++++++++++++++++++-
 .../tc-testing/tc-tests/infra/qdiscs.json          | 198 +++++++++++++
 92 files changed, 1434 insertions(+), 397 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh

