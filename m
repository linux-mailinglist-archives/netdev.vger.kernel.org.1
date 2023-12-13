Return-Path: <netdev+bounces-57051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0AA811C4B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 19:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54631281E3E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E671059551;
	Wed, 13 Dec 2023 18:23:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E4FF2
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 10:23:26 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c6bd30ee89so6649552a12.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 10:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702491805; x=1703096605;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18MV4utO26KMcyyUVPOX8kfYPMir6GGoQ5g8BbWiBNI=;
        b=UgajmR21ITn0zrO6LImyiQmP73RGzg7NuV2le2GdbSzdxhh6hsI/z0CbHNfhvdbsiF
         K9YVf4gMzu+cXfeovTSlJ8u1DzbCQQzT7dIGawDkJRdcFQK4Ncg1rQ+rhfNbT9gywYDA
         MHVSKfGSOvLj3QQ0yFpL+sF4rM+GR79F7z7NsONgpI2exEsPoRKrb/QqT3OIzg8C/k02
         KOHuHv51e8aIJk7Vfe04C1EjxeGX0Oh2QwZrYmicDgYZBsFmpflT3qEqGf7vJ9BsnU91
         JLfezS5sheRe0kBaRDriFPzpLbBGpKI3ooeahc/zEMOqTBoZQlZRX8QhQIhTyDRU57PM
         VDwg==
X-Gm-Message-State: AOJu0YyspDK+6jsB4rtyZy9bAvQpsOIPJLPhd2pdw9ZqKoYFgGpP6U59
	mBtq/Phy1Aap0G3oimrDUBjaBHC6mOt0CYSMxpyY8c08EtDI
X-Google-Smtp-Source: AGHT+IGIa45ExPstKQuR/yxnoGGuZkZIIkWkUufzcicGWZ3zuob0ec3M1TL/yFgtjCaCQIR/9LN/zWv3i6I5KqILafCqYHDXGixX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:e712:0:b0:5ca:4528:d217 with SMTP id
 b18-20020a63e712000000b005ca4528d217mr283408pgi.6.1702491805662; Wed, 13 Dec
 2023 10:23:25 -0800 (PST)
Date: Wed, 13 Dec 2023 10:23:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f4579060c68431b@google.com>
Subject: [syzbot] [mptcp?] WARNING in mptcp_check_listen_stop
From: syzbot <syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2513974cc3e1 Merge branch 'stmmac-bug-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1237863ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b50bd31249191be8
dashboard link: https://syzkaller.appspot.com/bug?extid=5a01c3a666e726bc8752
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fbf7f04433a8/disk-2513974c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f839967d18d6/vmlinux-2513974c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/10f6c15a1f15/bzImage-2513974c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 27574 at net/mptcp/protocol.c:2999 mptcp_check_listen_stop.part.0+0x17b/0x240 net/mptcp/protocol.c:2999
Modules linked in:
CPU: 0 PID: 27574 Comm: syz-executor.2 Not tainted 6.7.0-rc4-syzkaller-00167-g2513974cc3e1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:mptcp_check_listen_stop.part.0+0x17b/0x240 net/mptcp/protocol.c:2999
Code: 00 00 00 0f b6 45 12 88 44 24 20 44 0f b6 6c 24 20 bf 0a 00 00 00 44 89 ee e8 c1 66 24 f7 41 80 fd 0a 74 2b e8 86 6b 24 f7 90 <0f> 0b 90 e8 7d 6b 24 f7 48 b8 00 00 00 00 00 fc ff df 49 c7 04 04
RSP: 0018:ffffc9001500fce0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88803f651880 RCX: ffffffff8a63221f
RDX: ffff8880545f1dc0 RSI: ffffffff8a63222a RDI: 0000000000000001
RBP: ffff888025953400 R08: 0000000000000001 R09: 000000000000000a
R10: 0000000000000007 R11: 0000000000000002 R12: 1ffff92002a01f9c
R13: 0000000000000007 R14: ffff88803f651892 R15: 000000000000000a
FS:  0000555556b7b480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31f25000 CR3: 0000000027e0c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mptcp_check_listen_stop net/mptcp/protocol.c:3032 [inline]
 __mptcp_close+0x888/0xa10 net/mptcp/protocol.c:3020
 mptcp_close+0x28/0xf0 net/mptcp/protocol.c:3087
 inet_release+0x132/0x270 net/ipv4/af_inet.c:433
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:485
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1419
 __fput+0x270/0xbb0 fs/file_table.c:394
 __fput_sync+0x47/0x50 fs/file_table.c:475
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close fs/open.c:1575 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f398e47ba9a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffcd1957d90 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f398e47ba9a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f398e59d980 R08: 0000001b32320000 R09: 0000000000000033
R10: 000000008a82179f R11: 0000000000000293 R12: 00000000002addf7
R13: ffffffffffffffff R14: 00007f398e000000 R15: 00000000002adab6
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

