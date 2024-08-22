Return-Path: <netdev+bounces-121164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F15295C00D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 23:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA43C2852DD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F7170A15;
	Thu, 22 Aug 2024 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhjhdbjg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C4D14BF98;
	Thu, 22 Aug 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724360487; cv=none; b=sswKlRgSo4nMT07byJBLvAfocxECzQ9pddtbPKxDxPfb7OfHy9cjnAvuObgGY59PB7fdiRO1ns/b7TAE1zm3J4hib/SKZZJyQYRLNUC81Iqf5O0uYoiAJLWWav8+xA37SQZxtWtFwKDyxiTUGpUj+KH+p1OKQSSBOIdrbII8wzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724360487; c=relaxed/simple;
	bh=ZkIDf72IozmKiOW/uW2rF9anfmQWpVrF1vkPPIq1mOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=juR0e/0XNLmt6EgJe9e4YTRZ5FOvJeLq1rP4KBw+3S5vXj+C1uKl+ljKUWf0iB4LD8V6L/pzQr3t+xVrErPSfwwaujFao6zHx7o92SPwEC4F+unesKBlBhbkUJwxKzrPmPvrqjNDknwtQzTtmJDY6cOCqPisDExohfv/prxuS54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhjhdbjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E259C4AF0B;
	Thu, 22 Aug 2024 21:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724360486;
	bh=ZkIDf72IozmKiOW/uW2rF9anfmQWpVrF1vkPPIq1mOc=;
	h=From:To:Cc:Subject:Date:From;
	b=FhjhdbjgVBb1W5robTC7nqiwQr0tvrs4wslyvOui3P68xi5BD8p1XnUrbmf5H/BpZ
	 fbysoje2IW9PpUHsR8xgwHP2aNBbWHNRAtXajQM1DeQ+JWJr8Fqd+AD0z+QvarJmyJ
	 jg5HfDwuWeJnnG0SyLhZo6bt0JnoArLm4qcIyZhfQMC/q1/X7A+kK/BCRccR/cApiQ
	 2QwlCWetRTzZCHZal7zP9UdyeU3tVr6fIhBzZKjy0D+0ZKV1sNmKq4nB2wG1ch1fTm
	 Vtx17Ej1P5q5sOV0mn4HRoGMu0Y8fL5N4+EZM27KHX1YBHNQ+KF8RC7BkOIZLKA04D
	 D5hRIKILzpTUA==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.11-rc5
Date: Thu, 22 Aug 2024 14:01:25 -0700
Message-ID: <20240822210125.1542769-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit a4a35f6cbebbf9466b6c412506ab89299d567f51:

  Merge tag 'net-6.11-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-08-15 10:35:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc5

for you to fetch changes up to 0124fb0ebf3b0ef89892d42147c9387be3105318:

  s390/iucv: Fix vargs handling in iucv_alloc_device() (2024-08-22 13:09:20 -0700)

----------------------------------------------------------------
Including fixes from bluetooth and netfilter.

Current release - regressions:

 - virtio_net: avoid crash on resume - move netdev_tx_reset_queue()
   call before RX napi enable

Current release - new code bugs:

 - net/mlx5e: fix page leak and incorrect header release w/ HW GRO

Previous releases - regressions:

 - udp: fix receiving fraglist GSO packets

 - tcp: prevent refcount underflow due to concurrent execution
   of tcp_sk_exit_batch()

Previous releases - always broken:

 - ipv6: fix possible UAF when incrementing error counters on output

 - ip6: tunnel: prevent merging of packets with different L2

 - mptcp: pm: fix IDs not being reusable

 - bonding: fix potential crashes in IPsec offload handling

 - Bluetooth: HCI:
   - MGMT: add error handling to pair_device() to avoid a crash
   - invert LE State quirk to be opt-out rather then opt-in
   - fix LE quote calculation

 - drv: dsa: VLAN fixes for Ocelot driver

 - drv: igb: cope with large MAX_SKB_FRAGS Kconfig settings

 - drv: ice: fi Rx data path on architectures with PAGE_SIZE >= 8192

Misc:

 - netpoll: do not export netpoll_poll_[disable|enable]()

 - MAINTAINERS: update the list of networking headers

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexandra Winter (1):
      s390/iucv: Fix vargs handling in iucv_alloc_device()

Bharat Bhushan (1):
      octeontx2-af: Fix CPT AF register offset calculation

Carolina Jubran (1):
      net/mlx5e: XPS, Fix oversight of Multi-PF Netdev changes

Dan Carpenter (1):
      dpaa2-switch: Fix error checking in dpaa2_switch_seed_bp()

David S. Miller (2):
      Merge branch 'vln-ocelot-fixes'
      Merge branch 'selftests-udpgro-fixes'

Dragos Tatulea (2):
      net/mlx5e: SHAMPO, Fix page leak
      net/mlx5e: SHAMPO, Release in progress headers

Eric Dumazet (4):
      netpoll: do not export netpoll_poll_[disable|enable]()
      ipv6: prevent UAF in ip6_send_skb()
      ipv6: fix possible UAF in ip6_finish_output2()
      ipv6: prevent possible UAF in ip6_xmit()

Felix Fietkau (1):
      udp: fix receiving fraglist GSO packets

Florian Westphal (1):
      tcp: prevent concurrent execution of tcp_sk_exit_batch

Griffin Kroah-Hartman (1):
      Bluetooth: MGMT: Add error handling to pair_device()

Hangbin Liu (2):
      selftests: udpgro: report error when receive failed
      selftests: udpgro: no need to load xdp for gro

Ido Schimmel (1):
      selftests: mlxsw: ethtool_lanes: Source ethtool lib from correct path

Jakub Kicinski (8):
      MAINTAINERS: add selftests to network drivers
      Merge branch 'mlx5-misc-fixes-2024-08-15'
      Merge tag 'for-net-2024-08-15' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'mptcp-pm-fix-ids-not-being-reusable'
      Merge branch 'ipv6-fix-possible-uaf-in-output-paths'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'net-xilinx-axienet-multicast-fixes-and-improvements'
      Merge tag 'nf-24-08-22' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Jeremy Kerr (1):
      net: mctp: test: Use correct skb for route input check

Jiri Pirko (1):
      virtio_net: move netdev_tx_reset_queue() call before RX napi enable

Joseph Huang (1):
      net: dsa: mv88e6xxx: Fix out-of-bound access

Kuniyuki Iwashima (1):
      kcm: Serialise kcm_sendmsg() for the same socket.

Luiz Augusto von Dentz (3):
      Bluetooth: HCI: Invert LE State quirk to be opt-out rather then opt-in
      Bluetooth: hci_core: Fix LE quote calculation
      Bluetooth: SMP: Fix assumption of Central always being Initiator

Maciej Fijalkowski (3):
      ice: fix page reuse when PAGE_SIZE is over 8k
      ice: fix ICE_LAST_OFFSET formula
      ice: fix truesize operations for PAGE_SIZE >= 8192

Martin Whitaker (1):
      net: dsa: microchip: fix PTP config failure when using multiple ports

Matthieu Baerts (NGI0) (14):
      mptcp: pm: re-using ID of unused removed ADD_ADDR
      selftests: mptcp: join: check re-using ID of unused ADD_ADDR
      mptcp: pm: re-using ID of unused removed subflows
      selftests: mptcp: join: check re-using ID of closed subflow
      mptcp: pm: re-using ID of unused flushed subflows
      selftests: mptcp: join: test for flush/re-add endpoints
      mptcp: pm: remove mptcp_pm_remove_subflow()
      mptcp: pm: only mark 'subflow' endp as available
      mptcp: pm: only decrement add_addr_accepted for MPJ req
      mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
      mptcp: pm: only in-kernel cannot have entries with ID 0
      mptcp: pm: fullmesh: select the right ID later
      selftests: mptcp: join: validate fullmesh endp on 1st sf
      mptcp: pm: avoid possible UaF when selecting endp

Menglong Dong (1):
      net: ovs: fix ovs_drop_reasons error

Mengyuan Lou (1):
      net: ngbe: Fix phy mode set to external phy

Michal Swiatkowski (1):
      ice: use internal pf id instead of function number

Nikolay Aleksandrov (4):
      bonding: fix bond_ipsec_offload_ok return type
      bonding: fix null pointer deref in bond_ipsec_offload_ok
      bonding: fix xfrm real_dev null pointer dereference
      bonding: fix xfrm state handling when clearing active slave

Nikolay Kuratov (1):
      cxgb4: add forgotten u64 ivlan cast before shift

Pablo Neira Ayuso (1):
      netfilter: flowtable: validate vlan header

Paolo Abeni (3):
      Merge branch 'bonding-fix-xfrm-offload-bugs'
      igb: cope with large MAX_SKB_FRAGS
      Merge branch 'maintainers-networking-updates'

Patrisious Haddad (1):
      net/mlx5: Fix IPsec RoCE MPV trace call

Pavan Chebbi (1):
      bnxt_en: Don't clear ntuple filters and rss contexts during ethtool ops

Sava Jakovljev (1):
      net: phy: realtek: Fix setting of PHY LEDs Mode B bit on RTL8211F

Sean Anderson (2):
      net: xilinx: axienet: Always disable promiscuous mode
      net: xilinx: axienet: Fix dangling multicast addresses

Sebastian Andrzej Siewior (2):
      netfilter: nft_counter: Disable BH in nft_counter_offload_stats().
      netfilter: nft_counter: Synchronize nft_counter_reset() against reader.

Simon Horman (6):
      tc-testing: don't access non-existent variable on exception
      MAINTAINERS: Add sonet.h to ATM section of MAINTAINERS
      MAINTAINERS: Add net_tstamp.h to SOCKET TIMESTAMPING section
      MAINTAINERS: Add limited globs for Networking headers
      MAINTAINERS: Add header files to NETWORKING sections
      MAINTAINERS: Mark JME Network Driver as Odd Fixes

Somnath Kotur (1):
      bnxt_en: Fix double DMA unmapping for XDP_REDIRECT

Stephen Hemminger (1):
      netem: fix return value if duplicate enqueue fails

Thomas Bogendoerfer (1):
      ip6_tunnel: Fix broken GRO

Vladimir Oltean (14):
      selftests: net: local_termination: refactor macvlan creation/deletion
      selftests: net: local_termination: parameterize sending interface
      selftests: net: local_termination: parameterize test name
      selftests: net: local_termination: add one more test for VLAN-aware bridges
      selftests: net: local_termination: introduce new tests which capture VLAN behavior
      selftests: net: local_termination: don't use xfail_on_veth()
      selftests: net: local_termination: add PTP frames to the mix
      selftests: net: bridge_vlan_aware: test that other TPIDs are seen as untagged
      net: mscc: ocelot: use ocelot_xmit_get_vlan_info() also for FDMA and register injection
      net: mscc: ocelot: fix QoS class for injected packets with "ocelot-8021q"
      net: mscc: ocelot: serialize access to the injection/extraction groups
      net: dsa: provide a software untagging function on RX for VLAN-aware bridges
      net: dsa: felix: fix VLAN tag loss on CPU reception with ocelot-8021q
      net: mscc: ocelot: treat 802.1ad tagged traffic as 802.1Q-untagged

 MAINTAINERS                                        |  33 +-
 drivers/bluetooth/btintel.c                        |  10 -
 drivers/bluetooth/btintel_pcie.c                   |   3 -
 drivers/bluetooth/btmtksdio.c                      |   3 -
 drivers/bluetooth/btrtl.c                          |   1 -
 drivers/bluetooth/btusb.c                          |   4 +-
 drivers/bluetooth/hci_qca.c                        |   4 +-
 drivers/bluetooth/hci_vhci.c                       |   2 -
 drivers/net/bonding/bond_main.c                    |  21 +-
 drivers/net/bonding/bond_options.c                 |   2 +-
 drivers/net/dsa/microchip/ksz_ptp.c                |   5 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c            |   3 +-
 drivers/net/dsa/ocelot/felix.c                     | 126 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   2 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   4 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |   5 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c  |   3 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |   7 +-
 .../net/ethernet/intel/ice/devlink/devlink_port.c  |   4 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |  21 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |  47 +--
 drivers/net/ethernet/intel/igb/igb_main.c          |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cpt.c    |  23 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  23 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  26 +-
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c         |   6 +-
 drivers/net/ethernet/mscc/ocelot.c                 | 279 ++++++++++++-
 drivers/net/ethernet/mscc/ocelot_fdma.c            |   3 +-
 drivers/net/ethernet/mscc/ocelot_vcap.c            |   1 +
 drivers/net/ethernet/mscc/ocelot_vsc7514.c         |   4 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c      |   8 +-
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  25 +-
 drivers/net/phy/realtek.c                          |   3 +-
 drivers/net/virtio_net.c                           |   2 +-
 include/linux/dsa/ocelot.h                         |  47 +++
 include/net/bluetooth/hci.h                        |  17 +-
 include/net/bluetooth/hci_core.h                   |   2 +-
 include/net/dsa.h                                  |  16 +-
 include/net/kcm.h                                  |   1 +
 include/soc/mscc/ocelot.h                          |  12 +-
 include/soc/mscc/ocelot_vcap.h                     |   2 +
 net/bluetooth/hci_core.c                           |  19 +-
 net/bluetooth/hci_event.c                          |   2 +-
 net/bluetooth/mgmt.c                               |   4 +
 net/bluetooth/smp.c                                | 146 +++----
 net/core/netpoll.c                                 |   2 -
 net/dsa/tag.c                                      |   5 +-
 net/dsa/tag.h                                      | 141 +++++--
 net/dsa/tag_ocelot.c                               |  37 +-
 net/ipv4/tcp_ipv4.c                                |  14 +
 net/ipv4/udp_offload.c                             |   3 +-
 net/ipv6/ip6_output.c                              |  10 +
 net/ipv6/ip6_tunnel.c                              |  12 +-
 net/iucv/iucv.c                                    |   4 +-
 net/kcm/kcmsock.c                                  |   4 +
 net/mctp/test/route-test.c                         |   2 +-
 net/mptcp/pm.c                                     |  13 -
 net/mptcp/pm_netlink.c                             | 142 ++++---
 net/mptcp/protocol.h                               |   3 -
 net/netfilter/nf_flow_table_inet.c                 |   3 +
 net/netfilter/nf_flow_table_ip.c                   |   3 +
 net/netfilter/nft_counter.c                        |   9 +-
 net/openvswitch/datapath.c                         |   2 +-
 net/sched/sch_netem.c                              |  47 ++-
 .../selftests/drivers/net/mlxsw/ethtool_lanes.sh   |   3 +-
 .../selftests/net/forwarding/bridge_vlan_aware.sh  |  54 ++-
 tools/testing/selftests/net/forwarding/lib.sh      |  57 +++
 .../selftests/net/forwarding/local_termination.sh  | 435 +++++++++++++++++----
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  76 +++-
 tools/testing/selftests/net/udpgro.sh              |  53 +--
 tools/testing/selftests/tc-testing/tdc.py          |   1 -
 74 files changed, 1562 insertions(+), 561 deletions(-)

