Return-Path: <netdev+bounces-264490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPW1KgK6qWlEDAEAu9opvQ
	(envelope-from <netdev+bounces-264490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:14:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 074A1215F65
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACF0B3137130
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877843E3D83;
	Thu,  5 Mar 2026 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="froSTPIP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498C83E1238;
	Thu,  5 Mar 2026 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730606; cv=none; b=SHyszZ2ps6b1EQUG0nD6D8di6VQqqUXXh7A21RedX49IWzlNw5EEqXQ/LHZfI08x9UTd7LMAoPgKJdoX7n+Gz4gTzSgqmyhQy50M9z11KRUUNoZao05hbC5odTYCer2vVQq7XIc5vdS3YNsj3iSd1XfyfImrkRAH0EYkkeY5aNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730606; c=relaxed/simple;
	bh=GCVAr7D2SR/TcW3O1xQWKbzobrlFo1jGO+HS3iywA4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rV8td3ZakxMg83cv2x+wErZyRyniMtFwGwvR6cqy6c8sktFOfm0Me9iHWQl2CKJ58yCsBmHFqJ09RpFWQS4UFRXR0a+63eq4Vu5f7QZ+KarFgx5Cuaw3vO3tMcyjWr1tEvVP02r//C6cHAP2QV5yAhu3jFhcdT8O2XuLzdwWRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=froSTPIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AD8C116C6;
	Thu,  5 Mar 2026 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772730606;
	bh=GCVAr7D2SR/TcW3O1xQWKbzobrlFo1jGO+HS3iywA4M=;
	h=From:To:Cc:Subject:Date:From;
	b=froSTPIPJgAw/I3ObgFoub3/H+25f85MsAMgy4nEpwi5bgcaXhnOPhid0He6h0e63
	 hArZR/bK73vNXd/VKuY1vvgakjUK6e/GF5aX9Jf7rINYytygQzXfkLKWCtq1SkJpma
	 W7ycdyNXJLuiB+X0lT840e9ooiYKSz9adum6WYPZlt8T7CpyB+mwR3NG2JP23zlXTW
	 zn9LQD3+OKop+VokuwmKDmmeYqmZ3icOQfuimnEt16QOOgkjgpALk9NNtLNqYKWLO4
	 grAmM5BByMKWcfjTVqckAv3hmipE4tyRiDfLSTK15Ldqg0UOks4NqeMBirmEwAQV/a
	 81CdzT3y4htVA==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.0-rc3
Date: Thu,  5 Mar 2026 09:10:04 -0800
Message-ID: <20260305171004.322683-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 074A1215F65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264490-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,open-mesh.org:url]
X-Rspamd-Action: no action

Hi Linus!

A few PRs here narrowly missed the previous rc, but I'm not sure
if that explains why this PR is almost 2x the usual size.
I had a feeling that AI tools are helping people investigate
and send fixes for issues which would previously be waved off
as one-off / not worth the time. But the data doesn't necessarily
bear that out.

The following changes since commit b9c8fc2caea6ff7e45c6942de8fee53515c66b34:

  Merge tag 'net-7.0-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-02-26 08:00:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc3

for you to fetch changes up to cf440e5b40649d1ffbc6c4e33fef3223c7482897:

  Merge branch 'Address-XDP-frags-having-negative-tailroom' (2026-03-05 08:03:27 -0800)

----------------------------------------------------------------
Including fixes from CAN, netfilter and wireless.

Current release - new code bugs:

 - sched: cake: fixup cake_mq rate adjustment for diffserv config

 - wifi: fix missing ieee80211_eml_params member initialization

Previous releases - regressions:

 - tcp: give up on stronger sk_rcvbuf checks (for now)

Previous releases - always broken:

 - net: fix rcu_tasks stall in threaded busypoll

 - sched: fq: clear q->band_pkt_count[] in fq_reset()

 - sched: only allow act_ct to bind to clsact/ingress qdiscs and
   shared blocks

 - bridge: check relevant per-VLAN options in VLAN range grouping

 - xsk: fix fragment node deletion to prevent buffer leak

Misc:

 - spring cleanup of inactive maintainers

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aaron Ma (1):
      ice: recap the VSI and QoS info after rebuild

Alban Bedel (1):
      can: mcp251x: fix deadlock in error path of mcp251x_open

Allison Henderson (1):
      net/rds: Fix circular locking dependency in rds_tcp_tune

Arthur Kiyanovski (1):
      MAINTAINERS: ena: update AMAZON ETHERNET maintainers

Baochen Qiang (2):
      wifi: ath12k: use correct pdev id when requesting firmware stats
      wifi: ath12k: fix station lookup failure when disconnecting from AP

Bart Van Assche (2):
      wifi: cw1200: Fix locking in error paths
      wifi: wlcore: Fix a locking bug

Bobby Eshleman (1):
      net: devmem: use READ_ONCE/WRITE_ONCE on binding->dev

Breno Leitao (1):
      netconsole: fix sysdata_release_enabled_show checking wrong flag

Brian Vazquez (1):
      idpf: change IRQ naming to match netdev and ethtool queue numbering

Chintan Vankar (1):
      net: ethernet: ti: am65-cpsw-nuss/cpsw-ale: Fix multicast entry handling in ALE table

Danielle Ratson (2):
      bridge: Check relevant per-VLAN options in VLAN range grouping
      selftests: net: Add bridge VLAN range grouping tests

Davide Caratti (1):
      net/sched: ets: fix divide by zero in the offload path

Eric Biggers (2):
      net/tcp-ao: Fix MAC comparison to be constant-time
      net/tcp-md5: Fix MAC comparison to be constant-time

Eric Dumazet (5):
      net: annotate data-races around sk->sk_{data_ready,write_space}
      inet: annotate data-races around isk->inet_num
      indirect_call_wrapper: do not reevaluate function pointer
      tcp: secure_seq: add back ports to TS offset
      net_sched: sch_fq: clear q->band_pkt_count[] in fq_reset()

Fernando Fernandez Mancera (2):
      net: bridge: fix nd_tbl NULL dereference when IPv6 is disabled
      net: vxlan: fix nd_tbl NULL dereference when IPv6 is disabled

Florian Westphal (2):
      selftests: netfilter: nft_queue.sh: avoid flakes on debug kernels
      netfilter: nft_set_pipapo: split gc into unlink and reclaim phase

Frank Li (1):
      dt-bindings: net: can: nxp,sja1000: add reference to mc-peripheral-props.yaml

Greg Kroah-Hartman (6):
      can: ems_usb: ems_usb_read_bulk_callback(): check the proper length of a message
      can: ucan: Fix infinite loop from zero-length messages
      can: usb: etas_es58x: correctly anchor the urb in the read bulk callback
      can: usb: f81604: handle short interrupt urb messages properly
      can: usb: f81604: handle bulk write errors properly
      can: usb: f81604: correctly anchor the urb in the read bulk callback

Guenter Roeck (1):
      dpaa2-switch: Fix interrupt storm after receiving bad if_id in IRQ handler

Ian Ray (1):
      net: nfc: nci: Fix zero-length proprietary notifications

Jakub Kicinski (33):
      Merge tag 'batadv-net-pullrequest-20260225' of https://git.open-mesh.org/linux-merge
      Merge branch 'bridge-check-relevant-options-in-vlan-range-grouping'
      Merge branch 'net-sched-sch_cake-fixes-for-cake_mq'
      tcp: give up on stronger sk_rcvbuf checks (for now)
      selftests/net: packetdrill: remove tests for tcp_rcv_*big
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'xsk-fixes-for-af_xdp-fragment-handling'
      ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
      Merge tag 'wireless-2026-03-04' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'linux-can-fixes-for-7.0-20260302' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      nfc: nci: free skb on nci_transceive early error paths
      nfc: digital: free skb on digital_in_send error paths
      nfc: nci: complete pending data exchange on device close
      nfc: nci: clear NCI_DATA_EXCHANGE before calling completion callback
      nfc: rawsock: cancel tx_work before socket teardown
      Merge branch 'nfc-fix-leaks-and-races-surfaced-by-nipa'
      Merge branch 'mptcp-misc-fixes-for-v7-0-rc2'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'net-stmmac-fix-vlan-handling-when-interface-is-down'
      Merge tag 'nf-26-03-05' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      MAINTAINERS: remove Johan Hedberg from Bluetooth subsystem
      MAINTAINERS: remove Manish Chopra from QLogic QL4xxx (now orphan)
      MAINTAINERS: remove Jerin Jacob from Marvell OcteonTX2
      MAINTAINERS: remove Sean Wang from MediaTek Ethernet and switch
      MAINTAINERS: remove DENG Qingfang from MediaTek switch
      MAINTAINERS: replace Clark Wang with Frank Li for Freescale FEC
      MAINTAINERS: remove Jonathan Lemon from OpenCompute PTP
      MAINTAINERS: replace Taras Chornyi with Elad Nachman for Marvell Prestera
      MAINTAINERS: remove Claudiu Manoil and Alexandre Belloni from Ocelot switch
      MAINTAINERS: remove Thomas Falcon from IBM ibmvnic
      Merge branch 'maintainers-annual-cleanup-of-inactive-maintainers'
      Merge branch 'net-ipv6-fix-panic-when-ipv4-route-references-loopback-ipv6-nexthop-and-add-selftest'
      Merge branch 'Address-XDP-frags-having-negative-tailroom'

Jakub Staniszewski (2):
      ice: reintroduce retry mechanism for indirect AQ
      ice: fix retry for AQ command 0x06EE

Jamal Hadi Salim (1):
      net/sched: act_ife: Fix metalist update behavior

Jason Xing (1):
      mailmap: reflect my gmail as default

Jedrzej Jagielski (1):
      ixgbevf: fix link setup issue

Jiayuan Chen (5):
      atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
      bpf/bonding: reject vlan+srcmac xmit_hash_policy change when XDP is loaded
      selftests/bpf: add test for xdp_bonding xmit_hash_policy compat
      net: ipv6: fix panic when IPv4 route references loopback IPv6 nexthop
      selftests: net: add test for IPv4 route with loopback IPv6 nexthop

Joe Damato (1):
      mailmap: Add entry for Joe Damato

Johannes Berg (1):
      Merge tag 'ath-current-20260302' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Jonas Köppeler (2):
      net/sched: sch_cake: avoid sync overhead when unlimited
      net/sched: sch_cake: fixup cake_mq rate adjustment for diffserv config

Kohei Enju (1):
      iavf: fix netdev->max_mtu to respect actual hardware limit

Koichiro Den (1):
      net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race for lockless qdiscs

Kuniyuki Iwashima (1):
      udp: Unhash auto-bound connected sk from 4-tuple hash table when disconnected.

Larysa Zaremba (10):
      ice: fix adding AQ LLDP filter for VF
      xdp: use modulo operation to calculate XDP frag tailroom
      xsk: introduce helper to determine rxq->frag_size
      ice: fix rxq info registering in mbuf packets
      ice: change XDP RxQ frag_size from DMA write length to xdp.frame_sz
      i40e: fix registering XDP RxQ info
      i40e: use xdp.frame_sz as XDP RxQ info frag_size
      libeth, idpf: use truesize as XDP RxQ info frag_size
      net: enetc: use truesize as XDP RxQ info frag_size
      xdp: produce a warning when calculated tailroom is negative

Li Li (4):
      idpf: increment completion queue next_to_clean in sw marker wait routine
      idpf: skip deallocating bufq_sets from rx_qgrp if it is NULL
      idpf: skip deallocating txq group's txqs if it is NULL
      idpf: nullify pointers after they are freed

Long Li (1):
      net: mana: Ring doorbell at 4 CQ wraparounds

Lorenzo Bianconi (4):
      wifi: mt76: mt7996: Fix possible oob access in mt7996_mac_write_txwi_80211()
      wifi: mt76: mt7925: Fix possible oob access in mt7925_mac_write_txwi_80211()
      wifi: mt76: Fix possible oob access in mt76_connac2_mac_write_txwi_80211()
      net: ethernet: mtk_eth_soc: Reset prog ptr to old_prog in case of error in mtk_xdp_setup()

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix ping failure after offload mode setup when link speed is not 1G

Marc Kleine-Budde (2):
      Merge patch series "can: usb: f81604: handle short interrupt urb messages properly"
      can: gs_usb: gs_can_open(): always configure bitrates before starting device

Matthieu Baerts (NGI0) (4):
      mptcp: pm: avoid sending RM_ADDR over same subflow
      selftests: mptcp: join: check RM_ADDR not sent over same subflow
      mptcp: pm: in-kernel: always mark signal+subflow endp as used
      selftests: mptcp: join: check removing signal+subflow endp

MeiChia Chiu (1):
      wifi: mac80211: fix missing ieee80211_eml_params member initialization

Michal Schmidt (1):
      ice: fix crash in ethtool offline loopback test

Michal Swiatkowski (1):
      libie: don't unroll if fwlog isn't supported

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: fix rtl8365mb_phy_ocp_write return value

Naveen Anandhan (1):
      selftests: tc-testing: fix list_categories() crash on list type

Nikhil P. Rao (2):
      xsk: Fix fragment node deletion to prevent buffer leak
      xsk: Fix zero-copy AF_XDP fragment drop

Oliver Hartkopp (2):
      can: bcm: fix locking for bcm_op runtime updates
      can: dummy_can: dummy_can_init(): fix packet statistics

Ovidiu Panait (4):
      net: stmmac: Fix error handling in VLAN add and delete paths
      net: stmmac: Improve double VLAN handling
      net: stmmac: Fix VLAN HW state restore
      net: stmmac: Defer VLAN HW configuration when interface is down

Pablo Neira Ayuso (2):
      netfilter: nf_tables: unconditionally bump set->nelems before insertion
      netfilter: nf_tables: clone set on flush only

Paolo Abeni (3):
      Merge branch 'bonding-fix-missing-xdp-compat-check-on-xmit_hash_policy-change'
      Merge branch 'avoid-compiler-and-iq-oq-reordering'
      selftests: mptcp: more stable simult_flows tests

Paul Moses (1):
      net/sched: act_gate: snapshot parameters with RCU on replace

Raju Rangoju (2):
      amd-xgbe: fix MAC_TCR_SS register width for 2.5G and 10M speeds
      amd-xgbe: fix sleep while atomic on suspend/resume

Sebastian Andrzej Siewior (1):
      net: Provide a PREEMPT_RT specific check for netdev_queue::_xmit_lock

Sebastian Krzyszkowiak (1):
      wifi: rsi: Don't default to -EOPNOTSUPP in rsi_mac80211_config

Simon Baatz (1):
      selftests/net: packetdrill: restore tcp_rcv_big_endseq.pkt

Sreedevi Joshi (1):
      idpf: Fix flow rule delete failure due to invalid validation

Stephen Hemminger (1):
      MAINTAINERS: update the skge/sky2 maintainers

Sun Jian (2):
      selftests/harness: order TEST_F and XFAIL_ADD constructors
      selftests: net: tun: don't abort XFAIL cases

Sven Eckelmann (1):
      batman-adv: Avoid double-rtnl_lock ELP metric worker

Thomas Gleixner (1):
      i40e: Fix preempt count leak in napi poll tracepoint

Valentin Spreckels (1):
      net: usb: r8152: add TRENDnet TUC-ET2G

Victor Nogueira (3):
      net/sched: Only allow act_ct to bind to clsact/ingress qdiscs and shared blocks
      selftests/tc-testing: Create tests to exercise act_ct binding restrictions
      selftests/tc-testing: Add tests exercising act_ife metalist replace behaviour

Vimlesh Kumar (4):
      octeon_ep: Relocate counter updates before NAPI
      octeon_ep: avoid compiler and IQ/OQ reordering
      octeon_ep_vf: Relocate counter updates before NAPI
      octeon_ep_vf: avoid compiler and IQ/OQ reordering

Vitaly Lifshits (2):
      e1000e: introduce new board type for Panther Lake PCH
      e1000e: clear DPG_EN after reset to avoid autonomous power-gating

Vivek Behera (2):
      igb: Fix trigger of incorrect irq in igb_xsk_wakeup
      igc: Fix trigger of incorrect irq in igc_xsk_wakeup function

YiFei Zhu (1):
      net: Fix rcu_tasks stall in threaded busypoll

Yung Chih Su (1):
      net: ipv4: fix ARM64 alignment fault in multipath hash seed

Zilin Guan (1):
      ice: Fix memory leak in ice_set_ringparam()

Ziyi Guo (1):
      can: esd_usb: add endpoint type validation

 .mailmap                                           |   2 +
 CREDITS                                            |   8 +
 .../devicetree/bindings/net/can/nxp,sja1000.yaml   |   1 +
 MAINTAINERS                                        |  24 +-
 drivers/net/bonding/bond_main.c                    |   9 +-
 drivers/net/bonding/bond_options.c                 |   2 +
 drivers/net/can/dummy_can.c                        |   1 +
 drivers/net/can/spi/mcp251x.c                      |  15 +-
 drivers/net/can/usb/ems_usb.c                      |   7 +-
 drivers/net/can/usb/esd_usb.c                      |  30 ++-
 drivers/net/can/usb/etas_es58x/es58x_core.c        |   8 +-
 drivers/net/can/usb/f81604.c                       |  45 +++-
 drivers/net/can/usb/gs_usb.c                       |  22 +-
 drivers/net/can/usb/ucan.c                         |   2 +-
 drivers/net/dsa/realtek/rtl8365mb.c                |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |  10 -
 drivers/net/ethernet/amd/xgbe/xgbe-main.c          |   1 -
 drivers/net/ethernet/amd/xgbe/xgbe.h               |   3 -
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |   3 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |   2 +-
 drivers/net/ethernet/intel/e1000e/defines.h        |   1 +
 drivers/net/ethernet/intel/e1000e/e1000.h          |   4 +-
 drivers/net/ethernet/intel/e1000e/hw.h             |   2 -
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  31 ++-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  15 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  41 ++--
 drivers/net/ethernet/intel/i40e/i40e_trace.h       |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   5 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  17 +-
 drivers/net/ethernet/intel/ice/ice.h               |   1 +
 drivers/net/ethernet/intel/ice/ice_base.c          |  38 ++-
 drivers/net/ethernet/intel/ice/ice_common.c        |  15 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  51 ++--
 drivers/net/ethernet/intel/ice/ice_idc.c           |  44 +++-
 drivers/net/ethernet/intel/ice/ice_lib.c           |  15 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   7 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   4 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   3 +
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |   3 -
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |  14 +-
 drivers/net/ethernet/intel/idpf/xdp.c              |   6 +-
 drivers/net/ethernet/intel/idpf/xsk.c              |   1 +
 drivers/net/ethernet/intel/igb/igb_xsk.c           |  38 ++-
 drivers/net/ethernet/intel/igc/igc_main.c          |  34 ++-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |   3 +-
 drivers/net/ethernet/intel/ixgbevf/vf.c            |   3 +-
 drivers/net/ethernet/intel/libeth/xsk.c            |   1 +
 drivers/net/ethernet/intel/libie/fwlog.c           |   4 +
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |  48 ++--
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c  |  27 ++-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.c  |  50 ++--
 .../ethernet/marvell/octeon_ep_vf/octep_vf_rx.c    |  28 ++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  15 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  23 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  53 +++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c  |  60 ++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   2 +-
 drivers/net/ethernet/ti/cpsw_ale.c                 |   9 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |   8 +
 drivers/net/netconsole.c                           |   2 +-
 drivers/net/usb/r8152.c                            |   1 +
 drivers/net/vxlan/vxlan_core.c                     |   5 +
 drivers/net/wireless/ath/ath12k/mac.c              |   6 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  36 +--
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   1 +
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |   2 +-
 drivers/net/wireless/st/cw1200/pm.c                |   2 +
 drivers/net/wireless/ti/wlcore/main.c              |   4 +-
 include/linux/indirect_call_wrapper.h              |  18 +-
 include/linux/netdevice.h                          |  27 ++-
 include/linux/usb/r8152.h                          |   1 +
 include/net/act_api.h                              |   1 +
 include/net/bonding.h                              |   1 +
 include/net/inet6_hashtables.h                     |   2 +-
 include/net/inet_hashtables.h                      |   2 +-
 include/net/ip.h                                   |   2 +-
 include/net/ip_fib.h                               |   2 +-
 include/net/libeth/xsk.h                           |   3 +
 include/net/netfilter/nf_tables.h                  |   7 +
 include/net/sch_generic.h                          |  10 +
 include/net/secure_seq.h                           |  45 +++-
 include/net/tc_act/tc_gate.h                       |  33 ++-
 include/net/tc_act/tc_ife.h                        |   4 +-
 include/net/tcp.h                                  |   6 +-
 include/net/xdp_sock_drv.h                         |  16 +-
 net/atm/lec.c                                      |  26 +-
 net/batman-adv/bat_v_elp.c                         |  10 +-
 net/batman-adv/hard-interface.c                    |   8 +-
 net/batman-adv/hard-interface.h                    |   1 +
 net/bridge/br_device.c                             |   2 +-
 net/bridge/br_input.c                              |   2 +-
 net/bridge/br_private.h                            |  10 +
 net/bridge/br_vlan_options.c                       |  26 +-
 net/can/bcm.c                                      |   1 +
 net/core/dev.c                                     |  24 +-
 net/core/devmem.c                                  |   6 +-
 net/core/filter.c                                  |   6 +-
 net/core/netpoll.c                                 |   2 +-
 net/core/secure_seq.c                              |  80 +++---
 net/core/skmsg.c                                   |  14 +-
 net/ipv4/Kconfig                                   |   2 +
 net/ipv4/inet_hashtables.c                         |   8 +-
 net/ipv4/syncookies.c                              |  11 +-
 net/ipv4/sysctl_net_ipv4.c                         |   5 +-
 net/ipv4/tcp.c                                     |   7 +-
 net/ipv4/tcp_ao.c                                  |   3 +-
 net/ipv4/tcp_bpf.c                                 |   2 +-
 net/ipv4/tcp_diag.c                                |   2 +-
 net/ipv4/tcp_input.c                               |  38 ++-
 net/ipv4/tcp_ipv4.c                                |  40 ++-
 net/ipv4/tcp_minisocks.c                           |   2 +-
 net/ipv4/udp.c                                     |  25 +-
 net/ipv4/udp_bpf.c                                 |   2 +-
 net/ipv6/inet6_hashtables.c                        |   3 +-
 net/ipv6/route.c                                   |  11 +-
 net/ipv6/syncookies.c                              |  11 +-
 net/ipv6/tcp_ipv6.c                                |  40 ++-
 net/mac80211/eht.c                                 |   1 +
 net/mptcp/pm.c                                     |  55 ++++-
 net/mptcp/pm_kernel.c                              |   9 +
 net/netfilter/nf_tables_api.c                      |  45 ++--
 net/netfilter/nft_set_hash.c                       |   1 +
 net/netfilter/nft_set_pipapo.c                     |  62 ++++-
 net/netfilter/nft_set_pipapo.h                     |   2 +
 net/netfilter/nft_set_rbtree.c                     |   8 +-
 net/nfc/digital_core.c                             |   8 +-
 net/nfc/nci/core.c                                 |  30 ++-
 net/nfc/nci/data.c                                 |  12 +-
 net/nfc/rawsock.c                                  |  11 +
 net/rds/tcp.c                                      |  14 +-
 net/sched/act_ct.c                                 |   6 +
 net/sched/act_gate.c                               | 267 +++++++++++++++------
 net/sched/act_ife.c                                |  93 ++++---
 net/sched/cls_api.c                                |   7 +
 net/sched/sch_cake.c                               |  53 ++--
 net/sched/sch_ets.c                                |  12 +-
 net/sched/sch_fq.c                                 |   1 +
 net/unix/af_unix.c                                 |   8 +-
 net/xdp/xsk.c                                      |  28 ++-
 .../testing/selftests/bpf/prog_tests/xdp_bonding.c |  58 +++++
 tools/testing/selftests/kselftest_harness.h        |   7 +-
 tools/testing/selftests/net/Makefile               |   1 +
 tools/testing/selftests/net/bridge_vlan_dump.sh    | 204 ++++++++++++++++
 tools/testing/selftests/net/fib_nexthops.sh        |  11 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  49 ++++
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  11 +-
 tools/testing/selftests/net/netfilter/nf_queue.c   |  10 +-
 tools/testing/selftests/net/netfilter/nft_queue.sh |  13 +-
 .../net/packetdrill/tcp_rcv_big_endseq.pkt         |   2 +-
 .../selftests/net/packetdrill/tcp_rcv_toobig.pkt   |  33 ---
 tools/testing/selftests/net/tun.c                  |  12 +-
 .../selftests/tc-testing/tc-tests/actions/ct.json  | 159 ++++++++++++
 .../selftests/tc-testing/tc-tests/actions/ife.json |  99 ++++++++
 tools/testing/selftests/tc-testing/tdc_helper.py   |  10 +-
 159 files changed, 2163 insertions(+), 847 deletions(-)
 create mode 100755 tools/testing/selftests/net/bridge_vlan_dump.sh
 delete mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt

