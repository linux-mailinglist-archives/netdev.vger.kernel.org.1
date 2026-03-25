Return-Path: <netdev+bounces-271514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHtbFcDZw2lwuQQAu9opvQ
	(envelope-from <netdev+bounces-271514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:49:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7353325256
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D104A3274F85
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 12:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91263CFF5F;
	Wed, 25 Mar 2026 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RDx5QQjf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rmZjMPAB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RDx5QQjf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rmZjMPAB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64463081D6
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440601; cv=none; b=MVS2KKd973/p8hIb50vvFyjO2PU1iTp0Tx8bk7WvvUJ0vCwvOD+kqhybGVhbKPc35ZPhA8PSrF04t6fvaNXrzthvBwXZrbzVOOXkmuBqfg65b9SRzpjUM8Sj9mcAIScImlwfnSvPTF4KqBPMgcTM4lvS+OqHp36nFdEly6M0VN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440601; c=relaxed/simple;
	bh=mpV6pLE+IlWGAnGQSELSkIuCDexfIH52Z9wNAmhtNHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3R75NfRIIT1s7afQFX5IVeLFIRe32pVJLTugxxYGkNnebf5RJHNjEOxJOeUtwxPUXD73AY2MLX5/a0jmJi4ou9D88pAOqIwsVQNNvdDjtiZwl4KCqzEcS5fdEz8orayOQtHESuLaBRtc7Vf/emhHTNM184OFqd0ew1F2XISxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RDx5QQjf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rmZjMPAB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RDx5QQjf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rmZjMPAB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 254A04D22F;
	Wed, 25 Mar 2026 12:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774440597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NOCNudXR5dvmat4Qmt8GsS2WwmapGJyQDsXF+o4qCik=;
	b=RDx5QQjf97nMXtY5QUsmF/16/x8HLokYO1i5rcNOfVvQ6SCKeGZcojff/648QpGvC2gBDy
	y9emFyd4YL30ZEL/H/JpUQcPxiRmAE8HCBawANj4wcduJUs6ZvAD2MEGGwwjw6WiqXn00a
	Yt8OC1vHZIkiY4khN7aOnQgJYIve0oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774440597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NOCNudXR5dvmat4Qmt8GsS2WwmapGJyQDsXF+o4qCik=;
	b=rmZjMPABzr3yBwEH/IGhOP4a9O+x7+SXcFcPDVBnNJBHbtyB5PuC4l3/lBylD02yK8hw3L
	+ZEqX9q7qVtFHpAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774440597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NOCNudXR5dvmat4Qmt8GsS2WwmapGJyQDsXF+o4qCik=;
	b=RDx5QQjf97nMXtY5QUsmF/16/x8HLokYO1i5rcNOfVvQ6SCKeGZcojff/648QpGvC2gBDy
	y9emFyd4YL30ZEL/H/JpUQcPxiRmAE8HCBawANj4wcduJUs6ZvAD2MEGGwwjw6WiqXn00a
	Yt8OC1vHZIkiY4khN7aOnQgJYIve0oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774440597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NOCNudXR5dvmat4Qmt8GsS2WwmapGJyQDsXF+o4qCik=;
	b=rmZjMPABzr3yBwEH/IGhOP4a9O+x7+SXcFcPDVBnNJBHbtyB5PuC4l3/lBylD02yK8hw3L
	+ZEqX9q7qVtFHpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FB61443BD;
	Wed, 25 Mar 2026 12:09:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FO8hHJTQw2kbNgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Mar 2026 12:09:56 +0000
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
Subject: [PATCH 00/11 net-next v5] Convert CONFIG_IPV6 to built-in and remove stubs
Date: Wed, 25 Mar 2026 13:08:41 +0100
Message-ID: <20260325120928.15848-1-fmancera@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlesource.com:url,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: C7353325256
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
  v5:
    Patch 3: drop all IS_BUILTIN(IPV6) on files compiled only when IPV6=y
    Patch 5: drop the skb in ip6_fragment() before returning -EAFNOSUPPORT
    Patch 4, 6, 10: drop ipv6_get_nd_tbl() and use &nd_tbl directly always guarded by IS_ENABLED(CONFIG_IPV6) check

  v4: https://lore.kernel.org/netdev/20260320185649.5411-1-fmancera@suse.de/
    Patch 2: new patch introduced on this revision
    Patch 3: drop some IS_BUILTIN(IPV6) on files compiled only when IPV6=y
    Patch 5: introduce ipv6_mod_enabled() checks on fib6_nh_init(), ip6_dst_lookup_flow() and ip6_fragment() to avoid crash when ipv6.disable=1 during boot
    Patch 6: use &nd_tbl on code guarded by IS_ENABLED(CONFIG_IPV6)
    Patch 7: ipv6_stub->fib6_update_sernum() is replaced by fib6_update_sernum_upto_root() variant and guarded by spinlocks as it was on the ipv6_stub variant. This fixes the RCU warnings.

  v3: https://lore.kernel.org/netdev/20260317140141.5723-1-fmancera@suse.de/
    Patch 1: bring back CONFIG_NET_FOU_IP_TUNNELS on m68k defconfigs and drop unrelated changes.
    Patch 4: add missing netlink error message indicating IPv6 is disabled
    Patch 8: use __inet6_bind() instead the alias that was just created.

  v2: https://lore.kernel.org/netdev/20260310153506.5181-1-fmancera@suse.de/
    Patch 1: change fs_initcall() to device_initcall() to avoid race condition and disable CONFIG_IPV6 on m68k defconfigs.

  v1: https://lore.kernel.org/netdev/20260309022013.5199-1-fmancera@suse.de/

Fernando Fernandez Mancera (11):
  ipv6: convert CONFIG_IPV6 to built-in only and clean up Kconfigs
  net: remove EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL() macros
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
 .../mellanox/mlx5/core/en/rep/neigh.c         |   9 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   |   3 +-
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |   2 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   1 -
 drivers/net/ethernet/mellanox/mlxsw/Kconfig   |   1 -
 drivers/net/ethernet/netronome/Kconfig        |   1 -
 .../ethernet/netronome/nfp/flower/action.c    |   2 +-
 .../netronome/nfp/flower/tunnel_conf.c        |   7 +-
 drivers/net/ethernet/sfc/tc_counters.c        |   2 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c   |   5 +-
 drivers/net/geneve.c                          |   1 -
 drivers/net/gtp.c                             |   2 +-
 drivers/net/ovpn/peer.c                       |   3 +-
 drivers/net/ovpn/udp.c                        |   3 +-
 drivers/net/usb/cdc_mbim.c                    |  17 +--
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
 include/linux/icmpv6.h                        |  29 +----
 include/linux/indirect_call_wrapper.h         |   2 +-
 include/linux/netfilter_ipv6.h                | 102 ++----------------
 include/net/ip.h                              |   8 --
 include/net/ip6_fib.h                         |  35 +++++-
 include/net/ip6_route.h                       |  26 +++++
 include/net/ipv6.h                            |  12 +++
 include/net/ipv6_stubs.h                      | 101 -----------------
 include/net/ndisc.h                           |  31 ++----
 include/net/udp_tunnel.h                      |   3 +-
 net/bridge/Kconfig                            |   1 -
 net/bridge/br_arp_nd_proxy.c                  |   3 +-
 net/bridge/br_netfilter_hooks.c               |  12 +--
 net/bridge/br_netfilter_ipv6.c                |   7 +-
 net/core/dev.c                                |   3 -
 net/core/filter.c                             |  72 ++++++-------
 net/core/hotdata.c                            |   1 -
 net/core/lwt_bpf.c                            |  10 +-
 net/core/neighbour.c                          |   1 -
 net/ipv4/Kconfig                              |   9 +-
 net/ipv4/fib_semantics.c                      |  16 +--
 net/ipv4/icmp.c                               |   2 +-
 net/ipv4/inet_connection_sock.c               |   2 -
 net/ipv4/inet_hashtables.c                    |   5 -
 net/ipv4/inetpeer.c                           |   4 -
 net/ipv4/metrics.c                            |   1 -
 net/ipv4/nexthop.c                            |  28 ++---
 net/ipv4/ping.c                               |  16 ---
 net/ipv4/route.c                              |   4 +-
 net/ipv4/syncookies.c                         |   4 -
 net/ipv4/tcp.c                                |  23 ----
 net/ipv4/tcp_fastopen.c                       |   1 -
 net/ipv4/tcp_input.c                          |   7 --
 net/ipv4/tcp_ipv4.c                           |  21 ----
 net/ipv4/tcp_minisocks.c                      |   4 -
 net/ipv4/tcp_output.c                         |   6 --
 net/ipv4/tcp_timer.c                          |   1 -
 net/ipv4/udp.c                                |  36 +------
 net/ipv6/Kconfig                              |   6 +-
 net/ipv6/addrconf_core.c                      |  91 ----------------
 net/ipv6/af_inet6.c                           |  67 +-----------
 net/ipv6/icmp.c                               |   6 --
 net/ipv6/ip6_fib.c                            |  10 +-
 net/ipv6/ip6_icmp.c                           |  46 +-------
 net/ipv6/ip6_offload.c                        |   4 +-
 net/ipv6/ip6_output.c                         |   8 ++
 net/ipv6/ip6_udp_tunnel.c                     |   3 +-
 net/ipv6/ndisc.c                              |   1 +
 net/ipv6/netfilter.c                          |  48 ---------
 net/ipv6/route.c                              |  12 +--
 net/l2tp/Kconfig                              |   1 -
 net/mpls/af_mpls.c                            |   3 +-
 net/netfilter/Kconfig                         |   8 --
 net/netfilter/core.c                          |   3 -
 net/netfilter/nf_nat_masquerade.c             |  21 +---
 net/netfilter/nfnetlink_queue.c               |  22 +++-
 net/netfilter/utils.c                         |   1 -
 net/openvswitch/actions.c                     |   3 +-
 net/psp/psp_sock.c                            |   1 -
 net/rxrpc/Kconfig                             |   2 +-
 net/sched/sch_frag.c                          |   4 +-
 net/sctp/Kconfig                              |   1 -
 net/tipc/Kconfig                              |   1 -
 net/tipc/udp_media.c                          |   9 +-
 net/xfrm/espintcp.c                           |   5 +-
 net/xfrm/xfrm_nat_keepalive.c                 |   4 +-
 net/xfrm/xfrm_output.c                        |   3 +-
 115 files changed, 296 insertions(+), 1397 deletions(-)
 delete mode 100644 include/net/ipv6_stubs.h

-- 
2.53.0


