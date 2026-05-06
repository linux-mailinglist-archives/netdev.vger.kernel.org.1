Return-Path: <netdev+bounces-284947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MfMHoBs+2miawMAu9opvQ
	(envelope-from <netdev+bounces-284947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:29:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E57214DE1E2
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E9AD3005EAD
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AE13FE363;
	Wed,  6 May 2026 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/NwxZJz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D482D7DE9;
	Wed,  6 May 2026 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084987; cv=none; b=k+YUzxmMuBoOIQ2HIXspOu+VIvQCp8T1x22vrsP/9k5D9wpnztAA6sn/gCh2mV8hFFwJ7UemRBPwQ4rRdJ0hsmWtC5V6IYGEUIn1ApQvk/rzn+ELI5mW8C23P2+VaQjCzS8+u8HVc4Hu0kSUxIDHrwTEjc31ckG2nPXlPiGEh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084987; c=relaxed/simple;
	bh=KEe+JqSrfEsaB9UFcPMwnZ1iqiFBaRF+JFM1eZblrew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OVwIIzWz9m04o5XxXSwFNh9Xv+RqiV+uM3bTQqsd9c2XhV08kzPEkvRf4wQTP9oh4/PoW+2tCGUSVMDSCOKP4oLPtH0+laun9/wZIdnQr+UL2kQEEgRGdnr9mVl0z+HmjWtj28Z+VTq/VBWyf/pI9dHahqTBLAU/oyoVpwyhxqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/NwxZJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6E3C2BCB0;
	Wed,  6 May 2026 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778084986;
	bh=KEe+JqSrfEsaB9UFcPMwnZ1iqiFBaRF+JFM1eZblrew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=I/NwxZJzB57YK+nhQMlPdHeXES+Gthxkh1V7282yJtp2H1wJ2daegp2cFYRwCKDt+
	 +m1h3HuYGDrZtkHx2zafe/Z27xUBSzw/1aLqVc8pi93lMLibALJEQLgnayUOYgPocr
	 hc1GMWDwNUu7lvs+3zefmrxTXAO8oI9i+TXZY2tstiwGtr8oGiJkKUmtL+JXovsug9
	 9+ofhW8jooEBxCLAGBAf3XE3c5avT/bQi17QnA7/ReyKtWlNJFYt/NTAdTtYM1uf1B
	 vi9owbPyAhjdnTtioAFuhYLx6QRizS3crsx2f9ZYP/GRukQIXdF/7HXnBLpwCm3pEG
	 o6M0LHk6tCYBw==
From: Thomas Gleixner <tglx@kernel.org>
To: syzbot <syzbot+ae231e0552fa77b26ea1@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 syzkaller-bugs@googlegroups.com
Cc: bridge@lists.linux.dev, Nikolay Aleksandrov <razor@blackwall.org>, Ido
 Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Subject: Re: [syzbot] [kernel?] WARNING: ODEBUG bug in smpboot_thread_fn
In-Reply-To: <69f88fc0.050a0220.3460d5.0004.GAE@google.com>
References: <69f88fc0.050a0220.3460d5.0004.GAE@google.com>
Date: Wed, 06 May 2026 18:29:43 +0200
Message-ID: <87qznowlfs.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E57214DE1E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f2e8ebfec4636d32];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-284947-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,storage.googleapis.com:url,syzkaller.appspot.com:url];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev,ae231e0552fa77b26ea1];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]

On Mon, May 04 2026 at 05:23, syzbot wrote:

Cc'ed network/bridge people as that's clearly in their realm.

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6d35786de281 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=126bf21f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f2e8ebfec4636d32
> dashboard link: https://syzkaller.appspot.com/bug?extid=ae231e0552fa77b26ea1
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b3ab34c4c807/disk-6d35786d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/03f465478178/vmlinux-6d35786d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/29d261604425/bzImage-6d35786d.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ae231e0552fa77b26ea1@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> ODEBUG: free active (active state 0) object: ffff888033a47278 object type: timer_list hint: br_ip6_multicast_port_query_expired+0x0/0x380 net/bridge/br_multicast.c:-1

                                                                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
An object which contains an active timer is RCU freed....

> WARNING: lib/debugobjects.c:632 at debug_print_object lib/debugobjects.c:629 [inline], CPU#1: rcuc/1/28
> WARNING: lib/debugobjects.c:632 at __debug_check_no_obj_freed lib/debugobjects.c:1116 [inline], CPU#1: rcuc/1/28
> WARNING: lib/debugobjects.c:632 at debug_check_no_obj_freed+0x405/0x550 lib/debugobjects.c:1146, CPU#1: rcuc/1/28
> Modules linked in:
> CPU: 1 UID: 0 PID: 28 Comm: rcuc/1 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> RIP: 0010:debug_print_object lib/debugobjects.c:629 [inline]
> RIP: 0010:__debug_check_no_obj_freed lib/debugobjects.c:1116 [inline]
> RIP: 0010:debug_check_no_obj_freed+0x44a/0x550 lib/debugobjects.c:1146
> Code: 89 44 24 20 e8 27 81 7f fd 48 8b 44 24 20 4c 8b 4d 00 4c 89 ef 48 c7 c6 a0 53 a7 8b 48 c7 c2 20 59 a7 8b 8b 0c 24 4d 89 f8 50 <67> 48 0f b9 3a 48 83 c4 08 4c 8b 6c 24 18 48 b9 00 00 00 00 00 fc
> RSP: 0018:ffffc90000a2fa90 EFLAGS: 00010246
> RAX: ffffffff89f32240 RBX: ffffffff99a8edc0 RCX: 0000000000000000
> RDX: ffffffff8ba75920 RSI: ffffffff8ba753a0 RDI: ffffffff8f933740
> RBP: ffffffff8b4f5380 R08: ffff888033a47278 R09: ffffffff8b4f6700
> R10: dffffc0000000000 R11: ffffffff81b0c180 R12: ffff888033a47400
> R13: ffffffff8f933740 R14: ffff888033a47000 R15: ffff888033a47278
> FS:  0000000000000000(0000) GS:ffff888126279000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb873a4da08 CR3: 000000004cc78000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  slab_free_hook mm/slub.c:2620 [inline]
>  slab_free mm/slub.c:6250 [inline]
>  kfree+0x13e/0x6c0 mm/slub.c:6565
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x228/0x560 lib/kobject.c:737
>  rcu_do_batch kernel/rcu/tree.c:2617 [inline]
>  rcu_core kernel/rcu/tree.c:2869 [inline]
>  rcu_cpu_kthread+0x99e/0x1470 kernel/rcu/tree.c:2957
>  smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
>  kthread+0x388/0x470 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>

