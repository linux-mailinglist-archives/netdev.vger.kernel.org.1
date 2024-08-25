Return-Path: <netdev+bounces-121703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DF795E213
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 07:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395611C21616
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 05:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB363987D;
	Sun, 25 Aug 2024 05:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="kYF6neWR";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="lDc8Mp94"
X-Original-To: netdev@vger.kernel.org
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CED4374D1
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724563115; cv=none; b=g8GEEfOgepUyTrK9171TiFThijj5LEYkf20rdFeTJyzHirK9hkvFwUhha4HMmKQwWI8JMbZcsxWGIjxPKNPSNBNwRPcILjmevgzuRcY3p8+79PnY9bKO4aQxcGUtDXQwo7l4BriOw8HKlZxOvF0/lyS7o7jT4Vnu1X9mYcTLFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724563115; c=relaxed/simple;
	bh=HGskyNopxoItjsgiqPdNz+iXkPrMwMiI0XicQsA+fkw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ifbtZIWWfSlmAjivPW2d0G1PM2f3RNkLQyvlAOhyywCXIAAV9rIpGCo2ri2N+/0Xp0OrmRZ+hKCuX5vvs1TIb4I3FdipBQkHgg+U1jKf8gLvyi4HSDUifcz3GWygShgeDRzBHUxe147JJpLsGBSuK+iOeUL7Lkr3o8E0xgS10Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=kYF6neWR; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=lDc8Mp94; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724563114; x=1756099114;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=HGskyNopxoItjsgiqPdNz+iXkPrMwMiI0XicQsA+fkw=;
  b=kYF6neWRMYWjZVVOkpqIBbjfugSYy3tK/FgnxgajpS3PPBiC/UjV2P02
   3b+eFU16V4jz2QziyvpD03IBfkZJvJZjpf9UqPmQEXCoEp5q9GA7QyXW7
   0l78+I4+tOSr53i4xFQhZ5AoGrRKSOerV54P0PTlRqvKzU7Z5NnipFb+B
   06RXQjVwsp++GyOdvc6eXyXGVPX3jyfE5zqNB3Jm84hwNnBqmn5OKcBTu
   yUU/pFtbLsw8m0fboUHSjGtXwuYlRzc/uJdyG+jQ09iIJmeIWG4ZW3aUy
   JXy5GuAC/eCFlW4N6C3SZVcV6aXgSfr8i4aRIEeKRuDSAthljrcUJ1skc
   Q==;
X-CSE-ConnectionGUID: WJNVpDXtRre9j/YCJ+6YTg==
X-CSE-MsgGUID: FMhP8O3PQ9OW+J2DSoIYKQ==
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 22:18:32 -0700
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d699beb78dso266074a91.0
        for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 22:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724563111; x=1725167911; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hveo/sb1qFxBdIAwFwqC/JxPePO91I71rDzJTBS1dJE=;
        b=lDc8Mp94uWSdYOo2t2UVB4UDc2uRzUJ9RwP+9MHWhbE0PeLNgpFAKA8geJ4yR9OiT5
         Eg2mpIr2/6Xgc+ZfAU2VVGFkXV4yVn4XoZpE6OmYRJ7n+OigF1qmx3uZnmfDdjEUQwIT
         gpXQEHR9P6QZcGi/cG4j4nm6eY6wxzbtBXoq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724563111; x=1725167911;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hveo/sb1qFxBdIAwFwqC/JxPePO91I71rDzJTBS1dJE=;
        b=nzl18ayXa7oTY9RSE3cdriR4MSP9sS12Tfj3sCG/EXYZhrW4emYPe9rtnCHqujZHLb
         yUN11ad/5qUiIJbzkNJH80HiiXNWPUIaB+aEJtryM8e0LFXih41RsHZ1l4vYmvbJlSm2
         E5noMCMujEipmYPGwn+rhCGS5VA6ZRh1+J8ySYQJBxI3mcQUYWOh9wT6EE/gK9G4rnfK
         dWkYQm9W61+vmVfFHGPLa7OQ2+xxygl4NgKTkSAMJVOaSDaqZkbL6dC8yCm2PPN6f6QY
         04QsgtwTwRiISNBdzEW4c3eYTHtXVIz/3lFIu/DwYHynB7NcWA93I/GcbbVfABS2r33N
         l6YA==
X-Forwarded-Encrypted: i=1; AJvYcCVhbnKpk/tFFm5Cg6D3967zHoZP39dpeOsRoY+uj+/KX7oKVg9xu7oqrMYzvnDaeg3KvODd9Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjOysoUxVNMDFuS8rLjT08BT4R0jFVMcQ2lQ8eRmC3RkWplmA
	6RSDvczbjy/tpYB6HC2jcIkhXBKP3XZfEzuYmvPIW78kgBcjITw61s9Gsh4l9ymTQt5eDNYY+DE
	RjIR9Izgl9ojsBuMiBi4kQkjkciZ76x5m3T/YWQSukdQ6KqKXoyP/lFMPeOtSgbUlEIdLp693jO
	c7bZDT0ORVC5VC2sAzzO0TLTo6+SPiwA==
X-Received: by 2002:a17:90a:c68b:b0:2cf:7cce:cc19 with SMTP id 98e67ed59e1d1-2d646bbb1f0mr7599516a91.6.1724563111543;
        Sat, 24 Aug 2024 22:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYtQlyTR9KDnJVu24zqlCaI40bQ5hg55DnY7OzRf4SRt+YCXuUrjCdzwNiKYd2DsSOHLjFR2f+7XXtVkNlOxw=
X-Received: by 2002:a17:90a:c68b:b0:2cf:7cce:cc19 with SMTP id
 98e67ed59e1d1-2d646bbb1f0mr7599506a91.6.1724563111182; Sat, 24 Aug 2024
 22:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 22:18:20 -0700
Message-ID: <CALAgD-5Y84pL8sUJe5_Sp9sJ_M1Xw-pqzLmauWHRTfE_TFoVVg@mail.gmail.com>
Subject: WARNING in dev_addr_check
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10. It is probably a logic bug.
There is a warning "Incorrect netdev->dev_addr"  generated at the line
519 of warning net/core/dev_addr_lists.c.

The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

netdevice: wlan1 (unregistered): Incorrect netdev->dev_addr
WARNING: CPU: 0 PID: 70 at net/core/dev_addr_lists.c:519
dev_addr_check+0x17e/0x1e0 net/core/dev_addr_lists.c:519
Modules linked in:
CPU: 0 PID: 70 Comm: kworker/u4:4 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:dev_addr_check+0x17e/0x1e0 net/core/dev_addr_lists.c:519
Code: f9 48 8b 13 eb 15 80 3d 89 fb 35 06 01 75 22 e8 28 1b b8 f8 48
c7 c2 e0 f7 68 8c 48 c7 c7 e0 f4 68 8c 4c 89 fe e8 c2 69 7c f8 <0f> 0b
e9 e6 fe ff ff e8 06 1b b8 f8 c6 05 59 fb 35 06 01 48 c7 c7
RSP: 0018:ffffc9000185f710 EFLAGS: 00010246
RAX: 503403a848a81f00 RBX: ffffffff8c68f818 RCX: ffff888018159e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000fffffff8 R08: ffffffff8155a25a R09: 1ffff1100c74519a
R10: dffffc0000000000 R11: ffffed100c74519b R12: ffff888046f046c0
R13: dffffc0000000000 R14: ffff888046f04130 R15: ffff888046f04130
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f9af880ae8 CR3: 000000003c37c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dev_addr_flush+0x28/0x200 net/core/dev_addr_lists.c:533
 free_netdev+0x1f4/0x4d0 net/core/dev.c:11074
 netdev_run_todo+0xdfa/0xf80 net/core/dev.c:10695
 ieee80211_unregister_hw+0x11f/0x2d0 net/mac80211/main.c:1669
 mac80211_hwsim_del_radio+0x2ba/0x4b0
drivers/net/wireless/virtual/mac80211_hwsim.c:5576
 hwsim_exit_net+0x5bd/0x660 drivers/net/wireless/virtual/mac80211_hwsim.c:6453
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x810/0xcd0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>


-- 
Yours sincerely,
Xingyu

