Return-Path: <netdev+bounces-18498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EA0757613
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A039B2814CF
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BAB8F53;
	Tue, 18 Jul 2023 08:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA359FBF0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 08:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35DE4C433CD;
	Tue, 18 Jul 2023 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689667222;
	bh=lNuU7vFuvRCSkCwLvhhA5jM0tivFsuhgy/tJEQUCrFs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fyYosWK7+6ToIJGk78IKhuAdQ+/nq4t8MWCSvQVqp/AxiB2pxCXYTgdiZg7K80CZP
	 MIwZJBgs4VHTI+do3H43tOb3XNY6z5S893ltxj79lrse0wc92Nk9Ojg0YwcXZeljXK
	 hOVFXnbwyPMr1s+z817sOG7Of3JgqoAzKNTC+oai0uQHPjTwuJpVxyfvk98i2kxsqZ
	 gUIdv2I4BNN0zQIqFKrfHWEsztJVOBQln65Kgl5Y9tKBck6d37GNgJa274i+YLThGW
	 XNRThgTE4hwjLWO0LO+HXlt42YMj+TQ5aeqiePtORQyZF8p15jPg1Eo3+sqE32j3/m
	 VJt3m316V9nOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10A4CE22AE5;
	Tue, 18 Jul 2023 08:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] Remove some unused phylink legacy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168966722206.706.5080340489033162242.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jul 2023 08:00:22 +0000
References: <ZLERQ2OBrv44Ppyc@shell.armlinux.org.uk>
In-Reply-To: <ZLERQ2OBrv44Ppyc@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.belloni@bootlin.com,
 angelogioacchino.delregno@collabora.com, arinc.unal@arinc9.com,
 claudiu.manoil@nxp.com, daniel@makrotopia.org, davem@davemloft.net,
 dqfext@gmail.com, edumazet@google.com, f.fainelli@gmail.com,
 florian.fainelli@broadcom.com, kuba@kernel.org, Landen.Chao@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 sean.wang@mediatek.com, UNGLinuxDriver@microchip.com, olteanv@gmail.com,
 woojung.huh@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Jul 2023 10:11:31 +0100 you wrote:
> Hi,
> 
> I believe we are now in a position where some of the legacy phylink code
> can be removed!
> 
> I believe that all DSA drivers do not make use of any pre-March 2020
> phylink behaviour - all drivers now seem to set legacy_pre_march2020 to
> false, and the conditions that DSA sets it to true are no longer
> satisifed by any driver.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: dsa: remove legacy_pre_march2020 detection
    https://git.kernel.org/netdev/net-next/c/a88dd7538461
  - [net-next,2/3] net: dsa: remove legacy_pre_march2020 from drivers
    https://git.kernel.org/netdev/net-next/c/8f42c07fb0f2
  - [net-next,3/3] net: phylink: remove legacy mac_an_restart() method
    https://git.kernel.org/netdev/net-next/c/76226787e137

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



