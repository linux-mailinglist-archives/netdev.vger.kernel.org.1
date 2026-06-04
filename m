Return-Path: <netdev+bounces-295365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R4h4B0G5IWp1MgEAu9opvQ
	(envelope-from <netdev+bounces-295365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:43:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 148446425E6
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:43:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BvSubC3W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295365-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295365-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FF5E30817CD
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDF64C9552;
	Thu,  4 Jun 2026 17:31:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EAD4C0409;
	Thu,  4 Jun 2026 17:31:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594300; cv=none; b=duJzjk8VlaSv1k/64/eYARvp8ILN1GEH+jBwOU8svytUviHjhCLpx35Xpl5ViLIAdnz7taqTbcLMdLRhUEvnw6Qs1SujBoLkbBjdzQcIuZMdqpve7z939gVONQuqGsVpyaK4NdkJ/5kTXsvBaFxWGnFrfWwjWMc/IdF6OfAj17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594300; c=relaxed/simple;
	bh=bSM10phuJ6MhGdydiAxLhALTpsvidvkm3AUB7O8rpWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YOiu3OzFP/5FHh/tMaigTwLX0c0dOjXG/D8NgQUkG93OaLFhB+pl9en7GYkRLJKzPM43+2hhk9GCoY95Oec93rEcs0PLjzVnkOVTD1v3sexzLEH3oGZczYIrccL1FEXZRg0krkbveGuESM0CkOf1nKRpnb9wo8mNbnhP8cjBlh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvSubC3W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A2F1F00893;
	Thu,  4 Jun 2026 17:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780594298;
	bh=DOANalrTDTT5Jz9WMH5KKyYydvW54Zuj8u99ZCEPHBM=;
	h=From:To:Cc:Subject:Date;
	b=BvSubC3W1MFXOWaatOy53kKsBB0qviodiWKHb93E7i46xCnjWj3GGQ8f0CaUIfRlR
	 rCmzJopv/Nbe+kb1MoQBOSbqSbWgj7Df74Us8JRAeuYfjuhT3FXH+vtWzdIVXNzO9q
	 Lq1Yo4oANluiu22378T1PIHgcNvdSG2MwztC7w2uyfki2sbvG527lkAnIdStgzplpG
	 1T6Y8qvLH2dyE11YwddgsATxxUkcvHDxjaQCF0cEAlqxX7qnFGp4TTtPGJZ1webXR3
	 OfWGugg6C8ClUXWZ8Sfq5Pp+q8egWuovxelJ/8Ud2Mx9KqR1E9cl7VdKBq5kwXnQ6/
	 6sCrzZhd8jjYg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.1-rc7
Date: Thu,  4 Jun 2026 10:31:37 -0700
Message-ID: <20260604173137.3434910-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295365-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 148446425E6

Hi Linus!

The following changes since commit f3be0c984ecbcb82b0bec408022c4ef738cb3843:

  Merge tag 'net-7.1-rc6-2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-05-29 15:46:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc7

for you to fetch changes up to b6197b386677ae5268d4702e23849d9ad53051ad:

  Reapply "bnxt_en: bring back rtnl_lock() in the bnxt_open() path" (2026-06-04 09:02:37 -0700)

----------------------------------------------------------------
Including fixes from Netfilter, wireless and Bluetooth.

Current release - fix to a fix:

 - Bluetooth: MGMT: fix backward compatibility with bluetoothd
   which adds stray bytes to MGMT_OP_ADD_EXT_ADV_DATA

Previous releases - regressions:

 - af_unix: fix inq_len update inaccuracy on partial read

 - eth: fec: fix pinctrl default state restore order on resume

 - wifi: iwlwifi: mvm: don't support the reset handshake for old firmwares

 - wifi: iwlwifi: pcie: simplify the resume flow if fast resume is
   not used, work around NIC access failures

Previous releases - always broken:

 - Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig

 - sctp: fix a couple of bugs in COOKIE_ECHO processing

 - sched: fix pedit partial COW leading to page cache corruption

 - wifi: nl80211: reject oversized EMA RNR lists

 - netfilter: conntrack_irc: fix possible out-of-bounds read

 - netfilter: bridge: make ebt_snat ARP rewrite writable

 - appletalk: zero-initialize aarp_entry to prevent heap info leak

 - ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options

 - mptcp: fix number of bugs reported by AI scans and discovered during
   NVMe over MPTCP testing

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Andy Roulin (3):
      vxlan: vnifilter: send notification on VNI add
      vxlan: vnifilter: fix spurious notification on VNI update
      selftests: net: add vxlan vnifilter notification test

Antoine Tenart (1):
      geneve: fix length used in GRO hint UDP checksum adjustment

Bharath Reddy (1):
      Bluetooth: fix memory leak in error path of hci_alloc_dev()

David Thompson (1):
      net: lan743x: permit VLAN-tagged packets up to configured MTU

Deepanshu Kartikey (1):
      wifi: mac80211: limit injected antenna index in ieee80211_parse_tx_radiotap

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: don't support the reset handshake for old firmwares
      wifi: iwlwifi: mvm: avoid oversized UATS command copy
      wifi: iwlwifi: pcie: simplify the resume flow if fast resume is not used

Eric Dumazet (3):
      ipv4: restrict IPOPT_SSRR and IPOPT_LSRR options
      ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()
      bonding: annotate data-races arcound churn variables

Fedor Pchelkin (1):
      wifi: fix leak if split 6 GHz scanning fails

Fernando Fernandez Mancera (2):
      netfilter: xt_NFQUEUE: prefer raw_smp_processor_id
      netfilter: synproxy: add mutex to guard hook reference counting

Florian Westphal (2):
      netfilter: conntrack_irc: fix possible out-of-bounds read
      netfilter: nft_byteorder: remove multi-register support

Gang Yan (1):
      mptcp: check desc->count in read_sock

Geetha sowjanya (1):
      octeontx2-pf: Fix NDC sync operation errors

Ido Schimmel (1):
      ipv6: mcast: Fix use-after-free when processing MLD queries

Jakub Kicinski (8):
      Merge tag 'nf-26-06-01' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'af_unix-fix-inq_len-update-issue'
      Merge branch 'mptcp-misc-fixes-for-v7-1-rc7'
      Merge tag 'wireless-2026-06-03' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'for-net-2026-06-03' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'fix-use-after-free-in-metadata-dst-teardown-in-airoha_eth-and-mtk_eth_soc-drivers'
      Merge branch 'vxlan-vnifilter-fix-vni-add-update-notifications'
      Reapply "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"

Jamal Hadi Salim (1):
      net/sched: act_api: use RCU with deferred freeing for action lifecycle

Jason Xing (1):
      xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()

Jianyu Li (2):
      af_unix: Fix inq_len update problem in partial read
      af_unix: Add test for SCM_INQ on partial read

Jiayuan Chen (3):
      netfilter: nft_fib_ipv6: bail out of sibling walk if rt got unlinked
      netfilter: nft_ct: bail out on template ct in get eval
      ipv6: anycast: insert aca into global hash under idev->lock

Johannes Berg (2):
      Merge tag 'iwlwifi-fixes-2026-05-31' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      wifi: cfg80211: enforce HE/EHT cap/oper consistency

Jonas Jelonek (1):
      net: sfp: initialize i2c_block_size at adapter configure time

Julian Anastasov (1):
      ipvs: clear the svc scheduler ptr early on edit

Justin Lai (2):
      rtase: Reset TX subqueue when clearing TX ring
      rtase: Avoid sleeping in get_stats64()

Kuniyuki Iwashima (3):
      net: Annotate sk->sk_write_space() for UDP SOCKMAP.
      tcp: Add preempt_{disable,enable}_nested() in reqsk_queue_hash_req().
      hsr: Remove WARN_ONCE() in hsr_addr_is_self().

Kurt Kanzenbach (1):
      ptp: vclock: Switch from RCU to SRCU

Lee Jones (1):
      l2tp: pppol2tp: hold reference to session in pppol2tp_ioctl()

Lorenzo Bianconi (2):
      net: airoha: Fix use-after-free in metadata dst teardown
      net: ethernet: mtk_eth_soc: Fix use-after-free in metadata dst teardown

Luiz Augusto von Dentz (3):
      Bluetooth: ISO: Fix not releasing hdev reference on iso_conn_big_sync
      Bluetooth: ISO: Fix a use-after-free of the hci_conn pointer
      Bluetooth: MGMT: Fix backward compatibility with userspace

Mark Bloch (1):
      devlink: Release nested relation on devlink free

Matthieu Baerts (NGI0) (3):
      mptcp: sockopt: check timestamping ret value
      mptcp: sockopt: set sockopt on all subflows
      mptcp: add-addr: always drop other suboptions

Michael Bommarito (1):
      Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig

Nikolay Kuratov (1):
      net/mlx5: Reorder completion before putting command entry in cmd_work_handler

Nithin Dabilpuram (1):
      octeontx2-af: npc: Fix CPT channel mask in npc_install_flow

Oscar Maes (1):
      pcnet32: stop holding device spin lock during napi_complete_done

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: mld: send tx power constraints before link activation

Paolo Abeni (5):
      mptcp: fix missing wakeups in edge scenarios
      mptcp: fix retransmission loop when csum is enabled
      mptcp: close TOCTOU race while computing rcv_wnd
      mptcp: allow subflow rcv wnd to shrink
      mptcp: fix uninit-value in mptcp_established_options

Raf Dickson (1):
      vsock/vmci: fix sk_ack_backlog leak on failed handshake

Rajat Gupta (1):
      net/sched: fix pedit partial COW leading to page cache corruption

Sechang Lim (1):
      udp: clear skb->dev before running a sockmap verdict

SeungJu Cheon (3):
      Bluetooth: RFCOMM: validate skb length in MCC handlers
      Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls
      Bluetooth: SCO: Fix data-race on sco_pi fields in sco_connect

Suman Ghosh (1):
      octeontx2-af: Fix initialization of mcam's entry2target_pffunc field

Tao Cui (2):
      mptcp: pm: fix extra_subflows underflow on userspace PM subflow creation
      selftests: mptcp: add test for extra_subflows underflow on userspace PM

Tapio Reijonen (1):
      net: fec: fix pinctrl default state restore order on resume

Tristan Madani (1):
      netfilter: nft_tunnel: fix use-after-free on object destroy

Xin Long (2):
      sctp: validate cached peer INIT chunk length in COOKIE_ECHO processing
      sctp: purge outqueue on stale COOKIE-ECHO handling

Yiming Qian (1):
      netfilter: bridge: make ebt_snat ARP rewrite writable

Yizhou Zhao (4):
      6lowpan: fix off-by-one in multicast context address compression
      net: garp: fix unsigned integer underflow in garp_pdu_parse_attr
      appletalk: aarp: zero-initialize aarp_entry to prevent heap info leak
      net/802/mrp: fix vector attribute parsing in mrp_pdu_parse_vecattr

Yuqi Xu (3):
      wifi: nl80211: reject oversized EMA RNR lists
      net: rds: clear i_sends on setup unwind
      Bluetooth: hci_sync: reject oversized Broadcast Announcement prepend

Zhang Cen (3):
      Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
      Bluetooth: MGMT: validate advertising TLV before type checks
      Bluetooth: bnep: reject short frames before parsing

Zhao Zhang (1):
      sctp: diag: reject stale associations in dump_one path

ZhaoJinming (1):
      net: bonding: fix NULL pointer dereference in bond_do_ioctl()

Zhi Li (1):
      dt-bindings: ethernet: eswin: fix hsp-sp-csr backward compatibility

 .../devicetree/bindings/net/eswin,eic7700-eth.yaml |   3 +-
 drivers/net/bonding/bond_3ad.c                     |  18 +-
 drivers/net/bonding/bond_main.c                    |   4 +-
 drivers/net/bonding/bond_netlink.c                 |   4 +-
 drivers/net/bonding/bond_procfs.c                  |   8 +-
 drivers/net/ethernet/airoha/airoha_eth.c           |   2 +-
 drivers/net/ethernet/amd/pcnet32.c                 |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  36 +++-
 drivers/net/ethernet/freescale/fec_main.c          |   3 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  36 ++--
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |   2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   6 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |  32 ++++
 drivers/net/ethernet/microchip/lan743x_main.h      |   1 +
 drivers/net/ethernet/realtek/rtase/rtase_main.c    |   7 +-
 drivers/net/geneve.c                               |   2 +-
 drivers/net/phy/sfp.c                              |   1 +
 drivers/net/vxlan/vxlan_vnifilter.c                |   5 +-
 drivers/net/wireless/intel/iwlwifi/mld/ap.c        |   4 -
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   7 +
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  28 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   6 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  56 ++++---
 drivers/ptp/ptp_vclock.c                           |  14 +-
 include/net/act_api.h                              |   1 +
 include/net/bluetooth/l2cap.h                      |   1 +
 include/net/ip_vs.h                                |   3 +-
 include/net/mptcp.h                                |   7 +-
 include/net/tc_act/tc_pedit.h                      |   1 -
 net/6lowpan/iphc.c                                 |   4 +-
 net/802/garp.c                                     |   2 +-
 net/802/mrp.c                                      |   9 +
 net/appletalk/aarp.c                               |   2 +-
 net/bluetooth/bnep/core.c                          |  59 ++++---
 net/bluetooth/hci_sync.c                           |   5 +
 net/bluetooth/hci_sysfs.c                          |   6 +-
 net/bluetooth/iso.c                                |  63 +++++--
 net/bluetooth/l2cap_core.c                         |  46 ++++++
 net/bluetooth/mgmt.c                               |  17 +-
 net/bluetooth/rfcomm/core.c                        |  69 +++++---
 net/bluetooth/rfcomm/sock.c                        |  26 ++-
 net/bluetooth/sco.c                                |  20 ++-
 net/bridge/netfilter/ebt_snat.c                    |   3 +
 net/core/sock.c                                    |   8 +-
 net/devlink/core.c                                 |   2 +
 net/hsr/hsr_framereg.c                             |   4 +-
 net/ieee802154/6lowpan/tx.c                        |   5 +
 net/ipv4/inet_connection_sock.c                    |   6 +
 net/ipv4/ip_options.c                              |   4 +
 net/ipv4/udp.c                                     |   8 +
 net/ipv6/anycast.c                                 |  16 +-
 net/ipv6/mcast.c                                   |   8 +-
 net/ipv6/netfilter/nft_fib_ipv6.c                  |   3 +
 net/l2tp/l2tp_ppp.c                                |  92 ++++++-----
 net/mac80211/tx.c                                  |   4 +-
 net/mptcp/options.c                                |  79 +++++----
 net/mptcp/pm.c                                     |  15 +-
 net/mptcp/pm_userspace.c                           |  14 +-
 net/mptcp/protocol.c                               |  10 ++
 net/mptcp/protocol.h                               |   7 +-
 net/mptcp/sockopt.c                                |  15 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |  13 +-
 net/netfilter/ipvs/ip_vs_sched.c                   |  14 +-
 net/netfilter/nf_conntrack_irc.c                   |   4 +-
 net/netfilter/nf_synproxy_core.c                   |  24 ++-
 net/netfilter/nft_byteorder.c                      |  51 +++---
 net/netfilter/nft_ct.c                             |   8 +-
 net/netfilter/nft_ct_fast.c                        |   2 +-
 net/netfilter/nft_tunnel.c                         |   2 +-
 net/netfilter/xt_NFQUEUE.c                         |   2 +-
 net/rds/ib_cm.c                                    |   1 +
 net/sched/act_api.c                                |   7 +-
 net/sched/act_pedit.c                              |  77 +++++----
 net/sctp/diag.c                                    |  17 +-
 net/sctp/sm_make_chunk.c                           |   5 +
 net/sctp/sm_statefuns.c                            |   6 +-
 net/unix/af_unix.c                                 |  11 +-
 net/vmw_vsock/vmci_transport.c                     |   4 +-
 net/wireless/nl80211.c                             |   9 +
 net/wireless/scan.c                                |   9 +-
 net/xdp/xsk.c                                      |  11 +-
 tools/testing/selftests/net/Makefile               |   1 +
 tools/testing/selftests/net/af_unix/scm_inq.c      |  54 +++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   4 +
 .../selftests/net/test_vxlan_vnifilter_notify.sh   | 184 +++++++++++++++++++++
 89 files changed, 1027 insertions(+), 433 deletions(-)
 create mode 100755 tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh

