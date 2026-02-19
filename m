Return-Path: <netdev+bounces-259560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULdUHF5Vl2lPxAIAu9opvQ
	(envelope-from <netdev+bounces-259560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:24:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB361161A41
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A62B301D6BC
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906BB2BD031;
	Thu, 19 Feb 2026 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH0BVhWh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C59110E3;
	Thu, 19 Feb 2026 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525383; cv=none; b=XGcE5smQZa9Uyo/zqqa+1kVjjRA5ewJYs0x8YcKAWtkAHXDieUmCuDgziPGDS2lLZifzr+1y0d64IwVsJRJqdIfUHBIGKzk37sGN/aNS8o/tC3paiC7qc5SCzBwf8nmKj86QjSrMYxhJBBHKoWy8sdvsmmBOvpjKZUlAvwSlwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525383; c=relaxed/simple;
	bh=X9JOI5zH7Dn3UvkeUkUE87DuY5w9gvjTh2UEBEMNaGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oChx5d64HCORbZMFND9xyEzJE5hjmVGwhY+stKhgbEBM1N5hZDFrgfkHjoonJOngvd98Yzpo7fhsJVPLbqXaoDjfEDUuBht0IWZV3y0qm0RBfkLENTWuq2mO6ozkr1sZmMJiG5NaPBn4XrPQr+OzNovGY0yxggJb4N34N31GP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH0BVhWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C69C4CEF7;
	Thu, 19 Feb 2026 18:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771525383;
	bh=X9JOI5zH7Dn3UvkeUkUE87DuY5w9gvjTh2UEBEMNaGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=fH0BVhWhyQN8tKz09MRmYgv9qWykHp0iiONPN8kdNVUK9zxCu4XAdHiCpvvs956f6
	 numyOKEvxlLDmqYPSOqgH8LBSmAxoe0t0orTi8Clw2HOv/Z8bmvFHEG1V2qEriHqvM
	 cy8Y/xzMGhDrDFipSbHcxvpNAZtdFLfl/oupW/R4eAW1FgfMB0KdCpZlmGbm3oqM+T
	 hBAKq/M3oRSeYDg3lNE1hMfzzNdud0w9c7ZkIwCf4rFySCZXfsbJmNVbS9EDI2xjmL
	 /q6ZrxNu4yHrqjb3BGSKUO3e9+odttDqq3CmrL4hQtmSb9RH2dTqf/4hbs4s/l6Y3k
	 VWa5O6gj37cow==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v7.0-rc1
Date: Thu, 19 Feb 2026 10:23:01 -0800
Message-ID: <20260219182301.660280-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259560-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB361161A41
X-Rspamd-Action: no action

Hi Linus!

The following changes since commit 37a93dd5c49b5fda807fd204edf2547c3493319c:

  Merge tag 'net-next-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2026-02-11 19:31:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc1

for you to fetch changes up to 571dcbeb8e635182bb825ae758399831805693c2:

  net: nfc: nci: Fix parameter validation for packet data (2026-02-19 09:32:51 -0800)

----------------------------------------------------------------
Including fixes from Netfilter.

Current release - new code bugs:

 - net: fix backlog_unlock_irq_restore() vs CONFIG_PREEMPT_RT

 - eth: mlx5e: XSK, Fix unintended ICOSQ change

 - phy_port: correctly recompute the port's linkmodes

 - vsock: prevent child netns mode switch from local to global

 - couple of kconfig fixes for new symbols

Previous releases - regressions:

 - nfc: nci: fix false-positive parameter validation for packet data

 - net: do not delay zero-copy skbs in skb_attempt_defer_free()

Previous releases - always broken:

 - mctp: ensure our nlmsg responses to user space are zero-initialised

 - ipv6: ioam: fix heap buffer overflow in __ioam6_fill_trace_data()

 - fixes for ICMP rate limiting

Misc:

 - intel: fix PCI device ID conflict between i40e and ipw2200

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aleksei Oladko (3):
      selftests: forwarding: vxlan_bridge_1d: fix test failure with br_netfilter enabled
      selftests: forwarding: vxlan_bridge_1d_ipv6: fix test failure with br_netfilter enabled
      selftests: forwarding: fix pedit tests failure with br_netfilter enabled

Allison Henderson (2):
      net/rds: rds_sendmsg should not discard payload_len
      net/rds: Fix NULL pointer dereference in rds_tcp_accept_one

Antonio Quartulli (1):
      ovpn: tcp - don't deref NULL sk_socket member after tcp_close()

Arnd Bergmann (3):
      printk: add CONFIG_PRINTK dependency for netconsole
      net: psp: select CONFIG_SKB_EXTENSIONS
      net: dsa: MxL862xx: don't force-enable MAXLINEAR_GPHY

Bobby Eshleman (4):
      eth: fbnic: set FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT on RDE_CTL0
      eth: fbnic: increase FBNIC_HDR_BYTES_MIN from 128 to 256 bytes
      eth: fbnic: set DMA_HINT_L4 for all flows
      selftests: drv-net: add HDS payload sweep test for devmem TCP

Brian Witte (3):
      netfilter: nft_counter: serialize reset with spinlock
      netfilter: nft_quota: use atomic64_xchg for reset
      netfilter: nf_tables: revert commit_mutex usage in reset path

Chen Ni (2):
      myri10ge: replace comma with semicolons
      bng_en: Remove duplicate include

Chengfeng Ye (1):
      fbnic: close fw_log race between users and teardown

Cosmin Ratiu (2):
      net/mlx5e: Fix deadlocks between devlink and netdev instance locks
      net/mlx5e: Use unsigned for mlx5e_get_max_num_channels

Daniel Machon (2):
      net: sparx5/lan969x: fix DWRR cost max to match hardware register width
      net: sparx5/lan969x: fix PTP clock max_adj value

Dimitri Daskalakis (2):
      eth: fbnic: Add validation for MTU changes
      eth: fbnic: Advertise supported XDP features.

Duoming Zhou (1):
      atm: fore200e: fix use-after-free in tasklets during device removal

Eric Dumazet (11):
      net: fix backlog_unlock_irq_restore() vs CONFIG_PREEMPT_RT
      ipv6: fix a race in ip6_sock_set_v6only()
      net: do not delay zero-copy skbs in skb_attempt_defer_free()
      ping: annotate data-races in ping_lookup()
      macvlan: observe an RCU grace period in macvlan_common_newlink() error path
      selftests/net: packetdrill: add ipv4-mapped-ipv6 tests
      icmp: prevent possible overflow in icmp_global_allow()
      inet: move icmp_global_{credit,stamp} to a separate cache line
      ipv6: icmp: remove obsolete code in icmpv6_xrlim_allow()
      ipv4: icmp: icmpv4_xrlim_allow() optimization if net.ipv4.icmp_ratelimit is zero
      ipv6: icmp: icmpv6_xrlim_allow() optimization if net.ipv6.icmp.ratelimit is zero

Ethan Nelson-Moore (2):
      net: intel: fix PCI device ID conflict between i40e and ipw2200
      net: arcnet: com20020-pci: fix support for 2.5Mbit cards

Fernando Fernandez Mancera (1):
      ipv6: addrconf: reduce default temp_valid_lft to 2 days

Florian Westphal (1):
      netfilter: nf_conntrack_h323: don't pass uninitialised l3num value

Gal Pressman (4):
      selftests: drv-net: limit RPS test CPUs to supported range
      net/mlx5e: Fix misidentification of ASO CQE during poll loop
      net/mlx5: Fix misidentification of write combining CQE during poll loop
      net/mlx5e: MACsec, add ASO poll loop in macsec_aso_set_arm_event

Hangbin Liu (1):
      bonding: alb: fix UAF in rlb_arp_recv during bond up/down

Hariprasad Kelam (1):
      octeontx2-af: Fix default entries mcam entry action

Ido Schimmel (1):
      selftests: mlxsw: tc_restrictions: Fix test failure with new iproute2

Inseo An (1):
      netfilter: nf_tables: fix use-after-free in nf_tables_addchain()

Ivan Vecera (1):
      dpll: zl3073x: Fix ref frequency setting

Jakub Kicinski (7):
      Merge branch 'net-phy_port-sfp-modules-representation-and-phy_port-listing'
      Merge branch 'net-mscc-ocelot-fix-missing-lock-in-ocelot_port_xmit'
      Merge branch 'vsock-fix-child-netns-mode-initialization-and-restriction'
      selftests: tc_actions: don't dump 2MB of \0 to stdout
      Merge branch 'icmp-better-deal-with-ddos'
      Merge tag 'nf-26-02-17' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'mlx5-misc-fixes-2026-02-18'

Jeremy Kerr (1):
      net: mctp: ensure our nlmsg responses are initialised

Jie Zhang (1):
      net: stmmac: fix oops when split header is enabled

Julian Anastasov (2):
      ipvs: skip ipv6 extension headers for csum checks
      ipvs: do not keep dest_dst if dev is going down

Kuniyuki Iwashima (1):
      ipv6: Fix out-of-bound access in fib6_add_rt2node().

Maxime Chevallier (3):
      net: phy: initialize the port support based on the PHY's for OF ports
      net: phy: phy_port: Cleanup the of-parsing logic for phy_port
      net: phy: phy_port: Correctly recompute the port's linkmodes

Michael Thalmeier (1):
      net: nfc: nci: Fix parameter validation for packet data

Nikolay Aleksandrov (2):
      net: bridge: mcast: always update mdb_n_entries for vlan contexts
      selftests: forwarding: bridge_mdb_max: add tests for mdb_n_entries warning

Pablo Neira Ayuso (1):
      net: remove WARN_ON_ONCE when accessing forward path array

Paolo Abeni (4):
      Merge branch 'eth-fbnic-fix-and-improve-header-data-split-configuration'
      Merge tag 'ovpn-net-20260212' of https://github.com/OpenVPN/ovpn-net-next
      Merge branch 'net-bridge-mcast-fix-mdb_n_entries-counting-warning'
      Merge branch 'selftests-forwarding-fix-br_netfilter-related-test-failures'

Phil Sutter (1):
      include: uapi: netfilter_bridge.h: Cover for musl libc

Pin-yen Lin (1):
      selftests: netconsole: Increase port listening timeout

Qanux (1):
      ipv6: ioam: fix heap buffer overflow in __ioam6_fill_trace_data()

Ralf Lici (3):
      ovpn: set sk_user_data before overriding callbacks
      ovpn: fix possible use-after-free in ovpn_net_xmit
      ovpn: fix VPN TX bytes counting

Ruitong Liu (1):
      net/sched: act_skbedit: fix divide-by-zero in tcf_skbedit_hash()

Shay Drory (1):
      net/mlx5: Fix multiport device check over light SFs

Stefano Garzarella (3):
      vsock: fix child netns mode initialization
      vsock: prevent child netns mode switch from local to global
      vsock: document namespace mode sysctls

Sun Jian (1):
      netfilter: annotate NAT helper hook pointers with __rcu

Tabrez Ahmed (1):
      rds: tcp: fix uninit-value in __inet_bind

Tariq Toukan (1):
      net/mlx5e: XSK, Fix unintended ICOSQ change

Thomas Fourier (1):
      net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle

Vikas Gupta (1):
      bnge: fix reserving resources from FW

Yue Haibing (1):
      selftests: net: lib: Fix jq parsing error

Ziyi Guo (5):
      net: mscc: ocelot: extract ocelot_xmit_timestamp() helper
      net: mscc: ocelot: split xmit into FDMA and register injection paths
      net: mscc: ocelot: add missing lock protection in ocelot_port_xmit_inj()
      net: usb: catc: enable basic endpoint checking
      xen-netback: reject zero-queue configuration from guest

 Documentation/admin-guide/sysctl/net.rst           |  52 ++++-
 Documentation/networking/ip-sysctl.rst             |   7 +-
 drivers/atm/fore200e.c                             |   4 +
 drivers/dpll/zl3073x/ref.h                         |   2 +
 drivers/net/Kconfig                                |   1 +
 drivers/net/arcnet/com20020-pci.c                  |  16 +-
 drivers/net/bonding/bond_main.c                    |   6 +-
 drivers/net/dsa/mxl862xx/Kconfig                   |   1 -
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c |   2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c   |   1 -
 drivers/net/ethernet/ec_bhf.c                      |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   8 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  41 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |  14 --
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |  13 ++
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |  52 ++++-
 .../net/ethernet/mellanox/mlx5/core/en/tc/meter.c  |  10 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/pool.c  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/tx.c    |   2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  64 ++----
 drivers/net/ethernet/mellanox/mlx5/core/wc.c       |  14 +-
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c     |   3 -
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |  20 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |  19 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c        |   5 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |  25 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |   2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |   2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.h |   2 +-
 drivers/net/ethernet/mscc/ocelot_net.c             |  89 +++++---
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |  12 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  20 +-
 drivers/net/macvlan.c                              |   5 +
 drivers/net/ovpn/io.c                              |  57 +++--
 drivers/net/ovpn/socket.c                          |  41 ++--
 drivers/net/ovpn/tcp.c                             |  23 +-
 drivers/net/ovpn/udp.c                             |   1 +
 drivers/net/phy/phy_device.c                       |   3 +
 drivers/net/phy/phy_port.c                         |  33 +--
 drivers/net/usb/catc.c                             |  37 ++-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |   8 +-
 drivers/net/xen-netback/xenbus.c                   |   5 +-
 include/linux/mlx5/driver.h                        |   4 +-
 include/linux/netfilter/nf_conntrack_amanda.h      |   2 +-
 include/linux/netfilter/nf_conntrack_ftp.h         |   2 +-
 include/linux/netfilter/nf_conntrack_irc.h         |   2 +-
 include/linux/netfilter/nf_conntrack_snmp.h        |   2 +-
 include/linux/netfilter/nf_conntrack_tftp.h        |   2 +-
 include/net/addrconf.h                             |   3 +-
 include/net/ioam6.h                                |   2 +
 include/net/ipv6.h                                 |  11 +-
 include/net/netns/ipv4.h                           |   9 +-
 include/uapi/linux/netfilter_bridge.h              |   4 +
 net/bridge/br_multicast.c                          |  45 ++--
 net/core/dev.c                                     |  19 +-
 net/core/skbuff.c                                  |   7 +-
 net/ipv4/icmp.c                                    |  17 +-
 net/ipv4/ping.c                                    |  33 +--
 net/ipv6/af_inet6.c                                |   2 +-
 net/ipv6/exthdrs.c                                 |   5 +
 net/ipv6/icmp.c                                    |  15 +-
 net/ipv6/ioam6.c                                   |  14 ++
 net/ipv6/ioam6_iptunnel.c                          |  10 +-
 net/ipv6/ip6_fib.c                                 |   2 +-
 net/mctp/device.c                                  |   1 +
 net/mctp/neigh.c                                   |   1 +
 net/mctp/route.c                                   |   1 +
 net/netfilter/ipvs/ip_vs_proto_sctp.c              |  18 +-
 net/netfilter/ipvs/ip_vs_proto_tcp.c               |  21 +-
 net/netfilter/ipvs/ip_vs_proto_udp.c               |  20 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |  46 +++-
 net/netfilter/nf_conntrack_amanda.c                |  14 +-
 net/netfilter/nf_conntrack_ftp.c                   |  14 +-
 net/netfilter/nf_conntrack_h323_main.c             |  10 +-
 net/netfilter/nf_conntrack_irc.c                   |  13 +-
 net/netfilter/nf_conntrack_snmp.c                  |   8 +-
 net/netfilter/nf_conntrack_tftp.c                  |   7 +-
 net/netfilter/nf_tables_api.c                      | 249 ++++-----------------
 net/netfilter/nft_counter.c                        |  20 +-
 net/netfilter/nft_quota.c                          |  13 +-
 net/nfc/nci/ntf.c                                  | 159 +++++++++++--
 net/psp/Kconfig                                    |   1 +
 net/rds/send.c                                     |   6 +-
 net/rds/tcp.c                                      |   2 +-
 net/rds/tcp_listen.c                               |  20 +-
 net/sched/act_skbedit.c                            |   6 +-
 net/vmw_vsock/af_vsock.c                           |  20 +-
 tools/testing/selftests/drivers/net/hw/devmem.py   |  19 +-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |  11 +-
 tools/testing/selftests/drivers/net/hw/toeplitz.py |  17 +-
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |   4 +-
 .../selftests/drivers/net/mlxsw/tc_restrictions.sh |   4 +-
 .../selftests/net/forwarding/bridge_mdb_max.sh     |  90 +++++++-
 .../selftests/net/forwarding/pedit_dsfield.sh      |   8 +
 tools/testing/selftests/net/forwarding/pedit_ip.sh |   8 +
 .../testing/selftests/net/forwarding/tc_actions.sh |   2 +-
 .../selftests/net/forwarding/vxlan_bridge_1d.sh    |  26 ++-
 .../net/forwarding/vxlan_bridge_1d_ipv6.sh         |   2 +-
 tools/testing/selftests/net/lib.sh                 |   2 +-
 .../selftests/net/packetdrill/ksft_runner.sh       |  11 +-
 103 files changed, 1140 insertions(+), 694 deletions(-)

