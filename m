Return-Path: <netdev+bounces-22584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8937682F3
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 02:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6402816D0
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 00:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F48381;
	Sun, 30 Jul 2023 00:48:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8684376
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 00:48:53 +0000 (UTC)
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FEB273F
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 17:48:52 -0700 (PDT)
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-56c68e1d44cso3392705eaf.2
        for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 17:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690678131; x=1691282931;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BURO1MpdTlN3V32S0AQv/o3bpO0z6wVd1hYAKFqfAOI=;
        b=U+829K/tRbJatGpLXQXVV6LFl4F31TzFks9mr/bYpWEvAzeAFiwlEg+vGcqF1+nq6B
         jWWGHEPUWSQyjpUlmMzQKRO7DPVIS4TZGFIt+kNYddn39irdTTJqOJea4AuwWggzpJ+V
         JbIFhcNmjRka16ZMoxmBqdMR4dSqOzbLiwUO/l0NQXwOX6pIE7rf+hox2AFwo//4PEZM
         ev7jHHLQvKNJnYME7nSGPQm4vthIzUajDG658aInHoFaYKUjh+lIRhHwOaETcbMQjZ2l
         VGel+un/sIznMh+iSwlDp+dv6Q0gbDSJlHynp9pPNP2EEsJrGkORHYHWkmG65aw3FTJk
         OOfQ==
X-Gm-Message-State: ABy/qLZXthquq1FuOjvtm7FghpOTGYQAVtmwJOcAEoHXiRI0GDXCJBnd
	E3vRJ232LnGrJizy+SS7bkHBeB5MFA6+/CdpuL5nv8JII7BC
X-Google-Smtp-Source: APBJJlEQ/73yYh9D/b/HEdwPOZidKd8YbVdb82EikXEA9jpczY+J5DnFHEkYU3SIfWErKq9jy8qffyjmL8+XtMk4bpS7vVhPzry/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:33ca:0:b0:56c:99c3:1ffa with SMTP id
 q193-20020a4a33ca000000b0056c99c31ffamr1793607ooq.0.1690678131199; Sat, 29
 Jul 2023 17:48:51 -0700 (PDT)
Date: Sat, 29 Jul 2023 17:48:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007095cd0601a9ad91@google.com>
Subject: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in bpf_mprog_detach
From: syzbot <syzbot+0c06ba0f831fe07a8f27@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    ec87f05402f5 octeontx2-af: Install TC filter rules in hard..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12a76df1a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8acaeb93ad7c6aaa
dashboard link: https://syzkaller.appspot.com/bug?extid=0c06ba0f831fe07a8f27
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0fc53904fc08/disk-ec87f054.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aee64718ea5c/vmlinux-ec87f054.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3b6d3f4cfbc/bzImage-ec87f054.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c06ba0f831fe07a8f27@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in ./include/linux/bpf_mprog.h:292:24
index 4294967295 is out of range for type 'bpf_mprog_fp [64]'
CPU: 1 PID: 13232 Comm: syz-executor.1 Not tainted 6.5.0-rc2-syzkaller-00573-gec87f05402f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:348
 bpf_mprog_read include/linux/bpf_mprog.h:292 [inline]
 bpf_mprog_fetch kernel/bpf/mprog.c:307 [inline]
 bpf_mprog_detach+0xcd7/0xd50 kernel/bpf/mprog.c:381
 tcx_prog_detach+0x258/0x950 kernel/bpf/tcx.c:78
 bpf_prog_detach kernel/bpf/syscall.c:3877 [inline]
 __sys_bpf+0x36ee/0x4ec0 kernel/bpf/syscall.c:5357
 __do_sys_bpf kernel/bpf/syscall.c:5449 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5447 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5447
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f443e27cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f443cdfe0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f443e39bf80 RCX: 00007f443e27cb29
RDX: 0000000000000020 RSI: 0000000020000340 RDI: 0000000000000009
RBP: 00007f443e2c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f443e39bf80 R15: 00007ffdb0833788
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

