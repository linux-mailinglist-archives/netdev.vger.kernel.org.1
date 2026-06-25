Return-Path: <netdev+bounces-302059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3YzAELdpPWpd2wgAu9opvQ
	(envelope-from <netdev+bounces-302059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:47:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A58516C7FE4
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:47:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HFMEO2do;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302059-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302059-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDC8D3054EB4
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676293ED122;
	Thu, 25 Jun 2026 17:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437C42F7F04;
	Thu, 25 Jun 2026 17:45:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409514; cv=none; b=T6b11xZLl+ChR/iuW44rlT3/pbFYdOuxjEmIORGma7w02U7nzSy0D1BUkSRt9JUcrmbYnlsQ8guKWM5qE84IarGvFLtXFMcIFexu2yivjYMr7PoAClndSZwWttPLM7Lv4EgztgWU/IfM9GMMtoeeOOG069SJyN+fXzw0yH7jpaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409514; c=relaxed/simple;
	bh=bIFrMN7HbNyANSQ6sMOj0JVB3/8P3DsimkiSzYvIUcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NVDV8jVxoSehITluRHYOpkEgX8PMStztV80jkoARVqLODXPNOEno+ClYe5xoWJuLLbLaA62abxnuWqB1ZYa/DfHnZVRpGO4GV0G+QrRv/ViqQ4RNTch1go1XyoCYfiI8AovxWEnLK1d7tLLCwkc94Bt9zrn38AIcurakj35m4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFMEO2do; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15A61F000E9;
	Thu, 25 Jun 2026 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782409511;
	bh=apv7aBo3JOIBuQuawDbGXJIOxWmcHv9SMP/VZrOIsT8=;
	h=From:To:Cc:Subject:Date;
	b=HFMEO2domLI4jeLjDW3QE23eOz8BVrc4jEWAAfhwdGq2CMgnjfhIT5yv/9/Wmn4Vm
	 OQCBW56C42QZei8BTBV1XibzOGDZXHy/5XTM8itwdyfoLH+imKvlFtlLnj38YhbLDB
	 XEyvYNMVhJr51gewrQrMoEAHsMvhNIVRf58hDs43HMAgxYLO9cCB8Wrj5P+Ab09pn4
	 8+Tda+RSexp6fDLwj77NAKJzgd2vCgRfSgoZcgzuZ/1KNQj8+xnXHlohTMk9i2G61E
	 j9Qu6N4dx7KYGICTZJNmgfKLInxC5z1vvang/tTQrP8HfMIDDNI8tUAE1SrBlzN5y8
	 DwS8TP9EMGYCw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.2-rc1
Date: Thu, 25 Jun 2026 10:45:11 -0700
Message-ID: <20260625174511.745883-1-kuba@kernel.org>
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
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302059-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,open-mesh.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A58516C7FE4

Hi Linus!

The following changes since commit b85966adbf5de0668a815c6e3527f87e0c387fb4:

  Merge tag 'net-next-7.2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2026-06-17 08:17:00 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.2-rc1

for you to fetch changes up to fe9f4ee6c61a1410afd73bf011de5ae618004796:

  Merge branch 'net-avoid-nested-up-notifier-events' (2026-06-25 10:18:41 -0700)

----------------------------------------------------------------
Including fixes from netfilter and IPsec.

Current release - regressions:

 - net: do not acquire dev->tx_global_lock in netdev_watchdog_up()

 - net: ethtool: keep rtnl_lock for ops using ethtool_op_get_link()

 - net: fix deadlock in nested UP notifier events

Current release - new code bugs:

 - eth: cn20k: fix subbank free list indexing for search order

 - eth: airoha: fix BQL underflow in shared QDMA TX ring

Previous releases - regressions:

 - netfilter:
   - flowtable: fix offloaded ct timeout never being extended
   - nf_conncount: prevent connlimit drops for early confirmed ct

Previous releases - always broken:

 - require CAP_NET_ADMIN in the originating netns when modifying
   cross-netns devices

 - report NAPI thread PID in the caller's pid namespace

 - mac802154: fix dirty frag in in-place crypto for IOT radios

 - sctp: hold socket lock when dumping endpoints in sctp_diag,
   avoid an overflow

 - eth: gve: fix header buffer corruption with header-split and HW-GRO

 - af_key: initialize alg_key_len for IPComp states, prevent OOB read

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Abdun Nihaal (1):
      bnx2x: fix potential memory leak in bnx2x_alloc_mem_bp()

Adrian Bente (1):
      netfilter: flowtable: fix offloaded ct timeout never being extended

Aleksandr Nogikh (1):
      ieee802154: fix kernel-infoleak in dgram_recvmsg()

Aleksandrova Alyona (1):
      net: dsa: sja1105: round up PTP perout pin duration

Ankit Garg (1):
      gve: fix header buffer corruption with header-split and HW-GRO

Arnd Bergmann (1):
      eth: mlx5: fix macsec dependency

Breno Leitao (1):
      netconsole: don't drop the last byte of a full-sized message

Christian Marangi (1):
      net: ethernet: mtk_eth_soc: fix supported_interface set after phylink_create

Cosmin Ratiu (2):
      devlink: Fix parent ref leak in devl_rate_node_create()
      devlink: Fix parent ref leak on tc-bw failure

Daniel Golle (2):
      net: dsa: mxl862xx: avoid unaligned 16-bit access in api_wrap
      net: dsa: mxl862xx: fix use-after-free of DSA ports in crc_err_work

Daniel Zahka (1):
      eth: fbnic: take netif_addr_lock_bh() around rx mode address programming

David Howells (10):
      rxrpc: Fix leak of connection from OOB challenge
      rxrpc: Fix double unlock in rxrpc_recvmsg()
      afs: Fix further netns teardown to cancel the preallocation charger
      afs: Fix uncancelled rxrpc OOB message handler
      rxrpc: Fix the reception of a reply packet before data transmission
      rxrpc: Fix oob challenge leak in cleanup after notification failure
      rxrpc: Fix potential infinite loop in rxrpc_recvmsg()
      rxrpc: Fix socket notification race
      rxrpc: Fix leak of released call in recvmsg(MSG_PEEK)
      rxrpc: Fix rxrpc_rotate_tx_rotate() to check there's something to rotate

David Yang (1):
      net: dsa: realtek: fix memory leak in rtl8366rb_setup_led()

Dawei Feng (1):
      net: ena: clean up XDP TX queues when regular TX setup fails

Dawid Osuchowski (1):
      ice: fix FDIR CTRL VSI resource leak in ice_reset_all_vfs()

Dima Ruinskiy (1):
      e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake

Dong Chenchen (1):
      xfrm: Fix dev use-after-free in xfrm async resumption

Doruk Tan Ozturk (2):
      tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done
      mac802154: llsec: add skb_cow_data() before in-place crypto

Eric Dumazet (7):
      xfrm: annotate data-races around xfrm_policy_count[] and xfrm_policy_default[]
      xfrm: validate selector family and prefixlen during match
      net: do not acquire dev->tx_global_lock in netdev_watchdog_up()
      veth: fix NAPI leak in XDP enable error path
      net: udp_tunnel: prevent double queueing in udp_tunnel_nic_device_sync
      tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
      tipc: avoid busy looping in tipc_exit_net()

Erni Sri Satya Vennela (1):
      net: mana: Fall back to standard MTU when PF reports adapter_mtu of 0

Fan Wu (1):
      hdlc_ppp: sync per-proto timers before freeing hdlc state

Fernando Fernandez Mancera (7):
      netfilter: nf_conncount: prevent connlimit drops for early confirmed ct
      ipv6: fix error handling in disable_ipv6 sysctl
      ipv6: fix error handling in ignore_routes_with_linkdown sysctl
      ipv6: fix error handling in forwarding sysctl
      ipv6: fix error handling in disable_policy sysctl
      ipv6: fix state corruption during proxy_ndp sysctl restart
      ipv6: fix missing notification for ignore_routes_with_linkdown

Florian Westphal (9):
      netfilter: nft_payload: reject offsets exceeding 65535 bytes
      netfilter: nft_meta_bridge: add validate callback for get operations
      netfilter: nft_flow_offload: zero device address for non-ether case
      netfilter: nf_reject: skip iphdr options when looking for icmp header
      netfilter: nft_meta_bridge: fix NFT_META_BRI_IIFPVID stack leak
      netfilter: nft_compat: ebtables emulation must reject non-bridge targets
      selftests: nft_queue.sh: add a bridge queue test
      netfilter: conntrack: add deprecation warnings for irc and pptp trackers
      netfilter: nft_ct: expectation timeouts are passed in milliseconds

Geetha sowjanya (2):
      octeontx2-af: mcs: Fix unsupported secy stats read
      octeontx2-pf: mcs: Fix mcs resources free on PF shutdown

Greg Thelen (1):
      tools: ynl: build archives with $(AR)

HanQuan (1):
      net/tcp-ao: fix use-after-free of key in del_async path

Haoxiang Li (4):
      net: ixp4xx_hss: fix duplicate HDLC netdev allocation
      net: wwan: t7xx: destroy DMA pool on CLDMA late init failure
      octeontx2-af: Free BPID bitmap on setup failure
      net: sparx5: unregister blocking notifier on init failure

Haoze Xie (1):
      netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst

Herbert Xu (1):
      xfrm: Fix xfrm state cache insertion race

Ido Schimmel (1):
      selftests: vlan_bridge_binding: Fix flaky operational state check

Ilya Maximets (1):
      net: dst_metadata: fix false-positive memcpy overflow in tun_dst_unclone

Inochi Amaoto (2):
      net: stmmac: dwmac-spacemit: Fix wrong phy interface definition
      net: stmmac: dwmac-spacemit: Fix wrong irq definition

Ioana Ciornei (2):
      dpaa2-switch: fix VLAN upper check not rejecting bridge join
      dpaa2-switch: do not accept VLAN uppers while bridged

Ivan Abramov (3):
      ieee802154: Restore initial state on failed device_rename() in cfg802154_switch_netns()
      ieee802154: Avoid calling WARN_ON() on -ENOMEM in cfg802154_switch_netns()
      ieee802154: Remove WARN_ON() in cfg802154_pernet_exit()

Jakub Kicinski (27):
      Merge branch 'net-require-cap_net_admin-in-the-device-netns-for-tunnel-changelink'
      net: psample: fix info leak in PSAMPLE_ATTR_DATA
      Merge branch 'net-sched-act_ct-preserve-tc_skb_cb-across-defragmentation'
      Merge branch 'devlink-fix-a-couple-parent-ref-leaks'
      Merge tag 'batadv-net-pullrequest-20260619' of https://git.open-mesh.org/batadv
      Merge tag 'ieee802154-for-net-next-2026-06-20' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next
      Merge branch 'ipv4-ipv6-account-for-fraggap-on-paged-allocation-paths'
      Merge tag 'nf-26-06-21' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      eth: bnxt: improve the timing of stats
      Merge branch 'selftests-xsk-stabilize-timeout-test-behavior'
      Merge tag 'ipsec-2026-06-22' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge branch 'drop-skb-metadata-before-lwt-encapsulation'
      Merge branch 'ipv6-fix-error-handling-in-disable_ipv6-sysctl'
      eth: fbnic: fix ordering of heartbeat vs ownership
      Merge branch 'airoha-fixes-for-sched-htb-offload-support'
      Merge branch 'net-stmmac-dwmac-spacemit-fix-wrong-macro-definition'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'nf-26-06-23' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'tipc-syzbot-related-fixes'
      Merge branch 'net-hns3-fix-configuration-deadlocks-and-refactor-link-setup'
      Merge branch 'rxrpc-miscellaneous-fixes'
      net: ethtool: keep rtnl_lock for ops using ethtool_op_get_link()
      net: turn the rx_mode work into a generic netdev_work facility
      net: add the driver-facing netdev_work scheduling API
      vlan: defer real device state propagation to netdev_work
      selftests: bonding: add a test for VLAN propagation over a bonded real device
      Merge branch 'net-avoid-nested-up-notifier-events'

Jakub Sitnicki (2):
      net: lwtunnel: Drop skb metadata before LWT encapsulation
      selftests/bpf: Add LWT encap tests for skb metadata

Jamal Hadi Salim (1):
      net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle

Jan Klos (1):
      net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G bit

Jiayuan Chen (1):
      ipv6: ioam: fix type confusion of dst_entry

Jozsef Kadlecsik (4):
      netfilter: ipset: Don't use test_bit() in lockless RCU readers in hash types
      netfilter: ipset: Don't use test_bit() in lockless RCU readers in bitmap types
      netfilter: ipset: fix order of kfree_rcu() and rcu_assign_pointer()
      netfilter: ipset: make sure gc is properly stopped

Junrui Luo (1):
      octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own PF

Krzysztof Kozlowski (1):
      net: ethernet: qualcomm: ppe: Demote from supported and fix maintainer addresses

Kuniyuki Iwashima (1):
      ipv4: fib: Don't ignore error route in local/main tables.

Li RongQing (1):
      net/mlx5: Remove broken and unused mlx5_query_mtppse()

Lorenzo Bianconi (5):
      netfilter: flowtable: fix and simplify IP6IP6 tunnel handling
      netfilter: flowtable: Validate iph->ihl in nf_flow_ip4_tunnel_proto()
      net: airoha: Fix off-by-one in airoha_tc_remove_htb_queue()
      net: airoha: fix netif_set_real_num_tx_queues for sparse QoS channels
      net: airoha: fix BQL underflow in shared QDMA TX ring

Lukasz Czapnik (1):
      ice: fix AQ error code comparison in ice_set_pauseparam()

Lukasz Raczylo (1):
      net: macb: add TX stall timeout callback to recover from lost TSTART write

Maoyi Xie (11):
      net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
      net: ipip: require CAP_NET_ADMIN in the device netns for changelink
      net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
      net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
      net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
      net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
      xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for changelink
      netdev-genl: report NAPI thread PID in the caller's pid namespace
      net: thunderbolt: Fix frags[] overflow by bounding frame_count
      net: sit: require CAP_NET_ADMIN in the device netns for changelink
      net: usb: kalmia: bound RX frame length in kalmia_rx_fixup()

Marcin Szycik (1):
      ice: call netif_keep_dst() once when entering switchdev mode

Mathias Krause (1):
      netfilter: nf_nat: avoid invalid nat_net pointer use on failed nf_nat_init()

Meghana Malladi (1):
      net: ti: icssg: Fix XSK zero copy TX during application wakeup

Michael Bommarito (4):
      net: rds: check cmsg_len before reading rds_rdma_args in size pass
      ieee802154: admin-gate legacy LLSEC dump operations
      ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation
      net/sched: act_ct: fix nf_connlabels leak on two error paths

Mohamed Khalfella (1):
      i40e: Fix i40e_debug() to use struct i40e_hw argument

Nicolai Buchwitz (1):
      net: usb: lan78xx: restore VLAN and hash filters after link up

Nirmoy Das (1):
      selftests: tls: size splice_short pipe by page size

Pablo Neira Ayuso (5):
      netfilter: nf_conntrack_expect: use conntrack GC to reap expectations
      netfilter: ctnetlink: do not allow to reset helper on existing conntrack
      netfilter: nf_conntrack_expect: store master_tuple in expectation
      netfilter: nf_conntrack_expect: run expectation eviction with no helper
      netfilter: nf_conntrack_helper: cap maximum number of expectation at helper registration

Paul Greenwalt (1):
      ice: fix ice_init_link() error return preventing probe

Pengpeng Hou (1):
      net: ehea: unwind probe_port sysfs file on failure

Philippe Schenker (1):
      net: ethernet: ti: icssg: guard PA stat lookups

Randy Dunlap (1):
      netfilter: x_tables.h: fix all kernel-doc warnings

Ratheesh Kannoth (5):
      octeontx2-pf: Fix leak of SQ timestamp buffer on teardown
      octeontx2-af: npc: Log successful MCAM drop-on-non-hit install at debug level
      octeontx2-af: npc: cn20k: fix NPC defrag
      octeontx2-af: npc: cn20k: Fix subbank free list indexing for search order
      octeontx2-af: fix CGX debugfs RVU AF PCI reference leaks

Rob Herring (Arm) (1):
      dt-bindings: net: renesas,ether: Drop example "ethernet-phy-ieee802.3-c22" fallback

Robert Marko (1):
      net: pse-pd: set user byte command SUB2 field

Robertus Diawan Chris (1):
      mac802154: Prevent overwrite return code in mac802154_perform_association()

Rongguang Wei (1):
      net: wangxun: don't advertise IFF_SUPP_NOFCS

Rosen Penev (1):
      net: emac: Fix NULL pointer dereference in emac_probe

Ross Porter (1):
      selftests: net: fix file owner for broadcast_ether_dst test

Runyu Xiao (3):
      netfilter: nft_synproxy: stop bypassing the priv->info snapshot
      net: au1000: move free_irq out of the close-time spinlocked section
      openvswitch: conntrack: annotate ct limit hlist traversal

Ruoyu Wang (3):
      net: pch_gbe: handle TX skb allocation failure
      net: marvell: prestera: initialize err in prestera_port_sfp_bind
      net: sungem: fix probe error cleanup

Sabrina Dubroca (1):
      espintcp: use sk_msg_free_partial to fix partial send

Sanman Pradhan (1):
      xfrm: use compat translator only for u64 alignment mismatch

Shitalkumar Gandhi (3):
      ieee802154: ca8210: fix cas_ctl leak on spi_async failure
      ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit
      net: ethernet: sunplus: spl2sw: fix phy_node refcount leak in remove

Shradha Gupta (1):
      net: mana: Optimize irq affinity for low vcpu configs

Shuaisong Yang (4):
      net: hns3: unify copper port ksettings configuration path
      net: hns3: refactor MAC autoneg and speed configuration
      net: hns3: fix permanent link down deadlock after reset
      net: hns3: differentiate autoneg default values between copper and fiber

Subbaraya Sundeep (2):
      octeontx2-pf: Clear stats of all resources when freeing resources
      octeontx2-af: Validate NIX maximum LFs correctly

Sven Eckelmann (15):
      batman-adv: gw: don't deselect gateway with active hardif
      batman-adv: ensure bcast is writable before modifying TTL
      batman-adv: fix (m|b)cast csum after decrementing TTL
      batman-adv: frag: ensure fragment is writable before modifying TTL
      batman-adv: frag: avoid underflow of TTL
      batman-adv: v: prevent OGM aggregation on disabled hardif
      batman-adv: tp_meter: restrict number of unacked list entries
      batman-adv: tp_meter: annotate last_recv_time access with READ/WRITE_ONCE
      batman-adv: tp_meter: prevent parallel modifications of last_recv
      batman-adv: tp_meter: handle overlapping packets
      batman-adv: tt: don't merge change entries with different VIDs
      batman-adv: tt: track roam count per VID
      batman-adv: dat: prevent false sharing between VLANs
      batman-adv: tvlv: enforce 2-byte alignment
      batman-adv: tvlv: avoid race of cifsnotfound handler state

Thorsten Leemhuis (1):
      tools/ynl: add missing uapi header deps in Makefile.deps

Tushar Vyavahare (3):
      selftests/xsk: make poll timeout mode explicit
      selftests/xsk: fix timeout thread harness sequencing
      selftests/xsk: restore shared_umem after POLL_TXQ_FULL

Wayen Yan (4):
      net: airoha: fix foe_check_time allocation size
      net: ethernet: mtk_ppe: Fix rhashtable leak in mtk_ppe_init error paths
      net: airoha: Fix skb->priority underflow in airoha_dev_select_queue()
      net: airoha: Fix TX scheduler queue mask loop upper bound

Wei Fang (1):
      net: enetc: fix potential divide-by-zero when num_vsi is zero

Weiming Shi (2):
      tipc: fix use-after-free of the discoverer in tipc_disc_rcv()
      ipv6: ndisc: fix NULL deref in accept_untracked_na()

Wells Lu (1):
      MAINTAINERS: Orphan SUNPLUS ETHERNET DRIVER

Wentao Guan (1):
      net: llc: make empty have static storage duration

Willem de Bruijn (1):
      selftests: drv-net: so_txtime: relax variance bounds

Wongi Lee (2):
      ipv4: account for fraggap on the paged allocation path
      ipv6: account for fraggap on the paged allocation path

Wyatt Feng (3):
      net: ipv4: bound TCP reordering sysctl writes and MTU probe sizes
      netfilter: xt_cluster: reject template conntracks in hash match
      rxrpc: Fix ACKALL packet handling

Xiang Mei (5):
      virtio-net: fix len check in receive_big()
      ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
      net, bpf: check master for NULL in xdp_master_redirect()
      geneve: gate GRO hint in geneve_gro_complete() on gs->gro_hint
      geneve: validate inner network offset in geneve_gro_complete()

Xin Long (2):
      sctp: hold socket lock when dumping endpoints in sctp_diag
      sctp: fix err_chunk memory leaks in INIT handling

Xingquan Liu (2):
      net/sched: dualpi2: fix GSO backlog accounting
      selftests/tc-testing: Add DualPI2 GSO backlog accounting test

Yi Chen (1):
      selftests: netfilter: conntrack_sctp_collision.sh: Introduce SCTP INIT collision test

Yun Zhou (2):
      flow_dissector: check device type before reading ETH_ADDRS
      net: mvneta: re-enable percpu interrupt on resume

ZhaoJinming (2):
      ice: dpll: set pointers to NULL after kfree in ice_dpll_deinit_info
      ice: dpll: fix memory leak in ice_dpll_init_info error paths

Zihan Xi (2):
      net/sched: act_ct: preserve tc_skb_cb across defragmentation
      selftests/tc-testing: act_ct: add TDC test for skb cb preservation across defrag

Zijing Yin (1):
      net: af_key: initialize alg_key_len for IPComp states

Ziran Zhang (1):
      rocker: Fix memory leak in ofdpa_port_fdb()

 .mailmap                                           |   3 +-
 .../bindings/clock/qcom,ipq9574-cmn-pll.yaml       |   2 +-
 .../bindings/clock/qcom,qca8k-nsscc.yaml           |   2 +-
 .../devicetree/bindings/net/qcom,ipq9574-ppe.yaml  |   2 +-
 .../devicetree/bindings/net/renesas,ether.yaml     |   3 +-
 Documentation/networking/netdevices.rst            |   2 +
 MAINTAINERS                                        |   7 +-
 drivers/net/dsa/mxl862xx/mxl862xx-host.c           |  18 +-
 drivers/net/dsa/realtek/rtl8366rb-leds.c           |   8 +-
 drivers/net/dsa/sja1105/sja1105_ptp.c              |   2 +-
 drivers/net/ethernet/airoha/airoha_eth.c           | 201 ++++++++++++---------
 drivers/net/ethernet/airoha/airoha_eth.h           |   3 +-
 drivers/net/ethernet/airoha/airoha_ppe.c           |   3 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  23 ++-
 drivers/net/ethernet/amd/au1000_eth.c              |   3 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  48 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   5 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   1 +
 drivers/net/ethernet/cadence/macb_main.c           |   8 +
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |  10 +-
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c   |   3 +
 drivers/net/ethernet/google/gve/gve_ethtool.c      |   3 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |  28 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  31 ++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 108 ++++++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   1 +
 drivers/net/ethernet/ibm/ehea/ehea_main.c          |   2 +
 drivers/net/ethernet/ibm/emac/core.c               |  13 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |   3 +
 drivers/net/ethernet/intel/e1000e/netdev.c         |  15 +-
 drivers/net/ethernet/intel/i40e/i40e_debug.h       |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c        |   1 -
 drivers/net/ethernet/intel/ice/ice_dpll.c          |  20 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  12 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  16 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |   2 +-
 drivers/net/ethernet/marvell/mvneta.c              |   3 +
 .../net/ethernet/marvell/octeontx2/af/cn20k/npc.c  |  60 ++++--
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c    |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c  |   9 +
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |  59 +++---
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |  27 ++-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  11 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  |  10 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   1 +
 .../net/ethernet/marvell/prestera/prestera_main.c  |   2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  10 +-
 drivers/net/ethernet/mediatek/mtk_ppe.c            |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   3 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |   4 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   1 -
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  19 --
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |   3 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |   9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   7 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |   4 +
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c        |   2 +
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   |   4 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |  78 ++++++--
 drivers/net/ethernet/microsoft/mana/mana_bpf.c     |   3 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  16 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   3 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |  38 +++-
 drivers/net/ethernet/rocker/rocker_ofdpa.c         |   3 +
 .../net/ethernet/stmicro/stmmac/dwmac-spacemit.c   |  13 +-
 drivers/net/ethernet/sun/sungem.c                  |  13 +-
 drivers/net/ethernet/sunplus/spl2sw_phy.c          |   6 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c       |  72 ++++----
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |   1 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   1 -
 drivers/net/geneve.c                               |  18 +-
 drivers/net/ieee802154/ca8210.c                    |   9 +-
 drivers/net/netconsole.c                           |  12 +-
 drivers/net/phy/realtek/realtek_main.c             |   3 +-
 drivers/net/pse-pd/pd692x0.c                       |   2 +-
 drivers/net/thunderbolt/main.c                     |   8 +-
 drivers/net/usb/kalmia.c                           |   8 +
 drivers/net/usb/lan78xx.c                          |  37 +++-
 drivers/net/veth.c                                 |   2 +
 drivers/net/virtio_net.c                           |   9 +-
 drivers/net/wan/hdlc_ppp.c                         |  15 +-
 drivers/net/wan/ixp4xx_hss.c                       |   4 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c             |   3 +
 fs/afs/cm_security.c                               |   3 +-
 fs/afs/rxrpc.c                                     |  10 +-
 include/linux/ethtool.h                            |   2 +
 include/linux/netdevice.h                          |  21 ++-
 include/linux/netfilter/x_tables.h                 |  29 ++-
 include/net/dst_metadata.h                         |   7 +-
 include/net/ip_fib.h                               |   7 +-
 include/net/netfilter/nf_conntrack_expect.h        |  17 +-
 include/net/netfilter/nf_conntrack_helper.h        |   4 +
 include/net/netfilter/nf_queue.h                   |   1 +
 include/net/netfilter/nft_meta.h                   |   2 +
 include/net/rtnetlink.h                            |   2 +
 include/net/sctp/sctp.h                            |   3 +-
 include/net/xfrm.h                                 |  15 +-
 include/uapi/linux/netfilter/nf_conntrack_common.h |   1 +
 net/8021q/vlan.c                                   |  76 +-------
 net/8021q/vlan.h                                   |  11 ++
 net/8021q/vlan_dev.c                               |  60 ++++++
 net/batman-adv/bat_iv_ogm.c                        |  11 +-
 net/batman-adv/bat_v.c                             |   1 +
 net/batman-adv/bat_v_ogm.c                         |  23 ++-
 net/batman-adv/distributed-arp-table.c             |  12 +-
 net/batman-adv/fragmentation.c                     |  22 ++-
 net/batman-adv/fragmentation.h                     |   3 +-
 net/batman-adv/hard-interface.c                    |  28 +--
 net/batman-adv/routing.c                           |  73 +++++++-
 net/batman-adv/tp_meter.c                          |  74 +++++---
 net/batman-adv/translation-table.c                 |  12 +-
 net/batman-adv/tvlv.c                              |  69 ++++++-
 net/batman-adv/types.h                             |  21 ++-
 net/bridge/netfilter/nft_meta_bridge.c             |  23 ++-
 net/core/Makefile                                  |   2 +-
 net/core/dev.c                                     |   2 +
 net/core/dev.h                                     |  11 +-
 net/core/dev_addr_lists.c                          |  77 +-------
 net/core/filter.c                                  |   2 +-
 net/core/flow_dissector.c                          |  12 +-
 net/core/lwtunnel.c                                |   6 +
 net/core/netdev-genl.c                             |   4 +-
 net/core/netdev_work.c                             | 162 +++++++++++++++++
 net/core/rtnetlink.c                               |   8 +
 net/devlink/rate.c                                 |  25 +--
 net/ethtool/common.h                               |   4 +
 net/ieee802154/core.c                              |  49 ++---
 net/ieee802154/header_ops.c                        |   9 +-
 net/ieee802154/ieee802154.h                        |  17 ++
 net/ieee802154/netlink.c                           |  36 ++--
 net/ipv4/ip_gre.c                                  |   6 +
 net/ipv4/ip_output.c                               |   7 +-
 net/ipv4/ip_vti.c                                  |   3 +
 net/ipv4/ipip.c                                    |   3 +
 net/ipv4/netfilter/nf_reject_ipv4.c                |   2 +-
 net/ipv4/sysctl_net_ipv4.c                         |  10 +-
 net/ipv4/tcp_ao.c                                  |   4 +
 net/ipv4/tcp_output.c                              |   4 +-
 net/ipv4/udp_tunnel_nic.c                          |   2 +-
 net/ipv4/xfrm4_input.c                             |   2 -
 net/ipv6/addrconf.c                                |  42 +++--
 net/ipv6/ioam6_iptunnel.c                          |   8 +-
 net/ipv6/ip6_gre.c                                 |   6 +
 net/ipv6/ip6_output.c                              |   9 +-
 net/ipv6/ip6_tunnel.c                              |  10 +
 net/ipv6/ip6_vti.c                                 |   3 +
 net/ipv6/ndisc.c                                   |   8 +-
 net/ipv6/route.c                                   |   3 +
 net/ipv6/sit.c                                     |   3 +
 net/ipv6/xfrm6_input.c                             |   2 -
 net/key/af_key.c                                   |   1 +
 net/llc/sysctl_net_llc.c                           |   2 +-
 net/mac802154/llsec.c                              |  14 ++
 net/mac802154/scan.c                               |   1 +
 net/netfilter/Kconfig                              |  11 +-
 net/netfilter/ipset/ip_set_bitmap_gen.h            |   4 +-
 net/netfilter/ipset/ip_set_bitmap_ip.c             |   2 +-
 net/netfilter/ipset/ip_set_bitmap_ipmac.c          |   2 +-
 net/netfilter/ipset/ip_set_bitmap_port.c           |   2 +-
 net/netfilter/ipset/ip_set_core.c                  |   4 +-
 net/netfilter/ipset/ip_set_hash_gen.h              |  12 +-
 net/netfilter/nf_conncount.c                       |  11 +-
 net/netfilter/nf_conntrack_broadcast.c             |   1 +
 net/netfilter/nf_conntrack_core.c                  |  33 +++-
 net/netfilter/nf_conntrack_expect.c                | 155 ++++++++--------
 net/netfilter/nf_conntrack_h323_main.c             |   4 +-
 net/netfilter/nf_conntrack_helper.c                |  19 +-
 net/netfilter/nf_conntrack_irc.c                   |   2 +
 net/netfilter/nf_conntrack_netlink.c               |  45 ++---
 net/netfilter/nf_conntrack_pptp.c                  |   2 +
 net/netfilter/nf_conntrack_sip.c                   |  13 +-
 net/netfilter/nf_flow_table_core.c                 |  13 +-
 net/netfilter/nf_flow_table_ip.c                   |  88 +++------
 net/netfilter/nf_flow_table_path.c                 |   4 +-
 net/netfilter/nf_nat_core.c                        |  10 +
 net/netfilter/nf_queue.c                           |  14 ++
 net/netfilter/nfnetlink_queue.c                    |   3 +
 net/netfilter/nft_compat.c                         |  24 ++-
 net/netfilter/nft_ct.c                             |  22 ++-
 net/netfilter/nft_meta.c                           |   5 +-
 net/netfilter/nft_payload.c                        |  16 +-
 net/netfilter/nft_synproxy.c                       |   9 +-
 net/netfilter/xt_cluster.c                         |   2 +-
 net/openvswitch/conntrack.c                        |   3 +-
 net/psample/psample.c                              |   6 +-
 net/rds/send.c                                     |   2 +
 net/rxrpc/ar-internal.h                            |   6 +-
 net/rxrpc/call_event.c                             |   5 +-
 net/rxrpc/call_object.c                            |   2 +
 net/rxrpc/conn_client.c                            |   2 +-
 net/rxrpc/conn_event.c                             |   9 +-
 net/rxrpc/input.c                                  |  39 +++-
 net/rxrpc/oob.c                                    |  12 +-
 net/rxrpc/recvmsg.c                                |  10 +-
 net/rxrpc/sendmsg.c                                |   3 +-
 net/sched/act_ct.c                                 |  13 +-
 net/sched/cls_api.c                                |   3 +
 net/sched/sch_dualpi2.c                            |  11 +-
 net/sched/sch_generic.c                            |   7 +-
 net/sctp/diag.c                                    |  67 ++++---
 net/sctp/sm_statefuns.c                            |   5 +
 net/sctp/socket.c                                  |  29 ++-
 net/tipc/core.c                                    |   9 +-
 net/tipc/crypto.c                                  |   9 +
 net/tipc/discover.c                                |  14 +-
 net/tipc/udp_media.c                               |  19 +-
 net/xfrm/espintcp.c                                |  34 +---
 net/xfrm/xfrm_input.c                              |  29 +--
 net/xfrm/xfrm_interface_core.c                     |   3 +
 net/xfrm/xfrm_policy.c                             |  27 +--
 net/xfrm/xfrm_state.c                              |  23 ++-
 net/xfrm/xfrm_user.c                               |  20 +-
 tools/net/ynl/Makefile                             |   2 +-
 tools/net/ynl/Makefile.deps                        |   2 +
 tools/net/ynl/generated/Makefile                   |   2 +-
 tools/net/ynl/lib/Makefile                         |   2 +-
 tools/testing/selftests/bpf/config                 |   3 +
 tools/testing/selftests/bpf/prog_tests/test_xsk.c  |  96 +++++-----
 tools/testing/selftests/bpf/prog_tests/test_xsk.h  |   2 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 175 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 123 +++++++------
 .../testing/selftests/drivers/net/bonding/Makefile |   1 +
 .../drivers/net/bonding/bond_vlan_real_dev.sh      | 180 ++++++++++++++++++
 tools/testing/selftests/drivers/net/so_txtime.c    |   2 +-
 tools/testing/selftests/net/broadcast_ether_dst.sh |   2 +-
 .../net/netfilter/conntrack_sctp_collision.sh      |  89 ++++++---
 .../selftests/net/netfilter/nft_flowtable.sh       |   8 +-
 tools/testing/selftests/net/netfilter/nft_queue.sh |  66 ++++++-
 tools/testing/selftests/net/tls.c                  |   8 +-
 tools/testing/selftests/net/vlan_bridge_binding.sh |   2 +-
 .../selftests/tc-testing/tc-tests/actions/ct.json  |  38 ++++
 .../tc-testing/tc-tests/qdiscs/dualpi2.json        |  44 +++++
 tools/testing/selftests/tc-testing/tdc_gso.py      |  43 +++++
 239 files changed, 3041 insertions(+), 1290 deletions(-)
 create mode 100644 net/core/netdev_work.c
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_vlan_real_dev.sh
 create mode 100755 tools/testing/selftests/tc-testing/tdc_gso.py

