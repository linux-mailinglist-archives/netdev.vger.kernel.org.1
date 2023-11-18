Return-Path: <netdev+bounces-48915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9807A7F003E
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 16:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA21B2097B
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A771168AA;
	Sat, 18 Nov 2023 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB7gC/q6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C3101C5;
	Sat, 18 Nov 2023 15:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E63C2C433C9;
	Sat, 18 Nov 2023 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700320227;
	bh=6UWsJkvAEvj2H3Wa8RCVwzYqgNc80avR/IIJi1BMIxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vB7gC/q6cSSItaBEdfFLGgUZ4LAJ7iImYmiosOdJoKcKeiJ+q8bxAiSCZAXieWjjo
	 E4AlPbH/t7vv+kGSG+dRLVfLLFmUmbJ1eZ906enyR3i/1WVopgqar8oCTkuY3A63Bf
	 xVenYLpdN/4nuI1rPOnxytOlTc43FtNJHyU6xjLbuax+OIlNcDbnXAjAXpQT1nrZ5A
	 HA1B4H+cw9+ga75ZSlOW5l37URKqtskwYdoyxk5GdLKu0kz+nW5D9F0KNJJN6zwZUs
	 iqy6DH+5H59qkF2V8hCcY4uolwn5yNfBd3lClJRWE3FATJO0LcWHUyDe6qCE5LTNBG
	 mk0vq1gBsEvdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCCA0EA6305;
	Sat, 18 Nov 2023 15:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 00/16] net: Make timestamping selectable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170032022683.7145.6992267439143242783.git-patchwork-notify@kernel.org>
Date: Sat, 18 Nov 2023 15:10:26 +0000
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
To: =?utf-8?q?K=C3=B6ry_Maincent_=3Ckory=2Emaincent=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, radu-nicolae.pirea@oss.nxp.com,
 j.vosburgh@gmail.com, andy@greyhouse.net, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, willemdebruijn.kernel@gmail.com, corbet@lwn.net,
 horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com, horms@kernel.org,
 vladimir.oltean@nxp.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, maxime.chevallier@bootlin.com,
 jay.vosburgh@canonical.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Nov 2023 12:28:28 +0100 you wrote:
> Up until now, there was no way to let the user select the layer at
> which time stamping occurs. The stack assumed that PHY time stamping
> is always preferred, but some MAC/PHY combinations were buggy.
> 
> This series updates the default MAC/PHY default timestamping and aims to
> allow the user to select the desired layer administratively.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,01/16] net: Convert PHYs hwtstamp callback to use kernel_hwtstamp_config
    https://git.kernel.org/netdev/net-next/c/446e2305827b
  - [net-next,v7,02/16] net: phy: Remove the call to phy_mii_ioctl in phy_hwstamp_get/set
    https://git.kernel.org/netdev/net-next/c/430dc3256d57
  - [net-next,v7,03/16] net: ethtool: Refactor identical get_ts_info implementations.
    https://git.kernel.org/netdev/net-next/c/b8768dc40777
  - [net-next,v7,04/16] net: macb: Convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/202cb220026e
  - [net-next,v7,05/16] net: Make dev_set_hwtstamp_phylib accessible
    https://git.kernel.org/netdev/net-next/c/011dd3b3f83f
  - [net-next,v7,06/16] net: phy: micrel: fix ts_info value in case of no phc
    https://git.kernel.org/netdev/net-next/c/915d25a9d69b
  - [net-next,v7,07/16] net_tstamp: Add TIMESTAMPING SOFTWARE and HARDWARE mask
    https://git.kernel.org/netdev/net-next/c/acec05fb78ab
  - [net-next,v7,08/16] net: ethtool: Add a command to expose current time stamping layer
    https://git.kernel.org/netdev/net-next/c/11d55be06df0
  - [net-next,v7,09/16] netlink: specs: Introduce new netlink command to get current timestamp
    https://git.kernel.org/netdev/net-next/c/bb8645b00ced
  - [net-next,v7,10/16] net: ethtool: Add a command to list available time stamping layers
    https://git.kernel.org/netdev/net-next/c/d905f9c75329
  - [net-next,v7,11/16] netlink: specs: Introduce new netlink command to list available time stamping layers
    https://git.kernel.org/netdev/net-next/c/aed5004ee7a0
  - [net-next,v7,12/16] net: Replace hwtstamp_source by timestamping layer
    https://git.kernel.org/netdev/net-next/c/51bdf3165f01
  - [net-next,v7,13/16] net: Change the API of PHY default timestamp to MAC
    https://git.kernel.org/netdev/net-next/c/0f7f463d4821
  - [net-next,v7,14/16] net: ethtool: ts: Update GET_TS to reply the current selected timestamp
    https://git.kernel.org/netdev/net-next/c/091fab122869
  - [net-next,v7,15/16] net: ethtool: ts: Let the active time stamping layer be selectable
    https://git.kernel.org/netdev/net-next/c/152c75e1d002
  - [net-next,v7,16/16] netlink: specs: Introduce time stamping set command
    https://git.kernel.org/netdev/net-next/c/ee60ea6be0d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



