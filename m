Return-Path: <netdev+bounces-38898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAAE7BCF17
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 17:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FA21C20866
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 15:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3129111BC;
	Sun,  8 Oct 2023 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728433E5
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 15:27:48 +0000 (UTC)
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BD1B9
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 08:27:46 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1c02d6efee4so5897442fac.2
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 08:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696778866; x=1697383666;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qHI8coAGIlxFEFe37OEjc5tftTQMBWp+MUuffsbsvw=;
        b=F+rdRMX6LklUdpE5an2lLFQQnWBezUADBJ+ChBDcVI+oBGyM/nmQqH4WxEmen/3OB3
         p3m8ItkKlqV+CYB17YDRlwtvSsmN79FOo1cnjMu8j3s2CL/9ICa/whrkt2P4aQ9JysxE
         SxsgjaklMDIblh8mDANLgh1JoGMsc7TYGzU+Nukpm0aHFpKTRAC31Nl225K5pie3IUHJ
         KeabqJj/WJLeoebC4DeVLxiayTbrqECgTVbdGhkt6CRJsc1ncBBvems/Pf2bflerIInK
         kZOdqsJ9LEZe2+8X829LdXj329p3ITN22ykqJC+3orlSN92MsL/7/dRYfeDYPPn2YKdz
         PhrQ==
X-Gm-Message-State: AOJu0YxUjIjCL9fkv6ok5kxl+lTEz451/mRWtcPgyHVcj6/llkc27bXw
	Z8UdRSVC3KDzm44kxeu1ltBZ4veTib4J3B/JaZF4yHFLh0Gu
X-Google-Smtp-Source: AGHT+IGTZmXhzwZBTw28xm0AwF8vsR0+nxTuVLX4In7tdP1G9Hbb0l+bpBjcsX6lZ20I9pqBf+p96rf61T2L5ar7Y2gVWcn5NG/6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b7b1:b0:1d1:40c5:a531 with SMTP id
 ed49-20020a056870b7b100b001d140c5a531mr5258426oab.3.1696778865815; Sun, 08
 Oct 2023 08:27:45 -0700 (PDT)
Date: Sun, 08 Oct 2023 08:27:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f393c0607361dd5@google.com>
Subject: [syzbot] [wireguard?] WARNING in kthread_unpark
From: syzbot <syzbot+66ff56c4661498a22ae8@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    2e530aeb342b Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13ef2062680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cc95add722fb0c1
dashboard link: https://syzkaller.appspot.com/bug?extid=66ff56c4661498a22ae8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2468ab4c933e/disk-2e530aeb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd3708bf8a20/vmlinux-2e530aeb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/86bc7d3468f9/Image-2e530aeb.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+66ff56c4661498a22ae8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 11 at kernel/kthread.c:524 __kthread_bind kernel/kthread.c:537 [inline]
WARNING: CPU: 1 PID: 11 at kernel/kthread.c:524 kthread_unpark+0x148/0x204 kernel/kthread.c:630
Modules linked in:
CPU: 1 PID: 11 Comm: kworker/u4:0 Not tainted 6.6.0-rc3-syzkaller-g2e530aeb342b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Workqueue: netns cleanup_net
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __kthread_bind kernel/kthread.c:537 [inline]
pc : kthread_unpark+0x148/0x204 kernel/kthread.c:630
lr : __kthread_bind kernel/kthread.c:537 [inline]
lr : kthread_unpark+0x148/0x204 kernel/kthread.c:630
sp : ffff800092b376d0
x29: ffff800092b376d0 x28: ffff0000c63f0000 x27: dfff800000000000
x26: 1fffe00019602005 x25: dfff800000000000 x24: 1fffe00018c7e29c
x23: 0000000000000000 x22: 0000000000000000 x21: ffff0000cd704400
x20: ffff0000cb01002c x19: ffff0000cb010000 x18: ffff800092b371c0
x17: ffff80008e19d000 x16: ffff8000802771bc x15: 0000000000000001
x14: 1fffe00019602130 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : ffff0000c199b780 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000020 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __kthread_bind kernel/kthread.c:537 [inline]
 kthread_unpark+0x148/0x204 kernel/kthread.c:630
 kthread_stop+0x188/0x704 kernel/kthread.c:706
 destroy_workqueue+0x124/0xdc4 kernel/workqueue.c:4805
 wg_destruct+0x1c8/0x2dc drivers/net/wireguard/device.c:258
 netdev_run_todo+0xc34/0xe08 net/core/dev.c:10445
 rtnl_unlock+0x14/0x20 net/core/rtnetlink.c:151
 default_device_exit_batch+0x6cc/0x744 net/core/dev.c:11454
 ops_exit_list net/core/net_namespace.c:175 [inline]
 cleanup_net+0x5dc/0x8d0 net/core/net_namespace.c:614
 process_one_work+0x694/0x1204 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2784
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857
irq event stamp: 8730562
hardirqs last  enabled at (8730561): [<ffff80008a7140e8>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (8730561): [<ffff80008a7140e8>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (8730562): [<ffff80008a625394>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
softirqs last  enabled at (8730490): [<ffff800084cff268>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (8730490): [<ffff800084cff268>] wg_packet_purge_staged_packets+0x1b8/0x1f4 drivers/net/wireguard/send.c:338
softirqs last disabled at (8730488): [<ffff800084cff0ec>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (8730488): [<ffff800084cff0ec>] wg_packet_purge_staged_packets+0x3c/0x1f4 drivers/net/wireguard/send.c:335
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

