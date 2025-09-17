Return-Path: <netdev+bounces-223834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B73B7D0DB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A419432167F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 02:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA12F363C;
	Wed, 17 Sep 2025 02:42:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9931BC8B;
	Wed, 17 Sep 2025 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076977; cv=none; b=BKBk7EbLTm2dId7LfHaat2U5rYD8VhNufJyJDAmZg0rCpfoVD80P0m/OLpXxvg5zL4FJW/vro//BXi2EGF4aLOXNp5GW1p+fkiPB8Qk/cpQH/kW/gQGxeINnNIppHrrdVUkFJay3jPTfjSQQJNqTQe05NRwnngr+65Iw4cz5TNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076977; c=relaxed/simple;
	bh=f/PXRMpBfdJOg/apFzc/tZRkAV2PwX6Tv9SgMWOry4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H01hGJIRTx1LwVlpqZ9tFNH6mXLVdauTvr96HKdUZlqlD8Zzo+Jx0fRQSa8d0N05zjXNv6PiSidPzRFSRwIHfB4oLaSEvr6QsgGTY6J0dEV2u7Q+6bI9+FOhGxkIFzaO66R9AgxBNXnNEi5ermlb12M5IisyhMWmwOta6eyxpOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cRNHk2XPDz13N9q;
	Wed, 17 Sep 2025 10:38:42 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B69C180064;
	Wed, 17 Sep 2025 10:42:51 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Sep 2025 10:42:50 +0800
Message-ID: <00ce3ed1-f2a6-4366-b01c-34cd6a45ae87@huawei.com>
Date: Wed, 17 Sep 2025 10:42:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in napi_gro_frags
 (2)
To: syzbot <syzbot+64e24275ad95a915a313@syzkaller.appspotmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<lorenzo@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller-bugs@googlegroups.com>, <toke@redhat.com>, yuehaibing
	<yuehaibing@huawei.com>
References: <68c9a275.050a0220.3c6139.0e62.GAE@google.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <68c9a275.050a0220.3c6139.0e62.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500016.china.huawei.com (7.185.36.197)

#syz test

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 86a9e927d0ff..a95b1edb80bd 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1875,6 +1875,9 @@ static ssize_t tun_get_user(struct tun_struct 
*tun, struct tun_file *tfile,
                                 local_bh_enable();
                                 goto unlock_frags;
                         }
+
+                       if (skb != tfile->napi.skb)
+                               tfile->napi.skb = skb;
                 }
                 rcu_read_unlock();
                 local_bh_enable();

在 2025/9/17 1:46, syzbot 写道:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f3883b1ea5a8 selftests: net: move netlink-dumps back to pr..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=156f4642580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a6c33a7db07dbea2
> dashboard link: https://syzkaller.appspot.com/bug?extid=64e24275ad95a915a313
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1274d562580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1674d562580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0ee19c85bfb5/disk-f3883b1e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e4e07abc0c5d/vmlinux-f3883b1e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d4ed4e8369cf/bzImage-f3883b1e.xz
>
> The issue was bisected to:
>
> commit e6d5dbdd20aa6a86974af51deb9414cd2e7794cb
> Author: Lorenzo Bianconi <lorenzo@kernel.org>
> Date:   Mon Feb 12 09:50:56 2024 +0000
>
>      xdp: add multi-buff support for xdp running in generic mode
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17377562580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14b77562580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b77562580000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+64e24275ad95a915a313@syzkaller.appspotmail.com
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
>
> syz.0.17 uses obsolete (PF_INET,SOCK_PACKET)
> ==================================================================
> BUG: KASAN: slab-use-after-free in skb_reset_mac_header include/linux/skbuff.h:3150 [inline]
> BUG: KASAN: slab-use-after-free in napi_frags_skb net/core/gro.c:723 [inline]
> BUG: KASAN: slab-use-after-free in napi_gro_frags+0x6e/0x1030 net/core/gro.c:758
> Read of size 8 at addr ffff88802ef22c18 by task syz.0.17/6079
>
> CPU: 0 UID: 0 PID: 6079 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0xca/0x240 mm/kasan/report.c:482
>   kasan_report+0x118/0x150 mm/kasan/report.c:595
>   skb_reset_mac_header include/linux/skbuff.h:3150 [inline]
>   napi_frags_skb net/core/gro.c:723 [inline]
>   napi_gro_frags+0x6e/0x1030 net/core/gro.c:758
>   tun_get_user+0x28cb/0x3e20 drivers/net/tun.c:1920
>   tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
>   new_sync_write fs/read_write.c:593 [inline]
>   vfs_write+0x5c9/0xb30 fs/read_write.c:686
>   ksys_write+0x145/0x250 fs/read_write.c:738
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2f9b98ebe9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffe90190e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f2f9bbc5fa0 RCX: 00007f2f9b98ebe9
> RDX: 000000000000004b RSI: 0000200000000340 RDI: 0000000000000003
> RBP: 00007f2f9ba11e19 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f2f9bbc5fa0 R14: 00007f2f9bbc5fa0 R15: 0000000000000003
>   </TASK>
>
> Allocated by task 6079:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>   unpoison_slab_object mm/kasan/common.c:330 [inline]
>   __kasan_mempool_unpoison_object+0xa0/0x170 mm/kasan/common.c:558
>   kasan_mempool_unpoison_object include/linux/kasan.h:388 [inline]
>   napi_skb_cache_get+0x37b/0x6d0 net/core/skbuff.c:295
>   __alloc_skb+0x11e/0x2d0 net/core/skbuff.c:657
>   napi_alloc_skb+0x84/0x7d0 net/core/skbuff.c:811
>   napi_get_frags+0x69/0x140 net/core/gro.c:673
>   tun_napi_alloc_frags drivers/net/tun.c:1404 [inline]
>   tun_get_user+0x77c/0x3e20 drivers/net/tun.c:1784
>   tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
>   new_sync_write fs/read_write.c:593 [inline]
>   vfs_write+0x5c9/0xb30 fs/read_write.c:686
>   ksys_write+0x145/0x250 fs/read_write.c:738
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 6079:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>   kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
>   poison_slab_object mm/kasan/common.c:243 [inline]
>   __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
>   kasan_slab_free include/linux/kasan.h:233 [inline]
>   slab_free_hook mm/slub.c:2422 [inline]
>   slab_free mm/slub.c:4695 [inline]
>   kmem_cache_free+0x18f/0x400 mm/slub.c:4797
>   skb_pp_cow_data+0xdd8/0x13e0 net/core/skbuff.c:969
>   netif_skb_check_for_xdp net/core/dev.c:5390 [inline]
>   netif_receive_generic_xdp net/core/dev.c:5431 [inline]
>   do_xdp_generic+0x699/0x11a0 net/core/dev.c:5499
>   tun_get_user+0x2523/0x3e20 drivers/net/tun.c:1872
>   tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
>   new_sync_write fs/read_write.c:593 [inline]
>   vfs_write+0x5c9/0xb30 fs/read_write.c:686
>   ksys_write+0x145/0x250 fs/read_write.c:738
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The buggy address belongs to the object at ffff88802ef22b40
>   which belongs to the cache skbuff_head_cache of size 240
> The buggy address is located 216 bytes inside of
>   freed 240-byte region [ffff88802ef22b40, ffff88802ef22c30)
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ef22
> flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000000 ffff88801e29ca00 ffffea0000a31b80 dead000000000004
> raw: 0000000000000000 00000000000c000c 00000000f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 19816261324, free_ts 18915708978
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
>   prep_new_page mm/page_alloc.c:1859 [inline]
>   get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
>   __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
>   alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
>   alloc_slab_page mm/slub.c:2492 [inline]
>   allocate_slab+0x8a/0x370 mm/slub.c:2660
>   new_slab mm/slub.c:2714 [inline]
>   ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
>   __slab_alloc mm/slub.c:3992 [inline]
>   __slab_alloc_node mm/slub.c:4067 [inline]
>   slab_alloc_node mm/slub.c:4228 [inline]
>   kmem_cache_alloc_node_noprof+0x280/0x3c0 mm/slub.c:4292
>   __alloc_skb+0x112/0x2d0 net/core/skbuff.c:659
>   alloc_skb include/linux/skbuff.h:1377 [inline]
>   nlmsg_new include/net/netlink.h:1055 [inline]
>   rtmsg_ifinfo_build_skb+0x84/0x260 net/core/rtnetlink.c:4392
>   rtmsg_ifinfo_event net/core/rtnetlink.c:4434 [inline]
>   rtmsg_ifinfo+0x8c/0x1a0 net/core/rtnetlink.c:4443
>   register_netdevice+0x1712/0x1ae0 net/core/dev.c:11307
>   register_netdev+0x40/0x60 net/core/dev.c:11371
>   nr_proto_init+0x145/0x710 net/netrom/af_netrom.c:1424
>   do_one_initcall+0x233/0x820 init/main.c:1269
>   do_initcall_level+0x104/0x190 init/main.c:1331
>   do_initcalls+0x59/0xa0 init/main.c:1347
> page last free pid 920 tgid 920 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1395 [inline]
>   __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
>   vfree+0x25a/0x400 mm/vmalloc.c:3434
>   delayed_vfree_work+0x55/0x80 mm/vmalloc.c:3353
>   process_one_work kernel/workqueue.c:3236 [inline]
>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>   kthread+0x70e/0x8a0 kernel/kthread.c:463
>   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> Memory state around the buggy address:
>   ffff88802ef22b00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>   ffff88802ef22b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff88802ef22c00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>                              ^
>   ffff88802ef22c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88802ef22d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

