Return-Path: <netdev+bounces-13455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1803373BA51
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B0C281C6A
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1468AD23;
	Fri, 23 Jun 2023 14:36:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1776AD2E
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:36:47 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4F11987
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:36:45 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-77b257b9909so45232439f.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531004; x=1690123004;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dX/Y1bjDXjyX46L6txVItpNuZgpzzZS0TxSILPuB2A=;
        b=dMnsZOpMQ1n1HrXKYf5cbr9oUwQpZhjKjDDHhXb9Svty/40KjrteYMRqaOaRE31KMP
         NXcw5Nx9yWyHPsi0BdNJxMBz1gCoRRrJPCKnIja/53zNkdoNdGnw3Cw/qMykMB22UR9i
         IyxgNODsrNJ7QD0CzgGmrTt/6G821keGRAD/6sR4sh6Jv29yf6zIN8jwHIuyNexRFmuO
         sZvrx0Z7x5xMiP7DRucajU2uxTQSabMbwBG21CEO1IXb5K5LANDrsniNvhSfs+v0artU
         f0Gftkx//4V2suQsY9WRb31ljqog2QrOe/MsQJxkt7IewCx/gwekbmX3AC5xDYig5BLE
         BLfA==
X-Gm-Message-State: AC+VfDxL4QRR760apsy32Ge3s6dkdK7qdbM4l9Ch0mpXuTOASX+kOc3y
	halZk6QyizL35gY74AeEcKAj0HUag1QvMwqtaXQFAXTbNkBl
X-Google-Smtp-Source: ACHHUZ5bzPUMk2q7EX21GYAtLzNTsNn2tTQhouSYh63nqmq0fMOaGs/YubGcFB9COnSaRggyFgBio7cWxA5d+iWQXGdz8M1Crbkd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:95a2:0:b0:420:f404:40b6 with SMTP id
 b31-20020a0295a2000000b00420f40440b6mr7186337jai.1.1687531004603; Fri, 23 Jun
 2023 07:36:44 -0700 (PDT)
Date: Fri, 23 Jun 2023 07:36:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013b7a605feccee01@google.com>
Subject: [syzbot] [net?] WARNING in sock_i_ino
From: syzbot <syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    6f68fc395f49 Merge tag 'linux-can-fixes-for-6.4-20230622' ..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1665dc57280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=5da61cf6a9bc1902d422
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e35733280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12064b33280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b8a4c4a2083/disk-6f68fc39.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c8f50d314bb1/vmlinux-6f68fc39.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b4b6929c2933/bzImage-6f68fc39.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5012 at kernel/softirq.c:376 __local_bh_enable_ip+0xbe/0x130 kernel/softirq.c:376
Modules linked in:
CPU: 0 PID: 5012 Comm: syz-executor487 Not tainted 6.4.0-rc7-syzkaller-00202-g6f68fc395f49 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:__local_bh_enable_ip+0xbe/0x130 kernel/softirq.c:376
Code: 45 bf 01 00 00 00 e8 91 5b 0a 00 e8 3c 15 3d 00 fb 65 8b 05 ec e9 b5 7e 85 c0 74 58 5b 5d c3 65 8b 05 b2 b6 b4 7e 85 c0 75 a2 <0f> 0b eb 9e e8 89 15 3d 00 eb 9f 48 89 ef e8 6f 49 18 00 eb a8 0f
RSP: 0018:ffffc90003a1f3d0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000201 RCX: 1ffffffff1cf5996
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff8805c6f3
RBP: ffffffff8805c6f3 R08: 0000000000000001 R09: ffff8880152b03a3
R10: ffffed1002a56074 R11: 0000000000000005 R12: 00000000000073e4
R13: dffffc0000000000 R14: 0000000000000002 R15: 0000000000000000
FS:  0000555556726300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 000000007c646000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sock_i_ino+0x83/0xa0 net/core/sock.c:2559
 __netlink_diag_dump+0x45c/0x790 net/netlink/diag.c:171
 netlink_diag_dump+0xd6/0x230 net/netlink/diag.c:207
 netlink_dump+0x570/0xc50 net/netlink/af_netlink.c:2269
 __netlink_dump_start+0x64b/0x910 net/netlink/af_netlink.c:2374
 netlink_dump_start include/linux/netlink.h:329 [inline]
 netlink_diag_handler_dump+0x1ae/0x250 net/netlink/diag.c:238
 __sock_diag_cmd net/core/sock_diag.c:238 [inline]
 sock_diag_rcv_msg+0x31e/0x440 net/core/sock_diag.c:269
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2547
 sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:280
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x71c/0x900 net/socket.c:2503
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2557
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2586
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5303aaabb9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7506e548 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5303aaabb9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007f5303a6ed60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5303a6edf0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


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

