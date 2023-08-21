Return-Path: <netdev+bounces-29362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDE4782E81
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 18:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8E11C208E9
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E957476;
	Mon, 21 Aug 2023 16:36:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9C6FDA
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:36:59 +0000 (UTC)
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BEAFF
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 09:36:57 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-565aee93236so3803452a12.1
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 09:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692635817; x=1693240617;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DscXzbPNxTBR1mFGaAB02zyy+OW3MXcEY6WXJZDd5nU=;
        b=KKafzYcfCPr7j0+IEEkA1gmZlcQCbsTy8uQWPE5HSfFhbrD0HX1Cl6H9mOL9La9tGz
         gB76t4PuWnTZve17coTgBSw/LdBXTPsO/d9dAVhvsK+kJXZGsvhwoLxJx0m1hlq/VzoS
         6tmPoliNoQyh0eFsSUPOpV0Kdn6wR8RTQs4wYrpUXSdG23UlQwAaVPmsG/CHTVQAAC9P
         Pa6Kxo7Tp/ILRoz7qXjTQbQF/OZ+mSbOPhx4RseLvBxV/gpxLl8i49mh1AgJO6M/WETI
         q7wGE0X2d3VRB5Oc5ZkIJCk/SXgMP+Of8cBe4bTp71L/JQqO79hny4sVHAXBZ09A3+Mo
         trNA==
X-Gm-Message-State: AOJu0YyubxXO/GChfDLa+ul6lKYuvqjh+rF1SC/TG/VxWOIeuRFw9yxP
	OTb2Fn+ZkHFdYgVC6wcgv66YOxizo21RFV3a+gvjLr5Lci/k
X-Google-Smtp-Source: AGHT+IEQDWXwjb92oMzfXVoJdYwEHSi8DF11A7NLabTRacYoPPK2B/zbPpb4aoA/KqQaIFuvq1P2bXDHwug+ycWqbGfLzVMcjuKK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:a319:0:b0:565:e467:ef5e with SMTP id
 s25-20020a63a319000000b00565e467ef5emr1099865pge.5.1692635817459; Mon, 21 Aug
 2023 09:36:57 -0700 (PDT)
Date: Mon, 21 Aug 2023 09:36:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a249880603717c15@google.com>
Subject: [syzbot] [net?] [wireless?] INFO: task hung in reg_process_self_managed_hints
From: syzbot <syzbot+1f16507d9ec05f64210a@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, davem@davemloft.net, edumazet@google.com, 
	johannes@sipsolutions.net, kerneljasonxing@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    d4ddefee5160 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1653bc65a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa796b6080b04102
dashboard link: https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e59507a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16cd6137a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6187f26c7496/disk-d4ddefee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8bb63089fdb5/vmlinux-d4ddefee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1579fb12e27b/bzImage-d4ddefee.xz

The issue was bisected to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115fece3a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=135fece3a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=155fece3a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f16507d9ec05f64210a@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

INFO: task syz-executor296:5042 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc6-syzkaller-00200-gd4ddefee5160 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor296 state:D stack:24336 pid:5042  ppid:5038   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0xee1/0x59f0 kernel/sched/core.c:6710
 schedule+0xe7/0x1b0 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6845
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x967/0x1340 kernel/locking/mutex.c:747
 wiphy_lock include/net/cfg80211.h:5776 [inline]
 reg_process_self_managed_hints+0x78/0x170 net/wireless/reg.c:3181


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

