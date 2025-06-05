Return-Path: <netdev+bounces-195292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE15DACF3DC
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 18:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CD4189C8F8
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA81F91D6;
	Thu,  5 Jun 2025 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6BlH1fX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3533062;
	Thu,  5 Jun 2025 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139933; cv=none; b=oVVC/ptMCjObgT1S4JJX5LNtKg556kJxnM7uKwJ43H2W9m76vuyXg4neSmJBZAHpyrNq4tnoBF9EJwQ01UJ2iXugu0AA9RuhKual+VqDeYMIsvA1y0R0IFXwHPQNkeGvFsytaHSutYZNQfcBvittuAWyfOJRSzZKTM2Jt4Xk+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139933; c=relaxed/simple;
	bh=c7jgBo/AzI0O1+jT39VW9dZxBQdtvZE7DTKrrDXU5h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=odPuweKBkH8ZJUhvtuaLYixbHFehl9PAs2RRaZYF7Cl5QHt3mke7kYcCfuPRXmCxA3KhbQe0QhOmMlGpTuAzpZktv8IP/0HEHhr/wJL0paqiXYxbpjjVNv9nshMppdjE9Nt6EokHJCylhIm3noXj20L/0MkbWnFqpZOYX8oeBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6BlH1fX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038B8C4CEE7;
	Thu,  5 Jun 2025 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749139933;
	bh=c7jgBo/AzI0O1+jT39VW9dZxBQdtvZE7DTKrrDXU5h8=;
	h=From:To:Cc:Subject:Date:From;
	b=l6BlH1fX3l+BValQrzqY1TnsKBZgV4k8+UdcXnRuvCJA3BJ1S+iV/Uap6sC3WHKZc
	 hYKbXuGBlXTIkEd4GIbcHfKm/V+1TQeK37iTA3YJ5q2LgYQ+/leICcPzWrVg1kLonc
	 9HAQlKNJo/clem5t+GS23unDuzRVRyc7AvH8vFyi6DvlNOmH527428gHhQjzZZKd83
	 v1b0HkdtlJwnJ3MZfhMtCGtPBIJShXxdmR4HkInb/ClWrHTh0G5Kuij6C4Sqd8l79/
	 sCEeso3gy+g835BJJOaHvU7m6VRjlcoSlhphd2gUGNppHA+YuAAq81VHDmWLMrx4In
	 JfzgUXpi15qvw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.16-rc1
Date: Thu,  5 Jun 2025 09:12:12 -0700
Message-ID: <20250605161212.145569-1-kuba@kernel.org>
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

The following changes since commit 90b83efa6701656e02c86e7df2cb1765ea602d07:

  Merge tag 'bpf-next-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next (2025-05-28 15:52:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc1

for you to fetch changes up to 3cae906e1a6184cdc9e4d260e4dbdf9a118d94ad:

  calipso: unlock rcu before returning -EAFNOSUPPORT (2025-06-05 08:03:38 -0700)

----------------------------------------------------------------
Including fixes from CAN, wireless, Bluetooth, and Netfilter.

Current release - regressions:

 - Revert "kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN
   in all_tests", makes kunit error out if compiler is old

 - wifi: iwlwifi: mvm: fix assert on suspend

 - rxrpc: fix return from none_validate_challenge()

Current release - new code bugs:

 - ovpn: couple of fixes for socket cleanup and UDP-tunnel teardown

 - can: kvaser_pciefd: refine error prone echo_skb_max handling logic

 - fix net_devmem_bind_dmabuf() stub when DEVMEM not compiled

 - eth: airoha: fixes for config / accel in bridge mode

Previous releases - regressions:

 - Bluetooth: hci_qca: move the SoC type check to the right place,
   fix GPIO integration

 - prevent a NULL deref in rtnl_create_link() after locking changes

 - fix udp gso skb_segment after pull from frag_list

 - hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()

Previous releases - always broken:

 - netfilter:
   - nf_nat: also check reverse tuple to obtain clashing entry
   - nf_set_pipapo_avx2: fix initial map fill (zeroing)

 - fix the helper for incremental update of packet checksums after
   modifying the IP address, used by ILA and BPF

 - eth: stmmac: prevent div by 0 when clock rate is misconfigured

 - eth: ice: fix Tx scheduler handling of XDP and changing queue count

 - eth: b53: fix support for the RGMII interface when delays configured

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexis Lothoré (2):
      net: stmmac: make sure that ptp_rate is not 0 before configuring timestamping
      net: stmmac: make sure that ptp_rate is not 0 before configuring EST

Alok Tiwari (2):
      gve: Fix RX_BUFFERS_POSTED stat to report per-queue fill_cnt
      gve: add missing NULL check for gve_alloc_pending_packet() in TX DQO

Antonio Quartulli (5):
      ovpn: properly deconfigure UDP-tunnel
      ovpn: ensure sk is still valid during cleanup
      ovpn: avoid sleep in atomic context in TCP RX error path
      selftest/net/ovpn: fix TCP socket creation
      selftest/net/ovpn: fix missing file

Bartosz Golaszewski (1):
      Bluetooth: hci_qca: move the SoC type check to the right place

Brian Vazquez (1):
      idpf: fix a race in txq wakeup

Bui Quang Minh (1):
      selftests: net: build net/lib dependency in all target

Charalampos Mitrodimas (1):
      net: tipc: fix refcount warning in tipc_aead_encrypt

Dan Carpenter (1):
      net/mlx4_en: Prevent potential integer overflow calculating Hz

Daniele Palmas (1):
      net: wwan: mhi_wwan_mbim: use correct mux_id for multiplexing

David Howells (1):
      rxrpc: Fix return from none_validate_challenge()

Dmitry Antipov (1):
      Bluetooth: MGMT: reject malformed HCI_CMD_SYNC commands

Dong Chenchen (1):
      page_pool: Fix use-after-free in page_pool_recycle_in_ring

Emil Tantilov (1):
      idpf: avoid mailbox timeout delays during reset

Eric Dumazet (3):
      net: annotate data-races around cleanup_net_task
      net: prevent a NULL deref in rtnl_create_link()
      calipso: unlock rcu before returning -EAFNOSUPPORT

Fedor Pchelkin (1):
      can: kvaser_pciefd: refine error prone echo_skb_max handling logic

Florian Westphal (5):
      netfilter: nf_set_pipapo_avx2: fix initial map fill
      selftests: netfilter: nft_concat_range.sh: prefer per element counters for testing
      selftests: netfilter: nft_concat_range.sh: add datapath check for map fill bug
      netfilter: nf_nat: also check reverse tuple to obtain clashing entry
      selftests: netfilter: nft_nat.sh: add test for reverse clash with nat

Geert Uytterhoeven (1):
      hinic3: Remove printed message during module init

Horatiu Vultur (1):
      net: lan966x: Make sure to insert the vlan tags also in host mode

Ido Schimmel (1):
      seg6: Fix validation of nexthop addresses

Ilan Peer (1):
      wifi: iwlwifi: mld: Move regulatory domain initialization

Jakub Kicinski (11):
      Merge tag 'for-net-2025-05-30' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'net-stmmac-prevent-div-by-0'
      Merge branch 'net-fix-inet_proto_csum_replace_by_diff-for-ipv6'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Revert "kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
      netlink: specs: rt-link: add missing byte-order properties
      netlink: specs: rt-link: decode ip6gre
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      selftests: drv-net: add configs for the TSO test
      selftests: drv-net: tso: fix the GRE device name
      selftests: drv-net: tso: make bkg() wait for socat to quit

Jinjian Song (1):
      net: wwan: t7xx: Fix napi rx poll issue

Johannes Berg (2):
      wifi: iwlwifi: pcie: fix non-MSIX handshake register
      Merge tag 'iwlwifi-fixes-2025-06-04' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Jonas Gorski (5):
      net: dsa: b53: do not enable EEE on bcm63xx
      net: dsa: b53: do not enable RGMII delay on bcm63xx
      net: dsa: b53: do not configure bcm63xx's IMP port interface
      net: dsa: b53: allow RGMII for bcm63xx RGMII ports
      net: dsa: b53: do not touch DLL_IQQD on bcm53115

Krzysztof Kozlowski (1):
      Bluetooth: btnxpuart: Fix missing devm_request_irq() return value check

Lachlan Hodges (1):
      wifi: cfg80211/mac80211: correctly parse S1G beacon optional elements

Lorenzo Bianconi (3):
      net: airoha: Initialize PPE UPDMEM source-mac table
      net: airoha: Fix IPv6 hw acceleration in bridge mode
      net: airoha: Fix smac_id configuration in bridge mode

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix not responding with L2CAP_CR_LE_ENCRYPTION

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix swapped TX stats for MII interfaces.

Michal Kubiak (3):
      ice: fix Tx scheduler error handling in XDP callback
      ice: create new Tx scheduler nodes for new queues only
      ice: fix rebuilding the Tx scheduler tree for large queue counts

Mirco Barone (1):
      wireguard: device: enable threaded NAPI

Miri Korenblit (2):
      wifi: iwlwifi: mvm: fix assert on suspend
      wifi: iwlwifi: mld: avoid panic on init failure

Oliver Neukum (1):
      net: usb: aqc111: debug info before sanitation

Paolo Abeni (7):
      Merge tag 'linux-can-fixes-for-6.16-20250529' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'net-airoha-fix-ipv6-hw-acceleration'
      Merge branch 'net-dsa-b53-fix-rgmii-ports'
      Merge tag 'ovpn-net-20250603' of https://github.com/OpenVPN/ovpn-net-next
      Merge branch 'netlink-specs-rt-link-decode-ip6gre'
      Merge tag 'nf-25-06-05' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'wireless-2025-06-05' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Paul Chaignon (2):
      net: Fix checksum update for ILA adj-transport
      bpf: Fix L4 csum update on IPv6 in CHECKSUM_COMPLETE

Pranjal Shrivastava (1):
      net: Fix net_devmem_bind_dmabuf for non-devmem configs

Przemek Kitszel (6):
      iavf: iavf_suspend(): take RTNL before netdev_lock()
      iavf: centralize watchdog requeueing itself
      iavf: simplify watchdog_task in terms of adminq task scheduling
      iavf: extract iavf_watchdog_step() out of iavf_watchdog_task()
      iavf: sprinkle netdev_assert_locked() annotations
      iavf: get rid of the crit lock

Qasim Ijaz (1):
      net: ch9200: fix uninitialised access during mii_nway_restart

Quentin Schulz (1):
      net: stmmac: platform: guarantee uniqueness of bus_id

Ronak Doshi (1):
      vmxnet3: correctly report gso type for UDP tunnels

Saurabh Sengar (1):
      hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()

Shiming Cheng (1):
      net: fix udp gso skb_segment after pull from frag_list

Tengteng Yang (1):
      Fix sock_exceed_buf_limit not being triggered in __sk_mem_raise_allocated

Yanqing Wang (1):
      driver: net: ethernet: mtk_star_emac: fix suspend/resume issue

Álvaro Fernández Rojas (1):
      net: dsa: tag_brcm: legacy: fix pskb_may_pull length

 Documentation/netlink/specs/rt-link.yaml           |  68 ++++-
 drivers/bluetooth/btnxpuart.c                      |   2 +
 drivers/bluetooth/hci_qca.c                        |  14 +-
 drivers/net/can/kvaser_pciefd.c                    |   3 +-
 drivers/net/dsa/b53/b53_common.c                   |  58 ++--
 drivers/net/ethernet/airoha/airoha_eth.c           |   2 +
 drivers/net/ethernet/airoha/airoha_eth.h           |   1 +
 drivers/net/ethernet/airoha/airoha_ppe.c           |  52 +++-
 drivers/net/ethernet/airoha/airoha_regs.h          |  10 +
 drivers/net/ethernet/google/gve/gve_main.c         |   2 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |   3 +
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c   |   2 -
 drivers/net/ethernet/intel/iavf/iavf.h             |   1 -
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  29 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 291 +++++++--------------
 drivers/net/ethernet/intel/ice/ice_main.c          |  47 +++-
 drivers/net/ethernet/intel/ice/ice_sched.c         | 181 ++++++++++---
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |  18 +-
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |   9 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |  45 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |   8 -
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h    |   1 +
 drivers/net/ethernet/mediatek/mtk_star_emac.c      |   4 +
 drivers/net/ethernet/mellanox/mlx4/en_clock.c      |   2 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |   1 +
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |   1 +
 .../ethernet/microchip/lan966x/lan966x_switchdev.c |   1 +
 .../net/ethernet/microchip/lan966x/lan966x_vlan.c  |  21 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c   |   5 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   5 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  11 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c        |   8 +
 drivers/net/hyperv/netvsc_bpf.c                    |   2 +-
 drivers/net/hyperv/netvsc_drv.c                    |   4 +-
 drivers/net/ovpn/io.c                              |   8 +-
 drivers/net/ovpn/netlink.c                         |  16 +-
 drivers/net/ovpn/peer.c                            |   4 +-
 drivers/net/ovpn/socket.c                          |  68 ++---
 drivers/net/ovpn/socket.h                          |   4 +-
 drivers/net/ovpn/tcp.c                             |  73 +++---
 drivers/net/ovpn/tcp.h                             |   3 +-
 drivers/net/ovpn/udp.c                             |  46 ++--
 drivers/net/ovpn/udp.h                             |   4 +-
 drivers/net/usb/aqc111.c                           |   8 +-
 drivers/net/usb/ch9200.c                           |   7 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |  26 ++
 drivers/net/wireguard/device.c                     |   1 +
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   2 +-
 drivers/net/wwan/mhi_wwan_mbim.c                   |   9 +-
 drivers/net/wwan/t7xx/t7xx_netdev.c                |  11 +-
 include/linux/ieee80211.h                          |  79 +++++-
 include/net/checksum.h                             |   2 +-
 include/uapi/linux/bpf.h                           |   2 +
 net/bluetooth/l2cap_core.c                         |   3 +-
 net/bluetooth/mgmt.c                               |   3 +-
 net/core/dev.c                                     |   3 +-
 net/core/devmem.h                                  |   3 +-
 net/core/filter.c                                  |   5 +-
 net/core/net_namespace.c                           |   4 +-
 net/core/page_pool.c                               |  27 +-
 net/core/rtnetlink.c                               |   2 +-
 net/core/sock.c                                    |   8 +-
 net/core/utils.c                                   |   4 +-
 net/dsa/tag_brcm.c                                 |   2 +-
 net/ipv4/udp_offload.c                             |   5 +
 net/ipv6/ila/ila_common.c                          |   6 +-
 net/ipv6/seg6_local.c                              |   6 +-
 net/mac80211/mlme.c                                |   7 +-
 net/mac80211/scan.c                                |  11 +-
 net/netfilter/nf_nat_core.c                        |  12 +-
 net/netfilter/nft_set_pipapo_avx2.c                |  21 +-
 net/netlabel/netlabel_kapi.c                       |   6 +-
 net/rxrpc/insecure.c                               |   5 +-
 net/tipc/crypto.c                                  |   6 +-
 net/wireless/scan.c                                |  18 +-
 tools/include/uapi/linux/bpf.h                     |   2 +
 tools/testing/kunit/configs/all_tests.config       |   1 -
 tools/testing/selftests/Makefile                   |   2 +-
 tools/testing/selftests/drivers/net/hw/config      |   5 +
 tools/testing/selftests/drivers/net/hw/tso.py      |   4 +-
 .../selftests/net/netfilter/nft_concat_range.sh    | 102 +++++++-
 tools/testing/selftests/net/netfilter/nft_nat.sh   |  81 +++++-
 tools/testing/selftests/net/ovpn/ovpn-cli.c        |   1 +
 tools/testing/selftests/net/ovpn/test-large-mtu.sh |   9 +
 89 files changed, 1060 insertions(+), 618 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/config
 create mode 100755 tools/testing/selftests/net/ovpn/test-large-mtu.sh

