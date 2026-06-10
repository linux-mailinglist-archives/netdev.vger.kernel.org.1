Return-Path: <netdev+bounces-297394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LZDEF6fAKGpGJAMAu9opvQ
	(envelope-from <netdev+bounces-297394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:40:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE97A665458
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:40:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nph6H4mt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297394-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297394-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44C683056635
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616D223392A;
	Wed, 10 Jun 2026 01:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E809289E13
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:40:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055611; cv=none; b=Zy3ofsqm8v91bShjax8WPl5m594ZwFn26XwOXI8d4ApR151vnswd0aXmpjrCtW/kqLyTFCRhVxpKcWYXGXSzJ2QGszJPla1k3ufBOr1H65gk56ZG9VrreQBMnpYQ/fD2rBe+NkZ9SGeAsGxinYzWRmntNmNDdaf9P9+XSJxgLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055611; c=relaxed/simple;
	bh=QUg5sEOTOKQeaod+vkpige23G3mjuIfD+yDe4tsRtEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PZFEve9cDfwjZAlOw+33QUfXNbb8EoIrOK3R0J0wt35JMybo25WTKfAWJfNl8IU/DfC9svJFCzFQyYtPLAsfTTGmdRKQgGBjXXEH9ZGOctzuk2PTS6ezeCM/cNIbWq9f33PIVKi9UGPiZlYe/LzINrh6zSYxoEQy296cIJaubvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nph6H4mt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F016A1F00893;
	Wed, 10 Jun 2026 01:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781055610;
	bh=+6SFWH1nclcSX4NXUMWwZUYwNq+QOIeK5PggdjWZfow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nph6H4mtTmXUkqk5T0lHsNYqIHYLQ7iLeIFPkSC22YqnTMS5SqznaR9BezNIBNAEE
	 NVk614ikXB+eboaGY33zLfia1kM6cmoZJL0fQ+MtoutD1KzyzIfhShKz0eeD8W/h7C
	 qJ5V8TGiX6WOw6iuvU42qTkF6WTp0++07JrmyrpU2I5Zjv44wtJsG9+63y7EoYQf9Q
	 It1bH01ZAk7gUV1j0AyouBmQeBukmwLvcjE+gUFAMCm2/hkrLOLRVafGtZXCpTi7/l
	 gUj2O+Db35gZgvMCWkCEE1WCk6sVRtiABoxJ/flpN0Y4B6KsryYDAKTuHtkOtHhASP
	 v/CDY6bDSdqgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5680A3930A1F;
	Wed, 10 Jun 2026 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip6_vti: set netns_immutable on the fallback device.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105560789.2786170.11425771545973631922.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:40:07 +0000
References: <20260608155918.787644-1-edumazet@google.com>
In-Reply-To: <20260608155918.787644-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, noamr@ssd-disclosure.com,
 nicolas.dichtel@6wind.com, steffen.klassert@secunet.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,ssd-disclosure.com,6wind.com,secunet.com];
	TAGGED_FROM(0.00)[bounces-297394-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:noamr@ssd-disclosure.com,m:nicolas.dichtel@6wind.com,m:steffen.klassert@secunet.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE97A665458

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 15:59:18 +0000 you wrote:
> john1988 and Noam Rathaus reported that vti6_init_net() does not set the
> netns_immutable flag on the per-netns fallback tunnel device (ip6_vti0).
> 
> Other similar tunnel drivers (like ip6_tunnel, sit, ip6_gre, and ip_tunnel)
> correctly set this flag during their fallback device initialization to
> prevent them from being moved to another network namespace.
> 
> [...]

Here is the summary with links:
  - [net] ip6_vti: set netns_immutable on the fallback device.
    https://git.kernel.org/netdev/net/c/d289d5307762

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



