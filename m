Return-Path: <netdev+bounces-299898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f2b2J3hyMWpSjgUAu9opvQ
	(envelope-from <netdev+bounces-299898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:57:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F0969190E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:57:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=NF6pKf+J;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299898-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299898-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24BE13032F4E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020E844E027;
	Tue, 16 Jun 2026 15:55:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FAC44D6AB
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:55:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625331; cv=pass; b=ipg27BhkvAFarNIFbBdhbwH+Gr8xQVeLjL2EQZV1lZFORFEU8Te/N7uw9zpTp4aNm1Azw+HbgFMYHNaiJfp72KTDJkXm3FQHlG1D4bx0TOo3MbgPP8pPbfqj03v7Ju7zd3drGBu5qYGaHxTJUu2RdHSv3+APeg6foe403DQSd9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625331; c=relaxed/simple;
	bh=tPtC+rAwCZ/eZGbidheKhCgDS7b3brCaUtC6E/55rIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iqr7SHKrw0lcSoDU+IW7vN+QxcmRSB7GJiDvj22KiYzgXDGJRxiq8QlH/D3cpkhsXNh2SwlkvUlPTaE1bj1K10zXgQs2p+bwRDVFSd5KimzpHCEsyWtMNXKib9v5b1A9NChLX1hfXBvyD26nhCZ6BXJiEmh5SfEv/DZFfu/V8fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NF6pKf+J; arc=pass smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5176bbb9384so52109031cf.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 08:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781625329; cv=none;
        d=google.com; s=arc-20240605;
        b=CNnp11fQHKtQ/na3DKmTQenZsFStegpyEujSJLKY4ULB9I9LQdqv04Cd3YsoARpo47
         RjjRw67vJ80vJzPvhj8iD0OuTj8GVllij20h8PPSHCGS/K+T1XgAwpz6O/oLCfncFt5n
         MDBVYfCM06KpJVB3BDv2h6LGMG+VIbqTfXSWBxnwaUHLYysRlmoMiKmzJbEl+gJ7SLtB
         CWZJMD9pNOh/c2ZhkFD5FkjkncP73BSy6zqmpSAFj8qj9WScLYKGm2Gr3RR47z3XEfVy
         LhxSoq39/0GJvUOygtPacXK+z1w+S+lv/6//BUA5W2mcUoDL9xSLFVXNj4hiAT+xnmKd
         T5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QwBYhoeA7+6K8c91ii8BFi9ciwbcuwTvQG0skksIRzs=;
        fh=1ZcrK03cZnUuddBFcYNF4NWltlHrj5BlwZ760eswbg4=;
        b=WT/H1VvmSAp2H4oYGOsKdjnsOzOtJvXQcw7jNhYpHX2NYbHNO88Bj3EKJu/04VMC1p
         oFANgYapaKyKgTkbLYruJhOs4kUYuXmo1SpN6wRPOq3sGElDsXe+05wOxwwBN31sUUk4
         MobVJGGoLUbpGHnPRanS8i2XjEcuITGqloM4KVfvQg97/NvysK8E2fF4cWZn4QsUBK6L
         N+hIdIRD7NjlYCEmZE6sJsBktqs6csyMOKbUSRkhgd22Sbh/s45hvTCXibYfjS3BsJaY
         GbFVZfkf4vAMWIbR7a9r5SLWlAag0BZstRz2msk2UXUyOKYSlgKv/V81zcRaYdBfS4BY
         n/OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781625329; x=1782230129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwBYhoeA7+6K8c91ii8BFi9ciwbcuwTvQG0skksIRzs=;
        b=NF6pKf+J+SK808Sdq+vxJovrXhxBerM+Kzh90ir3F+DpQbDaktJ0nhiHL2Cw5C1Q6c
         /R3XgIwOYZXTXPCvrjsL79CXcR2fMXRC4D04MMydS5z7jjbXREWUheGYVxq6FknKPf9V
         lo5O/CS95pKXzLhHVz69tfHtZ476kgV8pIA9KBIv6bGVerJYLXfWd2BNKAxIckoADboR
         eCBrJVYdy1+XYjc7r1wyFX64Nq6pqJABZOGpLN6qY33sVTGvJQYGUozdKvigwWvV4fFb
         0W217QMy7lzdLUCfYqMFDycBz/Y/RhLZlT+XGVafl2d+pma0J3L+SZtZGBm6CnYpiXo9
         bSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625329; x=1782230129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QwBYhoeA7+6K8c91ii8BFi9ciwbcuwTvQG0skksIRzs=;
        b=fezZylTz/9IsyHw55UxoYvQ5OQT0JHXKmNcwQ06nxAsRVBmjUoK0WEFN58AB1Yi0cr
         G7hNQrVmGdGMd6OPf0RFIkGu/0oPuzxaYJ0O8/kYFHdrIgVaFnvCIGx3f/iSdtSTBwff
         kwmyclRww+3OI6cHtqtmG0kTQmrpJs/Q4MKCv9IMFAsxFBjiKZ+eOZ295NnGtKBVSt0A
         +Fw412MUs14RXmIzEgsFlX9ZDHRoba8Mx1891Lu7Np9j42riTvvVbgvabV1QWJHVU46e
         S16Aje+66QiWfIhBeuClEHHLk5LfRhe5J8//6RItzue6SXYzybJBHhISwLQT+qScuRjx
         rawQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jJ3+LnprumYljjrz1wLvGeh0MuE8iHLoUwXZ7S+yJLSQZDq6yAyp2e6d2nLmvP18siG6rTX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDegkxSwYQ1hoCNp5rGHdpccQsK2cwNtHQco7o1KxX4VULwO6h
	QHxwsRApbHXDSYMYoByjVvluQAVKpvOJohM3fR/2cGAfw8xHRRfuoW8/ewsnvpvinCeKSrFi2/d
	RvpLqAVXC1TaS0atG3Laq2vpfjo1t2lgQF0jroWjh
X-Gm-Gg: Acq92OEdnH3OC8X2bpLRkximPUTUoAmrHeuVO4b9YRel45/v8Xh+jNDN7SwxHLOEXvL
	H+bG2pdxJQHfzamHncaZgwQu0AceCnh6N4EOVDqswX3U2QNbtI/BPPRf3pH3sLiBQFMopzLfr07
	2ZZiaD86diQFgGs96M9JGJoSoUXAzxMAYYXXXPVpHBM/cO4CHGpx5/ICdV15/rlngFt1DIojYxB
	LENPu9hqPmVZhkHIIqUuuVEPu49W2IJN0f7JIovnd+13GU4cvt5r9677a0IHVG///IeL3739wd0
	h2B/576V5g1N/g4ESxKvedhfoYGsb16cgIP1t4mwIccWVKO2gfpHxOdsTtvzOQOrqdtoHQ7527f
	KiTrjeWWpoBUbntkvL1oZa9yKDfXv
X-Received: by 2002:a05:622a:8d03:b0:517:5bc1:e1f5 with SMTP id
 d75a77b69052e-519a861024cmr2534771cf.0.1781625328417; Tue, 16 Jun 2026
 08:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a315824.b0403584.28d0ff.0000.GAE@google.com> <20260616153110.GA876739@shredder>
In-Reply-To: <20260616153110.GA876739@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jun 2026 08:55:16 -0700
X-Gm-Features: AVVi8Cfs0mbFCdaV0EvY_8f2yx4sjIwJSydPZYHOM4k_b7_5b72s2_UI7rLQCp0
Message-ID: <CANn89iJ7S1op9FJeaEqdR0KDiPu08PbFP7CqJ8NLVRgcPt370A@mail.gmail.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in fib_rules_lookup
To: Ido Schimmel <idosch@nvidia.com>
Cc: syzbot <syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com>, 
	kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a0842261b62cdea8];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,goo.gl:url,vger.kernel.org:from_smtp,googlegroups.com:email,mail.gmail.com:mid,appspotmail.com:email,syzkaller.appspot.com:url];
	TAGGED_FROM(0.00)[bounces-299898-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com,m:kuniyu@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev,965506b59a2de0b6905c];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01F0969190E

On Tue, Jun 16, 2026 at 8:31=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Tue, Jun 16, 2026 at 07:05:24AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    72dfa4700f78 net: dsa: sja1105: fix lastused timestamp =
in ..
>
> This includes commit 759923cf03b0 ("ipv4: fib: Convert
> fib_net_exit_batch() to ->exit_rtnl().") that moved ip_fib_net_exit()
> (and therefore fib4_rules_exit()) earlier in the netns dismantle path.
>
> Kuniyuki, can you please take a look?
>
> You can use this to reproduce:
>
> #!/bin/bash
>
> while true; do
>         ip netns add ns1
>         ip -n ns1 link set dev lo up
>         ip -n ns1 address add 192.0.2.1/24 dev lo
>         ip -n ns1 link add name dummy1 up type dummy
>         ip -n ns1 address add 198.51.100.1/24 dev dummy1
>         ip -n ns1 rule add ipproto tcp sport 12345 table 12345
>         ip -n ns1 fou add port 5555 ipproto 47 local 192.0.2.1 peer 198.5=
1.100.2 peer_port 54321
>         ip netns del ns1
> done
>

Oh right.

While looking at this syzbot report I also found an old issue.

https://lore.kernel.org/netdev/20260616141317.407791-1-edumazet@google.com/=
T/#u

I guess adding some delays in enqueue_to_backlog() could trigger a
similar bug even if we revert Kuniyuki's patch.




> Thanks
>
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15794bd2580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da0842261b62=
cdea8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D965506b59a2de=
0b6905c
> > compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5=
db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/d4e16f50a97c/d=
isk-72dfa470.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6cd4a736e796/vmli=
nux-72dfa470.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/548b0011c8e8=
/bzImage-72dfa470.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com
> >
> > bond0 (unregistering): Released all slaves
> > bond1 (unregistering): Released all slaves
> > bond2 (unregistering): (slave dummy0): Releasing active interface
> > bond2 (unregistering): Released all slaves
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in fib_rules_lookup+0x15e/0xeb0 net/cor=
e/fib_rules.c:321
> > Read of size 8 at addr ffff88804ec4c680 by task kworker/u8:21/12641
> >
> > CPU: 0 UID: 0 PID: 12641 Comm: kworker/u8:21 Not tainted syzkaller #0 P=
REEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 05/09/2026
> > Workqueue: netns cleanup_net
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
> >  print_address_description+0x55/0x1e0 mm/kasan/report.c:378
> >  print_report+0x58/0x70 mm/kasan/report.c:482
> >  kasan_report+0x117/0x150 mm/kasan/report.c:595
> >  fib_rules_lookup+0x15e/0xeb0 net/core/fib_rules.c:321
> >  __fib_lookup+0x106/0x210 net/ipv4/fib_rules.c:96
> >  ip_route_output_key_hash_rcu+0x294/0x2720 net/ipv4/route.c:2811
> >  ip_route_output_key_hash+0x18d/0x2a0 net/ipv4/route.c:2702
> >  __ip_route_output_key include/net/route.h:169 [inline]
> >  ip_route_output_flow+0x2a/0x150 net/ipv4/route.c:2929
> >  ip4_datagram_release_cb+0x89d/0xbe0 net/ipv4/datagram.c:118
> >  release_sock+0x206/0x260 net/core/sock.c:3861
> >  inet_shutdown+0x2b1/0x390 net/ipv4/af_inet.c:950
> >  udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
> >  fou_release net/ipv4/fou_core.c:562 [inline]
> >  fou_exit_net+0x17d/0x1f0 net/ipv4/fou_core.c:1230
> >  ops_exit_list net/core/net_namespace.c:199 [inline]
> >  ops_undo_list+0x43d/0x8d0 net/core/net_namespace.c:252
> >  cleanup_net+0x572/0x810 net/core/net_namespace.c:702
> >  process_one_work kernel/workqueue.c:3314 [inline]
> >  process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
> >  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3478
> >  kthread+0x389/0x470 kernel/kthread.c:436
> >  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >  </TASK>
> >
> > Allocated by task 19121:
> >  kasan_save_stack mm/kasan/common.c:57 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
> >  poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
> >  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
> >  kasan_kmalloc include/linux/kasan.h:263 [inline]
> >  __do_kmalloc_node mm/slub.c:5296 [inline]
> >  __kmalloc_node_track_caller_noprof+0x4d7/0x7b0 mm/slub.c:5408
> >  kmemdup_noprof+0x2b/0x70 mm/util.c:138
> >  kmemdup_noprof include/linux/fortify-string.h:763 [inline]
> >  fib_rules_register+0x2f/0x400 net/core/fib_rules.c:170
> >  fib4_rules_init+0x21/0x160 net/ipv4/fib_rules.c:508
> >  ip_fib_net_init net/ipv4/fib_frontend.c:1578 [inline]
> >  fib_net_init+0x17a/0x3e0 net/ipv4/fib_frontend.c:1628
> >  ops_init+0x35d/0x5d0 net/core/net_namespace.c:137
> >  setup_net+0x118/0x350 net/core/net_namespace.c:446
> >  copy_net_ns+0x4f9/0x720 net/core/net_namespace.c:579
> >  create_new_namespaces+0x3f0/0x6b0 kernel/nsproxy.c:132
> >  unshare_nsproxy_namespaces+0x149/0x190 kernel/nsproxy.c:234
> >  ksys_unshare+0x57d/0xa00 kernel/fork.c:3242
> >  __do_sys_unshare kernel/fork.c:3316 [inline]
> >  __se_sys_unshare kernel/fork.c:3314 [inline]
> >  __x64_sys_unshare+0x38/0x50 kernel/fork.c:3314
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 12641:
> >  kasan_save_stack mm/kasan/common.c:57 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
> >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
> >  poison_slab_object mm/kasan/common.c:253 [inline]
> >  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
> >  kasan_slab_free include/linux/kasan.h:235 [inline]
> >  slab_free_hook mm/slub.c:2689 [inline]
> >  __rcu_free_sheaf_prepare+0x12d/0x2a0 mm/slub.c:2940
> >  rcu_free_sheaf+0x31/0x200 mm/slub.c:5850
> >  rcu_do_batch kernel/rcu/tree.c:2617 [inline]
> >  rcu_core+0x78b/0x10a0 kernel/rcu/tree.c:2869
> >  handle_softirqs+0x225/0x840 kernel/softirq.c:622
> >  do_softirq+0x76/0xd0 kernel/softirq.c:523
> >  __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
> >  unregister_netdevice_many_notify+0x1874/0x2150 net/core/dev.c:12445
> >  ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
> >  ops_undo_list+0x391/0x8d0 net/core/net_namespace.c:248
> >  cleanup_net+0x572/0x810 net/core/net_namespace.c:702
> >  process_one_work kernel/workqueue.c:3314 [inline]
> >  process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
> >  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3478
> >  kthread+0x389/0x470 kernel/kthread.c:436
> >  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >
> > The buggy address belongs to the object at ffff88804ec4c600
> >  which belongs to the cache kmalloc-192 of size 192
> > The buggy address is located 128 bytes inside of
> >  freed 192-byte region [ffff88804ec4c600, ffff88804ec4c6c0)
> >
> > The buggy address belongs to the physical page:
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4e=
c4c
> > flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > page_type: f5(slab)
> > raw: 00fff00000000000 ffff88813fe163c0 dead000000000100 dead00000000012=
2
> > raw: 0000000000000000 0000000800100010 00000000f5000000 000000000000000=
0
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc=
0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1=
3856, tgid 13853 (syz.3.2144), ts 351172300879, free_ts 351133053454
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x22d/0x280 mm/page_alloc.c:1853
> >  prep_new_page mm/page_alloc.c:1861 [inline]
> >  get_page_from_freelist+0x24ae/0x2530 mm/page_alloc.c:3941
> >  __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5221
> >  alloc_slab_page mm/slub.c:3278 [inline]
> >  allocate_slab+0x77/0x660 mm/slub.c:3467
> >  new_slab mm/slub.c:3525 [inline]
> >  refill_objects+0x336/0x3d0 mm/slub.c:7272
> >  refill_sheaf mm/slub.c:2816 [inline]
> >  __pcs_replace_empty_main+0x320/0x720 mm/slub.c:4652
> >  alloc_from_pcs mm/slub.c:4750 [inline]
> >  slab_alloc_node mm/slub.c:4884 [inline]
> >  __do_kmalloc_node mm/slub.c:5295 [inline]
> >  __kmalloc_noprof+0x464/0x750 mm/slub.c:5308
> >  kmalloc_noprof include/linux/slab.h:954 [inline]
> >  kzalloc_noprof include/linux/slab.h:1188 [inline]
> >  new_dir fs/proc/proc_sysctl.c:966 [inline]
> >  get_subdir fs/proc/proc_sysctl.c:1010 [inline]
> >  sysctl_mkdir_p fs/proc/proc_sysctl.c:1320 [inline]
> >  __register_sysctl_table+0xc02/0x1370 fs/proc/proc_sysctl.c:1395
> >  neigh_sysctl_register+0x9b1/0xa90 net/core/neighbour.c:3915
> >  addrconf_sysctl_register+0xb3/0x1c0 net/ipv6/addrconf.c:7396
> >  ipv6_add_dev+0xd26/0x13a0 net/ipv6/addrconf.c:460
> >  addrconf_notify+0x771/0x1050 net/ipv6/addrconf.c:3679
> >  notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
> >  call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2302 [inline]
> >  register_netdevice+0x18db/0x1f00 net/core/dev.c:11474
> >  macsec_newlink+0x706/0x1200 drivers/net/macsec.c:4218
> >  rtnl_newlink_create+0x310/0xb00 net/core/rtnetlink.c:3905
> > page last free pid 12657 tgid 12657 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  __free_pages_prepare mm/page_alloc.c:1397 [inline]
> >  __free_frozen_pages+0xc0d/0xd20 mm/page_alloc.c:2938
> >  __tlb_remove_table_free mm/mmu_gather.c:228 [inline]
> >  tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:291
> >  rcu_do_batch kernel/rcu/tree.c:2617 [inline]
> >  rcu_core+0x78b/0x10a0 kernel/rcu/tree.c:2869
> >  handle_softirqs+0x225/0x840 kernel/softirq.c:622
> >  __do_softirq kernel/softirq.c:656 [inline]
> >  invoke_softirq kernel/softirq.c:496 [inline]
> >  __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
> >  irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
> >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [in=
line]
> >  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1061
> >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentr=
y.h:697
> >
> > Memory state around the buggy address:
> >  ffff88804ec4c580: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff88804ec4c600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >ffff88804ec4c680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> >                    ^
> >  ffff88804ec4c700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffff88804ec4c780: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup

