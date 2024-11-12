Return-Path: <netdev+bounces-143902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA699C4B6E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B20B234BF
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178AE20403B;
	Tue, 12 Nov 2024 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngKCCbg6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19A204036;
	Tue, 12 Nov 2024 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373222; cv=none; b=mNMB8KVyYo1hOH8aeBzrOUoePgjUmjkghbXcqn3WF0MUBmMa1+OJPK4ve7Gqfv2vKpzkZd+mKxymgyAUnJEjmlnM665aTrZx4MkIcCRMx7xnqYuav/54gNIPzBc+ijlwvApecAfA/mNwDpIo+7J1CvfCfnuldrlVKDIp6e+s/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373222; c=relaxed/simple;
	bh=8jvHoe4EKiy6FD9P4lh3ZUNiEORm+PtSiSJ+oHh38SY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YY4MLElkR2b4zsnnWskj3/cYaowe1XEvKzDfHiW6DWvTBagMGxveLFRglF7AMNIYYdX5xJyGeGMceKpoxtuzB67uTEqPaG0eWIX10+LTVvM2oSaYLPn58rP8aBP/7qdg9Nfq3oLapBG4b0Dfhvr5IP8EcfC8HWc+OQ9bmxeXmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngKCCbg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69139C4CECF;
	Tue, 12 Nov 2024 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731373221;
	bh=8jvHoe4EKiy6FD9P4lh3ZUNiEORm+PtSiSJ+oHh38SY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ngKCCbg6exlZgZ2yaLi6xjjVtz3/Jsdh7X9VpVOxhoKFyHPOzVNMDVTuotVenBvUl
	 DFVDwFonTrXV3ek4Yvnak/W5VVUf7KYraz3I3YZ9hIgrs0l72b65xWSvPC1w/qtwHy
	 BuPmW0LtcCaPyq/d36JPi2W51O14HDjo+XpTRSTGXHIbb7vnsygOwzSkgQ3aYzf7+v
	 qzvLhjtlW+jlV8zv/4QW5DGCY0zSHVj1iwWy95XXWUh1/5EZd+1EJzTv07cia1tkW8
	 X1DGWAJ4+yEpy9d/Ne0f+ITpu7LhP1VAEReg8eWE3ku/Y4HpUx9JXS4cz7Yq3A1M3C
	 3ObC+Hc8p37eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDFB3809A80;
	Tue, 12 Nov 2024 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] Side MDIO Support for LAN937x Switches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173137323151.33228.6980879889205647360.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 01:00:31 +0000
References: <20241106075942.1636998-1-o.rempel@pengutronix.de>
In-Reply-To: <20241106075942.1636998-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
 devicetree@vger.kernel.org, marex@denx.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Nov 2024 08:59:35 +0100 you wrote:
> This patch set introduces support for an internal MDIO bus in LAN937x
> switches, enabling the use of a side MDIO channel for PHY management
> while keeping SPI as the main interface for switch configuration.
> 
> changes v3:
> - add "net: dsa: microchip: parse PHY config from device tree" patch
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] dt-bindings: net: dsa: microchip: add internal MDIO bus description
    https://git.kernel.org/netdev/net-next/c/7eb4c2571443
  - [net-next,v4,2/6] dt-bindings: net: dsa: microchip: add mdio-parent-bus property for internal MDIO
    https://git.kernel.org/netdev/net-next/c/698b20a679be
  - [net-next,v4,3/6] net: dsa: microchip: Refactor MDIO handling for side MDIO access
    https://git.kernel.org/netdev/net-next/c/9afaf0eec2ab
  - [net-next,v4,4/6] net: dsa: microchip: cleanup error handling in ksz_mdio_register
    https://git.kernel.org/netdev/net-next/c/8bbba4161b65
  - [net-next,v4,5/6] net: dsa: microchip: add support for side MDIO interface in LAN937x
    https://git.kernel.org/netdev/net-next/c/f47e6e1e79a1
  - [net-next,v4,6/6] net: dsa: microchip: parse PHY config from device tree
    https://git.kernel.org/netdev/net-next/c/34125ac851b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



