Return-Path: <netdev+bounces-35570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C847A9C10
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5602810B1
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471BF4176F;
	Thu, 21 Sep 2023 19:02:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4E17741
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:02:03 +0000 (UTC)
Received: from mail-qv1-f80.google.com (mail-qv1-f80.google.com [209.85.219.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55406803F0
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:01:59 -0700 (PDT)
Received: by mail-qv1-f80.google.com with SMTP id 6a1803df08f44-65854d1f626so11316946d6.2
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322919; x=1695927719;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lExL84plHs9XpBTTxEFLCXaT++DsJzvu8f+siPumnEU=;
        b=Wiso01O2LeY+bF8chJ4E7YELQGzxxzZCOOf8lkRydCeggPTFwrrgQoQkVclTePXS4E
         KjrE5tu6k+IuUiXmeQUuHuJufGd2Olvj/sIg7RoC5i6eFTu2K/lJlKTo09sgcXpX6RW0
         xjL07WV0fx2yt3b9/5mOHEazWPHrlwjXSvuNSTduOjDoxgfmVcIXCBARRHWK/18gahgL
         fDRO5uIaJcB1TAFR3nFOYztlZsT9A4QX23zU+Ort75nh/6jo+jVinKcgpaoW+7L1R40Y
         0mVJH9jZkib2HjdVPwYGwZut4IBQdlpr6Wzo9MA+jHMVxpuPA5NzxMPbvQUPslBwmHp1
         Y10A==
X-Gm-Message-State: AOJu0YwWZfqRSC91QoPNvHE+SoTTX9fw04gJGhYG4iaWhTUVL/Ue0brC
	ckWRJz3ewAukyCaoBbP+TdrPee5cMcKjuyNuSX3G2xB1SgH2
X-Google-Smtp-Source: AGHT+IGzwtLJCFhOShMYeh16/4hp+A6HqekIaDWfKz8uTxSoxI7pmKLeA3cisYoKrQI2l13RW1g996hLzfThoRXJAAFfb3N/FQ5t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:17a6:b0:3a8:8b74:fd46 with SMTP id
 bg38-20020a05680817a600b003a88b74fd46mr2424160oib.8.1695289013246; Thu, 21
 Sep 2023 02:36:53 -0700 (PDT)
Date: Thu, 21 Sep 2023 02:36:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d24f50605db3b41@google.com>
Subject: [syzbot] [tipc?] KMSAN: uninit-value in __tipc_nl_bearer_enable (2)
From: syzbot <syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jmaloy@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    4a0fc73da97e Merge tag 's390-6.6-2' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15cc921c680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2fd75f3f45dd99
dashboard link: https://syzkaller.appspot.com/bug?extid=9425c47dccbcb4c17d51
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1737422c680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c74c94680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/28d14dd1284c/disk-4a0fc73d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5ca8dd87357/vmlinux-4a0fc73d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7dda831a503/bzImage-4a0fc73d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in strscpy+0xc4/0x160
 strscpy+0xc4/0x160
 bearer_name_validate net/tipc/bearer.c:147 [inline]
 tipc_enable_bearer net/tipc/bearer.c:259 [inline]
 __tipc_nl_bearer_enable+0x634/0x2220 net/tipc/bearer.c:1043
 tipc_nl_bearer_enable+0x3c/0x70 net/tipc/bearer.c:1052
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
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2540
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2594
 __sys_sendmsg net/socket.c:2623 [inline]
 __do_sys_sendmsg net/socket.c:2632 [inline]
 __se_sys_sendmsg net/socket.c:2630 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2630
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
 slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
 kmalloc_reserve+0x148/0x470 net/core/skbuff.c:559
 __alloc_skb+0x318/0x740 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1286 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1214 [inline]
 netlink_sendmsg+0xb34/0x13d0 net/netlink/af_netlink.c:1885
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg net/socket.c:753 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2540
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2594
 __sys_sendmsg net/socket.c:2623 [inline]
 __do_sys_sendmsg net/socket.c:2632 [inline]
 __se_sys_sendmsg net/socket.c:2630 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2630
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

CPU: 1 PID: 4993 Comm: syz-executor386 Not tainted 6.5.0-syzkaller-12145-g4a0fc73da97e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
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

