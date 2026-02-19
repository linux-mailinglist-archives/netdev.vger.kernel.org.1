Return-Path: <netdev+bounces-259603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPLAF5qTl2mL1AIAu9opvQ
	(envelope-from <netdev+bounces-259603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:50:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B835A163607
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23AEE30131E0
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 22:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85398329E7E;
	Thu, 19 Feb 2026 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4fAIVYd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C0D26D4EF;
	Thu, 19 Feb 2026 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771541397; cv=none; b=pcrmkCG2cMubeurGeMJM8HakqSiZww6YXoSatk3FYDjPLKyQY4xe5YN2Q1JDCdfkl223Ume+GrymC1tqZ1Lbr8sxcYpi2nXMKlL6yrRX+9otBAKBBViLn3MgLOl2tJXzCI0Ks5BF4B/2MoGHBT+Wi8ryfiHoMoVvl1nerUATIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771541397; c=relaxed/simple;
	bh=uhz8oCfsG0JKHlBZ6UJxZBFWK2ro5RtvBlbow1Gb1Dw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NmaopOwR77Fo8MORgBbHV8tw/5hszCHBm/3793CImMBXiXFb84mQhf0fjQ/C8lAxN/4o758/7V/IJ5yxHwL75GFgBrsndLu8tjxUVnpk03WDIbTHE0RbhLx4RN4IKkt6hbhyICsutwWd2VscQ+2HrFrmbCxC5+sExSZSwRuTVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4fAIVYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0D4C4CEF7;
	Thu, 19 Feb 2026 22:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771541397;
	bh=uhz8oCfsG0JKHlBZ6UJxZBFWK2ro5RtvBlbow1Gb1Dw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B4fAIVYdBgJzYrehLJGs5dTcvMwnh8RlUOuK/Ro2gqAyQ/jYL1r/+1h2UsAjrhrma
	 UjQ8pT3EF0IvhuxXU2u6YbGmFHb4ZUdIrTV9H8LAGb5+8GwVQUl5nayhe5zTOudqoY
	 ATzOCJsZg+kIEWNSLFWn3oHtU9ojuphigTPAJe9ZJu539nhplRTGe0VP6WLrFsO+uU
	 N2JIVAyPrfumInagPw2WJxJVjKH0NbKIBXNnonf0xIoUoNGfo912INYglA7uXbp8Kg
	 0Wip3hix8XC58AJsx2LORGIdJTEK+zP464LQuX+hpGjPjsXe1LfGauDBq47dn1r4Ef
	 wxe+xqPp81iPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FD83809A88;
	Thu, 19 Feb 2026 22:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: usb: lan78xx: scan all MDIO addresses on LAN7801
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177154140555.121853.1686272340224201852.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 22:50:05 +0000
References: 
 <0110019c6f388aff-98d99cf0-4425-4fff-b16b-dea5ad8fafe0-000000@eu-north-1.amazonses.com>
In-Reply-To: 
 <0110019c6f388aff-98d99cf0-4425-4fff-b16b-dea5ad8fafe0-000000@eu-north-1.amazonses.com>
To: =?utf-8?q?Martin_P=C3=A5lsson_=3Cmartin=40poleshift=2Ese=3E?=@codeaurora.org
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 woojung.huh@microchip.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_SPAM(0.00)[0.646];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259603-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B835A163607
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Feb 2026 05:28:22 +0000 you wrote:
> The LAN7801 is designed exclusively for external PHYs (unlike the
> LAN7800/LAN7850 which have internal PHYs), but lan78xx_mdio_init()
> restricts PHY scanning to MDIO addresses 0-7 by setting phy_mask to
> ~(0xFF). This prevents discovery of external PHYs wired to addresses
> outside that range.
> 
> One such case is the DP83TC814 100BASE-T1 PHY, which is typically
> configured at MDIO address 10 via PHYAD bootstrap pins and goes
> undetected with the current mask.
> 
> [...]

Here is the summary with links:
  - [v3] net: usb: lan78xx: scan all MDIO addresses on LAN7801
    https://git.kernel.org/netdev/net/c/f1e2f0ce704e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



