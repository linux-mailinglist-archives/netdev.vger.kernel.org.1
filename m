Return-Path: <netdev+bounces-303772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bDp5EZFGRWqr9woAu9opvQ
	(envelope-from <netdev+bounces-303772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:55:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F766F0099
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:55:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=k6eyA3Yu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303772-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303772-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42AD630882EC
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDF63749FE;
	Wed,  1 Jul 2026 16:50:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2873793B3
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 16:50:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924638; cv=none; b=e/3IEK+9NS780FLgcDkZ9adt808QmcQj+2sPYhMlpVG9JHRrUnQJGzmOyxiLaUUT84zGr1N8cYY6aEE29H4R9EghWLPH/BQ71WQMujP/DZMjed8uiclcqn5WLnsPpPIU9O+2ITkg5/8giZ5rbfQzu42aAE6la7AL29WyGO8OKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924638; c=relaxed/simple;
	bh=xC08eigTgghYOgw25mXWra61LjC3On8LXm2uLBmUm5Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W5jd3h5lfCqWhweJmsjAXvPR+ao2d1dIYhJCaxHVdjwk/a5JJfFDMinAWdrnj/x81L5pT1iL8PYmfWE+naDE65Sw+8Gv+FibMfneePAbB6aaHy35DRsPNWb1zn0r9nSjb8STlObAwYf2TSS6ApvxZTJyvV4/9YzvCwpZWE6XdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6eyA3Yu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04CD1F000E9;
	Wed,  1 Jul 2026 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782924636;
	bh=08ygD9CE4swe4MjVOp3AAIcdmtQGAAer9jsUCacPnvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=k6eyA3YuNMhKoi0nNj6iIwRFmAdxWWLDSU/ujVkdqi525ZxYqJgqabawaJaMnJlCa
	 BCTlTiQjLky/ucNFaj1KA6JQlb2jWAI6Hkhn/g976riMOOzxloJ2c/ynWqKcbrwgZ1
	 Qj0nI/sWLHOV99ki2eB4n2u+SXwo19lpdAX9tZYV3FYpYd3WhzxGRwgLqu58JAa7ts
	 19+m2F1ACid0CFY0khjEsNNZKn1W9F9gg0o/I5puDIVuppgJzdKFT5pje3VVEApr4l
	 V31EDwmo/WhYFxY9Kj0aWzsUL4drgyvYs2mRdIz34rZ9i2RLSLi6AhQ96cJrMsLzIE
	 q6y77yH130FJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695E3926269;
	Wed,  1 Jul 2026 16:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 00/10] net: fib_rules: RTNL-less RTM_NEWRULE
 and
 RTM_DELRULE.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178292461976.1201752.16605175168707843811.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 16:50:19 +0000
References: <20260629181226.1929658-1-kuniyu@google.com>
In-Reply-To: <20260629181226.1929658-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303772-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94F766F0099

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Jun 2026 18:10:52 +0000 you wrote:
> RTM_NEWRULE and RTM_DELRULE acquire rtnl_net_lock(), but this is
> only for fib_unmerge() in IPv4.
> 
> Since commit d954a67a7dfa ("ipv4: fib_rule: Move fib4_rules_exit()
> to ->exit()."), RTM_DELRULE no longer needs RTNL.
> 
> fib_unmerge() is one-time event for each netns, so we only need
> RTNL for the first IPv4 rule.
> 
> [...]

Here is the summary with links:
  - [v1,net-next,01/10] net: fib_rules: Make fib_rules_ops.delete() return void.
    https://git.kernel.org/netdev/net-next/c/54fd3962c99d
  - [v1,net-next,02/10] ipv4: fib_rules: Make the need for fib_unmerge() explicit.
    https://git.kernel.org/netdev/net-next/c/5cb890ff7357
  - [v1,net-next,03/10] ipv4: fib: Protect fib_new_table() with spinlock.
    https://git.kernel.org/netdev/net-next/c/4b8f5c974d14
  - [v1,net-next,04/10] ipv4: fib: Drop RTNL annotation for net->ipv4.fib_table_hash[].
    https://git.kernel.org/netdev/net-next/c/763a9437101b
  - [v1,net-next,05/10] net: fib_rules: Add fib_rules_ops.lock.
    https://git.kernel.org/netdev/net-next/c/8e133ba99cd8
  - [v1,net-next,06/10] net: fib_rules: Remove unnecessary EXPORT_SYMBOL.
    https://git.kernel.org/netdev/net-next/c/a7e87ee40980
  - [v1,net-next,07/10] net: fib_rules: Drop RTNL assertions.
    https://git.kernel.org/netdev/net-next/c/facce49f29cc
  - [v1,net-next,08/10] net: fib_rules: Use dev_get_by_name_rcu().
    https://git.kernel.org/netdev/net-next/c/34ea2499389e
  - [v1,net-next,09/10] net: fib_rules: Only hold RTNL for the first IPv4 RTM_NEWRULE.
    https://git.kernel.org/netdev/net-next/c/eef9bddc3313
  - [v1,net-next,10/10] ipv6: fib_rules: Convert fib6_rules_net_exit_rtnl() to ->exit().
    https://git.kernel.org/netdev/net-next/c/ffc8a4b9ad2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



