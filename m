Return-Path: <netdev+bounces-149607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD359E6717
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FAC1885713
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB0E1C3054;
	Fri,  6 Dec 2024 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VT6JuvuT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D46198840
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464756; cv=none; b=OmveNogLP1MzxSfqb3uWib7ebXsbnQk9B2Wii0WEIikHoDdFnOLj8DDW+iSQ5h2ZPbnZWentw64vV5E6JmMaY+mw8VJ72FkmALHugFvudkxR8iHAII63iVfIJFaxI+cz3hMnt82U8G8MmuFs7LIKXK3Ruc5gbT3WVzOisTPcO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464756; c=relaxed/simple;
	bh=L3azQ1TwxVAYqqTw1AiavRz3AXFUJV/NkBotLlHpI00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiH7Sck6aO0NRP0eWWNzVWXm9ufQBRbkQHHD6dRTSWR4K47dM3RcH4jPTEIhjzxLYPM6Jr6qEG/GFMvgEg5TFnb6j2yajphPthjrWyoBOUj+00Lmo3uJz1XzU3RpizX2uPDlWwzyYQsFfxt7WsVuEUFQ6e39fI/mP/UZAKQc+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VT6JuvuT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733464754; x=1765000754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=L3azQ1TwxVAYqqTw1AiavRz3AXFUJV/NkBotLlHpI00=;
  b=VT6JuvuTuZ0kdTAZJg5zayuRh5bnVnyEw6OzlSn4JxHmhqJKCdGTFADM
   JZF3WwN8QV5wKdoq5dOHcpOIxbMSAthkcjqfENEENAoPLSx3Is2JcaY+e
   ZXH55JkH0AmJreqgWuB9Y1yLK1EnfmqVTjC0k+fquz0FA+O0GwXcDss9n
   zH75mqhNeDTIiI6Nx2RyAPze7PDNHYDaIYIDeOsiu60jTBTXTGZrfePm8
   loTYrmUsr29Wy+8Fsw70iLKH1gMWpuJbn1M/iFPJ11t643AnvsPbDhiqX
   RnmUKq3IGoeDwXYO4VqxEvYbuzbzCOsgUAj1OnOm8EheEJitI5zsEzNNY
   g==;
X-CSE-ConnectionGUID: s8mw38edTKSc0VJ7YXVx0w==
X-CSE-MsgGUID: Ky8VAeILRPm5vVdeX83NhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33956323"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="33956323"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 21:59:14 -0800
X-CSE-ConnectionGUID: sRIXAHKUSeOBNGlO8xeldA==
X-CSE-MsgGUID: lZTexBfsSLCawPeCZpVANw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="94187399"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 21:59:11 -0800
Date: Fri, 6 Dec 2024 13:58:39 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>, sashal@kernel.org
Subject: Re: [PATCH net] ipmr: fix build with clang and DEBUG_NET disabled.
Message-ID: <Z1KSj7i8S1+2ZrSi@ly-workstation>
References: <ee75faa926b2446b8302ee5fc30e129d2df73b90.1732810228.git.pabeni@redhat.com>
 <Z1FGZtZMg3hYpqvx@ly-workstation>
 <CANn89iLxUA5Td3TviC_VzN_grzwAPRrfOO7tY0v+c4661XiM-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLxUA5Td3TviC_VzN_grzwAPRrfOO7tY0v+c4661XiM-w@mail.gmail.com>

On Thu, Dec 05, 2024 at 07:47:03AM +0100, Eric Dumazet wrote:
> On Thu, Dec 5, 2024 at 7:22 AM Lai, Yi <yi1.lai@linux.intel.com> wrote:
> >
> > On Thu, Nov 28, 2024 at 05:18:04PM +0100, Paolo Abeni wrote:
> > > Sasha reported a build issue in ipmr::
> > >
> > > net/ipv4/ipmr.c:320:13: error: function 'ipmr_can_free_table' is not \
> > >       needed and will not be emitted \
> > >       [-Werror,-Wunneeded-internal-declaration]
> > >    320 | static bool ipmr_can_free_table(struct net *net)
> > >
> > > Apparently clang is too smart with BUILD_BUG_ON_INVALID(), let's
> > > fallback to a plain WARN_ON_ONCE().
> > >
> > > Reported-by: Sasha Levin <sashal@kernel.org>
> > > Closes: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25635-g6813e2326f1e/testrun/26111580/suite/build/test/clang-nightly-lkftconfig/details/
> > > Fixes: 11b6e701bce9 ("ipmr: add debug check for mr table cleanup")
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > >  net/ipv4/ipmr.c  | 2 +-
> > >  net/ipv6/ip6mr.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> > > index 383ea8b91cc7..c5b8ec5c0a8c 100644
> > > --- a/net/ipv4/ipmr.c
> > > +++ b/net/ipv4/ipmr.c
> > > @@ -437,7 +437,7 @@ static void ipmr_free_table(struct mr_table *mrt)
> > >  {
> > >       struct net *net = read_pnet(&mrt->net);
> > >
> > > -     DEBUG_NET_WARN_ON_ONCE(!ipmr_can_free_table(net));
> > > +     WARN_ON_ONCE(!ipmr_can_free_table(net));
> > >
> > >       timer_shutdown_sync(&mrt->ipmr_expire_timer);
> > >       mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
> > > diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> > > index 4147890fe98f..7f1902ac3586 100644
> > > --- a/net/ipv6/ip6mr.c
> > > +++ b/net/ipv6/ip6mr.c
> > > @@ -416,7 +416,7 @@ static void ip6mr_free_table(struct mr_table *mrt)
> > >  {
> > >       struct net *net = read_pnet(&mrt->net);
> > >
> > > -     DEBUG_NET_WARN_ON_ONCE(!ip6mr_can_free_table(net));
> > > +     WARN_ON_ONCE(!ip6mr_can_free_table(net));
> > >
> > >       timer_shutdown_sync(&mrt->ipmr_expire_timer);
> > >       mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
> > > --
> > > 2.45.2
> > >
> >
> > Hi Paolo Abeni,
> >
> > Greetings!
> >
> > I used Syzkaller and found that there is WARNING in ip6mr_free_table in linux v6.13-rc1.
> >
> > After bisection and the first bad commit is:
> > "
> > f6d7695b5ae22092fa2cc42529bb7462f7e0c4ad ipmr: fix build with clang and DEBUG_NET disabled
> > "
> >
> > Please help take a look if the WARNING is triggerd expectedly. I hope following records can be insightful for you.
> >
> 
> Hi there
> 
> Probably fixed already in net tree with :
> 
> 50b94204446e1215af081fd713d7d566d9258e35 ipmr: tune the
> ipmr_can_free_table() checks.
> 
> Thank you
>

Thanks for the info. I have tried net-next latest main branch
1daa6591ab7d (HEAD -> main, origin/main, origin/HEAD) Merge branch
'net_sched-sch_sfq-reject-limit-of-1'.

The WARNING in ip6mr_free_table is fixed. However, the WARNING in
ipmr_rules_exit can still be observed.

[   47.037578] ------------[ cut here ]------------
[   47.038326] WARNING: CPU: 0 PID: 840 at net/ipv4/ipmr.c:440 ipmr_rules_exit+0x14b/0x1d0
[   47.039574] Modules linked in:
[   47.040005] CPU: 0 UID: 0 PID: 840 Comm: repro Not tainted 6.13.0-rc1net-tree+ #1
[   47.040959] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/4
[   47.042538] RIP: 0010:ipmr_rules_exit+0x14b/0x1d0
[   47.043182] Code: df 48 c1 ea 03 80 3c 02 00 75 7b 48 c7 83 08 08 00 00 00 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc 6
[   47.045522] RSP: 0000:ffff888030057bc0 EFLAGS: 00010293
[   47.046207] RAX: 0000000000000000 RBX: ffff888013fbb880 RCX: ffffffff853c08db
[   47.047216] RDX: ffff88803016abc0 RSI: ffffffff853c094b RDI: 0000000000000005
[   47.048140] RBP: ffff888030057be8 R08: 0000000000000000 R09: ffffed10027f7738
[   47.049064] R10: 0000000000000001 R11: 0000000000000001 R12: ffff888030722000
[   47.049985] R13: 0000000000000001 R14: ffff888013fbc088 R15: ffff888013fbb880
[   47.050940] FS:  00007facb93cd640(0000) GS:ffff88806c400000(0000) knlGS:0000000000000000
[   47.051979] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   47.052729] CR2: 00007f897b683e80 CR3: 000000001439a005 CR4: 0000000000770ef0
[   47.053652] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   47.054594] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   47.055516] PKRU: 55555554
[   47.055883] Call Trace:
[   47.056217]  <TASK>
[   47.056533]  ? show_regs+0x6d/0x80
[   47.057020]  ? __warn+0xf3/0x390
[   47.057485]  ? report_bug+0x25e/0x4b0
[   47.058006]  ? ipmr_rules_exit+0x14b/0x1d0
[   47.058600]  ? report_bug+0x2cb/0x4b0
[   47.059133]  ? ipmr_rules_exit+0x14b/0x1d0
[   47.059711]  ? ipmr_rules_exit+0x14c/0x1d0
[   47.060291]  ? handle_bug+0xf1/0x190
[   47.060788]  ? exc_invalid_op+0x3c/0x80
[   47.061310]  ? asm_exc_invalid_op+0x1f/0x30
[   47.061900]  ? ipmr_rules_exit+0xdb/0x1d0
[   47.062508]  ? ipmr_rules_exit+0x14b/0x1d0
[   47.063080]  ? ipmr_rules_exit+0x14b/0x1d0
[   47.063668]  ipmr_net_exit_batch+0x5d/0xb0
[   47.064232]  ? __pfx_ipmr_net_exit_batch+0x10/0x10
[   47.064888]  ? __pfx_ipmr_net_exit+0x10/0x10
[   47.065479]  ops_exit_list+0x132/0x190
[   47.066005]  setup_net+0x502/0x840
[   47.066521]  ? __pfx_setup_net+0x10/0x10
[   47.067065]  ? __pfx_down_read_killable+0x10/0x10
[   47.067715]  ? __mutex_init+0xfd/0x140
[   47.068271]  copy_net_ns+0x2bb/0x6e0
[   47.068802]  create_new_namespaces+0x403/0xb40
[   47.069452]  unshare_nsproxy_namespaces+0xca/0x200
[   47.070090]  ksys_unshare+0x482/0xae0
[   47.070622]  ? __pfx_ksys_unshare+0x10/0x10
[   47.071197]  ? __audit_syscall_entry+0x39c/0x500
[   47.071840]  __x64_sys_unshare+0x3a/0x50
[   47.072376]  x64_sys_call+0xd3e/0x2140
[   47.072886]  do_syscall_64+0x6d/0x140
[   47.073383]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   47.074053] RIP: 0033:0x7facb903ee5d
[   47.074574] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 8
[   47.076927] RSP: 002b:00007facb93ccca8 EFLAGS: 00000297 ORIG_RAX: 0000000000000110
[   47.077913] RAX: ffffffffffffffda RBX: 00007facb93cd640 RCX: 00007facb903ee5d
[   47.078856] RDX: 00007facb903ee5d RSI: 0000000000000000 RDI: 0000000064040280
[   47.079781] RBP: 00007facb93ccd60 R08: 0000000100000001 R09: 0000000000000000
[   47.080702] R10: 0000000100000001 R11: 0000000000000297 R12: 00007facb93cd640
[   47.081622] R13: 0000000000000006 R14: 00007facb909f560 R15: 0000000000000000
[   47.082618]  </TASK>
[   47.082934] irq event stamp: 56841
[   47.083403] hardirqs last  enabled at (56849): [<ffffffff814606d5>] __up_console_sem+0x95/0xb0
[   47.084546] hardirqs last disabled at (56856): [<ffffffff814606ba>] __up_console_sem+0x7a/0xb0
[   47.085688] softirqs last  enabled at (56588): [<ffffffff8128c01e>] __irq_exit_rcu+0x10e/0x170
[   47.086857] softirqs last disabled at (56571): [<ffffffff8128c01e>] __irq_exit_rcu+0x10e/0x170
[   47.087967] ---[ end trace 0000000000000000 ]---

Is this expected?

> > All detailed into can be found at:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241204_202439_ip6mr_free_table
> > Syzkaller repro code:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241204_202439_ip6mr_free_table/repro.c
> > Syzkaller repro syscall steps:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241204_202439_ip6mr_free_table/repro.prog
> > Syzkaller report:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241204_202439_ip6mr_free_table/repro.report
> > Kconfig(make olddefconfig):
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241204_202439_ip6mr_free_table/kconfig_origin
> > Bisect info:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/241204_202439_ip6mr_free_table/bisect_info.log
> > bzImage:
> > https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241204_202439_ip6mr_free_table/bzImage_2b2d5f55fa44b37555edcdbbaf3acdb821e456a5
> > Issue dmesg:
> > https://github.com/laifryiee/syzkaller_logs/blob/main/241204_202439_ip6mr_free_table/2b2d5f55fa44b37555edcdbbaf3acdb821e456a5_dmesg.log
> >
> > "
> > [  106.095480] ------------[ cut here ]------------
> > [  106.096382] WARNING: CPU: 1 PID: 682 at net/ipv6/ip6mr.c:419 ip6mr_free_table+0xc6/0x130
> > [  106.098015] Modules linked in:
> > [  106.098454] CPU: 1 UID: 0 PID: 682 Comm: repro Not tainted 6.12.0+ #1
> > [  106.099311] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/4
> > [  106.100953] RIP: 0010:ip6mr_free_table+0xc6/0x130
> > [  106.101605] Code: 40 0d 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 5e 48 83 bb 40 0d 00 00 f
> > [  106.104018] RSP: 0018:ffff88801743fb88 EFLAGS: 00010293
> > [  106.104940] RAX: 0000000000000000 RBX: ffff88802d009c40 RCX: ffffffff8558ee4f
> > [  106.105887] RDX: ffff888021640000 RSI: ffffffff8558ee86 RDI: ffff88802d00a980
> > [  106.106817] RBP: ffff88801743fba0 R08: 0000000000000000 R09: ffffed1005a013b0
> > [  106.107758] R10: 0000000000000001 R11: 0000000000000001 R12: ffff888010796000
> > [  106.108813] R13: 0000000000000001 R14: dead000000000100 R15: dffffc0000000000
> > [  106.109755] FS:  00007ff3dcab1640(0000) GS:ffff88806c500000(0000) knlGS:0000000000000000
> > [  106.110877] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  106.111660] CR2: 00007f8030792008 CR3: 00000000215c2006 CR4: 0000000000770ef0
> > [  106.112614] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  106.113549] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  106.114482] PKRU: 55555554
> > [  106.114856] Call Trace:
> > [  106.115201]  <TASK>
> > [  106.115502]  ? show_regs+0x6d/0x80
> > [  106.115996]  ? __warn+0xf3/0x380
> > [  106.116499]  ? report_bug+0x25e/0x4b0
> > [  106.117014]  ? ip6mr_free_table+0xc6/0x130
> > [  106.117652]  ? report_bug+0x2cb/0x4b0
> > [  106.118211]  ? ip6mr_free_table+0xc6/0x130
> > [  106.118784]  ? ip6mr_free_table+0xc7/0x130
> > [  106.119362]  ? handle_bug+0xf1/0x190
> > [  106.119890]  ? exc_invalid_op+0x3c/0x80
> > [  106.120461]  ? asm_exc_invalid_op+0x1f/0x30
> > [  106.121089]  ? ip6mr_free_table+0x8f/0x130
> > [  106.121706]  ? ip6mr_free_table+0xc6/0x130
> > [  106.122336]  ? ip6mr_free_table+0xc6/0x130
> > [  106.122919]  ? ip6mr_free_table+0xc6/0x130
> > [  106.123499]  ip6mr_rules_exit+0x12a/0x260
> > [  106.124076]  ip6mr_net_exit_batch+0x5d/0xb0
> > [  106.124677]  ? __pfx_ip6mr_net_exit_batch+0x10/0x10
> > [  106.125382]  ? __pfx_ip6mr_net_exit+0x10/0x10
> > [  106.126033]  ops_exit_list+0x132/0x190
> > [  106.126619]  setup_net+0x502/0x840
> > [  106.127143]  ? __pfx_setup_net+0x10/0x10
> > [  106.127725]  ? __pfx_down_read_killable+0x10/0x10
> > [  106.128444]  ? __mutex_init+0xfd/0x140
> > [  106.129024]  copy_net_ns+0x2bb/0x6e0
> > [  106.129537]  create_new_namespaces+0x403/0xb40
> > [  106.130171]  unshare_nsproxy_namespaces+0xca/0x200
> > [  106.130858]  ksys_unshare+0x482/0xae0
> > [  106.131439]  ? __pfx_ksys_unshare+0x10/0x10
> > [  106.132113]  ? __audit_syscall_entry+0x39c/0x500
> > [  106.132827]  __x64_sys_unshare+0x3a/0x50
> > [  106.133432]  x64_sys_call+0xd3e/0x2140
> > [  106.134007]  do_syscall_64+0x6d/0x140
> > [  106.134574]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  106.135333] RIP: 0033:0x7ff3dc83ee5d
> > [  106.135873] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 8
> > [  106.138484] RSP: 002b:00007ff3dcab0ca8 EFLAGS: 00000297 ORIG_RAX: 0000000000000110
> > [  106.139569] RAX: ffffffffffffffda RBX: 00007ff3dcab1640 RCX: 00007ff3dc83ee5d
> > [  106.140603] RDX: 00007ff3dc83ee5d RSI: 0000000000000000 RDI: 0000000064040280
> > [  106.141608] RBP: 00007ff3dcab0d60 R08: 0000000100000001 R09: 0000000000000000
> > [  106.142538] R10: 0000000100000001 R11: 0000000000000297 R12: 00007ff3dcab1640
> > [  106.143474] R13: 0000000000000006 R14: 00007ff3dc89f560 R15: 0000000000000000
> > [  106.144466]  </TASK>
> > [  106.144784] irq event stamp: 50463
> > [  106.145252] hardirqs last  enabled at (50471): [<ffffffff814615c5>] __up_console_sem+0x95/0xb0
> > [  106.146386] hardirqs last disabled at (50478): [<ffffffff814615aa>] __up_console_sem+0x7a/0xb0
> > [  106.147514] softirqs last  enabled at (50120): [<ffffffff8128cc8e>] __irq_exit_rcu+0x10e/0x170
> > [  106.148727] softirqs last disabled at (50107): [<ffffffff8128cc8e>] __irq_exit_rcu+0x10e/0x170
> > [  106.149948] ---[ end trace 0000000000000000 ]---
> > [  106.158499] ------------[ cut here ]------------
> > [  106.159167] WARNING: CPU: 1 PID: 682 at net/ipv4/ipmr.c:440 ipmr_rules_exit+0x14b/0x1d0
> > [  106.160449] Modules linked in:
> > [  106.160933] CPU: 1 UID: 0 PID: 682 Comm: repro Tainted: G        W          6.12.0+ #1
> > [  106.162053] Tainted: [W]=WARN
> > [  106.162492] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/4
> > [  106.164206] RIP: 0010:ipmr_rules_exit+0x14b/0x1d0
> > [  106.164915] Code: df 48 c1 ea 03 80 3c 02 00 75 7b 48 c7 83 08 08 00 00 00 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc 6
> > [  106.167497] RSP: 0018:ffff88801743fbc0 EFLAGS: 00010293
> > [  106.168432] RAX: 0000000000000000 RBX: ffff88802d009c40 RCX: ffffffff85369a4b
> > [  106.169436] RDX: ffff888021640000 RSI: ffffffff85369abb RDI: 0000000000000005
> > [  106.170449] RBP: ffff88801743fbe8 R08: 0000000000000000 R09: ffffed1005a013b0
> > [  106.171462] R10: 0000000000000001 R11: 0000000000000001 R12: ffff888021756000
> > [  106.172592] R13: 0000000000000001 R14: ffff88802d00a448 R15: ffff88802d009c40
> > [  106.173605] FS:  00007ff3dcab1640(0000) GS:ffff88806c500000(0000) knlGS:0000000000000000
> > [  106.174742] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  106.175568] CR2: 00007f0c14691000 CR3: 00000000215c2006 CR4: 0000000000770ef0
> > [  106.176685] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  106.177702] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  106.178717] PKRU: 55555554
> > [  106.179131] Call Trace:
> > [  106.179469]  <TASK>
> > [  106.179770]  ? show_regs+0x6d/0x80
> > [  106.180294]  ? __warn+0xf3/0x380
> > [  106.180761]  ? report_bug+0x25e/0x4b0
> > [  106.181302]  ? ipmr_rules_exit+0x14b/0x1d0
> > [  106.181925]  ? report_bug+0x2cb/0x4b0
> > [  106.182491]  ? ipmr_rules_exit+0x14b/0x1d0
> > [  106.183111]  ? ipmr_rules_exit+0x14c/0x1d0
> > [  106.183726]  ? handle_bug+0xf1/0x190
> > [  106.184315]  ? exc_invalid_op+0x3c/0x80
> > [  106.184915]  ? asm_exc_invalid_op+0x1f/0x30
> > [  106.185567]  ? ipmr_rules_exit+0xdb/0x1d0
> > [  106.186177]  ? ipmr_rules_exit+0x14b/0x1d0
> > [  106.186793]  ? ipmr_rules_exit+0x14b/0x1d0
> > [  106.187429]  ipmr_net_exit_batch+0x5d/0xb0
> > [  106.188045]  ? __pfx_ipmr_net_exit_batch+0x10/0x10
> > [  106.188778]  ? __pfx_ipmr_net_exit+0x10/0x10
> > [  106.189423]  ops_exit_list+0x132/0x190
> > [  106.190020]  setup_net+0x502/0x840
> > [  106.190549]  ? __pfx_setup_net+0x10/0x10
> > [  106.191142]  ? __pfx_down_read_killable+0x10/0x10
> > [  106.191845]  ? __mutex_init+0xfd/0x140
> > [  106.192461]  copy_net_ns+0x2bb/0x6e0
> > [  106.193024]  create_new_namespaces+0x403/0xb40
> > [  106.193706]  unshare_nsproxy_namespaces+0xca/0x200
> > [  106.194427]  ksys_unshare+0x482/0xae0
> > [  106.195001]  ? __pfx_ksys_unshare+0x10/0x10
> > [  106.195648]  ? __audit_syscall_entry+0x39c/0x500
> > [  106.196384]  __x64_sys_unshare+0x3a/0x50
> > [  106.196988]  x64_sys_call+0xd3e/0x2140
> > [  106.197555]  do_syscall_64+0x6d/0x140
> > [  106.198120]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  106.198870] RIP: 0033:0x7ff3dc83ee5d
> > [  106.199409] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 8
> > [  106.202011] RSP: 002b:00007ff3dcab0ca8 EFLAGS: 00000297 ORIG_RAX: 0000000000000110
> > [  106.203093] RAX: ffffffffffffffda RBX: 00007ff3dcab1640 RCX: 00007ff3dc83ee5d
> > [  106.204126] RDX: 00007ff3dc83ee5d RSI: 0000000000000000 RDI: 0000000064040280
> > [  106.205144] RBP: 00007ff3dcab0d60 R08: 0000000100000001 R09: 0000000000000000
> > [  106.206160] R10: 0000000100000001 R11: 0000000000000297 R12: 00007ff3dcab1640
> > [  106.207175] R13: 0000000000000006 R14: 00007ff3dc89f560 R15: 0000000000000000
> > [  106.208253]  </TASK>
> > [  106.208592] irq event stamp: 51871
> > [  106.209097] hardirqs last  enabled at (51879): [<ffffffff814615c5>] __up_console_sem+0x95/0xb0
> > [  106.210317] hardirqs last disabled at (51886): [<ffffffff814615aa>] __up_console_sem+0x7a/0xb0
> > [  106.211536] softirqs last  enabled at (51802): [<ffffffff8128cc8e>] __irq_exit_rcu+0x10e/0x170
> > [  106.212814] softirqs last disabled at (51903): [<ffffffff8128cc8e>] __irq_exit_rcu+0x10e/0x170
> > [  106.213954] ---[ end trace 0000000000000000 ]---
> > "
> >
> > Regards,
> > Yi Lai
> >
> > ---
> >
> > If you don't need the following environment to reproduce the problem or if you
> > already have one reproduced environment, please ignore the following information.
> >
> > How to reproduce:
> > git clone https://gitlab.com/xupengfe/repro_vm_env.git
> > cd repro_vm_env
> > tar -xvf repro_vm_env.tar.gz
> > cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
> >   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
> >   // You could change the bzImage_xxx as you want
> >   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> > You could use below command to log in, there is no password for root.
> > ssh -p 10023 root@localhost
> >
> > After login vm(virtual machine) successfully, you could transfer reproduced
> > binary to the vm by below way, and reproduce the problem in vm:
> > gcc -pthread -o repro repro.c
> > scp -P 10023 repro root@localhost:/root/
> >
> > Get the bzImage for target kernel:
> > Please use target kconfig and copy it to kernel_src/.config
> > make olddefconfig
> > make -jx bzImage           //x should equal or less than cpu num your pc has
> >
> > Fill the bzImage file into above start3.sh to load the target kernel in vm.
> >
> >
> > Tips:
> > If you already have qemu-system-x86_64, please ignore below info.
> > If you want to install qemu v7.1.0 version:
> > git clone https://github.com/qemu/qemu.git
> > cd qemu
> > git checkout -f v7.1.0
> > mkdir build
> > cd build
> > yum install -y ninja-build.x86_64
> > yum -y install libslirp-devel.x86_64
> > ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> > make
> > make install

