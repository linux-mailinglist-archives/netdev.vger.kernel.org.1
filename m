Return-Path: <netdev+bounces-24030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599F076E890
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732D21C214E1
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 12:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10641156C1;
	Thu,  3 Aug 2023 12:42:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209F11CAE
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 12:42:07 +0000 (UTC)
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AA73588
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 05:42:03 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6bc9c98b895so1545433a34.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 05:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691066522; x=1691671322;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QS/jf/60yteZJ4KS6ZjrdJhYl3jCQuMPys0NiOhJrhY=;
        b=R4xEFAw3IAbOynOYG5aOarGKOERgAFv+Ixj1HCuDj8JBJFx8dBOBmF+YU2u/IWeDvi
         NkM1rgTAYpdu0GW1NkqRjhWWVdPMIe0u1tiMHjCWhuy/LTUQ/uavifrZA/gqnPMzzbvP
         lCGrmSmTJNq4YmnH/y+3yM52bbBm9uYu4NiMn43uya6dkWAtlKzlgWrgapnOCw6ifkPk
         aSNPzLHvhzBp0Ab85uOAo9KFAAij3qbmzOQticNii5oBiRf7mcqJjgcHQWSdZUzP8kQL
         jdMI9BlyehYRGZEgxCYX3otYTFWkjV9jdjAfBJAQ5nfdCM+LFQX4fR23VQadsK7aFOAv
         Wifg==
X-Gm-Message-State: ABy/qLb+bJXsILz+pFe9JE3HcTlok1cjby3gRpb1Sb5H54OdzboLceSL
	NatplhjNizTFZx2f9FFSwWQa8z7z5Kak6YzZbqwgqaEv4hzN
X-Google-Smtp-Source: APBJJlENO0gmwwV/xjXG9L0hUNI4Nqx2bZZgKXtPLaN9g0bZrxgPVdPJqzdkkI55GpfUxvyNlxZ/eZAQ3E0uJDawHHOphpogDL4E
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:768e:b0:1bb:51ab:a7c5 with SMTP id
 dx14-20020a056870768e00b001bb51aba7c5mr19524053oab.9.1691066521933; Thu, 03
 Aug 2023 05:42:01 -0700 (PDT)
Date: Thu, 03 Aug 2023 05:42:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054df9f0602041ba8@google.com>
Subject: [syzbot] [wireguard?] KASAN: null-ptr-deref Write in wg_packet_send_staged_packets
From: syzbot <syzbot+1ef6522091226898343f@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    d7b3af5a77e8 Add linux-next specific files for 20230728
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10774fa1a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62dd327c382e3fe
dashboard link: https://syzkaller.appspot.com/bug?extid=1ef6522091226898343f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5efa5e68267f/disk-d7b3af5a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1f5d3e10263/vmlinux-d7b3af5a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57cab469d186/bzImage-d7b3af5a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ef6522091226898343f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: null-ptr-deref in __refcount_add include/linux/refcount.h:193 [inline]
BUG: KASAN: null-ptr-deref in __refcount_inc include/linux/refcount.h:250 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc include/linux/refcount.h:267 [inline]
BUG: KASAN: null-ptr-deref in kref_get include/linux/kref.h:45 [inline]
BUG: KASAN: null-ptr-deref in wg_peer_get drivers/net/wireguard/peer.h:76 [inline]
BUG: KASAN: null-ptr-deref in wg_packet_send_staged_packets+0xd10/0x1860 drivers/net/wireguard/send.c:385
Write of size 4 at addr 0000000000000710 by task syz-executor.2/22201

CPU: 1 PID: 22201 Comm: syz-executor.2 Not tainted 6.5.0-rc3-next-20230728-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:193 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 kref_get include/linux/kref.h:45 [inline]
 wg_peer_get drivers/net/wireguard/peer.h:76 [inline]
 wg_packet_send_staged_packets+0xd10/0x1860 drivers/net/wireguard/send.c:385
 wg_packet_send_keepalive+0x48/0x300 drivers/net/wireguard/send.c:239
 wg_expired_send_persistent_keepalive+0x5e/0x70 drivers/net/wireguard/timers.c:141
 call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb10 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x218/0x965 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:write_comp_data+0x3c/0x90 kernel/kcov.c:236
Code: 01 00 00 49 89 f8 65 48 8b 14 25 40 ba 03 00 a9 00 01 ff 00 74 0e 85 f6 74 59 8b 82 04 16 00 00 85 c0 74 4f 8b 82 e0 15 00 00 <83> f8 03 75 44 48 8b 82 e8 15 00 00 8b 92 e4 15 00 00 48 8b 38 48
RSP: 0018:ffffc900038bfa80 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 1ffff92000717f51 RCX: ffffffff882281ad
RDX: ffff888020b1bb80 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900038bfdb0
R13: ffffc900038bfbb0 R14: ffffc900038bfb90 R15: ffffc900038bfaa8
 copy_msghdr_from_user+0xcd/0x160 net/socket.c:2430
 recvmsg_copy_msghdr net/socket.c:2681 [inline]
 ___sys_recvmsg+0xdc/0x1a0 net/socket.c:2753
 do_recvmmsg+0x2af/0x740 net/socket.c:2851
 __sys_recvmmsg net/socket.c:2930 [inline]
 __do_sys_recvmmsg net/socket.c:2953 [inline]
 __se_sys_recvmmsg net/socket.c:2946 [inline]
 __x64_sys_recvmmsg+0x235/0x290 net/socket.c:2946
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcbf367cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcbf43d00c8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007fcbf379c050 RCX: 00007fcbf367cb29
RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007fcbf36c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fcbf379c050 R15: 00007ffdfffbc408
 </TASK>
==================================================================
----------------
Code disassembly (best guess):
   0:	01 00                	add    %eax,(%rax)
   2:	00 49 89             	add    %cl,-0x77(%rcx)
   5:	f8                   	clc
   6:	65 48 8b 14 25 40 ba 	mov    %gs:0x3ba40,%rdx
   d:	03 00
   f:	a9 00 01 ff 00       	test   $0xff0100,%eax
  14:	74 0e                	je     0x24
  16:	85 f6                	test   %esi,%esi
  18:	74 59                	je     0x73
  1a:	8b 82 04 16 00 00    	mov    0x1604(%rdx),%eax
  20:	85 c0                	test   %eax,%eax
  22:	74 4f                	je     0x73
  24:	8b 82 e0 15 00 00    	mov    0x15e0(%rdx),%eax
* 2a:	83 f8 03             	cmp    $0x3,%eax <-- trapping instruction
  2d:	75 44                	jne    0x73
  2f:	48 8b 82 e8 15 00 00 	mov    0x15e8(%rdx),%rax
  36:	8b 92 e4 15 00 00    	mov    0x15e4(%rdx),%edx
  3c:	48 8b 38             	mov    (%rax),%rdi
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

