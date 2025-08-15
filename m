Return-Path: <netdev+bounces-213882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAF7B2735A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830A65E67D5
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63391114;
	Fri, 15 Aug 2025 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="pZVdPsq0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp153-162.sina.com.cn (smtp153-162.sina.com.cn [61.135.153.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977819A
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 00:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216711; cv=none; b=M3DwHx46AdgeVqXZJPxTTaahgeABinCZVnycADB14NNFbD2jb9Wtxrwlzv/AHIzJrKK/y66ARZ8YZTmaZFz7OQNLnyiRbHwyJY2MVo+c5VPVaXVYfvgVc+zQy9wx/+WDGxD5j8maIMXa6p47o1qxLiDORc4atHxGS3/xfKMKcfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216711; c=relaxed/simple;
	bh=M7/awrwFW0+lfKMbyVgOnxo2z+jj8zWoxElZ250hLBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAVGy1TqtT+B/csxWgIaAGUqmNGbmry1UeyGFFXV1Rop2kcj/UcJ8Lh5SqzR4U2qEl6BYAM2LxUIOiUz7N/WpXxHPQFYXSPGL1ApfBALpQs+fYW2efhwVkxf0TRcvdfd2pbHbgptVJypPlBvVT/6/VBl0ulrhuV6Sp83Y6AX6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=pZVdPsq0; arc=none smtp.client-ip=61.135.153.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755216702;
	bh=fDqRyFA+mjlN2QT1Fq9xh052KYDrnE6/QdvHVjXFdsg=;
	h=From:Subject:Date:Message-ID;
	b=pZVdPsq0JjuECx/fF6Zs8hIQD+MTMQqrPRz+aPEkdyv6vlTcVEqkyYGS22BuimpTt
	 0606RgcmUp09MHXiWFWLn7ScqQW88+LYqhTAq8BWPs4gesVvwcEu3USUPrl+S4rX+x
	 CJFcZpCkOu6hpi9cekShs5w0wcYaqNccqBDjJttI=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 689E7B3300004D9A; Fri, 15 Aug 2025 08:11:34 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1152966816373
X-SMAIL-UIID: B585CA0F583C4A35B1986E2EFF5354D0-20250815-081134-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+535bbe83dfc3ae8d4be3@syzkaller.appspotmail.com>
Cc: edumazet@google.com,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nfc?] [net?] WARNING in nfc_rfkill_set_block
Date: Fri, 15 Aug 2025 08:11:21 +0800
Message-ID: <20250815001123.4558-1-hdanton@sina.com>
In-Reply-To: <689e6bba.050a0220.e29e5.0003.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 16:05:30 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16c80af0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=13f39c6a0380a209
> dashboard link: https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/46150b6d2447/disk-8f5ae30d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1c604b2b2258/vmlinux-8f5ae30d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9c542f0972de/bzImage-8f5ae30d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+535bbe83dfc3ae8d4be3@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> rtmutex deadlock detected

Even given the lockdep_set_novalidate_class() in device_initialize(),
rtmutex can detect deadlock (the ABBA one [1]?), weird.

[1] Subject: [PATCH] net/nfc: Fix A-B/B-A deadlock between nfc_unregister_device and rfkill_fop_write
https://lore.kernel.org/lkml/20250814173142.632749-2-ysk@kzalloc.com/

> WARNING: CPU: 1 PID: 9725 at kernel/locking/rtmutex.c:1674 rt_mutex_handle_deadlock+0x28/0xb0 kernel/locking/rtmutex.c:1674
> Modules linked in:
> CPU: 1 UID: 0 PID: 9725 Comm: syz.8.874 Tainted: G        W           6.17.0-rc1-syzkaller #0 PREEMPT_{RT,(full)} 
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> RIP: 0010:rt_mutex_handle_deadlock+0x28/0xb0 kernel/locking/rtmutex.c:1674
> Code: 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f 85 8c 00 00 00 48 89 f7 e8 c6 2c 01 00 90 48 c7 c7 a0 08 0b 8b e8 79 08 8b f6 90 <0f> 0b 90 90 4c 8d 3d 00 00 00 00 65 48 8b 1c 25 08 b0 f5 91 4c 8d
> RSP: 0018:ffffc900043a7950 EFLAGS: 00010246
> RAX: 89021558f1df5a00 RBX: ffffc900043a79e0 RCX: ffff888025bb3b80
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc900043a7b00 R08: 0000000000000000 R09: 0000000000000000
> R10: dffffc0000000000 R11: ffffed1017124863 R12: 1ffff92000874f38
> R13: ffffffff8af82119 R14: ffff888036e55098 R15: dffffc0000000000
> FS:  00007fec70d5e6c0(0000) GS:ffff8881269c5000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fce013b0000 CR3: 000000003ebbc000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
>  __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
>  rt_mutex_slowlock+0x692/0x6e0 kernel/locking/rtmutex.c:1800
>  __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
>  __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
>  mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
>  device_lock include/linux/device.h:911 [inline]
>  nfc_dev_down net/nfc/core.c:143 [inline]
>  nfc_rfkill_set_block+0x50/0x2e0 net/nfc/core.c:179
>  rfkill_set_block+0x1e5/0x450 net/rfkill/core.c:346
>  rfkill_fop_write+0x44e/0x580 net/rfkill/core.c:1301
>  vfs_write+0x287/0xb40 fs/read_write.c:684
>  ksys_write+0x14b/0x260 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fec72afebe9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fec70d5e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fec72d25fa0 RCX: 00007fec72afebe9
> RDX: 0000000000000008 RSI: 0000200000000080 RDI: 0000000000000003
> RBP: 00007fec72b81e19 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fec72d26038 R14: 00007fec72d25fa0 R15: 00007ffe1f71d718
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

