Return-Path: <netdev+bounces-46929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82857E72BE
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 21:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1F9B20BA2
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 20:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0629636B14;
	Thu,  9 Nov 2023 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YB6z+9OD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094C374C9
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 20:26:18 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489F944B7
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 12:26:18 -0800 (PST)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CDA2F3F129
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 20:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1699561575;
	bh=2Kj3mYxA7EDom8iqgmIGjAXq9KRsn15BoZtGKD2WBeA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=YB6z+9ODkfVq6T9ge5bzlUxss431+tLX9zvBtDOVE+aUmNvY/sZJtg6CUUxVI3y6W
	 riAlUXyVFAUcyxweEoYAIdw6h769GBMnP9ESFj/uTBdC+l0WbKijH2HGet1xNB6jzS
	 PqUscL3g2oowILq3BpMZIxk1IeYTlgp5NKea4+tU/KVjTobg2/3qe/MFWzfwNtloXT
	 UBLx+K06lc0VFUVLbuii+NhcQjyVjRJFLXuo7/fFuytDz08tcB4/PmT26GJJT8BlFm
	 zcLidVjFeOqP7d0syAPeqPZu4naBHjhKnX59mwbiaZx4nKI+TJ7AhlwlFTtRXJDahE
	 edZeKtbSo+uWA==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c59e2c661eso8305411fa.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 12:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699561575; x=1700166375;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Kj3mYxA7EDom8iqgmIGjAXq9KRsn15BoZtGKD2WBeA=;
        b=F/mdvNk6h1oINKMMP+7EM2Nw/LnMZ6ci5WnN/9HuEYdlew3dcfFZcAkBQYeXdM5Zmi
         uOhmwxPAegjYKPjUEkBzK0bljDNfFG6YqTFyGwzWPju1Wlrzt7+SkJAYiUhiopWFToc6
         CkzHaphU+mhTcQLv+FPV1Y/16cNbGmPfz4dTnS8YHtSPZDGj8snqnLH/mlXZ73KqWuxx
         K85JKLks6uujBRRdvXezRbz1rKlbKLde6uBvK/nT4R1aenSa522DrpZCnp8RnBoJDh/3
         eyBjlTx2spUA5AQrXtzpCJbPjn0MUofpWTAszMAadNDo1ZSdx8N/Y3eU0R1kLevhCAdF
         RlgQ==
X-Gm-Message-State: AOJu0Yxc9nTrx6aBv0ataSrjZ89vgkC3utgQu8XxLpAnX1bzpNnBLalY
	i4s6Je028nizpJIXKn6hne13f2ezpPGC+KAGseIgzB3fpCVnIHFnnBTE89RRZdx10suqoTHEHsp
	X2FCyF/BVYqOQiaIJS5xJjfUe+WipIiTMmA==
X-Received: by 2002:a2e:5c47:0:b0:2c5:dc3:5780 with SMTP id q68-20020a2e5c47000000b002c50dc35780mr162410ljb.8.1699561575338;
        Thu, 09 Nov 2023 12:26:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6xpWdJS6Rwy/1lIj6FVrWSd91kTgpVWNE8AuOUrVzexn2rPpZNA6iaWiBW0ULNAiZ+dxuDA==
X-Received: by 2002:a2e:5c47:0:b0:2c5:dc3:5780 with SMTP id q68-20020a2e5c47000000b002c50dc35780mr162399ljb.8.1699561574986;
        Thu, 09 Nov 2023 12:26:14 -0800 (PST)
Received: from vermin.localdomain ([159.148.28.2])
        by smtp.gmail.com with ESMTPSA id s19-20020a2e98d3000000b002bb99bd0865sm56653ljj.38.2023.11.09.12.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 12:26:14 -0800 (PST)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id D4D8A1C3B33; Thu,  9 Nov 2023 12:26:13 -0800 (PST)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id D42411C3B2E;
	Thu,  9 Nov 2023 22:26:13 +0200 (EET)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Eric Dumazet <edumazet@google.com>
cc: "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org,
    eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] bonding: stop the device in bond_setup_by_slave()
In-reply-to: <20231109180102.4085183-1-edumazet@google.com>
References: <20231109180102.4085183-1-edumazet@google.com>
Comments: In-reply-to Eric Dumazet <edumazet@google.com>
   message dated "Thu, 09 Nov 2023 18:01:02 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <77833.1699561573.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Nov 2023 22:26:13 +0200
Message-ID: <77834.1699561573@vermin>

Eric Dumazet <edumazet@google.com> wrote:

>Commit 9eed321cde22 ("net: lapbether: only support ethernet devices")
>has been able to keep syzbot away from net/lapb, until today.
>
>In the following splat [1], the issue is that a lapbether device has
>been created on a bonding device without members. Then adding a non
>ARPHRD_ETHER member forced the bonding master to change its type.
>
>The fix is to make sure we call dev_close() in bond_setup_by_slave()
>so that the potential linked lapbether devices (or any other devices
>having assumptions on the physical device) are removed.
>
>A similar bug has been addressed in commit 40baec225765
>("bonding: fix panic on non-ARPHRD_ETHER enslave failure")
>
>[1]
>skbuff: skb_under_panic: text:ffff800089508810 len:44 put:40 head:ffff000=
0c78e7c00 data:ffff0000c78e7bea tail:0x16 end:0x140 dev:bond0
>kernel BUG at net/core/skbuff.c:192 !
>Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>Modules linked in:
>CPU: 0 PID: 6007 Comm: syz-executor383 Not tainted 6.6.0-rc3-syzkaller-gb=
f6547d8715b #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/04/2023
>pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>pc : skb_panic net/core/skbuff.c:188 [inline]
>pc : skb_under_panic+0x13c/0x140 net/core/skbuff.c:202
>lr : skb_panic net/core/skbuff.c:188 [inline]
>lr : skb_under_panic+0x13c/0x140 net/core/skbuff.c:202
>sp : ffff800096a06aa0
>x29: ffff800096a06ab0 x28: ffff800096a06ba0 x27: dfff800000000000
>x26: ffff0000ce9b9b50 x25: 0000000000000016 x24: ffff0000c78e7bea
>x23: ffff0000c78e7c00 x22: 000000000000002c x21: 0000000000000140
>x20: 0000000000000028 x19: ffff800089508810 x18: ffff800096a06100
>x17: 0000000000000000 x16: ffff80008a629a3c x15: 0000000000000001
>x14: 1fffe00036837a32 x13: 0000000000000000 x12: 0000000000000000
>x11: 0000000000000201 x10: 0000000000000000 x9 : cb50b496c519aa00
>x8 : cb50b496c519aa00 x7 : 0000000000000001 x6 : 0000000000000001
>x5 : ffff800096a063b8 x4 : ffff80008e280f80 x3 : ffff8000805ad11c
>x2 : 0000000000000001 x1 : 0000000100000201 x0 : 0000000000000086
>Call trace:
>skb_panic net/core/skbuff.c:188 [inline]
>skb_under_panic+0x13c/0x140 net/core/skbuff.c:202
>skb_push+0xf0/0x108 net/core/skbuff.c:2446
>ip6gre_header+0xbc/0x738 net/ipv6/ip6_gre.c:1384
>dev_hard_header include/linux/netdevice.h:3136 [inline]
>lapbeth_data_transmit+0x1c4/0x298 drivers/net/wan/lapbether.c:257
>lapb_data_transmit+0x8c/0xb0 net/lapb/lapb_iface.c:447
>lapb_transmit_buffer+0x178/0x204 net/lapb/lapb_out.c:149
>lapb_send_control+0x220/0x320 net/lapb/lapb_subr.c:251
>__lapb_disconnect_request+0x9c/0x17c net/lapb/lapb_iface.c:326
>lapb_device_event+0x288/0x4e0 net/lapb/lapb_iface.c:492
>notifier_call_chain+0x1a4/0x510 kernel/notifier.c:93
>raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:461
>call_netdevice_notifiers_info net/core/dev.c:1970 [inline]
>call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
>call_netdevice_notifiers net/core/dev.c:2022 [inline]
>__dev_close_many+0x1b8/0x3c4 net/core/dev.c:1508
>dev_close_many+0x1e0/0x470 net/core/dev.c:1559
>dev_close+0x174/0x250 net/core/dev.c:1585
>lapbeth_device_event+0x2e4/0x958 drivers/net/wan/lapbether.c:466
>notifier_call_chain+0x1a4/0x510 kernel/notifier.c:93
>raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:461
>call_netdevice_notifiers_info net/core/dev.c:1970 [inline]
>call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
>call_netdevice_notifiers net/core/dev.c:2022 [inline]
>__dev_close_many+0x1b8/0x3c4 net/core/dev.c:1508
>dev_close_many+0x1e0/0x470 net/core/dev.c:1559
>dev_close+0x174/0x250 net/core/dev.c:1585
>bond_enslave+0x2298/0x30cc drivers/net/bonding/bond_main.c:2332
>bond_do_ioctl+0x268/0xc64 drivers/net/bonding/bond_main.c:4539
>dev_ifsioc+0x754/0x9ac
>dev_ioctl+0x4d8/0xd34 net/core/dev_ioctl.c:786
>sock_do_ioctl+0x1d4/0x2d0 net/socket.c:1217
>sock_ioctl+0x4e8/0x834 net/socket.c:1322
>vfs_ioctl fs/ioctl.c:51 [inline]
>__do_sys_ioctl fs/ioctl.c:871 [inline]
>__se_sys_ioctl fs/ioctl.c:857 [inline]
>__arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
>__invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
>el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
>do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
>el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
>el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
>el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
>Code: aa1803e6 aa1903e7 a90023f5 94785b8b (d4210000)
>
>Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_E=
THER")
>Reported-by: syzbot <syzkaller@googlegroups.com>
>Signed-off-by: Eric Dumazet <edumazet@google.com>

	I was initially worred that the close / open dance was on the
regular path, but it's only for the non-ARPHRD_ETHER case.  That's
really for Infiniband IPoIB, and I'm not sure that there is anything
that can be stacked atop an IPoIB bond.

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

	-J

>---
> drivers/net/bonding/bond_main.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 51d47eda1c873debda6da094377bcb3367a78f6e..8e6cc0e133b7f19afccd3ecf4=
4bea5ceacb393b1 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1500,6 +1500,10 @@ static void bond_compute_features(struct bonding *=
bond)
> static void bond_setup_by_slave(struct net_device *bond_dev,
> 				struct net_device *slave_dev)
> {
>+	bool was_up =3D !!(bond_dev->flags & IFF_UP);
>+
>+	dev_close(bond_dev);
>+
> 	bond_dev->header_ops	    =3D slave_dev->header_ops;
> =

> 	bond_dev->type		    =3D slave_dev->type;
>@@ -1514,6 +1518,8 @@ static void bond_setup_by_slave(struct net_device *=
bond_dev,
> 		bond_dev->flags &=3D ~(IFF_BROADCAST | IFF_MULTICAST);
> 		bond_dev->flags |=3D (IFF_POINTOPOINT | IFF_NOARP);
> 	}
>+	if (was_up)
>+		dev_open(bond_dev, NULL);
> }
> =

> /* On bonding slaves other than the currently active slave, suppress
>-- =

>2.42.0.869.gea05f2083d-goog

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

