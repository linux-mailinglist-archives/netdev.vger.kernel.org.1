Return-Path: <netdev+bounces-265157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GKCJcterGl/pAEAu9opvQ
	(envelope-from <netdev+bounces-265157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 18:22:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF4322CECC
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 18:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC7B2300A533
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 17:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CD7310651;
	Sat,  7 Mar 2026 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEhUdOeb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E311E9B1A
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904137; cv=none; b=DLspQeeMLAaRecWPN9/gBbWy2cR+G/NmdN1XUZ0DobRThOJByjH5LCyTSRImo7aGA868GM9vsyv+eKjONb0FtA/64K5BAQhRyRxZakJgakTq5nldCSZqV3YrK08NrGXVCbISAmLW0pJQ2CfwqbxM/TKk2WeJ2cuASRZZkcHLsoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904137; c=relaxed/simple;
	bh=b6dFSBwjZmzAufzl6/7jamXsse0LiQu2zuQz7VC6jM8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A9zDt/kikU0usuPdtjnp8HbRfp5a1DY/zH8zJgm2J6SuavxOb2HfVHgbZXyNXiKCd/D+vNg/oYDzbDbvIflgNpoCG120RGFVPI0SoWU711ZMdBfnhBAAQyT37+/OmAmZ9PS/Y+pMtqyuJmcvU7WbWrkQbh3/CmKoe0gn5keOc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEhUdOeb; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c738a4231a2so1131972a12.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 09:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772904135; x=1773508935; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9APm84bWzD+gvTHG8pYZTCvzYx0lMSC2tah5Xx/NvoA=;
        b=UEhUdOebA4fnEAEQCtNPQBiDCbaYBdttIB/4qh81KPWDct6hqwL/b3LML+7bF3tKVf
         L/PLPc1SQMqYfdS8idb2zmyXgn1oiYO2EYuJCXLXIrLJeR3JOpxOb2EmPdjmSPtk/NMV
         wgV+Zfb2cvNnuTFdxoDZ++Yj8xFsX0EXCLn9OP2kOgoab0LtGs3VG/j21IN/HaS+OBwl
         zmiM7xYKd287aDoxXY2prqClHexQIzIIEdrWsl8AblEIaKlotgVXMRfCmo9bwg67F25E
         6Vws05pLfASK3OkWNC/Ti1dlFcfSznChAGS3UcYqb/ibeGCCvtMAnEDxeDiJ/fplANg2
         hZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772904135; x=1773508935;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9APm84bWzD+gvTHG8pYZTCvzYx0lMSC2tah5Xx/NvoA=;
        b=dVCsb6uJa7Nor6vroSREo11inRQuL0iS8R0P8dEkZON8pmDfeKYF4JMxF8a+y9wCnr
         D93NvQyWEUvgH/tHzuhUgQ/UYpaOa5NsDPkZVtdUIyG1nfyt1eyR6cZQ7aUM4gDT7v/x
         RF5OVKcOvt0S2kTaK+gn7x4/h1Vb7E7v3AVgoSgWwPUZz5wEBXqGQn6RGHEdeJBFiTp+
         g+iiOAXOLNmaq19gvts+dJAf+nczik9Hq1UePTOFYwruHzA0N2zV88sLBVI3gI+m1L6I
         bH9hcH9Ui15t2vzJJCVhyi+wg7H+PTjD3rqAdN3agmNdCkD9434LLoOyWypLfz68KQrI
         +U7g==
X-Forwarded-Encrypted: i=1; AJvYcCU9cMU36TvBE4pOnGcaa58Wfc7B+yGo2/wmRsmYgfJD/i8505e55Bi2TIC+xSPk/XHuhnvQejU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXaVCoi1sT2pxM5zS+TWlvb1VRzT+K5dyTtxku3mETVvRC7gx5
	lZ3iF2WRN8zJXsoEHYM6RKJeQp6EmLuKhlxwCHF1dfRGTvWxDj8UiHnW
X-Gm-Gg: ATEYQzzCA7/3LZbtfmrzfkMnS3FHt6yj4INgO9HKiy5hFKewoTHxWqNo1jBE0utsmbH
	Zxrf8VnieKzrXXwpVKnj4EU62PpdYAtWFYyo88gjLOpjNifm+9lJGgihwtdyNN9LobCIaKGbwVM
	YDyPkRq0vuA3hxSNymfC3yD5bBiYj22+Dgg1bbASzmdt5EbowaiVISmTJRjdP3NygzI8XWTTkfT
	eBNJ3c6kFoDzllFJrLU2qTDYEdd9wGjeEynI93LxyNy1y+O3KdrqEjsmVCkiHi3n9ShSNimv4I4
	GIpWDuwlhtaBNp4pS50KOS6yczXds16xwoap2nQyZJEb27uOLLNnRhjLABSaZ6qT9nRzObhRLAr
	odd9WxbkVGUGm8lOKNfp607+zODJGIHE2nO9MO85QWyTqmxj8NecVYETIXJfKQ1STbz611anGkA
	ljEmYlK3JeRhIxa0i3on68yy6v50XtZyj9wdaUmt7MBg==
X-Received: by 2002:a05:6300:6702:b0:398:7982:8208 with SMTP id adf61e73a8af0-39879828268mr1099309637.1.1772904135440;
        Sat, 07 Mar 2026 09:22:15 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e170ee4sm4789742a12.21.2026.03.07.09.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 09:22:15 -0800 (PST)
Date: Sun, 8 Mar 2026 02:22:11 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] netfilter: ctnetlink: validate CTA_EXPECT_NAT_DIR to
 prevent OOB access
Message-ID: <aaxew8enOWT853XV@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 3CF4322CECC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265157-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.944];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

ctnetlink_parse_expect_nat() assigns the user-supplied
CTA_EXPECT_NAT_DIR value directly to exp->dir without validating that it
is within the valid range (0 to IP_CT_DIR_MAX-1).  When
nf_nat_sip_expected() later uses exp->dir as an index into
ct->master->tuplehash[], an out-of-bounds array access occurs.

For example, with exp->dir = 100, the access at
ct->master->tuplehash[100] reads 5600 bytes past the start of a
320-byte nf_conn object, causing a slab-out-of-bounds read confirmed by
UBSAN.

Validate exp->dir against IP_CT_DIR_MAX before accepting it.

UBSAN report:

[    1.411419] UBSAN: array-index-out-of-bounds in net/netfilter/nf_nat_sip.c:361:31
[    1.412133] index 100 is out of range for type 'nf_conntrack_tuple_hash [2]'
[    1.412365] CPU: 0 UID: 0 PID: 131 Comm: poc_exp_dir Not tainted 7.0.0-rc2+ #8 PREEMPTLAZY
[    1.412368] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    1.412370] Call Trace:
[    1.412374]  <TASK>
[    1.412375]  dump_stack_lvl+0x64/0x80
[    1.412388]  __ubsan_handle_out_of_bounds+0xc9/0x100
[    1.412398]  nf_nat_sip_expected+0x4b9/0x4d0
[    1.412405]  ? __pfx_nf_nat_sip_expected+0x10/0x10
[    1.412406]  ? __asan_memset+0x23/0x50
[    1.412413]  ? nf_ct_ext_add+0x147/0x200
[    1.412418]  init_conntrack.isra.0+0x6c8/0x770
[    1.412422]  ? __pfx_init_conntrack.isra.0+0x10/0x10
[    1.412424]  ? hash_conntrack_raw+0xd9/0x170
[    1.412425]  ? crng_make_state+0x7b/0x180
[    1.412431]  nf_conntrack_in+0x583/0xac0
[    1.412433]  ? __pfx_nf_conntrack_in+0x10/0x10
[    1.412435]  ? __pfx_get_random_u32+0x10/0x10
[    1.412437]  ? __get_random_u32_below+0x16/0x70
[    1.412439]  ? __pfx_ipv4_conntrack_local+0x10/0x10
[    1.412441]  nf_hook_slow+0x75/0x150
[    1.412444]  __ip_local_out+0x20d/0x2f0
[    1.412449]  ? __pfx___ip_local_out+0x10/0x10
[    1.412451]  ? __pfx_dst_output+0x10/0x10
[    1.412453]  ? __pfx_ip_generic_getfrag+0x10/0x10
[    1.412454]  ? __pfx_ip_make_skb+0x10/0x10
[    1.412456]  ip_send_skb+0x31/0xe0
[    1.412457]  udp_send_skb+0x475/0x680
[    1.412464]  udp_sendmsg+0xbe9/0x1150
[    1.412467]  ? __pfx_ip_generic_getfrag+0x10/0x10
[    1.412468]  ? __pfx_udp_sendmsg+0x10/0x10
[    1.412470]  ? __pfx__raw_spin_lock+0x10/0x10
[    1.412475]  ? udp_lib_get_port+0x35b/0xaf0
[    1.412477]  ? __pfx_ip4_datagram_release_cb+0x10/0x10
[    1.412479]  ? __pfx_udp_lib_get_port+0x10/0x10
[    1.412481]  ? __pfx__raw_spin_lock_bh+0x10/0x10
[    1.412482]  ? aa_sk_perm+0x1a0/0x3f0
[    1.412489]  ? __check_object_size+0x4b/0x450
[    1.412493]  ? inet_send_prepare+0x33/0x140
[    1.412496]  __sys_sendto+0x2be/0x2e0
[    1.412500]  ? __pfx___sys_sendto+0x10/0x10
[    1.412502]  ? __pfx_inet_bind_sk+0x10/0x10
[    1.412504]  ? __sys_bind+0x168/0x1a0
[    1.412506]  ? __pfx_ksys_write+0x10/0x10
[    1.412509]  __x64_sys_sendto+0x76/0x90
[    1.412511]  do_syscall_64+0xc7/0x6c0
[    1.412514]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    1.412521] RIP: 0033:0x423de7
[    1.412525] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d 7d 12 09 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d d0
[    1.412526] RSP: 002b:00007ffeaf8f5098 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[    1.412531] RAX: ffffffffffffffda RBX: 00007ffeaf8f50c0 RCX: 0000000000423de7
[    1.412533] RDX: 0000000000000007 RSI: 0000000000488257 RDI: 0000000000000004
[    1.412534] RBP: 00007ffeaf8f50f0 R08: 00007ffeaf8f50c0 R09: 0000000000000010
[    1.412535] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffeaf8f5228
[    1.412535] R13: 00007ffeaf8f5238 R14: 00000000004af868 R15: 0000000000000001
[    1.412537]  </TASK>
[    1.412538] ---[ end trace ]---

Fixes: 076a0ca02644 ("netfilter: ctnetlink: add NAT support for expectations")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/netfilter/nf_conntrack_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index c9d725fc2d71..fac75128dfb9 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3497,6 +3497,8 @@ ctnetlink_parse_expect_nat(const struct nlattr *attr,
 	exp->saved_addr = nat_tuple.src.u3;
 	exp->saved_proto = nat_tuple.src.u;
 	exp->dir = ntohl(nla_get_be32(tb[CTA_EXPECT_NAT_DIR]));
+	if (exp->dir >= IP_CT_DIR_MAX)
+		return -EINVAL;
 
 	return 0;
 #else
-- 
2.43.0


