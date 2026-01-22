Return-Path: <netdev+bounces-252465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIksFIBmcml0kAAAu9opvQ
	(envelope-from <netdev+bounces-252465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:03:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CF56BE78
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E67D130370BB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9643783A1;
	Thu, 22 Jan 2026 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnLlGdW0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FCC36F400;
	Thu, 22 Jan 2026 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101218; cv=none; b=WhiIyCNvhLTqD/2g96km7Pyu93afXmzMuPZOV70ZHjvAUjFQ8tm2PEV7Ro565xOg/gcbG60hy9iSWmuhD5jR8UQclkCxlDTC9WDH+XbZjmWPv9B8Xxv9EaFEWxXzOEcmqbiRq06lBEnH1TdodNvNMWpNbzuW9Yj+92neYq4xl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101218; c=relaxed/simple;
	bh=AGRfaRpcIPGtdS76Lm3RYD8zARNuQXZYHKBqPYy7rNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NXS7QvfdrsRr6205LN3s3CwSB07Thcxf9sEdpaQVs8VPE5pwqtqEL6E4CkT4Kt3wDdeJ87DJ7m5WLTThIAiNdR9ZtuJ47px6sTYinUSLacK/k3sX+yfSNUxV8ulP2bkqUKW/qTlMvER/5Tk3/weuGi+MVrv9dIrjToZRbCDIu3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnLlGdW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C10C2BCB1;
	Thu, 22 Jan 2026 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769101218;
	bh=AGRfaRpcIPGtdS76Lm3RYD8zARNuQXZYHKBqPYy7rNY=;
	h=From:To:Cc:Subject:Date:From;
	b=BnLlGdW0rNy2pUIJWcLjzMIzAd5ULuf9yP740JCZYc94/XRPaDbnfw9AeOWRNj5zL
	 8H+cIQq8ra8MmqxB7ZDGCWbg5f6mUnuyNpDFNbojZdUoh3GJTBQX7od39uUCBsIPjC
	 Rl4PhEKSb1aiviT3DMc8kl3jIOxN9qn9kxquqw32tQgIyVyLbYd+0hT/kKlOrZu4w3
	 Vpil0aRQg2y9Mr57VpWx3syHVN6hF743LPCb3YfoZcrIqKWyprFQqgkDDQNVoLCcPX
	 Nduqt+7yDuSUfiuVu+m9YfYgVauqqLgRIXNlsG6Mfb5cQAtBHJ6UTFcILxsBxHM4MC
	 MuHCVCukt0uOg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.19-rc7
Date: Thu, 22 Jan 2026 09:00:16 -0800
Message-ID: <20260122170016.3148026-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252465-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ynl-regen.sh:url]
X-Rspamd-Queue-Id: 52CF56BE78
X-Rspamd-Action: no action

Hi Linus!

The following changes since commit 9e995c573b63453a904f3157813dc8cde4a6aba4:

  Merge tag 'net-6.19-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-01-15 10:11:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.19-rc7

for you to fetch changes up to 4a3dba48188208e4f66822800e042686784d29d1:

  Octeontx2-af: Add proper checks for fwdata (2026-01-22 08:09:00 -0800)

----------------------------------------------------------------
Including fixes from CAN and wireless.

Pretty big PR, but hard to make up any cohesive story that would
explain it, a random collection of fixes. The two reverts of bad
patches from this release here feel like stuff that'd normally
show up by rc5 or rc6. Perhaps obvious thing to say, given the MW
timing.

That said, no active investigations / regressions. Let's see what
the next week brings.

Current release - fix to a fix:

 - can: alloc_candev_mqs(): add missing default CAN capabilities

Current release - regressions:

 - usbnet: fix crash due to missing BQL accounting after resume

 - Revert "net: wwan: mhi_wwan_mbim: Avoid -Wflex-array-member-not ...

Previous releases - regressions:

 - Revert "nfc/nci: Add the inconsistency check between the input ...

Previous releases - always broken:

 - number of driver fixes for incorrect use of seqlocks on stats

 - rxrpc: fix recvmsg() unconditional requeue, don't corrupt rcv queue
   when MSG_PEEK was set

 - ipvlan: make the addrs_lock be per port avoid races in the port
   hash table

 - sched: enforce that teql can only be used as root qdisc

 - virtio: coalesce only linear skb

 - wifi: ath12k: fix dead lock while flushing management frames

 - eth: igc: reduce TSN TX packet buffer from 7KB to 5KB per queue

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alok Tiwari (1):
      octeontx2: cn10k: fix RX flowid TCAM mask handling

Andrey Vatoropin (1):
      be2net: Fix NULL pointer dereference in be_cmd_get_mac_from_list

Baochen Qiang (2):
      wifi: ath12k: don't force radio frequency check in freq_to_idx()
      wifi: ath12k: fix dead lock while flushing management frames

Benjamin Berg (3):
      wifi: mac80211: parse all TTLM entries
      wifi: mac80211: apply advertised TTLM from association response
      wifi: cfg80211: ignore link disabled flag from userspace

Chwee-Lin Choong (2):
      igc: fix race condition in TX timestamp read for register 0
      igc: Reduce TSN TX packet buffer from 7KB to 5KB per queue

Clemens Gruber (1):
      net: fec: account for VLAN header in frame length calculations

Cody Haas (1):
      ice: Fix persistent failure in ice_get_rxfh

Dan Carpenter (1):
      wifi: mwifiex: Fix a loop in mwifiex_update_ampdu_rxwinsize()

Daniel Golle (2):
      net: phy: intel-xway: fix OF node refcount leakage
      net: pcs: pcs-mtk-lynxi: report in-band capability for 2500Base-X

Dave Ertman (1):
      ice: Avoid detrimental cleanup for bond during interface stop

David Howells (2):
      rxrpc: Fix recvmsg() unconditional requeue
      rxrpc: Fix data-race warning and potential load/store tearing

David Yang (5):
      veth: fix data race in veth_get_ethtool_stats
      net: hns3: fix data race in hns3_fetch_stats
      idpf: Fix data race in idpf_net_dim
      be2net: fix data race in be_get_new_eqd
      net: openvswitch: fix data race in ovs_vport_get_upcall_stats

Ding Hui (1):
      ice: Fix incorrect timeout ice_release_res()

Dmitry Skorodumov (2):
      ipvlan: Make the addrs_lock be per port
      selftests: net: simple selftest for ipvtap

Eric Dumazet (7):
      net: add skb->data_len and (skb>end - skb->tail) to skb_dump()
      bonding: limit BOND_MODE_8023AD to Ethernet devices
      l2tp: avoid one data-race in l2tp_tunnel_del_work()
      mISDN: annotate data-race around dev->work
      ipv6: annotate data-race in ndisc_router_discovery()
      bonding: provide a net pointer to __skb_flow_dissect()
      net/sched: act_ife: avoid possible NULL deref

Ethan Nelson-Moore (1):
      net: usb: dm9601: remove broken SR9700 support

Fan Gong (1):
      hinic3: Fix netif_queue_set_napi queue_index input parameter error

Hamza Mahfooz (1):
      net: sfp: add potron quirk to the H-COM SPP425H-GAB4 SFP+ Stick

Hariprasad Kelam (2):
      Octeontx2-pf: Update xdp features
      Octeontx2-af: Add proper checks for fwdata

Ivan Vecera (1):
      dpll: Prevent duplicate registrations

Jacob Keller (1):
      ice: initialize ring_stats->syncp

Jakub Kicinski (9):
      Merge branch 'vsock-virtio-fix-data-loss-disclosure-due-to-joining-of-non-linear-skb'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'fou-gue-fix-skb-memleak-with-inner-protocol-0'
      Merge branch 'ipvlan-addrs_lock-made-per-port'
      Merge tag 'linux-can-fixes-for-6.19-20260116' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'net-sched-teql-enforce-hierarchy-placement'
      Merge branch 'fix-some-bugs-in-the-flow-director-of-hns3-driver'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'wireless-2026-11-22' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jamal Hadi Salim (2):
      net/sched: Enforce that teql can only be used as root qdisc
      net/sched: qfq: Use cl_is_active to determine whether class is active in qfq_rm_from_ag

Jeongjun Park (1):
      netrom: fix double-free in nr_route_frame()

Jiawen Wu (1):
      net: txgbe: remove the redundant data return in SW-FW mailbox

Jijie Shao (2):
      net: hns3: fix wrong GENMASK() for HCLGE_FD_AD_COUNTER_NUM_M
      net: hns3: fix the HCLGE_FD_AD_NXT_KEY error setting issue

Johannes Berg (1):
      Merge tag 'ath-current-20260113' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath into wireless

Justin Chen (1):
      net: bcmasp: Fix network filter wake for asp-3.0

Krzysztof Kozlowski (1):
      nfc: MAINTAINERS: Orphan the NFC and look for new maintainers

Kuniyuki Iwashima (4):
      l2tp: Fix memleak in l2tp_udp_encap_recv().
      gue: Fix skb memleak with inner IP protocol 0.
      tools: ynl: Specify --no-line-number in ynl-regen.sh.
      fou: Don't allow 0 for FOU_ATTR_IPPROTO.

Kurt Kanzenbach (1):
      igc: Restore default Qbv schedule when changing channels

Lachlan Hodges (1):
      wifi: mac80211: don't perform DA check on S1G beacon

Laurent Vivier (1):
      usbnet: limit max_mtu based on device's hard_mtu

Manish Dharanenthiran (1):
      wifi: ath12k: cancel scan only on active scan vdev

Marc Kleine-Budde (8):
      can: dev: alloc_candev_mqs(): add missing default CAN capabilities
      can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error
      can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak
      can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak
      can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix URB memory leak
      can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB memory leak
      can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB memory leak
      Merge patch series "can: usb: fix URB memory leaks"

Marek Vasut (1):
      wifi: rsi: Fix memory corruption due to not set vif driver data size

Maxime Chevallier (1):
      net: freescale: ucc_geth: Return early when TBI PHY can't be found

Melbin K Mathew (3):
      vsock/virtio: fix potential underflow in virtio_transport_get_credit()
      vsock/virtio: cap TX credit to local buffer size
      vsock/test: add stream TX credit bounds test

Michal Luczaj (3):
      vsock/virtio: Coalesce only linear skb
      vsock/test: Add test for a linear and non-linear skb getting coalesced
      vsock/test: Do not filter kallsyms by symbol type

Michel Lind (1):
      tools/net/ynl: Makefile's install target now installs ynltool

Mina Almasry (1):
      idpf: read lower clock bits inside the time sandwich

Miri Korenblit (2):
      wifi: mac80211: correctly check if CSA is active
      wifi: mac80211: don't increment crypto_tx_tailroom_needed_cnt twice

Paolo Abeni (1):
      Merge branch 'vsock-virtio-fix-tx-credit-handling'

Paul Greenwalt (2):
      ice: add missing ice_deinit_hw() in devlink reinit path
      ice: fix devlink reload call trace

Raju Rangoju (1):
      amd-xgbe: avoid misleading per-packet error log

Ratheesh Kannoth (1):
      octeontx2-af: Fix error handling

Ricardo B. Marlière (1):
      selftests: net: fib-onlink-tests: Convert to use namespaces by default

Russell King (Oracle) (1):
      net: stmmac: fix resume: calculate tso last_segment

Simon Horman (1):
      docs: netdev: refine 15-patch limit

Simon Schippers (1):
      usbnet: fix crash due to missing BQL accounting after resume

Slark Xiao (1):
      Revert "net: wwan: mhi_wwan_mbim: Avoid -Wflex-array-member-not-at-end warning"

Stefano Garzarella (1):
      vsock/test: fix seqpacket message bounds test

Taehee Yoo (1):
      selftests: net: amt: wait longer for connection before sending packets

Thadeu Lima de Souza Cascardo (1):
      Revert "nfc/nci: Add the inconsistency check between the input data length and count"

Thomas Fourier (3):
      wifi: ath10k: fix dma_free_coherent() pointer
      wifi: ath12k: fix dma_free_coherent() pointer
      octeontx2: Fix otx2_dma_map_page() error return code

Veerendranath Jakkam (1):
      wifi: cfg80211: Fix bitrate calculation overflow for HE rates

Victor Nogueira (1):
      selftests/tc-testing: Try to add teql as a child qdisc

Vladimir Oltean (1):
      net: dsa: fix off-by-one in maximum bridge ID determination

Xin Long (1):
      sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT

Yingying Tang (2):
      wifi: ath12k: Fix scan state stuck in ABORTING after cancel_remain_on_channel
      wifi: ath12k: Fix wrong P2P device link id issue

Yun Lu (1):
      netdevsim: fix a race issue related to the operation on bpf_bound_progs list

 CREDITS                                            |   4 +
 Documentation/netlink/specs/fou.yaml               |   2 +
 Documentation/process/maintainer-netdev.rst        |  12 ++
 MAINTAINERS                                        |   3 +-
 drivers/dpll/dpll_core.c                           |  12 +-
 drivers/isdn/mISDN/timerdev.c                      |  13 +-
 drivers/net/bonding/bond_main.c                    |  11 +-
 drivers/net/can/dev/dev.c                          |   1 +
 drivers/net/can/usb/ems_usb.c                      |   8 +-
 drivers/net/can/usb/esd_usb.c                      |   9 +-
 drivers/net/can/usb/gs_usb.c                       |   7 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   9 +-
 drivers/net/can/usb/mcba_usb.c                     |   8 +-
 drivers/net/can/usb/usb_8dev.c                     |   8 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |   5 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |   5 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.h        |   1 +
 drivers/net/ethernet/emulex/benet/be_cmds.c        |   3 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   8 +-
 drivers/net/ethernet/freescale/fec_main.c          |  13 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  69 +++----
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   2 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c    |  22 ++-
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |   1 +
 drivers/net/ethernet/intel/ice/ice.h               |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c        |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |  29 ++-
 drivers/net/ethernet/intel/ice/ice_main.c          |  31 ++-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c         |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |  16 +-
 drivers/net/ethernet/intel/igc/igc_defines.h       |   5 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   4 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   5 +
 drivers/net/ethernet/intel/igc/igc_ptp.c           |  43 +++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  86 ++++++---
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |   3 +
 .../net/ethernet/marvell/octeontx2/af/rvu_sdp.c    |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   7 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  12 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c     |   4 +-
 drivers/net/ipvlan/ipvlan.h                        |   2 +-
 drivers/net/ipvlan/ipvlan_core.c                   |  16 +-
 drivers/net/ipvlan/ipvlan_main.c                   |  49 +++--
 drivers/net/netdevsim/bpf.c                        |   6 +
 drivers/net/netdevsim/dev.c                        |   2 +
 drivers/net/netdevsim/netdevsim.h                  |   1 +
 drivers/net/pcs/pcs-mtk-lynxi.c                    |   4 +-
 drivers/net/phy/intel-xway.c                       |   7 +-
 drivers/net/phy/sfp.c                              |   2 +
 drivers/net/usb/dm9601.c                           |   4 -
 drivers/net/usb/usbnet.c                           |  10 +-
 drivers/net/veth.c                                 |   8 +-
 drivers/net/wireless/ath/ath10k/ce.c               |  16 +-
 drivers/net/wireless/ath/ath12k/ce.c               |  12 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  16 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   9 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |   6 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |   1 +
 drivers/net/wwan/mhi_wwan_mbim.c                   |  17 +-
 drivers/nfc/virtual_ncidev.c                       |   4 -
 include/net/cfg80211.h                             |   3 -
 include/trace/events/rxrpc.h                       |   4 +
 include/uapi/linux/nl80211.h                       |   5 +-
 net/core/skbuff.c                                  |   7 +-
 net/dsa/dsa.c                                      |   2 +-
 net/ipv4/fou_core.c                                |   3 +
 net/ipv4/fou_nl.c                                  |   2 +-
 net/ipv6/ndisc.c                                   |   4 +-
 net/l2tp/l2tp_core.c                               |   8 +-
 net/mac80211/ieee80211_i.h                         |   2 -
 net/mac80211/iface.c                               |   8 +-
 net/mac80211/key.c                                 |   3 +-
 net/mac80211/mlme.c                                | 213 ++++++++++++---------
 net/mac80211/scan.c                                |   9 +-
 net/netrom/nr_route.c                              |  13 +-
 net/openvswitch/vport.c                            |  11 +-
 net/rxrpc/ar-internal.h                            |   9 +-
 net/rxrpc/conn_event.c                             |   2 +-
 net/rxrpc/output.c                                 |  14 +-
 net/rxrpc/peer_event.c                             |  17 +-
 net/rxrpc/proc.c                                   |   4 +-
 net/rxrpc/recvmsg.c                                |  19 +-
 net/rxrpc/rxgk.c                                   |   2 +-
 net/rxrpc/rxkad.c                                  |   2 +-
 net/sched/act_ife.c                                |   6 +-
 net/sched/sch_qfq.c                                |   2 +-
 net/sched/sch_teql.c                               |   5 +
 net/sctp/sm_statefuns.c                            |  10 +-
 net/vmw_vsock/virtio_transport_common.c            |  36 ++--
 net/wireless/nl80211.c                             |  10 -
 net/wireless/util.c                                |   8 +-
 tools/net/ynl/Makefile                             |   3 +-
 tools/net/ynl/ynl-regen.sh                         |   2 +-
 tools/testing/selftests/net/Makefile               |   1 +
 tools/testing/selftests/net/amt.sh                 |   7 +-
 tools/testing/selftests/net/config                 |   2 +
 tools/testing/selftests/net/fib-onlink-tests.sh    |  71 +++----
 tools/testing/selftests/net/ipvtap_test.sh         | 168 ++++++++++++++++
 .../selftests/tc-testing/tc-tests/qdiscs/teql.json |  25 +++
 tools/testing/vsock/util.h                         |   2 +-
 tools/testing/vsock/vsock_test.c                   | 117 +++++++++++
 tools/testing/vsock/vsock_test_zerocopy.c          |  74 +++++++
 tools/testing/vsock/vsock_test_zerocopy.h          |   3 +
 108 files changed, 1144 insertions(+), 472 deletions(-)
 create mode 100755 tools/testing/selftests/net/ipvtap_test.sh

