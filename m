Return-Path: <netdev+bounces-15713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D70E749505
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 07:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD6C1C20CE3
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 05:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434F2A47;
	Thu,  6 Jul 2023 05:36:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BDFEDD
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 05:36:07 +0000 (UTC)
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260911BF9
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 22:35:59 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-66872e30de9so634690b3a.3
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 22:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688621758; x=1691213758;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8IG/7a1r+lbg72l7T26yvBl01awCMA71YiK77chGGY=;
        b=QxKpkHxfL2RsXcOGVfjRPL3pqsL8kVItBOzVwGEwqit8X/KDOgLV8+PBtUbpCC6161
         OHFu3ZHlxpRST82NuO/zgi+Xg2SN9gFS1+VZsKAufezbbzVRFhHRjZ+eaPB/sQeLMUpP
         UjfHULwSzfdJ0xYzRLotsNcCTpmUVOPzapFpt0LCz2RD8QkLM4hHZZVjTKSZDUsRcrpM
         ToTLXENBcbz/dhJp3sEx8//o24BUq1C0FUSi+E8bCl9TLmySNgtvij3q1bB3GffshG7d
         GGybn1FgaCMcN+0r9JlMJSIhQy9vFg764cMHsiUBzc5lcfsdOyMBfvXNyAwJURsCUgqP
         WDVg==
X-Gm-Message-State: ABy/qLYnQrJ2af/83LRPPxQ7i/g+T8DbGp4zT0Cc9myNaWisei0htAyX
	7tXNRd3jvPwI975ozcPaZ7SNeIX7nTnMh1LtX/oabPY8588S
X-Google-Smtp-Source: APBJJlHZV14xswxelXjf2gNMVwi7ttbcjOZU6bY8KMzghjNPkZhZ4HCiV3TXsEZ54Vyvhpc7pg50NtR8npI/+S5dYgQVOThu6sJn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d16:b0:677:c9da:14b6 with SMTP id
 fa22-20020a056a002d1600b00677c9da14b6mr1140786pfb.4.1688621758557; Wed, 05
 Jul 2023 22:35:58 -0700 (PDT)
Date: Wed, 05 Jul 2023 22:35:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001432c105ffcae455@google.com>
Subject: [syzbot] [wireless?] WARNING in restore_regulatory_settings (2)
From: syzbot <syzbot+dfe2fbeb4e710bbaddf9@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, davem@davemloft.net, 
	edumazet@google.com, hare@suse.de, hch@lst.de, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    6352a698ca5b Add linux-next specific files for 20230630
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=3D11f564a4a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D39b764f3018462f=
e
dashboard link: https://syzkaller.appspot.com/bug?extid=3Ddfe2fbeb4e710bbad=
df9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils=
 for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1640f4a0a8000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11a10c40a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/55254daea013/disk-=
6352a698.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cb343779c938/vmlinux-=
6352a698.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d451333dab6/bzI=
mage-6352a698.xz

The issue was bisected to:

commit ae220766d87cd6799dbf918fea10613ae14c0654
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Jun 8 11:02:37 2023 +0000

    block: remove the unused mode argument to ->release

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1340a3f0a800=
00
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D10c0a3f0a800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D1740a3f0a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+dfe2fbeb4e710bbaddf9@syzkaller.appspotmail.com
Fixes: ae220766d87c ("block: remove the unused mode argument to ->release")

------------[ cut here ]------------
Unexpected user alpha2: =EF=BF=BDI
WARNING: CPU: 0 PID: 9 at net/wireless/reg.c:438 is_user_regdom_saved net/w=
ireless/reg.c:438 [inline]
WARNING: CPU: 0 PID: 9 at net/wireless/reg.c:438 restore_alpha2 net/wireles=
s/reg.c:3399 [inline]
WARNING: CPU: 0 PID: 9 at net/wireless/reg.c:438 restore_regulatory_setting=
s+0x210/0x1760 net/wireless/reg.c:3491
Modules linked in:
CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.4.0-next-20230630-syzkaller #=
0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 05/27/2023
Workqueue: events_power_efficient crda_timeout_work
RIP: 0010:is_user_regdom_saved net/wireless/reg.c:438 [inline]
RIP: 0010:restore_alpha2 net/wireless/reg.c:3399 [inline]
RIP: 0010:restore_regulatory_settings+0x210/0x1760 net/wireless/reg.c:3491
Code: e6 03 44 89 f6 e8 50 d7 09 f8 45 84 f6 0f 85 7a 07 00 00 e8 62 db 09 =
f8 44 89 e2 44 89 ee 48 c7 c7 20 bc 9f 8b e8 c0 2b d1 f7 <0f> 0b e8 49 db 0=
9 f8 48 8b 1d d2 80 f8 04 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc900000e7c30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 00000000000000bf RCX: 0000000000000000
RDX: ffff888016a68000 RSI: ffffffff814c65a7 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000049
R13: 00000000000000bf R14: 0000000000000000 R15: ffff8880b983bb80
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 0000000073e5d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 crda_timeout_work+0x28/0x50 net/wireless/reg.c:540
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

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

