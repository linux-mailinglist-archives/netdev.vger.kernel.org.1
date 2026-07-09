Return-Path: <netdev+bounces-306177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JTMRHb6AT2o5iQIAu9opvQ
	(envelope-from <netdev+bounces-306177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 13:06:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B67137300AA
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 13:06:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lqaGO8hT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306177-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306177-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B795331338B5
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1CE3FB7E0;
	Thu,  9 Jul 2026 10:40:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E6409292;
	Thu,  9 Jul 2026 10:40:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593631; cv=none; b=T2/ok9SlYtET7BE4GA2OcsBYHiUA3ASkM4coju6m7QlZnM/ghfvGuOeCMIfdzIgm9feTH73IHNHyZZs25klZvZTcdFhWdVxov3PwSziBd98lBXlntNGjq9S4O/FesDEGKn1A+FQC5Km6xtiEGBWKJR0foGXjLJ2hnAy7cbsP97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593631; c=relaxed/simple;
	bh=0+mmxk0Q2jOEjhMA6+4OrZj3k4MCVIL9QCT6aywmDas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qyuaQLWQcHI+wVfONv6BNDnHSJzt5/jEo7vP3opCcJgrizPbzt5HoxPkvkOGzauT6M7SEiFd9n1cGdm+o2hERB7HxckX10k2tAEBaNhb7uZao7F2pG9ZisO0Qavd3SF7X8JIVzUNe30IY5xoG+R3qTNqjnHfuS938kEJXWt1v9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqaGO8hT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54E21F000E9;
	Thu,  9 Jul 2026 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783593628;
	bh=vkOd4iAUiJ6n2QUtcEjpc5vGqssHjYoRrqkbCvolS18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lqaGO8hTedWUFNbdgJezcbre2D9HKfbytKsdCAR6dchw2UiWeWmel3JOWQUnck66q
	 LTQJAe0WYXn/T5AFKaXuuHo6VWzIXssMqRigJ7nY/rOu1HvBj162zM0vv1lVFVQpP+
	 2yYdkt+rGI2u5mbAHxefBs02lXP7qpkR7OUVN+ZHxRAbTdP3WLu6m35TnbAD5vJIaI
	 pfZNjiWIFYbMqV1v7FCGmnvpiQqHmYkTdnnA+g4Of2Lrz/sn96m7mdTcuqgNp7a/Ds
	 5a4BaYMjdFL38yFExmA8rB2pSj8CrFjOBrQQTF7TL8R8lg6swZkM8lPOKy6vbyxQm6
	 WEkx87oZ2dxkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B2039D609B;
	Thu,  9 Jul 2026 10:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net : bonding : Remove TODO comment about retrying
 setting
 the MAC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178359360714.3403147.176396086169787143.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 10:40:07 +0000
References: <20260703125513.694324-1-paritosh.potukuchi@amd.com>
In-Reply-To: <20260703125513.694324-1-paritosh.potukuchi@amd.com>
To: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jv@jvosburgh.net,
 paritosh.potukuchi@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306177-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:paritoshpotukuchi@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jv@jvosburgh.net,m:paritosh.potukuchi@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B67137300AA

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Jul 2026 12:55:12 +0000 you wrote:
> As correctly pointed out by Jay Vosburgh,
> 
> "This comment dates to sometime before git, when it was common for
> network device drivers to lack the ability to change the MAC while the
> interface is up.  To the best of my knowledge, that isn't a issue
> today."
> 
> [...]

Here is the summary with links:
  - net : bonding : Remove TODO comment about retrying setting the MAC
    https://git.kernel.org/netdev/net-next/c/0e74441edefc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



