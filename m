Return-Path: <netdev+bounces-52411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F177FEA9C
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16CE282CDD
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AA62C84A;
	Thu, 30 Nov 2023 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA410E0
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:30:18 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6cc0763b3c6so785785b3a.3
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 00:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701333018; x=1701937818;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIw1JWWT8TnVD6HbKTVvuR/5VtUWqfCmmFWn9LBakHY=;
        b=FoY2oQQHKmNrnmu3KEqQcBqdrKHsPxNRdbE9LNNJtDwAVmok8f+L0W5eP3mpTdXLxa
         Z+yegHSax7pY3Mo9uxnWrYA+XrOjoIoQ8sqbjgxtMKiR82yes9F0kLEgaT86iM3oMxz5
         DEsrBoK10J+FAEmCLR9B6tMQAa8+yzFFxMZgllCtBVEWvJbvHbaigBXyWNb1+2GDeV0v
         iuXUt2z23UuN0nSqufpEq/l+kMRhzsvEG5rlQAeEB+zxOhvvG84ROmN2rtXa7OkFogrv
         F6/HlJ56FLxtFA0GP6fes5j2+eac99Zk/QdnyKph2nYoprA1hZDWvxk4FpDfs3X3+KVj
         RZkA==
X-Gm-Message-State: AOJu0Yypd3IPKW9Z4P1FMzSZjsxeapug8hw6P5bo/D1AwyrZSbFklS5Q
	7L0hpCmuwahWSoM8ARBRN5WXFZOJqS1CLv6O/wHK+NU7z761
X-Google-Smtp-Source: AGHT+IFbutBmUZfwpexHXYZG5aEDMpJIxfd0+ggfyPZdji7eh9GhZt1t2/yrc8QSkSBVy3CwHfwsiFsCEl+LIBCdACB+oFRh/Ter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1249:b0:6cd:f18e:175 with SMTP id
 u9-20020a056a00124900b006cdf18e0175mr15597pfi.0.1701333017837; Thu, 30 Nov
 2023 00:30:17 -0800 (PST)
Date: Thu, 30 Nov 2023 00:30:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ca935060b5a7682@google.com>
Subject: [syzbot] [net?] WARNING in cleanup_net (3)
From: syzbot <syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d90b0276af8f Merge tag 'hardening-v6.6-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c4675c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d594086f139d167
dashboard link: https://syzkaller.appspot.com/bug?extid=9ada62e1dc03fdc41982
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d90b0276.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6997ebf3cf3/vmlinux-d90b0276.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d893c5c3f98f/bzImage-d90b0276.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com

     do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
     entry_SYSENTER_compat_after_hwframe+0x70/0x82
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1093 at lib/ref_tracker.c:179 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
WARNING: CPU: 1 PID: 1093 at lib/ref_tracker.c:179 ref_tracker_dir_exit+0x3e2/0x680 lib/ref_tracker.c:178
Modules linked in:
CPU: 1 PID: 1093 Comm: kworker/u16:7 Not tainted 6.6.0-rc2-syzkaller-00337-gd90b0276af8f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:ref_tracker_dir_exit+0x3e2/0x680 lib/ref_tracker.c:179
Code: 85 07 02 00 00 4d 39 f5 49 8b 06 4d 89 f7 0f 85 0e ff ff ff 48 8b 2c 24 e8 4b 7b 32 fd 48 8b 74 24 18 48 89 ef e8 ce d8 ec 05 <0f> 0b e8 37 7b 32 fd 48 8d 5d 44 be 04 00 00 00 48 89 df e8 b6 34
RSP: 0018:ffffc90006ee7b78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff8a8cab20 RDI: 0000000000000001
RBP: ffff8880591981e0 R08: 0000000000000001 R09: fffffbfff233dff7
R10: ffffffff919effbf R11: 0000000000000114 R12: ffff888059198230
R13: ffff888059198230 R14: ffff888059198230 R15: ffff888059198230
FS:  0000000000000000(0000) GS:ffff88802c700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000057ab404c CR3: 0000000070f05000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 00000000ffff00f1 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 net_free net/core/net_namespace.c:448 [inline]
 net_free net/core/net_namespace.c:442 [inline]
 cleanup_net+0x8d4/0xb20 net/core/net_namespace.c:635
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>


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

