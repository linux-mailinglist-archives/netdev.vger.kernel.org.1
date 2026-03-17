Return-Path: <netdev+bounces-268613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHjaDz9fuWnYAgIAu9opvQ
	(envelope-from <netdev+bounces-268613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:03:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D842AB5EF
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0B683065145
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73203E1CE7;
	Tue, 17 Mar 2026 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LxfvirS4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nSeS5l/y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xPLtK05c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wKZFUQNt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0012E3A5E7F
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756171; cv=none; b=dC+gxHYVzLXZnlVzzgDq24n9xKKlDgqZImt560s5mG8xtWi4JNokwLEinvP52Q3CAh8/fRmR/VpfmAcwnVuf+k/VANb7TVzNJrwxLRCMzvH6o6aKcSEcXQLh4m6u9lszGjsAQrc8M11W81UPe5Q8l/wUuIBuhbUsmxmrm4+n7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756171; c=relaxed/simple;
	bh=kECZmN7bFkG2NC+tLmbH79h9tkrtHSLc45Yj03+M1m8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YpKNSFh8qNyW3aRRk4LyMuj+OtD7f43l6VAFiKRaea6x3ljvuQu33kt22pPQjkdmD9MFwLJn8iUYGkNwJYh8bMsT0gj8WQ0EwgLbJLEWmPrEaZiPouidFf80zeqCFLwWVFidWY1r8E3aSh0DKAPW1SiCUTH7fIvExIQXEW7oiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LxfvirS4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nSeS5l/y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xPLtK05c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wKZFUQNt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A89B5BCC9;
	Tue, 17 Mar 2026 14:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773756160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fpecIF/k7eOUb/z2nQE381lmopQZPgVCHWe0k3hAlxg=;
	b=LxfvirS4X9/wr5+W9eP60oIkM5a1E5gYP8tZb7wFlm9hlYIhxApa73jiW8/rpnxlqvSlt+
	ZMtPgeffwOSjL+vgbSp24km0vqjU6Xv2gkAkXEJw3qkYHKlSmrbupb3DvuYIjuIS4Dj2ZU
	2o/8ahhwbAEjGfDyVBu+dXu6h8bowCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773756160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fpecIF/k7eOUb/z2nQE381lmopQZPgVCHWe0k3hAlxg=;
	b=nSeS5l/y1ro5IkDlV0Z7/a9DSk9VyqzaY5phnamhLZlTCMzNp0WVuvlOaxwbkg7XArXjrA
	AdFtj0ZYrEONEACw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773756155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fpecIF/k7eOUb/z2nQE381lmopQZPgVCHWe0k3hAlxg=;
	b=xPLtK05cPsMdRfwakHdBBx29JVJ1MQO1p8HzToMKldGcw7PFR/Z4sOHIpJR2YF7EQP79kx
	hY7dX+ZpVaBRAvKwdGQX0b10zYyqZ6L6WCoTWooHc2xRrGEWEDPgrBtATfdKSW72y/4m2Y
	M4JCIA9yhROG1pLkP0xMeiVUNySulnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773756155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fpecIF/k7eOUb/z2nQE381lmopQZPgVCHWe0k3hAlxg=;
	b=wKZFUQNtGlXX9VvbNSj8L0k2jzjZfBktlWhTZkYwPJ1PGAPMLSz6XbeK+2G2mjG+5fNoLO
	XEITK3junafs2tBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2A9B4273B;
	Tue, 17 Mar 2026 14:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hzp8LPpeuWmpYwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 17 Mar 2026 14:02:34 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	rbm@suse.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10 net-next v3] Convert CONFIG_IPV6 to built-in and remove stubs
Date: Tue, 17 Mar 2026 15:00:56 +0100
Message-ID: <20260317140141.5723-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[googlesource.com:query timed out,suse.de:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268613-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[suse.de:query timed out,googlesource.com:query timed out];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid,googlesource.com:url]
X-Rspamd-Queue-Id: 01D842AB5EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Historically, the Linux kernel has supported compiling the IPv6 stack as
a loadable module. While this made sense in the early days of IPv6
adoption, modern deployments and distributions overwhelmingly either
build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
entirely (CONFIG_IPV6=n). The modular IPv6 use-case offers image size
and memory savings for specific setups, this benefit is outweighed by
the architectural burden it imposes on the subsystems on implementation
and maintenance.

In addition, most of the distributions are already using CONFIG_IPV6=y
by default [1], including openWRT [2] and Android gki_defconfig [3]. So
this won't have an impact on them. The most impacted architecture would
probably be arm64 as their default config is still using CONFIG_IPV6=m. 

To allow core networking, BPF, Netfilter, and various device drivers to
safely interact with a potentially unloaded IPv6 module, the kernel
relies on indirect call structures like ipv6_stub, ipv6_bpf_stub, and
nf_ipv6_ops, along with dynamic RCU registrations for things like ICMPv6
senders.

This patch series addresses this by changing CONFIG_IPV6 from a tristate
to a boolean, enforcing that IPv6 is either built-in or disabled. This
allows us to completely rip out the stub infrastructures and safely
replace them with direct function calls.

The bloat-o-meter report the following results for m68k, arm64, x86_64
defconfig.

m68k (keep on mind that CONFIG_IPV6 is disabled now):
add/remove: 65/938 grow/shrink: 36/254 up/down: 3022/-49692 (-46670)

arm64:
add/remove: 1251/265 grow/shrink: 81/46 up/down: 448740/-71519 (377221)

x86_64:
add/remove: 62/98 grow/shrink: 10/39 up/down: 2497/-4357 (-1860)

Considering that each new kernel release increases sizes by 30-40KiB on
average, this size increase isn't a huge jump for the distributions that
are still using CONFIG_IPV6=m. For the ones that are already using
CONFIG_IPV6=y, the size is reduced actually.

All the patches has been independently build tested. With allmodconfig
and allmodconfig + CONFIG_IPV6=n. In addition, net selftest has been run
against them on virtme-ng.

The series applied as a whole as been tested with allyesconfig and also
allyesconfig + CONFIG_IPV6=n but not all patches has been independently
tested this way.

[1] https://github.com/nyrahul/linux-kernel-configs

[2] https://github.com/openwrt/openwrt/commit/832e7b817221d288df76b763ca12c585365db5d8

[3] https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/arch/arm64/configs/gki_defconfig


Changes:
  v3:
    Patch 1: bring back CONFIG_NET_FOU_IP_TUNNELS on m68k defconfigs and drop unrelated changes.
    Patch 4: add missing netlink error message indicating IPv6 is disabled
    Patch 8: use __inet6_bind() instead the alias that was just created.

  v2: https://lore.kernel.org/netdev/20260310153506.5181-1-fmancera@suse.de/
    Patch 1: change fs_initcall() to device_initcall() to avoid race condition and disable CONFIG_IPV6 on m68k defconfigs.

  v1: https://lore.kernel.org/netdev/20260309022013.5199-1-fmancera@suse.de/

Fernando Fernandez Mancera (10):
  ipv6: convert CONFIG_IPV6 to built-in only and clean up Kconfigs
  ipv6: replace IS_BUILTIN(CONFIG_IPV6) with IS_ENABLED(CONFIG_IPV6)
  ipv6: remove dynamic ICMPv6 sender registration infrastructure
  ipv6: prepare headers for ipv6_stub removal
  drivers: net: drop ipv6_stub usage and use direct function calls
  ipv4: drop ipv6_stub usage and use direct function calls
  net: convert remaining ipv6_stub users to direct function calls
  bpf: remove ipv6_bpf_stub completely and use direct function calls
  ipv6: remove ipv6_stub infrastructure completely
  netfilter: remove nf_ipv6_ops and use direct function calls

 arch/arm64/configs/defconfig                  |   2 +-
 arch/m68k/configs/amiga_defconfig             |  44 +-------
 arch/m68k/configs/apollo_defconfig            |  44 +-------
 arch/m68k/configs/atari_defconfig             |  44 +-------
 arch/m68k/configs/bvme6000_defconfig          |  44 +-------
 arch/m68k/configs/hp300_defconfig             |  44 +-------
 arch/m68k/configs/mac_defconfig               |  44 +-------
 arch/m68k/configs/multi_defconfig             |  44 +-------
 arch/m68k/configs/mvme147_defconfig           |  44 +-------
 arch/m68k/configs/mvme16x_defconfig           |  44 +-------
 arch/m68k/configs/q40_defconfig               |  44 +-------
 arch/m68k/configs/sun3_defconfig              |  44 +-------
 arch/m68k/configs/sun3x_defconfig             |  44 +-------
 drivers/infiniband/Kconfig                    |   1 -
 drivers/infiniband/core/addr.c                |   3 +-
 drivers/infiniband/hw/ocrdma/Kconfig          |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.c           |   6 +-
 drivers/infiniband/ulp/ipoib/Kconfig          |   2 +-
 drivers/net/Kconfig                           |   9 --
 drivers/net/ethernet/broadcom/Kconfig         |   2 +-
 drivers/net/ethernet/chelsio/Kconfig          |   2 +-
 .../mellanox/mlx5/core/en/rep/neigh.c         |  12 ++-
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   |   3 +-
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |   2 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   1 -
 drivers/net/ethernet/mellanox/mlxsw/Kconfig   |   1 -
 .../ethernet/mellanox/mlxsw/spectrum_router.c |   9 +-
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |   3 +-
 drivers/net/ethernet/netronome/Kconfig        |   1 -
 .../ethernet/netronome/nfp/flower/action.c    |   2 +-
 .../netronome/nfp/flower/tunnel_conf.c        |   9 +-
 drivers/net/ethernet/sfc/tc_counters.c        |   2 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c   |   5 +-
 drivers/net/geneve.c                          |   1 -
 drivers/net/gtp.c                             |   2 +-
 drivers/net/ovpn/peer.c                       |   3 +-
 drivers/net/ovpn/udp.c                        |   3 +-
 drivers/net/usb/cdc_mbim.c                    |  17 +--
 drivers/net/vrf.c                             |   3 +-
 drivers/net/vxlan/vxlan_core.c                |  11 +-
 drivers/net/vxlan/vxlan_multicast.c           |   6 +-
 drivers/net/wireguard/socket.c                |   3 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c  |   2 +-
 drivers/scsi/bnx2fc/Kconfig                   |   1 -
 drivers/scsi/bnx2i/Kconfig                    |   1 -
 drivers/scsi/cxgbi/cxgb3i/Kconfig             |   2 +-
 drivers/scsi/cxgbi/cxgb4i/Kconfig             |   2 +-
 fs/dlm/Kconfig                                |   2 +-
 fs/gfs2/Kconfig                               |   2 +-
 include/linux/icmpv6.h                        |  26 +----
 include/linux/indirect_call_wrapper.h         |   2 +-
 include/linux/netfilter_ipv6.h                | 102 ++----------------
 include/net/ip.h                              |   5 -
 include/net/ip6_fib.h                         |  35 +++++-
 include/net/ip6_route.h                       |  26 +++++
 include/net/ipv6.h                            |  12 +++
 include/net/ipv6_stubs.h                      | 101 -----------------
 include/net/ndisc.h                           |  38 +++----
 include/net/udp_tunnel.h                      |   3 +-
 net/bridge/Kconfig                            |   1 -
 net/bridge/br_arp_nd_proxy.c                  |   3 +-
 net/bridge/br_netfilter_hooks.c               |  12 +--
 net/bridge/br_netfilter_ipv6.c                |   7 +-
 net/core/filter.c                             |  68 +++++-------
 net/core/lwt_bpf.c                            |  10 +-
 net/ieee802154/6lowpan/tx.c                   |   2 +-
 net/ipv4/Kconfig                              |   9 +-
 net/ipv4/fib_semantics.c                      |  11 +-
 net/ipv4/icmp.c                               |   2 +-
 net/ipv4/nexthop.c                            |  21 ++--
 net/ipv4/route.c                              |   2 +-
 net/ipv4/udp.c                                |   7 +-
 net/ipv6/Kconfig                              |   6 +-
 net/ipv6/addrconf.c                           |  10 +-
 net/ipv6/addrconf_core.c                      |  91 ----------------
 net/ipv6/af_inet6.c                           |  67 +-----------
 net/ipv6/icmp.c                               |   6 --
 net/ipv6/ip6_fib.c                            |  10 +-
 net/ipv6/ip6_icmp.c                           |  46 +-------
 net/ipv6/ip6_offload.c                        |   4 +-
 net/ipv6/ip6_output.c                         |   5 +-
 net/ipv6/ip6_udp_tunnel.c                     |   3 +-
 net/ipv6/ndisc.c                              |  35 +++---
 net/ipv6/netfilter.c                          |  48 ---------
 net/ipv6/route.c                              |  13 +--
 net/l2tp/Kconfig                              |   1 -
 net/mpls/af_mpls.c                            |   3 +-
 net/netfilter/Kconfig                         |   8 --
 net/netfilter/core.c                          |   3 -
 net/netfilter/nf_nat_masquerade.c             |  21 +---
 net/netfilter/nfnetlink_queue.c               |  22 +++-
 net/netfilter/utils.c                         |   1 -
 net/openvswitch/actions.c                     |   3 +-
 net/rxrpc/Kconfig                             |   2 +-
 net/sched/sch_frag.c                          |   4 +-
 net/sctp/Kconfig                              |   1 -
 net/tipc/Kconfig                              |   1 -
 net/tipc/udp_media.c                          |   9 +-
 net/xfrm/espintcp.c                           |   5 +-
 net/xfrm/xfrm_nat_keepalive.c                 |   4 +-
 net/xfrm/xfrm_output.c                        |   3 +-
 103 files changed, 324 insertions(+), 1286 deletions(-)
 delete mode 100644 include/net/ipv6_stubs.h

-- 
2.53.0


