Return-Path: <netdev+bounces-286026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K8PCZtm/mk9qQAAu9opvQ
	(envelope-from <netdev+bounces-286026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:41:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E75B4FC6D7
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86069303D333
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A3D3A256C;
	Fri,  8 May 2026 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe6pVYeo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63943A1A26;
	Fri,  8 May 2026 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280061; cv=none; b=sNpW7PZ8vjDt3HA4PPEUVuBZRXksq5oDE9JtzMw4FT9sCi07fr0E527dNLfwu90gv9ne11Ag6ns1jFDJSegenatInU0/TiHKoWUi8gDBp0G9dyhPj7ikYoKNUr5Czj334/PHtF4/a4qkUnhaTwalgiG2VHXZQ8uI1Q/c5akxCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280061; c=relaxed/simple;
	bh=FYU/15qOeVBqPbvSjXhyZXA3TJXjTjc4EpIfifg/PwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cCuvggo6/CbFWKl9JZmtwLIsAGS2Dtu+Gv5Lyrch3BYA7z53XXnwJtAAYqkqZiA6WbHtXPbcOoPEjsnVPXVkMcg5jbjVJtc7uc+EwZcs7f7lSxMM0Fii8Ymkizq/tefBleDgem8SchRxYSbWp1LF3ezVSWwh3gp5NY+UUVZLrZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe6pVYeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97949C2BCB0;
	Fri,  8 May 2026 22:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280060;
	bh=FYU/15qOeVBqPbvSjXhyZXA3TJXjTjc4EpIfifg/PwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oe6pVYeox2+qqYgcZWf+Q4AN+uhEr35Fs7Q433jPfVEqRe+zwzCWEraBsWad58/Y0
	 BLRjt7e4ACn9T5otwG8i2OLqqksLfrY60HwWQX1NqSihzMiRl6QdvDO2JgIBIqL+GC
	 fcy7BUtFsJ3AGwQw3/nsJo+iaOO6nQApRwrZzJYokn4AHrmQ5Boua4IScDLZT6uDZI
	 daN+Qc7rTOW677wYCzC8kZsm1kulQUR8DBPWtIXIwADqnM9qxHVSqkPB9PKGuHtVLR
	 cN7fkPeupD9gZh/Ud27b5jM3aOfjRTB1iuh9b0kZ3GcIjzU9UdYh27u0T1AMUN7J0c
	 AnWsa2ks9LGzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDCC38119D3;
	Fri,  8 May 2026 22:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: change maintainers for macb Ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828000904.878212.12911947829161473740.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:40:09 +0000
References: <20260507120444.9733-1-nicolas.ferre@microchip.com>
In-Reply-To: <20260507120444.9733-1-nicolas.ferre@microchip.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 claudiu.beznea@tuxon.dev, netdev@vger.kernel.org,
 alexandre.belloni@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 7E75B4FC6D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286026-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 May 2026 14:04:44 +0200 you wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> I would like to hand over the macb maintenance to Théo, as I'm unable to
> keep up with the recent flow of patches for this driver. After speaking
> with Claudiu, he indicated that he is in the same position as me.
> To help with this work, Conor has agreed to act as a reviewer.
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: change maintainers for macb Ethernet driver
    https://git.kernel.org/netdev/net/c/0a549298f452

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



