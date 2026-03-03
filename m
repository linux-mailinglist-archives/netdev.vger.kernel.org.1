Return-Path: <netdev+bounces-263038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI2+M8lnpmljPQAAu9opvQ
	(envelope-from <netdev+bounces-263038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:47:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 578AC1E909F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FC2F3047DEE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 04:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3928E375F86;
	Tue,  3 Mar 2026 04:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTYGH1+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5F2FC874
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513219; cv=none; b=faGSxDiKfjfaKp9s7UmL6u33TpJKZdZnrq1gk6NeAs/cY8VezV0Q91RhXStgWpSkn4t3Seyi6KisQsxM3Q2Cvx89+uzKXrk33OfOjusg4NIQvxfTGHr0V0k4p50Pzmb1oOfa95/ZHJSV/GjQplAQO/5iBKWgjm/7hfb01YHdqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513219; c=relaxed/simple;
	bh=xxifiAy61FZMvhx4TODwLk3MBWqPC56SoR9/wJaXHmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Flcgle2mk0UdoQTt3vBTTM8BJTlyFe6SkYvEtkJLuzm4YLgVxTANaQaX6PM++tDsj6yu42tsfz2+1dDuWGLLaaqgAuKIIO2c6Ckeu60OAs3BZBUQJd4uahjssHyiTCYXnp64Tc//jv6vxmVAi1IYjv07Gf82nxFdPkbR/8iQdx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTYGH1+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE78C2BCB0;
	Tue,  3 Mar 2026 04:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772513218;
	bh=xxifiAy61FZMvhx4TODwLk3MBWqPC56SoR9/wJaXHmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UTYGH1+5LNkHpo7h3CpwDuHUq+ZvHNQ33yldN6tk7EE8Rwsp8rGWjn3t3S1y7maXs
	 hTRq1lyQV6E6reZborTJlpy64RV7Df2zyS+DGnsogGisI0CnsgFn3xV46ytNjrX6Gg
	 Ck9BWQ9gT0fQCi+lyDB9g1JVdEdbJ51x26IKIZ/atZjaGvZrxq1gn4DGLnh6070uAV
	 8mb5himDsncppuhyDrYW0fOahb3GTi50FISNLJQ0bLiPbuimqzYeBM4wkQrj4NQNAJ
	 HDWxkF/ZFTjJysADbZxEY8dwVDjy8mApRJoofvwnJb1LY/SQEZgK3XH2YcYZjOdUQi
	 9WULFqyeBaZBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D3593809A80;
	Tue,  3 Mar 2026 04:47:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 00/15] ipmr: No RTNL for RTNL_FAMILY_IPMR
 rtnetlink.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177251322007.625663.1420878410226758653.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 04:47:00 +0000
References: <20260228221800.1082070-1-kuniyu@google.com>
In-Reply-To: <20260228221800.1082070-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: 578AC1E909F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263038-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Feb 2026 22:17:18 +0000 you wrote:
> This series removes RTNL from ipmr rtnetlink handlers.
> 
> After this series, there are a few RTNL left in net/ipv4/ipmr.c
> and such users will be converted to per-netns RTNL in another
> series.
> 
> Patch 1 adds a selftest to exercise most? of the RTNL paths
>  in net/ipv4/ipmr.c
> 
> [...]

Here is the summary with links:
  - [v3,net-next,01/15] selftest: net: Add basic functionality tests for ipmr.
    https://git.kernel.org/netdev/net-next/c/05068eaa67b2
  - [v3,net-next,02/15] ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
    https://git.kernel.org/netdev/net-next/c/261950e0390b
  - [v3,net-next,03/15] ipmr: Convert ipmr_rtm_dumplink() to RCU.
    https://git.kernel.org/netdev/net-next/c/402a8111d7be
  - [v3,net-next,04/15] ipmr: Use MAXVIFS in mroute_msgsize().
    https://git.kernel.org/netdev/net-next/c/2bd6c9d600d6
  - [v3,net-next,05/15] ipmr: Convert ipmr_rtm_getroute() to RCU.
    https://git.kernel.org/netdev/net-next/c/295a17b3eae9
  - [v3,net-next,06/15] ipmr: Convert ipmr_rtm_dumproute() to RCU.
    https://git.kernel.org/netdev/net-next/c/2c698bab294a
  - [v3,net-next,07/15] ipmr: Move unregister_netdevice_many() out of mroute_clean_tables().
    https://git.kernel.org/netdev/net-next/c/3810f9529dc7
  - [v3,net-next,08/15] ipmr: Move unregister_netdevice_many() out of ipmr_free_table().
    https://git.kernel.org/netdev/net-next/c/b7fdc3cfb60a
  - [v3,net-next,09/15] ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().
    https://git.kernel.org/netdev/net-next/c/b22b01867406
  - [v3,net-next,10/15] ipmr: Remove RTNL in ipmr_rules_init() and ipmr_net_init().
    https://git.kernel.org/netdev/net-next/c/4a11adcd9eef
  - [v3,net-next,11/15] ipmr: Call fib_rules_unregister() without RTNL.
    https://git.kernel.org/netdev/net-next/c/478c2add78b1
  - [v3,net-next,12/15] ipmr: Define net->ipv4.{ipmr_notifier_ops,ipmr_seq} under CONFIG_IP_MROUTE.
    https://git.kernel.org/netdev/net-next/c/1c36d186a0c8
  - [v3,net-next,13/15] ipmr/ip6mr: Convert net->ipv[46].ipmr_seq to atomic_t.
    https://git.kernel.org/netdev/net-next/c/4480d5fa1f6e
  - [v3,net-next,14/15] ipmr: Add dedicated mutex for mrt->{mfc_hash,mfc_cache_list}.
    https://git.kernel.org/netdev/net-next/c/3c1e53e55418
  - [v3,net-next,15/15] ipmr: Don't hold RTNL for ipmr_rtm_route().
    https://git.kernel.org/netdev/net-next/c/bddafc06ca5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



