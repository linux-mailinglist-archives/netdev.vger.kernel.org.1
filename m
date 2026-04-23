Return-Path: <netdev+bounces-280879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADiDNeSS6mmr0wIAu9opvQ
	(envelope-from <netdev+bounces-280879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:45:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 502CF457F32
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2D65301C6E7
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D732351C2B;
	Thu, 23 Apr 2026 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXL2oK20"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A0241139;
	Thu, 23 Apr 2026 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776980683; cv=none; b=UFKxP/TIjxA0n5hMUsPlLP9glC8DzemxV3Z5b0dUHAGCS7FMqpXMSYxJprTVDx3D4KtFHEDJJJ3AhUpy7v9SJqzf2H99RnjOW3VMRQoaE4VfTowkqjASXRiPSjA8V3YodYYv/JnXpvqLJs0m+pPTRlq8PqiR5Oip7+9bUFqYdEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776980683; c=relaxed/simple;
	bh=pe0r5/JP+uITimIYpv7h4WPQ18jwC4D7xfvv9WlvITY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HlpKnJgxk7XeLb8ryxmLIvSjvZlCcZqn+5auIyOCHPO5vnSrOAuJWw6hyEyio4SU0r5chci+3hkODeYgM9Iwf6CVC4i9u6H1ybtmjsitAdf0W89E45AeVht/aySw/wsQqpkPiIXfxwZBxHJlOXOrSnWIPD1DVVs9Sjnmet3Spbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXL2oK20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC18C2BCAF;
	Thu, 23 Apr 2026 21:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776980682;
	bh=pe0r5/JP+uITimIYpv7h4WPQ18jwC4D7xfvv9WlvITY=;
	h=From:To:Cc:Subject:Date:From;
	b=SXL2oK20Q2nkVa0CooEPHMoeUWpzB+u2G39WePdJ8t+7SH+eZJxhwVnoZiTUiuyfQ
	 42VD/mgVMNxsP8nY92utZS97VkD+bBElxz34NAAeYseP3qEKq7pvqucYk+Tcawm1Sb
	 bZ+DX671vrAP7i4gymhlKyBD3QZcMSF1/zE0h+gIL0EyyA1GXsBcRwVJTztMS7MuwO
	 FtGr2RFMxQ1J8mv99X+B6w16haZqGz84dFk3GpUnZoASWQayvca7gIDhl/uprFb+A7
	 o4PfPiWz+vq2NB3hrL51iZT1/8+Lvvx9cbnmGeJrxYjalOtBYSrwqtnKKNkcMF2JTI
	 Z9MSH+wKEt9sQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.1-rc1
Date: Thu, 23 Apr 2026 14:44:41 -0700
Message-ID: <20260423214441.1357981-1-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-280879-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 502CF457F32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus!

The following changes since commit 1f5ffc672165ff851063a5fd044b727ab2517ae3:

  Fix mismerge of the arm64 / timer-core interrupt handling changes (2026-04-14 23:03:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc1

for you to fetch changes up to 5e6391da4539c35422c0df1d1d2d9a9bb97cd736:

  Merge branch 'rxrpc-miscellaneous-fixes' (2026-04-23 14:29:18 -0700)

----------------------------------------------------------------
Including fixes from Netfilter.

Steady stream of fixes. Last two weeks feel comparable to the two
weeks before the merge window. Lots of AI-aided bug discovery.
A newer big source is Sashiko/Gemini (Roman Gushchin's system),
which points out issues in existing code during patch review
(maybe 25% of fixes here likely originating from Sashiko).
Nice thing is these are often fixed by the respective maintainers,
not drive-bys.

Current release - new code bugs:

 - kconfig: MDIO_PIC64HPSC should depend on ARCH_MICROCHIP

Previous releases - regressions:

 - add async ndo_set_rx_mode and switch drivers which we promised
   to be called under the per-netdev mutex to it

 - dsa: remove duplicate netdev_lock_ops() for conduit ethtool ops

 - hv_sock: report EOF instead of -EIO for FIN

 - vsock/virtio: fix MSG_PEEK calculation on bytes to copy

Previous releases - always broken:

 - ipv6: fix possible UAF in icmpv6_rcv()

 - icmp: validate reply type before using icmp_pointers

 - af_unix: drop all SCM attributes for SOCKMAP

 - netfilter: fix a number of bugs in the osf (OS fingerprinting)

 - eth: intel: fix timestamp interrupt configuration for E825C

Misc:

 - bunch of data-race annotations

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexey Kodanev (1):
      nfp: fix swapped arguments in nfp_encode_basic_qdr() calls

Anderson Nascimento (1):
      rxrpc: Fix missing validation of ticket length in non-XDR key preparsing

Andrea Mayer (1):
      seg6: fix seg6 lwtunnel output redirect for L2 reduced encap mode

Ao Zhou (1):
      net: rds: fix MR cleanup on copy error

Ariful Islam Shoikot (1):
      docs: maintainer-netdev: fix typo in "targeting"

Bingquan Chen (1):
      net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()

Breno Leitao (1):
      netconsole: avoid out-of-bounds access on empty string in trim_newline()

Brett Creeley (1):
      virtio_net: sync rss_trailer.max_tx_vq on queue_pairs change via VQ_PAIRS_SET

Chia-Yu Chang (1):
      net/sched: sch_dualpi2: drain both C-queue and L-queue in dualpi2_change()

Daniel Borkmann (1):
      ipv6: Cap TLV scan in ip6_tnl_parse_tlv_enc_lim

Daniel Palmer (1):
      m68k: mvme147: Make me the maintainer

David Carlier (1):
      gtp: disable BH before calling udp_tunnel_xmit_skb()

David Howells (8):
      rxrpc: Fix memory leaks in rxkad_verify_response()
      rxrpc: Fix rxkad crypto unalignment handling
      rxrpc: Fix potential UAF after skb_unshare() failure
      rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
      rxgk: Fix potential integer overflow in length check
      rxrpc: Fix rxrpc_input_call_event() to only unshare DATA packets
      rxrpc: Fix re-decryption of RESPONSE packets
      rxrpc: Fix error handling in rxgk_extract_token()

Dexuan Cui (2):
      hv_sock: Report EOF instead of -EIO for FIN
      hv_sock: Return -EIO for malformed/short packets

Dudu Lu (4):
      net/sched: act_mirred: fix wrong device for mac_header_xmit check in tcf_blockcast_redir
      macvlan: fix macvlan_get_size() not reserving space for IFLA_MACVLAN_BC_CUTOFF
      net/sched: sch_cake: fix NAT destination port not being updated in cake_update_flowkeys
      vsock/virtio: fix accept queue count leak on transport mismatch

Eric Dumazet (20):
      tcp: annotate data-races in tcp_get_info_chrono_stats()
      tcp: add data-race annotations around tp->data_segs_out and tp->total_retrans
      tcp: add data-races annotations around tp->reordering, tp->snd_cwnd
      tcp: annotate data-races around tp->snd_ssthresh
      tcp: annotate data-races around tp->delivered and tp->delivered_ce
      tcp: add data-race annotations for TCP_NLA_SNDQ_SIZE
      tcp: annotate data-races around tp->bytes_sent
      tcp: annotate data-races around tp->bytes_retrans
      tcp: annotate data-races around tp->dsack_dups
      tcp: annotate data-races around tp->reord_seen
      tcp: annotate data-races around tp->srtt_us
      tcp: annotate data-races around tp->timeout_rehash
      tcp: annotate data-races around (tp->write_seq - tp->snd_nxt)
      tcp: annotate data-races around tp->plb_rehash
      ipv6: fix possible UAF in icmpv6_rcv()
      net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
      net/sched: sch_pie: annotate data-races in pie_dump_stats()
      net/sched: sch_fq_codel: remove data-races from fq_codel_dump_stats()
      net/sched: sch_red: annotate data-races in red_dump_stats()
      net/sched: sch_sfb: annotate data-races in sfb_dump_stats()

Ernestas Kulik (1):
      llc: Return -EINPROGRESS from llc_ui_connect()

Erni Sri Satya Vennela (5):
      net: mana: Init link_change_work before potential error paths in probe
      net: mana: Init gf_stats_work before potential error paths in probe
      net: mana: Guard mana_remove against double invocation
      net: mana: Don't overwrite port probe error with add_adev result
      net: mana: Fix EQ leak in mana_remove on NULL port

Fernando Fernandez Mancera (2):
      netfilter: nfnetlink_osf: fix out-of-bounds read on option matching
      netfilter: nfnetlink_osf: fix potential NULL dereference in ttl check

Florian Westphal (1):
      netfilter: conntrack: remove sprintf usage

Gang Yan (2):
      mptcp: sync the msk->sndbuf at accept() time
      selftests: mptcp: add a check for sndbuf of S/C

Geert Uytterhoeven (1):
      net: mdio: MDIO_PIC64HPSC should depend on ARCH_MICROCHIP

Grzegorz Nitka (4):
      ice: fix 'adjust' timer programming for E830 devices
      ice: update PCS latency settings for E825 10G/25Gb modes
      ice: fix timestamp interrupt configuration for E825C
      ice: perform PHY soft reset for E825C ports at initialization

Guangshuo Li (1):
      ice: fix double free in ice_sf_eth_activate() error path

Jacob Keller (2):
      ice: fix ready bitmap check for non-E822 devices
      ice: fix ice_ptp_read_tx_hwtstamp_status_eth56g

Jakub Kicinski (12):
      Merge branch 'net-enetc-fix-command-bd-ring-issues'
      Merge branch 'vsock-virtio-fix-msg_peek-calculation-on-bytes-to-copy'
      selftests: net: add missing CMAC to tcp_ao config
      Merge branch 'tcp-take-care-of-tcp_get_timestamping_opt_stats-races'
      Merge tag 'ovpn-net-20260417' of https://github.com/OpenVPN/ovpn-net-next
      Merge branch 'intel-wired-lan-driver-updates-2026-04-14-ice-i40e-iavf-idpf-e1000e'
      Merge branch 'bnge-fixes'
      Merge branch 'intel-wired-lan-driver-updates-2026-04-20-ice'
      Merge branch 'tcp-symmetric-challenge-ack-for-seg-ack-snd-nxt'
      Merge branch 'tcp-fix-listener-wakeup-after-reuseport-migration'
      Merge branch 'rxrpc-miscellaneous-fixes'
      Merge branch 'rxrpc-miscellaneous-fixes'

Jiawen Wu (1):
      net: txgbe: fix firmware version check

Jiayuan Chen (4):
      nexthop: fix IPv6 route referencing IPv4 nexthop
      selftests: fib_nexthops: test stale has_v4 on nexthop replace
      tcp: send a challenge ACK on SEG.ACK > SND.NXT
      selftests/net: packetdrill: cover RFC 5961 5.2 challenge ACK on both edges

Keita Morisaki (1):
      ice: fix race condition in TX timestamp ring cleanup

KhaiWenTan (1):
      net: stmmac: Update default_an_inband before passing value to phylink_config

Kohei Enju (4):
      ice: fix potential NULL pointer deref in error path of ice_set_ringparam()
      i40e: don't advertise IFF_SUPP_NOFCS
      net: validate skb->napi_id in RX tracepoints
      vhost_net: fix sleeping with preempt-disabled in vhost_net_busy_poll()

Kory Maincent (1):
      net: pse-pd: fix out-of-bounds bitmap access in pse_isr() on 32-bit

Kuniyuki Iwashima (1):
      af_unix: Drop all SCM attributes for SOCKMAP.

Lee Jones (1):
      tipc: fix double-free in tipc_buf_append()

Longxuan Yu (2):
      8021q: use RCU for egress QoS mappings
      8021q: delete cleared egress QoS mappings

Lorenzo Bianconi (7):
      net: airoha: Wait for NPU PPE configuration to complete in airoha_ppe_offload_setup()
      net: airoha: Fix possible TX queue stall in airoha_qdma_tx_napi_poll()
      net: airoha: Fix PPE cpu port configuration for GDM2 loopback path
      net: airoha: Move ndesc initialization at end of airoha_qdma_init_tx()
      net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()
      net: airoha: Move ndesc initialization at end of airoha_qdma_init_rx_queue()
      net: airoha: Add size check for TX NAPIs in airoha_qdma_cleanup()

Luigi Leonardi (3):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
      vsock/test: fix MSG_PEEK handling in recv_buf()
      vsock/test: add MSG_PEEK after partial recv test

Marek Vasut (2):
      net: ks8851: Reinstate disabling of BHs around IRQ handler
      net: ks8851: Avoid excess softirq scheduling

Matt Vollrath (1):
      e1000e: Unroll PTP in probe error handling

Michael Bommarito (2):
      sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
      net/rds: zero per-item info buffer before handing it to visitors

Michal Schmidt (1):
      ice: fix double-free of tx_buf skb

Mieczyslaw Nalewaj (1):
      net: dsa: realtek: rtl8365mb: fix mode mask calculation

Pablo Neira Ayuso (3):
      netfilter: nft_osf: restrict it to ipv4
      netfilter: xtables: restrict several matches to inet family
      netfilter: nat: use kfree_rcu to release ops

Paolo Abeni (6):
      Merge branch 'net-sleepable-ndo_set_rx_mode'
      Merge branch 'net-airoha-fix-airoha_qdma_cleanup_tx_queue-processing'
      Merge tag 'nf-26-04-20' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'net-airoha-fix-null-pointer-derefrences-in-airoha_qdma_cleanup'
      Merge branch 'net-mana-fix-probe-remove-error-path-bugs'
      Merge branch 'mptcp-sync-the-msk-sndbuf-at-accept-time'

Paul Greenwalt (2):
      ice: fix PHY config on media change with link-down-on-close
      ice: fix ICE_AQ_LINK_SPEED_M for 200G

Petr Oros (1):
      iavf: fix wrong VLAN mask for legacy Rx descriptors L2TAG2

Prathamesh Deshpande (1):
      net/mlx5: Fix HCA caps leak on notifier init failure

Qingfang Deng (2):
      flow_dissector: do not dissect PPPoE PFC frames
      pppoe: drop PFC frames

Ralf Lici (6):
      selftests: ovpn: add nftables config dependencies for test-mark
      selftests: ovpn: fail notification check on mismatch
      selftests: ovpn: flatten slurped notification JSON before filtering
      selftests: ovpn: add prefix to helpers and shared variables
      selftests: ovpn: align command flow with TAP
      selftests: ovpn: serialize YNL listener startup

Ruide Cao (1):
      ipv4: icmp: validate reply type before using icmp_pointers

Ruijie Li (1):
      net/smc: avoid early lgr access in smc_clc_wait_msg

Stanislav Fomichev (16):
      net: dsa: remove redundant netdev_lock_ops() from conduit ethtool ops
      net: add address list snapshot and reconciliation infrastructure
      net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work
      net: cache snapshot entries for ndo_set_rx_mode_async
      net: move promiscuity handling into netdev_rx_mode_work
      fbnic: convert to ndo_set_rx_mode_async
      mlx5: convert to ndo_set_rx_mode_async
      bnxt: convert to ndo_set_rx_mode_async
      bnxt: use snapshot in bnxt_cfg_rx_mode
      iavf: convert to ndo_set_rx_mode_async
      netdevsim: convert to ndo_set_rx_mode_async
      dummy: convert to ndo_set_rx_mode_async
      netkit: convert to ndo_set_rx_mode_async
      net: warn ops-locked drivers still using ndo_set_rx_mode
      selftests: net: add team_bridge_macvlan rx_mode test
      selftests: net: use ip commands instead of teamd in team rx_mode test

Stefano Garzarella (1):
      vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting

Vikas Gupta (2):
      bnge: fix initial HWRM sequence
      bnge: remove unsupported backing store type

Vinicius Costa Gomes (1):
      net/sched: taprio: fix use-after-free in advance_sched() on schedule switch

Wei Fang (2):
      net: enetc: correct the command BD ring consumer index
      net: enetc: fix NTMP DMA use-after-free issue

Weiming Shi (3):
      openvswitch: cap upcall PID array size and pre-size vport replies
      slip: reject VJ receive packets on instances with no rstate array
      slip: bound decode() reads against the compressed packet length

Xiang Mei (1):
      netfilter: nfnetlink_osf: fix divide-by-zero in OSF_WSS_MODULO

Xin Long (1):
      sctp: fix sockets_allocated imbalance after sk_clone()

Yingnan Zhang (1):
      ipvs: fix MTU check for GSO packets in tunnel mode

Yuan Zhaoming (1):
      net: mctp: fix don't require received header reserved bits to be zero

Zhengchuan Liang (1):
      net: bridge: use a stable FDB dst snapshot in RCU readers

Zhenzhong Wu (2):
      tcp: call sk_data_ready() after listener migration
      selftests/bpf: check epoll readiness during reuseport migration

 Documentation/networking/netdevices.rst            |  13 +
 Documentation/process/maintainer-netdev.rst        |   2 +-
 MAINTAINERS                                        |   7 +
 drivers/net/dsa/realtek/rtl8365mb.c                |   2 +-
 drivers/net/dummy.c                                |   6 +-
 drivers/net/ethernet/airoha/airoha_eth.c           | 110 ++++--
 drivers/net/ethernet/airoha/airoha_eth.h           |   4 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |  34 +-
 drivers/net/ethernet/broadcom/bnge/bnge_core.c     |  30 +-
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c     |  16 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  58 +--
 drivers/net/ethernet/freescale/enetc/ntmp.c        | 231 ++++++-----
 .../net/ethernet/freescale/enetc/ntmp_private.h    |  10 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |   1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   1 -
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  16 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h        |   2 +-
 drivers/net/ethernet/intel/ice/ice.h               |   4 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c       |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c          | 121 ++----
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  44 +--
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h    |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        | 259 ++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   5 +
 drivers/net/ethernet/intel/ice/ice_sf_eth.c        |   2 +
 drivers/net/ethernet/intel/ice/ice_txrx.c          |  29 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h          |  16 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |  32 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |  20 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h     |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c        |   2 +-
 drivers/net/ethernet/micrel/ks8851.h               |   6 +-
 drivers/net/ethernet/micrel/ks8851_common.c        |  69 ++--
 drivers/net/ethernet/micrel/ks8851_par.c           |  15 +-
 drivers/net/ethernet/micrel/ks8851_spi.c           |  11 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  35 +-
 .../ethernet/netronome/nfp/nfpcore/nfp_target.c    |  17 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   4 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   3 +-
 drivers/net/gtp.c                                  |   2 +
 drivers/net/macvlan.c                              |   1 +
 drivers/net/mdio/Kconfig                           |   1 +
 drivers/net/netconsole.c                           |   2 +
 drivers/net/netdevsim/netdev.c                     |   8 +-
 drivers/net/netkit.c                               |   6 +-
 drivers/net/ppp/ppp_generic.c                      |   2 +-
 drivers/net/ppp/pppoe.c                            |   8 +-
 drivers/net/pse-pd/pse_core.c                      |  13 +-
 drivers/net/slip/slhc.c                            |  49 ++-
 drivers/net/virtio_net.c                           |   6 +
 drivers/vhost/net.c                                |   4 +-
 include/linux/fsl/ntmp.h                           |   9 +-
 include/linux/if_vlan.h                            |  25 +-
 include/linux/netdevice.h                          |  28 ++
 include/linux/ppp_defs.h                           |  16 +
 include/net/mctp.h                                 |   3 +
 include/net/pie.h                                  |   2 +-
 include/net/tcp.h                                  |  12 +-
 include/net/tcp_ecn.h                              |   2 +-
 include/trace/events/net.h                         |   4 +-
 include/trace/events/rxrpc.h                       |   6 +-
 net/8021q/vlan_dev.c                               |  45 ++-
 net/8021q/vlan_netlink.c                           |  10 +-
 net/8021q/vlanproc.c                               |  12 +-
 net/bridge/br_arp_nd_proxy.c                       |   8 +-
 net/bridge/br_fdb.c                                |  28 +-
 net/core/dev.c                                     |  67 +---
 net/core/dev.h                                     |   4 +
 net/core/dev_addr_lists.c                          | 385 ++++++++++++++++++-
 net/core/dev_addr_lists_test.c                     | 387 ++++++++++++++++++-
 net/core/dev_api.c                                 |   3 +
 net/core/dev_ioctl.c                               |   6 +-
 net/core/filter.c                                  |   2 +-
 net/core/flow_dissector.c                          |  13 +-
 net/core/rtnetlink.c                               |   1 +
 net/dsa/conduit.c                                  |  16 +-
 net/ipv4/icmp.c                                    |   5 +-
 net/ipv4/inet_connection_sock.c                    |   3 +
 net/ipv4/netfilter/iptable_nat.c                   |   4 +-
 net/ipv4/nexthop.c                                 |   4 +-
 net/ipv4/tcp.c                                     |  62 +--
 net/ipv4/tcp_bbr.c                                 |   6 +-
 net/ipv4/tcp_bic.c                                 |   2 +-
 net/ipv4/tcp_cdg.c                                 |   4 +-
 net/ipv4/tcp_cubic.c                               |   6 +-
 net/ipv4/tcp_dctcp.c                               |   2 +-
 net/ipv4/tcp_input.c                               |  52 +--
 net/ipv4/tcp_metrics.c                             |   6 +-
 net/ipv4/tcp_nv.c                                  |   4 +-
 net/ipv4/tcp_output.c                              |  19 +-
 net/ipv4/tcp_plb.c                                 |   2 +-
 net/ipv4/tcp_timer.c                               |   2 +-
 net/ipv4/tcp_vegas.c                               |   9 +-
 net/ipv4/tcp_westwood.c                            |   4 +-
 net/ipv4/tcp_yeah.c                                |   3 +-
 net/ipv6/icmp.c                                    |  10 +-
 net/ipv6/ip6_tunnel.c                              |   6 +
 net/ipv6/netfilter/ip6table_nat.c                  |   4 +-
 net/ipv6/seg6_iptunnel.c                           |   3 +-
 net/llc/af_llc.c                                   |   4 +-
 net/mctp/route.c                                   |   8 +-
 net/mptcp/protocol.c                               |   2 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |  19 +-
 net/netfilter/nf_nat_amanda.c                      |   2 +-
 net/netfilter/nf_nat_core.c                        |  10 +-
 net/netfilter/nf_nat_sip.c                         |  33 +-
 net/netfilter/nfnetlink_osf.c                      |  45 +--
 net/netfilter/nft_osf.c                            |   6 +-
 net/netfilter/xt_mac.c                             |  34 +-
 net/netfilter/xt_owner.c                           |  37 +-
 net/netfilter/xt_physdev.c                         |  29 +-
 net/netfilter/xt_realm.c                           |   2 +-
 net/openvswitch/datapath.c                         |  35 +-
 net/openvswitch/vport.c                            |   3 +
 net/packet/af_packet.c                             |  21 +-
 net/rds/connection.c                               |  14 +
 net/rds/rdma.c                                     |   4 -
 net/rxrpc/ar-internal.h                            |   1 -
 net/rxrpc/call_event.c                             |  20 +-
 net/rxrpc/conn_event.c                             |  43 ++-
 net/rxrpc/io_thread.c                              |  24 +-
 net/rxrpc/key.c                                    |   4 +
 net/rxrpc/rxgk_app.c                               |   3 +-
 net/rxrpc/rxgk_common.h                            |   1 +
 net/rxrpc/rxkad.c                                  | 112 +++---
 net/rxrpc/skbuff.c                                 |   9 -
 net/sched/act_mirred.c                             |   2 +-
 net/sched/sch_cake.c                               |   2 +-
 net/sched/sch_dualpi2.c                            |  32 +-
 net/sched/sch_fq_codel.c                           |   3 +-
 net/sched/sch_hhf.c                                |  19 +-
 net/sched/sch_pie.c                                |  38 +-
 net/sched/sch_red.c                                |  31 +-
 net/sched/sch_sfb.c                                |  54 +--
 net/sched/sch_taprio.c                             |   9 +-
 net/sctp/socket.c                                  |   5 +-
 net/smc/smc_clc.c                                  |   4 +-
 net/tipc/msg.c                                     |  14 +-
 net/unix/af_unix.c                                 |  35 +-
 net/vmw_vsock/hyperv_transport.c                   |  29 +-
 net/vmw_vsock/virtio_transport_common.c            |  19 +-
 .../selftests/bpf/prog_tests/migrate_reuseport.c   |  49 ++-
 .../selftests/drivers/net/bonding/lag_lib.sh       |  17 +-
 .../selftests/drivers/net/team/dev_addr_lists.sh   |   2 -
 tools/testing/selftests/net/config                 |   1 +
 tools/testing/selftests/net/fib_nexthops.sh        |  22 ++
 tools/testing/selftests/net/mptcp/diag.sh          |  28 ++
 tools/testing/selftests/net/ovpn/common.sh         | 363 +++++++++++++-----
 tools/testing/selftests/net/ovpn/config            |   3 +
 .../testing/selftests/net/ovpn/test-chachapoly.sh  |   2 +-
 .../selftests/net/ovpn/test-close-socket-tcp.sh    |   2 +-
 .../selftests/net/ovpn/test-close-socket.sh        | 102 +++--
 tools/testing/selftests/net/ovpn/test-float.sh     |   2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh      | 233 +++++++----
 .../selftests/net/ovpn/test-symmetric-id-float.sh  |   4 +-
 .../selftests/net/ovpn/test-symmetric-id-tcp.sh    |   4 +-
 .../selftests/net/ovpn/test-symmetric-id.sh        |   2 +-
 tools/testing/selftests/net/ovpn/test-tcp.sh       |   2 +-
 tools/testing/selftests/net/ovpn/test.sh           | 427 ++++++++++++++-------
 .../packetdrill/tcp_rfc5961_ack-out-of-window.pkt  |  48 +++
 .../net/packetdrill/tcp_ts_recent_invalid_ack.pkt  |   4 +-
 tools/testing/selftests/net/rtnetlink.sh           |  44 +++
 tools/testing/selftests/net/tcp_ao/config          |   1 +
 tools/testing/vsock/util.c                         |  15 +
 tools/testing/vsock/vsock_test.c                   |  50 ++-
 172 files changed, 3537 insertions(+), 1417 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt

