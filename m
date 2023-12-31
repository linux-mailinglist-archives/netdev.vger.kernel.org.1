Return-Path: <netdev+bounces-60643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9A5820B2B
	for <lists+netdev@lfdr.de>; Sun, 31 Dec 2023 12:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31194B2127D
	for <lists+netdev@lfdr.de>; Sun, 31 Dec 2023 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6603C13;
	Sun, 31 Dec 2023 11:04:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62433DD
	for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7fdde8b58so1158771939f.1
        for <netdev@vger.kernel.org>; Sun, 31 Dec 2023 03:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704020666; x=1704625466;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLE1C8Gnyay/58EMKQf3mRANF7ZKO9ZaeKljhyCAUHw=;
        b=o2CoRQeEN2seIBbluduZLkFshtK1MlGmx0HmjNGBTbCTsxLVf8VQ9QJihdKTiFgIq/
         iSeEb9DvFupaNnwrCp3001206QHKal6auP+/kzVMvT/vLYMxwXhaqmk2q5at+gEsGi9V
         fR03gHxey1CJkHQ4B07hcefs0JYUrcsG0Tz2O8UTEagIhZ7cD6NTUR7C+CMrIUsihisY
         k2EpQaZZ8+WX7YQbTXVPRYndVSTtc9RcdMv0y9fOGUaUP8Yr9/rOV6kmQDeyRen3Y/FX
         RH4qazUcGAHAV/zer8GqbWLxruVp1uUPyLWDc2t1obCqNR4ALwaP5hWazQSth/qKaC9f
         /mgQ==
X-Gm-Message-State: AOJu0YwbzPR9raSSYqigZsp0SKEu8M7kvGAL+eDlzhYOtSRRpJfzIBR0
	FC/WRgfIhtgZXgvHAr/q9FWucTk8GXyN/DECkhgqszRCrQlP
X-Google-Smtp-Source: AGHT+IGyDKDdu7u5iZJp4qvJvbdN6saFWeu21xb1p5GQZklkpQhmfDhrUusUyOH8lB7HeBm14Lhb1TWgztrOAAAE3vXa+1+KQXDy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:35f:ebc7:6065 with SMTP id
 j10-20020a056e02218a00b0035febc76065mr2284648ila.1.1704020666201; Sun, 31 Dec
 2023 03:04:26 -0800 (PST)
Date: Sun, 31 Dec 2023 03:04:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fbc8c060dcc3a5c@google.com>
Subject: [syzbot] [net?] general protection fault in hfsc_tcf_block
From: syzbot <syzbot+0039110f932d438130f9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com, 
	syzkaller-bugs@googlegroups.com, victor@mojatatu.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2b2ee36250d bridge: cfm: fix enum typo in br_cc_ccm_tx_pa..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=125321a1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4e9ca8e3c104d2a
dashboard link: https://syzkaller.appspot.com/bug?extid=0039110f932d438130f9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123c0065e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a8c0f6e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7344dc892eab/disk-c2b2ee36.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b5d04995c162/vmlinux-c2b2ee36.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9558856ab7f4/bzImage-c2b2ee36.xz

The issue was bisected to:

commit 913b47d3424e7d99eaf34b798c47dfa840c64a08
Author: Victor Nogueira <victor@mojatatu.com>
Date:   Tue Dec 19 18:16:19 2023 +0000

    net/sched: Introduce tc block netdev tracking infra

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1235de8de80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1135de8de80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1635de8de80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")

general protection fault, probably for non-canonical address 0xdffffc0000002009: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000000010048-0x000000000001004f]
CPU: 1 PID: 5066 Comm: syz-executor151 Not tainted 6.7.0-rc6-syzkaller-01658-gc2b2ee36250d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:hfsc_tcf_block+0x3f/0x70 net/sched/sch_hfsc.c:1265
Code: de e8 a5 2b f0 f8 48 85 db 74 2c e8 0b 30 f0 f8 e8 06 30 f0 f8 48 8d 7b 58 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 15 48 8b 43 58 5b 5d c3 e8 df 2f f0 f8 48 8d 9d d0
RSP: 0018:ffffc90003bcf408 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 000000000000fff2 RCX: ffffffff8897515b
RDX: 0000000000002009 RSI: ffffffff8897516a RDI: 000000000001004a
RBP: ffff88801675f000 R08: 0000000000000007 R09: 0000000000000000
R10: 000000000000fff2 R11: 0000000000000001 R12: ffff888023d04000
R13: ffffffff8bed5000 R14: 0000000000000001 R15: ffffffff8f19aa60
FS:  0000555555ea1380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 000000007ae44000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 qdisc_block_add_dev net/sched/sch_api.c:1190 [inline]
 qdisc_create+0x6b6/0x1430 net/sched/sch_api.c:1390
 tc_modify_qdisc+0x4d5/0x1c30 net/sched/sch_api.c:1788
 rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6615
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6a6284c7f9
Code: 48 83 c4 28 c3 e8 27 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff964096d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6a6284c7f9
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007fff964096f0 R08: 00007fff96409750 R09: 00007fff96409750
R10: 00007fff96409750 R11: 0000000000000246 R12: 00007f6a628bf5f0
R13: 00007fff964098d8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfsc_tcf_block+0x3f/0x70 net/sched/sch_hfsc.c:1265
Code: de e8 a5 2b f0 f8 48 85 db 74 2c e8 0b 30 f0 f8 e8 06 30 f0 f8 48 8d 7b 58 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 15 48 8b 43 58 5b 5d c3 e8 df 2f f0 f8 48 8d 9d d0
RSP: 0018:ffffc90003bcf408 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 000000000000fff2 RCX: ffffffff8897515b
RDX: 0000000000002009 RSI: ffffffff8897516a RDI: 000000000001004a
RBP: ffff88801675f000 R08: 0000000000000007 R09: 0000000000000000
R10: 000000000000fff2 R11: 0000000000000001 R12: ffff888023d04000
R13: ffffffff8bed5000 R14: 0000000000000001 R15: ffffffff8f19aa60
FS:  0000555555ea1380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dcfb61a758 CR3: 000000007ae44000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	de e8                	fsubrp %st,%st(0)
   2:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
   3:	2b f0                	sub    %eax,%esi
   5:	f8                   	clc
   6:	48 85 db             	test   %rbx,%rbx
   9:	74 2c                	je     0x37
   b:	e8 0b 30 f0 f8       	call   0xf8f0301b
  10:	e8 06 30 f0 f8       	call   0xf8f0301b
  15:	48 8d 7b 58          	lea    0x58(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 15                	jne    0x45
  30:	48 8b 43 58          	mov    0x58(%rbx),%rax
  34:	5b                   	pop    %rbx
  35:	5d                   	pop    %rbp
  36:	c3                   	ret
  37:	e8 df 2f f0 f8       	call   0xf8f0301b
  3c:	48                   	rex.W
  3d:	8d                   	.byte 0x8d
  3e:	9d                   	popf
  3f:	d0                   	.byte 0xd0


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

