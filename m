Return-Path: <netdev+bounces-149737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651089E6F9C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 14:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250BF18878D0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E5206F10;
	Fri,  6 Dec 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2yDMiFl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999FD204096
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493167; cv=none; b=WmONxuol3N9baUHCAR5lv4n6KLjjhO18zWSIl0fWrQ0psid/InO+jovT7gvimG3lwlXG6iLSi+TTjdN2ZAqULCzthJ4iPwRIyTeuaTmEP4VFMDZ43SU6eBys+yw3IlhLNlrnbILrq//jyuqqFh+bwisZW0rqjNmCpHC6j20UBGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493167; c=relaxed/simple;
	bh=+XYoFoF6yVLB2hi6tB9q/qH80Stkj3pKmiakucqq0bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSUTcs57sr0Zez2mzNlDK9CrlJMTNLudzmi+KsDiJlAjyLreu39+lVZY1zYoO8z0o13OPj9w1HwowZ22Nkbmpz7DMpnfLTwO5pDMAdGKPDgSmkJF6xjQX4v0JmdsfhjrHHlqcCGfciXiEux5gvEfBiMTFIFrXZjXYl9pdsAqUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2yDMiFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4871C4CED1;
	Fri,  6 Dec 2024 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733493167;
	bh=+XYoFoF6yVLB2hi6tB9q/qH80Stkj3pKmiakucqq0bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2yDMiFll2cvNE/yMrojyusBI/V16w8LFfuZZYrf1U2ye0MQHd5gnUPHJRIfOlMVD
	 mA/6o3lFjb8+psuHWav0rOaC4agUhPOX9W9+o3rqwi1MJ7zh2fcUjdUNDVIwuN2SYQ
	 U6z6mEfPT7V71F2o+KNUGdsllphSiEJtVVeMWy13j+5Jg54CFgYxXS7+F4JmZm/uwT
	 ze+6qQOiv0YUzJ5BXuR4I08F8/EkYW/NgU3nz9sBbUOkoSc9a5MhsUl684/q6wfOIw
	 nl5hDtUK7ZBSFouRfu2JrioAA41We9q/ly5AzLaY6AbNs4lWEHTM0FGp3ZEG7nSZbu
	 W4I5lBJ0E+2OQ==
Date: Fri, 6 Dec 2024 13:52:42 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+fb99d1b0c0f81d94a5e2@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: lapb: increase LAPB_HEADER_LEN
Message-ID: <20241206135242.GS2581@kernel.org>
References: <20241204141031.4030267-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204141031.4030267-1-edumazet@google.com>

On Wed, Dec 04, 2024 at 02:10:31PM +0000, Eric Dumazet wrote:
> It is unclear if net/lapb code is supposed to be ready for 8021q.
> 
> We can at least avoid crashes like the following :
> 
> skbuff: skb_under_panic: text:ffffffff8aabe1f6 len:24 put:20 head:ffff88802824a400 data:ffff88802824a3fe tail:0x16 end:0x140 dev:nr0.2
> ------------[ cut here ]------------
>  kernel BUG at net/core/skbuff.c:206 !
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 UID: 0 PID: 5508 Comm: dhcpcd Not tainted 6.12.0-rc7-syzkaller-00144-g66418447d27b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
>  RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
>  RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
> Code: 0d 8d 48 c7 c6 2e 9e 29 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 1a 6f 37 02 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> RSP: 0018:ffffc90002ddf638 EFLAGS: 00010282
> RAX: 0000000000000086 RBX: dffffc0000000000 RCX: 7a24750e538ff600
> RDX: 0000000000000000 RSI: 0000000000000201 RDI: 0000000000000000
> RBP: ffff888034a86650 R08: ffffffff8174b13c R09: 1ffff920005bbe60
> R10: dffffc0000000000 R11: fffff520005bbe61 R12: 0000000000000140
> R13: ffff88802824a400 R14: ffff88802824a3fe R15: 0000000000000016
> FS:  00007f2a5990d740(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c2631fd CR3: 0000000029504000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   skb_push+0xe5/0x100 net/core/skbuff.c:2636
>   nr_header+0x36/0x320 net/netrom/nr_dev.c:69
>   dev_hard_header include/linux/netdevice.h:3148 [inline]
>   vlan_dev_hard_header+0x359/0x480 net/8021q/vlan_dev.c:83
>   dev_hard_header include/linux/netdevice.h:3148 [inline]
>   lapbeth_data_transmit+0x1f6/0x2a0 drivers/net/wan/lapbether.c:257
>   lapb_data_transmit+0x91/0xb0 net/lapb/lapb_iface.c:447
>   lapb_transmit_buffer+0x168/0x1f0 net/lapb/lapb_out.c:149
>  lapb_establish_data_link+0x84/0xd0
>  lapb_device_event+0x4e0/0x670
>   notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
>  __dev_notify_flags+0x207/0x400
>   dev_change_flags+0xf0/0x1a0 net/core/dev.c:8922
>   devinet_ioctl+0xa4e/0x1aa0 net/ipv4/devinet.c:1188
>   inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1003
>   sock_do_ioctl+0x158/0x460 net/socket.c:1227
>   sock_ioctl+0x626/0x8e0 net/socket.c:1346
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:907 [inline]
>   __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+fb99d1b0c0f81d94a5e2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67506220.050a0220.17bd51.006c.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

