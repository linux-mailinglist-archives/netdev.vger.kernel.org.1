Return-Path: <netdev+bounces-262450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBtLH2KSpGktkwUAu9opvQ
	(envelope-from <netdev+bounces-262450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 20:24:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D30B31D1485
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 20:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32892300B9E6
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 19:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DABC3112BD;
	Sun,  1 Mar 2026 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPFNlxPZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88F2E92D2
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772393055; cv=none; b=aSrk1Q+OOkGcLSu4A0cj+wHd53KBZmecSjow5Bjm7FnSJrmSrhSqUI+YLlB92vyHLwfOuep720hxZNAH+B/C7we6XVN2S0eBFIGP3PNlS2O7ljqryP2A5Qsg4B0Trkox45XOmosSfOxgSU3zRq2pEFlpa0inpio+G6MFZHMr7qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772393055; c=relaxed/simple;
	bh=5Z4kx/J5JbFJ7iMjvmctwY1eSfmHmHpsdSoeb58SehA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMq4m9hcXn4v+2hgW6T7IzjxiFp9nv6JyiHXWKcyBFrPENri1xWdO9BiC729dsWCp3quougdQ/Bynkf/WSwj2Y/z8q+2F757VsAw7IRmQx+kQ7yKwTmRAT+IyWtbnn+QHhmaA5CXDNXycGswY4kJJOIu33CB8n1nowrY218ZT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPFNlxPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F61CC116C6;
	Sun,  1 Mar 2026 19:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772393055;
	bh=5Z4kx/J5JbFJ7iMjvmctwY1eSfmHmHpsdSoeb58SehA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HPFNlxPZMnsfly3WrRZebY0m3y3pRKT3NTIKovjo5stuz+Kdk0+3wwyc1PbLCTWc0
	 pLH5CirquMiyZawgQdzOi4Dvszg4FFCMrHDhAdKFppo298oYg9yMichLtgbUF5nRcH
	 DXh3bShgh+vme8Qt9Z4w+cYKleRqD2JzjTMLsyvK1P+10p5vUStDRUCxtBEjU4ewm+
	 Rq1UKGgH/IGKoa1Lilj8GEcp7dSBtYEFOX24VzA/0RmEJvs2l9m9PVLTI7CAiHuSJh
	 PvtrwcwNcm12sgoSbXF+zfHz8MqdJW5pzgmKA+bJr8ov3EmHAQb7xCQbe+59H+5Vq6
	 ysyLF/FcC2khg==
Date: Sun, 1 Mar 2026 11:24:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Ido Schimmel
 <idosch@nvidia.com>
Subject: Re: [PATCH net-next] ipv6: add IPV6_CALL() helper
Message-ID: <20260301112413.1b6c785e@kernel.org>
In-Reply-To: <20260301162514.3347319-1-edumazet@google.com>
References: <20260301162514.3347319-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-262450-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D30B31D1485
X-Rspamd-Action: no action

On Sun,  1 Mar 2026 16:25:14 +0000 Eric Dumazet wrote:
> ipv6_stub use is racy, we should add READ_ONCE() and WRITE_ONCE(),
> even if this pointer can only change once.
> 
> Add IPV6_CALL() macro to factorize the READ_ONCE(), and perform
> direct calls when CONFIG_IPV6=y.

Some crashiness detected here, I think
pw-bot: cr

[ 1831.476440][ T4627] =============================
[ 1831.476614][ T4627] WARNING: suspicious RCU usage
[ 1831.476776][ T4627] 7.0.0-rc1-virtme #1 Not tainted
[ 1831.476955][ T4627] -----------------------------
[ 1831.477119][ T4627] net/ipv6/ip6_fib.c:111 suspicious rcu_dereference_protected() usage!
[ 1831.477338][ T4627] 
[ 1831.477338][ T4627] other info that might help us debug this:
[ 1831.477338][ T4627] 
[ 1831.477613][ T4627] 
[ 1831.477613][ T4627] rcu_scheduler_active = 2, debug_locks = 1
[ 1831.477831][ T4627] 1 lock held by ip/4627:
[ 1831.477975][ T4627]  #0: ffffffff950a1d28 (rtnl_mutex){+.+.}-{4:4}, at: rtm_new_nexthop+0x1a6/0x8c0
[ 1831.478234][ T4627] 
[ 1831.478234][ T4627] stack backtrace:
[ 1831.478423][ T4627] CPU: 2 UID: 0 PID: 4627 Comm: ip Not tainted 7.0.0-rc1-virtme #1 PREEMPT(full) 
[ 1831.478427][ T4627] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 1831.478429][ T4627] Call Trace:
[ 1831.478431][ T4627]  <TASK>
[ 1831.478433][ T4627]  dump_stack_lvl+0x6f/0xa0
[ 1831.478440][ T4627]  lockdep_rcu_suspicious.cold+0x4f/0xad
[ 1831.478445][ T4627]  fib6_update_sernum+0xfb/0x130
[ 1831.478450][ T4627]  nh_rt_cache_flush+0x8d/0x380
[ 1831.478454][ T4627]  replace_nexthop+0x347/0x6e0
[ 1831.478458][ T4627]  insert_nexthop+0x41e/0x7a0
[ 1831.478460][ T4627]  ? nexthop_create+0x307/0x770
[ 1831.478463][ T4627]  rtm_new_nexthop+0x3a0/0x8c0
[ 1831.478467][ T4627]  ? insert_nexthop+0x7a0/0x7a0
[ 1831.478468][ T4627]  ? lock_acquire.part.0+0xbc/0x260
[ 1831.478471][ T4627]  ? find_held_lock+0x2b/0x80
[ 1831.478478][ T4627]  ? lock_acquire.part.0+0xbc/0x260
[ 1831.478479][ T4627]  ? find_held_lock+0x2b/0x80
[ 1831.478485][ T4627]  ? find_held_lock+0x2b/0x80
[ 1831.478487][ T4627]  ? insert_nexthop+0x7a0/0x7a0
[ 1831.478489][ T4627]  ? __lock_release.isra.0+0x59/0x170
[ 1831.478492][ T4627]  ? insert_nexthop+0x7a0/0x7a0
[ 1831.478494][ T4627]  rtnetlink_rcv_msg+0x6fe/0xb90
[ 1831.478499][ T4627]  ? rtnl_fdb_dump+0x620/0x620
[ 1831.478501][ T4627]  ? __lock_acquire+0x577/0xc10
[ 1831.478511][ T4627]  ? lock_acquire.part.0+0xbc/0x260
[ 1831.478513][ T4627]  ? find_held_lock+0x2b/0x80
[ 1831.478516][ T4627]  netlink_rcv_skb+0x123/0x380
[ 1831.478519][ T4627]  ? rtnl_fdb_dump+0x620/0x620
[ 1831.478522][ T4627]  ? netlink_ack+0xce0/0xce0
[ 1831.478527][ T4627]  ? netlink_deliver_tap+0xc5/0x330
[ 1831.478529][ T4627]  ? netlink_deliver_tap+0x13f/0x330
[ 1831.478533][ T4627]  netlink_unicast+0x4a3/0x770
[ 1831.478536][ T4627]  ? netlink_attachskb+0x810/0x810
[ 1831.478537][ T4627]  ? __alloc_skb+0x4c4/0x5f0
[ 1831.478540][ T4627]  ? napi_skb_cache_get+0x7a0/0x7a0
[ 1831.478542][ T4627]  ? lock_acquire.part.0+0xbc/0x260
[ 1831.478544][ T4627]  ? __lock_acquire+0x577/0xc10
[ 1831.478547][ T4627]  netlink_sendmsg+0x735/0xc60
[ 1831.478550][ T4627]  ? netlink_unicast+0x770/0x770
[ 1831.478553][ T4627]  ? __might_fault+0x97/0x140
[ 1831.478559][ T4627]  ____sys_sendmsg+0x419/0x850
[ 1831.478561][ T4627]  ? copy_msghdr_from_user+0x270/0x430
[ 1831.478563][ T4627]  ? get_timestamp.constprop.0+0x390/0x390
[ 1831.478564][ T4627]  ? move_addr_to_kernel+0x40/0x40
[ 1831.478567][ T4627]  ? stack_depot_save_flags+0x30d/0x6e0
[ 1831.478571][ T4627]  ? rcu_read_lock_any_held+0x3c/0x90
[ 1831.478576][ T4627]  ___sys_sendmsg+0xfd/0x180
[ 1831.478578][ T4627]  ? __call_rcu_common.constprop.0+0xa6/0xa00
[ 1831.478581][ T4627]  ? copy_msghdr_from_user+0x430/0x430
[ 1831.478595][ T4627]  __sys_sendmsg+0x124/0x1c0
[ 1831.478597][ T4627]  ? __sys_sendmsg_sock+0x20/0x20
[ 1831.478599][ T4627]  ? lockdep_hardirqs_on+0x84/0x130
[ 1831.478603][ T4627]  ? __call_rcu_common.constprop.0+0x3bd/0xa00
[ 1831.478608][ T4627]  ? do_raw_spin_unlock+0x59/0x250
[ 1831.478610][ T4627]  ? rcu_is_watching+0x15/0xd0
[ 1831.478613][ T4627]  do_syscall_64+0x117/0xfc0
[ 1831.478615][ T4627]  ? exc_page_fault+0xaf/0xd0
[ 1831.478617][ T4627]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

