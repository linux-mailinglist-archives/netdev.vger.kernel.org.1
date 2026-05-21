Return-Path: <netdev+bounces-290595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDKOF5dUD2raJAYAu9opvQ
	(envelope-from <netdev+bounces-290595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:53:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B45AB46F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5F9D3031C12
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6653905F5;
	Thu, 21 May 2026 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8Q1v+oY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB48387590;
	Thu, 21 May 2026 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779388998; cv=none; b=kgWjVpfdYXPoqQZCIbCiu/nPHwuZzd2JSFGBaRLRnyx4ZWg1HTtguOi79iEASN5/oQB4jqNe4Za81uQLpz+moECirfFGUXFalqqeKPQKMHMeMXyu1aEDGXfF3lGRCy1FStENhOSEIePzCWrZm0XpyoLRLx7Gzwbk31rouJ38AWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779388998; c=relaxed/simple;
	bh=DEqVy03gYoD5WQq7sbFHSAGZHhSITFtkyzqez0DGeGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JtuYuJ0jAkCzJhajZ/V9VyqGfksSW24aqQmRXhDKaNF1HM93Z6/sYXZbCyzn5OEHLnQG0B//4mEv4J7tKSrXLDYOGI+E3ENXHZ+aPv2xZ0m8uG52Wxv2fB5qxeNdQpCtpFHfYDlThhgMFMAVL2ERRE0nwpbbTmTks9Z+eIlFyNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8Q1v+oY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1283F1F000E9;
	Thu, 21 May 2026 18:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779388996;
	bh=mDr2wfbt1lqeqHLcrxPA5MrJY6mZadsjN6kMd7ZxQsA=;
	h=From:To:Cc:Subject:Date;
	b=Y8Q1v+oYaaXxz85hjVNYM/B/V9XAqwdjVYEEC1PXPOG1yUL5RsBjG329YgrIRfPRj
	 +valXnhDwhvO3KuE7ZDSg2dVRTPwPzE+BxIWc2bzb+FU929ZRlhy61rusdx6ZiJ3+t
	 Mzq9axrwoeqAyEHp1Z0LRxTponO9zZAQdq5e5jZtIoyfRyfz4WyGtlS4pIEguHUQIl
	 66edeuc86pU/2ZVBLWOkXzzgHDXs4zSNHTEjfsFx+pJM8VOIDJEHniGCFjAzljm1jm
	 mK9gPolvIo4ysNJa4g1fuU6tx6bqpKTlkGQBNH2rK87s97IEsbuqroJEqDU04MuTHX
	 v/Pgoi83XmK6A==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.1-rc5
Date: Thu, 21 May 2026 11:43:15 -0700
Message-ID: <20260521184315.3654490-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290595-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[open-mesh.org:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 795B45AB46F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus!

Craziness continues with no end in sight. Even discounting the driver
revert this is a pretty huge PR for standards of the previous era.
I'd speculate - we haven't seen the worst of it, yet. Good news, I guess,
is that so far we haven't seen many (any?) cases of "AI reported a bug,
we fixed it and a real user regressed".

The following changes since commit 66182ca873a4e87b3496eca79d57f86b76d7f52d:

  Merge tag 'net-7.1-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-05-14 08:57:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc5

for you to fetch changes up to 0e3c08f1b7b79b2e9635e70fde3a2f053c99eff1:

  Merge tag 'wireless-2026-05-21' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2026-05-21 11:03:58 -0700)

----------------------------------------------------------------
Including fixes from Bluetooth, wireless and netfilter.

Current release - fix to a fix:

 - Bluetooth: btmtk: accept too short WMT FUNC_CTRL events

 - vsock/virtio: relax the recently added memory limit a little

Current release - regressions:

 - IB/IPoIB: make sure IB drivers always use async set_rx_mode since
   some (mlx5) are now required to use it due to locking changes

Previous releases - regressions:

 - udp: fix UDP length on last GSO_PARTIAL segment

 - af_unix: fix UAF read of tail->len in unix_stream_data_wait()

 - tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction

 - mlx5e: fix unlocked writing to ICOSQ, breaking AF_XDP

Previous releases - always broken:

 - tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR

 - ipv4: raw: reject IP_HDRINCL packets with ihl < 5

 - Bluetooth: a lot of locking and concurrency fixes (as always)

 - batman-adv (mesh wireless networking): a lot of random fixes
   for issues reported by security researchers and Sashiko

 - netfilter: same thing, a lot of small security-ish fixes
   all over the place, nothing really stands out

Misc:

 - bring back the old 3c509 driver, Maciej wants to maintain it

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Abdun Nihaal (1):
      net: wwan: iosm: fix potential memory leaks in ipc_imem_init()

Aditya Garg (1):
      net: mana: validate rx_req_idx to prevent out-of-bounds array access

Alexandru Hossu (1):
      wifi: mac80211: bounds-check link_id in ieee80211_ml_epcs

Alice Mikityanska (1):
      udp: gso: Fix handling checksum in __udp_gso_segment

Antonio Quartulli (1):
      ovpn: fix race between deleting interface and adding new peer

Baochen Qiang (1):
      wifi: ath12k: fix EHT TX MCS limitation due to wrong 20 MHz-only parsing

Christian Marangi (1):
      net: airoha: Fix NPU RX DMA descriptor bits

Chuck Lever (1):
      tls: Preserve sk_err across recvmsg() when data has been copied

Cole Leavitt (1):
      wifi: iwlwifi: mld: fix TSO segmentation explosion when AMSDU is disabled

Daniel Golle (3):
      net: dsa: mt7530: fix FDB entries not aging out with short timeout
      net: dsa: mt7530: preserve VLAN tags on trapped link-local frames
      net: dsa: mt7530: fix CPU port VLAN not being reset to unaware

David Carlier (4):
      ovpn: tcp - use cached peer pointer in ovpn_tcp_close()
      ovpn: respect peer refcount in CMD_NEW_PEER error path
      Bluetooth: ISO: drop ISO_END frames received without prior ISO_START
      net: devmem: reject dma-buf bind with non-page-aligned size or SG length

David Howells (3):
      crypto/krb5, rxrpc: Fix lack of pre-decrypt/pre-verify length checks
      rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in recvmsg
      rxrpc: Fix RESPONSE packet verification to extract skb to a linear buffer

Dawei Feng (3):
      octeontx2-pf: fix double free in rvu_rep_rsrc_init()
      octeontx2-pf: avoid double free of pool->stack on AQ init failure
      qed: fix double free in qed_cxt_tables_alloc()

Dragos Tatulea (2):
      IB/IPoIB: ndo_set_rx_mode_async conversion
      net/mlx5e: xsk: Fix unlocked writing to ICOSQ

Edward Parker (1):
      net: dsa: mt7530: untag VLAN-aware bridge PVID

Emmanuel Grumbach (2):
      wifi: iwlwifi: mld: disconnect only after 6 beacons without Rx
      wifi: mac80211: don't override max_amsdu_subframes

Eric Dumazet (4):
      ipv4: icmp: reject broadcast/multicast routes
      ipv4: use WARN_ON_ONCE() in ip_rt_bug()
      tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction
      net: bridge: prevent too big nested attributes in br_fill_linkxstats()

Erni Sri Satya Vennela (1):
      net: mana: Fix TOCTOU double-fetch of hwc_msg_id from DMA buffer

Florian Westphal (2):
      netfilter: nf_conntrack_helper: fix possible null deref during error log
      netfilter: nft_inner: release local_lock before re-enabling softirqs

Gal Pressman (2):
      net/mlx5e: Don't leak RSS context in case of error
      udp: Fix UDP length on last GSO_PARTIAL segment

Gang Yan (1):
      mptcp: update window_clamp on subflows when SO_RCVBUF is set

Grzegorz Nitka (3):
      ice: ptp: serialize E825 PHY timer start with PTP lock
      ice: ptp: use primary NAC semaphore on E825
      ice: restore PTP Rx timestamp config after ethtool set-channels

Haoze Xie (1):
      netfilter: nf_queue: hold bridge skb->dev while queued

Hyunwoo Kim (1):
      net: skbuff: propagate shared-frag marker through frag-transfer helpers

Ido Schimmel (2):
      bridge: mcast: Fix a possible use-after-free when removing a bridge port
      selftests: bridge_vlan_mcast: Test toggling of multicast snooping

Ilya Maximets (2):
      openvswitch: vport: fix race between linking and the device notifier
      tools: ynl: support listening on all nsids

Ivan Vecera (1):
      dpll: zl3073x: fix memory leak on pin registration failure

Jacob Keller (1):
      ice: fix locking around wait_event_interruptible_locked_irq

Jakub Kicinski (17):
      Merge tag 'for-net-2026-05-14' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'batadv-net-pullrequest-20260515' of https://git.open-mesh.org/batadv
      Merge tag 'nf-26-05-16' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'intel-wired-lan-driver-updates-2026-05-15-ice-ixgbevf-igc-e1000e'
      Merge branch 'bridge-mcast-fix-a-possible-use-after-free-when-removing-a-bridge-port'
      Merge branch 'net-phy-honor-eee_disabled_modes-when-advertising-eee'
      Merge branch 'udp-gso-fix-__udp_gso_segment-after-gso_partial-udp-length-change'
      net: shaper: annotate the data races
      net: shaper: rework the VALID marking (again)
      Merge branch 'net-shaper-fix-valid-confusion-even-more'
      Merge branch 'rxrpc-better-fix-for-data-response-decrypt-vs-splice'
      Merge branch 'bpf-skmsg-fix-verdict-sk_data_ready-racing-with-ktls-rx'
      Merge tag 'for-net-2026-05-20' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      MAINTAINERS: add missing entry for Bluetooth include files
      Merge branch 'ethernet-3c509-bring-driver-back-and-make-some-fixes'
      Merge branch 'net-enetc-sr-iov-robustness-and-security-fixes'
      Merge tag 'wireless-2026-05-21' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jann Horn (2):
      af_unix: Fix UAF read of tail->len in unix_stream_data_wait()
      Bluetooth: bnep: Fix UAF read of dev->name

Jeroen Massar (1):
      net/mlx5: Do not restore destination-less TC rules

Jiajia Liu (1):
      Bluetooth: btmtk: fix urb->setup_packet leak in error paths

Jiexun Wang (1):
      Bluetooth: serialize accept_q access

Johannes Berg (6):
      wifi: iwlwifi: mvm: fix driver-set TX rates on old devices
      wifi: iwlwifi: mld: don't WARN on WoWLAN suspend w/o BSS vif
      wifi: mac80211: fix MLE defragmentation
      wifi: mac80211: fix multi-link element inheritance
      Merge tag 'iwlwifi-fixes-2026-05-16' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'ath-current-20260519' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

John Walker (1):
      wifi: cfg80211: advance loop vars in cfg80211_merge_profile()

Jonas Jelonek (1):
      net: pse-pd: fix sign on -ENOENT check in of_load_pse_pis()

Jose Ignacio Tornos Martinez (1):
      ice: fix VF queue configuration with low MTU values

Jozsef Kadlecsik (4):
      netfilter: ipset: fix a potential dump-destroy race
      netfilter: ipset: Fix data race between add and list header in all hash types
      netfilter: ipset: Fix data race between add and dump in all hash types
      netfilter: ipset: annotate "pos" for concurrent readers/writers

Julian Anastasov (1):
      ipvs: avoid possible loop in ip_vs_dst_event on resizing

Justin Iurman (2):
      ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()
      ipv6: ioam: refresh hdr pointer before ioam6_event()

Kang Yang (1):
      wifi: ath10k: skip WMI and beacon transmission when device is wedged

Kartik Nair (1):
      wifi: cfg80211: wext: validate chandef in monitor mode

Kiran K (1):
      Bluetooth: btintel_pcie: Fix incorrect MAC access programming

Kohei Enju (2):
      igc: set tx buffer type for SMD frames
      igc: fix potential skb leak in igc_fpe_xmit_smd_frame()

Kyle Farnung (1):
      wifi: ath11k: clear shared SRNG pointer state on restart

Li Xiasong (2):
      mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient
      selftests: mptcp: join: cover ADD_ADDR tx drop and list progress

Lorenzo Bianconi (2):
      netfilter: br_netfilter: Reallocate headroom if necessary in neigh_hh_bridge()
      net: airoha: Disable GDM2 forwarding before configuring GDM2 loopback

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix not setting mask for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE

Luxiao Xu (1):
      batman-adv: fix tp_meter counter underflow during shutdown

Maciej W. Rozycki (5):
      Revert "drivers: net: 3com: 3c509: Remove this driver"
      ethernet: 3c509: Fix AUI transceiver type selection
      ethernet: 3c509: Add GPL 2.0 SPDX license identifier
      ethernet: 3c509: Update documentation to match MAINTAINERS
      ethernet: 3c509: Fix most coding style issues

Maoyi Xie (1):
      rds_tcp: close NULL deref window in rds_tcp_set_callbacks

Marcin Szycik (1):
      ice: fix setting promisc mode while adding VID filter

Matt Fleming (1):
      net/mlx5e: Fix use-after-free in mlx5e_tx_reporter_timeout_recover

Matthew Leach (1):
      wifi: ath11k: fix peer resolution on rx path when peer_id=0

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: drop nanoseconds width specifier
      selftests: rds: config: disable modules

Michael Bommarito (8):
      Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
      net: ifb: report ethtool stats over num_tx_queues
      ipv4: raw: reject IP_HDRINCL packets with ihl < 5
      net: hsr: defer node table free until after RCU readers
      ixgbevf: fix use-after-free in VEPA multicast source pruning
      wifi: mac80211: consume only present negotiated TTLM maps
      Bluetooth: MGMT: validate Add Extended Advertising Data length
      l2tp: use list_del_rcu in l2tp_session_unhash

Michael Grzeschik (1):
      MAINTAINERS: Update address for Michael Grzeschik

Mingyu Wang (1):
      Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths

Minh Nguyen (1):
      vsock/vmci: fix UAF when peer resets connection during handshake

Miri Korenblit (1):
      wifi: iwlwifi: mld: don't dereference a pointer before NULL checking it

Moriya Itzchaki (1):
      wifi: iwlwifi: use correct function to read STEP_URM register

Nan Li (1):
      netfilter: ipset: stop hash:* range iteration at end

Nerijus Bendžiūnas (1):
      net: phy: skip EEE advertisement write when autoneg is disabled

Nicolai Buchwitz (3):
      net: phy: honor eee_disabled_modes in phy_support_eee()
      net: phy: honor eee_disabled_modes in phy_advertise_eee_all()
      net: bcmgenet: keep RBUF EEE/PM disabled

Nicolas Escande (3):
      wifi: ath11k: fix error path leaks in some WMI WOW calls
      wifi: ath11k: fix error path leaks in some WMI calls
      wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()

Nikhil P. Rao (3):
      pds_core: fix error handling in pdsc_devcmd_wait
      pds_core: fix debugfs_lookup dentry leak and error handling
      pds_core: ensure null-termination for firmware version strings

Nimrod Oren (1):
      selftests: net: Fix checksums in xdp_native

Or Har-Toov (1):
      net/mlx5: Skip disabled vports when setting max TX speed

Paolo Abeni (7):
      Merge branch 'net-dsa-mt7530-assorted-fixes'
      Merge tag 'ovpn-net-20260514' of https://github.com/OpenVPN/ovpn-net-next
      mptcp: reset rcv wnd on disconnect
      Merge branch 'mptcp-misc-fixes-for-v7-1-rc4'
      Merge branch 'net-stmmac-eic7700-fix-delay-calculation-and-initialization-ordering'
      Merge branch 'vsock-virtio-fix-skb-overhead-accounting-to-preserve-full-buf_alloc'
      Merge tag 'batadv-net-pullrequest-20260520' of https://git.open-mesh.org/batadv

Pauli Virtanen (1):
      Bluetooth: btmtk: accept too short WMT FUNC_CTRL events

Prathamesh Deshpande (1):
      net/mlx5e: Fix eswitch mode block underflow on IPsec acquire SA

Ralf Lici (2):
      selftests: ovpn: reduce remaining ping flood counts
      ovpn: disable BHs when updating device stats

Ratheesh Kannoth (1):
      octeontx2-af: npc: Fix allmulticast skip logic for LBK and SDP VFs

Rosen Penev (1):
      net: ag71xx: check error for platform_get_irq

Ruide Cao (1):
      batman-adv: fix fragment reassembly length accounting

Ruijie Li (1):
      batman-adv: clear current gateway during teardown

Sabrina Dubroca (1):
      net: gro: don't merge zcopy skbs

Safa Karakuş (1):
      Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()

Sam Daly (1):
      octeontx2-af: CGX: add bounds check to cgx_speed_mbps index

Shardul Bankar (1):
      mptcp: do not drop partial packets

Sheroz Juraev (1):
      wifi: iwlwifi: mld: stop TX during firmware restart

Shitalkumar Gandhi (1):
      wifi: wilc1000: fix dma_buffer leak on bus acquire failure

Shuai Zhang (1):
      Bluetooth: hci_qca: Convert timeout from jiffies to ms

Stefano Garzarella (3):
      vsock/virtio: fix zerocopy completion for multi-skb sends
      vsock/virtio: reset connection on receiving queue overflow
      vsock/virtio: fix skb overhead accounting to preserve full buf_alloc

Sven Eckelmann (22):
      batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
      batman-adv: tt: reject oversized local TVLV buffers
      batman-adv: tt: fix negative tt_buff_len
      batman-adv: tt: fix negative last_changeset_len
      batman-adv: tt: fix TOCTOU race for reported vlans
      batman-adv: tt: avoid empty VLAN responses
      batman-adv: tt: prevent TVLV entry number overflow
      batman-adv: dat: handle forward allocation error
      batman-adv: tp_meter: avoid use of uninit sender vars
      batman-adv: frag: disallow unicast fragment in fragment
      batman-adv: tp_meter: directly shut down timer on cleanup
      batman-adv: fix batadv_skb_is_frag() kernel-doc
      batman-adv: v: stop OGMv2 on disabled interface
      batman-adv: tvlv: abort OGM send on tvlv append failure
      batman-adv: tvlv: reject oversized TVLV packets
      batman-adv: tp_meter: fix race condition in send error reporting
      batman-adv: tp_meter: avoid role confusion in tp_list
      batman-adv: mcast: fix use-after-free in orig_node RCU release
      batman-adv: iv: recover OGM scheduling after forward packet error
      batman-adv: bla: fix report_work leak on backbone_gw purge
      batman-adv: bla: avoid double decrement of bla.num_requests
      batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface

Wei Fang (9):
      net: enetc: fix incorrect mailbox message status returned to VFs
      net: enetc: fix missing error code when pf->vf_state allocation fails
      net: enetc: add ratelimiting to VF mailbox error messages
      net: enetc: fix TOCTOU race and validate VF MAC address
      net: enetc: fix race condition in VF MAC address configuration
      net: enetc: fix DMA write to freed memory in enetc_msg_free_mbx()
      net: enetc: fix unbounded loop and interrupt handling in VF-to-PF messaging
      net: enetc: fix init and teardown order to prevent use of unsafe resources
      net: enetc: avoid VF->PF mailbox timeout during SR-IOV teardown

Weiming Shi (3):
      net: appletalk: fix NULL pointer dereference in aarp_send_ddp()
      net: qualcomm: rmnet: fix endpoint use-after-free in rmnet_dellink()
      tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR

William Bowling (1):
      net: skbuff: preserve shared-frag marker during coalescing

Willmar Knikker (1):
      wifi: ath11k: fix use after free in ath11k_dp_rx_msdu_coalesce()

Xingwang Xiang (2):
      bpf, skmsg: fix verdict sk_data_ready racing with ktls rx
      selftests/bpf: add regression test for ktls+sockmap verdict UAF

Yizhou Zhao (1):
      netfilter: nft_inner: Fix IPv6 inner_thoff desync

Yuho Choi (1):
      ipv6: route: Unregister netdevice notifier on BPF init failure

Zhang Cen (1):
      netpoll: normalize skb->dev to the netpoll device

Zhao Li (1):
      wifi: mac80211: capture fast-RX rate before mesh reuses skb->cb

Zhengchuan Liang (1):
      netfilter: ip6t_hbh: reject oversized option lists

Zhi Li (5):
      dt-bindings: ethernet: eswin: add optional TXD and RXD delay register offsets
      net: stmmac: eswin: fix HSP CSR init ordering after clock enable
      net: stmmac: eswin: clear TXD and RXD delay registers during initialization
      net: stmmac: eswin: correct RGMII delay granularity to 20 ps
      net: stmmac: eswin: validate RGMII delay values

Zijing Yin (1):
      phonet/pep: disable BH around forwarded sk_receive_skb()

 .mailmap                                           |    2 +
 Documentation/.renames.txt                         |    1 +
 Documentation/crypto/krb5.rst                      |   17 +-
 .../devicetree/bindings/net/eswin,eic7700-eth.yaml |   13 +-
 .../device_drivers/ethernet/3com/3c509.rst         |  249 ++++
 .../networking/device_drivers/ethernet/index.rst   |    1 +
 MAINTAINERS                                        |    3 +-
 arch/powerpc/configs/ppc6xx_defconfig              |    1 +
 crypto/krb5/krb5_api.c                             |   54 +-
 drivers/bluetooth/btintel_pcie.c                   |   20 +-
 drivers/bluetooth/btintel_pcie.h                   |    3 -
 drivers/bluetooth/btmtk.c                          |    6 +-
 drivers/bluetooth/hci_ldisc.c                      |   48 +-
 drivers/bluetooth/hci_qca.c                        |   33 +-
 drivers/dpll/zl3073x/dpll.c                        |    6 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |    8 +-
 drivers/net/dsa/mt7530.c                           |  160 +-
 drivers/net/ethernet/3com/3c509.c                  | 1543 ++++++++++++++++++++
 drivers/net/ethernet/3com/Kconfig                  |   14 +
 drivers/net/ethernet/3com/Makefile                 |    1 +
 drivers/net/ethernet/airoha/airoha_eth.c           |   10 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c        |    7 +-
 drivers/net/ethernet/amd/pds_core/dev.c            |   11 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |    6 +-
 drivers/net/ethernet/atheros/ag71xx.c              |    3 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    9 +-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |   15 +-
 drivers/net/ethernet/freescale/enetc/enetc_msg.c   |  108 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |   75 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.h    |    1 +
 drivers/net/ethernet/intel/ice/ice_main.c          |    8 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |   33 +-
 drivers/net/ethernet/intel/ice/virt/queues.c       |    2 +-
 drivers/net/ethernet/intel/igc/igc_tsn.c           |    9 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |    1 +
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |    7 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |    2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c |    2 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |    2 +
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |    3 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |    6 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |    7 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |    5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c  |    2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   21 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |    5 +
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |   35 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |    2 +
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |    8 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-eic7700.c    |  128 +-
 drivers/net/ifb.c                                  |   11 +-
 drivers/net/ovpn/io.c                              |   12 +-
 drivers/net/ovpn/main.c                            |   12 +-
 drivers/net/ovpn/netlink.c                         |    8 +-
 drivers/net/ovpn/peer.c                            |   23 +-
 drivers/net/ovpn/peer.h                            |    1 -
 drivers/net/ovpn/stats.h                           |   16 +
 drivers/net/ovpn/tcp.c                             |   19 +-
 drivers/net/ovpn/udp.c                             |    2 +-
 drivers/net/phy/phy-c45.c                          |    8 +
 drivers/net/phy/phy_device.c                       |    6 +-
 drivers/net/pse-pd/pse_core.c                      |    2 +-
 drivers/net/tap.c                                  |    2 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |   17 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |    9 +-
 drivers/net/wireless/ath/ath11k/hal.c              |   14 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |    5 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |    1 +
 drivers/net/wireless/ath/ath11k/wmi.c              |  131 +-
 drivers/net/wireless/ath/ath12k/mac.c              |    8 +-
 drivers/net/wireless/intel/iwlwifi/mld/constants.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |   13 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |   15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   14 +-
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c         |    6 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |    2 +-
 drivers/net/wwan/iosm/iosm_ipc_imem.c              |    2 +
 include/crypto/krb5.h                              |    9 +-
 include/linux/soc/airoha/airoha_offload.h          |    6 +-
 include/net/bluetooth/bluetooth.h                  |    1 +
 include/net/ip_vs.h                                |    3 +-
 include/net/neighbour.h                            |    8 +-
 include/net/net_shaper.h                           |    1 +
 include/net/netfilter/nf_queue.h                   |    1 +
 include/net/tcp.h                                  |    7 +-
 include/trace/events/rxrpc.h                       |    1 +
 net/appletalk/aarp.c                               |    5 +
 net/batman-adv/bat_iv_ogm.c                        |   82 +-
 net/batman-adv/bat_v_ogm.c                         |   59 +-
 net/batman-adv/bridge_loop_avoidance.c             |  109 +-
 net/batman-adv/distributed-arp-table.c             |    3 +
 net/batman-adv/fragmentation.c                     |   58 +-
 net/batman-adv/gateway_client.c                    |    4 +
 net/batman-adv/mesh-interface.c                    |    1 +
 net/batman-adv/originator.c                        |    4 +-
 net/batman-adv/tp_meter.c                          |  117 +-
 net/batman-adv/translation-table.c                 |   55 +-
 net/batman-adv/tvlv.c                              |   28 +-
 net/batman-adv/tvlv.h                              |    2 +-
 net/batman-adv/types.h                             |   59 +-
 net/bluetooth/af_bluetooth.c                       |   99 +-
 net/bluetooth/bnep/core.c                          |    2 +-
 net/bluetooth/hci_sync.c                           |    6 +-
 net/bluetooth/iso.c                                |   14 +-
 net/bluetooth/l2cap_core.c                         |    2 +-
 net/bluetooth/l2cap_sock.c                         |   51 +-
 net/bluetooth/mgmt.c                               |    6 +
 net/bluetooth/rfcomm/sock.c                        |    9 +-
 net/bluetooth/sco.c                                |    9 +-
 net/bridge/br_multicast.c                          |   22 +-
 net/bridge/br_netfilter_hooks.c                    |    6 +-
 net/bridge/br_netlink.c                            |   10 +
 net/core/devmem.c                                  |   11 +
 net/core/gro.c                                     |    7 +
 net/core/netpoll.c                                 |    2 +
 net/core/rtnetlink.c                               |    5 +-
 net/core/skbuff.c                                  |   11 +-
 net/core/skmsg.c                                   |    9 +-
 net/hsr/hsr_framereg.c                             |    4 +-
 net/ipv4/icmp.c                                    |    3 +
 net/ipv4/raw.c                                     |    2 +-
 net/ipv4/route.c                                   |    2 +-
 net/ipv4/tcp.c                                     |    3 -
 net/ipv4/tcp_input.c                               |   15 +-
 net/ipv4/tcp_ipv4.c                                |    3 +-
 net/ipv4/tcp_output.c                              |    1 +
 net/ipv4/udp_offload.c                             |   22 +-
 net/ipv6/exthdrs.c                                 |   21 +-
 net/ipv6/netfilter/ip6t_hbh.c                      |    4 +
 net/ipv6/route.c                                   |    6 +-
 net/ipv6/tcp_ipv6.c                                |    3 +-
 net/l2tp/l2tp_core.c                               |    2 +-
 net/mac80211/cfg.c                                 |    5 +-
 net/mac80211/mlme.c                                |    5 +-
 net/mac80211/parse.c                               |  107 +-
 net/mac80211/rx.c                                  |    6 +-
 net/mptcp/pm.c                                     |   56 +-
 net/mptcp/protocol.c                               |   25 +-
 net/mptcp/sockopt.c                                |   10 +-
 net/netfilter/ipset/ip_set_core.c                  |    5 +-
 net/netfilter/ipset/ip_set_hash_gen.h              |   57 +-
 net/netfilter/ipset/ip_set_hash_ipmark.c           |    6 +-
 net/netfilter/ipset/ip_set_hash_ipport.c           |    5 +-
 net/netfilter/ipset/ip_set_hash_ipportip.c         |    5 +-
 net/netfilter/ipset/ip_set_hash_ipportnet.c        |    5 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |  187 ++-
 net/netfilter/nf_conntrack_helper.c                |   13 +-
 net/netfilter/nf_queue.c                           |    4 +-
 net/netfilter/nfnetlink_queue.c                    |    2 +
 net/netfilter/nft_inner.c                          |    3 +-
 net/openvswitch/vport-netdev.c                     |    8 +
 net/phonet/pep.c                                   |   19 +-
 net/rds/tcp.c                                      |    9 +-
 net/rxrpc/ar-internal.h                            |   14 +-
 net/rxrpc/call_event.c                             |   22 +-
 net/rxrpc/call_object.c                            |    2 +
 net/rxrpc/conn_event.c                             |   30 +-
 net/rxrpc/insecure.c                               |    8 +-
 net/rxrpc/recvmsg.c                                |   68 +-
 net/rxrpc/rxgk.c                                   |  160 +-
 net/rxrpc/rxgk_app.c                               |   46 +-
 net/rxrpc/rxgk_common.h                            |   66 +-
 net/rxrpc/rxkad.c                                  |  115 +-
 net/shaper/shaper.c                                |   98 +-
 net/tls/tls_sw.c                                   |   20 +-
 net/unix/af_unix.c                                 |   11 +-
 net/vmw_vsock/virtio_transport_common.c            |  112 +-
 net/vmw_vsock/vmci_transport.c                     |    2 +-
 net/wireless/scan.c                                |    3 +
 net/wireless/wext-compat.c                         |    2 +
 tools/net/ynl/pyynl/lib/ynl.py                     |   37 +-
 .../selftests/bpf/prog_tests/sockmap_ktls.c        |  103 ++
 .../selftests/bpf/progs/test_sockmap_ktls.c        |   21 +
 .../selftests/net/forwarding/bridge_vlan_mcast.sh  |   30 +-
 tools/testing/selftests/net/lib/xdp_native.bpf.c   |   55 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |    6 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   31 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   10 +-
 .../selftests/net/ovpn/test-close-socket.sh        |    2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh      |    6 +-
 tools/testing/selftests/net/ovpn/test.sh           |    4 +-
 tools/testing/selftests/net/rds/config             |    1 +
 187 files changed, 4452 insertions(+), 1287 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/3com/3c509.rst
 create mode 100644 drivers/net/ethernet/3com/3c509.c

