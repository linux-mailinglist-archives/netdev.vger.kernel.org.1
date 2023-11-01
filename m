Return-Path: <netdev+bounces-45505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C396E7DDB26
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 03:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA0DB20FF7
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 02:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882857E8;
	Wed,  1 Nov 2023 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68370643
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 02:51:34 +0000 (UTC)
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52734C2
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 19:51:29 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1e9e1f0edebso7952398fac.2
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 19:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698807087; x=1699411887;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJcfotsCm12BSyne7j2myEzCh5vLbz+nR4XaUK+27+k=;
        b=R7pYY7/ipqhju4B763b9QuaDzpGSRsaWQrQzpg5YftEe6t/g6dpq63JAMuG477MAb7
         UjRapRfW27DUd+L0rel6mQ9PvBz0wcqSFaLCvj9HiriVghnFp2xKhyj8D+TFOy/U7E/n
         Txk2f/OUBJ1JIQfZsWKNlh4DgSH7CLz1OWgdBwuh/EAz9c6HsD+iQJtKFHqlhgSWtI57
         ZLGsXVtXxsFTltiCrO9M3PGv3Fu3GTHbGxAHF8hiiDZPLLxUMsPdTu/WPDoaGaqdnte5
         kZoxIvc9SGqryXl+ukrd42FWBUwGTa7OFHa/WUKmcJ8EiexX1t8yNl0Vt6Fi6jwN8m1n
         Tifw==
X-Gm-Message-State: AOJu0YwzuJAQPwsVaxm0AFXsyEWDGRtfr9ajiCRFvAJm4c35s1SDSgOK
	hdi0wsjvyqfrpROmpUPBUUCKovhTI6AUr8QV8r1Wh8XWVYmQ
X-Google-Smtp-Source: AGHT+IFlc/qnt5TorD6SUYKXTdlAfhvgagYm6ivuVjTLTIc/k5wXQPNFWdniTRSM9DVROrPwtMBm4YzORjcj4sHVTXpZprY5ZfMu
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:7188:b0:1e9:a727:e1f with SMTP id
 d8-20020a056870718800b001e9a7270e1fmr7951961oah.8.1698807087782; Tue, 31 Oct
 2023 19:51:27 -0700 (PDT)
Date: Tue, 31 Oct 2023 19:51:27 -0700
In-Reply-To: <000000000000ffc87a06086172a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000261b806090e5989@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_release
From: syzbot <syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    89ed67ef126c Merge tag 'net-next-6.7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1142a1a5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e3b1d98cf5a2cca
dashboard link: https://syzkaller.appspot.com/bug?extid=8a676a50d4eee2f21539
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1751c63d680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b69c238dd56a/disk-89ed67ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f555d654a8ba/vmlinux-89ed67ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/335bbfb6c442/bzImage-89ed67ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a676a50d4eee2f21539@syzkaller.appspotmail.com

list_del corruption. next->prev should be ffff888020fe5048, but was ffff88807a0f9048. (next=ffff88802533e5e8)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:67!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5827 Comm: syz-executor.5 Not tainted 6.6.0-syzkaller-05843-g89ed67ef126c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__list_del_entry_valid_or_report+0x122/0x130 lib/list_debug.c:65
Code: 85 06 0f 0b 48 c7 c7 20 5f 9d 8b 4c 89 fe 48 89 d9 e8 52 db 85 06 0f 0b 48 c7 c7 a0 5f 9d 8b 4c 89 fe 4c 89 f1 e8 3e db 85 06 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 80 3d 1d 6e
RSP: 0018:ffffc9000aaa7db0 EFLAGS: 00010046
RAX: 000000000000006d RBX: ffff88802533e5f0 RCX: 88e517f49d581b00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffff888020fe5008 R08: ffffffff81717aac R09: 1ffff92001554f54
R10: dffffc0000000000 R11: fffff52001554f55 R12: dffffc0000000000
R13: ffff888020fe4000 R14: ffff88802533e5e8 R15: ffff888020fe5048
FS:  0000555557106480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1cc2398000 CR3: 000000001cad1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 ptp_release+0xa8/0x1e0 drivers/ptp/ptp_chardev.c:147
 posix_clock_release+0x8c/0x100 kernel/time/posix-clock.c:157
 __fput+0x3cc/0xa10 fs/file_table.c:394
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close+0x15f/0x220 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f1cc227b9da
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffe5d85d9f0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f1cc227b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000032 R08: 0000001b30160000 R09: 00007f1cc239bf8c
R10: 00007ffe5d85db40 R11: 0000000000000293 R12: 00007f1cc1e001d8
R13: ffffffffffffffff R14: 00007f1cc1e00000 R15: 0000000000015db0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x122/0x130 lib/list_debug.c:65
Code: 85 06 0f 0b 48 c7 c7 20 5f 9d 8b 4c 89 fe 48 89 d9 e8 52 db 85 06 0f 0b 48 c7 c7 a0 5f 9d 8b 4c 89 fe 4c 89 f1 e8 3e db 85 06 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 80 3d 1d 6e
RSP: 0018:ffffc9000aaa7db0 EFLAGS: 00010046

RAX: 000000000000006d RBX: ffff88802533e5f0 RCX: 88e517f49d581b00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffff888020fe5008 R08: ffffffff81717aac R09: 1ffff92001554f54
R10: dffffc0000000000 R11: fffff52001554f55 R12: dffffc0000000000
R13: ffff888020fe4000 R14: ffff88802533e5e8 R15: ffff888020fe5048
FS:  0000555557106480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1cc2398000 CR3: 000000001cad1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

