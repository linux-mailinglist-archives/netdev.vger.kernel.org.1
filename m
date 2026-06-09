Return-Path: <netdev+bounces-296795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6yBVK31cJ2qEvAIAu9opvQ
	(envelope-from <netdev+bounces-296795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:21:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0997865B51B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:21:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dYKmRCQR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296795-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296795-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9EEF301B903
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D229175A89;
	Tue,  9 Jun 2026 00:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F31E8342
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:20:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964428; cv=none; b=sxBB+zUV4tUKTFh03EUjPe7CFTAFQahtRDfJJ3IjUjptTHG4fcDGE8GHu3KyAZA2ae6UZJbvw9VmnV68JyITltw/Hgz1lHDJnrRRZNjHgXwuDzCBNrv3Ib4/RNeJ8K0ttRQpgGxniAHSCyoJjuK05zsihzRnN5ftvSS2Zg6ViEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964428; c=relaxed/simple;
	bh=2OrlMEsIjOtrtMCl2NHbbpJBz03b0jzyPQL7XEpG5z4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mXHcXyVLLHKJ8RMHTLw2mEvBi8y1xShZKuCslf7cT3ilwbhFehXNNi4Di5F7HD1bz8B4T3f8WH8twgFKT0Eg78G0iBB/CZ7Czhe4yTwP8ulq324vxi9DTfuvuSL3L+wYpUlxdWu1Tv54EOfTg5/wFColqjbw8DzTAYUcF8KOTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYKmRCQR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA4F1F00893;
	Tue,  9 Jun 2026 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780964427;
	bh=vwPhAejTcYMlGOOzkULE9wRkgOj0KwlxeaNErkqQcaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dYKmRCQRWUN3nO5cO6dy733yfN5XswzwP/aFEPCTCZ16HEDvrkMyqFk/KsPSxl7tY
	 INkoj4qVinz2W/kC1/fUVd+dWR+bQeK1OI8wBxMkaIdax6aamFCvwTxuFfMPlpCeRS
	 ZO9ML3OZUvsqfvVxRNDfAxDF26DnYXrC+Bp3Oz6MAKuwGTjk1QuNA+SvsipcGQ/lDa
	 2Cfaz8B5JFYtTl9LtMbZzVhQ7BtyaiJf3IpkwMyPso4joX8SUajJbqMaLlXBokBHKS
	 7yLMrdJqWKMYIDgLq+o4EqBnSnQ7rf4moDTesCaTDL7pgugd7He1loyreJ6Ja7apj9
	 D2YnP4d8YHGHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B343812FDA;
	Tue,  9 Jun 2026 00:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 00/15] ip6mr: No RTNL for RTNL_FAMILY_IP6MR
 rtnetlink.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096442564.1723164.6271396560313518913.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 00:20:25 +0000
References: <20260604224712.3209821-1-kuniyu@google.com>
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 idosch@nvidia.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,nvidia.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296795-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0997865B51B

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 22:46:18 +0000 you wrote:
> This series is the IPv6 version of
> 
>   https://lore.kernel.org/netdev/20260228221800.1082070-1-kuniyu@google.com/
> 
> and removes RTNL from ip6mr rtnetlink handlers.
> 
> After this series, there are a few RTNL left in net/ipv6/ip6mr.c
> and such users will be converted to per-netns RTNL in another
> series.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,01/15] selftest: net: Extend ipmr.c for IP6MR.
    https://git.kernel.org/netdev/net-next/c/e02bf5e7aa4a
  - [v3,net-next,02/15] ip6mr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
    https://git.kernel.org/netdev/net-next/c/364568de4e7f
  - [v3,net-next,03/15] ip6mr: Use MAXMIFS in mr6_msgsize().
    https://git.kernel.org/netdev/net-next/c/36be7d7c5ded
  - [v3,net-next,04/15] ip6mr: Allocate skb earlier in ip6mr_rtm_getroute().
    https://git.kernel.org/netdev/net-next/c/c2f5fd21aca4
  - [v3,net-next,05/15] ip6mr: Convert ip6mr_rtm_getroute() to RCU.
    https://git.kernel.org/netdev/net-next/c/76ea2ba2297e
  - [v3,net-next,06/15] ip6mr: Convert ip6mr_rtm_dumproute() to RCU.
    https://git.kernel.org/netdev/net-next/c/3bcf206012b2
  - [v3,net-next,07/15] net: Remove rtnl_held of struct fib_dump_filter.
    https://git.kernel.org/netdev/net-next/c/a543cb49e603
  - [v3,net-next,08/15] ip6mr: Free mr_table after RCU grace period.
    https://git.kernel.org/netdev/net-next/c/2c309a863dd6
  - [v3,net-next,09/15] ip6mr: Call fib_rules_unregister() without RTNL.
    https://git.kernel.org/netdev/net-next/c/4becf0124675
  - [v3,net-next,10/15] ip6mr: Move unregister_netdevice_many() out of mroute_clean_tables().
    https://git.kernel.org/netdev/net-next/c/7395fccf6b4c
  - [v3,net-next,11/15] ip6mr: Move unregister_netdevice_many() out of ip6mr_free_table().
    https://git.kernel.org/netdev/net-next/c/33e6984fe5d4
  - [v3,net-next,12/15] ip6mr: Convert ip6mr_net_exit_batch() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/2a798e8c71b5
  - [v3,net-next,13/15] ip6mr: Remove RTNL in ip6mr_rules_init() and ip6mr_net_init().
    https://git.kernel.org/netdev/net-next/c/2290727b2fdb
  - [v3,net-next,14/15] ip6mr: Replace RTNL with a dedicated mutex for MFC.
    https://git.kernel.org/netdev/net-next/c/a4c98421720a
  - [v3,net-next,15/15] ip6mr: Define net->ipv6.{ip6mr_notifier_ops,ipmr_seq} under CONFIG_IPV6_MROUTE.
    https://git.kernel.org/netdev/net-next/c/5499868699ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



