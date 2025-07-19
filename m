Return-Path: <netdev+bounces-208305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40121B0AD58
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 03:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A02B4E5482
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57592B9A7;
	Sat, 19 Jul 2025 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmpnNMn7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8C11CA0
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752888797; cv=none; b=tPByFlrODuNsbRCo03IsJKhc4l4VWVrOSn+9Tjr2dlSbK/rkMEj4o3TEdvBxKl16z6PoOUFz/+yDZauqAfDWaeKwnr1d0OAQ12hEY0vPCRa4QfD9i7nAG6KfO6kYE3YwjtICUZzrs9XTetpGbuxlR6yjkQ3+bvSz7Jb5mhQnM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752888797; c=relaxed/simple;
	bh=8YGvF6MaVdUFAmAFYFDFEPsYah1b9P7Fphg0oCVAtDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGuQy2UZuBQg1ei89CmWyaOvTzGz7/Zy6h7aBD+QS1eJ6QdsTqz1I+8pBHfMd9SVcWjxRwEJ51KXO2MCWKbuT5vf1+WopZMmVNbmv7MYT8f8QUfkf96K7zJNZw1Ev0oPRzfvl73BNODdtqRbqd11dCT2ANg6i8QxvjYDpOQZRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmpnNMn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52D3C4CEEB;
	Sat, 19 Jul 2025 01:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752888795;
	bh=8YGvF6MaVdUFAmAFYFDFEPsYah1b9P7Fphg0oCVAtDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fmpnNMn7unUh/Orza4YiDKQyXn/Dj8f6NSWxvo8Jk62t/attJslu0G15AVIz0O2Ap
	 lRoTbhCn1ZnUlAnHV7Q8YXlB5PYEeujcx+TfcmLEscD6Z5uBEsrL7RWriJ4eG62iLG
	 g7FaLJ6Cox2SjiM2lsgdNWqvioVelTHHMT1riIj6PGL+0JWd3pWbB1Uvj4vvYlRyBo
	 /6hbNav7Zf4MvgvflzRqD/+Nqgr974X5p05AbmhZiT7kGA5UJQvwq96LYykR8synaG
	 IwxAIe3Gx78wymKZyX+DeeX9dbHWz00Va7OH0t/7ceT5jDtzq9g9JfCMAKHuh4syh0
	 sSMZfEVssUe8A==
Date: Fri, 18 Jul 2025 18:33:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
 pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
 haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: Re: [PATCH net-next v6 7/7] bonding: Selftest and documentation for
 the arp_ip_target parameter.
Message-ID: <20250718183313.227c00f4@kernel.org>
In-Reply-To: <20250718212430.1968853-8-wilder@us.ibm.com>
References: <20250718212430.1968853-1-wilder@us.ibm.com>
	<20250718212430.1968853-8-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 14:23:43 -0700 David Wilder wrote:
> This selftest provided a functional test for the arp_ip_target parameter
> both with and without user supplied vlan tags.
> 
> and
> 

Looks like something ate part of the commit message?

> Updates to the bonding documentation.

This test seems to reliably trigger a crash in our CI. Not sure if
something is different in our build... or pebkac?

[   17.977269] RIP: 0010:bond_fill_info+0x21b/0x890
[   17.977325] Code: b3 38 0b 00 00 31 d2 41 8b 06 85 c0 0f 84 2a 06 00 00 89 44 24 0c 41 f6 46 10 02 74 5c 49 8b 4e 08 31 c0 ba 04 00 00 00 eb 16 <8b> 34 01 83 c2 04 89 74 04 10 48 83 c0 04 66 83 7c 01 fc ff 74 3e
[   17.977478] RSP: 0018:ffffa4be0062f6f8 EFLAGS: 00010297
[   17.977524] RAX: 0000000000000000 RBX: ffff8e0906064000 RCX: 00ff8e0902fd5180
[   17.977616] RDX: 0000000000000004 RSI: 0000000000000000 RDI: ffff8e0903655298
[   17.977682] RBP: ffff8e090321f900 R08: 0000000000000064 R09: 0000000000000000
[   17.977747] R10: ffff8e0903655298 R11: fefefefefefefeff R12: ffff8e0903655294
[   17.977807] R13: 0000000000000000 R14: ffff8e0906064b38 R15: ffff8e0903655248
[   17.977872] FS:  00007fd944f5c800(0000) GS:ffff8e0997f78000(0000) knlGS:0000000000000000
[   17.977945] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.978001] CR2: 00007fd9451ad430 CR3: 0000000006e04004 CR4: 0000000000772ef0
[   17.978062] PKRU: 55555554
[   17.978087] Call Trace:
[   17.978110]  <TASK>
[   17.978136]  ? dev_get_stats+0x6c/0x330
[   17.978174]  ? nla_reserve+0x53/0x80
[   17.978218]  rtnl_fill_ifinfo.constprop.0+0xa4d/0x1560
[   17.978272]  ? __alloc_skb+0x86/0x1a0
[   17.978306]  ? kmalloc_reserve+0x61/0xf0
[   17.978343]  ? kmalloc_reserve+0x61/0xf0
[   17.978379]  rtmsg_ifinfo_build_skb+0xa9/0x120
[   17.978427]  rtmsg_ifinfo+0x3c/0x90
[   17.978463]  __dev_notify_flags+0xb4/0xf0
[   17.978499]  ? queue_delayed_work_on+0x58/0x60
[   17.978553]  rtnl_configure_link+0x88/0xb0
[   17.978591]  rtnl_newlink+0x568/0xc10
[   17.978628]  ? __pfx_rtnl_newlink+0x10/0x10
[   17.978664]  rtnetlink_rcv_msg+0x362/0x410
[   17.978692]  ? timerqueue_add+0x6a/0xc0
[   17.978731]  ? timerqueue_del+0x2e/0x50
[   17.978765]  ? __remove_hrtimer+0x39/0x90
[   17.978804]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   17.978856]  netlink_rcv_skb+0x57/0x110
[   17.978893]  netlink_unicast+0x25c/0x380
[   17.978928]  ? __alloc_skb+0xdb/0x1a0
[   17.978964]  netlink_sendmsg+0x1be/0x3e0
[   17.978995]  ____sys_sendmsg+0x2bd/0x320
[   17.979037]  ? copy_msghdr_from_user+0x6c/0xa0
[   17.979085]  ___sys_sendmsg+0x87/0xd0
[   17.979121]  ? __handle_mm_fault+0xa3f/0xe50
[   17.979168]  __sys_sendmsg+0x71/0xd0
[   17.979203]  do_syscall_64+0xa4/0x270
[   17.979243]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   17.979287] RIP: 0033:0x7fd9451291e7
[   17.979326] Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[   17.979475] RSP: 002b:00007ffe3779d578 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   17.979546] RAX: ffffffffffffffda RBX: 00007ffe3779dcb0 RCX: 00007fd9451291e7
[   17.979621] RDX: 0000000000000000 RSI: 00007ffe3779d5e0 RDI: 0000000000000005
[   17.979696] RBP: 0000000000000006 R08: 0000000000000058 R09: 0000000000000000
[   17.979766] R10: 00007fd9450216f8 R11: 0000000000000246 R12: 00007ffe3779dcc8
[   17.979832] R13: 00000000687ae66c R14: 0000000000499600 R15: 00007ffe3779d6c8
[   17.979899]  </TASK>
[   17.979923] Modules linked in: [last unloaded: netdevsim]
[   17.979986] ---[ end trace 0000000000000000 ]---
[   17.980033] RIP: 0010:bond_fill_info+0x21b/0x890
[   17.980086] Code: b3 38 0b 00 00 31 d2 41 8b 06 85 c0 0f 84 2a 06 00 00 89 44 24 0c 41 f6 46 10 02 74 5c 49 8b 4e 08 31 c0 ba 04 00 00 00 eb 16 <8b> 34 01 83 c2 04 89 74 04 10 48 83 c0 04 66 83 7c 01 fc ff 74 3e
[   17.980238] RSP: 0018:ffffa4be0062f6f8 EFLAGS: 00010297
[   17.980278] RAX: 0000000000000000 RBX: ffff8e0906064000 RCX: 00ff8e0902fd5180
[   17.980346] RDX: 0000000000000004 RSI: 0000000000000000 RDI: ffff8e0903655298
[   17.980411] RBP: ffff8e090321f900 R08: 0000000000000064 R09: 0000000000000000
[   17.980479] R10: ffff8e0903655298 R11: fefefefefefefeff R12: ffff8e0903655294
[   17.980542] R13: 0000000000000000 R14: ffff8e0906064b38 R15: ffff8e0903655248
[   17.980605] FS:  00007fd944f5c800(0000) GS:ffff8e0997f78000(0000) knlGS:0000000000000000
[   17.980674] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.980740] CR2: 00007fd9451ad430 CR3: 0000000006e04004 CR4: 0000000000772ef0
[   17.980808] PKRU: 55555554
[   17.981702] ip (1285) used greatest stack depth: 11664 bytes left
-- 
pw-bot: cr

