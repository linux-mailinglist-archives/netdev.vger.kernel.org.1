Return-Path: <netdev+bounces-15304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6797C746B96
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 10:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB541C208F6
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C708186C;
	Tue,  4 Jul 2023 08:10:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471881866
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:10:51 +0000 (UTC)
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B442E4F
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 01:10:48 -0700 (PDT)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-262e0b15ad3so7135372a91.2
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 01:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688458247; x=1691050247;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7xwhrlzcysPZgD7raFUrW5vjIVCVs0H5URIJbA37uU=;
        b=b30NQFyOiv4sgh01R9lV7UXiSgZc8Id8KvZjO9ydixlW+XsJVVZJOP8NhsbPEq8AhX
         hQXWYT2r8UqCnySC3tfaBdXrs19rvtnfhWye9K2tOr8Vwzoa10FqvCg1ivEOtfL3cDUK
         uDeNnA1oho7jqalmQsX21QYnnnd1Un+mMYUgR5kgDTlwbs+8SHt0xYzrw3NVBt/Di5Me
         AO00wkvZQwoqAzaHbjcDZc6CglU/0V60sctNvj71h7vvyN7ylcJSj440D3I9hex6uHco
         sHYgtRWFHYmxk2rlE+o4o8YFsoH04SV1rKm6agTDprOVJlRUZfxIRCTcwp/m+fIckMQa
         bDBw==
X-Gm-Message-State: ABy/qLbvwbJHqVayRn0wGagHiaIvzoBIAktbuuG9RAbUSrRn8CYg57gH
	ax/e9hUY7BYUNfstYmJMVgohliO2xDG+S0WinEcebmrmB1iN
X-Google-Smtp-Source: APBJJlF614BsBKSxk9mPoRcakWxeYZ7WHS+xp5jhGmJU5TV7o4+jcZEV5f0oXUJsx+7U5fnOKazTAJi2RqTP5tzo/673IeePeoDr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:c7d8:b0:262:fc7f:7d95 with SMTP id
 gf24-20020a17090ac7d800b00262fc7f7d95mr9087523pjb.0.1688458247656; Tue, 04
 Jul 2023 01:10:47 -0700 (PDT)
Date: Tue, 04 Jul 2023 01:10:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011da7605ffa4d289@google.com>
Subject: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_cmd_sync_submit
From: syzbot <syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    6352a698ca5b Add linux-next specific files for 20230630
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10bce02ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ae0334a93bf3848
dashboard link: https://syzkaller.appspot.com/bug?extid=e7be5be00de0c3c2d782
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161dadc7280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158449fb280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/938bb9b98868/disk-6352a698.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4468e2b2789e/vmlinux-6352a698.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16555dd478fa/bzImage-6352a698.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7be5be00de0c3c2d782@syzkaller.appspotmail.com

Bluetooth: hci0: link tx timeout
Bluetooth: hci0: killing stalled connection 11:aa:aa:aa:aa:aa
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 4431, name: kworker/u5:1
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u5:1/4431:
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:20 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: raw_atomic64_set include/linux/atomic/atomic-arch-fallback.h:2608 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: raw_atomic_long_set include/linux/atomic/atomic-long.h:79 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:3196 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:675 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:702 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work+0x8fd/0x16f0 kernel/workqueue.c:2567
 #1: ffffc900070efdb0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}, at: process_one_work+0x930/0x16f0 kernel/workqueue.c:2571
 #2: ffffffff8c9a2d80 (rcu_read_lock){....}-{1:2}, at: hci_link_tx_to net/bluetooth/hci_core.c:3406 [inline]
 #2: ffffffff8c9a2d80 (rcu_read_lock){....}-{1:2}, at: __check_timeout net/bluetooth/hci_core.c:3561 [inline]
 #2: ffffffff8c9a2d80 (rcu_read_lock){....}-{1:2}, at: __check_timeout+0x171/0x480 net/bluetooth/hci_core.c:3541
CPU: 1 PID: 4431 Comm: kworker/u5:1 Not tainted 6.4.0-next-20230630-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: hci0 hci_tx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 __might_resched+0x358/0x580 kernel/sched/core.c:10188
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0x9f/0x1350 kernel/locking/mutex.c:747
 hci_cmd_sync_submit+0x3b/0x330 net/bluetooth/hci_sync.c:699
 hci_cmd_sync_queue+0x7b/0xb0 net/bluetooth/hci_sync.c:739
 hci_abort_conn+0x15b/0x330 net/bluetooth/hci_conn.c:2906
 hci_disconnect+0xc3/0x220 net/bluetooth/hci_conn.c:258
 hci_link_tx_to net/bluetooth/hci_core.c:3415 [inline]
 __check_timeout net/bluetooth/hci_core.c:3561 [inline]
 __check_timeout+0x2cc/0x480 net/bluetooth/hci_core.c:3541
 hci_sched_le net/bluetooth/hci_core.c:3744 [inline]
 hci_tx_work+0x82b/0x1bb0 net/bluetooth/hci_core.c:3822
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.4.0-next-20230630-syzkaller #0 Tainted: G        W         
-----------------------------
kworker/u5:1/4431 is trying to lock:
ffff888021b149b0 (&hdev->unregister_lock){+.+.}-{3:3}, at: hci_cmd_sync_submit+0x3b/0x330 net/bluetooth/hci_sync.c:699
other info that might help us debug this:
context-{4:4}
3 locks held by kworker/u5:1/4431:
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:20 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: raw_atomic64_set include/linux/atomic/atomic-arch-fallback.h:2608 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: raw_atomic_long_set include/linux/atomic/atomic-long.h:79 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:3196 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:675 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:702 [inline]
 #0: ffff88807e8a8138 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work+0x8fd/0x16f0 kernel/workqueue.c:2567
 #1: ffffc900070efdb0 ((work_completion)(&hdev->tx_work)){+.+.}-{0:0}, at: process_one_work+0x930/0x16f0 kernel/workqueue.c:2571
 #2: ffffffff8c9a2d80 (rcu_read_lock){....}-{1:2}, at: hci_link_tx_to net/bluetooth/hci_core.c:3406 [inline]
 #2: ffffffff8c9a2d80 (rcu_read_lock){....}-{1:2}, at: __check_timeout net/bluetooth/hci_core.c:3561 [inline]
 #2: ffffffff8c9a2d80 (rcu_read_lock){....}-{1:2}, at: __check_timeout+0x171/0x480 net/bluetooth/hci_core.c:3541
stack backtrace:
CPU: 1 PID: 4431 Comm: kworker/u5:1 Tainted: G        W          6.4.0-next-20230630-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: hci0 hci_tx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4758 [inline]
 check_wait_context kernel/locking/lockdep.c:4828 [inline]
 __lock_acquire+0x15e8/0x5e20 kernel/locking/lockdep.c:5094
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
 hci_cmd_sync_submit+0x3b/0x330 net/bluetooth/hci_sync.c:699
 hci_cmd_sync_queue+0x7b/0xb0 net/bluetooth/hci_sync.c:739
 hci_abort_conn+0x15b/0x330 net/bluetooth/hci_conn.c:2906
 hci_disconnect+0xc3/0x220 net/bluetooth/hci_conn.c:258
 hci_link_tx_to net/bluetooth/hci_core.c:3415 [inline]
 __check_timeout net/bluetooth/hci_core.c:3561 [inline]
 __check_timeout+0x2cc/0x480 net/bluetooth/hci_core.c:3541
 hci_sched_le net/bluetooth/hci_core.c:3744 [inline]
 hci_tx_work+0x82b/0x1bb0 net/bluetooth/hci_core.c:3822
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Bluetooth: hci0: command 0x0406 tx timeout


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

