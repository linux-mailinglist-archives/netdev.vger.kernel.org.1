Return-Path: <netdev+bounces-252731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG+eFnlCc2mWtwAAu9opvQ
	(envelope-from <netdev+bounces-252731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:42:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AC0738D7
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3595C300373C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0722035DCF5;
	Fri, 23 Jan 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="eoV25QPf"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61536C0C5
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161330; cv=none; b=MImiEPCy/u17+hWgiK+a6Fop1GD3e0kYeeB2WUa4vcto8Mh6n9LzE9UR6RY552+7C8NHxIxT5K9oP0faP4LNOyTHKTv1ZKkKanQJI2zRDJnFMYzDWSOqaOtnCBJpj8HHGoslpTwKJ+4wHkh1yj1WjaevaH/JgpWsKInxu9eNb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161330; c=relaxed/simple;
	bh=jjb/kyyQdybrJ1NR5g2KlR1GNy1hDay55z1/Q3E4enY=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=RfFt/VmDUD0EHQyxvyzxIxiUpgNCkcmvUWsy56WRQMWMAwBttAVZKzZkm4jkxailLvsmLQc1rRpFTY5R6dR5pnrpFX8LYjbqRmHzQ2UQMzcl6bX4U5DE/lIM6mH6EUm7wSsHGjPx24vPsC6RvBmNEHqgi550kgLr56Ti+OKnOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=eoV25QPf; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jjb/kyyQdybrJ1NR5g2KlR1GNy1hDay55z1/Q3E4enY=;
	b=eoV25QPfLuXcB2SD4SQH8W2hqaPym6C5NSGmycVHV8l6+v1ljPn9jlmQxh1YM0XqMv2Ql3Xdy
	Wt9W/0iBSv4KI5QJOOCNeAVKzaNluB4IN1CLKm/NoBOB/Ahr61krHX6EX5Z+15Py8dOlrilHBtI
	wcRfNBGuLNbix6+YcuRTInY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dyCX856Lvz1T4G5;
	Fri, 23 Jan 2026 17:37:44 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 3314C40537;
	Fri, 23 Jan 2026 17:41:50 +0800 (CST)
Received: from [10.136.112.207] (10.136.112.207) by
 kwepemk500008.china.huawei.com (7.202.194.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Jan 2026 17:41:49 +0800
Message-ID: <fae17c21-4940-5605-85b2-1d5e17342358@huawei.com>
Date: Fri, 23 Jan 2026 17:41:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: <jv@jvosburgh.net>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <huyizhen2@huawei.com>
From: Chen Zhen <chenzhen126@huawei.com>
Subject: [BUG] KASAN: slab-use-after-free in bond_3ad_xor_xmit
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500008.china.huawei.com (7.202.194.93)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252731-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenzhen126@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: E3AC0738D7
X-Rspamd-Action: no action

Hi all,

We found a UAF in bond_3ad_xor_xmit() with syzkaller test on stable 6.6:
==================================================================
BUG: KASAN: slab-use-after-free in bond_3ad_xor_xmit+0x104/0x2f0 drivers/net/bonding/bond_main.c:5340
Read of size 8 at addr ffff0000c267e000 by task syz-executor/1084

CPU: 3 PID: 1084 Comm: syz-executor Not tainted 6.6.0-72.qmp_cmd_name: qmp_capabilities, arguments: {}
Call trace:
 dump_backtrace+0x12c/0x220 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x34/0x50 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x80/0x118 lib/dump_stack.c:106
 print_address_description.constprop.0+0x84/0x3b8 mm/kasan/report.c:364
 print_report+0xb0/0x280 mm/kasan/report.c:468
 kasan_report+0x7c/0xc8 mm/kasan/report.c:581
 check_region_inline mm/kasan/generic.c:181 [inline]
 __asan_load8+0x9c/0xc0 mm/kasan/generic.c:260
 bond_3ad_xor_xmit+0x104/0x2f0 drivers/net/bonding/bond_main.c:5340
 __bond_start_xmit+0x1c0/0x430 drivers/net/bonding/bond_main.c:5629
 bond_start_xmit+0x8c/0x178 drivers/net/bonding/bond_main.c:5657
 __netdev_start_xmit include/linux/netdevice.h:4995 [inline]
 netdev_start_xmit include/linux/netdevice.h:5009 [inline]
 xmit_one.constprop.0+0xbc/0x250 net/core/dev.c:3623
 dev_hard_start_xmit+0x9c/0x110 net/core/dev.c:3639
 __dev_queue_xmit+0x183c/0x2248 net/core/dev.c:4435
 dev_queue_xmit include/linux/netdevice.h:3155 [inline]
 tipc_l2_send_msg+0x12c/0x1c0 net/tipc/bearer.c:516
 tipc_bearer_xmit_skb+0x15c/0x218 net/tipc/bearer.c:575
 tipc_disc_timeout+0x41c/0x528 net/tipc/discover.c:338
 call_timer_fn+0x50/0x260 kernel/time/timer.c:1701
 expire_timers+0x23c/0x408 kernel/time/timer.c:1752
 __run_timers kernel/time/timer.c:2023 [inline]
 run_timer_softirq+0x2ac/0x700 kernel/time/timer.c:2036
 handle_softirqs+0x198/0x4e8 kernel/softirq.c:578
 __do_softirq+0x1c/0x28 kernel/softirq.c:612
 ____do_softirq+0x1c/0x30 arch/arm64/kernel/irq.c:81
 ...

Allocated by task 3544:
 kasan_save_stack+0x2c/0x58 mm/kasan/common.c:45
 kasan_set_track+0x2c/0x40 mm/kasan/common.c:52
 kasan_save_alloc_info+0x24/0x38 mm/kasan/generic.c:511
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xb8/0xc0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:201 [inline]
 kmalloc_trace+0x60/0x100 mm/slab_common.c:1055
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 bond_alloc_slave drivers/net/bonding/bond_main.c:1800 [inline]
 bond_enslave+0x2e8/0x2c60 drivers/net/bonding/bond_main.c:2060
 do_set_master+0x134/0x170 net/core/rtnetlink.c:2730
 rtnl_newlink_create+0x4f4/0x660 net/core/rtnetlink.c:3558
 __rtnl_newlink+0x994/0x9e8 net/core/rtnetlink.c:3761
 rtnl_newlink+0x6c/0xa8 net/core/rtnetlink.c:3774
 rtnetlink_rcv_msg+0x4b4/0x658 net/core/rtnetlink.c:6531
 netlink_rcv_skb+0x100/0x2d0 net/netlink/af_netlink.c:2545
 rtnetlink_rcv+0x30/0x48 net/core/rtnetlink.c:6549
 netlink_unicast_kernel+0x10c/0x270 net/netlink/af_netlink.c:1320
 netlink_unicast+0x378/0x490 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x468/0x8d0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:735 [inline]
 __sock_sendmsg net/socket.c:750 [inline]
 __sock_sendmsg+0x90/0x118 net/socket.c:745
 ____sys_sendmsg+0x550/0x670 net/socket.c:2611
 ___sys_sendmsg+0x12c/0x1c8 net/socket.c:2665
 __sys_sendmsg+0xfc/0x1a8 net/socket.c:2694
 __do_sys_sendmsg net/socket.c:2703 [inline]
 __se_sys_sendmsg net/socket.c:2701 [inline]
 __arm64_sys_sendmsg+0x58/0x78 net/socket.c:2701
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x80/0x208 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0x19c/0x1e8 arch/arm64/kernel/syscall.c:134
 do_el0_svc+0x3c/0x58 arch/arm64/kernel/syscall.c:176
 el0_svc+0x44/0x200 arch/arm64/kernel/entry-common.c:829
 el0t_64_sync_handler+0x100/0x130 arch/arm64/kernel/entry-common.c:869
 el0t_64_sync+0x3c8/0x3d0 arch/arm64/kernel/entry.S:757

Freed by task 3544:
 kasan_save_stack+0x2c/0x58 mm/kasan/common.c:45
 kasan_set_track+0x2c/0x40 mm/kasan/common.c:52
 kasan_save_free_info+0x38/0x60 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 __kasan_slab_free+0xe8/0x180 mm/kasan/common.c:244
 kasan_slab_free include/linux/kasan.h:167 [inline]
 slab_free_hook mm/slub.c:1835 [inline]
 slab_free_freelist_hook mm/slub.c:1861 [inline]
 slab_free mm/slub.c:3838 [inline]
 __kmem_cache_free+0x14c/0x390 mm/slub.c:3851
 kfree+0x74/0x130 mm/slab_common.c:1008
 slave_kobj_release+0x68/0xb8 drivers/net/bonding/bond_main.c:1773
 kobject_cleanup+0xac/0x278 lib/kobject.c:689
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x108/0x190 lib/kobject.c:737
 bond_enslave+0x1214/0x2c60 drivers/net/bonding/bond_main.c:2440
 do_set_master+0x134/0x170 net/core/rtnetlink.c:2730
 rtnl_newlink_create+0x4f4/0x660 net/core/rtnetlink.c:3558
 __rtnl_newlink+0x994/0x9e8 net/core/rtnetlink.c:3761
 rtnl_newlink+0x6c/0xa8 net/core/rtnetlink.c:3774
 rtnetlink_rcv_msg+0x4b4/0x658 net/core/rtnetlink.c:6531
 netlink_rcv_skb+0x100/0x2d0 net/netlink/af_netlink.c:2545
 rtnetlink_rcv+0x30/0x48 net/core/rtnetlink.c:6549
 netlink_unicast_kernel+0x10c/0x270 net/netlink/af_netlink.c:1320
 netlink_unicast+0x378/0x490 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x468/0x8d0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:735 [inline]
 __sock_sendmsg net/socket.c:750 [inline]
 __sock_sendmsg+0x90/0x118 net/socket.c:745
 ____sys_sendmsg+0x550/0x670 net/socket.c:2611
 ___sys_sendmsg+0x12c/0x1c8 net/socket.c:2665
 __sys_sendmsg+0xfc/0x1a8 net/socket.c:2694
 __do_sys_sendmsg net/socket.c:2703 [inline]
 __se_sys_sendmsg net/socket.c:2701 [inline]
 __arm64_sys_sendmsg+0x58/0x78 net/socket.c:2701
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x80/0x208 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0x19c/0x1e8 arch/arm64/kernel/syscall.c:134
 do_el0_svc+0x3c/0x58 arch/arm64/kernel/syscall.c:176
 el0_svc+0x44/0x200 arch/arm64/kernel/entry-common.c:829
 el0t_64_sync_handler+0x100/0x130 arch/arm64/kernel/entry-common.c:869
 el0t_64_sync+0x3c8/0x3d0 arch/arm64/kernel/entry.S:757
==================================================================
It seems that the bug occurs when:
1）A XDP related failure is triggered in bond_enslave() after
bond_update_slave_arr()
2）The code jumps to err_sysfs_del label and the slave is freed
3）Concurrently, network traffic triggers bond_3ad_xor_xmit() which
accesses the freed slave.

Any confirmation of the bug or guidance on its fix will be greatly
appreciated, and we are very willing to assist with subsequent testing
and validation.

Best Regard,
Chen Zhen






