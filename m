Return-Path: <netdev+bounces-269575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNO1CY8yvGnxuQIAu9opvQ
	(envelope-from <netdev+bounces-269575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:29:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913EC2D002A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C03D30C5F0B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22E73EF0C7;
	Thu, 19 Mar 2026 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMzEoXGB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1F034C145;
	Thu, 19 Mar 2026 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940843; cv=none; b=HZfZbVa2CfSY9G9oL/m2popUST66e6WOD7BLLATJmbH/aygXshBkEIFCgMXFdcUdYAwoMGHaCj23kYUgB+qTC08YzbYSbmXd+tukQaid7axWttoJKryhdgZ63epWNyWr3u8QvaQjQG/gbsEz+4ji8Ao2VQSt2PTn6Ipx4qzQGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940843; c=relaxed/simple;
	bh=5lzWrXSlKvKkaID5dU/3UmRGqSmnvppG81tXVNlHNH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=scwSZCTQcgGSgsSVvO6rQLaMFyDmh6KjLiHUg4EYgVg3gfPYfzSs40acX9T78EI4oTJPD58FVj6HmYz2R4VEepYqGvnqqFYKCdjJHrErdUQY8TCXznREXDU8/s8luO3I5duTJcoZSzABZ3ab0CjBNXhTlbAeyEi7CiM6cIyk7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMzEoXGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C3AC2BCAF;
	Thu, 19 Mar 2026 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773940843;
	bh=5lzWrXSlKvKkaID5dU/3UmRGqSmnvppG81tXVNlHNH8=;
	h=From:To:Cc:Subject:Date:From;
	b=EMzEoXGBKzgw2UUdFH/xj8pRuhCZRJCEvMegKhV0xy107sIwiE39LqST7/d3eQFdb
	 MzxbstyVa5CpJvWKGRjjesCJVJ4mZE97RznhJenDCG0y1LlumC59iCXXjIAQoQj1hQ
	 fMpa51Mjooq0UHhxgiSzXaouombKuDJQH1H8ewETASDWpegmOa3jlKDoURTK5Cx6zj
	 WLhvO1et+wm+EKhnvONYNoJzufrasWf3pMR7vlaeFzsma9h7TDA6ID2C4V2BrR8HwC
	 cPLR6mTEcRJmQpCJFNrOPsJkDjMDp4dCWYL1GmX4zmkGCW+eAIH9YCVjIvYvjA16/r
	 qGZWhW4gCTTGw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.0-rc5
Date: Thu, 19 Mar 2026 10:20:41 -0700
Message-ID: <20260319172041.4035309-1-kuba@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269575-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,open-mesh.org:url]
X-Rspamd-Queue-Id: 913EC2D002A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus!

The following changes since commit 2c7e63d702f6c4209c5af833308e7fcbc7d4ab17:

  Merge tag 'net-7.0-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-03-12 11:33:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc5

for you to fetch changes up to 7ab4a7c5d969642782b8a5b608da0dd02aa9f229:

  MPTCP: fix lock class name family in pm_nl_create_listen_socket (2026-03-19 09:37:48 -0700)

----------------------------------------------------------------
Including fixes from wireless, Bluetooth and netfilter.

Nothing too exciting here, mostly fixes for corner cases.

Current release - fix to a fix:

 - bonding: prevent potential infinite loop in bond_header_parse()

Current release - new code bugs:

 - wifi: mac80211: check tdls flag in ieee80211_tdls_oper

Previous releases - regressions:

 - af_unix: give up GC if MSG_PEEK intervened

 - netfilter: conntrack: add missing netlink policy validations

 - NFC: nxp-nci: allow GPIOs to sleep

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Anas Iqbal (1):
      net: dsa: bcm_sf2: fix missing clk_disable_unprepare() in error paths

Christian Eggers (3):
      Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU
      Bluetooth: LE L2CAP: Disconnect if sum of payload sizes exceed SDU
      Bluetooth: SMP: make SM/PER/KDU/BI-04-C happy

Cosmin Ratiu (1):
      net/mlx5: qos: Restrict RTNL area to avoid a lock cycle

Daniel Borkmann (1):
      clsact: Fix use-after-free in init/destroy rollback asymmetry

Deepanshu Kartikey (2):
      wifi: mac80211: check tdls flag in ieee80211_tdls_oper
      atm: lec: fix use-after-free in sock_def_readable()

Dipayaan Roy (1):
      net: mana: fix use-after-free in mana_hwc_destroy_channel() by reordering teardown

Dmitry Baryshkov (1):
      Bluetooth: qca: fix ROM version reading on WCN3998 chips

Eric Dumazet (2):
      ip_tunnel: adapt iptunnel_xmit_stats() to NETDEV_PCPU_STAT_DSTATS
      bonding: prevent potential infinite loop in bond_header_parse()

Eric Woudstra (1):
      netfilter: nf_flow_table_ip: reset mac header before vlan push

Fedor Pchelkin (2):
      net: macb: fix use-after-free access to PTP clock
      net: macb: fix uninitialized rx_fs_lock

Felix Fietkau (2):
      mac80211: fix crash in ieee80211_chan_bw_change for AP_VLAN stations
      wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure

Florian Westphal (3):
      netfilter: conntrack: add missing netlink policy validations
      netfilter: revert nft_set_rbtree: validate open interval overlap
      netfilter: bpf: defer hook memory release until rcu readers are done

Guenter Roeck (1):
      wifi: wlcore: Return -ENOMEM instead of -EAGAIN if there is not enough headroom

Hyunwoo Kim (2):
      bridge: cfm: Fix race condition in peer_mep deletion
      netfilter: ctnetlink: fix use-after-free in ctnetlink_dump_exp_ct()

Ian Ray (1):
      NFC: nxp-nci: allow GPIOs to sleep

Jakub Kicinski (10):
      Merge tag 'for-net-2026-03-12' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'nf-26-03-13' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'net-macb-fix-ethernet-malfunction-on-amd-versal-board-after-suspend'
      Merge branch 'net-usb-cdc_ncm-add-ndpoffset-to-ndp-nframes-bounds-check'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'batadv-net-pullrequest-20260317' of https://git.open-mesh.org/linux-merge
      Merge branch 'mlx5-misc-fixes-2026-03-16'
      Merge tag 'wireless-2026-03-18' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      net: shaper: protect late read accesses to the hierarchy
      net: shaper: protect from late creation of hierarchy

Jamal Hadi Salim (1):
      net/sched: teql: Fix double-free in teql_master_xmit

Jenny Guanni Qu (3):
      netfilter: nf_conntrack_h323: fix OOB read in decode_int() CONS case
      netfilter: xt_time: use unsigned int for monthday bit shift
      netfilter: nf_conntrack_h323: check for zero length in DecodeQ931()

Jianbo Liu (2):
      net/mlx5e: Prevent concurrent access to IPSec ASO context
      net/mlx5e: Fix race condition during IPSec ESN update

Jiayuan Chen (2):
      net/rose: fix NULL pointer dereference in rose_transmit_link on reconnect
      net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()

Johannes Berg (2):
      wifi: mac80211_hwsim: fully initialise PMSR capabilities
      wifi: mac80211: remove keys after disabling beaconing

Junrui Luo (1):
      bnxt_en: fix OOB access in DBG_BUF_PRODUCER async event handler

Justin Chen (1):
      net: bcmgenet: increase WoL poll timeout

Kevin Hao (2):
      net: macb: Introduce gem_init_rx_ring()
      net: macb: Reinitialize tx/rx queue pointer registers and rx ring during resume

Kohei Enju (1):
      igc: fix missing update of skb->tail in igc_xmit_frame()

Kuniyuki Iwashima (2):
      wifi: mac80211: Fix static_branch_dec() underflow for aql_disable.
      af_unix: Give up GC if MSG_PEEK intervened.

Li Xiasong (1):
      MPTCP: fix lock class name family in pm_nl_create_listen_socket

Lorenzo Bianconi (1):
      net: airoha: Remove airoha_dev_stop() in airoha_remove()

Luiz Augusto von Dentz (3):
      Bluetooth: ISO: Fix defer tests being unstable
      Bluetooth: HIDP: Fix possible UAF
      Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ

Lukas Johannes Möller (3):
      Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
      Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload length before access
      netfilter: nf_conntrack_sip: fix Content-Length u32 truncation in sip_help_tcp()

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix memory leak in XDP_DROP for non-zero-copy mode

Michael Grzeschik (1):
      Bluetooth: hci_sync: Fix hci_le_create_conn_sync

Michal Swiatkowski (1):
      libie: prevent memleak in fwlog code

Minhong He (1):
      ipv6: add NULL checks for idev in SRv6 paths

Muhammad Hammad Ijaz (1):
      net: mvpp2: guard flow control update with global_tx_fc in buffer switching

Nicolas Cavallari (1):
      wifi: mac80211: use jiffies_delta_to_msecs() for sta_info inactive times

Nikola Z. Ivanov (1):
      net: usb: aqc111: Do not perform PM inside suspend callback

Pablo Neira Ayuso (4):
      nf_tables: nft_dynset: fix possible stateful expression memleak in error path
      netfilter: nft_ct: drop pending enqueued packets on removal
      netfilter: xt_CT: drop pending enqueued packets on template removal
      netfilter: nf_tables: release flowtable after rcu grace period on error

Paolo Abeni (1):
      Merge tag 'nf-26-03-19' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Paul SAGE (1):
      tg3: replace placeholder MAC address with device property

Peddolla Harshavardhan Reddy (1):
      wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down

Petr Oros (1):
      iavf: fix VLAN filter lost on add/delete race

Sabrina Dubroca (1):
      mpls: add missing unregister_netdevice_notifier to mpls_init

Shaurya Rane (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user

Tobi Gaertner (2):
      net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bounds check
      net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bounds check

Wang Tao (1):
      Bluetooth: MGMT: Fix list corruption and UAF in command complete handlers

Weiming Shi (2):
      nfnetlink_osf: validate individual option lengths in fingerprints
      icmp: fix NULL pointer dereference in icmp_tag_validation()

Wesley Atwell (1):
      netdevsim: drop PSP ext ref on forward failure

Xiang Mei (3):
      wifi: mac80211: fix NULL deref in mesh_matches_local()
      udp_tunnel: fix NULL deref caused by udp_sock_create6 when CONFIG_IPV6=n
      net: bonding: fix NULL deref in bond_debug_rlb_hash_show

Yang Yang (1):
      batman-adv: avoid OGM aggregation when skb tailroom is insufficient

Zdenek Bouska (1):
      igc: fix page fault in XDP TX timestamps handling

 Documentation/netlink/specs/net_shaper.yaml        |  12 +-
 drivers/bluetooth/btqca.c                          |   2 +
 drivers/firewire/net.c                             |   5 +-
 drivers/net/bonding/bond_debugfs.c                 |  16 ++-
 drivers/net/bonding/bond_main.c                    |   8 +-
 drivers/net/dsa/bcm_sf2.c                          |   8 +-
 drivers/net/ethernet/airoha/airoha_eth.c           |   1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |   2 +-
 drivers/net/ethernet/broadcom/tg3.c                |  11 ++
 drivers/net/ethernet/cadence/macb_main.c           |  26 +++-
 drivers/net/ethernet/cadence/macb_ptp.c            |   4 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   9 +-
 drivers/net/ethernet/intel/igc/igc.h               |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c          |  14 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |  33 +++++
 drivers/net/ethernet/intel/libie/fwlog.c           |  49 +++++--
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   4 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |   1 +
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |  52 +++----
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |  23 ++-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |   6 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c       |   5 +
 drivers/net/netdevsim/netdev.c                     |   5 +-
 drivers/net/usb/aqc111.c                           |  12 +-
 drivers/net/usb/cdc_ncm.c                          |  10 +-
 drivers/net/wireless/ath/ath9k/channel.c           |   6 +-
 drivers/net/wireless/mediatek/mt76/scan.c          |   4 +-
 drivers/net/wireless/ti/wlcore/tx.c                |   2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   3 +-
 drivers/nfc/nxp-nci/i2c.c                          |   4 +-
 include/linux/etherdevice.h                        |   3 +-
 include/linux/if_ether.h                           |   3 +-
 include/linux/netdevice.h                          |   9 +-
 include/net/ip_tunnels.h                           |  28 +++-
 include/net/mac80211.h                             |   4 +-
 include/net/netfilter/nf_tables.h                  |   6 +-
 include/net/sch_generic.h                          |  33 +++++
 include/net/udp_tunnel.h                           |   2 +-
 net/atm/lec.c                                      |  72 ++++++----
 net/atm/lec.h                                      |   2 +-
 net/batman-adv/bat_iv_ogm.c                        |   3 +
 net/bluetooth/hci_conn.c                           |   4 +-
 net/bluetooth/hci_sync.c                           |   2 +-
 net/bluetooth/hidp/core.c                          |  16 ++-
 net/bluetooth/l2cap_core.c                         |  51 ++++---
 net/bluetooth/mgmt.c                               |   7 +-
 net/bluetooth/smp.c                                |   2 +-
 net/bridge/br_cfm.c                                |   4 +-
 net/ethernet/eth.c                                 |   9 +-
 net/ipv4/icmp.c                                    |   4 +-
 net/ipv4/ip_gre.c                                  |   3 +-
 net/ipv6/exthdrs.c                                 |   4 +
 net/ipv6/seg6_hmac.c                               |   2 +
 net/mac80211/cfg.c                                 |  12 +-
 net/mac80211/chan.c                                |   6 +-
 net/mac80211/debugfs.c                             |  14 +-
 net/mac80211/mesh.c                                |   3 +
 net/mac80211/sta_info.c                            |   7 +-
 net/mac80211/tdls.c                                |   2 +-
 net/mac80211/tx.c                                  |   4 +-
 net/mac802154/iface.c                              |   4 +-
 net/mpls/af_mpls.c                                 |   1 +
 net/mptcp/pm_kernel.c                              |   2 +-
 net/netfilter/nf_bpf_link.c                        |   2 +-
 net/netfilter/nf_conntrack_h323_asn1.c             |   4 +
 net/netfilter/nf_conntrack_netlink.c               |  28 +++-
 net/netfilter/nf_conntrack_proto_sctp.c            |   3 +-
 net/netfilter/nf_conntrack_sip.c                   |   6 +-
 net/netfilter/nf_flow_table_ip.c                   |   1 +
 net/netfilter/nf_tables_api.c                      |  26 +---
 net/netfilter/nfnetlink_osf.c                      |  13 ++
 net/netfilter/nft_ct.c                             |   4 +
 net/netfilter/nft_dynset.c                         |  10 +-
 net/netfilter/nft_set_rbtree.c                     |  71 ++-------
 net/netfilter/xt_CT.c                              |   4 +
 net/netfilter/xt_time.c                            |   4 +-
 net/phonet/af_phonet.c                             |   5 +-
 net/rose/af_rose.c                                 |   5 +
 net/sched/sch_generic.c                            |  27 ----
 net/sched/sch_ingress.c                            |  14 +-
 net/sched/sch_teql.c                               |   7 +-
 net/shaper/shaper.c                                | 160 ++++++++++++---------
 net/shaper/shaper_nl_gen.c                         |  12 +-
 net/shaper/shaper_nl_gen.h                         |   5 +
 net/smc/af_smc.c                                   |  23 ++-
 net/smc/smc.h                                      |   5 +
 net/smc/smc_close.c                                |   2 +-
 net/unix/af_unix.c                                 |   2 +
 net/unix/af_unix.h                                 |   1 +
 net/unix/garbage.c                                 |  79 ++++++----
 net/wireless/pmsr.c                                |   1 +
 93 files changed, 735 insertions(+), 460 deletions(-)

