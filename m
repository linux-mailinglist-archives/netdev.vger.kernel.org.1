Return-Path: <netdev+bounces-285442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NE/HjHK/GlhTwAAu9opvQ
	(envelope-from <netdev+bounces-285442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:21:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E28DB4ECCEA
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1B03301AAB2
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5E4306B37;
	Thu,  7 May 2026 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f47UMFg7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F8616F27F;
	Thu,  7 May 2026 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174509; cv=none; b=Asu9PrpOUBONmrKFGgsW5YcRpBt1/3dZeiLt0Ott36ua1AnwfPj0CT4DlrR6zelT7MmJ1y4b312hRpqLR4eJNJpGHL2fN9lrL5zkLJCjPb+aeua+rSgzpElV6dzVC6nQF86hsa/iUfmMZb2824JeKh3NGEm4I1IC1Y60BYVD/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174509; c=relaxed/simple;
	bh=q9/Vgq/7gfH9UnzWpwqOSo3fYoyvpejBFcZQUsW9PcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JIE782kabZzkdCbOh3jkKBDkkOfpD2nYHD9F3MyEddBmkCQzlwiNlCtec6qRu66Lej2aGtpv4C2E9Eg5or8bcbE+PYK/eCLjnYx36rwlfFUkBCV5QHNNH2ZMu2YmkmPYNA62vofb8FBKnhtl+t6A7KFHFmqe8XDBf8rMF1TEmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f47UMFg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7EEC2BCB2;
	Thu,  7 May 2026 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778174508;
	bh=q9/Vgq/7gfH9UnzWpwqOSo3fYoyvpejBFcZQUsW9PcQ=;
	h=From:To:Cc:Subject:Date:From;
	b=f47UMFg7gOLcUw/q5AOPXc6uSIykmzoeSnzOcNE96aDUnOlHy9iz+F6ljksZ8pJgB
	 vjVE8AddU+m5DhsQ75rpA3Xr+3jlzGFcbgsZt5q7dkHOjA3YvthoYxmliNV86UPo5J
	 x9OF/2oiSLWTQ2B794TUNpzgX6kX4YYcqkDnslLJ5CI4vjR7yP6iNC06IVuYggjgle
	 cMEHaHWtLZgPYLYxxpME+Foyl8/iVuBwCv0cJY0H0uObOhdcBTfCm7q6TPFn54/2LY
	 cR/qOn8GutML6tS9CLXE60N7BXsHYT7cqPH++mE9GsMtqhK3aOJZT6zf80SyrCiPko
	 x1wFlDZGPts2Q==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.1-rc3
Date: Thu,  7 May 2026 10:21:47 -0700
Message-ID: <20260507172147.3509230-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E28DB4ECCEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285442-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,test.sh:url]
X-Rspamd-Action: no action

Hi Linus!

The following changes since commit 08d0d3466664000ba0670e0ef0d447f23459e0d4:

  Merge tag 'net-7.1-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-04-30 08:45:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc3

for you to fetch changes up to 41ae14071cd7f6a7770e2fe1f8a0859d4c2c6ba4:

  net: sparx5: configure serdes for 1000BASE-X in sparx5_port_init() (2026-05-07 09:08:47 -0700)

----------------------------------------------------------------
Including fixes from Netfilter, IPsec, Bluetooth and WiFi.

Current release - fix to a fix:

 - ipmr: add __rcu to netns_ipv4.mrt, make sure we hold the RCU lock
   in all relevant places

Current release - new code bugs:

 - fixes for the recently added resizable hash tables

 - ipv6: make sure we default IPv6 tunnel drivers to =m now that
   IPv6 itself is built in

 - drv: octeontx2-af: fixes for parser/CAM fixes

Previous releases - regressions:

 - phy: micrel: fix LAN8814 QSGMII soft reset

 - wifi: cw1200: revert "Fix locking in error paths"

 - wifi: ath12k: fix crash on WCN7850, due to adding the same queue
   buffer to a list multiple times

Previous releases - always broken:

 - number of info leak fixes

 - ipv6: implement limits on extension header parsing

 - wifi: number of fixes for missing bound checks in the drivers

 - Bluetooth: fixes for races and locking issues

 - af_unix: fix an issue between garbage collection and PEEK

 - af_unix: fix yet another issue with OOB data

 - xfrm: esp: avoid in-place decrypt on shared skb frags

 - netfilter: replace skb_try_make_writable() by skb_ensure_writable()

 - openvswitch: vport: fix race between tunnel creation and linking
   leading to invalid memory accesses (type confusion)

 - drv: amd-xgbe: fix PTP addend overflow causing frozen clock

Misc:

 - sched/isolation: make HK_TYPE_KTHREAD an alias of HK_TYPE_DOMAIN
   (for relevant IPVS change)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: fix OF node refcount imbalance in WSI graph traversal

Aleksander Jan Bajkowski (1):
      net: usb: r8152: add TRENDnet TUC-ET2G v2.0

Alex Cheema (1):
      net: usb: cdc_ncm: add Apple Mac USB-C direct networking quirk

Alyssa Ross (1):
      ipv6: default IPV6_SIT to m

Amir Mohammad Jahangirzad (1):
      wifi: libertas: fix integer underflow in process_cmdrequest()

Andreas Haarmann-Thiemann (1):
      net: ethernet: cortina: Drop half-assembled SKB

Aurelien DESBRIERES (1):
      Bluetooth: hci_uart: Fix NULL deref in recv callbacks when priv is uninitialized

Baochen Qiang (2):
      wifi: ath12k: prepare REO update element only for primary link
      wifi: ath12k: fix peer_id usage in normal RX path

Bart Van Assche (1):
      wifi: cw1200: Revert "Fix locking in error paths"

Benjamin Berg (1):
      wifi: mac80211: use safe list iteration in radar detect work

Bobby Eshleman (1):
      eth: fbnic: fix double-free of PCS on phylink creation failure

Breno Leitao (1):
      netpoll: pass buffer size to egress_dev() to avoid MAC truncation

Catherine (1):
      wifi: mac80211: drop stray 'static' from fast-RX rx_result

Cosmin Ratiu (6):
      tools/selftests: Use a sensible timeout value for iperf3 client
      tools/selftests: Add a VXLAN+IPsec traffic test
      xfrm: Don't clobber inner headers when already set
      net/mlx5e: psp: Fix invalid access on PSP dev registration fail
      net/mlx5e: psp: Expose only a fully initialized priv->psp
      net/mlx5e: psp: Hook PSP dev reg/unreg to profile enable/disable

D. Wythe (1):
      net/smc: fix missing sk_err when TCP handshake fails

Daniel Borkmann (1):
      ipv6: Implement limits on extension header parsing

Daniel Golle (1):
      net: dsa: mt7530: fix .get_stats64 sleeping in atomic context

Daniel Machon (2):
      net: sparx5: fix wrong chip ids for TSN SKUs
      net: sparx5: configure serdes for 1000BASE-X in sparx5_port_init()

Daniel Zahka (3):
      netdevsim: psp: only call nsim_psp_uninit() on PFs
      netdevsim: psp: serialize calls to nsim_psp_uninit()
      netdevsim: psp: rcu protect psp_dev reference

David Carlier (2):
      psp: strip variable-length PSP header in psp_dev_rcv()
      Bluetooth: hci_conn: fix potential UAF in create_big_sync

Dipayaan Roy (4):
      net: mana: check xdp_rxq registration before unreg in mana_destroy_rxq()
      net: mana: Skip WQ object destruction for uninitialized RXQ
      net: mana: remove double CQ cleanup in mana_create_rxq error path
      net: mana: Fix crash from unvalidated SHM offset read from BAR0 during FLR

Dmitry Baryshkov (1):
      wifi: ath10k: snoc: select POWER_SEQUENCING

Dudu Lu (2):
      Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling
      Bluetooth: l2cap: fix MPS check in l2cap_ecred_reconf_req

Eric Dumazet (12):
      ipmr: prevent info-leak in pmr_cache_report()
      ipv4: igmp: annotate data-races in igmp_heard_query()
      net/sched: sch_pie: annotate more data-races in pie_dump_stats()
      net/sched: sch_cake: annotate data-races in cake_dump_class_stats (I)
      net/sched: sch_cake: annotate data-races in cake_dump_class_stats (II)
      vsock/virtio: fix potential unbounded skb queue
      net: prevent possible UAF in rtnl_prop_list_size()
      net/sched: sch_fq_codel: annotate data-races from fq_codel_dump_class_stats()
      ipv6: fix potential UAF caused by ip6_forward_proxy_check()
      inetpeer: add a missing read_seqretry() in inet_getpeer()
      net/sched: sch_sfq: annotate data-races from sfq_dump_class_stats()
      tcp: tcp_child_process() related UAF

Fernando Fernandez Mancera (3):
      netfilter: nf_socket: skip socket lookup for non-first fragments
      netfilter: nf_tables: skip L4 header parsing for non-first fragments
      netfilter: xtables: fix L4 header parsing for non-first fragments

Florian Westphal (2):
      netfilter: xt_CT: fix usersize for v1 and v2 revision
      netfilter: nf_tables: fix netdev hook allocation memleak with dormant tables

Gregory Fuchedgi (1):
      amd-xgbe: fix PTP addend overflow causing frozen clock

Holger Brunck (2):
      net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
      net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove

Ilya Maximets (3):
      openvswitch: vport: fix race between tunnel creation and linking
      openvswitch: vport: fix self-deadlock on release of tunnel ports
      selftests: openvswitch: add tests for tunnel vport refcounting

Jakov Novak (1):
      wifi: libertas: notify firmware load wait on disconnect

Jakub Kicinski (21):
      Merge branch 'net-mctp-test-minor-kunit-test-fixes'
      Merge branch 'octeontx2-af-npc-cn20k-mcam-fixes'
      Merge tag 'nf-26-05-01' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'ipv6-fix-ecmp-route-failover-on-carrier-loss'
      Merge branch 'replace-direct-dequeue-call-with-qdisc_dequeue_peeked'
      Merge branch 'net-sched-sch_cake-annotate-data-races-in-cake_dump_class_stats-series'
      net: tls: fix silent data drop under pipe back-pressure
      selftests: tls: add test for data loss on small pipe
      Merge branch 'mptcp-misc-fixes-for-v7-1-rc3'
      Merge branch 'bnxt_en-bug-fixes'
      Merge tag 'nf-26-05-05' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'net-mlx5e-psp-fixes'
      Merge branch 'net-mlx5-fixes-for-socket-direct'
      Merge branch 'xsk-fix-bugs-around-xsk-skb-allocation'
      Merge tag 'wireless-2026-05-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'for-net-2026-05-06' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'ovpn-net-20260504' of https://github.com/OpenVPN/ovpn-net-next
      Merge tag 'ipsec-2026-05-05' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      selftests: drv-net: fix sort order of makefile and config
      Merge branch 'netdevsim-psp-fix-init-and-uninit-bugs'
      Merge branch 'mptcp-pm-misc-fixes-for-v7-1-rc3'

Jamal Hadi Salim (1):
      net/sched: sch_red: Replace direct dequeue call with peek and qdisc_dequeue_peeked

Jann Horn (1):
      Bluetooth: hci_event: fix memset typo

Jason Xing (8):
      xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
      xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
      xsk: handle NULL dereference of the skb without frags issue
      xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
      xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
      xsk: avoid skb leak in XDP_TX_METADATA case
      xsk: fix xsk_addrs slab leak on multi-buffer error path
      xsk: fix u64 descriptor address truncation on 32-bit architectures

Jeongjun Park (1):
      wifi: rsi: fix kthread lifetime race between self-exit and external-stop

Jeremy Kerr (2):
      net: mctp: test: use a zeroed struct sockaddr_mctp
      net: mctp: test: Use dev_direct_xmit for TX to our test device

Jesper Dangaard Brouer (1):
      veth: fix OOB txq access in veth_poll() with asymmetric queue counts

Jiawen Wu (2):
      net: libwx: fix VF illegal register access
      net: libwx: use request_irq for VF misc interrupt

Jiexun Wang (1):
      af_unix: Reject SIOCATMARK on non-stream sockets

Jiri Slaby (SUSE) (1):
      wifi: ath5k: do not access array OOB

Joey Lu (1):
      net: stmmac: dwmac-nuvoton: fix NULL pointer dereference in nvt_set_phy_intf_sel()

Johannes Berg (5):
      Merge tag 'ath-current-20260427' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: tests: mark HT check strict
      Merge tag 'ath-current-20260505' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: remove station if connection prep fails
      wifi: nl80211: fix NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST usage

Julian Anastasov (6):
      ipvs: fixes for the new ip_vs_status info
      ipvs: fix races around the conn_lfactor and svc_lfactor sysctl vars
      ipvs: fix the spin_lock usage for RT build
      ipvs: do not leak dest after get from dest trash
      ipvs: fix races around est_mutex and est_cpulist
      ipvs: fix shift-out-of-bounds in ip_vs_rht_desired_size

Justin Chen (1):
      net: phy: broadcom: Save PHY counters during suspend

Kai Zen (1):
      net: rtnetlink: zero ifla_vf_broadcast to avoid stack infoleak in rtnl_fill_vfinfo

Kalesh AP (1):
      bnxt_en: Check return value of bnxt_hwrm_vnic_cfg

Kuan-Ting Chen (1):
      xfrm: esp: avoid in-place decrypt on shared skb frags

Kuniyuki Iwashima (6):
      selftest: net: Add test for TCP flow failover with ECMP routes.
      af_unix: Set gc_in_progress to true in unix_gc().
      ipmr: Add __rcu to netns_ipv4.mrt.
      ipv6: Fix null-ptr-deref in fib6_mtu().
      ipmr: Call ipmr_fib_lookup() under RCU.
      tcp: Fix dst leak in tcp_v6_connect().

Lorenzo Bianconi (1):
      net: airoha: Move entries to queue head in case of DMA mapping failure in airoha_dev_xmit()

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt

Maciej W. Rozycki (1):
      MAINTAINERS: Add self for the DEC LANCE network driver

Maoyi Xie (3):
      ip6_gre: Use cached t->net in ip6erspan_changelink().
      wifi: nl80211: require CAP_NET_ADMIN over the target netns in SET_WIPHY_NETNS
      wifi: nl80211: re-check wiphy netns in nl80211_prepare_wdev_dump() continuation

Marek Szyprowski (1):
      wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task

Markus Baier (1):
      net: usb: asix: ax88772: re-add usbnet_link_change() in phylink callbacks

Matthieu Baerts (NGI0) (12):
      mptcp: sockopt: increase seq in mptcp_setsockopt_all_sf
      mptcp: pm: kernel: correctly retransmit ADD_ADDR ID 0
      mptcp: pm: ADD_ADDR rtx: allow ID 0
      mptcp: pm: ADD_ADDR rtx: fix potential data-race
      mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      mptcp: pm: ADD_ADDR rtx: free sk if last
      mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
      mptcp: pm: ADD_ADDR rtx: skip inactive subflows
      mptcp: pm: ADD_ADDR rtx: return early if no retrans
      mptcp: pm: prio: skip closed subflows
      selftests: mptcp: check output: catch cmd errors
      selftests: mptcp: pm: restrict 'unknown' check to pm_nl_ctl

Michael Bommarito (6):
      xfrm: ah: account for ESN high bits in async callbacks
      wifi: nl80211: require admin perm on SET_PMK / DEL_PMK
      wifi: mac80211: check ieee80211_rx_data_set_link return in pubsta MLO path
      Bluetooth: virtio_bt: clamp rx length before skb_put
      Bluetooth: virtio_bt: validate rx pkt_type header length
      Bluetooth: HIDP: serialise l2cap_unregister_user via hidp_session_sem

Michael Chan (2):
      bnxt_en: Delay for 5 seconds after AER DPC for all chips
      bnxt_en: Set bp->max_tpa according to what the FW supports

Michal Kosiorek (1):
      xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete

Mikhail Gavrilov (1):
      Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion

Nan Li (1):
      net/rds: handle zerocopy send cleanup before the message is queued

Nicolas Escande (1):
      wifi: ath12k: fix leak in some ath12k_wmi_xxx() functions

Pablo Neira Ayuso (8):
      netfilter: replace skb_try_make_writable() by skb_ensure_writable()
      netfilter: nft_fwd_netdev: add device and headroom validate with neigh forwarding
      netfilter: x_tables: add .check_hooks to matches and targets
      netfilter: nft_compat: run xt_check_hooks_{match,target}() from .validate
      netfilter: flowtable: ensure sufficient headroom in xmit path
      netfilter: flowtable: fix inline vlan encapsulation in xmit path
      netfilter: flowtable: fix inline pppoe encapsulation in xmit path
      netfilter: flowtable: use skb_pull_rcsum() to pop vlan/pppoe header

Paolo Abeni (3):
      mptcp: fix rx timestamp corruption on fastopen
      Merge branch 'net-mana-fix-mana_destroy_rxq-cleanup-for-partial-rxq-init'
      Merge branch 'openvswitch-fix-self-deadlock-on-release-of-tunnel-vports'

Pauli Virtanen (2):
      Bluetooth: SCO: fix sleeping under spinlock in sco_conn_ready
      Bluetooth: SCO: hold sk properly in sco_conn_ready

Pavan Chebbi (1):
      bnxt_en: Use absolute target ns from ptp_clock_request

Pavitra Jha (1):
      net: wwan: t7xx: validate port_count against message length in t7xx_port_enum_msg_handler

Pengpeng Hou (1):
      Bluetooth: RFCOMM: pull credit byte with skb_pull_data()

Qingfang Deng (1):
      ovpn: reset MAC header before passing skb up

Ralf Lici (2):
      ovpn: ensure packet delivery happens with BH disabled
      selftests: ovpn: reduce ping count in test.sh

Rameshkumar Sundaram (1):
      wifi: ath12k: initialize RSSI dBm conversion event state

Ratheesh Kannoth (10):
      octeontx2-af: npc: cn20k: Propagate MCAM key-type errors on cn20k
      octeontx2-af: npc: cn20k: Drop debugfs_create_file() error checks in init
      octeontx2-af: npc: cn20k: Propagate errors in defrag MCAM alloc rollback
      octeontx2-af: npc: cn20k: Fix target map and rule
      octeontx2-af: npc: cn20k: Clear MCAM entries by index and key width
      octeontx2-af: npc: cn20k: Fix bank value
      octeontx2-af: npc: cn20k: Fix MCAM actions read
      octeontx2-af: npc: cn20k: Initialize default-rule index outputs up front
      octeontx2-af: npc: cn20k: Tear down default MCAM rules explicitly on free
      octeontx2-af: npc: cn20k: Reject missing default-rule MCAM indices

Rio Liu (1):
      wifi: mac80211: skip ieee80211_verify_sta_ht_mcs_support check in non-strict mode

Robert Marko (1):
      net: phy: micrel: fix LAN8814 QSGMII soft reset

Ruijie Li (1):
      xfrm: provide message size for XFRM_MSG_MAPPING

Sagarika Sharma (1):
      ipv6: update route serial number on NETDEV_CHANGE

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: treat boot stage bit 12 as warning

SeungJu Cheon (2):
      Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
      Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths

Shardul Bankar (2):
      mptcp: use MPJoinSynAckHMacFailure for SynAck HMAC failure
      mptcp: use MPTCP_RST_EMPTCP for ACK HMAC validation failure

Shay Drory (4):
      net/mlx5: SD: Serialize init/cleanup
      net/mlx5: SD, Keep multi-pf debugfs entries on primary
      net/mlx5e: SD, Fix missing cleanup on probe error
      net/mlx5e: SD, Fix race condition in secondary device probe/remove

Shitalkumar Gandhi (1):
      net: rtsn: fix mdio_node leak in rtsn_mdio_alloc()

Siwei Zhang (3):
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()

Tristan Madani (3):
      wifi: b43: enforce bounds check on firmware key index in b43_rx()
      wifi: b43legacy: enforce bounds check on firmware key index in RX path
      Bluetooth: btmtk: validate WMT event SKB length before struct access

Victor Nogueira (1):
      selftests/tc-testing: Add tests that force red and sfb to dequeue from child's gso_skb

Victor Nogueria (1):
      net/sched: sch_sfb: Replace direct dequeue call with peek and qdisc_dequeue_peeked

Waiman Long (2):
      ipvs: Guard access of HK_TYPE_KTHREAD cpumask with RCU
      sched/isolation: Make HK_TYPE_KTHREAD an alias of HK_TYPE_DOMAIN

Wei Fang (1):
      net: enetc: fix VSI mailbox timeout handling and DMA lifecycle

Weiming Shi (1):
      netfilter: nft_fwd_netdev: use recursion counter in neigh egress path

Yilin Zhu (1):
      ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()

Yu-Hsiang Tseng (1):
      wifi: ath12k: use lockdep_assert_in_rcu_read_lock() for RCU assertions

 MAINTAINERS                                        |   6 +
 drivers/bluetooth/btintel_pcie.c                   |  13 +-
 drivers/bluetooth/btintel_pcie.h                   |   2 +-
 drivers/bluetooth/btmtk.c                          |  15 +-
 drivers/bluetooth/hci_ath.c                        |   3 +
 drivers/bluetooth/hci_bcsp.c                       |   3 +
 drivers/bluetooth/hci_h4.c                         |   3 +
 drivers/bluetooth/hci_h5.c                         |   3 +
 drivers/bluetooth/virtio_bt.c                      |  39 ++-
 drivers/net/dsa/mt7530.c                           |  75 +++-
 drivers/net/dsa/mt7530.h                           |   8 +
 drivers/net/ethernet/airoha/airoha_eth.c           |   6 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h               |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  16 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |  29 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |  10 +-
 drivers/net/ethernet/cortina/gemini.c              |   5 +
 drivers/net/ethernet/freescale/enetc/enetc.h       |   1 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c    |  42 ++-
 .../ethernet/marvell/octeontx2/af/cn20k/debugfs.c  |  33 +-
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c  | 382 ++++++++++++++-------
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.h  |  24 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   3 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    | 231 +++++++++++--
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |  30 +-
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c |  36 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  30 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   | 114 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h   |   2 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   3 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  10 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   3 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  40 ++-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  10 +-
 drivers/net/ethernet/microsoft/mana/shm_channel.c  |   5 -
 drivers/net/ethernet/renesas/rtsn.c                |   6 +-
 .../net/ethernet/stmicro/stmmac/dwmac-nuvoton.c    |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   7 +-
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c  |   4 +-
 drivers/net/netdevsim/netdev.c                     |   3 +-
 drivers/net/netdevsim/netdevsim.h                  |   4 +-
 drivers/net/netdevsim/psp.c                        |  65 +++-
 drivers/net/ovpn/io.c                              |   7 +
 drivers/net/phy/bcm-phy-lib.c                      |   9 +
 drivers/net/phy/bcm-phy-lib.h                      |   1 +
 drivers/net/phy/bcm7xxx.c                          |  14 +
 drivers/net/phy/broadcom.c                         |   5 +
 drivers/net/phy/micrel.c                           |  15 +-
 drivers/net/usb/asix_devices.c                     |   2 +
 drivers/net/usb/cdc_ncm.c                          |   8 +
 drivers/net/usb/r8152.c                            |   1 +
 drivers/net/veth.c                                 |   3 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |   9 +-
 drivers/net/wireless/ath/ath10k/Kconfig            |   1 +
 drivers/net/wireless/ath/ath12k/core.c             |  77 +++--
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   5 +-
 drivers/net/wireless/ath/ath12k/mac.c              |   2 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c              | 105 +++++-
 drivers/net/wireless/ath/ath5k/base.c              |   3 +-
 drivers/net/wireless/broadcom/b43/xmit.c           |   3 +-
 drivers/net/wireless/broadcom/b43legacy/xmit.c     |   3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   6 +-
 drivers/net/wireless/marvell/libertas/if_usb.c     |   6 +-
 drivers/net/wireless/rsi/rsi_common.h              |   5 +-
 drivers/net/wireless/st/cw1200/pm.c                |   2 -
 drivers/net/wwan/t7xx/t7xx_modem_ops.c             |  20 +-
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c         |  18 +-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h            |   2 +-
 include/linux/netfilter/x_tables.h                 |   8 +
 include/linux/sched/isolation.h                    |   6 +-
 include/net/bluetooth/hci_core.h                   |   2 +-
 include/net/dropreason-core.h                      |   6 +
 include/net/ip_vs.h                                |  31 +-
 include/net/ipv6.h                                 |   3 +
 include/net/mana/shm_channel.h                     |   6 +
 include/net/netfilter/nf_dup_netdev.h              |  13 +
 include/net/netfilter/nf_flow_table.h              |   4 +-
 include/net/netns/ipv4.h                           |   2 +-
 net/bluetooth/bnep/core.c                          |  13 +-
 net/bluetooth/hci_conn.c                           | 124 +++++--
 net/bluetooth/hci_event.c                          |  31 +-
 net/bluetooth/hidp/core.c                          |  27 +-
 net/bluetooth/iso.c                                |  56 +--
 net/bluetooth/l2cap_core.c                         |  14 +-
 net/bluetooth/l2cap_sock.c                         |   9 +
 net/bluetooth/rfcomm/core.c                        |   7 +-
 net/bluetooth/sco.c                                |  62 ++--
 net/core/dev.c                                     |   2 +-
 net/core/netpoll.c                                 |  23 +-
 net/core/rtnetlink.c                               |   1 +
 net/ipv4/ah4.c                                     |  14 +-
 net/ipv4/esp4.c                                    |   3 +-
 net/ipv4/igmp.c                                    |  58 ++--
 net/ipv4/inetpeer.c                                |   3 +-
 net/ipv4/ip_output.c                               |   2 +
 net/ipv4/ipmr.c                                    |  10 +-
 net/ipv4/netfilter/nf_socket_ipv4.c                |   3 +
 net/ipv4/tcp_ipv4.c                                |  14 +-
 net/ipv4/tcp_minisocks.c                           |   2 +-
 net/ipv6/Kconfig                                   |   4 +-
 net/ipv6/ah6.c                                     |  14 +-
 net/ipv6/esp6.c                                    |   3 +-
 net/ipv6/exthdrs_core.c                            |   7 +
 net/ipv6/ip6_gre.c                                 |   5 +-
 net/ipv6/ip6_input.c                               |   5 +
 net/ipv6/ip6_output.c                              |   5 +
 net/ipv6/ip6_tunnel.c                              |   4 +
 net/ipv6/netfilter/nf_socket_ipv6.c                |   5 +-
 net/ipv6/route.c                                   |   5 +
 net/ipv6/tcp_ipv6.c                                |  17 +-
 net/ipv6/xfrm6_protocol.c                          |   4 +-
 net/mac80211/mlme.c                                |  18 +-
 net/mac80211/rx.c                                  |   6 +-
 net/mac80211/tests/chan-mode.c                     |   1 +
 net/mac80211/util.c                                |   4 +-
 net/mctp/test/route-test.c                         |   2 +-
 net/mctp/test/utils.c                              |   2 +-
 net/mptcp/fastopen.c                               |   4 +-
 net/mptcp/pm.c                                     |  62 ++--
 net/mptcp/pm_kernel.c                              |  13 +-
 net/mptcp/sockopt.c                                |   4 +
 net/mptcp/subflow.c                                |   4 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |  74 ++--
 net/netfilter/ipvs/ip_vs_core.c                    |   2 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     | 164 ++++++---
 net/netfilter/ipvs/ip_vs_est.c                     |  83 +++--
 net/netfilter/nf_dup_netdev.c                      |  16 -
 net/netfilter/nf_flow_table_core.c                 |   1 +
 net/netfilter/nf_flow_table_ip.c                   | 151 ++++++--
 net/netfilter/nf_flow_table_path.c                 |   7 +-
 net/netfilter/nf_tables_api.c                      |  35 +-
 net/netfilter/nf_tables_core.c                     |   2 +-
 net/netfilter/nft_compat.c                         |  45 ++-
 net/netfilter/nft_exthdr.c                         |   2 +-
 net/netfilter/nft_fwd_netdev.c                     |  29 +-
 net/netfilter/nft_osf.c                            |   2 +-
 net/netfilter/nft_tproxy.c                         |   8 +-
 net/netfilter/x_tables.c                           |  79 ++++-
 net/netfilter/xt_CT.c                              |   8 +-
 net/netfilter/xt_TCPMSS.c                          |  33 +-
 net/netfilter/xt_TPROXY.c                          |  11 +-
 net/netfilter/xt_addrtype.c                        |  25 +-
 net/netfilter/xt_devgroup.c                        |  18 +-
 net/netfilter/xt_ecn.c                             |   4 +
 net/netfilter/xt_hashlimit.c                       |   4 +-
 net/netfilter/xt_osf.c                             |   3 +
 net/netfilter/xt_physdev.c                         |  24 +-
 net/netfilter/xt_policy.c                          |  24 +-
 net/netfilter/xt_set.c                             |  39 ++-
 net/netfilter/xt_tcpmss.c                          |   4 +
 net/openvswitch/vport-geneve.c                     |   5 +-
 net/openvswitch/vport-gre.c                        |   5 +-
 net/openvswitch/vport-netdev.c                     |  64 ++--
 net/openvswitch/vport-netdev.h                     |   2 +-
 net/openvswitch/vport-vxlan.c                      |   5 +-
 net/psp/psp_main.c                                 |  42 ++-
 net/rds/message.c                                  |  20 +-
 net/sched/sch_cake.c                               | 153 +++++----
 net/sched/sch_fq_codel.c                           |  39 ++-
 net/sched/sch_pie.c                                |  14 +-
 net/sched/sch_red.c                                |   2 +-
 net/sched/sch_sfb.c                                |   2 +-
 net/sched/sch_sfq.c                                |  48 +--
 net/smc/af_smc.c                                   |   8 +-
 net/tls/tls_sw.c                                   |   6 +-
 net/unix/af_unix.c                                 |   3 +
 net/unix/garbage.c                                 |   6 +-
 net/vmw_vsock/virtio_transport_common.c            |   4 +-
 net/wireless/nl80211.c                             |  27 ++
 net/wireless/pmsr.c                                |   2 +-
 net/xdp/xsk.c                                      | 115 ++++---
 net/xdp/xsk_buff_pool.c                            |   3 +
 net/xfrm/xfrm_output.c                             |  20 +-
 net/xfrm/xfrm_state.c                              |  12 +-
 net/xfrm/xfrm_user.c                               |   1 +
 tools/testing/selftests/drivers/net/hw/Makefile    |   1 +
 tools/testing/selftests/drivers/net/hw/config      |   5 +
 .../selftests/drivers/net/hw/ipsec_vxlan.py        | 204 +++++++++++
 tools/testing/selftests/drivers/net/lib/py/load.py |   5 +-
 tools/testing/selftests/net/Makefile               |   1 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  16 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  20 +-
 .../selftests/net/openvswitch/openvswitch.sh       |  37 ++
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |  19 +-
 tools/testing/selftests/net/ovpn/test.sh           |   4 +-
 tools/testing/selftests/net/tcp_ecmp_failover.sh   | 216 ++++++++++++
 tools/testing/selftests/net/tls.c                  |  43 +++
 .../tc-testing/tc-tests/infra/qdiscs.json          | 148 ++++++++
 189 files changed, 3485 insertions(+), 1160 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py
 create mode 100755 tools/testing/selftests/net/tcp_ecmp_failover.sh

