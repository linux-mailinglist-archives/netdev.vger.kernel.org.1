Return-Path: <netdev+bounces-270024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJLFEp2YvWmR/QIAu9opvQ
	(envelope-from <netdev+bounces-270024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:57:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B52DF9AD
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C8F93048568
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E9F3E8693;
	Fri, 20 Mar 2026 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q2GRAN0t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uGoRHoVh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q2GRAN0t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uGoRHoVh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBA03E6DD7
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033032; cv=none; b=CxmgUrHIpK+vD/1Vg9wByNSh5LF1aBs4f+H7CIkvD/D5BS/svPHpCNbiRovTgQmSDQty7AUj/tMGqONxXvxKZusOUPN6rV3S4CGgsUu0y+e64BXEEIYcYwVJBHFVeuPSKnC337FkuueV/B70IXRia4Lj0RXNPI2S81ZPl/RH56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033032; c=relaxed/simple;
	bh=5u/69Ub4Juu4NLxxLAk9jCDB54EELB/kHB7fvnQzOso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPNc+7xG3Om3+5L5IZoL5xeYGiYw9ukPZxXNWqg2sTbxBECfDq5xkLCGtdvFsI2Yom8ynoInuMb5PCIh1VeeHEVGQ2ZscXrpWxb4cFujA3bGqy699iWZf21Bcqux78W9QR2b8gCYonZ6IEITQ5I9aIuCtykLZrDdK2H9awI7wBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q2GRAN0t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uGoRHoVh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q2GRAN0t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uGoRHoVh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B71655BE0E;
	Fri, 20 Mar 2026 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774033027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YDmRCzO4YhXudI4xqIEwirSRecK892oqD1VNQNzxbII=;
	b=Q2GRAN0tUmpumCO9vLu+EStF+ZwSg5Px2pcf/8IhAwCLU2sJEO7uTaArV8xyqBmpBoY9RZ
	MDEfYBKni3ETYJmBndwOCw0AHQ4419e9D/d4x9w3JEXbHEVrI5FYB1na7lc7aoXmX5JlPK
	qNhCKm9KEKbT5rn3LXT2p0cQlWTrv4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774033027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YDmRCzO4YhXudI4xqIEwirSRecK892oqD1VNQNzxbII=;
	b=uGoRHoVhssx3tX04oa7vi93tyk2492XC8FLuwjJaq6cygUcY7vjWhr+dfQdM3dB+qYSwLn
	MR1t+j2hz3O4qSDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774033027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YDmRCzO4YhXudI4xqIEwirSRecK892oqD1VNQNzxbII=;
	b=Q2GRAN0tUmpumCO9vLu+EStF+ZwSg5Px2pcf/8IhAwCLU2sJEO7uTaArV8xyqBmpBoY9RZ
	MDEfYBKni3ETYJmBndwOCw0AHQ4419e9D/d4x9w3JEXbHEVrI5FYB1na7lc7aoXmX5JlPK
	qNhCKm9KEKbT5rn3LXT2p0cQlWTrv4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774033027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YDmRCzO4YhXudI4xqIEwirSRecK892oqD1VNQNzxbII=;
	b=uGoRHoVhssx3tX04oa7vi93tyk2492XC8FLuwjJaq6cygUcY7vjWhr+dfQdM3dB+qYSwLn
	MR1t+j2hz3O4qSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B69C42952;
	Fri, 20 Mar 2026 18:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CsepOoKYvWnyTgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 20 Mar 2026 18:57:06 +0000
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
Subject: [PATCH 00/11 net-next v4] Convert CONFIG_IPV6 to built-in and remove stubs
Date: Fri, 20 Mar 2026 19:55:52 +0100
Message-ID: <20260320185649.5411-1-fmancera@suse.de>
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
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270024-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A07B52DF9AD
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
  v4:
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
  net: EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL() macros
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
 include/net/ndisc.h                           |  38 +++----
 include/net/udp_tunnel.h                      |   3 +-
 net/bridge/Kconfig                            |   1 -
 net/bridge/br_arp_nd_proxy.c                  |   3 +-
 net/bridge/br_netfilter_hooks.c               |  12 +--
 net/bridge/br_netfilter_ipv6.c                |   7 +-
 net/core/dev.c                                |   3 -
 net/core/filter.c                             |  68 +++++-------
 net/core/hotdata.c                            |   1 -
 net/core/lwt_bpf.c                            |  10 +-
 net/core/neighbour.c                          |   1 -
 net/ipv4/Kconfig                              |   9 +-
 net/ipv4/fib_semantics.c                      |  11 +-
 net/ipv4/icmp.c                               |   2 +-
 net/ipv4/inet_connection_sock.c               |   2 -
 net/ipv4/inet_hashtables.c                    |   5 -
 net/ipv4/inetpeer.c                           |   4 -
 net/ipv4/metrics.c                            |   1 -
 net/ipv4/nexthop.c                            |  26 ++---
 net/ipv4/ping.c                               |  16 ---
 net/ipv4/route.c                              |   2 +-
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
 net/ipv6/addrconf.c                           |  10 +-
 net/ipv6/addrconf_core.c                      |  91 ----------------
 net/ipv6/af_inet6.c                           |  67 +-----------
 net/ipv6/icmp.c                               |   6 --
 net/ipv6/ip6_fib.c                            |  10 +-
 net/ipv6/ip6_icmp.c                           |  46 +-------
 net/ipv6/ip6_offload.c                        |   4 +-
 net/ipv6/ip6_output.c                         |   9 +-
 net/ipv6/ip6_udp_tunnel.c                     |   3 +-
 net/ipv6/ndisc.c                              |  35 +++---
 net/ipv6/netfilter.c                          |  48 ---------
 net/ipv6/route.c                              |  18 ++--
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
 116 files changed, 322 insertions(+), 1416 deletions(-)
 delete mode 100644 include/net/ipv6_stubs.h

-- 
2.53.0


