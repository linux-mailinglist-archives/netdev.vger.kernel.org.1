Return-Path: <netdev+bounces-55104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98EE809663
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 00:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4711C20C17
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 23:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246281DA4A;
	Thu,  7 Dec 2023 23:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJaV8XwN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EEE10EF
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 15:02:08 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d7a47d06eeso14063527b3.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 15:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701990127; x=1702594927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSUtrJOxzz/0F85ylmroxY9e/PpBkw5GCzLped6gFcE=;
        b=WJaV8XwNjXzpcHp0352E98uN4137WKoncqp3HnjS4DC6RuGHm2AqlLOYYXX/kyKcif
         BUKd/XQBM5L0+wuBSYiRxDhHLVf+UBncT+Xjw2th5zFt8j3WfriFX0cw3+GYDPXqZUkP
         sHihJ98k/9BO/yyPIHGj5vdaiIY9sijFGRhTfjYPe69ne4MeA5znbd2EVbMZp6EKGkUo
         T/v/vgJ+6ByEKlTqolD+HmJz1ju0nEGN+NPuLvvvuZOVx1pJyKCDMCwtolQlBjDldXr+
         ThDncS5+p8ckGuNPcD9q1NpxWyUIhB6O4B6o2jiaFm1Xg5OQnzhBfdXkQUDB5PrTcFqa
         x6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701990127; x=1702594927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSUtrJOxzz/0F85ylmroxY9e/PpBkw5GCzLped6gFcE=;
        b=AWQXIvzmTBgCkOrbMqOOFnUgDcEEhe2KEJ7/ZVIdX25JBfslXKGCk2Tgzsk7TqV2a4
         +s0eXwtAVOZA8ZUbozxgJLtpaEr6NRAzdutTJmyKOCPC9YZLt2Uoqu1PbfFqqxmeIeJe
         azMxYpdp6RHWc6uiNMBPsEKIqPR/Jl6CP7gQqWZvK7xoM/gtxx6a1IKhzZsTkBKG5CeL
         5eOzuKI+w+PGejCRgejDiCM1L75vrwYwwveJQWZUfVlz5uGAiWfIKnJgv2xGIT+kEam9
         j/L5xzpRs8SB0uuPn34N7EKq1+UAPYtsYH+S+5JmMUGHqe2tBNkFMApdSBJr2txvpr04
         e8OQ==
X-Gm-Message-State: AOJu0YynefPiPM7Y3OblhnX3fZzFiniQJKGQAxwfRegLGPmxGsZogMse
	1bMYKn7rAhbePeh+38RAR5c=
X-Google-Smtp-Source: AGHT+IG96le4qEOmx4wYSSpaY5XIXgYPzgg4BAle1+qtbXw/KvpFgebxNBBgswu4XSsDuG6uGYLNtA==
X-Received: by 2002:a81:8d45:0:b0:5ca:4b49:48a7 with SMTP id w5-20020a818d45000000b005ca4b4948a7mr3170598ywj.43.1701990127370;
        Thu, 07 Dec 2023 15:02:07 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id x125-20020a817c83000000b005a4da74b869sm225104ywc.139.2023.12.07.15.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 15:02:06 -0800 (PST)
Message-ID: <2133401f-2ba5-42eb-9158-dcc74db744f5@gmail.com>
Date: Thu, 7 Dec 2023 15:02:05 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20231205173250.2982846-1-edumazet@google.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20231205173250.2982846-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eric, could you also open a bug for this incident?


On 12/5/23 09:32, Eric Dumazet wrote:
> Some elusive syzbot reports are hinting to fib6_info_release(),
> with a potential dangling f6i->gc_link anchor.
> 
> Add debug checks so that syzbot can catch the issue earlier eventually.
> 
> BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:990 [inline]
> BUG: KASAN: slab-use-after-free in hlist_del_init include/linux/list.h:1016 [inline]
> BUG: KASAN: slab-use-after-free in fib6_clean_expires_locked include/net/ip6_fib.h:533 [inline]
> BUG: KASAN: slab-use-after-free in fib6_purge_rt+0x986/0x9c0 net/ipv6/ip6_fib.c:1064
> Write of size 8 at addr ffff88802805a840 by task syz-executor.1/10057
> 
> CPU: 1 PID: 10057 Comm: syz-executor.1 Not tainted 6.7.0-rc2-syzkaller-00029-g9b6de136b5f0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> print_address_description mm/kasan/report.c:364 [inline]
> print_report+0xc4/0x620 mm/kasan/report.c:475
> kasan_report+0xda/0x110 mm/kasan/report.c:588
> __hlist_del include/linux/list.h:990 [inline]
> hlist_del_init include/linux/list.h:1016 [inline]
> fib6_clean_expires_locked include/net/ip6_fib.h:533 [inline]
> fib6_purge_rt+0x986/0x9c0 net/ipv6/ip6_fib.c:1064
> fib6_del_route net/ipv6/ip6_fib.c:1993 [inline]
> fib6_del+0xa7a/0x1750 net/ipv6/ip6_fib.c:2038
> __ip6_del_rt net/ipv6/route.c:3866 [inline]
> ip6_del_rt+0xf7/0x200 net/ipv6/route.c:3881
> ndisc_router_discovery+0x295b/0x3560 net/ipv6/ndisc.c:1372
> ndisc_rcv+0x3de/0x5f0 net/ipv6/ndisc.c:1856
> icmpv6_rcv+0x1470/0x19c0 net/ipv6/icmp.c:979
> ip6_protocol_deliver_rcu+0x170/0x13e0 net/ipv6/ip6_input.c:438
> ip6_input_finish+0x14f/0x2f0 net/ipv6/ip6_input.c:483
> NF_HOOK include/linux/netfilter.h:314 [inline]
> NF_HOOK include/linux/netfilter.h:308 [inline]
> ip6_input+0xa1/0xc0 net/ipv6/ip6_input.c:492
> ip6_mc_input+0x48b/0xf40 net/ipv6/ip6_input.c:586
> dst_input include/net/dst.h:461 [inline]
> ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
> NF_HOOK include/linux/netfilter.h:314 [inline]
> NF_HOOK include/linux/netfilter.h:308 [inline]
> ipv6_rcv+0x24e/0x380 net/ipv6/ip6_input.c:310
> __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5529
> __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5643
> netif_receive_skb_internal net/core/dev.c:5729 [inline]
> netif_receive_skb+0x133/0x700 net/core/dev.c:5788
> tun_rx_batched+0x429/0x780 drivers/net/tun.c:1579
> tun_get_user+0x29e3/0x3bc0 drivers/net/tun.c:2002
> tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2048
> call_write_iter include/linux/fs.h:2020 [inline]
> new_sync_write fs/read_write.c:491 [inline]
> vfs_write+0x64f/0xdf0 fs/read_write.c:584
> ksys_write+0x12f/0x250 fs/read_write.c:637
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f38e387b82f
> Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 b9 80 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 0c 81 02 00 48
> RSP: 002b:00007f38e45c9090 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f38e399bf80 RCX: 00007f38e387b82f
> RDX: 00000000000003b6 RSI: 0000000020000680 RDI: 00000000000000c8
> RBP: 00007f38e38c847a R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000000003b6 R11: 0000000000000293 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f38e399bf80 R15: 00007f38e3abfa48
> </TASK>
> 
> Allocated by task 10044:
> kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
> kasan_set_track+0x25/0x30 mm/kasan/common.c:52
> ____kasan_kmalloc mm/kasan/common.c:374 [inline]
> __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
> kasan_kmalloc include/linux/kasan.h:198 [inline]
> __do_kmalloc_node mm/slab_common.c:1007 [inline]
> __kmalloc+0x59/0x90 mm/slab_common.c:1020
> kmalloc include/linux/slab.h:604 [inline]
> kzalloc include/linux/slab.h:721 [inline]
> fib6_info_alloc+0x40/0x160 net/ipv6/ip6_fib.c:155
> ip6_route_info_create+0x337/0x1e70 net/ipv6/route.c:3749
> ip6_route_add+0x26/0x150 net/ipv6/route.c:3843
> rt6_add_route_info+0x2e7/0x4b0 net/ipv6/route.c:4316
> rt6_route_rcv+0x76c/0xbf0 net/ipv6/route.c:985
> ndisc_router_discovery+0x138b/0x3560 net/ipv6/ndisc.c:1529
> ndisc_rcv+0x3de/0x5f0 net/ipv6/ndisc.c:1856
> icmpv6_rcv+0x1470/0x19c0 net/ipv6/icmp.c:979
> ip6_protocol_deliver_rcu+0x170/0x13e0 net/ipv6/ip6_input.c:438
> ip6_input_finish+0x14f/0x2f0 net/ipv6/ip6_input.c:483
> NF_HOOK include/linux/netfilter.h:314 [inline]
> NF_HOOK include/linux/netfilter.h:308 [inline]
> ip6_input+0xa1/0xc0 net/ipv6/ip6_input.c:492
> ip6_mc_input+0x48b/0xf40 net/ipv6/ip6_input.c:586
> dst_input include/net/dst.h:461 [inline]
> ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
> NF_HOOK include/linux/netfilter.h:314 [inline]
> NF_HOOK include/linux/netfilter.h:308 [inline]
> ipv6_rcv+0x24e/0x380 net/ipv6/ip6_input.c:310
> __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5529
> __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5643
> netif_receive_skb_internal net/core/dev.c:5729 [inline]
> netif_receive_skb+0x133/0x700 net/core/dev.c:5788
> tun_rx_batched+0x429/0x780 drivers/net/tun.c:1579
> tun_get_user+0x29e3/0x3bc0 drivers/net/tun.c:2002
> tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2048
> call_write_iter include/linux/fs.h:2020 [inline]
> new_sync_write fs/read_write.c:491 [inline]
> vfs_write+0x64f/0xdf0 fs/read_write.c:584
> ksys_write+0x12f/0x250 fs/read_write.c:637
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Freed by task 5123:
> kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
> kasan_set_track+0x25/0x30 mm/kasan/common.c:52
> kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
> ____kasan_slab_free mm/kasan/common.c:236 [inline]
> ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
> kasan_slab_free include/linux/kasan.h:164 [inline]
> slab_free_hook mm/slub.c:1800 [inline]
> slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
> slab_free mm/slub.c:3809 [inline]
> __kmem_cache_free+0xc0/0x180 mm/slub.c:3822
> rcu_do_batch kernel/rcu/tree.c:2158 [inline]
> rcu_core+0x819/0x1680 kernel/rcu/tree.c:2431
> __do_softirq+0x21a/0x8de kernel/softirq.c:553
> 
> Last potentially related work creation:
> kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
> __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
> __call_rcu_common.constprop.0+0x9a/0x7a0 kernel/rcu/tree.c:2681
> fib6_info_release include/net/ip6_fib.h:332 [inline]
> fib6_info_release include/net/ip6_fib.h:329 [inline]
> rt6_route_rcv+0xa4e/0xbf0 net/ipv6/route.c:997
> ndisc_router_discovery+0x138b/0x3560 net/ipv6/ndisc.c:1529
> ndisc_rcv+0x3de/0x5f0 net/ipv6/ndisc.c:1856
> icmpv6_rcv+0x1470/0x19c0 net/ipv6/icmp.c:979
> ip6_protocol_deliver_rcu+0x170/0x13e0 net/ipv6/ip6_input.c:438
> ip6_input_finish+0x14f/0x2f0 net/ipv6/ip6_input.c:483
> NF_HOOK include/linux/netfilter.h:314 [inline]
> NF_HOOK include/linux/netfilter.h:308 [inline]
> ip6_input+0xa1/0xc0 net/ipv6/ip6_input.c:492
> ip6_mc_input+0x48b/0xf40 net/ipv6/ip6_input.c:586
> dst_input include/net/dst.h:461 [inline]
> ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
> NF_HOOK include/linux/netfilter.h:314 [inline]
> NF_HOOK include/linux/netfilter.h:308 [inline]
> ipv6_rcv+0x24e/0x380 net/ipv6/ip6_input.c:310
> __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5529
> __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5643
> netif_receive_skb_internal net/core/dev.c:5729 [inline]
> netif_receive_skb+0x133/0x700 net/core/dev.c:5788
> tun_rx_batched+0x429/0x780 drivers/net/tun.c:1579
> tun_get_user+0x29e3/0x3bc0 drivers/net/tun.c:2002
> tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2048
> call_write_iter include/linux/fs.h:2020 [inline]
> new_sync_write fs/read_write.c:491 [inline]
> vfs_write+0x64f/0xdf0 fs/read_write.c:584
> ksys_write+0x12f/0x250 fs/read_write.c:637
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Second to last potentially related work creation:
> kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
> __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
> insert_work+0x38/0x230 kernel/workqueue.c:1647
> __queue_work+0xcdc/0x11f0 kernel/workqueue.c:1803
> call_timer_fn+0x193/0x590 kernel/time/timer.c:1700
> expire_timers kernel/time/timer.c:1746 [inline]
> __run_timers+0x585/0xb20 kernel/time/timer.c:2022
> run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
> __do_softirq+0x21a/0x8de kernel/softirq.c:553
> 
> The buggy address belongs to the object at ffff88802805a800
> which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 64 bytes inside of
> freed 512-byte region [ffff88802805a800, ffff88802805aa00)
> 
> The buggy address belongs to the physical page:
> page:ffffea0000a01600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28058
> head:ffffea0000a01600 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000000840 ffff888013041c80 ffffea0001e02600 dead000000000002
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 18706, tgid 18699 (syz-executor.2), ts 999991973280, free_ts 996884464281
> set_page_owner include/linux/page_owner.h:31 [inline]
> post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1537
> prep_new_page mm/page_alloc.c:1544 [inline]
> get_page_from_freelist+0xa25/0x36d0 mm/page_alloc.c:3312
> __alloc_pages+0x22e/0x2420 mm/page_alloc.c:4568
> alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
> alloc_slab_page mm/slub.c:1870 [inline]
> allocate_slab mm/slub.c:2017 [inline]
> new_slab+0x283/0x3c0 mm/slub.c:2070
> ___slab_alloc+0x979/0x1500 mm/slub.c:3223
> __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
> __slab_alloc_node mm/slub.c:3375 [inline]
> slab_alloc_node mm/slub.c:3468 [inline]
> __kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3517
> __do_kmalloc_node mm/slab_common.c:1006 [inline]
> __kmalloc+0x49/0x90 mm/slab_common.c:1020
> kmalloc include/linux/slab.h:604 [inline]
> kzalloc include/linux/slab.h:721 [inline]
> copy_splice_read+0x1ac/0x8f0 fs/splice.c:338
> vfs_splice_read fs/splice.c:992 [inline]
> vfs_splice_read+0x2ea/0x3b0 fs/splice.c:962
> splice_direct_to_actor+0x2a5/0xa30 fs/splice.c:1069
> do_splice_direct+0x1af/0x280 fs/splice.c:1194
> do_sendfile+0xb3e/0x1310 fs/read_write.c:1254
> __do_sys_sendfile64 fs/read_write.c:1322 [inline]
> __se_sys_sendfile64 fs/read_write.c:1308 [inline]
> __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
> page last free stack trace:
> reset_page_owner include/linux/page_owner.h:24 [inline]
> free_pages_prepare mm/page_alloc.c:1137 [inline]
> free_unref_page_prepare+0x4fa/0xaa0 mm/page_alloc.c:2347
> free_unref_page_list+0xe6/0xb40 mm/page_alloc.c:2533
> release_pages+0x32a/0x14f0 mm/swap.c:1042
> tlb_batch_pages_flush+0x9a/0x190 mm/mmu_gather.c:98
> tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
> tlb_flush_mmu mm/mmu_gather.c:300 [inline]
> tlb_finish_mmu+0x14b/0x6f0 mm/mmu_gather.c:392
> exit_mmap+0x38b/0xa70 mm/mmap.c:3321
> __mmput+0x12a/0x4d0 kernel/fork.c:1349
> mmput+0x62/0x70 kernel/fork.c:1371
> exit_mm kernel/exit.c:567 [inline]
> do_exit+0x9ad/0x2ae0 kernel/exit.c:858
> do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
> get_signal+0x23be/0x2790 kernel/signal.c:2904
> arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
> exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
> exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
> irqentry_exit_to_user_mode+0xa/0x40 kernel/entry/common.c:309
> asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   include/net/ip6_fib.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
> index 1ba9f4ddf2f6db6c6ebf0a0675ca74fea2273fd9..e1e7a894863a7891610ce5afb2034473cc208d3e 100644
> --- a/include/net/ip6_fib.h
> +++ b/include/net/ip6_fib.h
> @@ -328,8 +328,11 @@ static inline bool fib6_info_hold_safe(struct fib6_info *f6i)
>   
>   static inline void fib6_info_release(struct fib6_info *f6i)
>   {
> -	if (f6i && refcount_dec_and_test(&f6i->fib6_ref))
> +	if (f6i && refcount_dec_and_test(&f6i->fib6_ref)) {
> +		DEBUG_NET_WARN_ON_ONCE(fib6_has_expires(f6i));
> +		DEBUG_NET_WARN_ON_ONCE(!hlist_unhashed(&f6i->gc_link));
>   		call_rcu(&f6i->rcu, fib6_info_destroy_rcu);
> +	}
>   }
>   
>   enum fib6_walk_state {

