Return-Path: <netdev+bounces-282558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLNqD0il8mk0tQEAu9opvQ
	(envelope-from <netdev+bounces-282558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:41:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3C49BCD4
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 386BA3028F78
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9187320E334;
	Thu, 30 Apr 2026 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9F291da"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F71FF1B5;
	Thu, 30 Apr 2026 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509670; cv=none; b=E/Q8KHW/3HHPdzcU9G2opePuCrGa69VYS5M6KTXlno8fT5vP8Ic81KiEmkHbBX2kINlf0zTpoSaI3BrpfhbMbGmQbL7ZHDPZqqJk/oloGYmEjC6m068gfLrZP+u4YwJrd0gaC742+AmZi3fCec3u6Cd8USX42wvST4WT5r5cJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509670; c=relaxed/simple;
	bh=Wab3M3mvzB73WYV181I8Lu7mlzlgjKx6PiGdi46EavE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ayM4jZCQGRZ+MZla1Sy7v4LjxBversclMsmN10lO0gNIjaRBIgaTxXLUfOhrn+wlvzyH+qH26yKw/7z2H4ThyPdkugAT34Q9utYrHvLrCgqM8Hhsbk0dE7sZxCjwRWUKDaKsH13NLpdxHsC2u/AKG5bWh3aBE7AGCgPy4ju1vJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9F291da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F46AC19425;
	Thu, 30 Apr 2026 00:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777509670;
	bh=Wab3M3mvzB73WYV181I8Lu7mlzlgjKx6PiGdi46EavE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l9F291da+hv8wntX0HshDp4ILsoZ4ixEdsPhWiXs++Wiw6LCLAZnBii3oEKdxzyB7
	 l75+u+ZJizOsdPhsrcaXceIRJCsT24YnnloLZwi2t9Er/X97ISq7KWeYJDTlo8D5CP
	 JvJnV5+lxY5aXnbDBVy5/MBP5cup9JtMihHXr7RX2COiI4d9v5dMQ0CqXha6PNV97S
	 vnNBt/wzM1KUzZrmcb33SD6fD/CJ9eE2bgtTgBiqMxeuUOgtuGlVvPAv52oB1X+x8I
	 r8b/7a8rKknyF4jrgUR3kcdbXutF9THIFE2ksX/gdxZTaZqYKtfv0oGOSlWhM2HVCM
	 m4GT8tu8hrSsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFD63809A2A;
	Thu, 30 Apr 2026 00:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: aquantia: use ADVERTISE_XNP for
 extended
 next page advertising
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177750962529.2238701.8852834858635772557.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 00:40:25 +0000
References: <20260428125827.238469-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260428125827.238469-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 hkallweit1@gmail.com, vladimir.oltean@nxp.com, camelia.groza@nxp.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: A9F3C49BCD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,nxp.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282558-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 14:58:27 +0200 you wrote:
> When configuring the link parameters in forced mode for the AQR-105, the
> Extended Next Page bit gets advertised for Multi-Gigabit modes.
> 
> This is done through bit 12 of MDIO_AN_ADVERTISE in MDIO_MMD_AN. This
> contains a copy of the MII_ADVERTISE, for which 802.3 defines bit 12 as
> the Extended Next Page advertising. This bit used to be marked as
> reserved, but a proper define for it was added in :
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: aquantia: use ADVERTISE_XNP for extended next page advertising
    https://git.kernel.org/netdev/net-next/c/e2d217fe3ff2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



