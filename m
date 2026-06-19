Return-Path: <netdev+bounces-300560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1RtnObOUNGr9bwYAu9opvQ
	(envelope-from <netdev+bounces-300560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:00:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA9A6A37C5
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:00:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Esw7hyB9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300560-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300560-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 777D9303ECDD
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC44282F26;
	Fri, 19 Jun 2026 01:00:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452A275870;
	Fri, 19 Jun 2026 01:00:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830816; cv=none; b=lYavd8jro9JDTEt3Y+2ZfTdOcdqLIdFYCsVPczRZvhCS6sLBmeK/ac1j9tEpYrSFZWilePuMdmyOMgLxn7xrJ+EFn+2uvEeqnsJgKkyO5FQHq0OTckQ5K+hNuWuSQH1v/fL1ZNWm6mf+rt3Lv5zIfpyHVq9kxMhHXheswrPlQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830816; c=relaxed/simple;
	bh=Dzr2lu7db8HJGgS7abNaDmcpYQrSr4zFu5mGHvmRm+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NMJbvHfE6KciF3oiIdVKJiNWamD1VZmmXkuS8pbxy9ISTL0Rlq1PrAF5eHez38J4K73T/AJQ1KwBv0OfLw1UtY5P2EEEcZiRYrc6SrrvhaDjZT8BSEMw0ZL/2iEWigAVFGRbZNg6zAaV7Kt8fWLkGvxf5x8Ebpnm3NortN+2UCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esw7hyB9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC441F000E9;
	Fri, 19 Jun 2026 01:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830815;
	bh=ryWbyGXApqhl6vmfED+Rh4w1DRsyT4L+xzSDyv8c/Bg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Esw7hyB9M9sft345veXwg6nC94M7zkW7piFgTp5FdnPhgISlu1jW9gqQvBaCxyXmY
	 UWV7vfTySqHRfWEReLkxpMVb+juRagHwHyVfLSVr+wf+RMv+dxQIxpY8XY0o++CTVS
	 80/QFfxPGsIC0vRL2E62XdS6saB7Bn77tVCjsGneSCV9ZonS6UVQrLXaAt1QUD3e6C
	 h/xp1Q7G2zwRgHkOX50sMGf/6Gi9FK6d6nuRjJF5bB+ysuzO8xMPBRrAacWqAG87Ts
	 9iFtOixPtZRila53GL9Wu2mlKjHH9iLcy+eK8nrpTBrxlrbsrFDGx+QedL6x6HQxxU
	 8dmjJWp6VHSQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A2F3A78A7C;
	Fri, 19 Jun 2026 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpaa2-switch: fix VLAN upper check not rejecting
 bridge
 join
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183080863.3146201.970396959346690558.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:00:08 +0000
References: <20260616105430.3725910-1-ioana.ciornei@nxp.com>
In-Reply-To: <20260616105430.3725910-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 f.fainelli@gmail.com, vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,nxp.com];
	TAGGED_FROM(0.00)[bounces-300560-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ioana.ciornei@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:f.fainelli@gmail.com,m:vladimir.oltean@nxp.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FA9A6A37C5

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 13:54:30 +0300 you wrote:
> The blamed commit refactored the prechangeupper event handling but
> failed to actually return an error in case
> dpaa2_switch_prevent_bridging_with_8021q_upper() detected a 802.1q upper
> on a port which tries to join a bridge. Fix this by returning err
> instead of 0.
> 
> Fixes: 45035febc495 ("net: dpaa2-switch: refactor prechangeupper sanity checks")
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net] dpaa2-switch: fix VLAN upper check not rejecting bridge join
    https://git.kernel.org/netdev/net/c/ed2294f94e34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



