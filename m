Return-Path: <netdev+bounces-300280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /cKDBwg6M2oQ+gUAu9opvQ
	(envelope-from <netdev+bounces-300280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 02:21:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1CD69CDD7
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 02:21:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cmLNKJkA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300280-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300280-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0B61303517A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9D233943;
	Thu, 18 Jun 2026 00:21:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247A40D56F
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 00:21:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742061; cv=none; b=TNGrAKjMbVWFW89ze5ESFMSBUn5BY9uKl+EiGbrA2AdqjEFTKOK44w/8VdiXGX+B/fIf0R3uTDbvZvF9PctCHAQNzB5knxtwOLELZlvnLCTNgLXxZXHW4AAGRsNLclWUbcqVO1ywe554HftbRWkrSLcAfmPk0UPCfQSTeOkS0lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742061; c=relaxed/simple;
	bh=8eWueccu3LOtZoris0rEasgWqyxVv8cPWbRFhVeU4rQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aVrjM4oZf9f3cSog2Sr9+XOxuAhi1e5HvFCUQd9r3EfDDk+8RStjOqOJYDvyHfPu0KVScs4GtX8rrIqrAmcKhI5K0zRm3+lZC6ySfaPmUySYzX3UtALHnO31T6WYl8c0bXW9tZWCOolEVQpO0OnsFH7M0E9hgEqPz0EqAisJ6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmLNKJkA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B2B1F00A3D;
	Thu, 18 Jun 2026 00:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742060;
	bh=Y36d3c9E+J3nQ2hIY9KPFdRkxun7FQwJj96D5/KofuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cmLNKJkAWEYPv96ZZeS67kU8bzAykkPraRXUF75VxaWxt3LRWDvB/PItFZhrPlXA/
	 mxvtwaSFKqwRVE2tBITV32GyjCjGF/BPwG6Afl41H4Sg2VWICxUGhI3t0JuASi6cq6
	 iS+8BV16YbvzuYIV79+6SJK/r6M/nIRHIX/q/MLUdmai9xaT6dPWrDZA47YrjsRoqa
	 EUJXiprKLkao6INhU/v+YhfhRghMnS3dTpNVjhadkd13RL5E4oQly8U7zXGzZHw48c
	 PLNmZMgGNd5XV5zUlhZtX6aRjBFmIlrcgPW4mCnfe4mSJ/DxQOcYbq+BAyJy416TTz
	 mkO24dQIPnejg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197EE393102B;
	Thu, 18 Jun 2026 00:20:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: psample: fix info leak in PSAMPLE_ATTR_DATA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174205363.1875263.12586731210463427377.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:20:53 +0000
References: <20260616003046.1099490-1-kuba@kernel.org>
In-Reply-To: <20260616003046.1099490-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bestswngs@gmail.com, yotam.gi@gmail.com, jhs@mojatatu.com, jiri@resnulli.us
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,mojatatu.com,resnulli.us];
	TAGGED_FROM(0.00)[bounces-300280-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bestswngs@gmail.com,m:yotam.gi@gmail.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:andrew@lunn.ch,m:yotamgi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D1CD69CDD7

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 17:30:46 -0700 you wrote:
> psample open codes nla_put() presumably to avoid wiping
> the data with 0s just to override it with packet data.
> This open coding is missing clearing the pad, however,
> each netlink attr is padded to 4B and data_len may
> not be divisible by 4B.
> 
> Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: psample: fix info leak in PSAMPLE_ATTR_DATA
    https://git.kernel.org/netdev/net/c/aedd02af1f8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



