Return-Path: <netdev+bounces-121330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47DD95CC25
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6318A1F21AA5
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7466C184527;
	Fri, 23 Aug 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrPOfWxv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8C61FFC;
	Fri, 23 Aug 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415036; cv=none; b=NKz5WnW4Oq6kDXHLZMwT9zY07LUUfLjqiGcmmOeP3tm2BuNINV8bUx+PRpzqLtOOEOmHwqYWkKoWEv7hj5sW0O7HSWqbacJ/jEbe5voUeXVDpH5q34P82yMdzNyOGhsxW8QcAcQcQeC9HY23amoWxdjYaEGRwBhVoRLMBRaAtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415036; c=relaxed/simple;
	bh=pKfHgATmqSK7seazo5mDVuSTEke8rFJFn5HddZgvvO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HdLgxV9JdPunONoH1LKcA8s68yVSObwdiMoSdz1rzb1v5YhJ0I85raGhleBwjMRlFpx1PgZ6sVtRDvoic2qIUANytmvrGFb8a+6+LjqooHmHsIifffDRS+UYPV8h4eMSK+odvSH/EhQT4492KgHpvYCbYke0Quwfe48pClybWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrPOfWxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5F1C4AF09;
	Fri, 23 Aug 2024 12:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724415035;
	bh=pKfHgATmqSK7seazo5mDVuSTEke8rFJFn5HddZgvvO0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lrPOfWxvYJn89G8sixWzWn/bUQdiEKtMGgFoKGr4jgFtsw/mkEKxaWsnqhd1yuvG4
	 AiH3unq8t6tq1c6LHgPXCs9SBBcF69SbdgEUm3MF6x8AW/vp1794CmfWTBsqjTJyox
	 G9/a6E0V0Qtjjl3HbkWKEsP8ovixDCfbAQs/tkY82hO4eKUFA0WCPIlYgpNUuDxzpS
	 mgDHbfnhHg6dWotNdPxtBWBSwfRYPmNWSJ+4uFICG5dyoy0sIom77g1tUpmCquKjAX
	 GMN9ZMuW6NZt/C/WNNyg7Ov7QC/C0cCGmaciymzBz7Y22q3rHgJolT/W1hOYrnkqWz
	 66H20BuYHRySA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFC93804CB0;
	Fri, 23 Aug 2024 12:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v18 00/13] Introduce PHY listing and link_topology
 tracking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172441503552.2944490.10143291093709397459.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 12:10:35 +0000
References: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, hkallweit1@gmail.com,
 vladimir.oltean@nxp.com, kory.maincent@bootlin.com,
 jesse.brandeburg@intel.com, kabel@kernel.org, piergiorgio.beruto@gmail.com,
 o.rempel@pengutronix.de, nicveronese@gmail.com, horms@kernel.org,
 mwojtas@chromium.org, nathan@kernel.org, atenart@kernel.org,
 mkl@pengutronix.de, dan.carpenter@linaro.org, romain.gantois@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 21 Aug 2024 17:09:54 +0200 you wrote:
> Hello everyone,
> 
> This is V18 of the phy_link_topology series, aiming at improving support
> for multiple PHYs being attached to the same MAC.
> 
> V18 is a simple rebase of the V17 on top of net-next, gathering the
> tested-by and reviewed-by tags from Christophe (thanks !).
> 
> [...]

Here is the summary with links:
  - [net-next,v18,01/13] net: phy: Introduce ethernet link topology representation
    https://git.kernel.org/netdev/net-next/c/384968786909
  - [net-next,v18,02/13] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
    https://git.kernel.org/netdev/net-next/c/4d76f115ab91
  - [net-next,v18,03/13] net: phy: add helpers to handle sfp phy connect/disconnect
    https://git.kernel.org/netdev/net-next/c/b2db6f4ace72
  - [net-next,v18,04/13] net: sfp: Add helper to return the SFP bus name
    https://git.kernel.org/netdev/net-next/c/0a2f7de0f3b9
  - [net-next,v18,05/13] net: ethtool: Allow passing a phy index for some commands
    https://git.kernel.org/netdev/net-next/c/c15e065b46dc
  - [net-next,v18,06/13] netlink: specs: add phy-index as a header parameter
    https://git.kernel.org/netdev/net-next/c/9af0e89d6c24
  - [net-next,v18,07/13] net: ethtool: Introduce a command to list PHYs on an interface
    https://git.kernel.org/netdev/net-next/c/17194be4c8e1
  - [net-next,v18,08/13] netlink: specs: add ethnl PHY_GET command set
    https://git.kernel.org/netdev/net-next/c/d3d9a3e48a63
  - [net-next,v18,09/13] net: ethtool: plca: Target the command to the requested PHY
    https://git.kernel.org/netdev/net-next/c/02180fb525ba
  - [net-next,v18,10/13] net: ethtool: pse-pd: Target the command to the requested PHY
    https://git.kernel.org/netdev/net-next/c/31748765bed3
  - [net-next,v18,11/13] net: ethtool: cable-test: Target the command to the requested PHY
    https://git.kernel.org/netdev/net-next/c/3688ff3077d3
  - [net-next,v18,12/13] net: ethtool: strset: Allow querying phy stats by index
    https://git.kernel.org/netdev/net-next/c/e96c93aa4be9
  - [net-next,v18,13/13] Documentation: networking: document phy_link_topology
    https://git.kernel.org/netdev/net-next/c/db31e09d517b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



