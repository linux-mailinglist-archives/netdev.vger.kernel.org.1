Return-Path: <netdev+bounces-299640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zOKvE6uBMGqsTwUAu9opvQ
	(envelope-from <netdev+bounces-299640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:50:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4162968A787
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:50:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="G/eSgO6v";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299640-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299640-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E5B93002B7B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463B337F731;
	Mon, 15 Jun 2026 22:50:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6079CD
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 22:50:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563812; cv=none; b=WbLqcPzRXRAUQQAMEjuxe/yVPYkuQSTxUeyaRYYr8Som14o7BPpK6az2w/LzgbGGwLNhe933+EXvY4q/0MvcWHp4DxY0aSj7x0/4ktRPFtP3SxnTbTtLdKDGMtrGTB2Uwq+i25+rTGlNZb9EvnbOvGK/299VLywGVCcGUa1BnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563812; c=relaxed/simple;
	bh=9IfPHaM2qg9a1ZJo/KxopywVgwethcP2rKtKLON0IhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zefb/1ISdct6GtmZdy8eLee6dGwbnUDeV1QDxOXnrw2luv/wF6k1nfNnHxiZcx+cGCzIK9JeYABFhmRiblxC09ctouHjUnuM3y3Qk4DVLiSkjAFEoPOginGEnzV218aktIjOj7I3VxS0t2LUzn8yv1LOcabGvr+5vI53I2Z7Q3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/eSgO6v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18121F000E9;
	Mon, 15 Jun 2026 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563810;
	bh=+UuQVCAyUvse1CZNlmPDFh59OEsUZB+xGlZxHGND+n8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G/eSgO6vZTW3YbchjfabTrxKMJadLhtgPRAsobGJN8TnxIW2rMClT9+2+M/Tkm4+X
	 RiIV6X3pqHoJoK5yotO8qkx7cnS9Ur23r8FraMx3w/mviMytAN/2uVBzdkVuPUxNkc
	 ePFQpu84tp8hATKLJdM6RTpAeGoCNLhV3fMUicW+DffIIAyOj119ouhie1h06wq0k2
	 ZVx2XbXoNl0JurGU2OfW9VG32vJLFiMbQrVHdUf5uLD0mciXNobQfnqRYcdQi2op1k
	 zMog6+d1Y8fNI1wYeH+sQiMAGuN5uZImpEsFlJKahJdiHIfASg5hhNIE4Kqj3SCIZa
	 K+1x7ZVauUC7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199623839A08;
	Mon, 15 Jun 2026 22:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: airoha: Fix always-true condition in PPE1 queue
 reservation loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156380564.325968.12566495684945605433.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 22:50:05 +0000
References: <6a2ca3de.ad59c0a6.147df9.2ac1@mx.google.com>
In-Reply-To: <6a2ca3de.ad59c0a6.147df9.2ac1@mx.google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299640-lists,netdev=lfdr.de,netdevbpf];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4162968A787

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jun 2026 08:23:12 +0800 you wrote:
> In airoha_fe_pse_ports_init(), the inner condition for PPE1 queue
> reservation is identical to the for-loop bound, making it always true
> and the else branch dead code:
> 
>   for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_PPE1]; q++) {
>       if (q < pse_port_num_queues[FE_PSE_PORT_PPE1])  /* always true */
>           set RSV_PAGES;
>       else
>           set 0;  /* unreachable */
>   }
> 
> [...]

Here is the summary with links:
  - net: airoha: Fix always-true condition in PPE1 queue reservation loop
    https://git.kernel.org/netdev/net/c/c66f8511a810

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



