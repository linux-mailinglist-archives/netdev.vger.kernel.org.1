Return-Path: <netdev+bounces-303426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zjCpOqRfRGrztgoAu9opvQ
	(envelope-from <netdev+bounces-303426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:30:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 515D46E8EC6
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:30:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hC5DofeT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303426-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303426-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5927B300E24E
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64F1B4223;
	Wed,  1 Jul 2026 00:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6017C211;
	Wed,  1 Jul 2026 00:30:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865824; cv=none; b=j1VN5h4aCARNUZf27T+WcQZQKczu0CLx3GmS6WJ7TkFJKlpPlC+Ypw22yJ2aRs4VIeGWJlRf9FGo0fLI39GXYZLhM8pwrUPNOBHuHKUit9Gt3nWYJEfWP5d2kF9Yqd/8LW+zvlE+NoTm4dp0AkIVoQi7EyGckex3XUK5oK4xNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865824; c=relaxed/simple;
	bh=pYwbjf/cyqt4q3Kk2dXIhbksoPHKn56eeg4262reB50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P/zzZBqtf2XmoqkULTTUhEHCyVbMrB8BK2RNnmRHI7Wy15Jr71BKJOiLcu5OOOUAaiMWdye+0vmtCBd4lzL/sXdk+ejhy7bqWSnJCgjgskYoNbXkyQGfwxDZOpLOd3rBQIx9yAzpudLwjz/mgFBQuXzwnv1HRgCcK9dkxCp/Ml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hC5DofeT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3421F000E9;
	Wed,  1 Jul 2026 00:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865822;
	bh=tUYCaFY6QdTOkOX6R5QEq54defo8SKOANe+5WX+xyco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hC5DofeT0+8Ygdk2MUcd9eQR9wGyeJP4u6j6bK19qmHIsMZsgmPdSC3IUOgyWutju
	 ZmmgZUCbHfetAgNFrjq16OchCNYnhiYrMqHtwJyRo4ExL489PQc96+JKXLKkEXuZkv
	 Gx+krz6d/smsy6TEBl1BepBXHtmNg0JIvcrRldm3HPAk3djzPRJnlC3pLvotpOTLkS
	 b7F1/x+n8WAB4fUAe5hfiaZ1wntxMFRHv0g67wOoTP5lckFY390FCl1MzERaMAaC1g
	 fci70bDzTJ+0WWt8N+6f3uCcymnUVlXBaO2SJqf61q2QmECKcvd2NM8Lm2/ZJhWH8T
	 hZVF/DsdCJQtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939DC393A964;
	Wed,  1 Jul 2026 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] cxgb4: Fix decode strings dump for T6 adapters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178286580614.352416.780057618509971566.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 00:30:06 +0000
References: <20260629130856.1168-1-markov.gi@npc-ksb.ru>
In-Reply-To: <20260629130856.1168-1-markov.gi@npc-ksb.ru>
To: Markov Gleb <markov.gi@npc-ksb.ru>
Cc: bharat@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
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
	TAGGED_FROM(0.00)[bounces-303426-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:markov.gi@npc-ksb.ru,m:bharat@chelsio.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,npc-ksb.ru:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 515D46E8EC6

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 16:08:54 +0300 you wrote:
> From: Gleb Markov <markov.gi@npc-ksb.ru>
> 
> Depending on the value of chip_version, the correct decode set is selected.
> However, the subsequent matching with the t4 encoding type in the if-else
> block results in a reassignment, which leads to the loss of support for
> t6_decode as well as reinitializing of values t4_decode and t5_decode.
> 
> [...]

Here is the summary with links:
  - [net] cxgb4: Fix decode strings dump for T6 adapters
    https://git.kernel.org/netdev/net/c/5d6dc22d6268

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



