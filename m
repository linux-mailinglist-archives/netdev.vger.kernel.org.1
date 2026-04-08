Return-Path: <netdev+bounces-276652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKA/OBWI1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:53:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1F73BF219
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1746B300878A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CCF386C13;
	Wed,  8 Apr 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DucWXcGV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6E8462
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666909; cv=none; b=ZGYoN/s5d+dwhqcHuXxQYikro4PZmyewOqruD2lKfNMq3OzpCtnL+ob0SIAHjcmJ8ki17r+zhlGXLksoTd0fNx68ndpWM9LbfGjm5E7/MCikbcYGfrRFtLQTPXKeWOd5aOFGCC7RG1brgFM3VC9pniQK72xL6OFVzNe64RKdOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666909; c=relaxed/simple;
	bh=uD5NEwxrq7psb5x97X3jooKTDUH4sGQxGSkXfvmRZso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGHi/Ms6utp+wqCbgrwPWNyhD82DxKl289ZI+KrnwXVdJZ6uU+9K3JdlweLl0iYmgpBczVnMER5z2wuYgOxfrkhx+Rng8FwLrh6Y3pa2ks8nA45gqL+adysMjJBNRcEtY58XmtIiKbgj6vp4Vs4Abc5xCR9crOkok8l7KykuOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DucWXcGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8504BC19421;
	Wed,  8 Apr 2026 16:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775666909;
	bh=uD5NEwxrq7psb5x97X3jooKTDUH4sGQxGSkXfvmRZso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DucWXcGVLvgjeGYP15Yek9Xmv3g0bxv+In7dJX6o3OR1T99U04BobEqtsn+KciFt8
	 YAaUGATwk9bhNJP4Box6KXfxIZmRaDrIhsMiz0TBP2A1YP0ho3VcEI4qfYWDgc58OX
	 mlbUwaVTAv6ta4MYhSoxCqFzqAZx4OX1zdF+YFvcJzBHOsLCmsXg5zHBFpl6JDERp5
	 sNTopEqWayWVb1EZn8F3nleO/HMBOMpte35eTqJcCTJzXW6FLehrpAdqU1WSMhet15
	 iHL27k+L9mUj0c+HNWGac6dzZJc+jXzopXjToiaNDbGxhfCmVi5bY+7HYkut+80rCQ
	 +wEiumjipWuGg==
Date: Wed, 8 Apr 2026 17:48:25 +0100
From: Simon Horman <horms@kernel.org>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	James Chapman <jchapman@katalix.com>, netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>,
	syzbot+ci3edea60a44225dec@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] l2tp: Drop large packets with UDP encap
Message-ID: <20260408164825.GH469338@kernel.org>
References: <20260403174949.843941-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403174949.843941-1-alice.kernel@fastmail.im>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276652-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[fastmail.im];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ci3edea60a44225dec];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,isovalent.com:email]
X-Rspamd-Queue-Id: 3B1F73BF219
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 08:49:49PM +0300, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> syzbot reported a WARN on my patch series [1]. The actual issue is an
> overflow of 16-bit UDP length field, and it exists in the upstream code.
> My series added a debug WARN with an overflow check that exposed the
> issue, that's why syzbot tripped on my patches, rather than on upstream
> code.
> 
> syzbot's repro:
> 
> # {"procs":1,"slowdown":1,"sandbox":"","sandbox_arg":0,"close_fds":false,"callcomments":true}
> r0 = socket$pppl2tp(0x18, 0x1, 0x1)
> r1 = socket$inet6_udp(0xa, 0x2, 0x0)
> connect$inet6(r1, &(0x7f00000000c0)={0xa, 0x0, 0x0, @loopback, 0xfffffffc}, 0x1c)
> connect$pppl2tp(r0, &(0x7f0000000240)=@pppol2tpin6={0x18, 0x1, {0x0, r1, 0x4, 0x0, 0x0, 0x0, {0xa, 0x4e22, 0xffff, @ipv4={'\x00', '\xff\xff', @empty}}}}, 0x32)
> writev(r0, &(0x7f0000000080)=[{&(0x7f0000000000)="ee", 0x34000}], 0x1)
> 
> It basically sends an oversized (0x34000 bytes) PPPoL2TP packet with UDP
> encapsulation, and l2tp_xmit_core doesn't check for overflows when it
> assigns the UDP length field. The value gets trimmed to 16 bites.
> 
> Add an overflow check that drops oversized packets and avoids sending
> packets with trimmed UDP length to the wire.
> 
> syzbot's stack trace (with my patch applied):
> 
> len >= 65536u
> WARNING: ./include/linux/udp.h:38 at udp_set_len_short include/linux/udp.h:38 [inline], CPU#1: syz.0.17/5957
> WARNING: ./include/linux/udp.h:38 at l2tp_xmit_core net/l2tp/l2tp_core.c:1293 [inline], CPU#1: syz.0.17/5957
> WARNING: ./include/linux/udp.h:38 at l2tp_xmit_skb+0x1204/0x18d0 net/l2tp/l2tp_core.c:1327, CPU#1: syz.0.17/5957
> Modules linked in:
> CPU: 1 UID: 0 PID: 5957 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:udp_set_len_short include/linux/udp.h:38 [inline]
> RIP: 0010:l2tp_xmit_core net/l2tp/l2tp_core.c:1293 [inline]
> RIP: 0010:l2tp_xmit_skb+0x1204/0x18d0 net/l2tp/l2tp_core.c:1327
> Code: 0f 0b 90 e9 21 f9 ff ff e8 e9 05 ec f6 90 0f 0b 90 e9 8d f9 ff ff e8 db 05 ec f6 90 0f 0b 90 e9 cc f9 ff ff e8 cd 05 ec f6 90 <0f> 0b 90 e9 de fa ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 4f
> RSP: 0018:ffffc90003d67878 EFLAGS: 00010293
> RAX: ffffffff8ad985e3 RBX: ffff8881a6400090 RCX: ffff8881697f0000
> RDX: 0000000000000000 RSI: 0000000000034010 RDI: 000000000000ffff
> RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
> R10: dffffc0000000000 R11: fffff520007acf00 R12: ffff8881baf20900
> R13: 0000000000034010 R14: ffff8881a640008e R15: ffff8881760f7000
> FS:  000055557e81f500(0000) GS:ffff8882a9467000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000033000 CR3: 00000001612f4000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  pppol2tp_sendmsg+0x40a/0x5f0 net/l2tp/l2tp_ppp.c:302
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg net/socket.c:742 [inline]
>  sock_write_iter+0x503/0x550 net/socket.c:1195
>  do_iter_readv_writev+0x619/0x8c0 fs/read_write.c:-1
>  vfs_writev+0x33c/0x990 fs/read_write.c:1059
>  do_writev+0x154/0x2e0 fs/read_write.c:1105
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f636479c629
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffffd4241c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> RAX: ffffffffffffffda RBX: 00007f6364a15fa0 RCX: 00007f636479c629
> RDX: 0000000000000001 RSI: 0000200000000080 RDI: 0000000000000003
> RBP: 00007f6364832b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f6364a15fac R14: 00007f6364a15fa0 R15: 00007f6364a15fa0
>  </TASK>
> 
> [1]: https://lore.kernel.org/all/20260226201600.222044-1-alice.kernel@fastmail.im/
> 
> Reported-by: syzbot+ci3edea60a44225dec@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69a1dfba.050a0220.3a55be.0026.GAE@google.com/

Hi Alice,

A Fixes tag needs to go here.
And if it's fixing code present in net - that is, the bug can manifest
there - then it should be targeted at net rather than net-next.

> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> ---
>  net/l2tp/l2tp_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index c89ae52764b8..157fc23ce4e1 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -1290,6 +1290,11 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
>  		uh->source = inet->inet_sport;
>  		uh->dest = inet->inet_dport;
>  		udp_len = uhlen + session->hdr_len + data_len;
> +		if (udp_len > U16_MAX) {
> +			kfree_skb(skb);
> +			ret = NET_XMIT_DROP;
> +			goto out_unlock;
> +		}

As a fix, this looks like the right approach.
But I do think this code could benefit from some goto labels
to handle unwinding error cases.

>  		uh->len = htons(udp_len);
>  
>  		/* Calculate UDP checksum if configured to do so */
> -- 
> 2.53.0
> 

