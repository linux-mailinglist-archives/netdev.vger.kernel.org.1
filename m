Return-Path: <netdev+bounces-45572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3D7DE671
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 20:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06F428112B
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 19:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0E019BB9;
	Wed,  1 Nov 2023 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42963A3
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 19:39:35 +0000 (UTC)
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD01DA
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 12:39:29 -0700 (PDT)
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-581ed663023so201472eaf.2
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 12:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698867569; x=1699472369;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDr+aT0CPwYoMVHOl15SqJscCmodMyvuqLh/g6iSDLM=;
        b=WWqhj1XNTmeJDjTscTkM85hmfuM2bGJ8s0w0zci85lEnt4dRe10cEwmFp0uHbxOGMR
         0fvTxgxEMWtYkHL+hXuFYYDv8/Uk4uRd82LGHQAzga9C7W3hM90AkuIpGSqonpWtbuDn
         zqsa7EU0kbtvAswpEJdae0giPW94vRoCTmO4Cq+KWtwcz1GhtZs5XefMKewN2ciWqC9u
         jWDQifuclDNEZeBQFnUAYu3wSq7pTJe4dIRKD/FPeEGkuoyD4PaJiWmISYr/hwZJzcwR
         TzMEcryRdbaC2le9Mnh3R2zefuc8ZVkvzLOLHxOKeqKeYflsF2t10MdXJUOofesgHEBd
         DwbQ==
X-Gm-Message-State: AOJu0Yxp90wVcRtuaoNaEm2Jd6vY4LOuxhKqS0IEpKC28+krBklInhU3
	QYD7WgTXszxJwTsQPbQTQZDTVktjvJw2O/JMC+EMvLt8nbDM
X-Google-Smtp-Source: AGHT+IFnYCsyRYUiexXp9LJ27H2i/hyNQr4Aj55cGc5K/7cHsJjNSSOclI12nVlp1yhOpZatI3bmkv/fOfEFBBaxJln2/WLhSeST
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:5295:0:b0:57b:6b2a:df8 with SMTP id
 d143-20020a4a5295000000b0057b6b2a0df8mr4931120oob.1.1698867568896; Wed, 01
 Nov 2023 12:39:28 -0700 (PDT)
Date: Wed, 01 Nov 2023 12:39:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6effc06091c6d49@google.com>
Subject: [syzbot] [can?] WARNING in j1939_xtp_rx_rts
From: syzbot <syzbot+daa36413a5cedf799ae4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, 
	pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2af9b20dbb39 Merge tag 'x86-urgent-2023-10-28' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12257ac3680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1f30869bb78ec6
dashboard link: https://syzkaller.appspot.com/bug?extid=daa36413a5cedf799ae4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2af9b20d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e66f0c379e2/vmlinux-2af9b20d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3732b6e62161/bzImage-2af9b20d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+daa36413a5cedf799ae4@syzkaller.appspotmail.com

WARNING: CPU: 2 PID: 5504 at net/can/j1939/transport.c:1656 j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1656 [inline]
WARNING: CPU: 2 PID: 5504 at net/can/j1939/transport.c:1656 j1939_xtp_rx_rts+0x1553/0x17e0 net/can/j1939/transport.c:1735
Modules linked in:
CPU: 2 PID: 5504 Comm: syz-executor.3 Not tainted 6.6.0-rc7-syzkaller-00195-g2af9b20dbb39 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1656 [inline]
RIP: 0010:j1939_xtp_rx_rts+0x1553/0x17e0 net/can/j1939/transport.c:1735
Code: 00 48 89 ef e8 fe d9 eb fa e9 42 ef ff ff e8 b4 1b 4e f8 be 01 00 00 00 48 89 ef e8 e7 d9 eb fa e9 a8 f9 ff ff e8 9d 1b 4e f8 <0f> 0b 48 8d 83 c0 00 00 00 4c 8d b3 c2 00 00 00 48 89 44 24 10 e9
RSP: 0018:ffffc90000520950 EFLAGS: 00010246

RAX: 0000000000000000 RBX: ffff8880267b8400 RCX: 0000000000000100
RDX: ffff88807058c800 RSI: ffffffff8939be93 RDI: 0000000000000005
RBP: 00000000fffffff5 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff5 R11: dffffc0000000000 R12: ffff8880198ec000
R13: 0000000000000002 R14: ffff888074db3c1b R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff88802c800000(0063) knlGS:00000000f7fc4b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000002fa23000 CR3: 000000004a9cd000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 j1939_tp_cmd_recv net/can/j1939/transport.c:2057 [inline]
 j1939_tp_recv+0x366/0xf50 net/can/j1939/transport.c:2144
 j1939_can_recv+0x78b/0xa70 net/can/j1939/main.c:112
 deliver net/can/af_can.c:572 [inline]
 can_rcv_filter+0x2a5/0x8e0 net/can/af_can.c:606
 can_receive+0x31b/0x5c0 net/can/af_can.c:663
 can_rcv+0x1dc/0x270 net/can/af_can.c:687
 __netif_receive_skb_one_core+0x115/0x180 net/core/dev.c:5552
 __netif_receive_skb+0x1f/0x1b0 net/core/dev.c:5666
 process_backlog+0x101/0x6b0 net/core/dev.c:5994
 __napi_poll.constprop.0+0xb4/0x530 net/core/dev.c:6556
 napi_poll net/core/dev.c:6623 [inline]
 net_rx_action+0x956/0xe90 net/core/dev.c:6756
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 do_softirq kernel/softirq.c:454 [inline]
 do_softirq+0xaa/0xe0 kernel/softirq.c:441
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x120 kernel/softirq.c:381
 j1939_sk_sendmsg+0xeb7/0x13a0 net/can/j1939/socket.c:1266
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2558
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2612
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2641
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x61/0xe0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7fc9579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7fc45ac EFLAGS: 00000292 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020000200
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

