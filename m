Return-Path: <netdev+bounces-224274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C030B83661
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0819541BC6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F110F2DF717;
	Thu, 18 Sep 2025 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDraqIwb"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CA257839;
	Thu, 18 Sep 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182181; cv=none; b=JapED/Fg4c1LDcuT0vFrE8yrB/J87AK1AZ38EXhuIZiW6oEmJrYd1g8BlND94u5iZkvDP5470FIa2T3/gvQO8yx2DXq8Qv3kaqraaz19qMG4ZHTxpquXDx2LVp7QvMW1c+DcamBEPZy0E7hrMhhMuJocL58LMwumpfyfFyvSMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182181; c=relaxed/simple;
	bh=uSAoYEa5vURTdDpkdObQtAd9aCWTnzJfGsYg6n+H7Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvTbC2EZQbM3S1gjB3s9IXb5GG0vP1NxeqeCRq2xIykoOjMMmmLciEsouSEbE0Y6gz3omYbFK6q4N8QBN5onxOM0smuwi3rPkzhdhr5BN1GgW7C/A67jxBtHqrEBNqx06KOJ/3GLC5Hl7lhVmiYo7bKYchwtVekqq5iSBxFCHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CDraqIwb; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F00EEC021B;
	Thu, 18 Sep 2025 03:56:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 18 Sep 2025 03:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758182178; x=1758268578; bh=G82LiYudmKV8yMFIaNNf+OsFpW+izJcMRlW
	h8GNT/cw=; b=CDraqIwb2L0d3S+MRIGhDMUdBDxnG49DNVYwZqk4AbyXv537p9y
	YNHvlKAlzVdcpMq6z2f2WJHJb/mrGHGDnnAzTnJBgaEgd0GHBCMA4cZBoxb3YTmL
	8XSIaeivcHoIMdkn1unD7dOiUNFMYif5XSQR/4CBGz8bli2kXSRn5mBDomdPmG1L
	UBPnuj8WdZ3eNYyyHZ1npgrW/PicTnj4KLD4w9hSfyz1VUZrUMKZOZ8X/IJUfuef
	iVTHAC1ELMabQ4nE0lSy6E14aoJKmeSPK36aPMwyerxmhfBoRZzPabJybBC002lC
	h5W48ZhpGvuBF9xh52h9djoA5X5N5Ikk0WQ==
X-ME-Sender: <xms:IrvLaKF4iYE9tVnX3v1FC8UX6N85Sm0DrpvfpxYLvQVh1asZG62q4A>
    <xme:IrvLaItrFRBbLW0H1PO6ApSUjBWnkkl6oMtemIp_S4rukLYApjkqKR6vRns-Am2mu
    5if9NEfIbcWE6c>
X-ME-Received: <xmr:IrvLaNq8U4im9hXrZO0PyjzrlrsyGvGatFkyEx4pvuqbw0sgfsttxEjFB719SPnovxuga46hkENgaV8LU1438xrIFO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejgedtjedttdelvdffteeuleekkeejheduheeuffeukefhkeevjeeuheeiueetuden
    ucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhdpghhoohhglh
    gvrghpihhsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepud
    dtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshiiisghothdoieehleeihedu
    ieguugdvsgeifeehsggrvdefhedtsehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrih
    hlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgt
    phhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvg
    hnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:IrvLaPUGxvW11A0m2C19j3bPwhMBJjJLo-1DlyA3dgatQiH4FjW_aw>
    <xmx:IrvLaF2a5dE153Y_QT5egk4oHUGpPGXRxHgkJpFyU3cVxbL0aZxUXQ>
    <xmx:IrvLaEuLfJIv1OoculLU3Co6OdGbaWKMVTE9mqkQ_M9O_IC-5m7N_Q>
    <xmx:IrvLaNWDNa4YhRl0PEhQl3BibLfyBGLpxzcAgWosX9O_k1ZrB7E8Rw>
    <xmx:IrvLaK2MwrsoqqpNmEcRebjpUurvNp4Mb3oVen5NYihWcGv9wJuJF8uC>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 03:56:17 -0400 (EDT)
Date: Thu, 18 Sep 2025 10:56:15 +0300
From: Ido Schimmel <idosch@idosch.org>
To: syzbot <syzbot+6596516dd2b635ba2350@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] general protection fault in find_match (6)
Message-ID: <aMu7Hw-lJeFPEEUI@shredder>
References: <68c9a4d2.050a0220.3c6139.0e63.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c9a4d2.050a0220.3c6139.0e63.GAE@google.com>

On Tue, Sep 16, 2025 at 10:56:34AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e2291551827f Merge tag 'probes-fixes-v6.16-rc6' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=126aad8c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
> dashboard link: https://syzkaller.appspot.com/bug?extid=6596516dd2b635ba2350
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1091958c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c89382580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-e2291551.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8873881d7728/vmlinux-e2291551.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c85b06341ad0/bzImage-e2291551.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/6dce6e633409/mount_8.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17c3e7d4580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6596516dd2b635ba2350@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000018: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
> CPU: 0 UID: 0 PID: 3043 Comm: kworker/u4:11 Not tainted 6.16.0-rc6-syzkaller-00037-ge2291551827f #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: ipv6_addrconf addrconf_dad_work
> RIP: 0010:__in6_dev_get include/net/addrconf.h:347 [inline]

Problem is that FDB nexthops can end up in non-FDB nexthop groups and
FDB nexthops are not associated with a nexthop device.

The kernel rejects such configurations upon addition:

# ip nexthop add id 1 via 192.0.2.1 fdb
# ip nexthop add id 2 group 1
Error: Non FDB nexthop group cannot have fdb nexthops.

But not upon replacement:

# ip nexthop add id 1 blackhole
# ip nexthop add id 2 group 1
# ip nexthop replace id 1 via 192.0.2.1 fdb
# ip nexthop
id 1 via 192.0.2.1 scope link fdb
id 2 group 1

I will try to send a fix later today.

> RIP: 0010:ip6_ignore_linkdown include/net/addrconf.h:443 [inline]
> RIP: 0010:find_match+0xa3/0xc90 net/ipv6/route.c:781
> Code: 00 00 00 00 00 fc ff df 42 80 7c 25 00 00 74 08 48 89 df e8 cf c4 fc f7 48 89 d8 bb c0 00 00 00 48 03 18 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 ae c4 fc f7 48 8b 1b e8 f6 60 48
> RSP: 0018:ffffc9000d5ce430 EFLAGS: 00010206
> RAX: 0000000000000018 RBX: 00000000000000c0 RCX: 0000000000000000
> RDX: ffff88803f90c880 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 1ffff1100b37b324 R08: ffffc9000d5ce7c0 R09: ffffc9000d5ce7d0
> R10: ffffc9000d5ce620 R11: ffffffff8a26ecd0 R12: dffffc0000000000
> R13: 0000000000000002 R14: 1ffff1100b37b326 R15: ffff888059bd9937
> FS:  0000000000000000(0000) GS:ffff88808d21b000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd76fadfd8 CR3: 000000000df38000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  rt6_nh_find_match+0xd9/0x150 net/ipv6/route.c:821
>  nexthop_for_each_fib6_nh+0x1cd/0x400 net/ipv4/nexthop.c:1516
>  __find_rr_leaf+0x461/0x6d0 net/ipv6/route.c:862
>  find_rr_leaf net/ipv6/route.c:890 [inline]
>  rt6_select net/ipv6/route.c:934 [inline]
>  fib6_table_lookup+0x39f/0xa80 net/ipv6/route.c:2232
>  ip6_pol_route+0x222/0x1180 net/ipv6/route.c:2268
>  pol_lookup_func include/net/ip6_fib.h:617 [inline]
>  fib6_rule_lookup+0x348/0x6f0 net/ipv6/fib6_rules.c:125
>  ip6_route_output_flags_noref net/ipv6/route.c:2683 [inline]
>  ip6_route_output_flags+0x364/0x5d0 net/ipv6/route.c:2695
>  ip6_route_output include/net/ip6_route.h:93 [inline]
>  ip6_dst_lookup_tail+0x1ae/0x1510 net/ipv6/ip6_output.c:1128
>  ip6_dst_lookup_flow+0x47/0xe0 net/ipv6/ip6_output.c:1259
>  udp_tunnel6_dst_lookup+0x231/0x3c0 net/ipv6/ip6_udp_tunnel.c:165
>  geneve6_xmit_skb drivers/net/geneve.c:957 [inline]
>  geneve_xmit+0xd2e/0x2b70 drivers/net/geneve.c:1043
>  __netdev_start_xmit include/linux/netdevice.h:5215 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5224 [inline]
>  xmit_one net/core/dev.c:3830 [inline]
>  dev_hard_start_xmit+0x2d4/0x830 net/core/dev.c:3846
>  __dev_queue_xmit+0x1adf/0x3a70 net/core/dev.c:4713
>  dev_queue_xmit include/linux/netdevice.h:3355 [inline]
>  neigh_hh_output include/net/neighbour.h:523 [inline]
>  neigh_output include/net/neighbour.h:537 [inline]
>  ip6_finish_output2+0x11bc/0x16a0 net/ipv6/ip6_output.c:141
>  __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
>  ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
>  NF_HOOK+0x9e/0x380 include/linux/netfilter.h:317
>  mld_sendpack+0x800/0xd80 net/ipv6/mcast.c:1868
>  ipv6_mc_dad_complete+0x88/0x4b0 net/ipv6/mcast.c:2293
>  addrconf_dad_completed+0x6d5/0xd60 net/ipv6/addrconf.c:4339
>  addrconf_dad_work+0xc36/0x14b0 net/ipv6/addrconf.c:-1
>  process_one_work kernel/workqueue.c:3238 [inline]
>  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
>  kthread+0x70e/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>

