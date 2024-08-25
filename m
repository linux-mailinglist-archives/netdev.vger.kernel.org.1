Return-Path: <netdev+bounces-121701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEDD95E1D0
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 07:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70932825FB
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 05:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91F83612D;
	Sun, 25 Aug 2024 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="LThwQ2Lw";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="KDXAIjf8"
X-Original-To: netdev@vger.kernel.org
Received: from mx-lax3-3.ucr.edu (mx-lax3-3.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4842837B
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 05:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724562535; cv=none; b=UiOaW/tE3/cyyzvsezy9iNy8Rc0E/jy09Sztx5uGTcdS1KIYeCnSUSyjEJk0/d/Tey0v42wxNKVhSYC273eqx77IOx6uAXXqObAjFtr+fbxvV31XLx9+AOwAN683++5F+w1BUbc+EhFQyk/4+pOjqdkZPkbzwCAA6ixtT02OiXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724562535; c=relaxed/simple;
	bh=jIOJaMMn0ZTGTb/Z3TzCsAw0gHRpSe90LkJXETJSClQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HPjC20o8ZWgnXN3fmHhBuaSLGUqlvZbyLNaSlA3/ZBdNC22eS0fOyU5Ly7ZKjE02ntO0Yo6KO2Tp22ly1GCZbwdJk334cX5yMj9TH37tqXVkKmPPyMHiHPoh6ahebVE7NjMOyg+BUe4GrhrVTdQpZLQW2D2uL//s8mNdVP6kJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=LThwQ2Lw; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=KDXAIjf8; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724562534; x=1756098534;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=jIOJaMMn0ZTGTb/Z3TzCsAw0gHRpSe90LkJXETJSClQ=;
  b=LThwQ2Lw2EQ2h+43sqPV7EKUovwXmB78/4hR+KYXriPPvbxS6i9g8kyu
   Va95hf2+IZ6h4t4JKLdN6U24GomADV+JMpsvg7c4hQq+5U1CWnfWrTgmz
   e78IUg0AlFxR9kSiQ/LdH9rGMVcRAGXkr19kKGD4NZpa3F6T79ozel9wL
   txhVHdfMC9+8buvLZg1TpA4NW92MAYZARPSojlySH6wJW81DKXuTVGMcj
   DuVHcnoJAvjO/PIGwxi1F04/b3D1SsON4I6k3FvsohhhvucouIcjT0Jvg
   iWIsIL+EdIC+mp9ehF2r1atWFh6O9iD+Qk5G03fNBrU1z0xN7xfM+6WaN
   Q==;
X-CSE-ConnectionGUID: 8IOfZV8cSN+rYqKeP6hRGw==
X-CSE-MsgGUID: y3GdqLqDQE6UJ6dzX6Bcqw==
Received: from mail-pj1-f69.google.com ([209.85.216.69])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 22:08:52 -0700
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d3c008e146so4257631a91.0
        for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 22:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724562531; x=1725167331; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4jvoW/6vL6+TrkpuNdtvsEjvxWnP1eLQrupVhxC/zQ8=;
        b=KDXAIjf8/e8LJRgducXOjiQzUizsZvH57CsICj3dDG77mtznRMhK/m4UVs4ZOrZUPG
         ExmT6Y+l9LFqdvXt6CmpOOovQe6AByK9rmLcW4iv6tujY1MCKJS0U85ADLzJC7xmXVl4
         y5XnC7LnQ1suwLQudGXIHIlE41uj9CEtcMZ7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724562531; x=1725167331;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jvoW/6vL6+TrkpuNdtvsEjvxWnP1eLQrupVhxC/zQ8=;
        b=VoVl8Qcx8oYVdUM/5vXagnpoi9xCJS8gJDKRpUBpNa5Q+w4wYyXc1maCPA5Sn51MQ0
         5mo0QJ9LVQ8+wRopMmQoThdo0tUdySEOsBjO2C/3QRszVcVOv++9PUu4QfBhsF4eTOQR
         KpOy/ko/aT52jEr+kFfDtjC/v/MKG6RDTGYjMrscxZp9n3sfOxVPtdMxvQy5Tqw+4VmV
         LChwuSTwCjRlVT4UpF0EjXNdNfbfeBWZRw040cQc0HaqGgtkT9BOrZxeL7pmQUcY4rdc
         mAi9vVMg/gpDoUAG32CuuKdiMvx3Ncq2KBCwLIzaOI051gAW/SbWD2Q+/MgOi/Yn4p8B
         sU7g==
X-Forwarded-Encrypted: i=1; AJvYcCXDvI0EHi93G+r0FCGXi6CjjGUz7FIln3WubVXvpzZXQ2fBL4vp5t8ACw0BiUnaiXc7RLRfeWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHiAgkYPPKsa0TalG3YuZrIy9+wMqtwGh2DHGlio1gSUylBvQZ
	fnIy3ovum+Mb5u92cxFliBtkH2mcWoW9AjBGSJPL+xHay25uf62drvbH7RcKq55GnoBFfJIWb6+
	Crf36qQ9quz/sXH4YTZQKZbRmluYkiDln25qNlLy9V6X4WazxZo5RpqYDtpNIJShFsEef9n8uqr
	1BDNbwGB4pqVqES7Jw2AQMUxuF8YVsRA==
X-Received: by 2002:a17:90b:188b:b0:2c7:c788:d34d with SMTP id 98e67ed59e1d1-2d646d6899dmr7473019a91.38.1724562530835;
        Sat, 24 Aug 2024 22:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnrW+0VEZp4u5uEDjDEdr9+ONFvvqOWUxIoWXSuLe9qqECj5DWxi+Q+0wLATmU5guoPBGoPzIWrCGYEBxJDQY=
X-Received: by 2002:a17:90b:188b:b0:2c7:c788:d34d with SMTP id
 98e67ed59e1d1-2d646d6899dmr7473011a91.38.1724562530496; Sat, 24 Aug 2024
 22:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 22:08:39 -0700
Message-ID: <CALAgD-72RvKXf37Zx+r2y44eW3XQQh40PTKvAiq67apjEUHWRA@mail.gmail.com>
Subject: BUG: general protection fault in skb_queue_purge_reason
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10. It is probably a null pointer dereference bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.
Bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 16200 Comm: syz.1.596 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__skb_unlink include/linux/skbuff.h:2389 [inline]
RIP: 0010:__skb_dequeue include/linux/skbuff.h:2405 [inline]
RIP: 0010:__skb_queue_purge_reason include/linux/skbuff.h:3259 [inline]
RIP: 0010:skb_queue_purge_reason+0x383/0x500 net/core/skbuff.c:3886
Code: 80 3c 30 00 74 05 e8 cc 7f 24 f9 4c 8b 7b 08 4d 8d 6c 24 08 ba
10 00 00 00 48 89 df 31 f6 e8 54 d0 27 02 4c 89 e8 48 c1 e8 03 <42> 80
3c 30 00 74 08 4c 89 ef e8 1e 80 24 f9 4d 89 7d 00 4c 89 f8
RSP: 0018:ffffc90004e8f6c0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff888044039500 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888044039510
RBP: ffffc90004e8f830 R08: ffffffff910fc66f R09: 0000000000000000
R10: ffff888044039500 R11: fffffbfff221f8ce R12: 0000000000000000
R13: 0000000000000008 R14: dffffc0000000000 R15: ffffc90004e8f760
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f39e3546018 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 skb_queue_purge include/linux/skbuff.h:3273 [inline]
 vhci_flush+0x40/0x50 drivers/bluetooth/hci_vhci.c:69
 hci_dev_close_sync+0x728/0xcb0 net/bluetooth/hci_sync.c:5088
 hci_dev_do_close net/bluetooth/hci_core.c:512 [inline]
 hci_unregister_dev+0x1fd/0x4e0 net/bluetooth/hci_core.c:2728
 vhci_release+0x7f/0xd0 drivers/bluetooth/hci_vhci.c:666
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
RIP: 0033:0x7facd07809b9
Code: Unable to access opcode bytes at 0x7facd078098f.
RSP: 002b:00007facd01ff038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: 0000000000000038 RBX: 00007facd0946058 RCX: 00007facd07809b9
RDX: 0000000000000038 RSI: 0000000020000100 RDI: 0000000000000005
RBP: 00007facd07f4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007facd0946058 R15: 00007ffefaa5f968
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__skb_unlink include/linux/skbuff.h:2389 [inline]
RIP: 0010:__skb_dequeue include/linux/skbuff.h:2405 [inline]
RIP: 0010:__skb_queue_purge_reason include/linux/skbuff.h:3259 [inline]
RIP: 0010:skb_queue_purge_reason+0x383/0x500 net/core/skbuff.c:3886
Code: 80 3c 30 00 74 05 e8 cc 7f 24 f9 4c 8b 7b 08 4d 8d 6c 24 08 ba
10 00 00 00 48 89 df 31 f6 e8 54 d0 27 02 4c 89 e8 48 c1 e8 03 <42> 80
3c 30 00 74 08 4c 89 ef e8 1e 80 24 f9 4d 89 7d 00 4c 89 f8
RSP: 0018:ffffc90004e8f6c0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff888044039500 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888044039510
RBP: ffffc90004e8f830 R08: ffffffff910fc66f R09: 0000000000000000
R10: ffff888044039500 R11: fffffbfff221f8ce R12: 0000000000000000
R13: 0000000000000008 R14: dffffc0000000000 R15: ffffc90004e8f760
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcf60c59398 CR3: 00000000195c0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 80 3c 30 00           cmpb   $0x0,(%rax,%rsi,1)
   4: 74 05                 je     0xb
   6: e8 cc 7f 24 f9       call   0xf9247fd7
   b: 4c 8b 7b 08           mov    0x8(%rbx),%r15
   f: 4d 8d 6c 24 08       lea    0x8(%r12),%r13
  14: ba 10 00 00 00       mov    $0x10,%edx
  19: 48 89 df             mov    %rbx,%rdi
  1c: 31 f6                 xor    %esi,%esi
  1e: e8 54 d0 27 02       call   0x227d077
  23: 4c 89 e8             mov    %r13,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 30 00       cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f: 74 08                 je     0x39
  31: 4c 89 ef             mov    %r13,%rdi
  34: e8 1e 80 24 f9       call   0xf9248057
  39: 4d 89 7d 00           mov    %r15,0x0(%r13)
  3d: 4c 89 f8             mov    %r15,%rax


-- 
Yours sincerely,
Xingyu

