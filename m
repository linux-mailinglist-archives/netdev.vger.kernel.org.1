Return-Path: <netdev+bounces-35561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7172F7A9CA4
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF06E284748
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796F69876;
	Thu, 21 Sep 2023 18:35:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174D51BAA
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:35:07 +0000 (UTC)
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D079C3435
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:19:15 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3ade3847902so1581634b6e.2
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320306; x=1695925106;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5eKlR0bOZ9M5Cm2koJtpaOYOwUm+68GDkQPHQ8NLg8=;
        b=Q91FvQnHWg4ypW4FrTXURMsUuyXKgiDBUh5fOTNei71o7w6iiWdxRlxln7iOpaDEDy
         Tc1UelaSsbCOELSsn3Y/fW9xQc0GLoS23hRXD/l2L2Yt0qB4pafN5JaAQmr+5PCkw9Vq
         wv+NBjAKeIjl1Nyiix+PD2NCJuOQxNEjgTqMlAbqjpr4/uUlTJ9jDZV/L8jD+++xAAmd
         mHaEMQ2lO+YWatmCpSZemcIHRZHmM4+Hv6uKNBkSy27hHbM7ex2jnLQb9fqtXaZS2GZb
         2l/kkMKyQCeor60G5OTrWbvwNimgqapfouE6pva6AS77SV+E/dqBVu/i1srz+2sZutki
         e2Pw==
X-Gm-Message-State: AOJu0YwvMczliwP6mO9rC0oiWPrfj69EJzEG61ju7bG8oxJZz3UKfnUx
	d3ebjwXLxbrJ8tbOczJkh8TiPsYjd2Jv7YbT7pauBoDdINhG
X-Google-Smtp-Source: AGHT+IEGsNcV85CID5pSiL55ACOjxAP6chPeC2dcnrPnHY3rRCNACulzsocADpcJgo+ZhtdenRVKbgvuWL+fAtaMkJj7mw+w+Knd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c79d:b0:1d6:5d92:c94f with SMTP id
 dy29-20020a056870c79d00b001d65d92c94fmr2065665oab.11.1695289013480; Thu, 21
 Sep 2023 02:36:53 -0700 (PDT)
Date: Thu, 21 Sep 2023 02:36:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070b4660605db3b5d@google.com>
Subject: [syzbot] [tipc?] KMSAN: uninit-value in tipc_nl_node_reset_link_stats
From: syzbot <syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jmaloy@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    e42bebf6db29 Merge tag 'efi-fixes-for-v6.6-1' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13627ea0680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=754d6383bae8bc99
dashboard link: https://syzkaller.appspot.com/bug?extid=5138ca807af9d2b42574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bbea38680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1692689c680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dc8a44662519/disk-e42bebf6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ee44b8b9dd0/vmlinux-e42bebf6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5d5e45bf97a/bzImage-e42bebf6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in strlen lib/string.c:418 [inline]
BUG: KMSAN: uninit-value in strstr+0xb8/0x2f0 lib/string.c:756
 strlen lib/string.c:418 [inline]
 strstr+0xb8/0x2f0 lib/string.c:756
 tipc_nl_node_reset_link_stats+0x3ea/0xb50 net/tipc/node.c:2595
 genl_family_rcv_msg_doit net/netlink/genetlink.c:971 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
 genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1075
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
 __sys_sendmsg net/socket.c:2624 [inline]
 __do_sys_sendmsg net/socket.c:2633 [inline]
 __se_sys_sendmsg net/socket.c:2631 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
 slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
 __alloc_skb+0x318/0x740 net/core/skbuff.c:650
 alloc_skb include/linux/skbuff.h:1286 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
 netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
 __sys_sendmsg net/socket.c:2624 [inline]
 __do_sys_sendmsg net/socket.c:2633 [inline]
 __se_sys_sendmsg net/socket.c:2631 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

CPU: 0 PID: 4999 Comm: syz-executor394 Not tainted 6.6.0-rc1-syzkaller-00125-ge42bebf6db29 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
=====================================================


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

