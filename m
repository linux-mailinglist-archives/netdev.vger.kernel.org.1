Return-Path: <netdev+bounces-294520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s2siNL+RH2oqnQAAu9opvQ
	(envelope-from <netdev+bounces-294520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:30:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38163633A5F
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:30:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b="X6YY1Z/U";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294520-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294520-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 707F1307C239
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47163DCD8C;
	Wed,  3 Jun 2026 02:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8A3DC4B1;
	Wed,  3 Jun 2026 02:30:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453817; cv=none; b=ouisTxpxEh2C41iJ1H1OVU2f8/qPqnFHTJrRGwbDv/YUrK0PLLsEloqJPKSk/NC/3xgO+3UmJLBLUiM9T90N2QnB13oMCuIS6GyNqY7kDwaSlzhaDzZQsitR6eqbENgO240zWOr2G9JzngsL3WARGLAKt+VGpsCieGb5QSlXHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453817; c=relaxed/simple;
	bh=UmRV/fWpwDBfoYxHLWRPnhTo2cL0CmgEtWaL05qdm7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QSM5Sz18sldP27vsyJ4TBEaq6iiz7Ix04sczTw7FZRojDL/Lc9D9QvF7mKLjt0P1+z0fX26ZDuRH9FUyFGanZ2ANguMNrfTJd9pVeEI84V2NuGfLraUKVmINPgdoOG289Tl6OKkY631W29RjCtij8DvkVfWef9cBl5ECEl27s0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6YY1Z/U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F161F00893;
	Wed,  3 Jun 2026 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780453816;
	bh=zslATiuQUoQ2ecIXBPpBnr1n5ssTXiki4SD5XB/9EKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X6YY1Z/Uq+hO232LGzWrVs4nQ8gGEE18O7LnEzsUclcqtvgD4sNPaa5sN+4VEyYX5
	 bI+0MIvg5I3yycNHcMjYwgxZA+7lum0MN8GTbww3vwteGP6Io/v26LYr5AEbD85dst
	 XRNUDKY1uvF219CscOiNn4EWYXqi2bnF9FaOMvxY52eTvAFMxOv9SEZSuN8t4RZSiZ
	 A0WjNTGUSqpYmfUcYe3m0LkVaBoIbOkyAimcTLTZSYqR5NwjTh+bvAnLV6Uj/ATG1K
	 E6vs13bugSzt5WsUuwZRFN7A27J29Z3qJk4I3rpfvAdAbGS90RZCr/y+FZn2uZJdxb
	 6RAnWW85RZEfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1993C393003B;
	Wed,  3 Jun 2026 02:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: stmmac: Improve Tx timer arm logic further
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178045381764.1178989.10990235373154874362.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jun 2026 02:30:17 +0000
References: 
 <20260529064659.32287-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To: 
 <20260529064659.32287-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Nazle@codeaurora.org, Asmade@codeaurora.org,
	Muhammad Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	TAGGED_FROM(0.00)[bounces-294520-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:Nazle@codeaurora.org,m:Asmade@codeaurora.org,m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38163633A5F

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 23:46:59 -0700 you wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Calling hrtimer_start() on an already-active txtimer is unnecessary
> and expensive. Skip the restart if the timer is already active by
> adding an hrtimer_active() check before hrtimer_start().
> 
> Previously, each packet reset the timer to tx_coal_timer in the future,
> acting as a sliding window that delayed NAPI under burst traffic. With
> this change, an already-active timer is left to fire sooner, scheduling
> NAPI within tx_coal_timer of the first packet and freeing TX descriptors
> earlier.
> 
> [...]

Here is the summary with links:
  - [v3] net: stmmac: Improve Tx timer arm logic further
    https://git.kernel.org/netdev/net-next/c/edceeba4af3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



