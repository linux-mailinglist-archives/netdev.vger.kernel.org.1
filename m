Return-Path: <netdev+bounces-175141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEF2A63753
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 21:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861DD7A6136
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 20:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCA218DB0C;
	Sun, 16 Mar 2025 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GQohJsO1"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A13153BE8
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742155753; cv=none; b=tiy1cJt0l8U8+W3/Qgkx3duyMsL7uPku93KnEpmSsVpJfwiyt9BRKJFhka9/U0nSFrwgLG0ZTVSIMtYBTou/mcU1ocM9/hqR/30sHXuMvO/XvRPwH8K0UQeNpieTiMHM0UAVG14vKOpYE8KYL3MpeJX6W9t73nn1qW+MiDAPDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742155753; c=relaxed/simple;
	bh=QyYE8MC+awhmnBBrOcT/c8PGT67jgrnjcBFJjPby+8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGbJMtF42tFgiwiohvPvrDgsi6T9oqeJ57qJhMeQLKth3hd0Mt7+80fITIr/MYTzH4bETqxdOs7h/6TNB2R5Qwcqw7vkgm2EdyTzbNinjOMKctoWxBFZif724+diI5cTVItSS1Er1OplKqBIxDk7F15NP0iFkJsS4r5hfColdt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GQohJsO1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 558BF25400B1;
	Sun, 16 Mar 2025 16:09:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 16 Mar 2025 16:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742155750; x=1742242150; bh=BIoNVnMM8sikv9aIRRLD96b8AYmUpy9St9o
	KK0m5ixM=; b=GQohJsO1d03mXt9sh2Itd1ep13D4Ohoei9pwnzNtfh/RUSYEK9U
	suskxlfSuhBHzGQdrKX9OJocQdDceMUKkHIGHAnnLO0XsGF65p8g/A5VeD2X6Wno
	7/f1fMZn1BBbgmDYUHj8oe99ZvY7Lg/LMKEUIpLHih3BSIhduj1p7jW+uaRxflEc
	V1qYXuy0p6pEmbhr+T51lvQLRFNEkcLMb7WHjLt5ntwALfN31tPwCLAq6CEz+Mpj
	c9MBNjPbNO7zaLPk0QAwNnZGU3nX56dL3soKZqwuAA2/5zHNsbdxjlz7F5Gca16O
	qIlE2kJapnhk2EyG7P1YZUvxZOeD2o60V4A==
X-ME-Sender: <xms:5S_XZ4k7Z4koVnSkCvSsYndAzP3LdNqar80XnM-e8d-f8NDJeMWwRw>
    <xme:5S_XZ32Lszj7HULLusuVz5meJ2P7fBEcHPZhYBOg_IHXuwpkKAaC19Z80P043F5KT
    fzvvOLGrc0u7Pk>
X-ME-Received: <xmr:5S_XZ2oKYWg9d6jlgg9hWoTz6fOSohxXv3haevzqugqL8CKmtaP5UtDXdTN2k6LhM4TV_NiIrsnpwLoirMozUvXwxmF4Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeu
    gfduffdvffdtfeehieejtdfhjeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgt
    hhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepkhhunhhihihusegrmhgriihonhdrtghomhdprhgtphhtthho
    pegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhoohhprgesnhhv
    ihguihgrrdgtohhmpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
    dprhgtphhtthhopeifihhllhgvmhgssehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:5S_XZ0kXSGt_-HdouXS-pPnD2ipExYIdTufTSa8aHrksbyELKK5LIQ>
    <xmx:5S_XZ21ELXSOAJMaMdKk_nqk0LrH3LqW69RT84Ynlo-4lM-76pb85w>
    <xmx:5S_XZ7usIj4Rmtu1-L41vmIncgHu8kCI5g6vIDrUSWyfwRDkGHsmzg>
    <xmx:5S_XZyUf9XQ_56iOGUhKRXbCYdg31JSM4aGHz05tKcfQrt-h89x6ZA>
    <xmx:5i_XZ_HHAbM112yAaHywgtfB7ZMO0u6Bo18Hfr6Muolu8dLon8KD6pGJ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 16:09:08 -0400 (EDT)
Date: Sun, 16 Mar 2025 22:09:05 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	bridge@lists.linux.dev, syzkaller <syzkaller@googlegroups.com>,
	yan kang <kangyan91@outlook.com>, yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH v2 net] net: Remove RTNL dance for SIOCBRADDIF and
 SIOCBRDELIF.
Message-ID: <Z9cv4XXz3pzL4qrp@shredder>
References: <20250316192851.19781-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316192851.19781-1-kuniyu@amazon.com>

On Sun, Mar 16, 2025 at 12:28:37PM -0700, Kuniyuki Iwashima wrote:
> SIOCBRDELIF is passed to dev_ioctl() first and later forwarded to
> br_ioctl_call(), which causes unnecessary RTNL dance and the splat
> below [0] under RTNL pressure.
> 
> Let's say Thread A is trying to detach a device from a bridge and
> Thread B is trying to remove the bridge.
> 
> In dev_ioctl(), Thread A bumps the bridge device's refcnt by
> netdev_hold() and releases RTNL because the following br_ioctl_call()
> also re-acquires RTNL.
> 
> In the race window, Thread B could acquire RTNL and try to remove
> the bridge device.  Then, rtnl_unlock() by Thread B will release RTNL
> and wait for netdev_put() by Thread A.
> 
> Thread A, however, must hold RTNL after the unlock in dev_ifsioc(),
> which may take long under RTNL pressure, resulting in the splat by
> Thread B.
> 
>   Thread A (SIOCBRDELIF)           Thread B (SIOCBRDELBR)
>   ----------------------           ----------------------
>   sock_ioctl                       sock_ioctl
>   `- sock_do_ioctl                 `- br_ioctl_call
>      `- dev_ioctl                     `- br_ioctl_stub
>         |- rtnl_lock                     |
>         |- dev_ifsioc                    '
>         '  |- dev = __dev_get_by_name(...)
>            |- netdev_hold(dev, ...)      .
>        /   |- rtnl_unlock  ------.       |
>        |   |- br_ioctl_call       `--->  |- rtnl_lock
>   Race |   |  `- br_ioctl_stub           |- br_del_bridge
>   Window   |     |                       |  |- dev = __dev_get_by_name(...)
>        |   |     |  May take long        |  `- br_dev_delete(dev, ...)
>        |   |     |  under RTNL pressure  |     `- unregister_netdevice_queue(dev, ...)
>        |   |     |               |       `- rtnl_unlock
>        \   |     |- rtnl_lock  <-'          `- netdev_run_todo
>            |     |- ...                        `- netdev_run_todo
>            |     `- rtnl_unlock                   |- __rtnl_unlock
>            |                                      |- netdev_wait_allrefs_any
>            |- netdev_put(dev, ...)  <----------------'
>                                                 Wait refcnt decrement
>                                                 and log splat below
> 
> To avoid blocking SIOCBRDELBR unnecessarily, let's not call
> dev_ioctl() for SIOCBRADDIF and SIOCBRDELIF.
> 
> In the dev_ioctl() path, we do the following:
> 
>   1. Copy struct ifreq by get_user_ifreq in sock_do_ioctl()
>   2. Check CAP_NET_ADMIN in dev_ioctl()
>   3. Call dev_load() in dev_ioctl()
>   4. Fetch the master dev from ifr.ifr_name in dev_ifsioc()
> 
> 3. can be done by request_module() in br_ioctl_call(), so we move
> 1., 2., and 4. to br_ioctl_stub().
> 
> Note that 2. is also checked later in add_del_if(), but it's better
> performed before RTNL.
> 
> SIOCBRADDIF and SIOCBRDELIF have been processed in dev_ioctl() since
> the pre-git era, and there seems to be no specific reason to process
> them there.
> 
> [0]:
> unregister_netdevice: waiting for wpan3 to become free. Usage count = 2
> ref_tracker: wpan3@ffff8880662d8608 has 1/1 users at
>      __netdev_tracker_alloc include/linux/netdevice.h:4282 [inline]
>      netdev_hold include/linux/netdevice.h:4311 [inline]
>      dev_ifsioc+0xc6a/0x1160 net/core/dev_ioctl.c:624
>      dev_ioctl+0x255/0x10c0 net/core/dev_ioctl.c:826
>      sock_do_ioctl+0x1ca/0x260 net/socket.c:1213
>      sock_ioctl+0x23a/0x6c0 net/socket.c:1318
>      vfs_ioctl fs/ioctl.c:51 [inline]
>      __do_sys_ioctl fs/ioctl.c:906 [inline]
>      __se_sys_ioctl fs/ioctl.c:892 [inline]
>      __x64_sys_ioctl+0x1a4/0x210 fs/ioctl.c:892
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 893b19587534 ("net: bridge: fix ioctl locking")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Reported-by: yan kang <kangyan91@outlook.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/netdev/SY8P300MB0421225D54EB92762AE8F0F2A1D32@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

