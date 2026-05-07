Return-Path: <netdev+bounces-285404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL8kA/K0/Gm0SwAAu9opvQ
	(envelope-from <netdev+bounces-285404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:51:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D864EB669
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82FB53010632
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A64D44BCA8;
	Thu,  7 May 2026 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHVido9h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A1444B67A
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169065; cv=none; b=YiZrS0VlFqGRN0T6kMWxgB/Q++gn2Hk+hlUgB2gINZnWbv3K0ydGK9p2IwgN7NNNeYkQZq0cYARrM0r1jmhGfMSNlzNlYuw0eQy4NRh0gjmk19PnZO3Zjx7YFnwgoJ2M8yhppbOwqYlvI/KeKhgkaJY0sbesVBV3aSKERBHXemE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169065; c=relaxed/simple;
	bh=3v6IxUH82rV9kEOsgKaUNpLlcLs4FWQetg5EG+aISS0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LI7GpRx2NlNHlVyBG46U6w6HCXJuRqVT2dhGmtNTqBKXnRQbV7tqWXi9vXEDXpBMABr+rFhXQ2Np1Bs+rlQM0VuR/4//oI7i+9+hBPrg7bqKVvbTUFv0Dj7ecFUFLWUrvuxGZI61aQ+vEI9KCAiDn9fxXz3J21V+Fx7JLLojVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHVido9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10236C2BCC4;
	Thu,  7 May 2026 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169065;
	bh=3v6IxUH82rV9kEOsgKaUNpLlcLs4FWQetg5EG+aISS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fHVido9hwcevHBk7letmfdQ0i41mhZKK9C1EAh/ZGQIkWc0qedwO8Zj1eT4x8VJ7o
	 GvK/IuGaeZQbfY53Wdvtf1YUB7sJWe7p3ei4sFRg+mIp00MRv+TQ3lJa/SvPoowiRR
	 v2N6qdTm6l1wjQ+ZD1f/YDEgN7rREpB1LuxcUx0H88TyYuSgVTdlZ1WK4igynGkfik
	 LPXC5fNrMoHh0HsRKw78BcEqyaxWf7YSOJq58RR77BoyparMtCmAyxdBxY3L9lwgg0
	 W6NHhEu4ciwQyEh/2KkrfTqG6Zc7DJ1SI9gMru6Bxjko33J2fGg0G/Noj6YNU28fi0
	 ZPywS7VYkzjWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CC4D3930909;
	Thu,  7 May 2026 15:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipmr: Call ipmr_fib_lookup() under RCU.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177816901429.4048611.16793001834053100372.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 15:50:14 +0000
References: <20260506065955.1695753-1-kuniyu@google.com>
In-Reply-To: <20260506065955.1695753-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org, syzkaller@googlegroups.com,
 yi1.lai@intel.com
X-Rspamd-Queue-Id: C4D864EB669
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,googlegroups.com,intel.com];
	TAGGED_FROM(0.00)[bounces-285404-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 06:59:53 +0000 you wrote:
> Yi Lai reported RCU splat in reg_vif_xmit() below. [0]
> 
> When CONFIG_IP_MROUTE_MULTIPLE_TABLES=n, ipmr_fib_lookup()
> uses rcu_dereference() without explicit rcu_read_lock().
> 
> Although rcu_read_lock_bh() is already held by the caller
> __dev_queue_xmit(), lockdep requires explicit rcu_read_lock()
> for rcu_dereference().
> 
> [...]

Here is the summary with links:
  - [v1,net] ipmr: Call ipmr_fib_lookup() under RCU.
    https://git.kernel.org/netdev/net/c/019c892e4654

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



