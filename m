Return-Path: <netdev+bounces-26811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16B877911C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B631C21501
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17DE29DF7;
	Fri, 11 Aug 2023 13:57:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9416620FB3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 13:57:09 +0000 (UTC)
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E9C30CB
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:57:07 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1bda71e4eb8so17958005ad.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691762227; x=1692367027;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ds3aUmdjpf+HFfBxz4dhh1sRq2srANYLhw7fJ21z5R8=;
        b=DnoqvV+UQ0vxJw84yKdjzYqlTdeHhs5RzD3pEnoBEDtpEKtekCDCxyxyFYhb82UVs3
         6pSsY9nFEGid7VC+UOjlPevj6p6LmyXtZM/Gt+fclheHYHGqIpxxE9v0Na0960ITLVE+
         SbLcE97IcLo/MCxg/Haq24Vi7Hok720Xfiv00eussC4GqHIqyzrDTXVydvdHQTCUvhJd
         3XQvRaOO2oN5TjHytFCQl4OmQZq98YaKvQsoO8dqYms5beL4OsPLAatSIjtr9zb7u0Qw
         JMLPip7i1AsjWnHLYux+GGZxTfN17Whu2D3sciwh/8Okmz3xeTI2tr/NqLxRyzpxPJG9
         O/sQ==
X-Gm-Message-State: AOJu0Yzw43smkmaiVXn921D0zkbhWbXtWJIt15EOIWEln5oV70jRCMXO
	M384CUeTeaSfwDFZfWe3iSOhBdxkvb7JsgOiK0djGtPU5TiT
X-Google-Smtp-Source: AGHT+IF6J3jRZxTdbzywrqfd4BNmjtJ9d2u8VUtmGI4YC3X/ul8r2fNSyWscmrdEVjDNOVRDtjHb3blP3wq/i9jaYEZqxJyFKT5c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:228b:b0:1b9:e8e5:b0a4 with SMTP id
 b11-20020a170903228b00b001b9e8e5b0a4mr684190plh.8.1691762227062; Fri, 11 Aug
 2023 06:57:07 -0700 (PDT)
Date: Fri, 11 Aug 2023 06:57:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096ae870602a61602@google.com>
Subject: [syzbot] [net?] WARNING in rtnl_dellink (3)
From: syzbot <syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com>
To: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, hawk@kernel.org, idosch@nvidia.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	vladbu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    048c796beb6e ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15b02135a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=4b4f06495414e92701d5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1700ccaba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158dfa43a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf6b84b5998f/disk-048c796b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4000dee89ebe/vmlinux-048c796b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b700ee9bd306/bzImage-048c796b.xz

The issue was bisected to:

commit 718cb09aaa6fa78cc8124e9517efbc6c92665384
Author: Vlad Buslov <vladbu@nvidia.com>
Date:   Tue Aug 8 09:35:21 2023 +0000

    vlan: Fix VLAN 0 memory leak

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1369e31da80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10e9e31da80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1769e31da80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com
Fixes: 718cb09aaa6f ("vlan: Fix VLAN 0 memory leak")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5090 at net/core/dev.c:10876 unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Modules linked in:
CPU: 0 PID: 5090 Comm: syz-executor155 Not tainted 6.5.0-rc4-syzkaller-00248-g048c796beb6e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:unregister_netdevice_many_notify+0x14d8/0x19a0 net/core/dev.c:10876
Code: b4 1a 00 00 48 c7 c6 e0 18 81 8b 48 c7 c7 20 19 81 8b c6 05 ab 19 6c 06 01 e8 b4 22 23 f9 0f 0b e9 64 f7 ff ff e8 68 60 5c f9 <0f> 0b e9 3b f7 ff ff e8 fc 68 b0 f9 e9 fc ec ff ff 4c 89 e7 e8 4f
RSP: 0018:ffffc90003c4f158 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000028921a01 RCX: 0000000000000000
RDX: ffff888020503b80 RSI: ffffffff8829a7b8 RDI: 0000000000000001
RBP: ffff88807d990000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880274efe00
R13: 0000000000000000 R14: 0000000000000002 R15: ffff8880274efe00
FS:  0000555555fb0380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdeffb1328 CR3: 000000002a3a9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rtnl_delete_link net/core/rtnetlink.c:3214 [inline]
 rtnl_dellink+0x3c1/0xae0 net/core/rtnetlink.c:3266
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2876b4cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdeffb1428 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f2876b4cce9
RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 0000000000000004
RBP: 00000000000f4240 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000100000000 R11: 0000000000000246 R12: 00007ffdeffb1480
R13: 00000000000157a9 R14: 00007ffdeffb144c R15: 0000000000000003
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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

