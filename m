Return-Path: <netdev+bounces-269467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAPbEekIvGldrgIAu9opvQ
	(envelope-from <netdev+bounces-269467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:32:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ADC2CCDDE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75BC230B3D4C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947EF371049;
	Thu, 19 Mar 2026 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMpKqYNv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720CA371040
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930539; cv=none; b=i3se46h6qb74xg3i7/7CxTTHl3K1AR9yZ39/D0CGCUHfpwuIZDL3jqr4o7UFJi5UuSTgjmQFibKvZ8gzuCYZuC3FvG/lCpQ+PCs79GnbyXL6NxBulVdXN8ThHaSod0I1U7NjpIJAv+NXNUEAIPJZTyXeyotzIF+ikkVPcafvQzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930539; c=relaxed/simple;
	bh=hYyBhvKmaPN7jyGxIieVw4UpTD4yDaKJNhTU611pXM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kugJ8AFoJ1VR0w52Cl8aFG4kbCTGD5JdOevqgCxwBXNZPue88Jstbn6N71OOIOAmJ0sRb96U2X4B6q/xSxkrz4xne+w7kSEbJM5GjCz2tJZdbKvdQDuqP8wIrYQYistLKfnHe5EWyMmU5trUFVm9UuH+PJPpL3z/UxZ6Bv8J/mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMpKqYNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC36C19424;
	Thu, 19 Mar 2026 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773930539;
	bh=hYyBhvKmaPN7jyGxIieVw4UpTD4yDaKJNhTU611pXM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMpKqYNvFi6N/Hpo0aN6ZZNuFJgyAmZ5TVpjb4Km5zvvLT9et21ETmRb82fpkBYOd
	 GMF7vsRYoHL2bUDqwn1uK47j9t/uw9KgPHssOQ8JylZu/ZbfYdft9gSJ7lpKzM/+U3
	 ZzleTakPN3bh6d+dKYRYRFtgxhx7FVqtT6mRfqUHuauUi048On4moBkDX2aGgZdkcs
	 y36wLbHgULnV5zi5jT3SGz/TgNTKn2Vcjtn8Y3eaiBezIcvoQwPob2iZfiAcUYI5hZ
	 qhgKBh3ik6C6A3Nkbl5BQbNCnZftys4BFwAaHW9JkJCV3gDAARoeLRIahwxgU3Z5du
	 yDJclrUs3Wm0Q==
Date: Thu, 19 Mar 2026 07:28:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Kui-Feng Lee <thinker.li@gmail.com>, Xin Long
 <lucien.xin@gmail.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v5 net 0/3] ipv6: Fix two GC issues with permanent
 routes.
Message-ID: <20260319072857.4f96d143@kernel.org>
In-Reply-To: <20260319041427.1528743-1-kuniyu@google.com>
References: <20260319041427.1528743-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269467-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.873];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0ADC2CCDDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 04:13:49 +0000 Kuniyuki Iwashima wrote:
> Patch 1 fixes the unbounded growth of tb6_gc_hlist due to
> permanent routes whose exception routes have all expired.
> 
> Patch 2 fixes an issue where exception routes tied to
> permanent routes are not properly aged.
> 
> Patch 3 is a selftest for the issue fixed by Patch 2.

Hitting a RCU warning with this:

[ 1246.404735][T26812] =============================
[ 1246.404892][T26812] WARNING: suspicious RCU usage
[ 1246.405029][T26812] 7.0.0-rc3-virtme #1 Not tainted
[ 1246.405170][T26812] -----------------------------
[ 1246.405302][T26812] ./include/net/neighbour.h:312 suspicious rcu_dereference_check() usage!
[ 1246.405498][T26812] 
[ 1246.405498][T26812] other info that might help us debug this:
[ 1246.405498][T26812] 
[ 1246.405786][T26812] 
[ 1246.405786][T26812] rcu_scheduler_active = 2, debug_locks = 1
[ 1246.405988][T26812] 3 locks held by ip/26812:
[ 1246.406124][T26812]  #0: ff11000015e71a30 (&tb->tb6_lock){+.-.}-{3:3}, at: ip6_route_add+0x95/0x160
[ 1246.406587][T26812]  #1: ffffffffbc58c900 (rcu_read_lock_bh){....}-{1:3}, at: fib6_nh_age_exceptions.part.0+0x24/0x200
[ 1246.406873][T26812]  #2: ffffffffbcdafbd8 (rt6_exception_lock){+.-.}-{3:3}, at: fib6_nh_age_exceptions.part.0+0x66/0x200
[ 1246.407143][T26812] 
[ 1246.407143][T26812] stack backtrace:
[ 1246.407315][T26812] CPU: 3 UID: 0 PID: 26812 Comm: ip Not tainted 7.0.0-rc3-virtme #1 PREEMPT(full) 
[ 1246.407318][T26812] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 1246.407319][T26812] Call Trace:
[ 1246.407321][T26812]  <TASK>
[ 1246.407322][T26812]  dump_stack_lvl+0x6f/0xa0
[ 1246.407328][T26812]  lockdep_rcu_suspicious.cold+0x4f/0xad
[ 1246.407334][T26812]  ___neigh_lookup_noref.constprop.0+0x4d0/0x8e0
[ 1246.407339][T26812]  rt6_age_examine_exception+0x209/0x510
[ 1246.407343][T26812]  ? __ip6_del_rt+0x160/0x160
[ 1246.407346][T26812]  ? fib6_nh_get_excptn_bucket+0x6e/0x150
[ 1246.407348][T26812]  fib6_nh_age_exceptions.part.0+0xce/0x200
[ 1246.407352][T26812]  rt6_age_exceptions+0xff/0x150
[ 1246.407355][T26812]  ? rt6_flush_exceptions+0x1a0/0x1a0
[ 1246.407357][T26812]  ? rcu_is_watching+0x15/0xd0
[ 1246.407361][T26812]  ? rcu_is_watching+0x15/0xd0
[ 1246.407363][T26812]  fib6_age_exceptions+0xc5/0x250
[ 1246.407366][T26812]  fib6_add_rt2node+0x25c6/0x3f90
[ 1246.407368][T26812]  ? pcpu_alloc_noprof+0x635/0xa60
[ 1246.407376][T26812]  ? fib6_age_exceptions+0x250/0x250
[ 1246.407379][T26812]  ? fib6_add_1.constprop.0+0x512/0x1620
[ 1246.407385][T26812]  ? fib6_add+0x36a/0xe40
[ 1246.407386][T26812]  fib6_add+0x36a/0xe40
[ 1246.407389][T26812]  ? lock_acquire.part.0+0xbc/0x260
[ 1246.407392][T26812]  ? fib6_add_rt2node+0x3f90/0x3f90
[ 1246.407398][T26812]  ip6_route_add+0xa7/0x160
[ 1246.407400][T26812]  ? ip6_route_multipath_add+0x13a0/0x13a0
[ 1246.407402][T26812]  inet6_rtm_newroute+0x10a/0x120
[ 1246.407404][T26812]  ? ip6_route_multipath_add+0x13a0/0x13a0
[ 1246.407406][T26812]  ? lock_acquire.part.0+0xbc/0x260
[ 1246.407407][T26812]  ? find_held_lock+0x2b/0x80
[ 1246.407415][T26812]  ? __lock_release.isra.0+0x59/0x170
[ 1246.407418][T26812]  ? rtnetlink_rcv_msg+0x6dc/0xb90
[ 1246.407422][T26812]  ? ip6_route_multipath_add+0x13a0/0x13a0
[ 1246.407424][T26812]  rtnetlink_rcv_msg+0x6fe/0xb90
[ 1246.407427][T26812]  ? rtnl_fdb_dump+0x620/0x620
[ 1246.407429][T26812]  ? __lock_acquire+0x577/0xc10
[ 1246.407433][T26812]  ? lock_acquire.part.0+0xbc/0x260
[ 1246.407434][T26812]  ? find_held_lock+0x2b/0x80
[ 1246.407438][T26812]  netlink_rcv_skb+0x123/0x380
[ 1246.407441][T26812]  ? rtnl_fdb_dump+0x620/0x620
[ 1246.407444][T26812]  ? netlink_ack+0xce0/0xce0
[ 1246.407450][T26812]  ? netlink_deliver_tap+0xc5/0x330
[ 1246.407451][T26812]  ? netlink_deliver_tap+0x13f/0x330
[ 1246.407455][T26812]  netlink_unicast+0x4a3/0x770
[ 1246.407458][T26812]  ? netlink_attachskb+0x810/0x810
[ 1246.407460][T26812]  ? __alloc_skb+0x4c4/0x5f0
[ 1246.407463][T26812]  ? napi_skb_cache_get+0x7a0/0x7a0
[ 1246.407465][T26812]  ? lock_acquire.part.0+0xbc/0x260
[ 1246.407467][T26812]  ? __lock_acquire+0x577/0xc10
[ 1246.407470][T26812]  netlink_sendmsg+0x735/0xc60
[ 1246.407473][T26812]  ? netlink_unicast+0x770/0x770
[ 1246.407477][T26812]  ? __might_fault+0x97/0x140
[ 1246.407482][T26812]  ____sys_sendmsg+0x419/0x850
[ 1246.407484][T26812]  ? copy_msghdr_from_user+0x270/0x430
[ 1246.407486][T26812]  ? get_timestamp.constprop.0+0x390/0x390
[ 1246.407488][T26812]  ? move_addr_to_kernel+0x40/0x40
[ 1246.407491][T26812]  ? stack_depot_save_flags+0x30d/0x6e0
[ 1246.407495][T26812]  ? rcu_read_lock_any_held+0x3c/0x90
[ 1246.407500][T26812]  ___sys_sendmsg+0xfd/0x180
[ 1246.407502][T26812]  ? __call_rcu_common.constprop.0+0xa6/0xa00
[ 1246.407505][T26812]  ? copy_msghdr_from_user+0x430/0x430
[ 1246.407520][T26812]  __sys_sendmsg+0x124/0x1c0
[ 1246.407522][T26812]  ? __sys_sendmsg_sock+0x20/0x20
[ 1246.407524][T26812]  ? lockdep_hardirqs_on+0x84/0x130
[ 1246.407528][T26812]  ? __call_rcu_common.constprop.0+0x3bd/0xa00
[ 1246.407533][T26812]  ? do_raw_spin_unlock+0x59/0x250
[ 1246.407536][T26812]  ? rcu_is_watching+0x15/0xd0
[ 1246.407539][T26812]  do_syscall_64+0x117/0xfc0
[ 1246.407541][T26812]  ? exc_page_fault+0xaf/0xd0
[ 1246.407544][T26812]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 1246.407546][T26812] RIP: 0033:0x7f7fe0147c5e
[ 1246.407549][T26812] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[ 1246.407551][T26812] RSP: 002b:00007ffce73c1500 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[ 1246.407553][T26812] RAX: ffffffffffffffda RBX: 00007ffce73c3b10 RCX: 00007f7fe0147c5e
[ 1246.407555][T26812] RDX: 0000000000000000 RSI: 00007ffce73c15c0 RDI: 0000000000000005
[ 1246.407556][T26812] RBP: 00007ffce73c1510 R08: 0000000000000000 R09: 0000000000000000
[ 1246.407557][T26812] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[ 1246.407557][T26812] R13: 0000000069bb982b R14: 00007ffce73c3b20 R15: 000000000049c620
[ 1246.407564][T26812]  </TASK>

