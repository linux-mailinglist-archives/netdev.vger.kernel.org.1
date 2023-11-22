Return-Path: <netdev+bounces-50145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C71F67F4B4B
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFAF2813D1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4782C56B6A;
	Wed, 22 Nov 2023 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A60726A2
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:43:24 -0800 (PST)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso77529385ad.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700667804; x=1701272604;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFtPKhGMv7Zp9VrcApbcd7/gxkt/GNlZA4pzGmzIan8=;
        b=FRJRJJDhrVC0iJWkjFbAja6W1H33sJnhzqiBQJF0AVpqWoLytirzR6LkQrwdC67Qrv
         ULZQxEufbstA+UJioD4rWHWQRHggu7SH5ndokFFuEcKg8l84gTL35cipLB7mNpjcAEFV
         7BVB9hmH/ZYj8Y5QCX/70NFf34nQUOBDSOLCmR4+/Zy7FNEJHG3PveZUrjhBXJboCsjF
         jqlHI5tdArdQbLZBM5RvjVoMH1G2iVcAu5xSyj8D9h68POScPE907RemybPoRODg2iM3
         skxC+2KHcH1C++M1UYYwrIN3CPFdia7FkIqAUOr7xrKIXQ/hAdKfXI8E8Q/8VPcAkwbP
         3P/w==
X-Gm-Message-State: AOJu0YzjoZ1Ane1MbCwZ225fpUTlT5aIgtNF8XmnQq52xHw32wx3dcj5
	wCeBJIrhNhssSUc6jcX2x4jVKMUI8uYrz2KjbMO2uZ6yG5+I
X-Google-Smtp-Source: AGHT+IEEUVismXgXQPXvJLbbHx9YueCHRh2KYjXyV83BjC6BUyockrT+FCGd/iWadtfdDaLPRHxLNfKsAoUnBPg4posJAtd+c1Ll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:18f:b0:1cf:5085:cfa1 with SMTP id
 z15-20020a170903018f00b001cf5085cfa1mr727262plg.13.1700667803849; Wed, 22 Nov
 2023 07:43:23 -0800 (PST)
Date: Wed, 22 Nov 2023 07:43:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000545a26060abf943b@google.com>
Subject: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_incoming_options
From: syzbot <syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matthieu.baerts@tessares.net, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2d5304e6c64 Merge tag 'platform-drivers-x86-v6.7-2' of gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1536e3d4e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e32016b84cf917ca
dashboard link: https://syzkaller.appspot.com/bug?extid=b834a6b2decad004cfa1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11469724e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13934aaf680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/23ea827adf3b/disk-c2d5304e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f964ac588f5/vmlinux-c2d5304e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b061be889285/bzImage-c2d5304e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in mptcp_incoming_options+0xc93/0x3a80 net/mptcp/options.c:1197
 mptcp_incoming_options+0xc93/0x3a80 net/mptcp/options.c:1197
 tcp_data_queue+0xb4/0x7f20 net/ipv4/tcp_input.c:5141
 tcp_rcv_established+0x1132/0x2600 net/ipv4/tcp_input.c:6155
 tcp_v4_do_rcv+0x8a8/0xff0 net/ipv4/tcp_ipv4.c:1906
 tcp_v4_rcv+0x4ce0/0x51a0 net/ipv4/tcp_ipv4.c:2329
 ip_protocol_deliver_rcu+0x264/0x1300 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x2b8/0x440 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:461 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0x476/0x770 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core net/core/dev.c:5529 [inline]
 __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5643
 process_backlog+0x480/0x8b0 net/core/dev.c:5971
 __napi_poll+0xe3/0x970 net/core/dev.c:6533
 napi_poll net/core/dev.c:6602 [inline]
 net_rx_action+0x884/0x16d0 net/core/dev.c:6735
 __do_softirq+0x1b7/0x7c3 kernel/softirq.c:553
 do_softirq+0x9a/0xf0 kernel/softirq.c:454
 __local_bh_enable_ip+0x99/0xa0 kernel/softirq.c:381
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:817 [inline]
 __dev_queue_xmit+0x24ff/0x5130 net/core/dev.c:4373
 dev_queue_xmit include/linux/netdevice.h:3112 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0x14be/0x1b40 net/ipv4/ip_output.c:235
 __ip_finish_output+0x266/0x720
 ip_finish_output+0x4b/0x550 net/ipv4/ip_output.c:323
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0x15f/0x3e0 net/ipv4/ip_output.c:433
 dst_output include/net/dst.h:451 [inline]
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x1c02/0x1e00 net/ipv4/ip_output.c:535
 ip_queue_xmit+0x60/0x80 net/ipv4/ip_output.c:549
 __tcp_transmit_skb+0x3b26/0x4c40 net/ipv4/tcp_output.c:1462
 tcp_transmit_skb net/ipv4/tcp_output.c:1480 [inline]
 tcp_write_xmit+0x3e0f/0x8940 net/ipv4/tcp_output.c:2792
 __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:2977
 tcp_push+0x755/0x7a0 net/ipv4/tcp.c:736
 mptcp_push_release net/mptcp/protocol.c:1489 [inline]
 __mptcp_push_pending+0x8bc/0xde0 net/mptcp/protocol.c:1624
 mptcp_sendmsg+0x1e90/0x2300 net/mptcp/protocol.c:1890
 inet_sendmsg+0x105/0x190 net/ipv4/af_inet.c:847
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmmsg+0x3c4/0x950 net/socket.c:2724
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2750
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 mptcp_parse_option net/mptcp/options.c:110 [inline]
 mptcp_get_options+0x2d86/0x2e60 net/mptcp/options.c:396
 mptcp_incoming_options+0x124/0x3a80 net/mptcp/options.c:1139
 tcp_data_queue+0xb4/0x7f20 net/ipv4/tcp_input.c:5141
 tcp_rcv_established+0x1132/0x2600 net/ipv4/tcp_input.c:6155
 tcp_v4_do_rcv+0x8a8/0xff0 net/ipv4/tcp_ipv4.c:1906
 tcp_v4_rcv+0x4ce0/0x51a0 net/ipv4/tcp_ipv4.c:2329
 ip_protocol_deliver_rcu+0x264/0x1300 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x2b8/0x440 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:461 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0x476/0x770 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core net/core/dev.c:5529 [inline]
 __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5643
 process_backlog+0x480/0x8b0 net/core/dev.c:5971
 __napi_poll+0xe3/0x970 net/core/dev.c:6533
 napi_poll net/core/dev.c:6602 [inline]
 net_rx_action+0x884/0x16d0 net/core/dev.c:6735
 __do_softirq+0x1b7/0x7c3 kernel/softirq.c:553

Local variable mp_opt created at:
 mptcp_incoming_options+0x9b/0x3a80 net/mptcp/options.c:1116
 tcp_data_queue+0xb4/0x7f20 net/ipv4/tcp_input.c:5141

CPU: 0 PID: 5031 Comm: syz-executor376 Not tainted 6.7.0-rc2-syzkaller-00014-gc2d5304e6c64 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
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

