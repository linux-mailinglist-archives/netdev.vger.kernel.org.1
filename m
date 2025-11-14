Return-Path: <netdev+bounces-238642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4670DC5C954
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 11:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD293A6ED1
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C5930FC36;
	Fri, 14 Nov 2025 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGwDgGsH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA6F2FA0F2;
	Fri, 14 Nov 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116069; cv=none; b=jJCfjPtlWeId2GJYxSGs+X3HJ/W0BVt6b+zu7rBjcola0ZZIvLe9XYLtarGCJyuEqyW6mxKR21FpMbBgCWJ3IrXt729InmnrOo0ZyW8xr5K1gG8Vy70DMptSIetYVqfhhNhsSWMxQGS8gFUdJjBfCUM1KhtnhSu1W3TYvcmJs3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116069; c=relaxed/simple;
	bh=RTmM7fTyjP3bs7vHWQ8OBVi7VJf0cvB7mMLlycA2/pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jvpasJajKUllwPXZWKx7fxrcQPcGQqLuVRfRhmdxGTn51IegRZ10vaBIc26S2agmWJmacCVfZ5YghHhAppvkiNjoSoE8pCsqQjjlOfzLWK19QAsdN9DL9FrgFYwUCatj/PwaSlFmLD/GhR8bai9Q3DRNHHW+MfoY+sCzzs5DTuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGwDgGsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B66AC4CEF8;
	Fri, 14 Nov 2025 10:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763116068;
	bh=RTmM7fTyjP3bs7vHWQ8OBVi7VJf0cvB7mMLlycA2/pA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZGwDgGsHjSkuEz1nSvpvShkL8AE0ZEuVF+riBw1wLWm+BTUftbAfQhaKvUTVqY6sQ
	 4qbhTuwazN+XxSd8OhDf5zVnM0TfHAWXOMXkOs1rdX5n3pcRWYOpcVwuMYbb8zHcJg
	 aCPwHw0v8OcuEMOWneGU5A5zy1P6WkEeJZcqDL+Wn+oLk/5JgucaGuY7NQAk7c6RZP
	 yJ+QEsmMN2aFReN3mgBoF/UtYyaQH+Nb4qW79WGt1nf4kCH21H3yGm0+OWCQDXqdyk
	 innlrh/NIBZnhRbdDMTbMHHsIp+beYK/BMo8gFqsr36adnd+TCzoCvX2lL6ExcaVAh
	 /HzWiEGSB9A0g==
Message-ID: <8cda478a-c589-490f-8c34-38655a6c367d@kernel.org>
Date: Fri, 14 Nov 2025 11:27:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mptcp?] possible deadlock in mptcp_subflow_shutdown (2)
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>,
 syzbot <syzbot+7902f127c28c701e913f@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, geliang@kernel.org,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martineau@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <69113ffc.a70a0220.22f260.00cd.GAE@google.com>
 <327bfa84-c39c-4f6c-aaed-d9054f5d9ae6@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <327bfa84-c39c-4f6c-aaed-d9054f5d9ae6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 10/11/2025 09:41, Paolo Abeni wrote:
> On 11/10/25 2:29 AM, syzbot wrote:
>> syzbot found the following issue on:
>>
>> HEAD commit:    dc77806cf3b4 Merge tag 'rust-fixes-6.18' of git://git.kern..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17dd9bcd980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=19d831c6d0386a9c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=7902f127c28c701e913f
>> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/a1c9259ca92c/disk-dc77806c.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/98d084f2ad8b/vmlinux-dc77806c.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/c25e628e3491/bzImage-dc77806c.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+7902f127c28c701e913f@syzkaller.appspotmail.com
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> syzkaller #0 Not tainted
>> ------------------------------------------------------
>> syz.7.3695/23717 is trying to acquire lock:
>> ffff888087316860 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
>> ffff888087316860 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_subflow_shutdown+0x24/0x380 net/mptcp/protocol.c:2918
>>
>> but task is already holding lock:
>> ffff888026899a60 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
>> ffff888026899a60 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x1d/0xe0 net/mptcp/protocol.c:3168
>>
>> which lock already depends on the new lock.
>>
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #7 (sk_lock-AF_INET){+.+.}-{0:0}:
>>        lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
>>        lock_sock include/net/sock.h:1679 [inline]
>>        inet_shutdown+0x67/0x440 net/ipv4/af_inet.c:907
>>        nbd_mark_nsock_dead+0xae/0x5d0 drivers/block/nbd.c:319
>>        recv_work+0x671/0xa80 drivers/block/nbd.c:1024
>>        process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
>>        process_scheduled_works kernel/workqueue.c:3346 [inline]
>>        worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
>>        kthread+0x3c5/0x780 kernel/kthread.c:463
>>        ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
>>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>
>> -> #6 (&nsock->tx_lock){+.+.}-{4:4}:
>>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>>        __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>>        nbd_handle_cmd drivers/block/nbd.c:1146 [inline]
>>        nbd_queue_rq+0x423/0x12d0 drivers/block/nbd.c:1210
>>        blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2129
>>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>>        __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
>>        blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
>>        blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2367
>>        blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2928
>>        blk_mq_flush_plug_list block/blk-mq.c:2976 [inline]
>>        blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2948
>>        __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1225
>>        blk_finish_plug block/blk-core.c:1252 [inline]
>>        blk_finish_plug block/blk-core.c:1249 [inline]
>>        __submit_bio+0x545/0x690 block/blk-core.c:651
>>        __submit_bio_noacct_mq block/blk-core.c:724 [inline]
>>        submit_bio_noacct_nocheck+0x53d/0xc10 block/blk-core.c:755
>>        submit_bio_noacct+0x5bd/0x1f60 block/blk-core.c:879
>>        submit_bh fs/buffer.c:2829 [inline]
>>        block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
>>        filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2444
>>        do_read_cache_folio+0x263/0x5c0 mm/filemap.c:4024
>>        read_mapping_folio include/linux/pagemap.h:999 [inline]
>>        read_part_sector+0xd4/0x370 block/partitions/core.c:722
>>        adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
>>        check_partition block/partitions/core.c:141 [inline]
>>        blk_add_partitions block/partitions/core.c:589 [inline]
>>        bdev_disk_changed+0x723/0x1520 block/partitions/core.c:693
>>        blkdev_get_whole+0x187/0x290 block/bdev.c:748
>>        bdev_open+0x2c7/0xe40 block/bdev.c:957
>>        blkdev_open+0x34e/0x4f0 block/fops.c:701
>>        do_dentry_open+0x982/0x1530 fs/open.c:965
>>        vfs_open+0x82/0x3f0 fs/open.c:1097
>>        do_open fs/namei.c:3975 [inline]
>>        path_openat+0x1de4/0x2cb0 fs/namei.c:4134
>>        do_filp_open+0x20b/0x470 fs/namei.c:4161
>>        do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
>>        do_sys_open fs/open.c:1452 [inline]
>>        __do_sys_openat fs/open.c:1468 [inline]
>>        __se_sys_openat fs/open.c:1463 [inline]
>>        __x64_sys_openat+0x174/0x210 fs/open.c:1463
>>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>        do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> -> #5 (&cmd->lock){+.+.}-{4:4}:
>>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>>        __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>>        nbd_queue_rq+0xbd/0x12d0 drivers/block/nbd.c:1202
>>        blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2129
>>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>>        __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
>>        blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
>>        blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2367
>>        blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2928
>>        blk_mq_flush_plug_list block/blk-mq.c:2976 [inline]
>>        blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2948
>>        __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1225
>>        blk_finish_plug block/blk-core.c:1252 [inline]
>>        blk_finish_plug block/blk-core.c:1249 [inline]
>>        __submit_bio+0x545/0x690 block/blk-core.c:651
>>        __submit_bio_noacct_mq block/blk-core.c:724 [inline]
>>        submit_bio_noacct_nocheck+0x53d/0xc10 block/blk-core.c:755
>>        submit_bio_noacct+0x5bd/0x1f60 block/blk-core.c:879
>>        submit_bh fs/buffer.c:2829 [inline]
>>        block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
>>        filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2444
>>        do_read_cache_folio+0x263/0x5c0 mm/filemap.c:4024
>>        read_mapping_folio include/linux/pagemap.h:999 [inline]
>>        read_part_sector+0xd4/0x370 block/partitions/core.c:722
>>        adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
>>        check_partition block/partitions/core.c:141 [inline]
>>        blk_add_partitions block/partitions/core.c:589 [inline]
>>        bdev_disk_changed+0x723/0x1520 block/partitions/core.c:693
>>        blkdev_get_whole+0x187/0x290 block/bdev.c:748
>>        bdev_open+0x2c7/0xe40 block/bdev.c:957
>>        blkdev_open+0x34e/0x4f0 block/fops.c:701
>>        do_dentry_open+0x982/0x1530 fs/open.c:965
>>        vfs_open+0x82/0x3f0 fs/open.c:1097
>>        do_open fs/namei.c:3975 [inline]
>>        path_openat+0x1de4/0x2cb0 fs/namei.c:4134
>>        do_filp_open+0x20b/0x470 fs/namei.c:4161
>>        do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
>>        do_sys_open fs/open.c:1452 [inline]
>>        __do_sys_openat fs/open.c:1468 [inline]
>>        __se_sys_openat fs/open.c:1463 [inline]
>>        __x64_sys_openat+0x174/0x210 fs/open.c:1463
>>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>        do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> -> #4 (set->srcu){.+.+}-{0:0}:
>>        srcu_lock_sync include/linux/srcu.h:173 [inline]
>>        __synchronize_srcu+0xa1/0x290 kernel/rcu/srcutree.c:1439
>>        blk_mq_wait_quiesce_done block/blk-mq.c:283 [inline]
>>        blk_mq_wait_quiesce_done block/blk-mq.c:280 [inline]
>>        blk_mq_quiesce_queue block/blk-mq.c:303 [inline]
>>        blk_mq_quiesce_queue+0x149/0x1b0 block/blk-mq.c:298
>>        elevator_switch+0x17d/0x810 block/elevator.c:588
>>        elevator_change+0x391/0x5d0 block/elevator.c:691
>>        elevator_set_default+0x2e9/0x380 block/elevator.c:767
>>        blk_register_queue+0x384/0x4e0 block/blk-sysfs.c:942
>>        __add_disk+0x74a/0xf00 block/genhd.c:528
>>        add_disk_fwnode+0x13f/0x5d0 block/genhd.c:597
>>        add_disk include/linux/blkdev.h:775 [inline]
>>        nbd_dev_add+0x783/0xbb0 drivers/block/nbd.c:1987
>>        nbd_init+0x1a2/0x3c0 drivers/block/nbd.c:2702
>>        do_one_initcall+0x123/0x6e0 init/main.c:1283
>>        do_initcall_level init/main.c:1345 [inline]
>>        do_initcalls init/main.c:1361 [inline]
>>        do_basic_setup init/main.c:1380 [inline]
>>        kernel_init_freeable+0x5c8/0x920 init/main.c:1593
>>        kernel_init+0x1c/0x2b0 init/main.c:1483
>>        ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
>>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>
>> -> #3 (&q->elevator_lock){+.+.}-{4:4}:
>>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>>        __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>>        queue_requests_store+0x3a7/0x670 block/blk-sysfs.c:117
>>        queue_attr_store+0x26b/0x310 block/blk-sysfs.c:869
>>        sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
>>        kernfs_fop_write_iter+0x3af/0x570 fs/kernfs/file.c:352
>>        new_sync_write fs/read_write.c:593 [inline]
>>        vfs_write+0x7d3/0x11d0 fs/read_write.c:686
>>        ksys_write+0x12a/0x250 fs/read_write.c:738
>>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>        do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> -> #2 (&q->q_usage_counter(io)#52){++++}-{0:0}:
>>        blk_alloc_queue+0x619/0x760 block/blk-core.c:461
>>        blk_mq_alloc_queue+0x172/0x280 block/blk-mq.c:4399
>>        __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4446
>>        nbd_dev_add+0x492/0xbb0 drivers/block/nbd.c:1957
>>        nbd_init+0x1a2/0x3c0 drivers/block/nbd.c:2702
>>        do_one_initcall+0x123/0x6e0 init/main.c:1283
>>        do_initcall_level init/main.c:1345 [inline]
>>        do_initcalls init/main.c:1361 [inline]
>>        do_basic_setup init/main.c:1380 [inline]
>>        kernel_init_freeable+0x5c8/0x920 init/main.c:1593
>>        kernel_init+0x1c/0x2b0 init/main.c:1483
>>        ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
>>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>
>> -> #1 (fs_reclaim){+.+.}-{0:0}:
>>        __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
>>        fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4283
>>        might_alloc include/linux/sched/mm.h:318 [inline]
>>        slab_pre_alloc_hook mm/slub.c:4921 [inline]
>>        slab_alloc_node mm/slub.c:5256 [inline]
>>        __kmalloc_cache_noprof+0x58/0x780 mm/slub.c:5758
>>        kmalloc_noprof include/linux/slab.h:957 [inline]
>>        kzalloc_noprof include/linux/slab.h:1094 [inline]
>>        ref_tracker_alloc+0x18e/0x5b0 lib/ref_tracker.c:271
>>        __netns_tracker_alloc include/net/net_namespace.h:362 [inline]
>>        netns_tracker_alloc include/net/net_namespace.h:371 [inline]
>>        get_net_track include/net/net_namespace.h:388 [inline]
>>        sk_net_refcnt_upgrade+0x141/0x1e0 net/core/sock.c:2384
>>        rds_tcp_tune+0x23d/0x530 net/rds/tcp.c:507
>>        rds_tcp_conn_path_connect+0x305/0x7f0 net/rds/tcp_connect.c:127
>>        rds_connect_worker+0x1af/0x2c0 net/rds/threads.c:176
>>        process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
>>        process_scheduled_works kernel/workqueue.c:3346 [inline]
>>        worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
>>        kthread+0x3c5/0x780 kernel/kthread.c:463
>>        ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
>>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>
>> -> #0 (k-sk_lock-AF_INET){+.+.}-{0:0}:
>>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>>        validate_chain kernel/locking/lockdep.c:3908 [inline]
>>        __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
>>        lock_acquire kernel/locking/lockdep.c:5868 [inline]
>>        lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
>>        lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
>>        lock_sock include/net/sock.h:1679 [inline]
>>        mptcp_subflow_shutdown+0x24/0x380 net/mptcp/protocol.c:2918
>>        mptcp_check_send_data_fin+0x248/0x440 net/mptcp/protocol.c:3022
>>        __mptcp_close+0x90e/0xbe0 net/mptcp/protocol.c:3116
>>        mptcp_close+0x28/0xe0 net/mptcp/protocol.c:3170
>>        inet_release+0xed/0x200 net/ipv4/af_inet.c:437
>>        __sock_release+0xb3/0x270 net/socket.c:662
>>        sock_close+0x1c/0x30 net/socket.c:1455
>>        __fput+0x402/0xb70 fs/file_table.c:468
>>        task_work_run+0x150/0x240 kernel/task_work.c:227
>>        resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>        exit_to_user_mode_loop+0xec/0x130 kernel/entry/common.c:43
>>        exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>>        syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>>        syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>>        do_syscall_64+0x426/0xfa0 arch/x86/entry/syscall_64.c:100
>>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> other info that might help us debug this:
>>
>> Chain exists of:
>>   k-sk_lock-AF_INET --> &nsock->tx_lock --> sk_lock-AF_INET
> 
> It looks like a false positive due to mptcp subflows and nbd connection
> sockets getting the lockdep annotation. We should possibly/likely use a
> specific lockdep key for mptcp subflows.

As noted by Paolo offline, it looks like this issue is due to nbd
introducing a lockdep dependency between reclaim and af_socket, and this
is similar to a previous report:

#syz dup: [syzbot] [mptcp?] possible deadlock in
mptcp_subflow_create_socket (2)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


