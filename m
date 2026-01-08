Return-Path: <netdev+bounces-248063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FBCD02A53
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 13:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF5A4306A0EF
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 12:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9094CB390;
	Thu,  8 Jan 2026 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjMMItKt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B794B4CB38D;
	Thu,  8 Jan 2026 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875016; cv=none; b=AAbBtlyHLW/ep57BGzkMcfeZMWFPSlwFuc3U9JvyFiY1YmNY36zrfCEw9hpTyKVLDCRYsUtDkzfCStJhyvoipAx3DimBI0IL98XAz6b5mte4SAO1GJSvx4Gfgg665VHnXbOWNOz3lGnDwNntbxnUsV7zs4RwTyobUBh5xvPoPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875016; c=relaxed/simple;
	bh=V8cRugivarBEma/Pu5wARlCtzarjKz6KnuR4no+nARM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UiIwEWWA3QA9fMRRxHmDH5seUyN9hIqi+cgicyarmbUCp2kRWN5R6l74fUqNEinI9NIiWRCn6N+uC7GJSXfpToIS4drT45faLJvgjV49N7Z7zXkcayxUuAbA2JT+8Kk0XUUXNq8guV7ZhYn6lTOYH5M70Rv3qoJSoSK9hZk1Ifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjMMItKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA58C116C6;
	Thu,  8 Jan 2026 12:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767875016;
	bh=V8cRugivarBEma/Pu5wARlCtzarjKz6KnuR4no+nARM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FjMMItKtOV4MfjmVtVcx4xSOK9TO8Ssc34UrVvFYBqhmScfX+oOlAc/fi6p78l2Ld
	 CpYT6r215tHes9qKisdEuA7o6Th+fSDcMPF9TnOKakzmR2OnZIy5unvbU6exO1Vhxy
	 4oT2w3+5cIGdY8T8CYe41tMGSvnalZeVNomY3XFP3sDn7NJLaER9nEQK92WYl/dD4L
	 I/C+nARaqpQhMUKTnwa+FDeKF/anarYruJAmU6lrFrXVitPBGe9tB931pma5YxsFZ6
	 rbOgA8IXFU6ufPxpWCFZEn4Z3rHLJhiTj4psAkmu6Idkpc2AY/Gt9j0FI0zaJx5A8Y
	 T5WULnsIioPRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2D5A3A82570;
	Thu,  8 Jan 2026 12:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] net: phy: realtek: various improvements
 for
 2.5GE PHYs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176787481279.3611260.7838276069885779242.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 12:20:12 +0000
References: <cover.1767630451.git.daniel@makrotopia.org>
In-Reply-To: <cover.1767630451.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, michael@fossekall.de, olek2@wp.pl,
 bevan.weiss@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 5 Jan 2026 16:37:38 +0000 you wrote:
> This series improves the RealTek PHY driver, mostly for 2.5GE PHYs.
> It implements configuring SGMII and 2500Base-X in-band auto-negotiation
> and improves using the PHYs in Clause-22-only mode.
> 
> Note that the rtl822x_serdes_write() function introduced by this series
> is going to be reused to configure polarities of SerDes RX and TX lanes
> once series "PHY polarity inversion via generic device tree properties"
> has been applied.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: phy: realtek: fix whitespace in struct phy_driver initializers
    https://git.kernel.org/netdev/net-next/c/50326b48f0cf
  - [net-next,v2,2/5] net: phy: realtek: implement configuring in-band an
    https://git.kernel.org/netdev/net-next/c/10fbd71fc5f9
  - [net-next,v2,3/5] net: phy: move mmd_phy_read and mmd_phy_write to phylib.h
    https://git.kernel.org/netdev/net-next/c/65de36f5eae1
  - [net-next,v2,4/5] net: phy: realtek: use paged access for MDIO_MMD_VEND2 in C22 mode
    https://git.kernel.org/netdev/net-next/c/1850ec20d6e7
  - [net-next,v2,5/5] net: phy: realtek: get rid of magic number in rtlgen_read_status()
    https://git.kernel.org/netdev/net-next/c/d8489935f597

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



