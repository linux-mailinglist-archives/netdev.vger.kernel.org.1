Return-Path: <netdev+bounces-258861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAr6BoMAk2lr0wEAu9opvQ
	(envelope-from <netdev+bounces-258861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 12:33:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD51143024
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 12:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7373930166F6
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB61B2BE644;
	Mon, 16 Feb 2026 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HW+VxM+K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uqzQ0Q47";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HW+VxM+K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uqzQ0Q47"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7235965
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771241588; cv=none; b=BIMEaNFAWuC3ONNHE74LtnAnnlW1isTVW9zAezYEQ8YPbbvLZt4oB3BVdleOaoqkhMQx2A/skpNrjO9zO8p8Ekkd1i2pn8XKoNxPMomp0aoRgPcGUZyaCw4oeFAOTbDQuGc4wort3hK4AVG+Mg0eZxrLKBfq0LwCL2PQ6lTZ5ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771241588; c=relaxed/simple;
	bh=a5Wo8XRvzXAdxGHUEvSQvS9KrapbDEEFafkgDqwhNF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n9l15QlCgTanNqiOaCbKkCwq7Z2oe4dsK5qTf/kQz/peqlVkYtob4qPFHXA9B4H2a91QKD9E7YgGzcEB5YxQeyKNNDUAD4YVJkdzgLFixyCZxvgq0cus1K5jt99l3TasTvgP+3SNM1Euj7wzaHG/k2dK94woR7nzwMikViktUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HW+VxM+K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uqzQ0Q47; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HW+VxM+K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uqzQ0Q47; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CCDC3E737;
	Mon, 16 Feb 2026 11:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771241584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYpI51Gn74KmwsfXFT+fe92WyC6hYD+NjTvW6SM4fkc=;
	b=HW+VxM+K8fzT6xVm8rlaN2Q9QmpY5QVQuiHPkGxxkzQY3Vzclpy1UXWX6IeM7ThCEilR6d
	ipZjMQ7qziWj/IBlpkYSyb8OgcXq1SCqw8oVqtKQK5W2SpBeqpiJzH5V6WTR/xGPwBpeYe
	qsIjsZk9HCtShFZI9hXdzeYuDbr7XB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771241584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYpI51Gn74KmwsfXFT+fe92WyC6hYD+NjTvW6SM4fkc=;
	b=uqzQ0Q473pbunpRp0lTFpgwPOKBLW7pMggbO853ECy7bHEsm7OsvuZbYuHEX84zQlKCOV4
	XMgNvoT9EnTLKEAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771241584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYpI51Gn74KmwsfXFT+fe92WyC6hYD+NjTvW6SM4fkc=;
	b=HW+VxM+K8fzT6xVm8rlaN2Q9QmpY5QVQuiHPkGxxkzQY3Vzclpy1UXWX6IeM7ThCEilR6d
	ipZjMQ7qziWj/IBlpkYSyb8OgcXq1SCqw8oVqtKQK5W2SpBeqpiJzH5V6WTR/xGPwBpeYe
	qsIjsZk9HCtShFZI9hXdzeYuDbr7XB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771241584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYpI51Gn74KmwsfXFT+fe92WyC6hYD+NjTvW6SM4fkc=;
	b=uqzQ0Q473pbunpRp0lTFpgwPOKBLW7pMggbO853ECy7bHEsm7OsvuZbYuHEX84zQlKCOV4
	XMgNvoT9EnTLKEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 619C43EA62;
	Mon, 16 Feb 2026 11:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lbzME28Ak2lNeQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 16 Feb 2026 11:33:03 +0000
Message-ID: <ae86f151-0480-45f2-870e-7378e1607058@suse.de>
Date: Mon, 16 Feb 2026 12:32:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] possible deadlock in inet6_getname
To: syzbot <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
References: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <698f15e6.a70a0220.2c38d7.00c1.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim,googlegroups.com:email,goo.gl:url,syzkaller.appspot.com:url,appspotmail.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258861-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev,5efae91f60932839f0a5];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 6FD51143024
X-Rspamd-Action: no action

On 2/13/26 1:15 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    57be33f85e36 nfc: nxp-nci: remove interrupt trigger type
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12f2165a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d
> dashboard link: https://syzkaller.appspot.com/bug?extid=5efae91f60932839f0a5
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1584065a580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f2165a580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/77aaa9b6c846/disk-57be33f8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2617a56e7118/vmlinux-57be33f8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4fd173f33f5f/bzImage-57be33f8.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com
> 
> ============================================
> WARNING: possible recursive locking detected
> syzkaller #0 Not tainted
> --------------------------------------------
> kworker/u8:6/2985 is trying to acquire lock:
> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
> 
> but task is already holding lock:
> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
> ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sock_set_cork+0x2c/0x2e0 net/ipv4/tcp.c:3694
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(k-sk_lock-AF_INET6);
>    lock(k-sk_lock-AF_INET6);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
> 4 locks held by kworker/u8:6/2985:
>   #0: ffff888033131948 ((wq_completion)krds_cp_wq#1/0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3232 [inline]
>   #0: ffff888033131948 ((wq_completion)krds_cp_wq#1/0){+.+.}-{0:0}, at: process_scheduled_works+0x9d4/0x17a0 kernel/workqueue.c:3340
>   #1: ffffc9000b8a7bc0 ((work_completion)(&(&cp->cp_send_w)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3233 [inline]
>   #1: ffffc9000b8a7bc0 ((work_completion)(&(&cp->cp_send_w)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa0f/0x17a0 kernel/workqueue.c:3340
>   #2: ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
>   #2: ffff88807a07aa20 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_sock_set_cork+0x2c/0x2e0 net/ipv4/tcp.c:3694
>   #3: ffff88807a07abc8 (k-clock-AF_INET6){++.-}-{3:3}, at: rds_tcp_data_ready+0x113/0x950 net/rds/tcp_recv.c:320
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 2985 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
> Workqueue: krds_cp_wq#1/0 rds_send_worker
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>   print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
>   check_deadlock kernel/locking/lockdep.c:3093 [inline]
>   validate_chain kernel/locking/lockdep.c:3895 [inline]
>   __lock_acquire+0x253f/0x2cf0 kernel/locking/lockdep.c:5237
>   lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
>   lock_sock_nested+0x48/0x100 net/core/sock.c:3780
>   lock_sock include/net/sock.h:1709 [inline]
>   inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
>   rds_tcp_get_peer_sport net/rds/tcp_listen.c:70 [inline]
>   rds_tcp_conn_slots_available+0x288/0x470 net/rds/tcp_listen.c:149
>   rds_recv_hs_exthdrs+0x60f/0x7c0 net/rds/recv.c:265
>   rds_recv_incoming+0x9f6/0x12d0 net/rds/recv.c:389
>   rds_tcp_data_recv+0x7f1/0xa40 net/rds/tcp_recv.c:243
>   __tcp_read_sock+0x196/0x970 net/ipv4/tcp.c:1702
>   rds_tcp_read_sock net/rds/tcp_recv.c:277 [inline]
>   rds_tcp_data_ready+0x369/0x950 net/rds/tcp_recv.c:331
>   tcp_rcv_established+0x19e9/0x2670 net/ipv4/tcp_input.c:6675
>   tcp_v6_do_rcv+0x8eb/0x1ba0 net/ipv6/tcp_ipv6.c:1609
>   sk_backlog_rcv include/net/sock.h:1185 [inline]
>   __release_sock+0x1b8/0x3a0 net/core/sock.c:3213
>   release_sock+0x5f/0x1f0 net/core/sock.c:3795
>   rds_send_xmit+0x207e/0x28d0 net/rds/send.c:480
>   rds_send_worker+0x7d/0x2e0 net/rds/threads.c:200
>   process_one_work kernel/workqueue.c:3257 [inline]
>   process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
>   worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
>   kthread+0x726/0x8b0 kernel/kthread.c:463
>   ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>   </TASK>
> BUG: sleeping function called from invalid context at net/core/sock.c:3782
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2985, name: kworker/u8:6
> preempt_count: 201, expected: 0
> RCU nest depth: 0, expected: 0
> INFO: lockdep is turned off.
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 1 UID: 0 PID: 2985 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
> Workqueue: krds_cp_wq#1/0 rds_send_worker
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>   __might_resched+0x378/0x4d0 kernel/sched/core.c:8829
>   lock_sock_nested+0x5d/0x100 net/core/sock.c:3782
>   lock_sock include/net/sock.h:1709 [inline]
>   inet6_getname+0x15d/0x650 net/ipv6/af_inet6.c:533
>   rds_tcp_get_peer_sport net/rds/tcp_listen.c:70 [inline]
>   rds_tcp_conn_slots_available+0x288/0x470 net/rds/tcp_listen.c:149
>   rds_recv_hs_exthdrs+0x60f/0x7c0 net/rds/recv.c:265
>   rds_recv_incoming+0x9f6/0x12d0 net/rds/recv.c:389
>   rds_tcp_data_recv+0x7f1/0xa40 net/rds/tcp_recv.c:243
>   __tcp_read_sock+0x196/0x970 net/ipv4/tcp.c:1702
>   rds_tcp_read_sock net/rds/tcp_recv.c:277 [inline]
>   rds_tcp_data_ready+0x369/0x950 net/rds/tcp_recv.c:331
>   tcp_rcv_established+0x19e9/0x2670 net/ipv4/tcp_input.c:6675
>   tcp_v6_do_rcv+0x8eb/0x1ba0 net/ipv6/tcp_ipv6.c:1609
>   sk_backlog_rcv include/net/sock.h:1185 [inline]
>   __release_sock+0x1b8/0x3a0 net/core/sock.c:3213
>   release_sock+0x5f/0x1f0 net/core/sock.c:3795
>   rds_send_xmit+0x207e/0x28d0 net/rds/send.c:480
>   rds_send_worker+0x7d/0x2e0 net/rds/threads.c:200
>   process_one_work kernel/workqueue.c:3257 [inline]
>   process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
>   worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
>   kthread+0x726/0x8b0 kernel/kthread.c:463
>   ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>   </TASK>
> BUG: scheduling while atomic: kworker/u8:6/2985/0x00000202
> INFO: lockdep is turned off.
> Modules linked in:
> Preemption disabled at:
> [<0000000000000000>] 0x0
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
> 

#syz test

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 6fb5c928b8fd..a36e5dfd6c66 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -59,30 +59,12 @@ void rds_tcp_keepalive(struct socket *sock)
  static int
  rds_tcp_get_peer_sport(struct socket *sock)
  {
-	union {
-		struct sockaddr_storage storage;
-		struct sockaddr addr;
-		struct sockaddr_in sin;
-		struct sockaddr_in6 sin6;
-	} saddr;
-	int sport;
-
-	if (kernel_getpeername(sock, &saddr.addr) >= 0) {
-		switch (saddr.addr.sa_family) {
-		case AF_INET:
-			sport = ntohs(saddr.sin.sin_port);
-			break;
-		case AF_INET6:
-			sport = ntohs(saddr.sin6.sin6_port);
-			break;
-		default:
-			sport = -1;
-		}
-	} else {
-		sport = -1;
-	}
+	struct sock *sk = sock->sk;
+
+	if (!sk)
+		return -1;

-	return sport;
+	return ntohs(inet_sk(sk)->inet_dport);
  }

  /* rds_tcp_accept_one_path(): if accepting on cp_index > 0, make sure the

