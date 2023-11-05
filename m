Return-Path: <netdev+bounces-46102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A416F7E15FA
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 20:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94E72812CE
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D82B64D;
	Sun,  5 Nov 2023 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361D1772A
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 19:10:35 +0000 (UTC)
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E308DD
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 11:10:34 -0800 (PST)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1ea1c5774d2so4803529fac.1
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 11:10:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699211433; x=1699816233;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SW4FutqOjQ1NorsIpGr01f/prHPC0R3lRpLUNI45Wcc=;
        b=vpyN1SaDwiwiGQcjBgXz8qfTuKF4LJNrbFGJEEa/Dgl4fpG09zEvOuKW2xNjC0MJPk
         0vR3k+uGyTwKKzdZNZI2CNH+b3APmWuOvh5RnZSocb3nneJnpQl9YSQt00usBqJ4lbrn
         Y6wuFGOjjTz8aKcsEuDp7tya89okHq530Lud12/IPCVI7Ry8qajEwvmJSKQlMxx8rDnm
         hOzfPvf+qgt7GZYWkt4EtyqB6KRA6EaMBL7z4pn6r68PcJuQP2ynHR7wMsWLRJnK/2CH
         3yXa0SiRKyMQgSKeP8BphNsDKXhsbxWD3dREJW/+ZDOSkNcUYQ0U0Zjws727KK5pgh4Y
         /XRA==
X-Gm-Message-State: AOJu0Yyy4L+aOnprSOi+v/tfJLnMmNS0VxKJBYHun1c6ftmQXW46BnNs
	FQ8T+1F4HJp9oQxc56dVYiZhqqd9WQQNpOewEK2ZSTs9yQYm
X-Google-Smtp-Source: AGHT+IEH1vv/1wun3TPKcx+mTQcCzmGiDfJDLi2qavac3QRemFx6ZeC7tns0eBFFGO9YGdH7ownGiNs2PWk6MlwPfSxPusaLskSK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1cf:b0:1e9:bebf:3813 with SMTP id
 n15-20020a05687001cf00b001e9bebf3813mr13014161oad.9.1699211433717; Sun, 05
 Nov 2023 11:10:33 -0800 (PST)
Date: Sun, 05 Nov 2023 11:10:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7b62806096c7d67@google.com>
Subject: [syzbot] [net?] general protection fault in ptp_ioctl
From: syzbot <syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com>
To: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	reibax@gmail.com, richardcochran@gmail.com, rrameshbabu@nvidia.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4652b8e4f3ff Merge tag '6.7-rc-ksmbd-server-fixes' of git:..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11aa125f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=423e70610024fd6b
dashboard link: https://syzkaller.appspot.com/bug?extid=8a78ecea7ac1a2ea26e5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16193ef7680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e035d7680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a9cb6d5a8c4b/disk-4652b8e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/363795681962/vmlinux-4652b8e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/113d96b73fef/bzImage-4652b8e4.xz

The issue was bisected to:

commit c5a445b1e9347b14752b01f1a304bd7a2f260acc
Author: Xabier Marquiegui <reibax@gmail.com>
Date:   Wed Oct 11 22:39:56 2023 +0000

    ptp: support event queue reader channel masks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122491ef680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112491ef680000
console output: https://syzkaller.appspot.com/x/log.txt?x=162491ef680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com
Fixes: c5a445b1e934 ("ptp: support event queue reader channel masks")

general protection fault, probably for non-canonical address 0xdffffc000000020b: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000000001058-0x000000000000105f]
CPU: 0 PID: 5053 Comm: syz-executor353 Not tainted 6.6.0-syzkaller-10396-g4652b8e4f3ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:ptp_ioctl+0xcb7/0x1d10 drivers/ptp/ptp_chardev.c:476
Code: 81 fe 13 3d 00 00 0f 85 9c 02 00 00 e8 c2 83 23 fa 49 8d bc 24 58 10 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 dc 0e 00 00 49 8b bc 24 58 10 00 00 ba 00 01 00
RSP: 0018:ffffc90003a37ba0 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: ffff88814a78a000 RCX: ffffffff8764f81f
RDX: 000000000000020b RSI: ffffffff8765028e RDI: 0000000000001058
RBP: ffffc90003a37ec0 R08: 0000000000000005 R09: ffffc90003a37c40
R10: 0000000000003d13 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc90003a37c80 R14: 0000000000003d13 R15: ffffffff92ac78e8
FS:  00005555569a9380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000076e09000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 posix_clock_ioctl+0xf8/0x160 kernel/time/posix-clock.c:86
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f710ac4a2a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda288c4c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffda288c698 RCX: 00007f710ac4a2a9
RDX: 0000000000000000 RSI: 0000000000003d13 RDI: 0000000000000003
RBP: 00007f710acbd610 R08: 00007ffda288c698 R09: 00007ffda288c698
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffda288c688 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ptp_ioctl+0xcb7/0x1d10 drivers/ptp/ptp_chardev.c:476
Code: 81 fe 13 3d 00 00 0f 85 9c 02 00 00 e8 c2 83 23 fa 49 8d bc 24 58 10 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 dc 0e 00 00 49 8b bc 24 58 10 00 00 ba 00 01 00
RSP: 0018:ffffc90003a37ba0 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: ffff88814a78a000 RCX: ffffffff8764f81f
RDX: 000000000000020b RSI: ffffffff8765028e RDI: 0000000000001058
RBP: ffffc90003a37ec0 R08: 0000000000000005 R09: ffffc90003a37c40
R10: 0000000000003d13 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc90003a37c80 R14: 0000000000003d13 R15: ffffffff92ac78e8
FS:  00005555569a9380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 0000000076e09000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	81 fe 13 3d 00 00    	cmp    $0x3d13,%esi
   6:	0f 85 9c 02 00 00    	jne    0x2a8
   c:	e8 c2 83 23 fa       	call   0xfa2383d3
  11:	49 8d bc 24 58 10 00 	lea    0x1058(%r12),%rdi
  18:	00
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 dc 0e 00 00    	jne    0xf10
  34:	49 8b bc 24 58 10 00 	mov    0x1058(%r12),%rdi
  3b:	00
  3c:	ba                   	.byte 0xba
  3d:	00 01                	add    %al,(%rcx)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

