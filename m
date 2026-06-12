Return-Path: <netdev+bounces-298790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t0wlOW5vLGpSQwQAu9opvQ
	(envelope-from <netdev+bounces-298790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:43:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8217067C5EA
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:43:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298790-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298790-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A8643015739
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2384C345740;
	Fri, 12 Jun 2026 20:43:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C884352F85
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 20:43:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781297005; cv=none; b=d7buwf+5X9kCrwZ1a36paR4VnvEC6rld+SN7ZnjVTTEk84PNML8am7tu7VKhDFq9XadA1zQcCl9UYe1KKthydNGqJNu0bReRuLs81BD6MTIS1oO7QXQtgahCPyEnQgdg3qw1Bcvqe3AV5WQj3agvTeOj7N1OjRVXkrv0OiDNo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781297005; c=relaxed/simple;
	bh=Mk/TzSPcB23FaFQpom3znsABAWm2xiLiQ9gVMCM3YcU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NROWX7xa5BkhJbWXEoEOU/R+sCOo1SeTXdztWBP0F6TXRjGJ0s0SSIKND9mpJk5hTKXk9N6a6AbsRVtCLMmR4zf6jIu6hO+kqT71d05MzndnOTO9hYjJLh6AM4I/G1TLEaIIhpLBu6ULJWDfEIWabSY6AyMKuTBQZbDPPGPQolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-48679a595e2so1878984b6e.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781297002; x=1781901802;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+CvRzUaL2bhKQwd3Bgdddk2TEKH/mLaPQFUWxCE4Kbs=;
        b=bzuZ1hTYTO9SReck3jjxDTRwrSfG5ZrucO5Y74nXksAOYCoULX7vORqXlybj3i//qm
         msfYoUa9L0AamUBrYuBOJoMTA0W0t7dpc/THKDO7JQ8J26T5u9WUPasaI3XB1g4GYfPo
         Z5dPkOd7EgLZJ24mTW+r5aGhyK+EBqu2lrcmlBo2cEMAN+e0m/VBRhqz4ZvVoEBEh5Zq
         qX6YVhDjhgCdt3UiEfRkHCrL3yZSB8scsN8zq4D9gh1n4XGaV05DyNgD5fN4C/XJVwx0
         TPcJdRIWETeeDePUea7988NDCu6H7heJX78yiXcLLiUWQeuz5KRufDvInHBwhCDLQE7f
         5ljA==
X-Forwarded-Encrypted: i=1; AFNElJ980D49o4rc193pNoBlkYZSSMSdUzzM5rG09zsrXvqj2Y+5Hr1uYZhfefmnNmspbfx9pJ7Uw2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19jfOm0u+/GsXFHEB2eExAj0a4P9DScvdUboMOzUtJ1JSYxtT
	pPdlJud7HmoN4iEbySxnVK0BnQQcTdN2dXICjbw5vABrxgRHquyFnVxhH3A91+tm8qUW5VYEoV3
	NJzigEzM051jkUXVtUt5eao5OtnSMppfai2v7wN5W6/YRG4M5Pqjw41vDlSM=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fc9:b0:467:1da9:2b0f with SMTP id
 5614622812f47-4872f5eca26mr2902287b6e.34.1781297002501; Fri, 12 Jun 2026
 13:43:22 -0700 (PDT)
Date: Fri, 12 Jun 2026 13:43:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2c6f6a.be3f099c.2836ae.0004.GAE@google.com>
Subject: [syzbot] [mm?] KASAN: invalid-free in rcu_free_sheaf
From: syzbot <syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2c40e3284434c6f1];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298790-lists,netdev=lfdr.de,60332fd095f8bb2946ad];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,storage.googleapis.com:url,googlegroups.com:email,syzkaller.appspotmail.com:from_mime,syzkaller.appspot.com:url];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:netdev@vger.kernel.org,m:peterz@infradead.org,m:syzkaller-bugs@googlegroups.com,m:tglx@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8217067C5EA

Hello,

syzbot found the following issue on:

HEAD commit:    0ce346bf2f68 Merge branch 'net-shaper-follow-ups-to-recent..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15a50986580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c40e3284434c6f1
dashboard link: https://syzkaller.appspot.com/bug?extid=60332fd095f8bb2946ad
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fcb2184c91a0/disk-0ce346bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44a7baa2dfdd/vmlinux-0ce346bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ef85b3aefe3/bzImage-0ce346bf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in rcu_free_sheaf+0x31/0x200 mm/slub.c:5850
Free of addr ffff888026c2d380 by task ksoftirqd/0/15

CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:557
 check_slab_allocation mm/kasan/common.c:-1 [inline]
 __kasan_slab_pre_free+0x104/0x120 mm/kasan/common.c:261
 kasan_slab_pre_free include/linux/kasan.h:199 [inline]
 slab_free_hook mm/slub.c:2634 [inline]
 __rcu_free_sheaf_prepare+0x10a/0x2a0 mm/slub.c:2940
 rcu_free_sheaf+0x31/0x200 mm/slub.c:5850
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x840 kernel/softirq.c:622
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1076
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5613:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x31c/0x660 mm/slub.c:5420
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 hwsim_update_pib+0x88/0x450 drivers/net/ieee802154/mac802154_hwsim.c:101
 hwsim_set_promiscuous_mode+0x196/0x2e0 drivers/net/ieee802154/mac802154_hwsim.c:323
 drv_set_promiscuous_mode+0x159/0x2e0 net/mac802154/driver-ops.h:127
 drv_start net/mac802154/driver-ops.h:195 [inline]
 mac802154_slave_open net/mac802154/iface.c:196 [inline]
 mac802154_wpan_open+0x19b3/0x2a70 net/mac802154/iface.c:295
 __dev_open+0x44d/0x830 net/core/dev.c:1702
 __dev_change_flags+0x2fa/0x7e0 net/core/dev.c:9752
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9815
 do_setlink+0xfa5/0x45a0 net/core/rtnetlink.c:3207
 rtnl_changelink net/core/rtnetlink.c:3841 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4014 [inline]
 rtnl_newlink+0x15ad/0x1bb0 net/core/rtnetlink.c:4151
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:7068
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 __sys_sendto+0x672/0x710 net/socket.c:2265
 __do_sys_sendto net/socket.c:2272 [inline]
 __se_sys_sendto net/socket.c:2268 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2689 [inline]
 __rcu_free_sheaf_prepare+0x12d/0x2a0 mm/slub.c:2940
 rcu_free_sheaf+0x31/0x200 mm/slub.c:5850
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x840 kernel/softirq.c:622
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1076
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888026c2d380
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
 64-byte region [ffff888026c2d380, ffff888026c2d3c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888026c2d780 pfn:0x26c2d
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88813fe1a8c0 ffffea0000d74490 ffffea0001fcda50
raw: ffff888026c2d780 0000000800200010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 137, tgid 137 (kworker/u8:5), ts 5542876120, free_ts 5542851482
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x22d/0x280 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861 [inline]
 get_page_from_freelist+0x2593/0x2610 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5221
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x339/0x3d0 mm/slub.c:7272
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x321/0x720 mm/slub.c:4652
 alloc_from_pcs mm/slub.c:4750 [inline]
 slab_alloc_node mm/slub.c:4884 [inline]
 __do_kmalloc_node mm/slub.c:5295 [inline]
 __kmalloc_node_noprof+0x577/0x7c0 mm/slub.c:5302
 kmalloc_node_noprof include/linux/slab.h:1081 [inline]
 __vmalloc_area_node mm/vmalloc.c:3857 [inline]
 __vmalloc_node_range_noprof+0x5ef/0x1750 mm/vmalloc.c:4064
 __vmalloc_node_noprof+0xc2/0x100 mm/vmalloc.c:4124
 alloc_thread_stack_node kernel/fork.c:357 [inline]
 dup_task_struct+0x298/0x840 kernel/fork.c:926
 copy_process+0x89b/0x4440 kernel/fork.c:2090
 kernel_clone+0x2d7/0x940 kernel/fork.c:2722
 user_mode_thread+0x110/0x180 kernel/fork.c:2798
 call_usermodehelper_exec_work+0x5c/0x230 kernel/umh.c:171
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3397
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3478
page last free pid 137 tgid 137 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1397 [inline]
 __free_frozen_pages+0xc1c/0xd30 mm/page_alloc.c:2938
 __kasan_populate_vmalloc_do mm/kasan/shadow.c:393 [inline]
 __kasan_populate_vmalloc+0x1b2/0x1d0 mm/kasan/shadow.c:424
 kasan_populate_vmalloc include/linux/kasan.h:580 [inline]
 alloc_vmap_area+0xd47/0x1480 mm/vmalloc.c:2123
 __get_vm_area_node+0x1f8/0x300 mm/vmalloc.c:3226
 __vmalloc_node_range_noprof+0x36a/0x1750 mm/vmalloc.c:4024
 __vmalloc_node_noprof+0xc2/0x100 mm/vmalloc.c:4124
 alloc_thread_stack_node kernel/fork.c:357 [inline]
 dup_task_struct+0x298/0x840 kernel/fork.c:926
 copy_process+0x89b/0x4440 kernel/fork.c:2090
 kernel_clone+0x2d7/0x940 kernel/fork.c:2722
 user_mode_thread+0x110/0x180 kernel/fork.c:2798
 call_usermodehelper_exec_work+0x5c/0x230 kernel/umh.c:171
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3397
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3478
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888026c2d280: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888026c2d300: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888026c2d380: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff888026c2d400: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888026c2d480: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

