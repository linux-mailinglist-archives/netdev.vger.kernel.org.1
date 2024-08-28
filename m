Return-Path: <netdev+bounces-122986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEC296363E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD53528438A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50561AE863;
	Wed, 28 Aug 2024 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="fijyb0Ap";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="s0baGfn7"
X-Original-To: netdev@vger.kernel.org
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7C1AE850
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888174; cv=none; b=Yvc+sr5KD17UcJgDO8LMwPR68HCiUi/H/o32ROfG6Y3Tc76gNBxHAKNDje9YETyRnvj80LrJ+O8GNDAcn9PKitY+kKXkuCkE/+pwB3YNRRngPmGjSE4eNV2KEiB6E6BYnwK2YTneDCIZgDaDv++mLRIVG/9V5to2vrFgCZ2Ozio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888174; c=relaxed/simple;
	bh=UAv0GhcvvLReI5FQleZ7imAebmEzkAd3opmLG5WcmKg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tf6k0tTa+1iaPUElA1kaOVciuSqqZ8jUsE85LmcPKdU3kHRDlnpClR/IWL7gtGxNGxCSp4R2PVNaZjIAwelfSfOQmb5GtDxqENiJe715BRbGmVL6OoOrT+vjlw1ZD6p74kfzG5jLNjFUNDT4e4gWXoU+3winPpo1TfiJka/NhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=fijyb0Ap; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=s0baGfn7; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724888173; x=1756424173;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=UAv0GhcvvLReI5FQleZ7imAebmEzkAd3opmLG5WcmKg=;
  b=fijyb0Ap2Xe8aw9IJR9WmFo5y+hXKwjc0a2nK+9Z9EgZKhPcwPDEFmEy
   5ItHm437islsv61AUnfKv4BcA+G8ivk+SBqSvEDvqpNe4OBubHnNv2UYc
   gkegtm8Gqyn6wQeg8rRKDHxsCNesWSE3RvTSQkGshsjDz4EbTZ7tTk26q
   Dlc7on0SBWYyYdU8xM2NPXyd//LU66O4vfC19rRhvfCL8vqntARUiE8Pn
   rX0TkBT5TsqkZELrm3u8+PHoUEfngwLCEo8Z/9FZa7TTWBT84o9rxz7cS
   6jZ0TSxpKqYgp5C8AS/lHLxIRM1e1px3/YcZmKBRcavXrBBL/rgM4maCU
   w==;
X-CSE-ConnectionGUID: /TRJ30rwSs2KcTaOVAGsAQ==
X-CSE-MsgGUID: A2hGDLSlTseLDZqUzH/rnw==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:36:12 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d5537a62dso95003275ab.2
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724888171; x=1725492971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6rPrJcateiPlUo8F+BEffwFF4a0FjSpJ+meOKec/FkE=;
        b=s0baGfn7Y0YMlyLdy87k8tGEjMdCEf19vVNNZslzRNCZ8Smz7+YWz0LvyqKtV3o+tB
         UuCNBVH5EbyE91LhLf/kzTNE4Rc28A8t+3nSc73upbOz0lUx/dG14B/aAQN9g0GFmvLG
         YH+6j1HshjcM8G7vXFWuBQ8BXk8PTZpUCLH7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724888171; x=1725492971;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6rPrJcateiPlUo8F+BEffwFF4a0FjSpJ+meOKec/FkE=;
        b=Ppou2LesMCf5EcDPnWRijx2zETkbbELMQtNJQ2tFKjzqWXsy3IJz9TwB1hGbDk1ifo
         wGF2O2pJfFh6Fu7lNxZKJ1U9l1zPM+txQXYoWGyXSSFdjfgJ6mdy96TcUZwfqNTgLjoT
         nvOLtZn2hpV5RNor3CsLCfbzrkgLwKz4NHkwmIfAZQE4oCwL8qIpa0SgqQg80ByO2j+C
         gqEQzx9q+j5FJIISbnVHHNrftiLvs/mJ8Lfg9mUNMlZpC7YXwPuLp/cR2QFyJpsAllZv
         Brnzb3dsqaxQ9NNaSOdMkPUd9gZdVDEFZ2dKEMDTGND87Ser/JJlV3SE1XRNvA13TkYQ
         8fEw==
X-Forwarded-Encrypted: i=1; AJvYcCVHggOOf75AKbAehESju5aTeQgwCr7ZOj1G36H++0bnnBLHx9x0bOWtfPt2IcSp/EBm/N9do6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0+cSbA7rm3H/KILb+Lf0IWi6IZHriZKnV1qNOe4yotYG4RSFm
	3jmGki2XEtcsuikiI8Y+SldiAoi5bUqSexK7Q97YWwSU4FvVif9TwU8GiwVO9+3M3ld2ZOlWgfX
	qHCGEnk2UYDDzYDJO2f0FrNk2e0IeTVqa2dcs3LDmDZAg645ChGsOXieRpmc8+522/mXGKKgRUq
	wOebgO5k+nlXD3+Gt9JaQRXGCli+kqGw==
X-Received: by 2002:a05:6e02:2148:b0:39b:3635:e3a with SMTP id e9e14a558f8ab-39f37879ed8mr13063535ab.22.1724888171377;
        Wed, 28 Aug 2024 16:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJG5Dp6FjzNYjfy935e7nCFbqDoD1tB9GDFxoO5P4oBgYIaBOv4Ol6SSRA3Trbx3kzq1MvZbcjjb3kB0x2s1I=
X-Received: by 2002:a05:6e02:2148:b0:39b:3635:e3a with SMTP id
 e9e14a558f8ab-39f37879ed8mr13063425ab.22.1724888171076; Wed, 28 Aug 2024
 16:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:36:00 -0700
Message-ID: <CALAgD-7NTOZ-8-uLbRSa35B+wKkXzzmviE1hy6ajLxwU2kfj7Q@mail.gmail.com>
Subject: BUG: corrupted list in neigh_parms_release
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, j.granados@samsung.com, 
	linux@weissschuh.net, judyhsiao@chromium.org, James.Z.Li@dell.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a
corrupted list  bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

list_del corruption. next->prev should be ffff88801b3bdc18, but was
0000000000000000. (next=ffff88803c7c5018)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:67!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 47298 Comm: kworker/u4:24 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:__list_del_entry_valid_or_report+0x11e/0x120 lib/list_debug.c:65
Code: 96 06 0f 0b 48 c7 c7 e0 5b a9 8b 4c 89 fe 48 89 d9 e8 96 ff 96
06 0f 0b 48 c7 c7 60 5c a9 8b 4c 89 fe 4c 89 f1 e8 82 ff 96 06 <0f> 0b
80 3d bd 35 c6 0a 00 74 01 c3 31 d2 eb 02 66 90 55 41 57 41
RSP: 0018:ffffc90002aff6b8 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88803c7c5020 RCX: 1547a0d62a403a00
RDX: 0000000000000000 RSI: 0000000080000201 RDI: 0000000000000000
RBP: ffffffff8ee71680 R08: ffffffff8172e30c R09: 1ffff9200055fe78
R10: dffffc0000000000 R11: fffff5200055fe79 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff88803c7c5018 R15: ffff88801b3bdc18
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6cc5e4f360 CR3: 00000000413bc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 neigh_parms_release+0x51/0x230 net/core/neighbour.c:1759
 addrconf_ifdown+0x188c/0x1b50 net/ipv6/addrconf.c:4009
 addrconf_notify+0x3c4/0x1000
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0xe0/0x180 kernel/notifier.c:461
 call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
 call_netdevice_notifiers net/core/dev.c:2044 [inline]
 unregister_netdevice_many_notify+0xd65/0x16d0 net/core/dev.c:11219
 cleanup_net+0x764/0xcd0 net/core/net_namespace.c:635
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x11e/0x120 lib/list_debug.c:65
Code: 96 06 0f 0b 48 c7 c7 e0 5b a9 8b 4c 89 fe 48 89 d9 e8 96 ff 96
06 0f 0b 48 c7 c7 60 5c a9 8b 4c 89 fe 4c 89 f1 e8 82 ff 96 06 <0f> 0b
80 3d bd 35 c6 0a 00 74 01 c3 31 d2 eb 02 66 90 55 41 57 41
RSP: 0018:ffffc90002aff6b8 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88803c7c5020 RCX: 1547a0d62a403a00
RDX: 0000000000000000 RSI: 0000000080000201 RDI: 0000000000000000
RBP: ffffffff8ee71680 R08: ffffffff8172e30c R09: 1ffff9200055fe78
R10: dffffc0000000000 R11: fffff5200055fe79 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff88803c7c5018 R15: ffff88801b3bdc18
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6cc5e4f360 CR3: 00000000413bc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


-- 
Yours sincerely,
Xingyu

