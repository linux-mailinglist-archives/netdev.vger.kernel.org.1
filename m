Return-Path: <netdev+bounces-166180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC9EA34DDF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB7616C078
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6819724169B;
	Thu, 13 Feb 2025 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL8xBjEU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD141422DD;
	Thu, 13 Feb 2025 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472115; cv=none; b=ojRZT4R3wHJffBAM1ok3UBMDXKwnvfBRy3gURk/fa+ZVtBvvvHDPZxEHWFqonJFeDJN9e9k+ndToBxVG7Ef5TvW0nEnIEv0IKopNGf0/GJGZXw61JYhstri67IwCxFvgKkabmWlvw4z46/yYiFrx8GNHCRMREBmHIdqEibz8uT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472115; c=relaxed/simple;
	bh=+Y35GvQ54z/WLmnN2A5b+6Acpzq3Q96exnspm6yq/Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T2sMF5TQaXI6eVdNbi4ViWZZRBAIDtG7pJqB8nP6oodlKank25sDdVt6moL5D8mYpT7xQM50hD048a6IEHgg/6hGet3XuNtKVqVPNvSMGc7UOov8WkxP241EP62Dhj7bGXhithXSWyilgagMzmrwUKVygxRg9xDlmz/IDmMg/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL8xBjEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2247C4CED1;
	Thu, 13 Feb 2025 18:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739472115;
	bh=+Y35GvQ54z/WLmnN2A5b+6Acpzq3Q96exnspm6yq/Og=;
	h=From:To:Cc:Subject:Date:From;
	b=hL8xBjEUYcWWnfe2pQB+/Q/riktgLT5scoN9vyo7lgB5BgpiZv3oKlWo7tq58WYMt
	 1UISNvpK+uT1JVDfOop45xHT5o7F33aV9uy2Aj4HQEQguebllNAilmHb1Nyv6gkX1Q
	 e8dUNOPg9It64KNiVvgLkO5fwPhiMYpu7RmCmBRFNJQ0xe8rq9ljsYV2FIYmAUGPd/
	 tcPYUVCiujHN/pvr6kcT862dcylksoSVgrAwi9NdQ81uUkZMoQXUbq5b5ofgevfKsp
	 a8CWESME3IDRFH9KcEbOiI7SWBiMOfGUJ5gmlQGGytQxwZ4F36jOm+EH83WsjeCIrz
	 p7q1C1iPcJwhQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.14-rc3
Date: Thu, 13 Feb 2025 10:41:54 -0800
Message-ID: <20250213184154.793578-1-kuba@kernel.org>
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

The following changes since commit 3cf0a98fea776adb09087e521fe150c295a4b031:

  Merge tag 'net-6.14-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-02-06 09:14:54 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.14-rc3

for you to fetch changes up to 488fb6effe03e20f38d34da7425de77bbd3e2665:

  net: pse-pd: Fix deadlock in current limit functions (2025-02-13 10:00:39 -0800)

----------------------------------------------------------------
Including fixes from netfilter, wireless and bluetooth.

Kalle Valo steps down after serving as the WiFi driver maintainer
for over a decade.

Current release - fix to a fix:

 - vsock: orphan socket after transport release, avoid null-deref

 - Bluetooth: L2CAP: fix corrupted list in hci_chan_del

Current release - regressions:

 - eth: stmmac: correct Rx buffer layout when SPH is enabled

 - rxrpc: fix alteration of headers whilst zerocopy pending

 - eth: iavf: fix a locking bug in an error path

 - s390/qeth: move netif_napi_add_tx() and napi_enable() from under BH

 - Revert "netfilter: flowtable: teardown flow if cached mtu is stale"

Current release - new code bugs:

 - rxrpc: fix ipv6 path MTU discovery, only ipv4 worked

 - pse-pd: fix deadlock in current limit functions

Previous releases - regressions:

 - rtnetlink: fix netns refleak with rtnl_setlink()

 - wifi: brcmfmac: use random seed flag for BCM4355 and BCM4364 firmware

Previous releases - always broken:

 - add missing RCU protection of struct net throughout the stack

 - can: rockchip: bail out if skb cannot be allocated

 - eth: ti: am65-cpsw: base XDP support fixes

Misc:

 - ethtool: tsconfig: update the format of hwtstamp flags,
   changes the uAPI but this uAPI was not in any release yet

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aditya Garg (1):
      wifi: brcmfmac: use random seed flag for BCM4355 and BCM4364 firmware

Aditya Kumar Singh (1):
      wifi: ath12k: fix handling of 6 GHz rules

Alexander Hölzl (1):
      can: j1939: j1939_sk_send_loop(): fix unable to send messages with data length zero

Alexandra Winter (1):
      s390/qeth: move netif_napi_add_tx() and napi_enable() from under BH

Andy Strohman (1):
      batman-adv: fix panic during interface removal

Bart Van Assche (1):
      iavf: Fix a locking bug in an error path

David Howells (2):
      rxrpc: Fix alteration of headers whilst zerocopy pending
      rxrpc: Fix ipv6 path MTU discovery

David Woodhouse (1):
      ptp: vmclock: Add .owner to vmclock_miscdev_fops

Eric Dumazet (24):
      net: add dev_net_rcu() helper
      ipv4: add RCU protection to ip4_dst_hoplimit()
      ipv4: use RCU protection in ip_dst_mtu_maybe_forward()
      ipv4: use RCU protection in ipv4_default_advmss()
      ipv4: use RCU protection in rt_is_expired()
      ipv4: use RCU protection in inet_select_addr()
      ipv4: use RCU protection in __ip_rt_update_pmtu()
      ipv4: icmp: convert to dev_net_rcu()
      flow_dissector: use RCU protection to fetch dev_net()
      ipv6: use RCU protection in ip6_default_advmss()
      ipv6: icmp: convert to dev_net_rcu()
      ipv6: Use RCU in ip6_input()
      net: fib_rules: annotate data-races around rule->[io]ifindex
      ndisc: ndisc_send_redirect() must use dev_get_by_index_rcu()
      ndisc: use RCU protection in ndisc_alloc_skb()
      neighbour: use RCU protection in __neigh_notify()
      arp: use RCU protection in arp_xmit()
      openvswitch: use RCU protection in ovs_vport_cmd_fill_info()
      vrf: use RCU protection in l3mdev_l3_out()
      ndisc: extend RCU protection in ndisc_send_skb()
      ipv6: mcast: extend RCU protection in igmp6_send()
      vxlan: check vxlan_vnigroup_init() return value
      team: better TEAM_OPTION_TYPE_STRING validation
      ipv6: mcast: add RCU protection to mld_newpack()

Fedor Pchelkin (1):
      can: ctucanfd: handle skb allocation failure

Furong Xu (1):
      net: stmmac: Apply new page pool parameters when SPH is enabled

Jakub Kicinski (10):
      Merge branch 'net-first-round-to-use-dev_net_rcu'
      Merge branch 'net-second-round-to-use-dev_net_rcu'
      Merge tag 'wireless-2025-02-07' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'linux-can-fixes-for-6.14-20250208' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'vsock-null-ptr-deref-when-so_linger-enabled'
      Merge branch 'net-ethernet-ti-am65-cpsw-xdp-fixes'
      Reapply "net: skb: introduce and use a single page frag cache"
      Merge tag 'nf-25-02-13' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'for-net-2025-02-13' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth

Joshua Hay (1):
      idpf: call set_real_num_queues in idpf_open

Kalle Valo (3):
      Merge tag 'ath-current-20250124' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      MAINTAINERS: wifi: ath: remove Kalle
      MAINTAINERS: wifi: remove Kalle

Kiran K (1):
      Bluetooth: btintel_pcie: Fix a potential race condition

Kory Maincent (2):
      net: ethtool: tsconfig: Fix netlink type of hwtstamp flags
      net: pse-pd: Fix deadlock in current limit functions

Krzysztof Kozlowski (1):
      can: c_can: fix unbalanced runtime PM disable in error path

Luiz Augusto von Dentz (2):
      Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
      Bluetooth: L2CAP: Fix corrupted list in hci_chan_del

Marcelo Ricardo Leitner (1):
      MAINTAINERS: Add sctp headers to the general netdev entry

Michal Luczaj (2):
      vsock: Orphan socket after transport release
      vsock/test: Add test for SO_LINGER null ptr deref

Murad Masimov (1):
      ax25: Fix refcount leak caused by setting SO_BINDTODEVICE sockopt

Nicolas Dichtel (1):
      rtnetlink: fix netns leak with rtnl_setlink()

Pablo Neira Ayuso (1):
      Revert "netfilter: flowtable: teardown flow if cached mtu is stale"

Paolo Abeni (3):
      Revert "net: skb: introduce and use a single page frag cache"
      Merge branch 'ptp-vmclock-bugfixes-and-cleanups-for-error-handling'
      Merge tag 'batadv-net-pullrequest-20250207' of git://git.open-mesh.org/linux-merge

Piotr Kwapulinski (1):
      ixgbe: Fix possible skb NULL pointer dereference

Remi Pommarel (1):
      batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1()

Reyders Morales (1):
      Documentation/networking: fix basic node example document ISO 15765-2

Robin van der Gracht (1):
      can: rockchip: rkcanfd_handle_rx_fifo_overflow_int(): bail out if skb cannot be allocated

Roger Quadros (3):
      net: ethernet: ti: am65-cpsw: fix memleak in certain XDP cases
      net: ethernet: ti: am65-cpsw: fix RX & TX statistics for XDP_TX case
      net: ethernet: ti: am65_cpsw: fix tx_cleanup for XDP case

Russell King (Oracle) (1):
      net: phylink: make configuring clock-stop dependent on MAC support

Song Yoong Siang (1):
      igc: Set buffer type for empty frames in igc_init_empty_frame

Sridhar Samudrala (2):
      idpf: fix handling rsc packet with a single segment
      idpf: record rx queue in skb for RSC packets

Sven Eckelmann (2):
      batman-adv: Ignore neighbor throughput metrics in error case
      batman-adv: Drop unmanaged ELP metric worker

Thomas Weißschuh (4):
      ptp: vmclock: Set driver data before its usage
      ptp: vmclock: Don't unregister misc device if it was not registered
      ptp: vmclock: Clean up miscdev and ptp clock through devres
      ptp: vmclock: Remove goto-based cleanup logic

Vincent Mailhol (1):
      can: etas_es58x: fix potential NULL pointer dereference on udev->serial

Wentao Liang (1):
      mlxsw: Add return value check for mlxsw_sp_port_get_stats_raw()

Zdenek Bouska (1):
      igc: Fix HW RX timestamp when passed by ZC XDP

 .mailmap                                           |   1 +
 .../bindings/net/wireless/qcom,ath10k.yaml         |   1 -
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |   1 -
 .../bindings/net/wireless/qcom,ath11k.yaml         |   1 -
 .../bindings/net/wireless/qcom,ath12k-wsi.yaml     |   1 -
 .../bindings/net/wireless/qcom,ath12k.yaml         |   1 -
 Documentation/netlink/specs/ethtool.yaml           |   3 +-
 Documentation/networking/iso15765-2.rst            |   4 +-
 MAINTAINERS                                        |   8 +-
 drivers/bluetooth/btintel_pcie.c                   |   5 +-
 drivers/net/can/c_can/c_can_platform.c             |   5 +-
 drivers/net/can/ctucanfd/ctucanfd_base.c           |  10 +-
 drivers/net/can/rockchip/rockchip_canfd-core.c     |   2 +-
 drivers/net/can/usb/etas_es58x/es58x_devlink.c     |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   5 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   5 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |  22 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   5 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  50 +++---
 drivers/net/phy/phylink.c                          |  15 +-
 drivers/net/pse-pd/pse_core.c                      |   4 +-
 drivers/net/team/team_core.c                       |   4 +-
 drivers/net/vxlan/vxlan_core.c                     |   7 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  61 ++++++--
 drivers/net/wireless/ath/ath12k/wmi.h              |   1 -
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   4 +-
 drivers/ptp/ptp_vmclock.c                          |  47 +++---
 drivers/s390/net/qeth_core_main.c                  |   8 +-
 include/linux/netdevice.h                          |   6 +
 include/net/bluetooth/l2cap.h                      |   3 +-
 include/net/ip.h                                   |  13 +-
 include/net/l3mdev.h                               |   2 +
 include/net/net_namespace.h                        |   2 +-
 include/net/route.h                                |   9 +-
 include/uapi/linux/ethtool.h                       |   2 +
 net/ax25/af_ax25.c                                 |  11 ++
 net/batman-adv/bat_v.c                             |   2 -
 net/batman-adv/bat_v_elp.c                         | 122 ++++++++++-----
 net/batman-adv/bat_v_elp.h                         |   2 -
 net/batman-adv/translation-table.c                 |  12 +-
 net/batman-adv/types.h                             |   3 -
 net/bluetooth/l2cap_core.c                         | 169 ++++++++++-----------
 net/bluetooth/l2cap_sock.c                         |  15 +-
 net/can/j1939/socket.c                             |   4 +-
 net/can/j1939/transport.c                          |   5 +-
 net/core/fib_rules.c                               |  24 +--
 net/core/flow_dissector.c                          |  21 +--
 net/core/neighbour.c                               |   8 +-
 net/core/rtnetlink.c                               |   1 +
 net/ethtool/common.c                               |   5 +
 net/ethtool/common.h                               |   2 +
 net/ethtool/strset.c                               |   5 +
 net/ethtool/tsconfig.c                             |  33 ++--
 net/ipv4/arp.c                                     |   4 +-
 net/ipv4/devinet.c                                 |   3 +-
 net/ipv4/icmp.c                                    |  31 ++--
 net/ipv4/route.c                                   |  30 ++--
 net/ipv6/icmp.c                                    |  42 ++---
 net/ipv6/ip6_input.c                               |  14 +-
 net/ipv6/mcast.c                                   |  45 +++---
 net/ipv6/ndisc.c                                   |  28 ++--
 net/ipv6/route.c                                   |   7 +-
 net/netfilter/nf_flow_table_ip.c                   |   8 +-
 net/openvswitch/datapath.c                         |  12 +-
 net/rxrpc/ar-internal.h                            |   7 +-
 net/rxrpc/output.c                                 |  50 ++++--
 net/rxrpc/peer_event.c                             |   7 +
 net/rxrpc/rxkad.c                                  |  13 +-
 net/rxrpc/sendmsg.c                                |   4 +-
 net/rxrpc/txbuf.c                                  |  37 ++---
 net/vmw_vsock/af_vsock.c                           |   8 +-
 tools/testing/vsock/vsock_test.c                   |  41 +++++
 75 files changed, 709 insertions(+), 458 deletions(-)

