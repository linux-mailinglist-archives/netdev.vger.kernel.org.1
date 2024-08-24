Return-Path: <netdev+bounces-121562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8112395DA84
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 04:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD391F22714
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 02:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FF2182C5;
	Sat, 24 Aug 2024 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="RmH2U9WF";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Bv0j1h/r"
X-Original-To: netdev@vger.kernel.org
Received: from mx6.ucr.edu (mx6.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7118028
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 02:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465517; cv=none; b=XQp5UlZ34Pjggcwh1adLU+rDxIxpiMU6McTG9PvpA0O+OYm5kkYIHBPNIMlzaR8fV4av/7AQyXFnhKdibwP5pOkMWSzJJpwnhWVj6eKEg4t8VvTOyNKeVK3Vg23q9s4FJ39OlImn69gpIBz9HFySP9JLzXKprhcOXQniDethn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465517; c=relaxed/simple;
	bh=934wDLlbm1PZ0ERQdFU8JnT0iLloEeAIYa1GS0wifCM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gkSHpJqitHBsl5MUQBXbq8OJf6cEwQQZ+ge5o6hqB8HZ+NDl599yRJdR8Nh1L8TAQfyR1cF+GgY0LUyZhk8F5W6CfGo6buhGcp/kRByNyD/TOShEwUrjZkgP+tXfWaY/dZNX/ZTeSh8OG1/R0uW1oxPgsrVsAIVrf+F8cAeCCFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=RmH2U9WF; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Bv0j1h/r; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724465516; x=1756001516;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=934wDLlbm1PZ0ERQdFU8JnT0iLloEeAIYa1GS0wifCM=;
  b=RmH2U9WFjk9KUdygar0m5Wh+2v3UfRfnmEVX/YYMlJhKld+0lOjZishS
   CDLZsvGoPp63b+7MGn7RN6zU4DfeLH4V63SHnDq1ltcwfDzoWmLooWR7H
   2uaZlx5IDMfKOpaiONU8D8QrYgk9yW9NI6wSnRjlAinAOLvNmuFT/QHE7
   Er1NNc5C9kXMgqkwjbQDuJzJed8fA/3btYQS21w9zIIJUYJW6pMJ5T4fW
   QoZWU72Aj9I0Qm8vghhSddSnbVjIV5ftFZqsIpzOAzhvJGhFjlLgAxwJ9
   GDKztc5Kazfgcxkc74LRzEjj7KI3oIRT0B6OuNSUZvZQmldmJUEDuB+PY
   Q==;
X-CSE-ConnectionGUID: OUq1jZn8SuCGqEEDb+SZQw==
X-CSE-MsgGUID: wJwS26XdQnmlaUZjZS02XQ==
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Aug 2024 19:10:47 -0700
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d3c4d321f4so2625794a91.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 19:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724465446; x=1725070246; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hDIrJj0PVJOEFwwnt6IKXzIuX6NBvsz+s/TaAofkIyc=;
        b=Bv0j1h/rue0QUczeVN0g63Sgxqpm+bzQdJtXodNyankkIiDjXFBf5/wC23cqnzfy7J
         qyBo5HJ52dW6Yho5925m0IfIkEX4jy3sWOW2wxxkctyvJkfk4fRvZAO6tJWO8QjgiQs0
         +WTOE0q4KSutBhixsW3eP/ryweAhMDy6zdpo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724465446; x=1725070246;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDIrJj0PVJOEFwwnt6IKXzIuX6NBvsz+s/TaAofkIyc=;
        b=o4Aqcd8gT5iYBS0szz04sAZrMdzs1ir3DwtT1uFxjX1xLhzJrft087vBZBijszYv0W
         EXsVRzZITdXRynhJlWahzZ56F69iRbYWF4p1fXdHdJcUa+EJPWQS9sfFrnrmSnT7H79S
         GTPxnTSTx1iXY0zNDfNTH2B0J+nO9f5s7jZ7Wdz4l1Wk1cN5bipgcxpnLDvZfBtdDWgQ
         lOHDo6iHTSksDr3wdrd3dcBTcq0HsfX8x98AFKzaLwk6NXlxzkj+WupqZJl7vpH60fQM
         9nddJ2NAa+nx3IkEZUL5Ceq9Fznri3ksTAB+LYzByTCBhXDTn0nWC0EeWXsdsR7lskcl
         YM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWj9qnfvQGA49zQ7v26Sdlo0AsFmSL2kCCCgWnXTVGc1oBSAMg9tweK7F0txuuI4gS6AlE9LMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHGOFkVTRzdfkwYaYIu26ZbhSQxqsvW7LarLg9AtQNvBnu1i6
	g85/YwCTxTrG5JAtBeroR2yZpllwlLYQo8k8jRbruWfPuGFwMw1Rva9QFoChtbYgUfSwWKBtxaN
	z2jtpcJuGaghxix1RHbpUqgspDhe15giIvT0mqwBLbWkqBlIALqwXD6RlvINCUIx5oYaMwDAuek
	0v8zT5qkeZzaNf7RtqPIGCThI9lHBupg==
X-Received: by 2002:a17:90a:98b:b0:2c9:888a:7a7b with SMTP id 98e67ed59e1d1-2d646c197eamr4385868a91.25.1724465446047;
        Fri, 23 Aug 2024 19:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsIgUPSD5q07XNG9vDNuDdezYBTm9lI7+ddhPDbH3O0UBrChnntO5SEpI/JxOX0KFRc2CcrsxDrxALy8nSTM0=
X-Received: by 2002:a17:90a:98b:b0:2c9:888a:7a7b with SMTP id
 98e67ed59e1d1-2d646c197eamr4385859a91.25.1724465445682; Fri, 23 Aug 2024
 19:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Fri, 23 Aug 2024 19:10:34 -0700
Message-ID: <CALAgD-58VEomA47Srga5H-p6cZa0zPj+y3E1se0rHb3gj4UvyA@mail.gmail.com>
Subject: BUG: general protection fault in batadv_bla_del_backbone_claims
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We found the following issue using syzkaller on Linux v6.10.

It seems to be a null pointer dereference bug
Need to check the `fi==NULL` before 'fi->fib_dead' on line 1587 of
net/ipv4/fib_trie.c

The bug report is:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000008: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 0 PID: 9032 Comm: syz.0.15 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:fib_table_lookup+0x709/0x1790 net/ipv4/fib_trie.c:1587
Code: 38 f3 75 4c e8 38 b9 15 f8 49 be 00 00 00 00 00 fc ff df eb 05
e8 27 b9 15 f8 48 8b 44 24 20 48 8d 58 44 48 89 d8 48 c1 e8 03 <42> 8a
04 30 84 c0 0f 85 76 03 00 00 0f b6 1b 31 ff 89 de e8 df bb
RSP: 0018:ffffc90004acf020 EFLAGS: 00010203
RAX: 0000000000000008 RBX: 0000000000000044 RCX: ffff88801db88000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004acf170 R08: ffffffff897b97ee R09: 1ffffffff221f8b0
R10: dffffc0000000000 R11: fffffbfff221f8b1 R12: 1ffff11003b1bbe6
R13: ffff88801d8ddf20 R14: dffffc0000000000 R15: ffff88801d8ddf30
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0cfb3b48d0 CR3: 000000001811e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __inet_dev_addr_type+0x2e9/0x510 net/ipv4/fib_frontend.c:225
 inet_addr_type_dev_table net/ipv4/fib_frontend.c:267 [inline]
 fib_del_ifaddr+0x1114/0x14b0 net/ipv4/fib_frontend.c:1320
 fib_inetaddr_event+0xcc/0x1f0 net/ipv4/fib_frontend.c:1448
 notifier_call_chain kernel/notifier.c:93 [inline]
 blocking_notifier_call_chain+0x126/0x1d0 kernel/notifier.c:388
 __inet_del_ifa+0x87a/0x1020 net/ipv4/devinet.c:437
 inet_del_ifa net/ipv4/devinet.c:474 [inline]
 inetdev_destroy net/ipv4/devinet.c:327 [inline]
 inetdev_event+0x664/0x1590 net/ipv4/devinet.c:1633
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0xe0/0x180 kernel/notifier.c:461
 call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
 call_netdevice_notifiers net/core/dev.c:2044 [inline]
 unregister_netdevice_many_notify+0xd65/0x16d0 net/core/dev.c:11219
 unregister_netdevice_many net/core/dev.c:11277 [inline]
 unregister_netdevice_queue+0x2ff/0x370 net/core/dev.c:11156
 unregister_netdevice include/linux/netdevice.h:3119 [inline]
 __tun_detach+0x6ad/0x15e0 drivers/net/tun.c:685
 tun_detach drivers/net/tun.c:701 [inline]
 tun_chr_close+0x104/0x1b0 drivers/net/tun.c:3500
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x239/0x2f0 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa13/0x2560 kernel/exit.c:876
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1025
 get_signal+0x1697/0x1730 kernel/signal.c:2909
 arch_do_signal_or_restart+0x92/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x95/0x280 kernel/entry/common.c:218
 do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f38fcb809b9
Code: Unable to access opcode bytes at 0x7f38fcb8098f.
RSP: 002b:00007ffca268d598 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000002 RBX: 00007f38fcd45f80 RCX: 00007f38fcb809b9
RDX: 0000000020000080 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f38fcbf4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f38fcd45f80 R14: 00007f38fcd45f80 R15: 0000000000000d01
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fib_table_lookup+0x709/0x1790 net/ipv4/fib_trie.c:1587
Code: 38 f3 75 4c e8 38 b9 15 f8 49 be 00 00 00 00 00 fc ff df eb 05
e8 27 b9 15 f8 48 8b 44 24 20 48 8d 58 44 48 89 d8 48 c1 e8 03 <42> 8a
04 30 84 c0 0f 85 76 03 00 00 0f b6 1b 31 ff 89 de e8 df bb
RSP: 0018:ffffc90004acf020 EFLAGS: 00010203
RAX: 0000000000000008 RBX: 0000000000000044 RCX: ffff88801db88000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004acf170 R08: ffffffff897b97ee R09: 1ffffffff221f8b0
R10: dffffc0000000000 R11: fffffbfff221f8b1 R12: 1ffff11003b1bbe6
R13: ffff88801d8ddf20 R14: dffffc0000000000 R15: ffff88801d8ddf30
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2a89116b60 CR3: 00000000202c2000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


-- 
Yours sincerely,
Xingyu

