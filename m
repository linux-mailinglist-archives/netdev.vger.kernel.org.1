Return-Path: <netdev+bounces-301485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tzclAWzvOmpwMAgAu9opvQ
	(envelope-from <netdev+bounces-301485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:41:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6306BA122
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:41:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BkKCGoEO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301485-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301485-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81A15308F8B5
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE13A75A6;
	Tue, 23 Jun 2026 20:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E13A6F19
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:40:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247222; cv=none; b=Q5eqQQvU392RIXU7/bXaqj5xLPK/VkRWZT+aOUBNGDe3dNgg6MqtJeuyuHbNOkZAATRy3Dd+r53nA4wzltzleRZSyXxs+1v7ux1ywLPfPIKxEDaWvGmopqtcIAzFjd5ONvkx+aEifmsuibU6cnwO3ByNgjZrorrp0kx2pH+3MjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247222; c=relaxed/simple;
	bh=888KVhgHm4zZtlcn9H81Av45V+cO8vyTuxujhwS1Shg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZoMoF/4YyA+bCLXkFKTUzhqi5/222lGN4jjHjVouVKEWkeOoOAZ9J2uHs2HwFv0MJsRXtn1ck5zuprh7+TdnoejSC0NKBHqrrTwh86fIgT1w6qZuRzzGTJJ5YqXWTw3OAvP/OIu0Y4BwqCL13caWGNtSwZFL5ven4GEEU4vMtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkKCGoEO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E041F000E9;
	Tue, 23 Jun 2026 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782247221;
	bh=AMcpquJMVliWCyVZpJVdP+uhF1fM/B/VVl+0HBiNrFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BkKCGoEO1hf3YhviPT1C0bP64ZqgQsZrhgVcMF4kWb6E1AiTeKELbfYTqw60uH921
	 2tWluMaDcn8Af9ijoAvovMewR+9AM8EucJ71jDxPr35ogKyycGLxbxyjBpLXnJdqYZ
	 FOhXCamRTtkP4CvMp4E+nwN+iZe4x3c1D++WkCs8P1N/iPf0j67dYYNNzTWdvY1ZKR
	 E+nP+5HzW6Xu+5KCX4Nhj24RyLKYp4vtO+0M+UTXoe78kryuGbsK0LbEDubAVr+LUW
	 MO/dzhnjTL4rdGenFKQeT59s30Z/uK1Hae8uYi3KLvpTGK7zpP3y4/y8aaoXtFM/TU
	 pEL1k50X6lkWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D43931005;
	Tue, 23 Jun 2026 20:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: airoha: Fix TX scheduler queue mask loop
 upper
 bound
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178224721075.2409533.1841899511926101005.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 20:40:10 +0000
References: <178187479434.2400840.1312143943526335838@gmail.com>
In-Reply-To: <178187479434.2400840.1312143943526335838@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-301485-lists,netdev=lfdr.de,netdevbpf];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F6306BA122

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 21:12:06 +0800 you wrote:
> In airoha_qdma_set_chan_tx_sched(), the loop clearing queue mask was
> using AIROHA_NUM_TX_RING (32) instead of AIROHA_NUM_QOS_QUEUES (8).
> 
> Each channel has 8 queues, and TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i)
> computes BIT(i + (channel * 8)). With i ranging 0..31, this causes:
> - channel 0: clears bit 0..31 (all 4 channels) instead of 0..7
> - channel 1: clears bit 8..31 (channels 1-3) instead of 8..15
> - channel 2: clears bit 16..31 (channels 2-3) instead of 16..23
> - channel 3: clears bit 24..31 (channel 3 only) - correct by accident
> 
> [...]

Here is the summary with links:
  - [v3,net] net: airoha: Fix TX scheduler queue mask loop upper bound
    https://git.kernel.org/netdev/net/c/245043dfc210

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



