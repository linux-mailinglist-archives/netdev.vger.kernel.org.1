Return-Path: <netdev+bounces-258688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cqBiOU0MkGm0VgEAu9opvQ
	(envelope-from <netdev+bounces-258688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 06:46:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D9013B27E
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 06:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3578301E3D9
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 05:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711C29E116;
	Sat, 14 Feb 2026 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="veQG5rFD"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A342E26299;
	Sat, 14 Feb 2026 05:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771048011; cv=none; b=KQPH7zMNot8GKWJgjLyCyHOelK4VpKSUDS1ojmuh8mfBBJgq6M41dBunfnqS62dIq68Uj9qixO6H0DDBRzA6COKpi60VDGEbF8QM0MGqVXOp9LypZqgo1qJhf8O2M2jOfg9y988Mm0L+z6mJ7Chd3MFpwhWaVP4wiLxzTTHpkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771048011; c=relaxed/simple;
	bh=R6SoNHInX5wVqkiSwOYQOw5+bJag4UnxMZYsGKpOxz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdi83L8ErY3rPBM4NIgzkdsMhjTsMvMQaRZLHt00Y9DsLoU8zwuMLK++lg3QnVSZCH0nscXBWDSKc5clN2yndggthG00zpGi71J4IhkzWFGZccm0y4GPEFByYjJuz1XYFjRMi08LfHtYNElzwE28MJ1LQOH5VkaAZQPQZBk7yXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=veQG5rFD; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 14 Feb 2026 13:46:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771048006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkpmoIOGR0LoIVCMXuRVy/GeG9Ng1mTwRyKUW5bZ824=;
	b=veQG5rFDooRmuLFlQmP+9/VrsjALIsNTvf3cz84Iz2OPE05/a/UA25sVrv8QkXXlNJffdM
	9WOEW1AGRpPoxqxCsvAm66aJbWsllwi4fbhCKUkivher6fWYL/U+6mJDz/6dyyXMj7tnz9
	qOt0r1nP7ZAS93kVR9UaX2O70ZfAnac=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: syzbot <syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	john.fastabend@gmail.com, jakub@cloudflare.com
Subject: Re: [syzbot] [net?] WARNING in inet_sock_destruct (6)
Message-ID: <pacq5eqmgrceli6anhy2fiz3zhen4ox3hir7z6tcdnc4ghca5d@yr7zb5lauovb>
References: <698f84c6.a70a0220.2c38d7.00cb.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698f84c6.a70a0220.2c38d7.00cb.GAE@google.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=22c34f040954bbd1];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-258688-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email,linux.dev:dkim,googlegroups.com:email];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,vger.kernel.org,redhat.com,googlegroups.com,gmail.com,cloudflare.com];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[goo.gl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 38D9013B27E
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:08:38PM +0800, syzbot wrote:




I identified this issue and submitted a fix before this syzbot report:
https://lore.kernel.org/bpf/20250508062423.51978-1-jiayuan.chen@linux.dev/
Unfortunately the patch was not accepted at the time.

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    192c0159402e Merge tag 'powerpc-7.0-1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b8cc02580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=22c34f040954bbd1
> dashboard link: https://syzkaller.appspot.com/bug?extid=5b3b7e51dda1be027b7a
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1316a15a580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14140ffa580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-192c0159.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d1c911c7a5b8/vmlinux-192c0159.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f9d4cfbb614a/bzImage-192c0159.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> sk->sk_forward_alloc
> WARNING: net/ipv4/af_inet.c:157 at inet_sock_destruct+0x653/0x800 net/ipv4/af_inet.c:157, CPU#0: ksoftirqd/0/15
> Modules linked in:
> CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:inet_sock_destruct+0x653/0x800 net/ipv4/af_inet.c:157
> Code: b4 4f ff e9 06 fd ff ff e8 aa 25 10 f8 90 0f 0b 90 e9 35 fe ff ff e8 9c 25 10 f8 90 0f 0b 90 e9 c5 fe ff ff e8 8e 25 10 f8 90 <0f> 0b 90 e9 04 ff ff ff e8 80 25 10 f8 90 0f 0b 90 e9 65 fe ff ff
> RSP: 0018:ffffc90000127bb0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff888100796300 RCX: ffffffff89f71e97
> RDX: ffff88801dec4900 RSI: ffffffff89f71f92 RDI: ffff88801dec4900
> RBP: 0000000000000090 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000090 R11: 00000000000075f9 R12: ffff888100796300
> R13: ffff888100796390 R14: ffffffff81ed1d7d R15: 0000000000000004
> FS:  0000000000000000(0000) GS:ffff8880d65b3000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe39b75ff4 CR3: 000000000e396000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  __sk_destruct+0x85/0xbb0 net/core/sock.c:2350
>  rcu_do_batch kernel/rcu/tree.c:2617 [inline]
>  rcu_core+0x5a2/0x10d0 kernel/rcu/tree.c:2869
>  handle_softirqs+0x1ea/0x910 kernel/softirq.c:622
>  run_ksoftirqd kernel/softirq.c:1063 [inline]
>  run_ksoftirqd+0x38/0x60 kernel/softirq.c:1055
>  smpboot_thread_fn+0x3d3/0xaa0 kernel/smpboot.c:160
>  kthread+0x370/0x450 kernel/kthread.c:467
>  ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

