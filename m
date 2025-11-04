Return-Path: <netdev+bounces-235355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22CC2F060
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 03:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5125F3BE73F
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 02:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614EC25A33F;
	Tue,  4 Nov 2025 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ao9jECMQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C9225760;
	Tue,  4 Nov 2025 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762224636; cv=none; b=r6hzHmsTyz66nFV5ZizfhQCrToaElDOMdgWU78V3jtPMliU4EiS5xaG4tJcbq9kW+r/uBtSmpu4ldSmOkQ1WlItP/zgyr6tyqtdzvZHKEwL9odWZFgVHD7kfN2R1y3LcyoUPkTRjhfNFQQt7yDj/ZWugrSoWYGG1/xt2elrV1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762224636; c=relaxed/simple;
	bh=gMLTiVDDeg6deTR4aZhrgf5MUJq64OEEUKWPcufaXW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jAVqgFbyqUmOWSirtbrSOlk5CNlyIsKLGR5UJqycosYxlazvrKs/i8KlntPhmpAU/VhJb4wDMDDseO2ASDaoNkeld9xeXMPiKkFp1gIRmedaSjjGpydnVdQhw0mRQiNpAyT7cn7R1iJA8cEwasWeV11SCOebZq3W3xH1tT8rcxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ao9jECMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8311C4CEE7;
	Tue,  4 Nov 2025 02:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762224636;
	bh=gMLTiVDDeg6deTR4aZhrgf5MUJq64OEEUKWPcufaXW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ao9jECMQPICwDuz8L5cVaEfKrUlS5nz+j/tJRchAoWfWXnpzCc9sJVUZsfcWKhp3b
	 6l276j5qgBkszzOCYwMauUB6XkctyH4VPfbU5UEqcnu0DtS5XF8f0vMP9PT70XBoaQ
	 xpRk4TA57ywHW18zvif0bwmKEO9XgWZYWNzV1uCESSQEW+rAecYm0DJnGnDetXLSwm
	 u4iFhoRca2D6W8DpHM50JBPOByk5tIS79C/GvPb398WLaIPKP7UCURSa3r622kSLfX
	 fJ3ErUrF8KRuNwlcLE7LgZeE1iNwkUT1msXkviS/xJmAdR/UA+7mMNe1dagihD8hvp
	 ONVEMgMK1RU2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7112B3809A8D;
	Tue,  4 Nov 2025 02:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/4] ethtool: introduce PHY MSE diagnostics
 UAPI
 and drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176222461025.2304280.9617758063205334203.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 02:50:10 +0000
References: <20251027122801.982364-1-o.rempel@pengutronix.de>
In-Reply-To: <20251027122801.982364-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com, corbet@lwn.net,
 hkallweit1@gmail.com, linux@armlinux.org.uk, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, nm@ti.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org, mkubecek@suse.cz,
 roan@protonic.nl

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Oct 2025 13:27:57 +0100 you wrote:
> changes v8:
> - Drop capability bitfield support from UAPI
> - Drop channel selection support from user space
> - Kernel now returns all available channels automatically
> - Add OA Technical Committee numbers (TC1 / TC12)
> - Minor doc and type cleanups
> changes v7:
> - htmldoc fixes
> changes v6:
> - rework the code to use uint instead of u32/u64
> - use bitset for flags
> - use nest for each separate channel
> changes v5:
> - add struct phy_mse_snapshot and phy_mse_config to the documentation
> changes v4:
> - remove -ENETDOWN as expected error value for get_mse_config() and
>   get_mse_snapshot()
> - fix htmldocs builds
> - s/__ethtool-a-mse/--ethtool-a-mse
> changes v3:
> - add missing ETHTOOL_A_LINKSTATE_MSE_* yaml changes
> changes v2:
> - rebase on latest net-next
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/4] net: phy: introduce internal API for PHY MSE diagnostics
    https://git.kernel.org/netdev/net-next/c/abcf6eef90c6
  - [net-next,v8,2/4] ethtool: netlink: add ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
    https://git.kernel.org/netdev/net-next/c/e6e93fb01302
  - [net-next,v8,3/4] net: phy: micrel: add MSE interface support for KSZ9477 family
    https://git.kernel.org/netdev/net-next/c/335a9660e141
  - [net-next,v8,4/4] net: phy: dp83td510: add MSE interface support for 10BASE-T1L
    https://git.kernel.org/netdev/net-next/c/fd93ed77efe4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



