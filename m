Return-Path: <netdev+bounces-268400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C4bDHWvBuGkfjAEAu9opvQ
	(envelope-from <netdev+bounces-268400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:50:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0942A2EC2
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A97B43027321
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A93E29B789;
	Tue, 17 Mar 2026 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbcR9wHA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AAF199949
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715815; cv=none; b=YHH827nxOdHjfqZmlxN1/ugDiDSV1t3tc4OCo7ABIssEtpqKByJuR79SvQ73jgLq3KBKjZaSkx8ysPnsxHGNUW5k2FTh8LcGMe4Njd0vT0m3/FynWGA/9mNHEhNPGC5e1B7K/N5lnFKkDsKtJ6fOI749qGnFHCUBpbJDqo/bHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715815; c=relaxed/simple;
	bh=PqSQafLyFw/dZ1o9wq+fGyAME5CbNSrN7NB1S1Hd6EE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DK9SNm3D2H6Ef5lyAS0giJGGVi9VGZlBQVmdGm2OeH3mWjh3xuifIwT+feQ7/S9ERX1QUTjqVKxLfSdU9mUgekZPsH4JPeM16vUDG7Z51776Mgotxe/Nn4ySQ/ruddAO77kKDjWfkNq1OGopUkIf83lq6PWhjH7IguSz4JJ7u7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbcR9wHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A6DC19421;
	Tue, 17 Mar 2026 02:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773715814;
	bh=PqSQafLyFw/dZ1o9wq+fGyAME5CbNSrN7NB1S1Hd6EE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RbcR9wHAX/eUe/plMv6Xoqf6ln1+L9uL9Gh87UdZA5oM1EtRkBiRjFhvB5k4XCmVV
	 TFQjYPY5cgkNWWVyDkokpIPrAvw/JNUl9RrWnS09Dr0zhgsE5C8eyEEY6fYjWgHzEQ
	 95njUx0Jx11pSAf0XqU0qe6LXj11jPvwr6OxZEU4HgGFhT3EgiLzmVY8tBW3Dq3IaJ
	 GS1VXBoTWWvZzT48ZOCisCsthqLPMMrgLSd3E0Z8yX9GXI2QDQZf9nZcRENs66WeUs
	 ViI14QuFtmnYKlLyvlTs5bQacx75UMRIwzfdzuX/R75jpjhCwqgsjUxvUjBpyKdVdo
	 ncdBl7zK3onfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0753808200;
	Tue, 17 Mar 2026 02:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net/sched: teql: Fix double-free in
 teql_master_xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371580729.3402731.13769692238630260864.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 02:50:07 +0000
References: <20260315155422.147256-1-jhs@mojatatu.com>
In-Reply-To: <20260315155422.147256-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 keenanat2000@gmail.com, security@kernel.org, victor@mojatatu.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268400-lists,netdev=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com,mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DC0942A2EC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Mar 2026 11:54:22 -0400 you wrote:
> Whenever a TEQL devices has a lockless Qdisc as root, qdisc_reset should
> be called using the seq_lock to avoid racing with the datapath. Failure
> to do so may cause crashes like the following:
> 
> [  238.028993][  T318] BUG: KASAN: double-free in skb_release_data (net/core/skbuff.c:1139)
> [  238.029328][  T318] Free of addr ffff88810c67ec00 by task poc_teql_uaf_ke/318
> [  238.029749][  T318]
> [  238.029900][  T318] CPU: 3 UID: 0 PID: 318 Comm: poc_teql_ke Not tainted 7.0.0-rc3-00149-ge5b31d988a41 #704 PREEMPT(full)
> [  238.029906][  T318] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [  238.029910][  T318] Call Trace:
> [  238.029913][  T318]  <TASK>
> [  238.029916][  T318]  dump_stack_lvl (lib/dump_stack.c:122)
> [  238.029928][  T318]  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
> [  238.029940][  T318]  ? skb_release_data (net/core/skbuff.c:1139)
> [  238.029944][  T318]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> ...
> [  238.029957][  T318]  ? skb_release_data (net/core/skbuff.c:1139)
> [  238.029969][  T318]  kasan_report_invalid_free (mm/kasan/report.c:221 mm/kasan/report.c:563)
> [  238.029979][  T318]  ? skb_release_data (net/core/skbuff.c:1139)
> [  238.029989][  T318]  check_slab_allocation (mm/kasan/common.c:231)
> [  238.029995][  T318]  kmem_cache_free (mm/slub.c:2637 (discriminator 1) mm/slub.c:6168 (discriminator 1) mm/slub.c:6298 (discriminator 1))
> [  238.030004][  T318]  skb_release_data (net/core/skbuff.c:1139)
> ...
> [  238.030025][  T318]  sk_skb_reason_drop (net/core/skbuff.c:1256)
> [  238.030032][  T318]  pfifo_fast_reset (./include/linux/ptr_ring.h:171 ./include/linux/ptr_ring.h:309 ./include/linux/skb_array.h:98 net/sched/sch_generic.c:827)
> [  238.030039][  T318]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> ...
> [  238.030054][  T318]  qdisc_reset (net/sched/sch_generic.c:1034)
> [  238.030062][  T318]  teql_destroy (./include/linux/spinlock.h:395 net/sched/sch_teql.c:157)
> [  238.030071][  T318]  __qdisc_destroy (./include/net/pkt_sched.h:328 net/sched/sch_generic.c:1077)
> [  238.030077][  T318]  qdisc_graft (net/sched/sch_api.c:1062 net/sched/sch_api.c:1053 net/sched/sch_api.c:1159)
> [  238.030089][  T318]  ? __pfx_qdisc_graft (net/sched/sch_api.c:1091)
> [  238.030095][  T318]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [  238.030102][  T318]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [  238.030106][  T318]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [  238.030114][  T318]  tc_get_qdisc (net/sched/sch_api.c:1529 net/sched/sch_api.c:1556)
> ...
> [  238.072958][  T318] Allocated by task 303 on cpu 5 at 238.026275s:
> [  238.073392][  T318]  kasan_save_stack (mm/kasan/common.c:58)
> [  238.073884][  T318]  kasan_save_track (mm/kasan/common.c:64 (discriminator 5) mm/kasan/common.c:79 (discriminator 5))
> [  238.074230][  T318]  __kasan_slab_alloc (mm/kasan/common.c:369)
> [  238.074578][  T318]  kmem_cache_alloc_node_noprof (./include/linux/kasan.h:253 mm/slub.c:4542 mm/slub.c:4869 mm/slub.c:4921)
> [  238.076091][  T318]  kmalloc_reserve (net/core/skbuff.c:616 (discriminator 107))
> [  238.076450][  T318]  __alloc_skb (net/core/skbuff.c:713)
> [  238.076834][  T318]  alloc_skb_with_frags (./include/linux/skbuff.h:1383 net/core/skbuff.c:6763)
> [  238.077178][  T318]  sock_alloc_send_pskb (net/core/sock.c:2997)
> [  238.077520][  T318]  packet_sendmsg (net/packet/af_packet.c:2926 net/packet/af_packet.c:3019 net/packet/af_packet.c:3108)
> [  238.081469][  T318]
> [  238.081870][  T318] Freed by task 299 on cpu 1 at 238.028496s:
> [  238.082761][  T318]  kasan_save_stack (mm/kasan/common.c:58)
> [  238.083481][  T318]  kasan_save_track (mm/kasan/common.c:64 (discriminator 5) mm/kasan/common.c:79 (discriminator 5))
> [  238.085348][  T318]  kasan_save_free_info (mm/kasan/generic.c:587 (discriminator 1))
> [  238.085900][  T318]  __kasan_slab_free (mm/kasan/common.c:287)
> [  238.086439][  T318]  kmem_cache_free (mm/slub.c:6168 (discriminator 3) mm/slub.c:6298 (discriminator 3))
> [  238.087007][  T318]  skb_release_data (net/core/skbuff.c:1139)
> [  238.087491][  T318]  consume_skb (net/core/skbuff.c:1451)
> [  238.087757][  T318]  teql_master_xmit (net/sched/sch_teql.c:358)
> [  238.088116][  T318]  dev_hard_start_xmit (./include/linux/netdevice.h:5324 ./include/linux/netdevice.h:5333 net/core/dev.c:3871 net/core/dev.c:3887)
> [  238.088468][  T318]  sch_direct_xmit (net/sched/sch_generic.c:347)
> [  238.088820][  T318]  __qdisc_run (net/sched/sch_generic.c:420 (discriminator 1))
> [  238.089166][  T318]  __dev_queue_xmit (./include/net/sch_generic.h:229 ./include/net/pkt_sched.h:121 ./include/net/pkt_sched.h:117 net/core/dev.c:4196 net/core/dev.c:4802)
> 
> [...]

Here is the summary with links:
  - [net,1/1] net/sched: teql: Fix double-free in teql_master_xmit
    https://git.kernel.org/netdev/net/c/66360460cab6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



