Return-Path: <netdev+bounces-110440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6753092C6B4
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 01:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984541C20A45
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 23:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9541D189F37;
	Tue,  9 Jul 2024 23:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3B189F31
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568422; cv=none; b=HF3hwwmubDS2FKNuQQ593S8qeZ9wExGuEESwHF27fpDl1Xzppkd1qjZmjSwpskE9gpN320T3sdvLSkkjHBVpY2VUfgBExjUarBchVKvhDYWVIDpCTKtah8RyCECiluo227Aid3FrwZU4rX6cIXmK7T+N0kizHXWhd+XuWE1IiaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568422; c=relaxed/simple;
	bh=HYd5bNgY6lE5Zn1y5qi9hfi3eadEVo09Div2fMrUvi4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i9Two+2oBl5N3fAH5jgJsAE2znGKIzxb7u/WP9KWg3x3Ad1BIN51IndhHsf6CfLo8ujRaBCE/PQNQiJwrOMPf8oaOtw+ZDXO2wdIa+XUx9XVOPX5kcn9n/6QpehNTLTyST+K2dRNHZAEkefuf/qu7H7Ha8wkix+LMPhUix4WyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-381c11633e9so62187245ab.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 16:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568420; x=1721173220;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBSjopU2zPVGxuAVzvZDSrcKW6icOp6WBz4fpp5ufsY=;
        b=I0eF9ArMouxDUNdkZ5aiIwb4MKfAp9YIDekNOLu5QYoasVew36oXYg7hcbCELyj9+m
         MDC8N/m72zozadOzbdMV7L9GrlVahQpDDeRlw5YeY3Wsra7yxLVYKQdYoWsFhHbS09cu
         QL51Q82IKgSzSBMcKQheYgIo2hgmDpLDOD/sdGXDLHJFeUJs1eQchgYvToN/rnNWwj7/
         MFplBpoofkvhA/dRcaAKGGjEqD3tMAUW+wxGXRIUk+pMXd4AgC0gQHvsQ1m5pRqJc18W
         0a8D7abyyGjacMfnSr8y6jPzwcphluxzihQZMUVcnKl9UrvmEK4IVGccSfu4kLSTBYTV
         N6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPZTn+SB7v3q+uovohodggrjrW1rqqDcx9/zJvOPXVh26G1BvCnyYcS5eo0Q2Ti8mBUUzKSKqiMR7XAxBoCqsatKUtw5sx
X-Gm-Message-State: AOJu0Ywk+4y9/y6eD8U3LQkIpiKoEGRFHHPBhfxaZ38n1UqjDvmgstW2
	ve3lpcU38M70xs8XtxGAyYvaFOKglbVf7qxg2M0NJdqI9MU3LMo2ZKlW2oRW4K5ghaCFiBrlLRM
	kPN8Wwpgo4pTVb9FseKTQsA3/lLA+5u4w84kwguoljm+OArz6PZUYT2w=
X-Google-Smtp-Source: AGHT+IE5fHt0zOzTEa8nkJ/Wyvq4QnoNnCpAPtZG9rz8c+dL50MJ5ZadjqmrVkojHjjqL51GBv940gjznBSK87S+rS5MMRp+cMAg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d97:b0:382:56bd:dfb3 with SMTP id
 e9e14a558f8ab-38a58584818mr1416685ab.2.1720568420350; Tue, 09 Jul 2024
 16:40:20 -0700 (PDT)
Date: Tue, 09 Jul 2024 16:40:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081caf2061cd90d7c@google.com>
Subject: [syzbot] [wpan?] WARNING in cfg802154_pernet_exit
From: syzbot <syzbot+ea134023eba0b937095a@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, 
	miquel.raynal@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0913ec336a6c net: ks8851: Fix deadlock with the SPI chip v..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11fcf3b9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=864caee5f78cab51
dashboard link: https://syzkaller.appspot.com/bug?extid=ea134023eba0b937095a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ca08c938c680/disk-0913ec33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/94b3b925e4c6/vmlinux-0913ec33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ecb897178dbe/bzImage-0913ec33.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea134023eba0b937095a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1057 at net/ieee802154/core.c:354 cfg802154_pernet_exit+0xb9/0xe0 net/ieee802154/core.c:354
Modules linked in:
CPU: 1 PID: 1057 Comm: kworker/u8:5 Not tainted 6.10.0-rc6-syzkaller-00170-g0913ec336a6c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: netns cleanup_net
RIP: 0010:cfg802154_pernet_exit+0xb9/0xe0 net/ieee802154/core.c:354
Code: 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 1c b7 c3 f6 48 8b 1b 4c 39 e3 74 12 e8 ef 01 5e f6 eb 89 e8 e8 01 5e f6 90 <0f> 0b 90 eb d0 e8 dd 01 5e f6 eb 05 e8 d6 01 5e f6 5b 41 5c 41 5d
RSP: 0018:ffffc90004547a88 EFLAGS: 00010293
RAX: ffffffff8b3825c8 RBX: ffff8880231c2008 RCX: ffff88802251bc00
RDX: 0000000000000000 RSI: 00000000ffffffef RDI: 0000000000000000
RBP: 00000000ffffffef R08: ffffffff8b382595 R09: 1ffffffff1ebcdc4
R10: dffffc0000000000 R11: fffffbfff1ebcdc5 R12: ffffffff8f8d05e0
R13: dffffc0000000000 R14: ffff888022dfd640 R15: ffff8880231c2608
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff96115b460 CR3: 000000005cf20000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

