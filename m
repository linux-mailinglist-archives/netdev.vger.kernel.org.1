Return-Path: <netdev+bounces-155861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9470A04129
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0323188586E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867BF1F12E2;
	Tue,  7 Jan 2025 13:48:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01411F130A;
	Tue,  7 Jan 2025 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257730; cv=none; b=BhyfKAlmtX7KQ6ZDYv+QX5mdq4+e+0UQDAYC2u1fRCazzinKOcOPRVPM+MID+OzFfuamegDiOWKVZh9No5MWWf+NP7UUXGRBrElYR6mmbMhs7a4aH4QB/JhToZtTnf4QN/ql5zx4Kho9snu7QNmSjsOJGkVEHBnHaQfpTku0Mw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257730; c=relaxed/simple;
	bh=E8L0S0o5EP5ckFB2dqAmJdY5B9TJMQFm436raXDfzRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=CFZhpvaFyZ44Uq35Cg4MqhfJpQjsfTVvMhdqDfIKFKYmtaSa+PUeFYNAxcN6yCMIqJkFPh3uYahqLQ8qBMRBKFHERhBAx8tmj/Wr6rjA6204nR7HufVX0v+KFLh3zSRFcy+9hythNL1xtGdgYkjvHXzCTBEXz1PmZAAnMAC/HVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72C854000B;
	Tue,  7 Jan 2025 13:48:37 +0000 (UTC)
Message-ID: <6c0aa43d-fdbd-472e-944d-e3a9a070d5ae@ghiti.fr>
Date: Tue, 7 Jan 2025 14:48:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [riscv?] kernel panic: Kernel stack overflow (3)
To: syzbot <syzbot+f694b8c2ba2919587a3d@syzkaller.appspotmail.com>,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, syzkaller-bugs@googlegroups.com
References: <676ab734.050a0220.2f3838.01af.GAE@google.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
Cc: netdev@vger.kernel.org
In-Reply-To: <676ab734.050a0220.2f3838.01af.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 24/12/2024 14:29, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    21f1b85c8912 riscv: mm: Do not call pmd dtor on vmemmap pa..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=14d32adf980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=90afd41d36b4291d
> dashboard link: https://syzkaller.appspot.com/bug?extid=f694b8c2ba2919587a3d
> compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: riscv64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-21f1b85c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/69f16f8d759e/vmlinux-21f1b85c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1e170e1b7a02/Image-21f1b85c.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f694b8c2ba2919587a3d@syzkaller.appspotmail.com
>
>   s11: ff6000001cefcec0 t3 : ff6000001cefd9e0 t4 : 1fec0000039dfb3b
>   t5 : 1fec0000039dfba9 t6 : 0000000000000015
> status: 0000000200000100 badaddr: ff20000005acff40 cause: 000000000000000f
> Kernel panic - not syncing: Kernel stack overflow
> CPU: 0 UID: 0 PID: 11449 Comm: syz.2.1759 Not tainted 6.13.0-rc2-syzkaller-g21f1b85c8912 #0
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffff80071bae>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:130
> [<ffffffff8000325c>] show_stack+0x30/0x3c arch/riscv/kernel/stacktrace.c:136
> [<ffffffff8005e1d6>] __dump_stack lib/dump_stack.c:94 [inline]
> [<ffffffff8005e1d6>] dump_stack_lvl+0x110/0x1a6 lib/dump_stack.c:120
> [<ffffffff8005e288>] dump_stack+0x1c/0x24 lib/dump_stack.c:129
> [<ffffffff80003e62>] panic+0x38c/0x86e kernel/panic.c:354
> [<ffffffff80071372>] handle_bad_stack+0xd4/0xfc arch/riscv/kernel/traps.c:427
> [<ffffffff802b37e2>] mark_usage kernel/locking/lockdep.c:4658 [inline]
> [<ffffffff802b37e2>] __lock_acquire+0xaa6/0x8594 kernel/locking/lockdep.c:5180
> SMP: stopping secondary CPUs
> Rebooting in 86400 seconds..
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
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


We have the same stack size as x86 and arm64, which is 32KB. Given the 
fault address (ff20000005acff40), we indeed overflow the kernel stack:

[ 5560.063329][T11449] Task stack:     [0xff20000005ad0000..0xff20000005ad8000]

I noticed the following warning right before we lack space on the stack 
(which in the comments indicate a "recursion"):

[ 5560.055175][T11449] Dead loop on virtual device ipvlan1, fix it urgently!

Can the overflow be explained by this? Or should we again increase stack space? Or could this be a riscv specific issue?

I have no idea, so +cc netdev in case they can explain this.

Thanks for your help,

Alex


