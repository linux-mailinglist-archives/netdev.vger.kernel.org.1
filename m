Return-Path: <netdev+bounces-26813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CBD77912A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0702823B1
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B5020FB3;
	Fri, 11 Aug 2023 13:59:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0763B3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 13:59:03 +0000 (UTC)
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B607E65
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:59:02 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-5655a2c868eso1808983a12.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691762341; x=1692367141;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twD7WsSnztEHgxSXYqMHwhsjqiewIh6ChtYQcifmThE=;
        b=XLGuGQlIWeM1umbB+4CMoMVusaTi9Re+PHL94jMVLNCvza2UxhzEZNraE3OnInnkY6
         +oHX1dlZ0Pr4sBJMW46qviNGbTdeXAGRoTgoYpRqWiyoInXVsSsOb2P9bp/GpI0dQuPj
         mQn5nOF0zkp8ZLuKmj1N9P3c1Rmyw91NQEeONWeFDQCkxoXgC+mqtJ9uyNQvV8IbnsnR
         kHHsMgfAitYO4I2tLQjn9IWp+n3UEVMnrxLhZa2EqDvcZqSYq5mtigLtoXQj49svZcb5
         yESkNXhas5x9At7xtbFFKs2NkHn4ZezSbisVMKNZcBw4uf4QbUR7Z83mUP1ba6fOPR/z
         47BQ==
X-Gm-Message-State: AOJu0YxCsywbB/kPNQIcCMvMYlz9LjLWAiCLtF3oDboNVGxd7muNBOW3
	CH5JUAqu/E5ayyvIB0jDy2b+xPHTeqSfksIwmb92Ji7TY+QY
X-Google-Smtp-Source: AGHT+IEDuMXJyXVa5dKXAxvaJ4B+mySkHVqFqXihLHpGNwiIASP24rw4rW3hvi9aSTJAIjYvsu67jUSzm1MQfrwqSBhcdAW9MNZw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:3e47:0:b0:564:aeb6:c371 with SMTP id
 l68-20020a633e47000000b00564aeb6c371mr362385pga.3.1691762341624; Fri, 11 Aug
 2023 06:59:01 -0700 (PDT)
Date: Fri, 11 Aug 2023 06:59:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ac4c70602a61d16@google.com>
Subject: [syzbot] [openvswitch?] BUG: unable to handle kernel paging request
 in ovs_vport_add
From: syzbot <syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com>
To: davem@davemloft.net, dev@openvswitch.org, edumazet@google.com, 
	kuba@kernel.org, leonro@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pshelar@ovn.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    29afcd69672a Merge branch 'improve-the-taprio-qdisc-s-rela..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1056d29da80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1199967d15d20915
dashboard link: https://syzkaller.appspot.com/bug?extid=7456b5dcf65111553320
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110bf169a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104f7a9da80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df7b1d334282/disk-29afcd69.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/178397c497e2/vmlinux-29afcd69.xz
kernel image: https://storage.googleapis.com/syzbot-assets/38ffbedb3b50/bzImage-29afcd69.xz

The issue was bisected to:

commit 759ab1edb56c88906830fd6b2e7b12514dd32758
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Wed Jul 26 18:55:29 2023 +0000

    net: store netdevs in an xarray

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1431ba3da80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1631ba3da80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1231ba3da80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com
Fixes: 759ab1edb56c ("net: store netdevs in an xarray")

netlink: 'syz-executor294': attribute type 9 has an invalid length.
BUG: unable to handle page fault for address: fffffbfff412f978
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffe4067 P4D 23ffe4067 PUD 23ffe3067 PMD 19e75067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5027 Comm: syz-executor294 Not tainted 6.5.0-rc4-syzkaller-01306-g29afcd69672a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:ovs_vport_name net/openvswitch/vport.h:196 [inline]
RIP: 0010:ovs_vport_add+0x17a/0x4c0 net/openvswitch/vport.c:223
Code: 89 c6 e8 39 16 78 f7 48 81 fd 00 f0 ff ff 0f 87 5b 02 00 00 e8 97 1a 78 f7 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 11 03 00 00 48 8d 7d 10 48 8b 75 00 48 b8 00 00
RSP: 0018:ffffc900038f73d0 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffffffff8e8df240 RCX: 0000000000000000
RDX: 1ffffffff412f978 RSI: ffffffff8a0e0579 RDI: 0000000000000007
RBP: ffffffffa097cbc2 R08: 0000000000000007 R09: fffffffffffff000
R10: ffffffffa097cbc2 R11: ffffffff8a40008b R12: ffffffff8e8df270
R13: dffffc0000000000 R14: ffffc900038f74d0 R15: ffffc900038f74d8
FS:  0000555556e67380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff412f978 CR3: 000000007ab37000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 new_vport+0x16/0x1c0 net/openvswitch/datapath.c:203
 ovs_dp_cmd_new+0x6a1/0xe70 net/openvswitch/datapath.c:1841
 genl_family_rcv_msg_doit.isra.0+0x1ef/0x2d0 net/netlink/genetlink.c:974
 genl_family_rcv_msg net/netlink/genetlink.c:1054 [inline]
 genl_rcv_msg+0x559/0x800 net/netlink/genetlink.c:1071
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2575
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1082
 netlink_unicast_kernel net/netlink/af_netlink.c:1344 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1370
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1939
 sock_sendmsg_nosec net/socket.c:728 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:751
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2514
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2568
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2597
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa80bfd7569
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdf3beb468 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffdf3beb638 RCX: 00007fa80bfd7569
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007fa80c04b610 R08: 000000000000000c R09: 00007ffdf3beb638
R10: 0000000000001004 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffdf3beb628 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
CR2: fffffbfff412f978
---[ end trace 0000000000000000 ]---
RIP: 0010:ovs_vport_name net/openvswitch/vport.h:196 [inline]
RIP: 0010:ovs_vport_add+0x17a/0x4c0 net/openvswitch/vport.c:223
Code: 89 c6 e8 39 16 78 f7 48 81 fd 00 f0 ff ff 0f 87 5b 02 00 00 e8 97 1a 78 f7 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 11 03 00 00 48 8d 7d 10 48 8b 75 00 48 b8 00 00
RSP: 0018:ffffc900038f73d0 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffffffff8e8df240 RCX: 0000000000000000
RDX: 1ffffffff412f978 RSI: ffffffff8a0e0579 RDI: 0000000000000007
RBP: ffffffffa097cbc2 R08: 0000000000000007 R09: fffffffffffff000
R10: ffffffffa097cbc2 R11: ffffffff8a40008b R12: ffffffff8e8df270
R13: dffffc0000000000 R14: ffffc900038f74d0 R15: ffffc900038f74d8
FS:  0000555556e67380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff412f978 CR3: 000000007ab37000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 c6                	mov    %eax,%esi
   2:	e8 39 16 78 f7       	call   0xf7781640
   7:	48 81 fd 00 f0 ff ff 	cmp    $0xfffffffffffff000,%rbp
   e:	0f 87 5b 02 00 00    	ja     0x26f
  14:	e8 97 1a 78 f7       	call   0xf7781ab0
  19:	48 89 ea             	mov    %rbp,%rdx
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 11 03 00 00    	jne    0x345
  34:	48 8d 7d 10          	lea    0x10(%rbp),%rdi
  38:	48 8b 75 00          	mov    0x0(%rbp),%rsi
  3c:	48                   	rex.W
  3d:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

