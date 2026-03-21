Return-Path: <netdev+bounces-270156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLDHIWsHvmnCFgMAu9opvQ
	(envelope-from <netdev+bounces-270156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:50:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2077C2E2FAB
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A76230185EA
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7F4286889;
	Sat, 21 Mar 2026 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNr9yIsl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F419C566;
	Sat, 21 Mar 2026 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774061414; cv=none; b=Wr94xXF6kqUvrLJ0c2vJd+3v5NrqiodsVsHYjRHqbunrWH2QeoERRm2oBQ7eisGufdJd3EM5RB9CXzwMSjsw/avgbI2mr+/WhasXCt0a/fkRErGWgOTr8vvb5q/90g5OPYS2SKye2jmO8l5Ob1IfJRgrbqb5se3ItMv/zYQuzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774061414; c=relaxed/simple;
	bh=LveKKKU05OQYUGsKgcOyjlWqFExM7tf2UOfbz/N3Sq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Br/Ye4DCuE0khHciAlzhfUA8oiidMgFo9E1AC9cHtcqImvOYQd5Xpy4RBquQrQ79mpP1cOPrZlGF+JYyJ31Ts/sNz3u+xjQYHoyJZkAYkI2ePqKixOBIXs49IWBPlwJ360zHL6PB55gPLYx7SCj0WUOuITZy4aE59BzY1y02X1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNr9yIsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AE3C4CEF7;
	Sat, 21 Mar 2026 02:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774061414;
	bh=LveKKKU05OQYUGsKgcOyjlWqFExM7tf2UOfbz/N3Sq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XNr9yIslxXPhSAhB2tlH1y3HeJmlpzxMAPEufbQC1W1Z7fJmnPSIGqtgQ5uuuvta7
	 illRWjY1OSDy+Cmz1M86zdotOGfGD1bhIbfW7b+D0/Xs8AP91QugNGpogfCZLPZ1o7
	 Yw/BFtQrCj4NJV4n7YRVci8T1irlYjlNzd3BgsZv0kMJR+n3Q3v3hUrKUDoEafE47p
	 1f1bCqij3P/lXaXR2FIeNP2aoj4joXUPN0ZjDwTUN0caVO3l+azvWwongGUZc9NUhq
	 cI5sN4kmBX1P0k3IaPRpAfx4bRLoD/vilO3Tfazb+iYnGht2UWA8BDf/JGYKeObNPa
	 lnV7kRI99aYeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0433808200;
	Sat, 21 Mar 2026 02:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: microchip: Don't embed struct
 phy_device
 to maintain the port state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177406140454.2732634.5366187825486244133.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 02:50:04 +0000
References: <20260319181705.1576679-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260319181705.1576679-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, woojung.huh@microchip.com,
 olteanv@gmail.com, UNGLinuxDriver@microchip.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,microchip.com,gmail.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270156-lists,netdev=lfdr.de,netdevbpf];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2077C2E2FAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 19:17:04 +0100 you wrote:
> The KSZ9477 maintains the SGMII port's state for speed, duplex and link
> status to be able to fixup the accesses to its internal older version of
> the Designware XPCS. However, it does so by embedding a full instance of
> struct phy_device, only to use the 'speed', 'link' and 'duplex' fields.
> 
> This is also only used for the SGMII port, it's otherwise unused for all
> other regular ports.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: microchip: Don't embed struct phy_device to maintain the port state
    https://git.kernel.org/netdev/net-next/c/2e69e55897dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



