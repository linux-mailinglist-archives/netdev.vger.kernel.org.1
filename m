Return-Path: <netdev+bounces-192653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E34AC0AE8
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF301BC579C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104AE28A703;
	Thu, 22 May 2025 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Ol49exO8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pMSFP0TS"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30B28A1DC;
	Thu, 22 May 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747914902; cv=none; b=lzCvS1/NWzADigAJIfAxC+YWNmJ3Q8zgc+J99zAoXaia7dN5bhwBuYEcuxdrtMgZuQDAGqGAvSaWa/5ZVos+P1hsPLJKQJet2RrnlqjUCPswrWa2AXwgNoFXUn+KR+Dy7cMDubJ8irO/pNTG85Ey8zTsMqifjVWMRwlu5U6wzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747914902; c=relaxed/simple;
	bh=1oUAEHIBXvG86Y2/ajgNwtB/pPqecUR8H0IlQw9KriE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ml7RHi/fEH9mgA/9HOpJAvIH0nLctCmzW3ErJbZh4uQXW0deeJadTWsJE7b/ZGrmX88e3SMvLS4ICJu0ZJZdl/B/pvygto5sSzBEitoTT4ytYYUrYTm0vndK2fBsdVJSMgq1XNyRSDkId1pamMuex5s1q2km7nOTD14vFGDSZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Ol49exO8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pMSFP0TS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 514391380E24;
	Thu, 22 May 2025 07:54:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 22 May 2025 07:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1747914898; x=
	1748001298; bh=sT00/m+xL7PLDSZNZbFcPlDDH7hp7b4f1md34HqAqfk=; b=O
	l49exO8eFpMxzAiQzK+gUoo1WlbcGlmSC5gKOLCUZT+4RDMFZ9PlEHZJgcEwteqI
	8Bk9fyeqH4xDH3KJh5nOCNHDBEJqbYHiPuYpJuEtzLgxb++96C9LAJaArqdhUGne
	WQaWVwZo/J/Qyh6dwVMFNDnpAngE1pFmhFqKyzlk10qbwiXaABMsWQa/EKRrC9d3
	2b/BkmvrHFu21eiO5UO/NFBrxGFMaOUwWDPXMhQO+twJY8LYns1zz7qmJYMi6k7u
	wE4urf7nSnl72/W9bbbVCsvHqwIiLxJm0ntNlmqpiHQFxJI5lqz2EmNF0Q8dEtAg
	u+uRHdJm28LlT91Aa7amA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747914898; x=1748001298; bh=sT00/m+xL7PLDSZNZbFcPlDDH7hp7b4f1md
	34HqAqfk=; b=pMSFP0TSSZKxVhFn936/7H04PwDYj/J+rNUmyZd+S6PtOorWJdK
	Bc8T1qx95O0YFlOpWI4NZ+rmiBgGbedoi4odOOxGlY2hdDRob829hDvbue2Pgd4/
	cLp76phwmMI7/NyYVlSztKrZZSWubW/UNppeT9qPAgGb3DTr77QKuauOjraVaAgw
	mKcB49U7KWSNCERTCd94F4fo2ZNGWxv4VuyoWNxHaDucV78r+9glqoMyhAXq9F/r
	AS5szFsprP+WBhNIIxvLQVstA9sVh+lUbhjOrmcB3oXD3/aRnfRQ9BjayCAGoW5H
	XkBECTrHCvONmbrRRbZDd0RMGzXu3AunvZw==
X-ME-Sender: <xms:kRAvaH0aa2kSeVhNp71Rr3uQoPER5eHJm7f8oijk2yXQYwePumfUqw>
    <xme:kRAvaGGxmDWCLdRe6mQWKnw5kYme-Hgmc9aFSycLip8mph7ozUtgXDmj7OdxoOG1u
    tbXi5N7lIdFkhn5nBk>
X-ME-Received: <xmr:kRAvaH4ELZw8rgIXkAddFXs_vH_XPDV9EAkSVcBFk5n5FMa-LU_i0EyXTutTsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdehkeelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucgoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoe
    hsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepveekhffg
    tddvveejvedvgffffeeftedtfefhtdfgueetgeevuefftdffhfduhedvnecuffhomhgrih
    hnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhgohhoghhlvggrphhishdr
    tghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehshiiisghothdojegvugelugegjegvudehvg
    ekkeehkeduuggthegssehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhope
    gvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhgvrhgsvghrthes
    ghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopehhohhrmhhssehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:kRAvaM2JP55Mch0m1AdrWlyPu7_0hzBnFiJ3lhYVd4eBv8Cio2mYLQ>
    <xmx:kRAvaKGeG4J5yBgdsRH8Yd8vXX41KflM589tTPIaludz6JI76ZcBVQ>
    <xmx:kRAvaN_MmZELoB6pO9yuzL4eyyQ5sRdUoP6mZjud0rMFGhbLa2AWAg>
    <xmx:kRAvaHkmvt6WupqDNI2rid8oR8XUK3Mx0YQFB895p1qkGgk9jahzcQ>
    <xmx:khAvaPoa_8Q-G_kEYzZUKO0QmErXfiDLtzufhq1vF173IC4UFfMIH3SV>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 07:54:56 -0400 (EDT)
Date: Thu, 22 May 2025 13:54:55 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: syzbot <syzbot+7ed9d47e15e88581dc5b@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in xfrm_state_find (4)
Message-ID: <aC8Qj-_vg_WnXXsO@krikkit>
References: <682e2613.a00a0220.2a3337.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <682e2613.a00a0220.2a3337.0003.GAE@google.com>

2025-05-21, 12:14:27 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    172a9d94339c Merge tag '6.15-rc6-smb3-client-fixes' of git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b062d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=56e29fa09e87dea7
> dashboard link: https://syzkaller.appspot.com/bug?extid=7ed9d47e15e88581dc5b
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/da9615d2ee0b/disk-172a9d94.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/997b6c928374/vmlinux-172a9d94.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/30f01bdce820/bzImage-172a9d94.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7ed9d47e15e88581dc5b@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in xfrm_state_find+0x2423/0xaae0 net/xfrm/xfrm_state.c:1438

I was looking into possible uninitialized uses of state_ptrs a while
ago, this report probably is the same thing. I'll post the patch later
today.

>  xfrm_state_find+0x2423/0xaae0 net/xfrm/xfrm_state.c:1438
>  xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2519 [inline]
>  xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2570 [inline]
>  xfrm_resolve_and_create_bundle+0xabc/0x58b0 net/xfrm/xfrm_policy.c:2868
>  xfrm_lookup_with_ifid+0x48c/0x3ac0 net/xfrm/xfrm_policy.c:3202
>  xfrm_lookup net/xfrm/xfrm_policy.c:3333 [inline]
>  xfrm_lookup_route+0x63/0x2b0 net/xfrm/xfrm_policy.c:3344
>  ip_route_output_flow+0x20d/0x2b0 net/ipv4/route.c:2918
>  ip_route_connect include/net/route.h:352 [inline]
>  tcp_v4_connect+0xa43/0x1cd0 net/ipv4/tcp_ipv4.c:252
>  tcp_v6_connect+0x134a/0x1d40 net/ipv6/tcp_ipv6.c:240
>  __inet_stream_connect+0x2d3/0x1760 net/ipv4/af_inet.c:677
>  inet_stream_connect+0x69/0xd0 net/ipv4/af_inet.c:748
>  __sys_connect_file net/socket.c:2038 [inline]
>  __sys_connect+0x523/0x680 net/socket.c:2057
>  __do_sys_connect net/socket.c:2063 [inline]
>  __se_sys_connect net/socket.c:2060 [inline]
>  __x64_sys_connect+0x95/0x100 net/socket.c:2060
>  x64_sys_call+0x23bb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:43
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Local variable tmp.i.i created at:
>  xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2491 [inline]
>  xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2570 [inline]
>  xfrm_resolve_and_create_bundle+0x3a7/0x58b0 net/xfrm/xfrm_policy.c:2868
>  xfrm_lookup_with_ifid+0x48c/0x3ac0 net/xfrm/xfrm_policy.c:3202

-- 
Sabrina

