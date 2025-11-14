Return-Path: <netdev+bounces-238646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0022C5CB6D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 11:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3857D4E32B8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7A9311973;
	Fri, 14 Nov 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiE4Z7di"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DE526E703;
	Fri, 14 Nov 2025 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117519; cv=none; b=FvwQcCgcWkpKaCzhjZtGqUpsfi2SV2CffDgKP7MAIuHj2eZkk7L0FPS5VeAZxxX1YNeVQR1mTtFyD8gzRRkhespSafU32KUHSgGwiVUTy/NsueaUMzkt1Irc+Hx2qDxlmGScUCBCPIqy3WVRCxmYA7Oi03i13vm7qTqTcZJWOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117519; c=relaxed/simple;
	bh=K2BXCX3kDyE4cwc2z5urjlXij8gU5+0GWSrPBEn1sFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dKg4Q7W2ffpFChR+miNcz5UNPk/7LGDjQNrrHni6DNVEx1+VZ3OH2B4ti/5hATwvsm+HLj6utrIz1X2Bg+ij0feAoGtcM9lfMT/DkK9PN44s7gZvv278mQDhKfzLWbEaQfYKS8RLlFATpxllrzPfgetjSx6+QqOKtlAfbxkQMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiE4Z7di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00614C116D0;
	Fri, 14 Nov 2025 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763117518;
	bh=K2BXCX3kDyE4cwc2z5urjlXij8gU5+0GWSrPBEn1sFc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iiE4Z7dinpClndLDrs1qifrJ40ZNJoyMUmxHo96S14BMYXNmXr+z/F8y/OCrYW2Da
	 rH7gA8L6avnWOXG78D9p3QFcg4X2KKDCyDj8ILHo18/ta7KJ6QbkvbkQei3Higavqj
	 UHuWzGvNTDWXj2pq4i8m5DHgXp4KwPEDbiJK0QVXDOjVnTWwBBiqXFCs0qNF5BOjnw
	 b/Wt6FWCAmmhWQGU1Z/Ro8G1pnX1YQ/BmaEtTE9aic/u5VkJqZSkHN7ema33mBhe+L
	 jb52FlPiRfwylVtolLV3Bnur9PL+fWNBp19I79egqRuoTpAihFBOEzRKLIZRuawRJ5
	 8l8+TJEQv8Kvw==
Message-ID: <a59e81d0-35a3-4acf-a123-30cc1c659d03@kernel.org>
Date: Fri, 14 Nov 2025 11:51:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mptcp?] possible deadlock in mptcp_pm_nl_add_addr_doit
Content-Language: en-GB, fr-BE
To: syzbot <syzbot+7fb125d1bae280dc4749@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, geliang@kernel.org,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martineau@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <68e3a493.a00a0220.298cc0.045f.GAE@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <68e3a493.a00a0220.298cc0.045f.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 06/10/2025 13:14, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3b9b1f8df454 Add linux-next specific files for 20250929
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=133df05b980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c7c078c891391b1
> dashboard link: https://syzkaller.appspot.com/bug?extid=7fb125d1bae280dc4749
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1ccfc1a8eb22/disk-3b9b1f8d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c4e52fa84079/vmlinux-3b9b1f8d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9eacf34feeec/bzImage-3b9b1f8d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7fb125d1bae280dc4749@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> syz.5.3503/26785 is trying to acquire lock:
> ffffffff8e645220 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:318 [inline]
> ffffffff8e645220 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4897 [inline]
> ffffffff8e645220 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:5221 [inline]
> ffffffff8e645220 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_node_noprof+0x48/0x710 mm/slub.c:5297
> 
> but task is already holding lock:
> ffff888066ee0f18 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
> ffff888066ee0f18 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_create_listen_socket net/mptcp/pm_kernel.c:866 [inline]
> ffff888066ee0f18 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_add_addr_doit+0x1150/0x1460 net/mptcp/pm_kernel.c:1005
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #7 (k-sk_lock-AF_INET){+.+.}-{0:0}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        lock_sock_nested+0x48/0x100 net/core/sock.c:3720
>        lock_sock include/net/sock.h:1679 [inline]
>        __inet_bind+0x392/0xa90 net/ipv4/af_inet.c:524
>        mptcp_bind+0x128/0x1d0 net/mptcp/protocol.c:3846
>        __sys_bind_socket net/socket.c:1861 [inline]
>        __sys_bind+0x2c6/0x3e0 net/socket.c:1892
>        __do_sys_bind net/socket.c:1897 [inline]
>        __se_sys_bind net/socket.c:1895 [inline]
>        __x64_sys_bind+0x7a/0x90 net/socket.c:1895
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #6 (sk_lock-AF_INET){+.+.}-{0:0}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        lock_sock_nested+0x48/0x100 net/core/sock.c:3720
>        lock_sock include/net/sock.h:1679 [inline]
>        inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:907
>        nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
>        sock_shutdown+0x15e/0x260 drivers/block/nbd.c:411
>        nbd_clear_sock drivers/block/nbd.c:1424 [inline]
>        nbd_config_put+0x342/0x790 drivers/block/nbd.c:1448
>        nbd_release+0xfe/0x140 drivers/block/nbd.c:1753
>        bdev_release+0x536/0x650 block/bdev.c:-1
>        blkdev_release+0x15/0x20 block/fops.c:702
>        __fput+0x44c/0xa70 fs/file_table.c:468
>        task_work_run+0x1d4/0x260 kernel/task_work.c:227
>        resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>        exit_to_user_mode_loop+0xe9/0x130 kernel/entry/common.c:43
>        exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>        syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>        syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>        do_syscall_64+0x2bd/0xfa0 arch/x86/entry/syscall_64.c:100
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #5 (&nsock->tx_lock){+.+.}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
>        nbd_handle_cmd drivers/block/nbd.c:1140 [inline]
>        nbd_queue_rq+0x257/0xf10 drivers/block/nbd.c:1204
>        blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2367
>        blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
>        blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
>        __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
>        blk_finish_plug block/blk-core.c:1252 [inline]
>        __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
>        __submit_bio_noacct_mq block/blk-core.c:724 [inline]
>        submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
>        submit_bh fs/buffer.c:2829 [inline]
>        block_read_full_folio+0x599/0x830 fs/buffer.c:2447
>        filemap_read_folio+0x117/0x380 mm/filemap.c:2444
>        do_read_cache_folio+0x350/0x590 mm/filemap.c:4024
>        read_mapping_folio include/linux/pagemap.h:999 [inline]
>        read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
>        adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:141 [inline]
>        blk_add_partitions block/partitions/core.c:589 [inline]
>        bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
>        blkdev_get_whole+0x380/0x510 block/bdev.c:748
>        bdev_open+0x31e/0xd30 block/bdev.c:957
>        blkdev_open+0x457/0x600 block/fops.c:694
>        do_dentry_open+0x953/0x13f0 fs/open.c:965
>        vfs_open+0x3b/0x340 fs/open.c:1097
>        do_open fs/namei.c:3975 [inline]
>        path_openat+0x2ee5/0x3830 fs/namei.c:4134
>        do_filp_open+0x1fa/0x410 fs/namei.c:4161
>        do_sys_openat2+0x121/0x1c0 fs/open.c:1437
>        do_sys_open fs/open.c:1452 [inline]
>        __do_sys_openat fs/open.c:1468 [inline]
>        __se_sys_openat fs/open.c:1463 [inline]
>        __x64_sys_openat+0x138/0x170 fs/open.c:1463
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #4 (&cmd->lock){+.+.}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
>        nbd_queue_rq+0xc8/0xf10 drivers/block/nbd.c:1196
>        blk_mq_dispatch_rq_list+0x4c0/0x1900 block/blk-mq.c:2129
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xda4/0x1570 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2367
>        blk_mq_dispatch_list+0xd0c/0xe00 include/linux/spinlock.h:-1
>        blk_mq_flush_plug_list+0x469/0x550 block/blk-mq.c:2976
>        __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
>        blk_finish_plug block/blk-core.c:1252 [inline]
>        __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
>        __submit_bio_noacct_mq block/blk-core.c:724 [inline]
>        submit_bio_noacct_nocheck+0x2fb/0xa50 block/blk-core.c:755
>        submit_bh fs/buffer.c:2829 [inline]
>        block_read_full_folio+0x599/0x830 fs/buffer.c:2447
>        filemap_read_folio+0x117/0x380 mm/filemap.c:2444
>        do_read_cache_folio+0x350/0x590 mm/filemap.c:4024
>        read_mapping_folio include/linux/pagemap.h:999 [inline]
>        read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
>        adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:141 [inline]
>        blk_add_partitions block/partitions/core.c:589 [inline]
>        bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
>        blkdev_get_whole+0x380/0x510 block/bdev.c:748
>        bdev_open+0x31e/0xd30 block/bdev.c:957
>        blkdev_open+0x457/0x600 block/fops.c:694
>        do_dentry_open+0x953/0x13f0 fs/open.c:965
>        vfs_open+0x3b/0x340 fs/open.c:1097
>        do_open fs/namei.c:3975 [inline]
>        path_openat+0x2ee5/0x3830 fs/namei.c:4134
>        do_filp_open+0x1fa/0x410 fs/namei.c:4161
>        do_sys_openat2+0x121/0x1c0 fs/open.c:1437
>        do_sys_open fs/open.c:1452 [inline]
>        __do_sys_openat fs/open.c:1468 [inline]
>        __se_sys_openat fs/open.c:1463 [inline]
>        __x64_sys_openat+0x138/0x170 fs/open.c:1463
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #3 (set->srcu){.+.+}-{0:0}:
>        lock_sync+0xba/0x160 kernel/locking/lockdep.c:5916
>        srcu_lock_sync include/linux/srcu.h:173 [inline]
>        __synchronize_srcu+0x96/0x3a0 kernel/rcu/srcutree.c:1439
>        elevator_switch+0x12b/0x640 block/elevator.c:588
>        elevator_change+0x315/0x4c0 block/elevator.c:691
>        elevator_set_default+0x186/0x260 block/elevator.c:767
>        blk_register_queue+0x34e/0x3f0 block/blk-sysfs.c:942
>        __add_disk+0x677/0xd50 block/genhd.c:528
>        add_disk_fwnode+0xfc/0x480 block/genhd.c:597
>        add_disk include/linux/blkdev.h:775 [inline]
>        nbd_dev_add+0x717/0xae0 drivers/block/nbd.c:1981
>        nbd_init+0x168/0x1f0 drivers/block/nbd.c:2688
>        do_one_initcall+0x236/0x820 init/main.c:1283
>        do_initcall_level+0x104/0x190 init/main.c:1345
>        do_initcalls+0x59/0xa0 init/main.c:1361
>        kernel_init_freeable+0x334/0x4b0 init/main.c:1593
>        kernel_init+0x1d/0x1d0 init/main.c:1483
>        ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #2 (&q->elevator_lock){+.+.}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
>        elevator_change+0x1e5/0x4c0 block/elevator.c:689
>        elevator_set_none+0x42/0xb0 block/elevator.c:782
>        blk_mq_elv_switch_none block/blk-mq.c:5032 [inline]
>        __blk_mq_update_nr_hw_queues block/blk-mq.c:5075 [inline]
>        blk_mq_update_nr_hw_queues+0x598/0x1ab0 block/blk-mq.c:5133
>        nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1486
>        nbd_genl_connect+0x135b/0x18f0 drivers/block/nbd.c:2236
>        genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
>        genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>        genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
>        netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>        netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>        netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
>        netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
>        sock_sendmsg_nosec net/socket.c:714 [inline]
>        __sock_sendmsg+0x21c/0x270 net/socket.c:729
>        ____sys_sendmsg+0x505/0x830 net/socket.c:2617
>        ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2671
>        __sys_sendmsg net/socket.c:2703 [inline]
>        __do_sys_sendmsg net/socket.c:2708 [inline]
>        __se_sys_sendmsg net/socket.c:2706 [inline]
>        __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2706
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #1 (&q->q_usage_counter(io)#49){++++}-{0:0}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        blk_alloc_queue+0x538/0x620 block/blk-core.c:461
>        blk_mq_alloc_queue block/blk-mq.c:4399 [inline]
>        __blk_mq_alloc_disk+0x15c/0x340 block/blk-mq.c:4446
>        nbd_dev_add+0x46c/0xae0 drivers/block/nbd.c:1951
>        nbd_init+0x168/0x1f0 drivers/block/nbd.c:2688
>        do_one_initcall+0x236/0x820 init/main.c:1283
>        do_initcall_level+0x104/0x190 init/main.c:1345
>        do_initcalls+0x59/0xa0 init/main.c:1361
>        kernel_init_freeable+0x334/0x4b0 init/main.c:1593
>        kernel_init+0x1d/0x1d0 init/main.c:1483
>        ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #0 (fs_reclaim){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
>        __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
>        __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
>        fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4283
>        might_alloc include/linux/sched/mm.h:318 [inline]
>        slab_pre_alloc_hook mm/slub.c:4897 [inline]
>        slab_alloc_node mm/slub.c:5221 [inline]
>        kmem_cache_alloc_node_noprof+0x48/0x710 mm/slub.c:5297
>        __alloc_skb+0x112/0x2d0 net/core/skbuff.c:660
>        alloc_skb include/linux/skbuff.h:1383 [inline]
>        nlmsg_new include/net/netlink.h:1055 [inline]
>        mptcp_event_pm_listener+0x134/0x520 net/mptcp/pm_netlink.c:532
>        mptcp_pm_nl_create_listen_socket net/mptcp/pm_kernel.c:870 [inline]
>        mptcp_pm_nl_add_addr_doit+0x11da/0x1460 net/mptcp/pm_kernel.c:1005
>        genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
>        genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>        genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
>        netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>        netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>        netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
>        netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
>        sock_sendmsg_nosec net/socket.c:714 [inline]
>        __sock_sendmsg+0x21c/0x270 net/socket.c:729
>        ____sys_sendmsg+0x505/0x830 net/socket.c:2617
>        ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2671
>        __sys_sendmsg net/socket.c:2703 [inline]
>        __do_sys_sendmsg net/socket.c:2708 [inline]
>        __se_sys_sendmsg net/socket.c:2706 [inline]
>        __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2706
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   fs_reclaim --> sk_lock-AF_INET --> k-sk_lock-AF_INET

As noted by Paolo offline, it looks like this issue is due to nbd
introducing a lockdep dependency between reclaim and af_socket, and this
is similar to a previous report:

#syz dup: [syzbot] [mptcp?] possible deadlock in mptcp_subflow_create_socket (2)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


