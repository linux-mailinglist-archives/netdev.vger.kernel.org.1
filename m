Return-Path: <netdev+bounces-286618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKWWIpK9AWozjQEAu9opvQ
	(envelope-from <netdev+bounces-286618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:29:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C050CBA7
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E859A30432F5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D47371041;
	Mon, 11 May 2026 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YsiIMz2D"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3436C0CA
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498607; cv=none; b=DuS2TqGN7Lr2ZrzV7rVXRpiMAPlwAh9fQHiUEhUqvFN2D8q7uEz7lTvHwzK649pX7SbVLuJnUUcr9PDskDnJgxE2QBJj74n0A88YU2+RhMVXRMrxqjVC6h5vMypJfcSua4VIxU76f3kK72blw9JqUK2FcXjHaP8xs3qtX2vvYfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498607; c=relaxed/simple;
	bh=VyxaJ9MDjbG+qLPFf6co9O+w4CKDfFZyyXZhAl67csg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vas2O7Px2XrtRTmqvpNBMSfaH8RcCgNJCfK7DIshfDMC80TD64ay709NnwQOctxds7/ATAhcuu9uwqwD7DReZRyLGRjOn5BfuLNpNOsJVs73PsrUdOys9epyqRLxY1DyP3D15Ly2EFHHUHcCcNfevgtReUa8xqDSuqtqTnTGg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YsiIMz2D; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd06ea1b-c9a1-4d7e-8c80-96a9bb4e31b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778498603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ir5sDmrpy9Jh0yOIejPVw3fVo5tABJcSn+8jnVeqjRU=;
	b=YsiIMz2DMaMFyO9SPvg+dxKFy/vHKl+NzllbvbUZAUQPTzZRi7DGNB2Esf3NKuPGyHiVyC
	M2s5ik9K6bz5+G+xlDTpLc9doelVhRceavukzFkfkk2odE7WsyrnZOaGH7SxWBVyYVsuP2
	dGM7bRCs8LfqvUaZGEJrqLKEj6QRx+4=
Date: Mon, 11 May 2026 19:23:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [net?] WARNING in qdisc_tree_reduce_backlog (2)
To: syzbot <syzbot+9744ccaabe337c6fb123@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
References: <6a0175e0.a00a0220.1c3806.0016.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <6a0175e0.a00a0220.1c3806.0016.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C91C050CBA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f2e8ebfec4636d32];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286618-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url,appspotmail.com:email,linux.dev:mid,linux.dev:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9744ccaabe337c6fb123];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action


On 5/11/26 2:23 PM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5862221fdded Merge tag 'parisc-for-7.1-rc3' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a4bb26580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f2e8ebfec4636d32
> dashboard link: https://syzkaller.appspot.com/bug?extid=9744ccaabe337c6fb123
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cd9aba7e59bf/disk-5862221f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/29af9d57e9af/vmlinux-5862221f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/02749594fd1e/bzImage-5862221f.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9744ccaabe337c6fb123@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> parentid != TC_H_ROOT
> WARNING: net/sched/sch_api.c:797 at qdisc_tree_reduce_backlog+0x3d9/0x480 net/sched/sch_api.c:797, CPU#1: ktimers/1/29
> Modules linked in:
> CPU: 1 UID: 0 PID: 29 Comm: ktimers/1 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)}
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> RIP: 0010:qdisc_tree_reduce_backlog+0x3d9/0x480 net/sched/sch_api.c:797
> Code: ff ff 4c 89 ef e8 b7 85 12 f9 e9 42 ff ff ff e8 4d 7c ab f8 eb 17 e8 46 7c ab f8 eb 10 e8 3f 7c ab f8 eb 09 e8 38 7c ab f8 90 <0f> 0b 90 e8 7f 72 03 02 89 c3 31 ff 89 c6 e8 d4 80 ab f8 85 db 74
> RSP: 0018:ffffc90000a3f768 EFLAGS: 00010246
> RAX: ffffffff8918f818 RBX: 0000000000000008 RCX: ffff88801daa3d80
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
> RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000100
> R10: 0000000000000100 R11: 00000000ffffffff R12: 00000000000affe0
> R13: dffffc0000000000 R14: ffffc90000a3f8e0 R15: ffff88803d0a7800
> FS:  0000000000000000(0000) GS:ffff888126279000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055558bcbda38 CR3: 00000000403d8000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000003e4f
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   sfq_rehash net/sched/sch_sfq.c:598 [inline]
>   sfq_perturbation+0x205d/0x22d0 net/sched/sch_sfq.c:615
>   call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
>   expire_timers kernel/time/timer.c:1799 [inline]
>   __run_timers kernel/time/timer.c:2374 [inline]
>   __run_timer_base+0x6a3/0x9f0 kernel/time/timer.c:2386
>   run_timer_base kernel/time/timer.c:2395 [inline]
>   run_timer_softirq+0x103/0x170 kernel/time/timer.c:2406
>   handle_softirqs+0x1de/0x6d0 kernel/softirq.c:622
>   __do_softirq kernel/softirq.c:656 [inline]
>   run_ktimerd+0x69/0x100 kernel/softirq.c:1151
>   smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
>   kthread+0x388/0x470 kernel/kthread.c:436
>   ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>


I think the issue is that before commit 47e8dbb6e763 ("net/sched: do not 
reset queues in graft operations"),
dev_deactivate() reset the per-tx-queue of lower leaf qdiscs (including 
any sfq) before dev->qdisc was swapped.

After 47e8dbb6e763, dev_deactivate(dev, false) skips that reset. The 
leaf will be drained much later, inside __qdisc_destroy(leaf).
But the timer sfq_perturbation may be fired between 
rcu_assign_pointer(dev->qdisc, new) and __qdisc_destroy, and dev->qdisc 
already
points at the new root.

May be the simplest way is adding test_bit(__QDISC_STATE_DEACTIVATED, 
&sch->state) at the start of sfq_perturbation.

