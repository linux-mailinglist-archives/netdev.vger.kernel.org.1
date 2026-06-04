Return-Path: <netdev+bounces-295033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1+zTKYHjIGqk8wAAu9opvQ
	(envelope-from <netdev+bounces-295033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:31:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C39F63C85D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:31:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f0RjVvaV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295033-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295033-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2166230577C4
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DF439524D;
	Thu,  4 Jun 2026 02:30:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBE738AC9C;
	Thu,  4 Jun 2026 02:30:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540219; cv=none; b=XL1bTRddh89Mxp5aZktEiVlhPT2pt9FiioUSftUbpTJ1wknBwpMj9TXG8IokyA7r5XWoLvM8j3DzeA901u/b7IieQ7HpDbey6JJy8yHuCX7tY+XPnxQGEfUK4fGbqpriBUt6PAmfNlxs4msXg5cMXxGUzlaI8E+hkGTeOuWrab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540219; c=relaxed/simple;
	bh=OkBpDNVBLnLr8GbbrG/57GXRcQQO6nBaWovVWvU4nd4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DyIiLaCH/FTUdTU8AnHYSszPwrzuao8cCG8d5oh4kOJ/2ibFTQypHOrDm0WO91ZOav5khT+HE430f5pNGBQdObDZlGBWDgUpPT24zcaC0QFbkl73PLsoCEB+dRAlILi7Jwrg7zCqt80aCKsJIOjryoOAvJ/Fl2I455l1G6N4aPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0RjVvaV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332D71F00893;
	Thu,  4 Jun 2026 02:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780540218;
	bh=gJZ51moKH/Fl5apdorABxKRD8vG3tBqQUGlUHnSqB9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f0RjVvaV+faPfCD4qKTd8hBQ2jkv/r6lBIWEA8p1hKQ8p4O6QWjhbYQ89Wa/cj9lw
	 JV1Kz1FPpJ2LdhJqhDpVBvMnJkJvlK6U8LCHzO/jKe0KanFpDqahyFco13FmiG7z3V
	 cXKcrH+x8TTNod6/TeMoFOG7A0cH6+/XveXNAb0H4thIAke8W3O0CYyU9vCcDC8QRJ
	 AUCngmKAdVbvOu5U/wfTopUif5d3LmcYApea0SWHIQpJruhBr2uWTJ2rvsvJn7St+x
	 fGuK315eN4jRKTZMbptjBEiH59kUIZHpYA52NoQd0Q2klPNPY38P98bYWDFv7cW4jr
	 Xpa9VtYLM+a/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939EE39308E6;
	Thu,  4 Jun 2026 02:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net next] net: axienet: Use dedicated ethtool_ops for the
 dmaengine path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178054021914.2211213.5101312493242393925.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:30:19 +0000
References: <20260601124454.3384601-1-suraj.gupta2@amd.com>
In-Reply-To: <20260601124454.3384601-1-suraj.gupta2@amd.com>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 sean.anderson@linux.dev, radhey.shyam.pandey@amd.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, harini.katakam@amd.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295033-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:suraj.gupta2@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michal.simek@amd.com,m:sean.anderson@linux.dev,m:radhey.shyam.pandey@amd.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:harini.katakam@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C39F63C85D

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Jun 2026 18:14:54 +0530 you wrote:
> The dmaengine path shares ethtool_ops with the legacy AXI DMA path,
> including .get_coalesce/.set_coalesce that poke XAXIDMA_*_CR_OFFSET
> directly. In dmaengine mode lp->dma_regs is not mapped by axienet, so
> those ethtool calls touch unmapped/unrelated memory and report values
> unrelated to the channel actually in use.
> 
> .get_ringparam/.set_ringparam only touch lp->rx_bd_num/lp->tx_bd_num,
> fields used only by the legacy path for BD ring sizing. In dmaengine
> mode the descriptor ring is owned by the dmaengine provider and these
> fields are not consulted, so reporting them is misleading.
> 
> [...]

Here is the summary with links:
  - [net,next] net: axienet: Use dedicated ethtool_ops for the dmaengine path
    https://git.kernel.org/netdev/net-next/c/c1c3d01e3a90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



