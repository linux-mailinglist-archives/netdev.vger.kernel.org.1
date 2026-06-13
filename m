Return-Path: <netdev+bounces-298902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yrsgKATbLGpUXAQAu9opvQ
	(envelope-from <netdev+bounces-298902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 06:22:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5B67DA9B
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 06:22:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298902-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298902-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16E32308A4D7
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 04:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620C3803D8;
	Sat, 13 Jun 2026 04:22:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D22FFF8D
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 04:22:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781324545; cv=none; b=WyIbseQlyYiweKIMah6UsalAmh+Lha1BQuJQ7dT05oBzAPjqeCz1ysoEZbsQhvT2LZNABvY0U0B3yCuVJ8eowouYctaqhsxrSa8WARGf71+lFYCkW0HJ2YHv8ofbg5zxDo5pTrtC2GDzExCkyhfM+HwCSD5NJaKwHqbG4zB2TwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781324545; c=relaxed/simple;
	bh=X6mBMrisD7bBTU2sJNwZfIrBuSY/5WsgjruqjUY0rTI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=opg2ikXd57IcI0/03Eauq/I8GQg3k5iq2lURJDnqruhHRrx7S3axoDfg4pDLsK9zLPUsPGifLLY8Jh5JbdPR0Kban/+fPs1VDI0496SKvU7oJRrtjGVzhjVy1wy/LbOrZZBCWc1IEaiM2kj5cVC/aD7b3TAfuSWH4PWQ8QRHgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-486cc29e03bso2674195b6e.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 21:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781324542; x=1781929342;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=647Piy0TDZ1tF6VoEaf+pcvbYAYZoWEajtL8BnsnRjQ=;
        b=CY0LHNMSdmA4EByr1u3Cr5y+7SbXMhHmXKOBPf6bzZ8L/k7hVEf4xoNL5grrdlIdoe
         NUKCtCV3DBuVNyqyRv2U76i+nnSzSrYgnz5VPqXb38V7nLJRfrgzCAHVQODRjVYLZglK
         sbSrP12Ez0jAS3FXr+UIlIZ+Bfmz5uQos0UQ1S9v/RT88as0dmgjbqz/107ADbKcmXiE
         6q8B0nIL+TP0EYAdLwTDBWjZ6kaaVaAYXfC9qePHGbWlMgEL8H3WkR2Xa0Ipg19Eboo1
         zGwDauLbcV5c4C/O9zpDb4OkHeejA1vqWKwETg9N6QI8KOvwOYJ77a8Ys+qC2vB3QhCd
         fwbg==
X-Forwarded-Encrypted: i=1; AFNElJ94LAgMLUrrGyA4k0y8eeBDvc9/9Ceo9NKxjJl5n62utmFrdgts1NSxAGRAKnJdh0xNMHKQtOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJ2ekXeVxtw5/G/m/hv6OsCixTuHfbyXUCeHA2Ycz27LnC+Dt
	6SzT2zK2dm+YBDAZMgwgYCybH/yNjwK0jllXaEF5ngvnhxNQMmcrnR3ICmzFVQMltVrV6Mvw2h3
	K8RCqn3279lLXwaWKPLH09xDsAN4oPjEzvv6plRwno9kWHHlzTgfOflUc+mQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2511:b0:479:eb19:6e69 with SMTP id
 5614622812f47-487419614eamr1787426b6e.6.1781324542218; Fri, 12 Jun 2026
 21:22:22 -0700 (PDT)
Date: Fri, 12 Jun 2026 21:22:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2cdafe.428ffe26.258b27.0161.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in udp_sendmsg (2)
From: syzbot <syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298902-lists,netdev=lfdr.de,607cdcf978b3e79da878];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,m:willemdebruijn.kernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,googlegroups.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10B5B67DA9B

Hello,

syzbot found the following issue on:

HEAD commit:    8b2feced65cd Merge branch 'net-dsa-microchip-remove-one-in..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=107db0c8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2b487b72ffad035
dashboard link: https://syzkaller.appspot.com/bug?extid=607cdcf978b3e79da878
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25f12e68ab8d/disk-8b2feced.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d8c43b4ea8e7/vmlinux-8b2feced.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3d8f43606e0/bzImage-8b2feced.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+607cdcf978b3e79da878@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.4.8614/8291 is trying to acquire lock:
ffffffff8ea85520 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8ea85520 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4520 [inline]
ffffffff8ea85520 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4875 [inline]
ffffffff8ea85520 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_node_noprof+0x4a/0x690 mm/slub.c:4950

but task is already holding lock:
ffff88807c806860 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
ffff88807c806860 (sk_lock-AF_INET){+.+.}-{0:0}, at: udp_sendmsg+0x1747/0x21a0 net/ipv4/udp.c:1447

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x41/0x100 net/core/sock.c:3783
       lock_sock include/net/sock.h:1713 [inline]
       tls_sw_sendmsg+0x15d/0x2430 net/tls/tls_sw.c:1291
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       sock_write_iter+0x406/0x4f0 net/socket.c:1254
       do_iter_readv_writev+0x619/0x8c0 fs/read_write.c:-1
       vfs_writev+0x33c/0x990 fs/read_write.c:1059
       do_writev+0x154/0x2e0 fs/read_write.c:1105
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (&ctx->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
       tls_sw_sendmsg+0x130/0x2430 net/tls/tls_sw.c:1288
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       sock_sendmsg+0x267/0x450 net/socket.c:825
       __sock_xmit+0x251/0x510 drivers/block/nbd.c:576
       sock_xmit drivers/block/nbd.c:605 [inline]
       send_disconnects drivers/block/nbd.c:1406 [inline]
       nbd_disconnect+0x3b7/0x560 drivers/block/nbd.c:1421
       nbd_disconnect_and_put+0x37/0x2c0 drivers/block/nbd.c:2257
       nbd_genl_disconnect+0x4a9/0x590 drivers/block/nbd.c:2303
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
       __sys_sendmsg net/socket.c:2784 [inline]
       __do_sys_sendmsg net/socket.c:2789 [inline]
       __se_sys_sendmsg net/socket.c:2787 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x37b/0x1100 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0xa70/0x1910 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xdcc/0x1600 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2386
       blk_mq_dispatch_list+0xd16/0xe10 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x48d/0x570 block/blk-mq.c:2997
       __blk_flush_plug+0x3ed/0x4d0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x28d/0x580 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:753
       submit_bh fs/buffer.c:2742 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2344
       filemap_read_folio+0x137/0x3b0 mm/filemap.c:2502
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4107
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:724
       adfspart_check_ICS+0xb1/0x960 block/partitions/acorn.c:356
       check_partition block/partitions/core.c:143 [inline]
       blk_add_partitions block/partitions/core.c:591 [inline]
       bdev_disk_changed+0x817/0x1770 block/partitions/core.c:695
       blkdev_get_whole+0x380/0x510 block/bdev.c:756
       bdev_open+0x31e/0xd30 block/bdev.c:965
       blkdev_open+0x470/0x610 block/fops.c:697
       do_dentry_open+0x785/0x14e0 fs/open.c:947
       vfs_open+0x3b/0x340 fs/open.c:1079
       do_open fs/namei.c:4699 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4858
       do_file_open+0x23e/0x4a0 fs/namei.c:4887
       do_sys_openat2+0x113/0x200 fs/open.c:1364
       do_sys_open fs/open.c:1370 [inline]
       __do_sys_openat fs/open.c:1386 [inline]
       __se_sys_openat fs/open.c:1381 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1381
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
       nbd_queue_rq+0xc6/0x1100 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0xa70/0x1910 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xdcc/0x1600 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2386
       blk_mq_dispatch_list+0xd16/0xe10 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x48d/0x570 block/blk-mq.c:2997
       __blk_flush_plug+0x3ed/0x4d0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x28d/0x580 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:753
       submit_bh fs/buffer.c:2742 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2344
       filemap_read_folio+0x137/0x3b0 mm/filemap.c:2502
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4107
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:724
       adfspart_check_ICS+0xb1/0x960 block/partitions/acorn.c:356
       check_partition block/partitions/core.c:143 [inline]
       blk_add_partitions block/partitions/core.c:591 [inline]
       bdev_disk_changed+0x817/0x1770 block/partitions/core.c:695
       blkdev_get_whole+0x380/0x510 block/bdev.c:756
       bdev_open+0x31e/0xd30 block/bdev.c:965
       blkdev_open+0x470/0x610 block/fops.c:697
       do_dentry_open+0x785/0x14e0 fs/open.c:947
       vfs_open+0x3b/0x340 fs/open.c:1079
       do_open fs/namei.c:4699 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4858
       do_file_open+0x23e/0x4a0 fs/namei.c:4887
       do_sys_openat2+0x113/0x200 fs/open.c:1364
       do_sys_open fs/open.c:1370 [inline]
       __do_sys_openat fs/open.c:1386 [inline]
       __se_sys_openat fs/open.c:1381 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1381
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xca/0x300 kernel/rcu/srcutree.c:1481
       elevator_switch+0x1e8/0x7a0 block/elevator.c:576
       elevator_change+0x2cc/0x450 block/elevator.c:681
       elevator_set_default+0x36c/0x430 block/elevator.c:754
       blk_register_queue+0x3e9/0x4e0 block/blk-sysfs.c:987
       __add_disk+0x677/0xd50 block/genhd.c:528
       add_disk_fwnode+0xfb/0x480 block/genhd.c:597
       add_disk include/linux/blkdev.h:794 [inline]
       nbd_dev_add+0x72c/0xb50 drivers/block/nbd.c:1984
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2692
       do_one_initcall+0x250/0x870 init/main.c:1392
       do_initcall_level+0x104/0x190 init/main.c:1454
       do_initcalls+0x59/0xa0 init/main.c:1470
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1703
       kernel_init+0x1d/0x1d0 init/main.c:1593
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
       elevator_change+0x1b3/0x450 block/elevator.c:679
       elevator_set_none+0xb5/0x140 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5131 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5176 [inline]
       blk_mq_update_nr_hw_queues+0x5e7/0x1a60 block/blk-mq.c:5241
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1489
       nbd_genl_connect+0x165b/0x1cf0 drivers/block/nbd.c:2239
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2551
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1895
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
       __sys_sendmsg net/socket.c:2784 [inline]
       __do_sys_sendmsg net/socket.c:2789 [inline]
       __se_sys_sendmsg net/socket.c:2787 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#53){++++}-{0:0}:
       blk_alloc_queue+0x546/0x680 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4450 [inline]
       __blk_mq_alloc_disk+0x197/0x390 block/blk-mq.c:4497
       nbd_dev_add+0x499/0xb50 drivers/block/nbd.c:1954
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2692
       do_one_initcall+0x250/0x870 init/main.c:1392
       do_initcall_level+0x104/0x190 init/main.c:1454
       do_initcalls+0x59/0xa0 init/main.c:1470
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1703
       kernel_init+0x1d/0x1d0 init/main.c:1593
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4325 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4339
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4520 [inline]
       slab_alloc_node mm/slub.c:4875 [inline]
       kmem_cache_alloc_node_noprof+0x4a/0x690 mm/slub.c:4950
       __alloc_skb+0x1d0/0x7d0 net/core/skbuff.c:702
       alloc_skb include/linux/skbuff.h:1383 [inline]
       alloc_skb_with_frags+0xc8/0x760 net/core/skbuff.c:6734
       sock_alloc_send_pskb+0x878/0x990 net/core/sock.c:2998
       sock_alloc_send_skb include/net/sock.h:1897 [inline]
       __ip_append_data+0x2a98/0x3e40 net/ipv4/ip_output.c:1127
       ip_append_data+0x10d/0x190 net/ipv4/ip_output.c:1380
       udp_sendmsg+0x3e4/0x21a0 net/ipv4/udp.c:1469
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       sock_sendmsg+0x379/0x450 net/socket.c:825
       splice_to_socket+0xae2/0x11f0 fs/splice.c:884
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0xee3/0x1910 fs/splice.c:1349
       __do_splice fs/splice.c:1431 [inline]
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice+0x353/0x490 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &ctx->tx_lock --> sk_lock-AF_INET

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET);
                               lock(&ctx->tx_lock);
                               lock(sk_lock-AF_INET);
  lock(fs_reclaim);

 *** DEADLOCK ***

2 locks held by syz.4.8614/8291:
 #0: ffff888056734060 (&pipe->mutex){+.+.}-{4:4}, at: splice_to_socket+0x15f/0x11f0 fs/splice.c:805
 #1: ffff88807c806860 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #1: ffff88807c806860 (sk_lock-AF_INET){+.+.}-{0:0}, at: udp_sendmsg+0x1747/0x21a0 net/ipv4/udp.c:1447

stack backtrace:
CPU: 0 UID: 0 PID: 8291 Comm: syz.4.8614 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __fs_reclaim_acquire mm/page_alloc.c:4325 [inline]
 fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4339
 might_alloc include/linux/sched/mm.h:317 [inline]
 slab_pre_alloc_hook mm/slub.c:4520 [inline]
 slab_alloc_node mm/slub.c:4875 [inline]
 kmem_cache_alloc_node_noprof+0x4a/0x690 mm/slub.c:4950
 __alloc_skb+0x1d0/0x7d0 net/core/skbuff.c:702
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xc8/0x760 net/core/skbuff.c:6734
 sock_alloc_send_pskb+0x878/0x990 net/core/sock.c:2998
 sock_alloc_send_skb include/net/sock.h:1897 [inline]
 __ip_append_data+0x2a98/0x3e40 net/ipv4/ip_output.c:1127
 ip_append_data+0x10d/0x190 net/ipv4/ip_output.c:1380
 udp_sendmsg+0x3e4/0x21a0 net/ipv4/udp.c:1469
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 sock_sendmsg+0x379/0x450 net/socket.c:825
 splice_to_socket+0xae2/0x11f0 fs/splice.c:884
 do_splice_from fs/splice.c:936 [inline]
 do_splice+0xee3/0x1910 fs/splice.c:1349
 __do_splice fs/splice.c:1431 [inline]
 __do_sys_splice fs/splice.c:1634 [inline]
 __se_sys_splice+0x353/0x490 fs/splice.c:1616
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5eb159cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5eb24f7028 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007f5eb1815fa0 RCX: 00007f5eb159cdd9
RDX: 000000000000000a RSI: 0000000000000000 RDI: 0000000000000008
RBP: 00007f5eb1632d69 R08: 002000000002ffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5eb1816038 R14: 00007f5eb1815fa0 R15: 00007ffe44aee038
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

