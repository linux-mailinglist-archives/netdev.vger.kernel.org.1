Return-Path: <netdev+bounces-301534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qakxE5w/O2rjUQgAu9opvQ
	(envelope-from <netdev+bounces-301534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 04:23:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B60566BAEB8
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 04:23:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ONhyk7p9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301534-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301534-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 626C730EE8D2
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 02:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0472F5337;
	Wed, 24 Jun 2026 02:21:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA733275B03
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:21:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267665; cv=none; b=M7oucYcTRRjPJ6s4DX8ZLa5JfvyzC/84Q5f9Vs/V6RmwFa7gu2Hn//ly2wqWeGsf+jirwDAKFYWu1FxsnOfaoTLqwmfG39lv9sq497OqQFN67tpO+0/QcA2giD3lDi/d8t8lFPx3moaObFZ4vBx2vur7gBwO1b1PiT7s2GcyKF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267665; c=relaxed/simple;
	bh=T/Bq86BjZdt/IivZEZGHu4jsLL4a9cKYPS3624V4wMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tUFiFlLRzTm2mtC70TPEYwbwGtrtnDAU89qzbdC3gp/oO5vYLnhG79idbUpIbbsy3N2Tlg/mX12djafXAsaQ0f+Y6MF/U2YHLgMn/poILAdHeM6HhOyjd6u6alYQm5ZH+xd73VmjlTBNgU2OeAw2p5HLwwHg05D2bRcA7yZf/2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONhyk7p9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02C01F000E9;
	Wed, 24 Jun 2026 02:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782267660;
	bh=nIcghOPdEg9s7M3qtKpFUe2LjQx2WBFCQvfbHsCf84w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ONhyk7p9P2C9oKUFF5k+yna/0Tvma0VP/rZnshrzIq0q59zfcXCly7Hz4uOi7stDU
	 ooXSNsbJ/0n7jzyNWf3oEVE+woetyV1dVGAxoFpX+tYIZ3kA+/vTE1Hepm3z2D+ZmM
	 DQCI0bo9oBdiib/YrohVboxL55hlTqk4ZUurkgkglOiMbzt8yApgEGQW2IrfA0yZUN
	 4P0vTTQ1MdIEPlfUKxekAIIgOrFl4ALK1JyInGWH1IVfCvC48Ey1wb4SqscEyHOg24
	 vRPy/Z5Gb4U5OF9vFA6jf8TLeXBwldUSEKDo+9MIumaEd6S2et1+ycrNYIbZFYjPOR
	 6gVj8BkHwgCDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688E393102A;
	Wed, 24 Jun 2026 02:20:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/6] ipv6: fix error handling in disable_ipv6
 sysctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178226764994.2513445.6893091614764518724.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 02:20:49 +0000
References: <20260622130857.5115-1-fmancera@suse.de>
In-Reply-To: <20260622130857.5115-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
 stephen@networkplumber.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
 dsahern@kernel.org
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301534-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:nicolas.dichtel@6wind.com,m:stephen@networkplumber.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B60566BAEB8

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jun 2026 15:08:51 +0200 you wrote:
> While working on a different IPv6 patch series I have spotted multiple
> minor bugs around sysctl error handling and notifications. In general,
> they are not serious issues.
> 
> In addition, there is one more issue in forwarding sysctl as it does not
> check for CAP_NET_ADMIN for the namespace. I am keeping that patch out
> of this series and I am aiming it at the net-next tree once it re-opens.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/6] ipv6: fix error handling in disable_ipv6 sysctl
    https://git.kernel.org/netdev/net/c/c779441e5070
  - [net,v3,2/6] ipv6: fix error handling in ignore_routes_with_linkdown sysctl
    https://git.kernel.org/netdev/net/c/cf4f2b14401f
  - [net,v3,3/6] ipv6: fix error handling in forwarding sysctl
    https://git.kernel.org/netdev/net/c/058b9b19f963
  - [net,v3,4/6] ipv6: fix error handling in disable_policy sysctl
    https://git.kernel.org/netdev/net/c/3e0e51c0ee1d
  - [net,v3,5/6] ipv6: fix state corruption during proxy_ndp sysctl restart
    https://git.kernel.org/netdev/net/c/6a1b50e585f0
  - [net,v3,6/6] ipv6: fix missing notification for ignore_routes_with_linkdown
    https://git.kernel.org/netdev/net/c/17dc3b245de4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



