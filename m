Return-Path: <netdev+bounces-298159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l8kzCpDGKmpIwwMAu9opvQ
	(envelope-from <netdev+bounces-298159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:30:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60051672B90
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:30:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ioy65vUf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298159-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298159-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 482C831AE4AF
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC882F1FE3;
	Thu, 11 Jun 2026 14:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFCC2DB78C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:30:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188208; cv=none; b=CCWX5JG67fM7Nm9rhFOW5mnXpFeXvpXkdq97NoK12ZXvcPPxQRhi9eHvW6ESBPCEzmdxwjwh+9IYMwtUe+pXGrtTtoAkngZVrznZKnEmSndgrpb3L3CgEroKeocMUKgbWvdacc6zmctxFvFqFDhZq0ZD2Wx1A9LYMCQB4flyLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188208; c=relaxed/simple;
	bh=4qaMIJsHnpCRiXHS92pZ1RwRQ3Q5rw7Vfcsqtlez6uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6lJN9eDZH0xhk+gkJ91X2FcJTtWmmvcMgZ15bGDy+4QqtMirqAXmjiuW8oDymTIx2YHx6agJ6tzM26/aQhrE5aFFXBwpPzvBSHcdvPQfpFNHIbIlfr9nN4q+DZYKK+ZOQMKdyVQQO7ddBqkSLIP+q4PK+XjY673+lDN5gMEVb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ioy65vUf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B0A1F00898;
	Thu, 11 Jun 2026 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781188207;
	bh=39SdH+Xl9xCCWeX7T7khXby4+WJQ0u2LK0gRNnyppk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ioy65vUfYtJCsrYWclFPHAgjGNQ+Uv4I8aELFh6X+fQ/hthdw9HRx3/9AQiLkWk5x
	 oMiNuxewWzNKNJqodLveRvA1dpE2jnJlJRceIVyC2mH7o9ONLE7IFJVhMgvv6f9FF7
	 +GjzOac6CD1GsUhf2MwxSavn///faIwbfVyPBDxSOB9DR66mggVkAaIaFtZRl2s4Hd
	 hTCLJRUdtkP0mzUnhErpzDtRjLWaTfW2efl341QTdAFYXLv/9q+5z/ZarQfqKceGOM
	 gjSLueXWbUebvCQiwSg2sy48IDaOfInuO6/EgcyOTV/Eucu9Ceqr4whKNRshiOyVxp
	 D/3YCyFjJa7CQ==
Message-ID: <425bcbf4-4a6e-43f2-8997-6f9f1d7c2d10@kernel.org>
Date: Thu, 11 Jun 2026 08:30:06 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 1/2] ipv4: fib: Don't dump dying fib_info in
 fib_leaf_notify().
To: Kuniyuki Iwashima <kuniyu@google.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Amit Cohen <amcohen@nvidia.com>,
 Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, syzbot+cb2aa2390ac024e25f5c@syzkaller.appspotmail.com
References: <20260610061744.2030996-1-kuniyu@google.com>
 <20260610061744.2030996-2-kuniyu@google.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260610061744.2030996-2-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298159-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:amcohen@nvidia.com,m:jiri@resnulli.us,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:syzbot+cb2aa2390ac024e25f5c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,resnulli.us,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cb2aa2390ac024e25f5c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60051672B90

On 6/10/26 12:17 AM, Kuniyuki Iwashima wrote:
> syzbot reported use-after-free in nsim_fib4_prepare_event(). [0]
> 
> The problem is that the following functions call fib_info_hold() /
> refcount_inc() while dumping fib_info under RCU, which is unsafe.
> 
>   * mlxsw_sp_router_fib4_event()
>   * rocker_router_fib_event()
>   * nsim_fib4_prepare_event()
> 
> refcount_inc_not_zero() must be used, but it would be too late
> there.
> 
> Let's guarantee the lifetime of fib_info in fib_leaf_notify().
> 
> Note that IPv6 does not need the corresponding change since
> fib6_table_dump() holds fib6_table.tb6_lock.
> 
> [0]:
> refcount_t: addition on 0; use-after-free.
> WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25, CPU#0: kworker/u8:15/3420
> Modules linked in:
> CPU: 0 UID: 0 PID: 3420 Comm: kworker/u8:15 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> Workqueue: netns cleanup_net
> RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
> Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 1b f1 22 fd 48 8d 3d 84 cb f1 0a 67 48 0f b9 3a eb 4a e8 08 f1 22 fd 48 8d 3d 81 cb f1 0a <67> 48 0f b9 3a eb 37 e8 f5 f0 22 fd 48 8d 3d 7e cb f1 0a 67 48 0f
> RSP: 0018:ffffc9000f2c7270 EFLAGS: 00010293
> RAX: ffffffff84a18858 RBX: 0000000000000002 RCX: ffff888032ff9ec0
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8f9353e0
> RBP: 0000000000000000 R08: ffff888032ff9ec0 R09: 0000000000000005
> R10: 0000000000000100 R11: 0000000000000004 R12: ffff8880570cc000
> R13: dffffc0000000000 R14: ffff88802b40563c R15: ffff8880570cc000
> FS:  0000000000000000(0000) GS:ffff888126173000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb1f4d5d000 CR3: 000000006072a000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __refcount_add include/linux/refcount.h:-1 [inline]
>  __refcount_inc include/linux/refcount.h:366 [inline]
>  refcount_inc include/linux/refcount.h:383 [inline]
>  fib_info_hold include/net/ip_fib.h:629 [inline]
>  nsim_fib4_prepare_event drivers/net/netdevsim/fib.c:930 [inline]
>  nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1000 [inline]
>  nsim_fib_event_nb+0x1055/0x1240 drivers/net/netdevsim/fib.c:1043
>  call_fib_notifier+0x45/0x80 net/core/fib_notifier.c:25
>  call_fib_entry_notifier net/ipv4/fib_trie.c:90 [inline]
>  fib_leaf_notify net/ipv4/fib_trie.c:2176 [inline]
>  fib_table_notify net/ipv4/fib_trie.c:2194 [inline]
>  fib_notify+0x36b/0x5e0 net/ipv4/fib_trie.c:2217
>  fib_net_dump net/core/fib_notifier.c:70 [inline]
>  register_fib_notifier+0x184/0x360 net/core/fib_notifier.c:108
>  nsim_fib_create+0x85d/0x9f0 drivers/net/netdevsim/fib.c:1596
>  nsim_dev_reload_create drivers/net/netdevsim/dev.c:1604 [inline]
>  nsim_dev_reload_up+0x374/0x7c0 drivers/net/netdevsim/dev.c:1058
>  devlink_reload+0x501/0x8d0 net/devlink/dev.c:475
>  devlink_pernet_pre_exit+0x1ff/0x420 net/devlink/core.c:558
>  ops_pre_exit_list net/core/net_namespace.c:161 [inline]
>  ops_undo_list+0x187/0x940 net/core/net_namespace.c:234
>  cleanup_net+0x56e/0x800 net/core/net_namespace.c:702
>  process_one_work kernel/workqueue.c:3314 [inline]
>  process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3397
>  worker_thread+0xa53/0xfc0 kernel/workqueue.c:3478
>  kthread+0x388/0x470 kernel/kthread.c:436
>  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> Fixes: 0ae3eb7b4611 ("netdevsim: fib: Perform the route programming in a non-atomic context")
> Fixes: c3852ef7f2f8 ("ipv4: fib: Replay events when registering FIB notifier")
> Reported-by: syzbot+cb2aa2390ac024e25f5c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a290011.39669fcc.33b062.00b1.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/ip_fib.h | 5 +++++
>  net/ipv4/fib_trie.c  | 4 ++++
>  2 files changed, 9 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



