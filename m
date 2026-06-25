Return-Path: <netdev+bounces-301822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ADqpKGOJPGq1pAgAu9opvQ
	(envelope-from <netdev+bounces-301822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:50:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDEC6C239B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:50:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="BwPxS/NY";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301822-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301822-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD3BC302734C
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7B38239D;
	Thu, 25 Jun 2026 01:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393FA382388;
	Thu, 25 Jun 2026 01:50:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352222; cv=none; b=R4CgopMGC8Lo3xt50RTQqOF1VjMNkL/oH8/4xEK0ErenmQUC8klPT/BDY7CpgrGkkGtDYTp2JLhtgOP4bo9CJgg6wj/NYYt7PIROG3Mo3TAWZ7YwwilThC0IvzbSk/LQw6psvqHX7VEqzg6wr+5G/wUdT71faPbzAhQgfKk3Yk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352222; c=relaxed/simple;
	bh=YHGfqbhRyyDfktnsQ5Uq+RyCg8gszg1PLUxyWW7yum4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vkol/E9r5Pv/zU0eFZO9sY2SgJuGctowhjoGibJu+utncQ6d/1RhRcMy+1R9BLG4yR/c0TRurp/JDyl2f4zpf3VRHbmyH1T3x3055HnZIstfPLMcDOaZk2JYq3fHazap9lRCzauglJy7GtQZHNdyIke6RXL6Ec04luEm38S7G0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwPxS/NY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50921F000E9;
	Thu, 25 Jun 2026 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352220;
	bh=Tb3rbYR4nybRquIn6oIG8yWcyiJzK0ODeI8w7S3Wx5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BwPxS/NYBPiD2m9FDKehNxKScGpAgzsm89XRyyK5phrhWpNQbwBHEVJJB6TPlM9P/
	 tmraZGQoZhtJpsjrMhkRasz4bRmy+n7Bl8MRqNGVAchjIoZpadvJpAgzIxirY4CR3H
	 vgLqp8U/5LnLXNGePJK1oGcRmzohkp84vBte+iFgTClFU+Odz9SyoDp57XzYk1COZd
	 PG/ZqRBzHFQjeCq9x+/yFdbmmx30ZZ9SJBP/lMaXZAGdq64wmxpIabwuDTYrpCz+EQ
	 yUpDfoJyupprEOjVaTuNAocHcBOHcvBA8AbUZ+beW5RCRTPyaJH1iMqyFjjBm2ghdm
	 v/EPh8LmW7xNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569D03AAA6D1;
	Thu, 25 Jun 2026 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G
 bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235220885.3075556.12697769735215481789.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 01:50:08 +0000
References: <20260620011956.37181-1-honza.klos@gmail.com>
In-Reply-To: <20260620011956.37181-1-honza.klos@gmail.com>
To: Jan Klos <honza.klos@gmail.com>
Cc: hkallweit1@gmail.com, andrew@lunn.ch, linux@armlinux.org.uk,
 netdev@vger.kernel.org, maxime.chevallier@bootlin.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, vladimir.oltean@nxp.com, olek2@wp.pl,
 markus.stockhausen@gmx.de, jan@3e8.eu, ih@simonwunderlich.de,
 amadeus@jmu.edu.cn, rmk+kernel@armlinux.org.uk, hau@realtek.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,armlinux.org.uk,vger.kernel.org,bootlin.com,davemloft.net,google.com,kernel.org,redhat.com,makrotopia.org,nxp.com,wp.pl,gmx.de,3e8.eu,simonwunderlich.de,jmu.edu.cn,realtek.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301822-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:honza.klos@gmail.com,m:hkallweit1@gmail.com,m:andrew@lunn.ch,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:maxime.chevallier@bootlin.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:olek2@wp.pl,m:markus.stockhausen@gmx.de,m:jan@3e8.eu,m:ih@simonwunderlich.de,m:amadeus@jmu.edu.cn,m:rmk+kernel@armlinux.org.uk,m:hau@realtek.com,m:linux-kernel@vger.kernel.org,m:honzaklos@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FDEC6C239B

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 03:19:53 +0200 you wrote:
> On RTL8127A connected to a link partner that advertises 10000baseT
> speed cannot be changed to anything other than 10000baseT as 10GbE
> is always advertised regardless of any setting. Fix this by
> clearing MDIO_AN_10GBT_CTRL_ADV10G bit in rtl822x_config_aneg()'s
> call to phy_modify_mmd_changed().
> 
> Fixes: 83d962316128 ("net: phy: realtek: add RTL8127-internal PHY")
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Jan Klos <honza.klos@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G bit
    https://git.kernel.org/netdev/net/c/510a283f4d12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



