Return-Path: <netdev+bounces-16235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E5174C090
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 05:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CEA1C208C1
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 03:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E679315BE;
	Sun,  9 Jul 2023 03:11:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE6ECA
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 03:11:52 +0000 (UTC)
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0D7CD
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 20:11:49 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1b8130aceefso48534945ad.2
        for <netdev@vger.kernel.org>; Sat, 08 Jul 2023 20:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688872309; x=1691464309;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f30W+jG79SI49HyRGQyMYd1hd13D1P4OJGijLMK/fQc=;
        b=N1liJClNeecuve8RcYsZESU4MMp9jkN+QbwW7q8sDrmJoNzHexxuFU6DH1iUp6ZppE
         6xLWPY+k5+DwIpXjJH+AqTEJkeEzlLd1o2YbaYn3+bPFsS5iLv2MNrMqlrCx38HYyW5W
         Gr7wupL/uIhxDejn6EbQSOn/6uwexmDciddUXSFME0xEmdG9iu9r5iZHPJoREHj6okWw
         eeu9x8s/lCN/a+sOZHaRC2X8QqxwaIPEGBcc/k/bnmcSAm3kbjNFR3UOLyCqndrQtwNC
         GHEfTpXUCY1Y0fcO1ETawrYoPGMBKFv93GjGQjwKbYGN02S4vEMAPxgDtp+hhELAKmup
         MFig==
X-Gm-Message-State: ABy/qLYL4SdMG4JpqYfbrYXbEsKTjmYMREmyzO7IIsB94IWz2gXrvLQR
	6a7mQ/04lNo0xcHFUsBHa4NDzH0mjclrSCMo93duYjN/64YO
X-Google-Smtp-Source: APBJJlGav31N1JqkTp7+pQ2obQCaiVGDLCDKDkvtFTMfIM1z6kv0mF8vBiz4DMB1W3YYlIG1DUqKNiEO9dBI3fK3V8unOZg7L6dL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:9681:b0:1b8:d44:32aa with SMTP id
 n1-20020a170902968100b001b80d4432aamr8727573plp.1.1688872309496; Sat, 08 Jul
 2023 20:11:49 -0700 (PDT)
Date: Sat, 08 Jul 2023 20:11:49 -0700
In-Reply-To: <000000000000e8364c05ceefa4cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001422b90600053af3@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_session_activate
From: syzbot <syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has found a reproducer for the following issue on:

HEAD commit:    8fc3b8f082cc Merge tag 'hardening-v6.5-rc1-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f232bca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9831e2c2660aae77
dashboard link: https://syzkaller.appspot.com/bug?extid=f32cbede7fd867ce0d56
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d77778a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103080b0a80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-8fc3b8f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0b4504d8c3f/vmlinux-8fc3b8f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9dab524b6b38/bzImage-8fc3b8f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-syzkaller-12415-g8fc3b8f082cc #0 Not tainted
------------------------------------------------------
ksoftirqd/0/16 is trying to acquire lock:
ffff88802c7cd088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88802c7cd088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: j1939_session_list_lock net/can/j1939/transport.c:238 [inline]
ffff88802c7cd088 (&priv->active_session_list_lock){+.-.}-{2:2}, at: j1939_session_activate+0x47/0x4b0 net/can/j1939/transport.c:1564

but task is already holding lock:
ffff8880238935c8 (&jsk->sk_session_queue_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff8880238935c8 (&jsk->sk_session_queue_lock){+.-.}-{2:2}, at: j1939_sk_queue_activate_next+0x5f/0x4d0 net/can/j1939/socket.c:207

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&jsk->sk_session_queue_lock){+.-.}-{2:2}:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       j1939_sk_queue_drop_all+0x3b/0x2f0 net/can/j1939/socket.c:139
       j1939_sk_netdev_event_netdown+0x7f/0x160 net/can/j1939/socket.c:1280
       j1939_netdev_notify+0x19f/0x1d0 net/can/j1939/main.c:381
       notifier_call_chain+0xb6/0x3c0 kernel/notifier.c:93
       call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
       call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
       call_netdevice_notifiers net/core/dev.c:2014 [inline]
       __dev_notify_flags+0x1ea/0x2d0 net/core/dev.c:8571
       dev_change_flags+0x11b/0x170 net/core/dev.c:8607
       do_setlink+0x19e2/0x3ae0 net/core/rtnetlink.c:2867
       __rtnl_newlink+0xd85/0x1860 net/core/rtnetlink.c:3655
       rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3702
       rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6424
       netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2549
       netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
       netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
       netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1914
       sock_sendmsg_nosec net/socket.c:725 [inline]
       sock_sendmsg+0xde/0x190 net/socket.c:748
       ____sys_sendmsg+0x739/0x920 net/socket.c:2494
       ___sys_sendmsg+0x110/0x1b0 net/socket.c:2548
       __sys_sendmsg+0xf7/0x1c0 net/socket.c:2577
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&priv->j1939_socks_lock){+.-.}-{2:2}:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       j1939_sk_errqueue+0xa3/0x1a0 net/can/j1939/socket.c:1081
       j1939_session_destroy+0x26c/0x4e0 net/can/j1939/transport.c:271
       __j1939_session_release net/can/j1939/transport.c:294 [inline]
       kref_put include/linux/kref.h:65 [inline]
       j1939_session_put net/can/j1939/transport.c:299 [inline]
       j1939_session_deactivate_locked net/can/j1939/transport.c:1086 [inline]
       j1939_session_deactivate_locked+0x293/0x340 net/can/j1939/transport.c:1074
       j1939_cancel_active_session+0x183/0x360 net/can/j1939/transport.c:2194
       j1939_netdev_notify+0x197/0x1d0 net/can/j1939/main.c:380
       notifier_call_chain+0xb6/0x3c0 kernel/notifier.c:93
       call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
       call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
       call_netdevice_notifiers net/core/dev.c:2014 [inline]
       __dev_notify_flags+0x1ea/0x2d0 net/core/dev.c:8571
       dev_change_flags+0x11b/0x170 net/core/dev.c:8607
       do_setlink+0x19e2/0x3ae0 net/core/rtnetlink.c:2867
       __rtnl_newlink+0xd85/0x1860 net/core/rtnetlink.c:3655
       rtnl_newlink+0x68/0xa0 net/core/rtnetlink.c:3702
       rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6424
       netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2549
       netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
       netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
       netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1914
       sock_sendmsg_nosec net/socket.c:725 [inline]
       sock_sendmsg+0xde/0x190 net/socket.c:748
       ____sys_sendmsg+0x739/0x920 net/socket.c:2494
       ___sys_sendmsg+0x110/0x1b0 net/socket.c:2548
       __sys_sendmsg+0xf7/0x1c0 net/socket.c:2577
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&priv->active_session_list_lock){+.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
       lock_acquire kernel/locking/lockdep.c:5761 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       j1939_session_list_lock net/can/j1939/transport.c:238 [inline]
       j1939_session_activate+0x47/0x4b0 net/can/j1939/transport.c:1564
       j1939_sk_queue_activate_next_locked net/can/j1939/socket.c:181 [inline]
       j1939_sk_queue_activate_next+0x2bf/0x4d0 net/can/j1939/socket.c:208
       j1939_session_deactivate_activate_next net/can/j1939/transport.c:1108 [inline]
       j1939_session_completed+0xb6/0x170 net/can/j1939/transport.c:1222
       j1939_xtp_rx_eoma_one net/can/j1939/transport.c:1395 [inline]
       j1939_xtp_rx_eoma+0x2a1/0x680 net/can/j1939/transport.c:1410
       j1939_tp_cmd_recv net/can/j1939/transport.c:2099 [inline]
       j1939_tp_recv+0x71e/0xf50 net/can/j1939/transport.c:2144
       j1939_can_recv net/can/j1939/main.c:112 [inline]
       j1939_can_recv+0x78e/0xa80 net/can/j1939/main.c:38
       deliver net/can/af_can.c:572 [inline]
       can_rcv_filter+0x5d4/0x8d0 net/can/af_can.c:606
       can_receive+0x31d/0x5c0 net/can/af_can.c:663
       can_rcv+0x1e1/0x280 net/can/af_can.c:687
       __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5452
       __netif_receive_skb+0x1f/0x1c0 net/core/dev.c:5566
       process_backlog+0x101/0x670 net/core/dev.c:5894
       __napi_poll+0xb7/0x6f0 net/core/dev.c:6460
       napi_poll net/core/dev.c:6527 [inline]
       net_rx_action+0x8a9/0xcb0 net/core/dev.c:6660
       __do_softirq+0x1d4/0x905 kernel/softirq.c:553
       run_ksoftirqd kernel/softirq.c:921 [inline]
       run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
       smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
       kthread+0x344/0x440 kernel/kthread.c:389
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

other info that might help us debug this:

Chain exists of:
  &priv->active_session_list_lock --> &priv->j1939_socks_lock --> &jsk->sk_session_queue_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&jsk->sk_session_queue_lock);
                               lock(&priv->j1939_socks_lock);
                               lock(&jsk->sk_session_queue_lock);
  lock(&priv->active_session_list_lock);

 *** DEADLOCK ***

3 locks held by ksoftirqd/0/16:
 #0: ffffffff8c9a16c0 (rcu_read_lock){....}-{1:2}, at: __skb_unlink include/linux/skbuff.h:2363 [inline]
 #0: ffffffff8c9a16c0 (rcu_read_lock){....}-{1:2}, at: __skb_dequeue include/linux/skbuff.h:2378 [inline]
 #0: ffffffff8c9a16c0 (rcu_read_lock){....}-{1:2}, at: process_backlog+0x23f/0x670 net/core/dev.c:5892
 #1: ffffffff8c9a16c0 (rcu_read_lock){....}-{1:2}, at: can_receive+0x1ef/0x5c0 net/can/af_can.c:653
 #2: ffff8880238935c8 (&jsk->sk_session_queue_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff8880238935c8 (&jsk->sk_session_queue_lock){+.-.}-{2:2}, at: j1939_sk_queue_activate_next+0x5f/0x4d0 net/can/j1939/socket.c:207

stack backtrace:
CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.4.0-syzkaller-12415-g8fc3b8f082cc #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x2df/0x3b0 kernel/locking/lockdep.c:2195
 check_prev_add kernel/locking/lockdep.c:3142 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 j1939_session_list_lock net/can/j1939/transport.c:238 [inline]
 j1939_session_activate+0x47/0x4b0 net/can/j1939/transport.c:1564
 j1939_sk_queue_activate_next_locked net/can/j1939/socket.c:181 [inline]
 j1939_sk_queue_activate_next+0x2bf/0x4d0 net/can/j1939/socket.c:208
 j1939_session_deactivate_activate_next net/can/j1939/transport.c:1108 [inline]
 j1939_session_completed+0xb6/0x170 net/can/j1939/transport.c:1222
 j1939_xtp_rx_eoma_one net/can/j1939/transport.c:1395 [inline]
 j1939_xtp_rx_eoma+0x2a1/0x680 net/can/j1939/transport.c:1410
 j1939_tp_cmd_recv net/can/j1939/transport.c:2099 [inline]
 j1939_tp_recv+0x71e/0xf50 net/can/j1939/transport.c:2144
 j1939_can_recv net/can/j1939/main.c:112 [inline]
 j1939_can_recv+0x78e/0xa80 net/can/j1939/main.c:38
 deliver net/can/af_can.c:572 [inline]
 can_rcv_filter+0x5d4/0x8d0 net/can/af_can.c:606
 can_receive+0x31d/0x5c0 net/can/af_can.c:663
 can_rcv+0x1e1/0x280 net/can/af_can.c:687
 __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5452
 __netif_receive_skb+0x1f/0x1c0 net/core/dev.c:5566
 process_backlog+0x101/0x670 net/core/dev.c:5894
 __napi_poll+0xb7/0x6f0 net/core/dev.c:6460
 napi_poll net/core/dev.c:6527 [inline]
 net_rx_action+0x8a9/0xcb0 net/core/dev.c:6660
 __do_softirq+0x1d4/0x905 kernel/softirq.c:553
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

