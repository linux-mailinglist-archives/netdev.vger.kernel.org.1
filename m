Return-Path: <netdev+bounces-32422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB66F7976C9
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19C31C20C56
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EA4134B0;
	Thu,  7 Sep 2023 16:16:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E888B28E7
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 16:16:25 +0000 (UTC)
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79023526F
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 09:16:01 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3a1c2d69709so1377066b6e.1
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 09:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103297; x=1694708097;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zW5qhnjQmXuAaFU5fKwA/lEli7GsBu/PGJfxRXG3SHY=;
        b=FQvUu0pPkX5dxCY0fvsnh8FwK4XCuZWSTIiZlqlyA/08Qq2mCHJ9huDaBD/bI66Il8
         8pVzp+kz/AQmPYfiZMPHBUBb9I6GfWEFPzyc1UkuWqcF8U5fv4QiXcEXHEb+knxdOOTS
         4MeVvyJuM0DRcjZx5tti1r5ZiEsUoeooV6eY2dMrX86Hdw9h2akX2QWooPWV9XOStbwc
         kHqD5E+Q/OTGL2huHkuFUL5Q47Ng2ItlAycXRL0+wK2yBy8UAk0t+4UX8p4JDlHZUBN3
         LBgaOhS+ih0j5eRJpUO3r6GYQ/JOw7dxvaiWuYtqySB6LyUlHZahYNSHh+/zerRU9OUy
         Tv1A==
X-Gm-Message-State: AOJu0YwUIwxa+8Kmgzgl2yo1rp224i2zB5+WSskVFV0b1t6sCiuntZSV
	Am9fB5F8kdcm7t2g7lVJTJxxvf6eslqaAXxiSQGHg3ZN3ziO
X-Google-Smtp-Source: AGHT+IG5wTTGmmZiHOULSKMs/aQJzNoUO7ZR1DHaaynqV/kIsxBQ60kNClLJ4OvCsCznerNQ8nbBG5G2Y/WjgpejAQ1X+NCllgum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:7d03:0:b0:569:356c:f365 with SMTP id
 y3-20020a637d03000000b00569356cf365mr3738671pgc.12.1694075041155; Thu, 07 Sep
 2023 01:24:01 -0700 (PDT)
Date: Thu, 07 Sep 2023 01:24:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d1dbf0604c09577@google.com>
Subject: [syzbot] [wireless?] [net?] memory leak in restore_regulatory_settings
From: syzbot <syzbot+68849d5e4a6e74f32c06@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    92901222f83d Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c340b8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3544ee7492950dd3
dashboard link: https://syzkaller.appspot.com/bug?extid=68849d5e4a6e74f32c06
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fe378fa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bf6f7ba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b5db23b3ecc/disk-92901222.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/135d82cfd540/vmlinux-92901222.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e1b0da81493/bzImage-92901222.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+68849d5e4a6e74f32c06@syzkaller.appspotmail.com

write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
BUG: memory leak
unreferenced object 0xffff88810f8a4e80 (size 64):
  comm "kworker/0:1", pid 9, jiffies 4294945857 (age 8.050s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff 00 00 00 00 00 00 00 00 30 30 00 00  ............00..
  backtrace:
    [<ffffffff815739f5>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff84739940>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff84739940>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff84739940>] regulatory_hint_core net/wireless/reg.c:3218 [inline]
    [<ffffffff84739940>] restore_regulatory_settings+0x820/0xa80 net/wireless/reg.c:3552
    [<ffffffff84739d71>] crda_timeout_work+0x21/0x30 net/wireless/reg.c:540
    [<ffffffff812c8f1d>] process_one_work+0x23d/0x530 kernel/workqueue.c:2630
    [<ffffffff812c9ac7>] process_scheduled_works kernel/workqueue.c:2703 [inline]
    [<ffffffff812c9ac7>] worker_thread+0x327/0x590 kernel/workqueue.c:2784
    [<ffffffff812d6f9b>] kthread+0x12b/0x170 kernel/kthread.c:388
    [<ffffffff81149875>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

