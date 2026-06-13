Return-Path: <netdev+bounces-299051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pRKrNJLJLWoakAQAu9opvQ
	(envelope-from <netdev+bounces-299051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:20:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C12667FC4D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:20:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RQir9p4I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299051-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299051-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FB4530086D7
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2411C31AAAF;
	Sat, 13 Jun 2026 21:20:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A60E30C16C
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 21:20:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781385615; cv=none; b=E+AtLOp/iXCsDhsHerBHX3HrKHMJ2d3T5QyYqx2EGHLiDoGErpqj4janU9+k6HRhznp0p9vnfZJ8qlvzPxeCnimNHar9hvKmWqO4ZAqkNBDflR14N5jJrd7JbE7fVzcuKycRHcViuTbOOl5IOwc86XUNs0TNpAE/Tqi/uaF4OY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781385615; c=relaxed/simple;
	bh=aT+XA15jw93GHgEnCRmcCbsPh6gtzetKFr9x1hfYsEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lIFN7FHVsNCT5vVAOsI6WW1tFefIDRc/9tN85mbTTzirq3zdCDLiad8+GHDHzsRt36dhRHX4xM6yuX3yi3JL2T2Vjs5qRhW5THgo0yDGIr4bE6wLeWHjmiM96DmBAuCIlC1GKcGiPjel8b1d/uDaL7lyC4eTQ/mhYznD5/lDOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQir9p4I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FF81F000E9;
	Sat, 13 Jun 2026 21:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781385613;
	bh=Po08mjjSFH5Dhb+ashMQyg3Cv7VZ71WKvXkpb8t6v70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RQir9p4INMeVBkFcfsoETwq/6GmaQMdLD0kbU2e8z4Iw39pmBrmesnPGMb+woZzFU
	 UJwiGwqJLyKKz8/Xr/eOlFiZ/l4Vp3aLOWVB/SGgkCxF/QDdVBiGhlmWhfXdDlK9Ue
	 sCikwygCAiHFh7459EoZ8yLKQ97ZnTw9nD3DF7qh9YcB3orMIe/XD4s+l96G33pJwq
	 8BMYBrf6+sPYvbKgTgWB4J4FgI3ANVesBM052ZjrPQkJM4IigrrhWnYzMuCuvEeotB
	 9qa4pxuoXG+Pns99Xx1TWkKQ8/UDbCFKfRM5cxYhqpPkGb7YHNjqjmOqJjogaHTgYj
	 9ggwqot1Y4VYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987F3A54A32;
	Sat, 13 Jun 2026 21:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: refine tcp_sequence() for the FIN exception
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178138560989.1597380.8334324274101107711.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 21:20:09 +0000
References: <20260608151452.706822-1-edumazet@google.com>
In-Reply-To: <20260608151452.706822-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, gmbnomis@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299051-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:gmbnomis@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C12667FC4D

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 15:14:52 +0000 you wrote:
> Commit 0e24d17bd966 ("tcp: implement RFC 7323 window retraction
> receiver requirements") removed the special FIN case that
> was added in commit 1e3bb184e941 ("tcp: re-enable acceptance of
> FIN packets when RWIN is 0").
> 
> If a peer sends a segment containing data and a FIN flag before
> it learns about our window retraction and has a buggy TCP stack,
> it might place the FIN one byte beyond what it thinks is the
> right edge of the window (i.e., max_window_edge + 1).
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: refine tcp_sequence() for the FIN exception
    https://git.kernel.org/netdev/net-next/c/91934d44468d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



