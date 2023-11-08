Return-Path: <netdev+bounces-46611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065D7E566D
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 13:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 819DFB20DD8
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E975D505;
	Wed,  8 Nov 2023 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6663C1
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 12:38:27 +0000 (UTC)
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04DF1BF0
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 04:38:26 -0800 (PST)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3b3f5a58408so9187461b6e.1
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 04:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699447106; x=1700051906;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9rx/NIwDuIO7RH8l1m10PzkYB91FmtIKSHTeanxTHM=;
        b=Pk54R2uqG+/AuXaLkS+KZCDzE0+0LEsF8G7m07BcQ0rEcGPyQhpb+BNrQeJcfWKkvh
         id3RZe3YeowHbq64zrKQSHNP00Ups60Ujr8u2aRE5Vn77UF4bMA16/dYZegIbPZ1ejPR
         n3NQiq662jgHeM1hxmFnlaPSZ3HClinwYFQgrpQLdjkuRKMEWpm4iXIxXdA+YW4azjEt
         /v+e/vdIVEWjevu9EwURokf8q/74Nw2CVwcMTFFqV6nYqVSd8lgGjS+ctY1P0F6hA+AY
         oBIx3zW5HQgaHUAbSlpAagxVVAJJIbgSOq068hswYhwC4VqTS3LovP+3Ov5As45FbU7F
         3lRA==
X-Gm-Message-State: AOJu0YwtZHdOziWAT9fZkjJ6aJ4PwmOFVmpw0fLCQ5a9e3ivuzyJAHh5
	iSfkoKtQnBH8v29gdrHIIfUY3O3XL1LjVNR1rza0Hkglha44
X-Google-Smtp-Source: AGHT+IG71zcFpz6v7BgDMgGsmf8ro6g3f2BtFnk+5GxCdSxmGM4jtJyBkjuFqm2Buq1Xn8XzDIk65nSM9m/S/cMH3sSE+eWS5nQl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:198f:b0:3ae:2024:837d with SMTP id
 bj15-20020a056808198f00b003ae2024837dmr769620oib.8.1699447106316; Wed, 08 Nov
 2023 04:38:26 -0800 (PST)
Date: Wed, 08 Nov 2023 04:38:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001633ea0609a35d4d@google.com>
Subject: [syzbot] [wireless?] [net?] WARNING in ieee80211_rfkill_poll
From: syzbot <syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1437f47b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0220f5f3436eb1a
dashboard link: https://syzkaller.appspot.com/bug?extid=7e59a5bfc7a897247e18
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c670c0e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1310d47b680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/38f32e2d2d96/disk-90b0c2b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ec454d0d1d26/vmlinux-90b0c2b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/110137c447a9/bzImage-90b0c2b2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 732 at net/mac80211/driver-ops.h:688 drv_rfkill_poll net/mac80211/driver-ops.h:688 [inline]
WARNING: CPU: 1 PID: 732 at net/mac80211/driver-ops.h:688 ieee80211_rfkill_poll+0x134/0x170 net/mac80211/cfg.c:3100
Modules linked in:
CPU: 1 PID: 732 Comm: kworker/1:2 Not tainted 6.6.0-syzkaller-14142-g90b0c2b2edd1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: events_power_efficient rfkill_poll
RIP: 0010:drv_rfkill_poll net/mac80211/driver-ops.h:688 [inline]
RIP: 0010:ieee80211_rfkill_poll+0x134/0x170 net/mac80211/cfg.c:3100
Code: 60 07 00 00 be ff ff ff ff 48 8d 78 68 e8 44 f4 38 00 31 ff 89 c5 89 c6 e8 89 59 39 fb 85 ed 0f 85 44 ff ff ff e8 0c 5e 39 fb <0f> 0b e9 38 ff ff ff e8 00 5e 39 fb 0f 0b 48 c7 c7 f8 16 34 89 e8
RSP: 0018:ffffc90001cafc90 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888100ff0700 RCX: ffffffff8614b267
RDX: ffff888107368000 RSI: ffffffff8614b274 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 1ffffffff15c0565 R12: ffff888100ff0700
R13: 0000000000000001 R14: ffffc90001cafd80 R15: ffff8881f673ad40
FS:  0000000000000000(0000) GS:ffff8881f6700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6477ad0e40 CR3: 00000001122fe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rdev_rfkill_poll net/wireless/rdev-ops.h:636 [inline]
 cfg80211_rfkill_poll+0xc9/0x240 net/wireless/core.c:224
 rfkill_poll+0x8d/0x110 net/rfkill/core.c:1037
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

