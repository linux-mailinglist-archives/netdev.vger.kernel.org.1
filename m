Return-Path: <netdev+bounces-13244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457E573AEC4
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC7628186C
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FDE19B;
	Fri, 23 Jun 2023 02:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846A7E0
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65658C433C8;
	Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687488626;
	bh=3VYzBKiNSP//NV3Xd0NjEnRo4SDW6LNO/672LVk9hoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cD7AFUNSeNLtLFIG54GDAcMp9kXo6zMAmwsD+rBnnyJJPPiEygWuGgMvhFz9zh5Zo
	 F4ARsWXOetSUakwNjohf9kD/xWZMRN8cbfgMG+lyUPU5Yr6tm4TynCegRUyMI+6v4+
	 mLVAeZoRHm0N40XXZs6kP3UFf2EfCM9Jvy5vcOtTVL7DnatNbuaGPS+6Ict6ahnQsx
	 F2l9lqc3HMwr5NLa3oK5Hmye8+6jsUzh6DkyW6NHUMNGns1UCzoh3i5gMDfhP4235y
	 qNTBnadauksn9mIcDavP9+YladHPPgghgtF67ft7kYdo/WU4C2zU9cJVoCcVvwoDvI
	 19IZXb7bvaoNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47DA7C691EE;
	Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/15] Add and use helper for PCS negotiation modes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748862628.32034.12255029865575674301.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 02:50:26 +0000
References: <ZIxQIBfO9dH5xFlg@shell.armlinux.org.uk>
In-Reply-To: <ZIxQIBfO9dH5xFlg@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, lynxis@fe80.eu,
 angelogioacchino.delregno@collabora.com, claudiu.beznea@microchip.com,
 daniel@makrotopia.org, daniel.machon@microchip.com, davem@davemloft.net,
 dqfext@gmail.com, edumazet@google.com, f.fainelli@gmail.com,
 horatiu.vultur@microchip.com, ioana.ciornei@nxp.com, kuba@kernel.org,
 Jose.Abreu@synopsys.com, Landen.Chao@mediatek.com,
 lars.povlsen@microchip.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, madalin.bucur@nxp.com, mw@semihalf.com,
 matthias.bgg@gmail.com, michal.simek@amd.com, netdev@vger.kernel.org,
 nicolas.ferre@microchip.com, pabeni@redhat.com,
 radhey.shyam.pandey@xilinx.com, sean.anderson@seco.com,
 sean.wang@mediatek.com, Steen.Hegelund@microchip.com,
 taras.chornyi@plvision.eu, thomas.petazzoni@bootlin.com,
 UNGLinuxDriver@microchip.com, olteanv@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jun 2023 13:05:52 +0100 you wrote:
> Hi,
> 
> Earlier this month, I proposed a helper for deciding whether a PCS
> should use inband negotiation modes or not. There was some discussion
> around this topic, and I believe there was no disagreement about
> providing the helper.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] net: phylink: add PCS negotiation mode
    https://git.kernel.org/netdev/net-next/c/f99d471afa03
  - [net-next,02/15] net: phylink: convert phylink_mii_c22_pcs_config() to neg_mode
    https://git.kernel.org/netdev/net-next/c/cdb08aa04737
  - [net-next,03/15] net: phylink: pass neg_mode into phylink_mii_c22_pcs_config()
    https://git.kernel.org/netdev/net-next/c/febf2aaf0564
  - [net-next,04/15] net: pcs: xpcs: update PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/a3a47cfb88fc
  - [net-next,05/15] net: pcs: lynxi: update PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/3b2de56a146f
  - [net-next,06/15] net: pcs: lynx: update PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/c689a6528c22
  - [net-next,07/15] net: lan966x: update PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/a0e93cfdac4c
  - [net-next,08/15] net: mvneta: update PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/140d1002e2a3
  - [net-next,09/15] net: mvpp2: update PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/d5b16264fffe
  - [net-next,10/15] net: prestera: update PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/d5a052993062
  - [net-next,11/15] net: qca8k: update PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/bfa0a3ac05b6
  - [net-next,12/15] net: sparx5: update PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/6e5bb3da9842
  - [net-next,13/15] net: dsa: b53: update PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/772c476dd1d4
  - [net-next,14/15] net: dsa: mt7530: update PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/6c1e4eca0b4e
  - [net-next,15/15] net: macb: update PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/f40df95d375d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



