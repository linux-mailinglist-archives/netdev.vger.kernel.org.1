Return-Path: <netdev+bounces-121683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B68395E0C0
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 04:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4B01C20CD5
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 02:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97DA7462;
	Sun, 25 Aug 2024 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="X4G1sZ4t";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="urXw0AhU"
X-Original-To: netdev@vger.kernel.org
Received: from mx6.ucr.edu (mx6.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D4EBE49
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724553833; cv=none; b=BfTkToQPQD8RTgBTXaBoSxeNnamyrrAWNS3NfdlMtHKWkzmw796YJYPm8P+cywLvwlNFNdVYYyizZ27IBOhQwfegMGbIj7URvNZeVBhgin1oRbEpL6nxlNRJczlS6zOSX4I3SFdWiUYPsZvFydfd2uD6cye83h9KT/XfdlvmGNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724553833; c=relaxed/simple;
	bh=xYwht60nwukBIB8VvdyNWQ1W6v8FzgDLlaemLk8iqvs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=c8pfhvxwZYP9vQLJFP/VClpwzV+aA3zwzLp8hlW0sKQGuAMaLjvJRzyUsMhL4gxKTggyxfF1FEtYBka9BD7fiSSe70Bs+V/CpVXZcOONECN6ufoCreHCHDoJyohJ/pN0hv3McP5KyQVRkv5utDS1CIbTp6QHlLP7UQL0j5XCHoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=X4G1sZ4t; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=urXw0AhU; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724553832; x=1756089832;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=xYwht60nwukBIB8VvdyNWQ1W6v8FzgDLlaemLk8iqvs=;
  b=X4G1sZ4tFFZ5yAs/z6aW7ibuJfhccXNpSQ06Z8Zt2xleh8U2vXGr0fU5
   s1NqhE0fvsd9R5FG15S2R1AKj78V73pgicgGYS/wJcfCS5mF/LyIhIwij
   PXnhLU9KVAOZ0TzaZ9yR3FY+pXYIq2ep/8z4RbcTK1rlDo6YslP4ZYqrp
   JEf8/WC1W1vfTlYDbsiSntfOtqF521AhoBXOv9J65YMD8pPw2LGEwuBOv
   ZSFtlX1W7VNjIUqd7TFk0G9HG9qFBGXUfvVJDyCcdPJVAv97mdH0SBp1F
   f2Cf8/2wQVziIg6fLvPbyjzSLclTR96YrcLMiAP3kj587E2R+x1lf80D3
   w==;
X-CSE-ConnectionGUID: 5TC4YaayQVq7Zvb8FXFGbg==
X-CSE-MsgGUID: MS0/kP+1TJOG2DhPZ5l1bw==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 19:43:43 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d5537a62dso39489115ab.2
        for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 19:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724553822; x=1725158622; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4MNH+fMGdP9JHLT+281L3G2ZahxWv0gRwwGG3Pw9Mrw=;
        b=urXw0AhUEaSFCqW1NBeuVHtsyQkk111oNXqnAJgSF4uLSvz036Z4wLvkyMtq+MCbts
         G49V3/MYYUmGGDniPqlpB/QjSwm+jIK8w6UlhDAXX1a1BQcR0N7yDIzIlZW7kjNAOT9n
         DnKe1cCwCTSSvtKMaga4/YoqtFYhhwhkme+/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724553822; x=1725158622;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4MNH+fMGdP9JHLT+281L3G2ZahxWv0gRwwGG3Pw9Mrw=;
        b=uSfaxs2MjT7WAh2o3lLebewvO4w45eHv8wCEnSnrEBQKYJRp2JGLgX34SH3xy0Cjoc
         oXONLpars2qN23P185xnUrSg2kZSFI1iQtzyXRjUx+TyK9fzERUFR8NdALP1xULmQm6O
         VuwqFDc/kWqgFaWbdqe/mm4xCVZ6sBG3RB2HaZxzNyqY29bDVWI8c0fgOsmKHQsf8z56
         DoqejDYc5zR117UyI2gbG13Bw2jXA8XCla01rbDwwNjvsf7yDAbMuMcs8fqECdCyKya5
         fqVSWRTif+nI01XtLiLK1eLxbQbxu8DJZ/YAxezZd0lFBP4Jq7WkFwfBBPXR1Z5KNTZg
         58qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb9LlwJaAZ5wZHGDpS+IRQQjktgDWkkuZhzHmEhuTgQYe7PcogKux3p3IqlozdFSeNBoONG/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4kPosRzJy1zOU5MIx/njSskCW5wRMgXyOy/PfLqlqMnS4K2P
	jl6KoiACBJuhvM0pqQjoPEHMp2n/MwW8UySpM4zXPiMekAl9SlUqchvVJyyJwTrEF3N7NDdZZlg
	1R5bN1VzxsavQe5yk0eFFJXaeqIw9SWFXgAeeZmhkuxGNCMRRBOvWD7KzfdLlcjDUtGpVJQ3NZZ
	jLgJu0hB5nQ1/E6fe/hc59lOYghmy1sA==
X-Received: by 2002:a05:6e02:188a:b0:396:f026:b0ac with SMTP id e9e14a558f8ab-39e3c989ecfmr81369905ab.14.1724553822544;
        Sat, 24 Aug 2024 19:43:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr8z+YHMldSfKdzax7ksxhfCeggpAybAldZfkpvfBau9UN11Sq+ooUijQjlihTL6LPNcWCm6zdS6A/CIPsSIU=
X-Received: by 2002:a05:6e02:188a:b0:396:f026:b0ac with SMTP id
 e9e14a558f8ab-39e3c989ecfmr81369785ab.14.1724553822239; Sat, 24 Aug 2024
 19:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sat, 24 Aug 2024 19:43:30 -0700
Message-ID: <CANikGpfm_DbtXV9+omVrZhGiFA3iVEb=JeE1OQwvB3cXXDPoag@mail.gmail.com>
Subject: BUG: general protection fault in sctp_inet6addr_event
To: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In `sctp_inet6addr_event`, a general protection fault error is
triggered when trying to execute `list_for_each_entry_safe(addr, temp,
&net->sctp.local_addr_list, list) { ...`
According to the report, it looks like the register $rax (propagated
from $r15) is unexpectedly set to null, causing an null-pointer
dereference issue.


Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 16764 Comm: kworker/u4:10 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:sctp_inet6addr_event+0x118/0x6e0
Code: 44 24 08 48 89 44 24 40 4c 89 e0 48 c1 e8 03 48 89 44 24 38 4c
89 64 24 28 4c 89 74 24 30 4c 89 f8 48 c1 e8 03 48 89 44 24 48 <42> 80
3c 28 00 74 08 4c 89 ff e8 89 25 b3 f7 49 8b 07 48 89 44 24
RSP: 0018:ffffc9000a037340 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888024170000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000a
RBP: ffff88802e8ed520 R08: ffffffff8a413727 R09: fffff52001406e58
R10: dffffc0000000000 R11: fffff52001406e58 R12: ffff88801856d000
R13: dffffc0000000000 R14: ffff88802cd22b88 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f10a8812088 CR3: 0000000028e84000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 notifier_call_chain kernel/notifier.c:93 [inline]
 atomic_notifier_call_chain+0x195/0x2d0 kernel/notifier.c:231
 addrconf_ifdown+0xedb/0x1b50 net/ipv6/addrconf.c:3980
 addrconf_notify+0x3c4/0x1000
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0xe0/0x180 kernel/notifier.c:461
 call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
 call_netdevice_notifiers net/core/dev.c:2044 [inline]
 dev_close_many+0x352/0x4e0 net/core/dev.c:1585
 dev_close+0x1bb/0x2c0 net/core/dev.c:1607
 cfg80211_shutdown_all_interfaces+0xbc/0x1d0 net/wireless/core.c:280
 ieee80211_remove_interfaces+0x111/0x690 net/mac80211/iface.c:2278
 ieee80211_unregister_hw+0x59/0x2d0 net/mac80211/main.c:1659
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
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sctp_inet6addr_event+0x118/0x6e0
Code: 44 24 08 48 89 44 24 40 4c 89 e0 48 c1 e8 03 48 89 44 24 38 4c
89 64 24 28 4c 89 74 24 30 4c 89 f8 48 c1 e8 03 48 89 44 24 48 <42> 80
3c 28 00 74 08 4c 89 ff e8 89 25 b3 f7 49 8b 07 48 89 44 24
RSP: 0018:ffffc9000a037340 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888024170000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000a
RBP: ffff88802e8ed520 R08: ffffffff8a413727 R09: fffff52001406e58
R10: dffffc0000000000 R11: fffff52001406e58 R12: ffff88801856d000
R13: dffffc0000000000 R14: ffff88802cd22b88 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f10a8812088 CR3: 0000000028e84000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 44 24 08             rex.R and $0x8,%al
   3: 48 89 44 24 40       mov    %rax,0x40(%rsp)
   8: 4c 89 e0             mov    %r12,%rax
   b: 48 c1 e8 03           shr    $0x3,%rax
   f: 48 89 44 24 38       mov    %rax,0x38(%rsp)
  14: 4c 89 64 24 28       mov    %r12,0x28(%rsp)
  19: 4c 89 74 24 30       mov    %r14,0x30(%rsp)
  1e: 4c 89 f8             mov    %r15,%rax
  21: 48 c1 e8 03           shr    $0x3,%rax
  25: 48 89 44 24 48       mov    %rax,0x48(%rsp)
* 2a: 42 80 3c 28 00       cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f: 74 08                 je     0x39
  31: 4c 89 ff             mov    %r15,%rdi
  34: e8 89 25 b3 f7       call   0xf7b325c2
  39: 49 8b 07             mov    (%r15),%rax
  3c: 48                   rex.W
  3d: 89                   .byte 0x89
  3e: 44                   rex.R
  3f: 24                   .byte 0x24

