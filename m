Return-Path: <netdev+bounces-300905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ltyIJkdaOGqFbQcAu9opvQ
	(envelope-from <netdev+bounces-300905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 23:40:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE106AB9D0
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 23:40:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g5tLnUSL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300905-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300905-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FBB23019050
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 21:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290F82D73B8;
	Sun, 21 Jun 2026 21:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F71DB92C
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 21:40:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078021; cv=none; b=L7RbafYVdBD1Ghift6QWzwW/BvtPnkRg2miD4qkqam8uM7Tr6kaOj4XrV3LxcvzdcSGGuAF7rpwvz4KCwZULGpkj4MwrsAt+pbxYBQTGBYuIfEzgo21Fx9lKhUlr8Su23SNsroX6P9WHxIejnpx11H4dHIdbhE9uEz+R9mJLJMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078021; c=relaxed/simple;
	bh=EOKoGpe9S/y70SBxt6sT7i9M0hkdYyekOw9nQTpeTMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qMRIxoyNZcqW9Q1jIl2Ha+kBC7ILISz/koOPRY70xEogCvohKTjIs+5QXez3BOXjBQhSDXkbYOWC033u9YH38ru4CwY8XouBl/waHaKT2mEwKK2v7bkyo/d7Z7OW8ELfXRTgzYqBuW7g20SbSq9NJm/+HCZOFhcZJ1+1bPHGQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5tLnUSL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95721F000E9;
	Sun, 21 Jun 2026 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078019;
	bh=dlhG6VVL7e735uRZLwmq98hxfSpDNi0y5BfFxqio2bA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g5tLnUSLVvAqXwiw9rKtczs152mWsRC3zISrtZI+zsHJyilqlS6HlaS9OuCtaDbH8
	 RzzxRvfmDyjxbHSDM6Uln4KVBknpegvqPB7BpEfDCo2BFRIxQvCsPDdZCDac0xSwsL
	 SXyRp7be76av0rQzm7ZPUMBvcSEb5mzS4Z7MIVHpv5LqOAHOeiIZbuO2gQeCv63pVL
	 x6MCRC9fqLOJROd+48Lr9Ip0st0DgfWtQhm+jcCFELB7l6xPwujM+84CkvQp71IpXw
	 Cq/0XICyEcquqgenXhjbeJC8j+SqPULoO0M0BYvexqoKGykFcaXouncGy5zkpf7815
	 W2vOm5Br/sw7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D93AAA6E4;
	Sun, 21 Jun 2026 21:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_ppe: Fix rhashtable leak in
 mtk_ppe_init error paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207801105.510072.2195645518730276699.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 21:40:11 +0000
References: <178167550101.2217645.14579307712717502425@gmail.com>
In-Reply-To: <178167550101.2217645.14579307712717502425@gmail.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300905-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFE106AB9D0

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 13:48:13 +0800 you wrote:
> In mtk_ppe_init(), when accounting is enabled, the error paths for
> dmam_alloc_coherent(mib) and devm_kzalloc(acct) failures return NULL
> directly, bypassing the err_free_l2_flows label that destroys the
> rhashtable initialized earlier.
> 
> While this leak only occurs during probe (not runtime) and the leaked
> memory is minimal (an empty rhash table), fixing it ensures proper
> error path cleanup consistency.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_ppe: Fix rhashtable leak in mtk_ppe_init error paths
    https://git.kernel.org/netdev/net/c/41782770be56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



