Return-Path: <netdev+bounces-15068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0643B7457EA
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 11:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F910280CE5
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 09:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF11F20E3;
	Mon,  3 Jul 2023 09:03:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16431C2F
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 09:03:53 +0000 (UTC)
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469ECCA
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 02:03:52 -0700 (PDT)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-53425d37fefso4330862a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 02:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688375031; x=1690967031;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tt+elPvBU4JSaauKcFdMY/BKO2C966PXSryxnaJxgAY=;
        b=avh/emK0mR4yGSkq7ntgX2bm8QdfJ6uCEtXloL8BrAr0OUQ0u0w6RuCm7qJyney5WP
         7DPGMBu9yY7OXGZ7q4sNqYkMRBy02q0M2Opwwxzu/kDOM5KO3xygNJnKvuW2sjfKncxY
         yxQDHLBVYL2NscY0/i36LNANa/bcGg+v5oEEBX38yd71vjiIqAdP8dCirYK/0KS2UujQ
         INhsNNR+MjZOP7pOvL+btJNBvGlb5Z+oYIWxFQTGSaNMF7Nxi4XESYcGciVes86IT3MT
         fTIp7l2hPXirteMgjc1v3t9qK+wZS5so1YYBxAqu+m7llmBDMm9PJpq5vZtqmBS9EAop
         3hAQ==
X-Gm-Message-State: ABy/qLZ9w8CqGPIYQg3atVBqxySh0pdaPjt5tl7AtKuRY7vJRpieLsnr
	U/7AUshKOpTZ1x0C0yMBAOStqqe1cW6RH66G/A4WT/GBFeiV
X-Google-Smtp-Source: APBJJlFA82iW9rXhYehwMgTc99H3wxQH7FsHWh8E3r+gJgbCSfsXtfO2h3ipz6Lcm+KvV2NOGAWCR16G4dlWCacy9xJB6yMXQ0JP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:2485:0:b0:557:5a08:845a with SMTP id
 k127-20020a632485000000b005575a08845amr5834083pgk.12.1688375031497; Mon, 03
 Jul 2023 02:03:51 -0700 (PDT)
Date: Mon, 03 Jul 2023 02:03:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000008b405ff9172af@google.com>
Subject: [syzbot] [kernel?] bpf test error: UBSAN: array-index-out-of-bounds
 in alloc_pid
From: syzbot <syzbot+b4667b39c6f42e957680@syzkaller.appspotmail.com>
To: ast@kernel.org, brauner@kernel.org, daniel@iogearbox.net, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    08fc75735fda mlxsw: minimal: fix potential memory leak in ..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=177e2770a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924167e3666ff54c
dashboard link: https://syzkaller.appspot.com/bug?extid=b4667b39c6f42e957680
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05692fe5b2c1/disk-08fc7573.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6409f36b80fa/vmlinux-08fc7573.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1ed32d53dbe/bzImage-08fc7573.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4667b39c6f42e957680@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in kernel/pid.c:244:15
index 1 is out of range for type 'upid [1]'
CPU: 0 PID: 5005 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller-04282-g08fc75735fda #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xd5/0x140 lib/ubsan.c:348
 alloc_pid+0xbe5/0xdd0 kernel/pid.c:244
 copy_process+0x4589/0x7620 kernel/fork.c:2519
 kernel_clone+0xeb/0x890 kernel/fork.c:2911
 __do_sys_clone+0xba/0x100 kernel/fork.c:3054
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa69b689fab
Code: ed 0f 85 60 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 89 00 00 00 41 89 c5 85 c0 0f 85 90 00 00
RSP: 002b:00007ffd809b1c70 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffd809b22c8 RCX: 00007fa69b689fab
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000555556466400
R10: 00005555564666d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd809b1d60 R14: 00007fa69b7ac9d8 R15: 000000000000000c
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

