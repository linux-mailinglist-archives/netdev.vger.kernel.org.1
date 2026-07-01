Return-Path: <netdev+bounces-303532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RtvWBqfMRGpr1AoAu9opvQ
	(envelope-from <netdev+bounces-303532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:15:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 609D36EB01A
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:15:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="E/2FfiRT";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303532-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303532-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99DD030E4FB5
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC623CF02B;
	Wed,  1 Jul 2026 08:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDED3B0AE3;
	Wed,  1 Jul 2026 08:10:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893429; cv=none; b=g1cE3bUb+OgbC9IPvDcJ0gIYO8GgYMFKkJYq/l1zAlBiqxhYetco5f0bkVteDpWxRs3vQ3dKrYKph9+SoAQjuhI2hnGjcE+qapdW2Zpo0Jhz83RB1oLBfPtMp8IE+KEhoUrBNc3u/iDRNgTrd2hM3hwWv5c6Z0QUTkLD6D9UZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893429; c=relaxed/simple;
	bh=m+W72GU6fk6j/ipI2VH5khUO4i1YsC/uDIYQR1TodcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WLrCv54gjbbXlZ+f89WFlnEYuXMEzAtvtWb0P+OdgKPLFXp6LvGeU0T6h8+psv0X2cq5ZghP4HHJOmQrHysUEFbkQJO6SVrOxhL+w3BBa4wxaIzO6v9/y9tR03f3qecC7sBf29TreRsCGxckr6USLL71Yi6bfJc0gpHiPUBI848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/2FfiRT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B231F000E9;
	Wed,  1 Jul 2026 08:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782893428;
	bh=9CmvUjMCbjjBNuCpOlolSnqaOTQ0xjcsUr6Vs8rofZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E/2FfiRThfiAXxsDOjQ4Tx96a4W9E9MnS4sLDhCcA0EFJiZ+qMZchFhbKLSygvFJ3
	 DNvYKl1pF9baqHesQpKE/5hWBdj4Cm6Bt3M/cwDpHfWNdegyTRUJZwOfBrZKNcTsnj
	 JoPjYXmRQyKx2GEqHkPcu1Rk1vNWDXMTmDP4dU2uzjZGsqNP8ME57gP/sjssxXtBGH
	 oz1L7fylwoIXL+3ezWy9BulsfuHWSf8lnVaod9niSx1PDwj/Fyj3PzgqSAXTDwTQ9k
	 qrpe56gFPuBV09TyX16BhddPAs/A9ecs/HeVTHAM3I4Yrj/iL6bXUTPSthBPw2rvFo
	 zY9dp8DUUQ89w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD93926651;
	Wed,  1 Jul 2026 08:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net/sched: hhf: clear heavy-hitter state on reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178289341188.500901.4629917066016960324.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 08:10:11 +0000
References: 
 <20260629164458.195029.ab92a1db1120.hhf-reset-stale-classifier@trailofbits.com>
In-Reply-To: 
 <20260629164458.195029.ab92a1db1120.hhf-reset-stale-classifier@trailofbits.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vtlam@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-303532-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:vtlam@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,davemloft.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 609D36EB01A

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 29 Jun 2026 16:44:59 +0000 you wrote:
> HHF reset does not clear the classifier state used to identify heavy
> hitters.  Packets after reset can therefore be scheduled using flow
> history from before the reset.
> 
> The reset operation should return the qdisc to an empty state.
> 
> Clear the heavy-hitter classifier tables when HHF is reset.
> 
> [...]

Here is the summary with links:
  - [v2] net/sched: hhf: clear heavy-hitter state on reset
    https://git.kernel.org/netdev/net/c/a225f8c20712

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



