Return-Path: <netdev+bounces-265347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBSxG3kurmlrAQIAu9opvQ
	(envelope-from <netdev+bounces-265347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 03:20:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB52332BA
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 03:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12FBF3006816
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 02:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12450221FBD;
	Mon,  9 Mar 2026 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zy5eeH5T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EERCUwHN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zy5eeH5T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EERCUwHN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64921FF2E
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022839; cv=none; b=t7QvQad/c+d/tVb/WMOfUBHKaEZg8tJ15NjMrjd7kbGOep+J6fzXZwQbCJopKl5i8CsHWhL3+MpFgnHSBX+W1xOHRs/JPcyHax/UQuy9e4HiTwdPQnC4+RFg0k3z4GuIICHD4V/Dsfpu9Xj+sv0Aq7s2YeRUQo4bhzx9M6aTeUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022839; c=relaxed/simple;
	bh=yXTpqqPQJ2i8OaHgl6gTB9NVfW9qpUHD+bFfIdxqk0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uud5UmpLeQwVvAXFUw7roDrt6Ul40DMZoh5KQSHpYU4xkJdetn2vnYDvQyzgFN8y7SnYmb9N5iEqX5t6NqB3QG8Xs6HE48n+iII0YI6/4BDxDzOP0K2SMxAcCp8EZgUmV5hkGWY2Xkp5noPEjKBzyAuuD9He47d++Gwvrk0VfL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zy5eeH5T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EERCUwHN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zy5eeH5T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EERCUwHN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B9AE4D1EE;
	Mon,  9 Mar 2026 02:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773022835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OHKN6mjsvqi3Ugc2QbjbqkqJ7lbb9J3vonLwLqMr4RA=;
	b=Zy5eeH5TjKVfqsFWTj7qOjNKBSHQIDuRHYZMCnLDilaXevAxVssstZhRqkV7WqhUTT8lfN
	KchzioQsUUcHrsAaT/gG9UwmqpVRAuTwSom6uh0w+nSvCEos3M+89gzn2EISjD/Xvc/zuC
	fqiCvVvNplzEGbUUeAxxibjEyEn2+Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773022835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OHKN6mjsvqi3Ugc2QbjbqkqJ7lbb9J3vonLwLqMr4RA=;
	b=EERCUwHNNtN9TYNZQAdrp/igzJ1RhL/NvlOwpwhUGOnPPfOB1rw3Y+K4CX3Wlr8ZgvID1a
	VfMHqeiTgJMZt9BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Zy5eeH5T;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EERCUwHN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773022835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OHKN6mjsvqi3Ugc2QbjbqkqJ7lbb9J3vonLwLqMr4RA=;
	b=Zy5eeH5TjKVfqsFWTj7qOjNKBSHQIDuRHYZMCnLDilaXevAxVssstZhRqkV7WqhUTT8lfN
	KchzioQsUUcHrsAaT/gG9UwmqpVRAuTwSom6uh0w+nSvCEos3M+89gzn2EISjD/Xvc/zuC
	fqiCvVvNplzEGbUUeAxxibjEyEn2+Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773022835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OHKN6mjsvqi3Ugc2QbjbqkqJ7lbb9J3vonLwLqMr4RA=;
	b=EERCUwHNNtN9TYNZQAdrp/igzJ1RhL/NvlOwpwhUGOnPPfOB1rw3Y+K4CX3Wlr8ZgvID1a
	VfMHqeiTgJMZt9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFB353EC6C;
	Mon,  9 Mar 2026 02:20:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ntIeN3Iurmk0MgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 09 Mar 2026 02:20:34 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH 00/10 net-next] Convert CONFIG_IPV6 to built-in and remove stubs
Date: Mon,  9 Mar 2026 03:19:33 +0100
Message-ID: <20260309022013.5199-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 16AB52332BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265347-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Historically, the Linux kernel has supported compiling the IPv6 stack as
a loadable module. While this made sense in the early days of IPv6
adoption, modern deployments and distributions overwhelmingly either
build IPv6 directly into the kernel (CONFIG_IPV6=y) or disable it
entirely (CONFIG_IPV6=n). The modular IPv6 use-case provides little to
no practical benefit today.

To allow core networking, BPF, Netfilter, and various device drivers to
safely interact with a potentially unloaded IPv6 module, the kernel
relies on indirect call structures like ipv6_stub, ipv6_bpf_stub, and
nf_ipv6_ops, along with dynamic RCU registrations for things like ICMPv6
senders.

This patch series addresses this by changing CONFIG_IPV6 from a tristate
to a boolean, enforcing that IPv6 is either built-in or disabled. This
allows us to completely rip out the stub infrastructures and safely
replace them with direct function calls.

All the patches has been independently build tested. With allmodconfig
and allmodconfig + CONFIG_IPV6=n. In addition, IPv6 core network
selftest has been run against them.

The series applied as a whole as been tested with allyesconfig and also
allyesconfig + CONFIG_IPV6=n but not all patches has been independently
tested this way.

This will like need to wait for [1] and [2] to be applied to avoid
conflicts from net tree and rebased in top of them.

[1] https://lore.kernel.org/netdev/20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com/

[2] https://lore.kernel.org/netdev/20260308032304.1841198-1-kuniyu@google.com/

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
 arch/m68k/configs/amiga_defconfig             |   2 +-
 arch/m68k/configs/apollo_defconfig            |   2 +-
 arch/m68k/configs/atari_defconfig             |   2 +-
 arch/m68k/configs/bvme6000_defconfig          |   2 +-
 arch/m68k/configs/hp300_defconfig             |   2 +-
 arch/m68k/configs/mac_defconfig               |   2 +-
 arch/m68k/configs/multi_defconfig             |   2 +-
 arch/m68k/configs/mvme147_defconfig           |   2 +-
 arch/m68k/configs/mvme16x_defconfig           |   2 +-
 arch/m68k/configs/q40_defconfig               |   2 +-
 arch/m68k/configs/sun3_defconfig              |   2 +-
 arch/m68k/configs/sun3x_defconfig             |   2 +-
 drivers/infiniband/Kconfig                    |   1 -
 drivers/infiniband/core/addr.c                |   3 +-
 drivers/infiniband/hw/ocrdma/Kconfig          |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.c           |   6 +-
 drivers/infiniband/ulp/ipoib/Kconfig          |   2 +-
 drivers/net/Kconfig                           |   9 --
 drivers/net/ethernet/broadcom/Kconfig         |   2 +-
 drivers/net/ethernet/chelsio/Kconfig          |   2 +-
 .../mellanox/mlx5/core/en/rep/neigh.c         |  11 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   |   3 +-
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |   2 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   1 -
 drivers/net/ethernet/mellanox/mlxsw/Kconfig   |   1 -
 .../ethernet/mellanox/mlxsw/spectrum_router.c |   8 +-
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |   2 +-
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
 drivers/net/vrf.c                             |   2 +-
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
 include/net/ip6_fib.h                         |  33 +++++-
 include/net/ip6_route.h                       |  25 +++++
 include/net/ipv6.h                            |  12 +++
 include/net/ipv6_stubs.h                      | 102 ------------------
 include/net/ndisc.h                           |  39 +++----
 include/net/udp_tunnel.h                      |   3 +-
 net/bridge/Kconfig                            |   1 -
 net/bridge/br_arp_nd_proxy.c                  |   3 +-
 net/bridge/br_netfilter_hooks.c               |  12 +--
 net/bridge/br_netfilter_ipv6.c                |   7 +-
 net/core/filter.c                             |  70 ++++++------
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
 net/ipv6/af_inet6.c                           |  69 ++----------
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
 103 files changed, 310 insertions(+), 795 deletions(-)
 delete mode 100644 include/net/ipv6_stubs.h

-- 
2.53.0


