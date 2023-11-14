Return-Path: <netdev+bounces-47582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1717EA834
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 02:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDE5280DE2
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3022567C;
	Tue, 14 Nov 2023 01:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMeeYH8a"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C25669
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 01:30:26 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F8A1A7
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 17:30:25 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso5252371b3a.3
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 17:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699925425; x=1700530225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3945JHm4+byQoZJ6jGVQeJ3RxKRVqbwf6VfYRQJlrD8=;
        b=UMeeYH8aG0KGJvoeXoP5sckb5C5lWenhvRtehGF2SKFHS90upLz4KQDUPg7qP1wZ7N
         GqXKCLk0vbwmEGtZqwc50BHauyeq7KF6p4ZbuALsPM79svke/PBSG7JlDzmML8BCo/Rj
         uIh/HbZvyEZi7cIbUq5so1M2u0aIVZlEn0UI3lczh5NL3/PXyCeygkywC0YmW9rLmE2O
         KW547yLO+YSFDDoQaTHXz85SHJVY3CD8g1WYFSKkK4z4Hp1uoKjzxmAK64ALeXHM26Ug
         p8FFdO6rgdsjp5OdGC6coL4s+t+bi7Eub9DORkvuH6iMNzM2N3ehlQRj7upY8H1JdD1J
         ilcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699925425; x=1700530225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3945JHm4+byQoZJ6jGVQeJ3RxKRVqbwf6VfYRQJlrD8=;
        b=WLYTF9dwCFI9WnFxasQ6vVW07rtjpdgJfRZbv2D6XkPpVwumq5Bbl9S5vvpim3d15K
         xuSuDEkgV1ID6qMJV/aXCvRVUdjG8zzzeRooGWqYxzmXlPWUAwYR60ZH0brVWrJLqkJY
         a+3CXSEp9SMJpmyH5w2vdCtMcRspyHt/Pw7ktUghaHgtXLmz8EU/wL9In9BKMoAqHCz9
         2AQ8RZ4axC2JFhXq/O+6187OLOx4aAL2Sqgrhw89GSNey+gIWB1nd2SAOdQXkiS8VWR3
         C1LtbiI8LuuzcNOk8lQSZ+uQeJS4LXUHdrZbu7SPEC6BWmFuQiwOQMVq60WvCwsCe0bI
         3MzQ==
X-Gm-Message-State: AOJu0YxH5AvrCm3jRG+CyT4UYXOg0uScOT/K2lrfTolyZzZqWdKhK/S3
	XXwGntLd3PEb+WVeBM4sfZo=
X-Google-Smtp-Source: AGHT+IHyNUMRSTRLromziStwK1wbK+JBU7zqhXXm7Paa5mTfhBlhEU45bgzBwIxO+qlv5vDARL+kEg==
X-Received: by 2002:a05:6a00:4186:b0:6bd:a8a3:cc59 with SMTP id ca6-20020a056a00418600b006bda8a3cc59mr10884141pfb.24.1699925424658;
        Mon, 13 Nov 2023 17:30:24 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r19-20020aa78453000000b0064f76992905sm199129pfn.202.2023.11.13.17.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 17:30:24 -0800 (PST)
Date: Tue, 14 Nov 2023 09:30:19 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] bonding: stop the device in bond_setup_by_slave()
Message-ID: <ZVLNq4RwImaKpi7R@Laptop-X1>
References: <20231109180102.4085183-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109180102.4085183-1-edumazet@google.com>

On Thu, Nov 09, 2023 at 06:01:02PM +0000, Eric Dumazet wrote:
> Commit 9eed321cde22 ("net: lapbether: only support ethernet devices")
> has been able to keep syzbot away from net/lapb, until today.
> 
> In the following splat [1], the issue is that a lapbether device has
> been created on a bonding device without members. Then adding a non
> ARPHRD_ETHER member forced the bonding master to change its type.
> 
> The fix is to make sure we call dev_close() in bond_setup_by_slave()
> so that the potential linked lapbether devices (or any other devices
> having assumptions on the physical device) are removed.
> 
> A similar bug has been addressed in commit 40baec225765
> ("bonding: fix panic on non-ARPHRD_ETHER enslave failure")
> 
> [1]
> skbuff: skb_under_panic: text:ffff800089508810 len:44 put:40 head:ffff0000c78e7c00 data:ffff0000c78e7bea tail:0x16 end:0x140 dev:bond0
> kernel BUG at net/core/skbuff.c:192 !
> Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 6007 Comm: syz-executor383 Not tainted 6.6.0-rc3-syzkaller-gbf6547d8715b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : skb_panic net/core/skbuff.c:188 [inline]
> pc : skb_under_panic+0x13c/0x140 net/core/skbuff.c:202
> lr : skb_panic net/core/skbuff.c:188 [inline]
> lr : skb_under_panic+0x13c/0x140 net/core/skbuff.c:202
> sp : ffff800096a06aa0
> x29: ffff800096a06ab0 x28: ffff800096a06ba0 x27: dfff800000000000
> x26: ffff0000ce9b9b50 x25: 0000000000000016 x24: ffff0000c78e7bea
> x23: ffff0000c78e7c00 x22: 000000000000002c x21: 0000000000000140
> x20: 0000000000000028 x19: ffff800089508810 x18: ffff800096a06100
> x17: 0000000000000000 x16: ffff80008a629a3c x15: 0000000000000001
> x14: 1fffe00036837a32 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000201 x10: 0000000000000000 x9 : cb50b496c519aa00
> x8 : cb50b496c519aa00 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff800096a063b8 x4 : ffff80008e280f80 x3 : ffff8000805ad11c
> x2 : 0000000000000001 x1 : 0000000100000201 x0 : 0000000000000086
> Call trace:
> skb_panic net/core/skbuff.c:188 [inline]
> skb_under_panic+0x13c/0x140 net/core/skbuff.c:202
> skb_push+0xf0/0x108 net/core/skbuff.c:2446
> ip6gre_header+0xbc/0x738 net/ipv6/ip6_gre.c:1384
> dev_hard_header include/linux/netdevice.h:3136 [inline]
> lapbeth_data_transmit+0x1c4/0x298 drivers/net/wan/lapbether.c:257
> lapb_data_transmit+0x8c/0xb0 net/lapb/lapb_iface.c:447
> lapb_transmit_buffer+0x178/0x204 net/lapb/lapb_out.c:149
> lapb_send_control+0x220/0x320 net/lapb/lapb_subr.c:251
> __lapb_disconnect_request+0x9c/0x17c net/lapb/lapb_iface.c:326
> lapb_device_event+0x288/0x4e0 net/lapb/lapb_iface.c:492
> notifier_call_chain+0x1a4/0x510 kernel/notifier.c:93
> raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:461
> call_netdevice_notifiers_info net/core/dev.c:1970 [inline]
> call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
> call_netdevice_notifiers net/core/dev.c:2022 [inline]
> __dev_close_many+0x1b8/0x3c4 net/core/dev.c:1508
> dev_close_many+0x1e0/0x470 net/core/dev.c:1559
> dev_close+0x174/0x250 net/core/dev.c:1585
> lapbeth_device_event+0x2e4/0x958 drivers/net/wan/lapbether.c:466
> notifier_call_chain+0x1a4/0x510 kernel/notifier.c:93
> raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:461
> call_netdevice_notifiers_info net/core/dev.c:1970 [inline]
> call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
> call_netdevice_notifiers net/core/dev.c:2022 [inline]
> __dev_close_many+0x1b8/0x3c4 net/core/dev.c:1508
> dev_close_many+0x1e0/0x470 net/core/dev.c:1559
> dev_close+0x174/0x250 net/core/dev.c:1585
> bond_enslave+0x2298/0x30cc drivers/net/bonding/bond_main.c:2332
> bond_do_ioctl+0x268/0xc64 drivers/net/bonding/bond_main.c:4539
> dev_ifsioc+0x754/0x9ac
> dev_ioctl+0x4d8/0xd34 net/core/dev_ioctl.c:786
> sock_do_ioctl+0x1d4/0x2d0 net/socket.c:1217
> sock_ioctl+0x4e8/0x834 net/socket.c:1322
> vfs_ioctl fs/ioctl.c:51 [inline]
> __do_sys_ioctl fs/ioctl.c:871 [inline]
> __se_sys_ioctl fs/ioctl.c:857 [inline]
> __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
> __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
> invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
> el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
> do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
> el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
> el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
> el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> Code: aa1803e6 aa1903e7 a90023f5 94785b8b (d4210000)
> 
> Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_ETHER")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  drivers/net/bonding/bond_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 51d47eda1c873debda6da094377bcb3367a78f6e..8e6cc0e133b7f19afccd3ecf44bea5ceacb393b1 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1500,6 +1500,10 @@ static void bond_compute_features(struct bonding *bond)
>  static void bond_setup_by_slave(struct net_device *bond_dev,
>  				struct net_device *slave_dev)
>  {
> +	bool was_up = !!(bond_dev->flags & IFF_UP);
> +
> +	dev_close(bond_dev);
> +
>  	bond_dev->header_ops	    = slave_dev->header_ops;
>  
>  	bond_dev->type		    = slave_dev->type;
> @@ -1514,6 +1518,8 @@ static void bond_setup_by_slave(struct net_device *bond_dev,
>  		bond_dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
>  		bond_dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
>  	}
> +	if (was_up)
> +		dev_open(bond_dev, NULL);
>  }
>  
>  /* On bonding slaves other than the currently active slave, suppress
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

As Jay's comments, the bond device itself should be unregistered if the
last interface of a non-ARPHRD_ETHER bond is removed. There should no need
to close/open bond dev on the non-ARPHRD_ETHER -> ARPHRD_ETHER path. So

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

