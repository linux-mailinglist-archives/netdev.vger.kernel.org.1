Return-Path: <netdev+bounces-17053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8851C74FEE4
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 07:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FD41C20ED4
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162833FED;
	Wed, 12 Jul 2023 05:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072783FDF
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 05:54:58 +0000 (UTC)
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200FC173A
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 22:54:57 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-3a41b765478so789508b6e.0
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 22:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689141296; x=1691733296;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOVKFzs9KIWmQMyZ0PHhgdwB2c2fu32hI4Diu1DLd8g=;
        b=YKvZIeDJ0vhNxKacWLp8zezJQtHLRXPx6uNHrRHuc/nV9jFLLLTrjnGdSrHfAIn4Lq
         AfFmxPsjlub/1PNvMWjkEDWw7IkMDE5OdmaAmMTJBX/OscrrAFA9tvxdaVBhp7bQBs0y
         K+rFJkWlgBxFjyGJyqknaoqAyEly58hxiK4fBbDAryynOdol6i3Xur4vCacBw5+xAjd/
         7+r3hWGZaZflaed1D7swGafn1taJcPhcnghO4xLZNSXdbNo5m8XoUL1f1tuHIq163XBO
         WHRRZiPFXWy0QuXn49HLm8PEDo8lh5jzEVxxnh9R086+A/xipko9UQ+GwQPgD+mfE+xG
         i4Hw==
X-Gm-Message-State: ABy/qLapU5xGsSjGM0q/4Y6afGWlQsEG4GZxGgov4xC6SVRhrkNl8ugG
	mIXNaLxqyg3LbmNq/KRtmisxqE+LudftCKjRrwxnIDIxmjBs
X-Google-Smtp-Source: APBJJlGdmN/HuSAX1E5vLHgsmHpMHTxprXKdiLnBMvOf74/u1vRYOx8HVqrle/4ui6EGq2kinyhM5J6ylIqoOT3lYZxXJQxZ+AoH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1152:b0:3a3:c492:9be6 with SMTP id
 u18-20020a056808115200b003a3c4929be6mr1585895oiu.2.1689141296509; Tue, 11 Jul
 2023 22:54:56 -0700 (PDT)
Date: Tue, 11 Jul 2023 22:54:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f43987060043da7b@google.com>
Subject: [syzbot] [nfc?] memory leak in virtual_ncidev_write (2)
From: syzbot <syzbot+6b7c68d9c21e4ee4251b@syzkaller.appspotmail.com>
To: bongsu.jeon@samsung.com, krzysztof.kozlowski@linaro.org, 
	linux-kernel@vger.kernel.org, linux-nfc@lists.01.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    4f6b6c2b2f86 Merge tag 'riscv-for-linus-6.5-mw2' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1565b4e2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=832b404e095b70c0
dashboard link: https://syzkaller.appspot.com/bug?extid=6b7c68d9c21e4ee4251b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1296aa88a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e31cbca80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/894096f65e3a/disk-4f6b6c2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fb7cd620415e/vmlinux-4f6b6c2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b6554eae0e7/bzImage-4f6b6c2b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b7c68d9c21e4ee4251b@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff88810ac1a700 (size 240):
  comm "syz-executor366", pid 5017, jiffies 4294944625 (age 12.970s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e1b1cd>] __alloc_skb+0x1fd/0x230 net/core/skbuff.c:634
    [<ffffffff82c344e4>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff82c344e4>] virtual_ncidev_write+0x34/0xf0 drivers/nfc/virtual_ncidev.c:115
    [<ffffffff8165e315>] vfs_write+0x175/0x570 fs/read_write.c:582
    [<ffffffff8165e951>] ksys_write+0xa1/0x160 fs/read_write.c:637
    [<ffffffff84a76ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a76ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888109c4b400 (size 640):
  comm "syz-executor366", pid 5017, jiffies 4294944625 (age 12.970s)
  hex dump (first 32 bytes):
    10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e17a86>] kmalloc_reserve+0xe6/0x180 net/core/skbuff.c:559
    [<ffffffff83e1b0a5>] __alloc_skb+0xd5/0x230 net/core/skbuff.c:644
    [<ffffffff82c344e4>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff82c344e4>] virtual_ncidev_write+0x34/0xf0 drivers/nfc/virtual_ncidev.c:115
    [<ffffffff8165e315>] vfs_write+0x175/0x570 fs/read_write.c:582
    [<ffffffff8165e951>] ksys_write+0xa1/0x160 fs/read_write.c:637
    [<ffffffff84a76ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a76ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



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

