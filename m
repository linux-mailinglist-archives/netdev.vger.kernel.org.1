Return-Path: <netdev+bounces-268811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHlALajiuWmnPAIAu9opvQ
	(envelope-from <netdev+bounces-268811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:24:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 401522B4459
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DC38301A7C6
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4003936F43F;
	Tue, 17 Mar 2026 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xevan37Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B78A21D596;
	Tue, 17 Mar 2026 23:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789614; cv=none; b=cAAE9QquFbpII47PENQY8OQkNhgI9PQYcBGPxvG/kNZBvcjlplXYhyPiandWz/5jV5oVDDC1J4EMGnfO+ptLoFutfHq6MdE4dhToOtO4OXNQXyivEisfrD/8KRpwDQUsi+IHvcTYe4OUm2JuUq/wwC1qCE4zw++5KuacjN5wVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789614; c=relaxed/simple;
	bh=UyK+xnkMEe+svdkkGSGYMgb3jdSfZWsGUgOTS6PaN2E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=emfApb6I7EIU5FO2P0Sze826m+WU2PDq3dEvSezRwGCyP1XgbK+AVA9O+cW+MLBBCu20pDCGmZ5+KdGOw8tgvGVDJPhaZT2m7cZl7b7idIbUSdReLI5ZFRIMlmMe8zFC2qE6IKYqJT3TyzlZlWmqud3Lh9KaMpxsF4g0bovgeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xevan37Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C7EC4CEF7;
	Tue, 17 Mar 2026 23:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773789613;
	bh=UyK+xnkMEe+svdkkGSGYMgb3jdSfZWsGUgOTS6PaN2E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xevan37YakH6PoCt7mNLmHzd+QdmStpPBfZSQg9iwH3UaKUAvJ/BTtjnfj8d5Q6Wq
	 2QvEwqd5d+d8FcGTOcqmjUNnc3YP/pKpvZFxITev/qgDpRT1ldM8IteN6Zsx35et0t
	 Z84d81UkzffSLJZBwxAiWP8iso2GFkMDdmmLPb5law7WIoZpXhAm5z/EPU7H+q581r
	 dwlk7IbzD5wO43PaMrQjMDMZQG0okNrCOKgbsFpN4xbCC0F3ireJH0SXLlrA+tn8z6
	 ARjuKx4i892bdkZbhvspu27+4R5MgoBmnN/ChO2rnwpx6EN3t6ECswRZi0DC2N7RZz
	 FMWW2P6BRQ1XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DFC3808200;
	Tue, 17 Mar 2026 23:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: mxl-gpy: add PHY-level statistics
 via
 ethtool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177378960579.53238.13018456125379529075.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 23:20:05 +0000
References: 
 <0029a2fb29bfdcc26abff828d2e18400067b5c58.1773587924.git.daniel@makrotopia.org>
In-Reply-To: 
 <0029a2fb29bfdcc26abff828d2e18400067b5c58.1773587924.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: lxu@maxlinear.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[maxlinear.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268811-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 401522B4459
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Mar 2026 15:19:44 +0000 you wrote:
> Report PCS receive error counts for all supported GPY115x, GPY2xx and
> MxL862xx PHYs.
> 
> Accumulate the vendor-specific PHY_ERRCNT read-clear counter
> (SEL=RXERR) in .update_stats() and expose it as both IEEE 802.3
> SymbolErrorDuringCarrier and generic rx_errors via
> .get_phy_stats().
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: mxl-gpy: add PHY-level statistics via ethtool
    https://git.kernel.org/netdev/net-next/c/05c1fc56d37b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



