Return-Path: <netdev+bounces-12945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E1B73988C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 09:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC74F28184A
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745DEC8CF;
	Thu, 22 Jun 2023 07:54:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F3A1FB4
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 07:54:07 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451B21BEA
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:54:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fa0253b9e7so3250785e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687420441; x=1690012441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndYuoLRAungaQNM3WlRcQ8kWCknXQfpIkiZNzQBmdoE=;
        b=vVvB8f65QLihTkCr7Nwavpho2FBe3DZTh1aYpQnrXLJWRnSppL2Bmy0Sg7+GL6YAza
         m/LE6L0ePE7NfIAu+uuS1Gb/g7YnxamjRDQbuXnX+uuGSyrNeii3Rbb1S/JHoQqz/Gw3
         Dp9+QQLaHNgttkriY4bhR5SUl8MFDExGf2A44kwqwgNc/mYvFEV9roA5kGmQ/iDkS8K6
         xjk4VRlUhDc9/vb6CReXv3os+xaaW1CEFaK04VAuCX5ZygdZjiksfpeLYblxCtFX8Hhd
         IbruPwGSe0+L+VH5SQ6peKeWRt6wqs3hIP+0oF8MSbumOY3qZd1ipRaoGe6m0fDPPfkf
         9Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420441; x=1690012441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndYuoLRAungaQNM3WlRcQ8kWCknXQfpIkiZNzQBmdoE=;
        b=AN/G389ugcN3O+PuHrHFgjN+ArfML+KV+B+hZcY0oIBLuNCwY98lLo1rajykwhtuRO
         q5ai+ysHEUIMF9haMzbCK2lV9IOGa9lKeLa6jI/3nFwVdwok8fq5m1olbiMEjqO8mW2S
         aZiSs4LBBABGT72xmnbcr/5oX+mvD+nqzOmthT6sGdOOor6nUREHodMUVSc8s/cxQ9E2
         Ox+WRou8+yx/dGk5Yr3imxTfFvXeKDgcGdUqpmVRDeP4Q8AEeJ2Ey+64sbpILR2NjIgx
         N6+9medKhZR+bnJ2kfEH8rpHZwlgvh/gAUB8m5fgNU09CibiMnSVJYCucWgNk92wI9TP
         rZpA==
X-Gm-Message-State: AC+VfDwHoZaBggOHxkQKvEKSMcN06tqWKjWylPk+syyIa1G2sEHCUJXw
	7tOAknKgn6NAEkxtMeTHy7By0w==
X-Google-Smtp-Source: ACHHUZ5FmIT7oWc5lc4G2eh4MxHWEJTZSMrh9J4jAl3Z7pV0E8IFS1jQO/QBGtwD/ABvdYp8hXYGuw==
X-Received: by 2002:a1c:7203:0:b0:3f6:774:fdc with SMTP id n3-20020a1c7203000000b003f607740fdcmr16313502wmc.18.1687420440765;
        Thu, 22 Jun 2023 00:54:00 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c20ca00b003f9b29ba838sm6976475wmm.35.2023.06.22.00.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:54:00 -0700 (PDT)
Date: Thu, 22 Jun 2023 09:53:59 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] netlink: do not hard code device address lenth in
 fdb dumps
Message-ID: <ZJP+F9cX8KP3M6Eh@nanopsycho>
References: <20230621174720.1845040-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621174720.1845040-1-edumazet@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jun 21, 2023 at 07:47:20PM CEST, edumazet@google.com wrote:
>syzbot reports that some netdev devices do not have a six bytes
>address [1]
>
>Replace ETH_ALEN by dev->addr_len.
>
>[1] (Case of a device where dev->addr_len = 4)
>
>BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>BUG: KMSAN: kernel-infoleak in copyout+0xb8/0x100 lib/iov_iter.c:169
>instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>copyout+0xb8/0x100 lib/iov_iter.c:169
>_copy_to_iter+0x6d8/0x1d00 lib/iov_iter.c:536
>copy_to_iter include/linux/uio.h:206 [inline]
>simple_copy_to_iter+0x68/0xa0 net/core/datagram.c:513
>__skb_datagram_iter+0x123/0xdc0 net/core/datagram.c:419
>skb_copy_datagram_iter+0x5c/0x200 net/core/datagram.c:527
>skb_copy_datagram_msg include/linux/skbuff.h:3960 [inline]
>netlink_recvmsg+0x4ae/0x15a0 net/netlink/af_netlink.c:1970
>sock_recvmsg_nosec net/socket.c:1019 [inline]
>sock_recvmsg net/socket.c:1040 [inline]
>____sys_recvmsg+0x283/0x7f0 net/socket.c:2722
>___sys_recvmsg+0x223/0x840 net/socket.c:2764
>do_recvmmsg+0x4f9/0xfd0 net/socket.c:2858
>__sys_recvmmsg net/socket.c:2937 [inline]
>__do_sys_recvmmsg net/socket.c:2960 [inline]
>__se_sys_recvmmsg net/socket.c:2953 [inline]
>__x64_sys_recvmmsg+0x397/0x490 net/socket.c:2953
>do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>Uninit was stored to memory at:
>__nla_put lib/nlattr.c:1009 [inline]
>nla_put+0x1c6/0x230 lib/nlattr.c:1067
>nlmsg_populate_fdb_fill+0x2b8/0x600 net/core/rtnetlink.c:4071
>nlmsg_populate_fdb net/core/rtnetlink.c:4418 [inline]
>ndo_dflt_fdb_dump+0x616/0x840 net/core/rtnetlink.c:4456
>rtnl_fdb_dump+0x14ff/0x1fc0 net/core/rtnetlink.c:4629
>netlink_dump+0x9d1/0x1310 net/netlink/af_netlink.c:2268
>netlink_recvmsg+0xc5c/0x15a0 net/netlink/af_netlink.c:1995
>sock_recvmsg_nosec+0x7a/0x120 net/socket.c:1019
>____sys_recvmsg+0x664/0x7f0 net/socket.c:2720
>___sys_recvmsg+0x223/0x840 net/socket.c:2764
>do_recvmmsg+0x4f9/0xfd0 net/socket.c:2858
>__sys_recvmmsg net/socket.c:2937 [inline]
>__do_sys_recvmmsg net/socket.c:2960 [inline]
>__se_sys_recvmmsg net/socket.c:2953 [inline]
>__x64_sys_recvmmsg+0x397/0x490 net/socket.c:2953
>do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>Uninit was created at:
>slab_post_alloc_hook+0x12d/0xb60 mm/slab.h:716
>slab_alloc_node mm/slub.c:3451 [inline]
>__kmem_cache_alloc_node+0x4ff/0x8b0 mm/slub.c:3490
>kmalloc_trace+0x51/0x200 mm/slab_common.c:1057
>kmalloc include/linux/slab.h:559 [inline]
>__hw_addr_create net/core/dev_addr_lists.c:60 [inline]
>__hw_addr_add_ex+0x2e5/0x9e0 net/core/dev_addr_lists.c:118
>__dev_mc_add net/core/dev_addr_lists.c:867 [inline]
>dev_mc_add+0x9a/0x130 net/core/dev_addr_lists.c:885
>igmp6_group_added+0x267/0xbc0 net/ipv6/mcast.c:680
>ipv6_mc_up+0x296/0x3b0 net/ipv6/mcast.c:2754
>ipv6_mc_remap+0x1e/0x30 net/ipv6/mcast.c:2708
>addrconf_type_change net/ipv6/addrconf.c:3731 [inline]
>addrconf_notify+0x4d3/0x1d90 net/ipv6/addrconf.c:3699
>notifier_call_chain kernel/notifier.c:93 [inline]
>raw_notifier_call_chain+0xe4/0x430 kernel/notifier.c:461
>call_netdevice_notifiers_info net/core/dev.c:1935 [inline]
>call_netdevice_notifiers_extack net/core/dev.c:1973 [inline]
>call_netdevice_notifiers+0x1ee/0x2d0 net/core/dev.c:1987
>bond_enslave+0xccd/0x53f0 drivers/net/bonding/bond_main.c:1906
>do_set_master net/core/rtnetlink.c:2626 [inline]
>rtnl_newlink_create net/core/rtnetlink.c:3460 [inline]
>__rtnl_newlink net/core/rtnetlink.c:3660 [inline]
>rtnl_newlink+0x378c/0x40e0 net/core/rtnetlink.c:3673
>rtnetlink_rcv_msg+0x16a6/0x1840 net/core/rtnetlink.c:6395
>netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2546
>rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6413
>netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
>netlink_unicast+0xf28/0x1230 net/netlink/af_netlink.c:1365
>netlink_sendmsg+0x122f/0x13d0 net/netlink/af_netlink.c:1913
>sock_sendmsg_nosec net/socket.c:724 [inline]
>sock_sendmsg net/socket.c:747 [inline]
>____sys_sendmsg+0x999/0xd50 net/socket.c:2503
>___sys_sendmsg+0x28d/0x3c0 net/socket.c:2557
>__sys_sendmsg net/socket.c:2586 [inline]
>__do_sys_sendmsg net/socket.c:2595 [inline]
>__se_sys_sendmsg net/socket.c:2593 [inline]
>__x64_sys_sendmsg+0x304/0x490 net/socket.c:2593
>do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>Bytes 2856-2857 of 3500 are uninitialized
>Memory access of size 3500 starts at ffff888018d99104
>Data copied to user address 0000000020000480
>
>Fixes: d83b06036048 ("net: add fdb generic dump routine")
>Reported-by: syzbot <syzkaller@googlegroups.com>
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

