Return-Path: <netdev+bounces-54060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B20805D4D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58791F213B9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE9968B68;
	Tue,  5 Dec 2023 18:25:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D4AAC
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 10:25:33 -0800 (PST)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1fae4875e0eso5701637fac.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 10:25:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800732; x=1702405532;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qt2IPYpVqJcBLk2RvD4/pXQbbdMV2lIC4jrljwh1tcQ=;
        b=icXW00+SiTkzbGYY7+gdltMUEIFpErB8KJGFONYMRm+ra5BC9gPuvtU199/f2sq+Sj
         OZh2dND/mFv7XYe4m9st7aVtA2uw+esem5BpUCJAX+GCclN5fJGSMZGo9cjtUO7MorQY
         uQNCW4Z8fbuVfcuu2Yg/vTauSiY1DtnTVJGHkLPnPy+KU9pfKJEhp/hSU/sak2F1Zk9R
         HV+Jqwl1pJqzOhzDZuAWJeyIpyIPVO1ROmz7YfhI0Tz7j6qgLaOFVEfHL4Ne1vU3Bwpn
         ZeWIXfGPqzDWgmrrvyUiLkxeUo4Y1vzhGt7wbmWfueDZDnti+oaXWfNaKeaFNj8qNg0p
         XFOQ==
X-Gm-Message-State: AOJu0YzDxH1ypw/cFDoTXjre31G0ZL6l85RowETC4D5VHMG8/UWK7/i3
	2bFOHROuporKQ6nfEO3cQZ77yVY1Hk6CpYkqSSRsI/0kpKys
X-Google-Smtp-Source: AGHT+IFZHDzqNlD/0jbez0iFB7jDTZLKQWBYaRkHCavKQDFJMy29oEdnZomvbogAb4l3Gwi/W180SmdAfMKy1SJ39SDJXY+G2tS8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:160a:b0:1fa:4e4:c49 with SMTP id
 b10-20020a056870160a00b001fa04e40c49mr5853088oae.0.1701800731972; Tue, 05 Dec
 2023 10:25:31 -0800 (PST)
Date: Tue, 05 Dec 2023 10:25:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b9bed060bc75cbc@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From: syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: **

Hello,

syzbot found the following issue on:

HEAD commit:    1c41041124bd Merge tag 'i3c/for-6.7' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10429eeb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=956549bd1d1e9efd
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ad66046b913bc04c6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b6a00f680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121471ef680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/20fd86e677f1/disk-1c410411.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ccd39cb0b7b6/vmlinux-1c410411.xz
kernel image: https://storage.googleapis.com/syzbot-assets/156fc60f97bc/bzImage-1c410411.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com

syz-executor994 uses obsolete (PF_INET,SOCK_PACKET)
=====================================================
BUG: KMSAN: uninit-value in __llc_lookup_established+0xe9d/0xf90
 __llc_lookup_established+0xe9d/0xf90
 __llc_lookup net/llc/llc_conn.c:611 [inline]
 llc_conn_handler+0x4bd/0x1360 net/llc/llc_conn.c:791
 llc_rcv+0xfbb/0x14a0 net/llc/llc_input.c:206
 __netif_receive_skb_one_core net/core/dev.c:5527 [inline]
 __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5641
 netif_receive_skb_internal net/core/dev.c:5727 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5786
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
 tun_get_user+0x53af/0x66d0 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x8ef/0x1490 fs/read_write.c:584
 ksys_write+0x20f/0x4c0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x93/0xd0 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable daddr created at:
 llc_conn_handler+0x53/0x1360 net/llc/llc_conn.c:783
 llc_rcv+0xfbb/0x14a0 net/llc/llc_input.c:206

CPU: 1 PID: 5004 Comm: syz-executor994 Not tainted 6.6.0-syzkaller-14500-g1c41041124bd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
=====================================================


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

