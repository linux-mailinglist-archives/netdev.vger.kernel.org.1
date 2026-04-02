Return-Path: <netdev+bounces-274623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLg0M6GZzmkBowYAu9opvQ
	(envelope-from <netdev+bounces-274623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:30:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE138BDF4
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E7FD3082D9A
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 16:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356A13F0775;
	Thu,  2 Apr 2026 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Coy43pY4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C013EF0B7;
	Thu,  2 Apr 2026 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147124; cv=none; b=EMna5AcuucNDQVEMBxd/cd3vLSh8IBNA8/qO7wm9TcgYsvPO6ld9l4a4ggf+yL/8tzvOxD0UbrKUU8TbGDkwSO/qEWzruOhcwOHst3cZxrz41nk54Ry8kizOGJwK2K9HJ9wCV6ia0UmM31ebJbwSuRNz/ZqNOyTGXcJJgocZOcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147124; c=relaxed/simple;
	bh=+cEuwGniw8jie2a1Gp6VPjs5LbKlyS3DkqDlrV6u0g0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RzlibCidImHzJIzKxmuIAxVidpNWAgcYoKm7akfG88haYjKR1AuumBiLmFfVC3Tj+tRLNPR1sX5NxK8U13WgGsd/2NiHCh33qA/ipKRIxpDQoQ1W0IZlmx5a2mE49xvBYfgzG3mZBYsei58Ponbv47eKF86gtlI+dZh19QxRFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Coy43pY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D366C2BC9E;
	Thu,  2 Apr 2026 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147123;
	bh=+cEuwGniw8jie2a1Gp6VPjs5LbKlyS3DkqDlrV6u0g0=;
	h=From:To:Cc:Subject:Date:From;
	b=Coy43pY4EIj62nWy81lxYnnie7HQTdh7gkAH3YC0uSNOES8hvlG2yawuQCnvUX/qG
	 +rZ+xo6CoQTZ4KsUyiKcCrwXSAHontmp0Z8WSlN0Ctm7Nt8TBEEq5y4hXCGxT0RyXK
	 fg1EXRC8AKjiTwOcaZcO3AvS+uof1dqHfvJj6B3mPW97wVQYOhQ4qtIGi2YxfUvJs0
	 tNTyqxCcb+OhaqmnYZKdJ2YPBUW5BYillGlzvgn2lBSpl6fRCql9MzaPtoZ9kRd431
	 Vq785nPlOO9NhXQpyqQ3dQt5E4+J6SH3X7E0Jx2RbY6d8Jpzhyw4rBXadO43WFjN+f
	 bWUNeHC8RvEUw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.0-rc7
Date: Thu,  2 Apr 2026 09:25:22 -0700
Message-ID: <20260402162522.666383-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274623-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 65EE138BDF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus!

The following changes since commit 453a4a5f97f0c95b7df458e6afb98d4ab057d90b:

  Merge tag 'net-7.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-03-26 09:53:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc7

for you to fetch changes up to ec7067e661193403a7a00980bda8612db5954142:

  eth: fbnic: Increase FBNIC_QUEUE_SIZE_MIN to 64 (2026-04-02 08:38:34 -0700)

----------------------------------------------------------------
With fixes from wireless, bluetooth and Netfilter included we're back
to each PR carrying 30%+ more fixes than in previous era. The good
news is that so far none of the "extra" fixes are themselves
causing real regressions. Not sure how much comfort that is.

Current release - fix to a fix:

 - netdevsim: fix build if SKB_EXTENSIONS=n

 - eth: stmmac: skip VLAN restore when VLAN hash ops are missing

Previous releases - regressions:

 - wifi: iwlwifi: mvm: don't send a 6E related command when
   not supported

Previous releases - always broken:

 - some info leak fixes

 - add missing clearing of skb->cb[] on ICMP paths from tunnels

 - ipv6: flowlabel: defer exclusive option free until RCU teardown

 - ipv6: avoid overflows in ip6_datagram_send_ctl()

 - mpls: add seqcount to protect platform_labels from OOB access

 - bridge: improve safety of parsing ND options

 - Bluetooth: fix leaks, overflows and races in hci_sync

 - netfilter: add more input validation, some to address bugs directly
   some to prevent exploits from cooking up broken configurations

 - wifi: ath: avoid poor performance due to stopping the wrong
   aggregation session

 - wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free

 - eth: fec: fix the PTP periodic output sysfs interface

 - eth: enetc: safely reinitialize TX BD ring when it has unsent frames

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexander Popov (1):
      wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free

Alexey Velichayshiy (1):
      wifi: iwlwifi: mvm: fix potential out-of-bounds read in iwl_mvm_nd_match_info_handler()

Buday Csaba (1):
      net: fec: fix the PTP periodic output sysfs interface

Cen Zhang (1):
      Bluetooth: SCO: fix race conditions in sco_sock_connect()

David Carlier (1):
      net: ti: icssg-prueth: fix missing data copy and wrong recycle in ZC RX dispatch

Dimitri Daskalakis (3):
      eth: fbnic: Account for page fragments when updating BDQ tail
      eth: fbnic: Fix debugfs output for BDQ's with page frags
      eth: fbnic: Increase FBNIC_QUEUE_SIZE_MIN to 64

Dipayaan Roy (1):
      net: mana: Fix RX skb truesize accounting

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: don't send a 6E related command when not supported

Eric Dumazet (3):
      ipv6: icmp: clear skb2->cb[] in ip6_err_gen_icmpv6_unreach()
      ip6_tunnel: clear skb2->cb[] in ip4ip6_err()
      ipv6: avoid overflows in ip6_datagram_send_ctl()

Fedor Pchelkin (2):
      net: macb: fix clk handling on PCI glue driver removal
      net: macb: properly unregister fixed rate clocks

Florian Westphal (3):
      netfilter: nfnetlink_log: account for netlink header size
      netfilter: x_tables: ensure names are nul-terminated
      netfilter: ipset: use nla_strcmp for IPSET_ATTR_NAME attr

Guoyu Su (1):
      net: use skb_header_pointer() for TCPv4 GSO frag_off check

Hangbin Liu (1):
      ipv6: fix data race in fib6_metric_set() using cmpxchg

Jakub Kicinski (10):
      Merge tag 'wireless-2026-03-26' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'net-enetc-safely-reinitialize-tx-bd-ring-when-it-has-unsent-frames'
      Merge branch 'fix-page-fragment-handling-when-page_size-4k'
      Merge branch 'bridge-vxlan-harden-nd-option-parsing-paths'
      Merge branch 'net-enetc-add-more-checks-to-enetc_set_rxfh'
      Merge tag 'for-net-2026-04-01' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'nf-26-04-01' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'mlx5-misc-fixes-2026-03-30'
      Merge branch 'bnxt_en-bug-fixes'
      Merge branch 'net-hsr-fixes-for-prp-duplication-and-vlan-unwind'

Jiayuan Chen (1):
      net: qrtr: replace qrtr_tx_flow radix_tree with xarray to fix memory leak

Johannes Berg (3):
      wifi: iwlwifi: mld: correctly set wifi generation data
      Merge tag 'iwlwifi-fixes-2026-03-24' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'ath-current-20260324' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Jonathan Rissanen (1):
      Bluetooth: hci_h4: Fix race during initialization

Keenan Dong (2):
      Bluetooth: MGMT: validate LTK enc_size on load
      Bluetooth: MGMT: validate mesh send advertising payload length

Li Xiasong (1):
      mptcp: fix soft lockup in mptcp_recvmsg()

Lorenzo Bianconi (2):
      net: airoha: Add missing cleanup bits in airoha_qdma_cleanup_rx_queue()
      net: airoha: Delay offloading until all net_devices are fully registered

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix UAF in le_read_features_complete

Luka Gejak (2):
      net: hsr: serialize seq_blocks merge across nodes
      net: hsr: fix VLAN add unwind on slave errors

Marek Behún (1):
      net: sfp: Fix Ubiquiti U-Fiber Instant SFP module on mvneta

Martin Schiller (2):
      net/x25: Fix potential double free of skb
      net/x25: Fix overflow when accumulating packets

Michael Chan (2):
      bnxt_en: Refactor some basic ring setup and adjustment logic
      bnxt_en: Don't assume XDP is never enabled in bnxt_init_dflt_ring_mode()

Michal Piekos (1):
      net: stmmac: skip VLAN restore when VLAN hash ops are missing

Oleh Konko (3):
      Bluetooth: hci_event: move wake reason storage into validated event handlers
      Bluetooth: SMP: force responder MITM requirements before building the pairing response
      Bluetooth: SMP: derive legacy responder STK authentication from MITM state

Pablo Neira Ayuso (4):
      netfilter: flowtable: strictly check for maximum number of actions
      netfilter: ctnetlink: ignore explicit helper on new expectations
      netfilter: x_tables: restrict xt_check_match/xt_check_target extensions for NFPROTO_ARP
      netfilter: nf_tables: reject immediate NF_QUEUE verdict

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: mld: Fix MLO scan timing

Paolo Abeni (3):
      ipv6: prevent possible UaF in addrconf_permanent_addr()
      Merge branch 'correct-bd-length-masks-and-bql-accounting-for-multi-bd-tx-packets'
      Merge branch 'net-x25-fix-overflow-and-double-free'

Pauli Virtanen (5):
      Bluetooth: hci_sync: call destroy in hci_cmd_sync_run if immediate
      Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
      Bluetooth: hci_sync: fix leaks when hci_cmd_sync_queue_once fails
      Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync
      Bluetooth: hci_event: fix potential UAF in hci_le_remote_conn_param_req_evt

Pavan Chebbi (1):
      bnxt_en: Restore default stat ctxs for ULP when resource is available

Pengpeng Hou (4):
      wifi: wl1251: validate packet IDs before indexing tx_frames
      net/ipv6: ioam6: prevent schema length wraparound in trace fill
      bnxt_en: set backing store type from query type
      NFC: pn533: bound the UART receive buffer

Qi Tang (2):
      netfilter: nf_conntrack_helper: pass helper to expect cleanup
      netfilter: ctnetlink: zero expect NAT fields when CTA_EXPECT_NAT absent

Qingfang Deng (1):
      netdevsim: fix build if SKB_EXTENSIONS=n

Reshma Immaculate Rajkumar (2):
      wifi: ath11k: Pass the correct value of each TID during a stop AMPDU session
      wifi: ath12k: Pass the correct value of each TID during a stop AMPDU session

Sabrina Dubroca (1):
      mpls: add seqcount to protect the platform_label{,s} pair

Saeed Mahameed (2):
      net/mlx5: Avoid "No data available" when FW version queries fail
      net/mlx5: Fix switchdev mode rollback in case of failure

Shay Drory (1):
      net/mlx5: lag: Check for LAG device before creating debugfs

Srujana Challa (1):
      virtio_net: clamp rss_max_key_size to NETDEV_RSS_KEY_LEN

Stefano Garzarella (1):
      vsock: initialize child_ns_mode_locked in vsock_net_init()

Suraj Gupta (2):
      net: xilinx: axienet: Correct BD length masks to match AXIDMA IP spec
      net: xilinx: axienet: Fix BQL accounting for multi-BD TX packets

Sven Eckelmann (Plasma Cloud) (1):
      net: ethernet: mtk_ppe: avoid NULL deref when gmac0 is disabled

Thomas Bogendoerfer (1):
      tg3: Fix race for querying speed/duplex

Wei Fang (5):
      net: enetc: reset PIR and CIR if they are not equal when initializing TX ring
      net: enetc: add graceful stop to safely reinitialize the TX Ring
      net: enetc: do not access non-existent registers on pseudo MAC
      net: enetc: check whether the RSS algorithm is Toeplitz
      net: enetc: do not allow VF to configure the RSS key

Weiming Shi (1):
      rds: ib: reject FRMR registration before IB connection is established

Xiang Mei (7):
      net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
      selftests/tc-testing: add test for HFSC divide-by-zero in rtsc_min()
      net: bonding: fix use-after-free in bond_xmit_broadcast()
      bridge: mrp: reject zero test interval to avoid OOM panic
      net/sched: cls_fw: fix NULL pointer dereference on shared blocks
      net/sched: cls_flow: fix NULL pointer dereference on shared blocks
      selftests/tc-testing: add tests for cls_fw and cls_flow on shared blocks

Yang Yang (3):
      bridge: br_nd_send: linearize skb before parsing ND options
      bridge: br_nd_send: validate ND option lengths
      vxlan: validate ND option lengths in vxlan_na_create

Yasuaki Torimaru (1):
      wifi: wilc1000: fix u8 overflow in SSID scan buffer size calculation

Yifan Wu (1):
      netfilter: ipset: drop logically empty buckets in mtype_del

Yochai Eisenrich (2):
      net: ipv6: ndisc: fix ndisc_ra_useropt to initialize nduseropt_padX fields to zero to prevent an info-leak
      net: sched: cls_api: fix tc_chain_fill_node to initialize tcm_info to zero to prevent an info-leak

Yucheng Lu (1):
      net/sched: sch_netem: fix out-of-bounds access in packet corruption

Yufan Chen (1):
      net: ftgmac100: fix ring allocation unwind on open failure

Zhengchuan Liang (1):
      net: ipv6: flowlabel: defer exclusive option free until RCU teardown

hkbinbin (1):
      Bluetooth: hci_sync: fix stack buffer overflow in hci_le_big_create_sync

 drivers/bluetooth/hci_h4.c                         |   3 -
 drivers/net/bonding/bond_main.c                    |   2 +-
 drivers/net/ethernet/airoha/airoha_eth.c           |  20 ++-
 drivers/net/ethernet/airoha/airoha_eth.h           |   1 +
 drivers/net/ethernet/airoha/airoha_ppe.c           |   7 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  76 +++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |   5 +-
 drivers/net/ethernet/broadcom/tg3.c                |   2 +-
 drivers/net/ethernet/cadence/macb_pci.c            |  10 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |  28 ++-
 drivers/net/ethernet/freescale/enetc/enetc.c       |  13 +-
 drivers/net/ethernet/freescale/enetc/enetc4_hw.h   |  11 ++
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c   | 118 +++++++++++--
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |  10 +-
 drivers/net/ethernet/freescale/fec_ptp.c           |   3 -
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c    |  21 ++-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |   4 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |  49 ++++--
 .../net/ethernet/mellanox/mlx5/core/lag/debugfs.c  |   3 +
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c    |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |   6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |   2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   7 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  14 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c       |   2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |   4 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   9 +-
 drivers/net/phy/sfp.c                              |   7 +-
 drivers/net/virtio_net.c                           |  20 +--
 drivers/net/vxlan/vxlan_core.c                     |   6 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  15 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   4 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |   5 +
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h   |  10 ++
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     | 101 +++++++----
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  19 ++
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   1 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   5 +
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |  30 +++-
 drivers/net/wireless/intel/iwlwifi/mld/scan.h      |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   3 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |   2 +-
 drivers/net/wireless/ti/wl1251/tx.c                |   8 +-
 drivers/net/wireless/virtual/virt_wifi.c           |   1 -
 drivers/nfc/pn533/uart.c                           |   3 +
 include/linux/netfilter/ipset/ip_set.h             |   2 +-
 include/linux/skbuff.h                             |   1 +
 include/net/netns/mpls.h                           |   1 +
 net/bluetooth/hci_conn.c                           |   8 +-
 net/bluetooth/hci_event.c                          | 127 ++++++-------
 net/bluetooth/hci_sync.c                           |  88 ++++++---
 net/bluetooth/mgmt.c                               |  17 +-
 net/bluetooth/sco.c                                |  30 +++-
 net/bluetooth/smp.c                                |  11 +-
 net/bridge/br_arp_nd_proxy.c                       |  18 +-
 net/bridge/br_mrp_netlink.c                        |   4 +-
 net/core/dev.c                                     |  11 +-
 net/hsr/hsr_device.c                               |  32 ++--
 net/hsr/hsr_framereg.c                             |  38 +++-
 net/ipv6/addrconf.c                                |   6 +-
 net/ipv6/datagram.c                                |  10 ++
 net/ipv6/icmp.c                                    |   3 +
 net/ipv6/ioam6.c                                   |   4 +-
 net/ipv6/ip6_fib.c                                 |  14 +-
 net/ipv6/ip6_flowlabel.c                           |   5 -
 net/ipv6/ip6_tunnel.c                              |   5 +
 net/ipv6/ndisc.c                                   |   3 +
 net/mpls/af_mpls.c                                 |  29 ++-
 net/mptcp/protocol.c                               |  11 +-
 net/netfilter/ipset/ip_set_core.c                  |   4 +-
 net/netfilter/ipset/ip_set_hash_gen.h              |   2 +-
 net/netfilter/ipset/ip_set_list_set.c              |   4 +-
 net/netfilter/nf_conntrack_helper.c                |   2 +-
 net/netfilter/nf_conntrack_netlink.c               |  60 ++-----
 net/netfilter/nf_flow_table_offload.c              | 196 ++++++++++++++-------
 net/netfilter/nf_tables_api.c                      |   7 +-
 net/netfilter/nfnetlink_log.c                      |   2 +-
 net/netfilter/x_tables.c                           |  23 +++
 net/netfilter/xt_cgroup.c                          |   6 +
 net/netfilter/xt_rateest.c                         |   5 +
 net/qrtr/af_qrtr.c                                 |  31 ++--
 net/rds/ib_rdma.c                                  |   7 +-
 net/sched/cls_api.c                                |   1 +
 net/sched/cls_flow.c                               |  10 +-
 net/sched/cls_fw.c                                 |  14 +-
 net/sched/sch_hfsc.c                               |   4 +-
 net/sched/sch_netem.c                              |   5 +-
 net/vmw_vsock/af_vsock.c                           |   1 +
 net/x25/x25_in.c                                   |   9 +-
 net/x25/x25_subr.c                                 |   1 +
 .../tc-testing/tc-tests/infra/filter.json          |  44 +++++
 .../tc-testing/tc-tests/infra/qdiscs.json          |  25 +++
 98 files changed, 1147 insertions(+), 493 deletions(-)

