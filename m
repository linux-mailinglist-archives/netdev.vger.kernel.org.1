Return-Path: <netdev+bounces-151440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1399EF103
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAA8189B54B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30986229669;
	Thu, 12 Dec 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH8FSCkx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A2229665;
	Thu, 12 Dec 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020079; cv=none; b=m54d0qXrZ5xxFX21jQUMjuUebR7at6WS+cjrshbtiEjLuod3Dvg0aafKpz5lKqBWMkWAuPGBywfHTeAqD+MLOsRzOlDBrzxZsAQUnEnskGAhyz5c4x6NMSXLJh/zo1tXiYwg90wjTxZA/9QXcN+I4fHYCPe102fyODafyOfcw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020079; c=relaxed/simple;
	bh=egvFnmqYg+JWrBeEqC24t5PZ9YjSy50VDbevzNSgIvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SOp0U48B9/JZHppekrAS15YeINNKKZiQczUBVfzSAtqdYpA79FEoQjyLzvHXE/O/v5OSJ1MN8pmpbLbUmUaLmtnYoBGw7ibHHhC15VTGacs1kpvx3PGT8qzeY5FSAoOuGKJXjjegu5RtKPKg0yBhibSM86vIC6/n0v7JpIQBtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH8FSCkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6A3C4CECE;
	Thu, 12 Dec 2024 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734020078;
	bh=egvFnmqYg+JWrBeEqC24t5PZ9YjSy50VDbevzNSgIvc=;
	h=From:To:Cc:Subject:Date:From;
	b=NH8FSCkxN4olXoYB+fcI4oe2fE7IGlgcbRzwz+Oq06IB/4JLtAMVlJPJVwtUASqva
	 1GIfuS1jh1RMfXNUWwVJE5XA/MDDOqi6t5ElDhrKbwRooafhvMUMMWgnci32XGADNe
	 xEGVw2p5vKLvYUe5cRTXFJFLwdjk2YHFMYTvPenQmk2UORVpMzNbt/lWYoYTOaYHOK
	 erCPMrJ55ad0x/ch2N2N9mmT7NCMtur8Skbdy/PbEHco+hEZvYYhovZWslwwT0uM9d
	 Oa2gTCSv44ktgWHu1hfwW/Nocb1p9b3oFTUzJHPDzwew0ty+kTJGj1DZuYus4E8gn0
	 Bn2TyVPIugObQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.13-rc3
Date: Thu, 12 Dec 2024 08:14:37 -0800
Message-ID: <20241212161437.3823483-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The file rename may stand out, the code is from this merge window.

The following changes since commit 896d8946da97332d4dc80fa1937d8dd6b1c35ad4:

  Merge tag 'net-6.13-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-12-05 10:25:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc3

for you to fetch changes up to ad913dfd8bfacdf1d2232fe9f49ccb025885ef22:

  Merge tag 'for-net-2024-12-12' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth (2024-12-12 07:10:40 -0800)

----------------------------------------------------------------
Including fixes from bluetooth, netfilter and wireless.

Current release - fix to a fix:

 - rtnetlink: fix error code in rtnl_newlink()

 - tipc: fix NULL deref in cleanup_bearer()

Current release - regressions:

 - ip: fix warning about invalid return from in ip_route_input_rcu()

Current release - new code bugs:

 - udp: fix L4 hash after reconnect

 - eth: lan969x: fix cyclic dependency between modules

 - eth: bnxt_en: fix potential crash when dumping FW log coredump

Previous releases - regressions:

 - wifi: mac80211:
   - fix a queue stall in certain cases of channel switch
   - wake the queues in case of failure in resume

 - splice: do not checksum AF_UNIX sockets

 - virtio_net: fix BUG()s in BQL support due to incorrect accounting
   of purged packets during interface stop

 - eth: stmmac: fix TSO DMA API mis-usage causing oops

 - eth: bnxt_en: fixes for HW GRO: GSO type on 5750X chips and
   oops due to incorrect aggregation ID mask on 5760X chips

Previous releases - always broken:

 - Bluetooth: improve setsockopt() handling of malformed user input

 - eth: ocelot: fix PTP timestamping in presence of packet loss

 - ptp: kvm: x86: avoid "fail to initialize ptp_kvm" when simply
   not supported

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: cfg80211: clear link ID from bitmap during link delete after clean up

Anumula Murali Mohan Reddy (1):
      cxgb4: use port number to set mac addr

Benjamin Lin (1):
      wifi: mac80211: fix station NSS capability initialization order

Dan Carpenter (2):
      net/mlx5: DR, prevent potential error pointer dereference
      rtnetlink: fix error code in rtnl_newlink()

Daniel Borkmann (5):
      net, team, bonding: Add netdev_base_features helper
      bonding: Fix initial {vlan,mpls}_feature set in bond_compute_features
      bonding: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
      team: Fix initial vlan_feature set in __team_compute_features
      team: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL

Daniel Machon (5):
      net: lan969x: fix cyclic dependency reported by depmod
      net: lan969x: fix the use of spin_lock in PTP handler
      net: sparx5: fix FDMA performance issue
      net: sparx5: fix default value of monitor ports
      net: sparx5: fix the maximum frame length register

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FE910C04 compositions

Danielle Ratson (3):
      selftests: mlxsw: sharedbuffer: Remove h1 ingress test case
      selftests: mlxsw: sharedbuffer: Remove duplicate test cases
      selftests: mlxsw: sharedbuffer: Ensure no extra packets are counted

David S. Miller (1):
      Merge branch 'net-sparx5-lan969x-fixes'

Emmanuel Grumbach (2):
      wifi: mac80211: wake the queues in case of failure in resume
      wifi: mac80211: fix a queue stall in certain cases of CSA

Eric Dumazet (3):
      tipc: fix NULL deref in cleanup_bearer()
      net: lapb: increase LAPB_HEADER_LEN
      net: defer final 'struct net' free in netns dismantle

Felix Fietkau (1):
      wifi: mac80211: fix vif addr when switching from monitor to station

Florian Westphal (1):
      netfilter: nf_tables: do not defer rule destruction via call_rcu

Frederik Deweerdt (1):
      splice: do not checksum AF_UNIX sockets

Frédéric Danis (1):
      Bluetooth: SCO: Add support for 16 bits transparent voice setting

Geetha sowjanya (1):
      octeontx2-af: Fix installation of PF multicast rule

Haoyu Li (2):
      wifi: mac80211: init cnt before accessing elem in ieee80211_copy_mbssid_beacon
      wifi: cfg80211: sme: init n_channels before channels[] access

Hongguang Gao (1):
      bnxt_en: Fix potential crash when dumping FW log coredump

Issam Hamdi (1):
      wifi: mac80211: fix mbss changed flags corruption on 32 bit systems

Iulia Tanasescu (4):
      Bluetooth: iso: Always release hdev at the end of iso_listen_bis
      Bluetooth: iso: Fix recursive locking warning
      Bluetooth: iso: Fix circular lock in iso_listen_bis
      Bluetooth: iso: Fix circular lock in iso_conn_big_sync

Jakub Kicinski (9):
      Merge branch 'selftests-mlxsw-add-few-fixes-for-sharedbuffer-test'
      Merge branch 'bnxt_en-bug-fixes'
      Merge branch 'ocelot-ptp-fixes'
      Merge branch 'qca_spi-fix-spi-specific-issues'
      Merge tag 'wireless-2024-12-10' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'net-renesas-rswitch-several-fixes'
      Merge branch 'mana-fix-few-memory-leaks-in-mana_gd_setup_irqs'
      Merge tag 'batadv-net-pullrequest-20241210' of git://git.open-mesh.org/linux-merge
      Merge tag 'for-net-2024-12-12' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth

Jesse Van Gavere (1):
      net: dsa: microchip: KSZ9896 register regmap alignment to 32 bit boundaries

Koichiro Den (6):
      virtio_net: correct netdev_tx_reset_queue() invocation point
      virtio_net: replace vq2rxq with vq2txq where appropriate
      virtio_ring: add a func argument 'recycle_done' to virtqueue_resize()
      virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
      virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
      virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx

Kuniyuki Iwashima (1):
      ip: Return drop reason if in_dev is NULL in ip_route_input_rcu().

Lin Ma (1):
      wifi: nl80211: fix NL80211_ATTR_MLO_LINK_ID off-by-one

Luiz Augusto von Dentz (2):
      Bluetooth: hci_core: Fix sleeping function called from invalid context
      Bluetooth: hci_event: Fix using rcu_read_(un)lock while iterating

Martin Ottens (1):
      net/sched: netem: account for backlog updates from child qdisc

Maxim Levitsky (2):
      net: mana: Fix memory leak in mana_gd_setup_irqs
      net: mana: Fix irq_contexts memory leak in mana_gd_setup_irqs

Michael Chan (2):
      bnxt_en: Fix GSO type for HW GRO packets on 5750X chips
      bnxt_en: Fix aggregation ID mask to prevent oops on 5760X chips

Michal Luczaj (1):
      Bluetooth: Improve setsockopt() handling of malformed user input

MoYuanhao (1):
      tcp: check space before adding MPTCP SYN options

Nikita Yushchenko (6):
      net: renesas: rswitch: fix possible early skb release
      net: renesas: rswitch: fix race window between tx start and complete
      net: renesas: rswitch: fix leaked pointer on error path
      net: renesas: rswitch: avoid use-after-put for a device tree node
      net: renesas: rswitch: handle stop vs interrupt race
      net: renesas: rswitch: fix initial MPIC register setting

Paolo Abeni (3):
      Merge branch 'virtio_net-correct-netdev_tx_reset_queue-invocation-points'
      udp: fix l4 hash after reconnect
      Merge tag 'nf-24-12-11' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Petr Machata (1):
      Documentation: networking: Add a caveat to nexthop_compat_mode sysctl

Phil Sutter (2):
      selftests: netfilter: Stabilize rpath.sh
      netfilter: IDLETIMER: Fix for possible ABBA deadlock

Remi Pommarel (3):
      batman-adv: Do not send uninitialized TT changes
      batman-adv: Remove uninitialized data in full table TT response
      batman-adv: Do not let TT changes list grows indefinitely

Robert Hodaszi (1):
      net: dsa: tag_ocelot_8021q: fix broken reception

Russell King (Oracle) (1):
      net: stmmac: fix TSO DMA API usage causing oops

Simon Horman (1):
      MAINTAINERS: Add ethtool.h to NETWORKING [GENERAL]

Stefan Wahren (2):
      qca_spi: Fix clock speed for multiple QCA7000
      qca_spi: Make driver probing reliable

Thadeu Lima de Souza Cascardo (1):
      Bluetooth: btmtk: avoid UAF in btmtk_process_coredump

Thomas Weißschuh (1):
      ptp: kvm: x86: Return EOPNOTSUPP instead of ENODEV from kvm_arch_ptp_init()

Vladimir Oltean (6):
      net: mscc: ocelot: fix memory leak on ocelot_port_add_txtstamp_skb()
      net: mscc: ocelot: improve handling of TX timestamp for unknown skb
      net: mscc: ocelot: ocelot->ts_id_lock and ocelot_port->tx_skbs.lock are IRQ-safe
      net: mscc: ocelot: be resilient to loss of PTP packets during transmission
      net: mscc: ocelot: perform error cleanup in ocelot_hwstamp_set()
      net: dsa: felix: fix stuck CPU-injected packets with short taprio windows

 Documentation/networking/ip-sysctl.rst             |   6 +
 MAINTAINERS                                        |   4 +-
 drivers/bluetooth/btmtk.c                          |  20 +-
 drivers/net/bonding/bond_main.c                    |  10 +-
 drivers/net/dsa/microchip/ksz_common.c             |  42 ++---
 drivers/net/dsa/ocelot/felix_vsc9959.c             |  17 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  18 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   9 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c         |   5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |  18 +-
 .../mellanox/mlx5/core/steering/sws/dr_domain.c    |   4 +-
 drivers/net/ethernet/microchip/Kconfig             |   1 -
 drivers/net/ethernet/microchip/Makefile            |   1 -
 drivers/net/ethernet/microchip/lan969x/Kconfig     |   5 -
 drivers/net/ethernet/microchip/lan969x/Makefile    |  13 --
 drivers/net/ethernet/microchip/sparx5/Kconfig      |   6 +
 drivers/net/ethernet/microchip/sparx5/Makefile     |   6 +
 .../microchip/{ => sparx5}/lan969x/lan969x.c       |   9 +-
 .../microchip/{ => sparx5}/lan969x/lan969x.h       |   0
 .../{ => sparx5}/lan969x/lan969x_calendar.c        |   0
 .../microchip/{ => sparx5}/lan969x/lan969x_regs.c  |   0
 .../{ => sparx5}/lan969x/lan969x_vcap_ag_api.c     |   0
 .../{ => sparx5}/lan969x/lan969x_vcap_impl.c       |   0
 .../ethernet/microchip/sparx5/sparx5_calendar.c    |   2 -
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  15 +-
 .../net/ethernet/microchip/sparx5/sparx5_mirror.c  |   3 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |   1 -
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |   6 +-
 drivers/net/ethernet/mscc/ocelot_ptp.c             | 207 +++++++++++++--------
 drivers/net/ethernet/qualcomm/qca_spi.c            |  26 ++-
 drivers/net/ethernet/qualcomm/qca_spi.h            |   1 -
 drivers/net/ethernet/renesas/rswitch.c             |  95 ++++++----
 drivers/net/ethernet/renesas/rswitch.h             |  14 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   7 +-
 drivers/net/team/team_core.c                       |  11 +-
 drivers/net/usb/qmi_wwan.c                         |   3 +
 drivers/net/virtio_net.c                           |  31 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   2 +-
 drivers/ptp/ptp_kvm_x86.c                          |   6 +-
 drivers/virtio/virtio_ring.c                       |  12 +-
 include/linux/dsa/ocelot.h                         |   1 +
 include/linux/netdev_features.h                    |   7 +
 include/linux/virtio.h                             |   6 +-
 include/net/bluetooth/bluetooth.h                  |  10 +-
 include/net/bluetooth/hci_core.h                   | 108 +++++++----
 include/net/lapb.h                                 |   2 +-
 include/net/mac80211.h                             |   7 +-
 include/net/net_namespace.h                        |   1 +
 include/net/netfilter/nf_tables.h                  |   4 -
 include/soc/mscc/ocelot.h                          |   2 -
 net/batman-adv/translation-table.c                 |  58 ++++--
 net/bluetooth/hci_core.c                           |  10 +-
 net/bluetooth/hci_event.c                          |  33 ++--
 net/bluetooth/hci_sock.c                           |  14 +-
 net/bluetooth/iso.c                                |  77 ++++++--
 net/bluetooth/l2cap_core.c                         |  12 +-
 net/bluetooth/l2cap_sock.c                         |  20 +-
 net/bluetooth/rfcomm/core.c                        |   6 +
 net/bluetooth/rfcomm/sock.c                        |   9 +-
 net/bluetooth/sco.c                                |  52 +++---
 net/core/net_namespace.c                           |  20 +-
 net/core/rtnetlink.c                               |   4 +-
 net/dsa/tag_ocelot_8021q.c                         |   2 +-
 net/ipv4/datagram.c                                |   8 +-
 net/ipv4/route.c                                   |   3 +-
 net/ipv4/tcp_output.c                              |   6 +-
 net/mac80211/cfg.c                                 |  17 +-
 net/mac80211/ieee80211_i.h                         |  49 ++++-
 net/mac80211/iface.c                               |  23 +--
 net/mac80211/mesh.c                                |   6 +-
 net/mac80211/mlme.c                                |   2 -
 net/mac80211/util.c                                |  26 +--
 net/netfilter/nf_tables_api.c                      |  32 ++--
 net/netfilter/xt_IDLETIMER.c                       |  52 +++---
 net/sched/sch_netem.c                              |  22 ++-
 net/tipc/udp_media.c                               |   7 +-
 net/unix/af_unix.c                                 |   1 +
 net/wireless/nl80211.c                             |   2 +-
 net/wireless/sme.c                                 |   1 +
 net/wireless/util.c                                |   3 +-
 .../selftests/drivers/net/mlxsw/sharedbuffer.sh    |  55 ++++--
 tools/testing/selftests/net/netfilter/rpath.sh     |  18 +-
 85 files changed, 857 insertions(+), 583 deletions(-)
 delete mode 100644 drivers/net/ethernet/microchip/lan969x/Kconfig
 delete mode 100644 drivers/net/ethernet/microchip/lan969x/Makefile
 rename drivers/net/ethernet/microchip/{ => sparx5}/lan969x/lan969x.c (97%)
 rename drivers/net/ethernet/microchip/{ => sparx5}/lan969x/lan969x.h (100%)
 rename drivers/net/ethernet/microchip/{ => sparx5}/lan969x/lan969x_calendar.c (100%)
 rename drivers/net/ethernet/microchip/{ => sparx5}/lan969x/lan969x_regs.c (100%)
 rename drivers/net/ethernet/microchip/{ => sparx5}/lan969x/lan969x_vcap_ag_api.c (100%)
 rename drivers/net/ethernet/microchip/{ => sparx5}/lan969x/lan969x_vcap_impl.c (100%)

