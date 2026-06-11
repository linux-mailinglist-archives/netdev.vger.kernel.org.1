Return-Path: <netdev+bounces-298381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +D1FEQA3K2qe4QMAu9opvQ
	(envelope-from <netdev+bounces-298381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:30:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E587675A25
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:30:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b0iEvCZv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298381-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298381-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3C4032CD553
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405273BD63A;
	Thu, 11 Jun 2026 22:30:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D14722AE48;
	Thu, 11 Jun 2026 22:30:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217019; cv=none; b=TD/XjT//8y9lnaVYhPwSPfAi3TRWs/5eYvAOtVo6ZhLgkgufrqq/XeMRkobDRh3QEwOgUbm7SNALacmmL3HSrgKZJmOlEdOnXmJPU+5aJz/+VjiHsTbON30ESnfKeF63svTDyWrCj0gtN03oMI2ic5mnZxPeCGXjqGsSZxRtlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217019; c=relaxed/simple;
	bh=8+9x3+3OANDUfFV6Mi4OJtDoo5EmG1o56H49VaDIDlA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j6GwgnMPWMGeMm5oo4bUEW/Q6WXZU07fJ8Q5CmWCx+eoDONMYncvYA748tbhSOxYEf3PbanB9o3GnKcw/LiO/92NMbzFc6uzb+uHLjjbJHG8OEB/+7jQ1WrXU4dNg5TdkZMPI1fSco1248+SwKuVxq/FVUDfn7fT2PxsNpR4Qzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0iEvCZv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2AE1F000E9;
	Thu, 11 Jun 2026 22:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781217017;
	bh=BvaraMWQw+8AFnBnEo9akEiyDXK81I9IoDwyriehdHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b0iEvCZv5EVVEYtAIQIWvHoGKyWYjIKZ0eZXUObHBXGzlaI4f2F692pm1JgKulK1t
	 sUUID1PujXxitRGK1My2s7EincJNLMw/VGpyjDsm9igFU84enyAD2qxN6raR3OtFDr
	 +8/wU7VA0jb7QONFP2JVR9i+lcLHzAc68EWTN1f5I2jDnAHLEmibX4AHk2QI59ZCbR
	 Ig1SUCCtNN7MUAaONZxYrD/B0fJebcs3JhqYsQkCF9cWrv2jnsKQw/fZgbcwzky9YD
	 dnviAVQfPsajBwNfl28Rs+RHH9zTt0DXTUakG+FoAXfdd/4ENm/XouwSYzmWyDrkCg
	 xEMcc++gyAqqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A063930FAD;
	Thu, 11 Jun 2026 22:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: pfcp: allocate per-cpu tstats for PFCP
 netdevs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121701414.389578.2568619037943825511.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:30:14 +0000
References: 
 <20260609232244.1602027.c569f6c530f6.pfcp-missing-tstats-link-create-oops@trailofbits.com>
In-Reply-To: 
 <20260609232244.1602027.c569f6c530f6.pfcp-missing-tstats-link-create-oops@trailofbits.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wojciech.drewek@intel.com,
 marcin.szycik@linux.intel.com, aleksander.lobakin@intel.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298381-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wojciech.drewek@intel.com,m:marcin.szycik@linux.intel.com,m:aleksander.lobakin@intel.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E587675A25

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 23:22:45 +0000 you wrote:
> PFCP uses dev_get_tstats64() as its ndo_get_stats64 callback, but
> pfcp_link_setup() does not request NETDEV_PCPU_STAT_TSTATS.  The net
> core therefore leaves dev->tstats NULL for PFCP devices.
> 
> Creating a PFCP rtnetlink device can immediately ask the new netdev for
> stats while building the RTM_NEWLINK notification.  That reaches
> dev_get_tstats64() and dereferences the NULL dev->tstats pointer.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: pfcp: allocate per-cpu tstats for PFCP netdevs
    https://git.kernel.org/netdev/net/c/24041543da8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



