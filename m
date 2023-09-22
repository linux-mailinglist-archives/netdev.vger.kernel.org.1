Return-Path: <netdev+bounces-35657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B34D47AA7C0
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 06:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6F481281C1E
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 04:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C56017F0;
	Fri, 22 Sep 2023 04:28:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBE80D
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:28:47 +0000 (UTC)
Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFA1192
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 21:28:46 -0700 (PDT)
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-1b0812d43a0so2897293fac.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 21:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695356925; x=1695961725;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxPzbarjaZODgqqwCQTkkwcLh5B7LBYCm2W05QOmtyk=;
        b=hQOpygnp768mj+/XAHLh1swqaUBcOjLih4MzDtFQS5ULDQbkgUZSXpbN1MDqRfUGYx
         bKqCJ5KyZ9ykmOx8eF+073xZp8pxgcMkA6QRvfDAFMNlpErGU5SXn66+6BxFP78JmyR1
         y2N6CHhy+qLu83VrHbGsTdTT8FEt9gE83JMo1o9o/aAYdCbjsH3Xp48US/H3LDMY/Lan
         5JvipxfDr4MZLoA3ULX1mA5k4tC4/YzsFwT/rMWf4YcRXWiW0ldi1nC9ccssOX2e2vnd
         kiZ7nqHGwPxsZOIu9xu0qsR+BeJrPbLQuaZuA5fpKyYgswNMxoHJ8o3Mwf2au9uUkd+t
         QIaw==
X-Gm-Message-State: AOJu0YyEtQdkr3QuDzJyZrX/NNEOoRVnAvKEZ+xt7xKy63GAX9KEpdWp
	b4jxrrEOnyEiU2NghP/rUg8pikzQGchQ3TaC5yV2Q7XmrSR7
X-Google-Smtp-Source: AGHT+IEcbamxt/1DdbzQaPQIU8EDsCmp3ie4IiKq+Z8Y5KXSFigt2Wn79LWXfdQEGO7nd6XytT7rZ5ooqHlsQ1LAADP+PzgefSue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b7b1:b0:1d5:8fad:fb03 with SMTP id
 ed49-20020a056870b7b100b001d58fadfb03mr639734oab.4.1695356925522; Thu, 21 Sep
 2023 21:28:45 -0700 (PDT)
Date: Thu, 21 Sep 2023 21:28:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005039270605eb0b7f@google.com>
Subject: [syzbot] [net?] WARNING in skb_checksum_help (2)
From: syzbot <syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com>
To: andrew@daynix.com, davem@davemloft.net, edumazet@google.com, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stephen@networkplumber.org, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    489fa31ea873 Merge branch 'work.misc' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1012dbf0c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a8fa629ede9e7b9
dashboard link: https://syzkaller.appspot.com/bug?extid=01cdbc31e9c0ae9b33ac
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130cfe18c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10561350c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2f2344129720/disk-489fa31e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1be11fcb953/vmlinux-489fa31e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4549005e4fa5/bzImage-489fa31e.xz

The issue was bisected to:

commit 860b7f27b8f78564ca5a2f607e0820b2d352a562
Author: Andrew Melnychenko <andrew@daynix.com>
Date:   Wed Dec 7 11:35:57 2022 +0000

    linux/virtio_net.h: Support USO offload in vnet header.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cb9d50c80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17cb9d50c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=13cb9d50c80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com
Fixes: 860b7f27b8f7 ("linux/virtio_net.h: Support USO offload in vnet header.")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5082 at net/core/dev.c:3260 skb_checksum_help+0x4a2/0x600 net/core/dev.c:3260
Modules linked in:
CPU: 1 PID: 5082 Comm: syz-executor228 Not tainted 6.2.0-syzkaller-10827-g489fa31ea873 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
RIP: 0010:skb_checksum_help+0x4a2/0x600 net/core/dev.c:3260
Code: e0 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 63 15 70 f9 48 89 ef 41 bc ea ff ff ff e8 35 f9 ff ff eb d4 e8 4e 15 70 f9 <0f> 0b 0f b6 1d 88 29 4e 06 31 ff 89 de e8 4c 11 70 f9 84 db 0f 84
RSP: 0018:ffffc90003b6f660 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000000000034a RCX: 0000000000000000
RDX: ffff888024171d40 RSI: ffffffff8814b1f2 RDI: 0000000000000004
RBP: ffff888079090780 R08: 0000000000000004 R09: 000000000000019a
R10: 0000000000000348 R11: 0000000000000000 R12: ffff8880790907f4
R13: 0000000000000000 R14: ffff888079090800 R15: 0000000000000348
FS:  00005555559ed300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000072c0b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netem_enqueue+0x2b57/0x35b0 net/sched/sch_netem.c:510
 netem_enqueue+0x2050/0x35b0 net/sched/sch_netem.c:483
 dev_qdisc_enqueue+0x46/0x3b0 net/core/dev.c:3773
 __dev_xmit_skb net/core/dev.c:3862 [inline]
 __dev_queue_xmit+0x236a/0x3db0 net/core/dev.c:4210
 packet_snd net/packet/af_packet.c:3073 [inline]
 packet_sendmsg+0x33aa/0x55d0 net/packet/af_packet.c:3104
 sock_sendmsg_nosec net/socket.c:722 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:745
 __sys_sendto+0x23a/0x340 net/socket.c:2145
 __do_sys_sendto net/socket.c:2157 [inline]
 __se_sys_sendto net/socket.c:2153 [inline]
 __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2153
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa19dae7699
Code: 28 c3 e8 4a 15 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb3262e28 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fffb3262e48 RCX: 00007fa19dae7699
RDX: 000000000000fc13 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 000000000000002f
R10: 0000000000000800 R11: 0000000000000246 R12: 00007fffb3262e50
R13: 00007fffb3262e70 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

