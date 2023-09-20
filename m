Return-Path: <netdev+bounces-35188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86BA7A779B
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E870B1C20ABF
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E2514283;
	Wed, 20 Sep 2023 09:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318E11721
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 09:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AC41C433C7;
	Wed, 20 Sep 2023 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695202224;
	bh=vC4eUrsH2Ay5ObH877X6wC9knycta7WDqSvROcgL6fI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RFg/orxs2Kk0ttJSiyrFNgDcPf6uXKdR9qYWcJZhrsFgLFMD2t5hkzlLer0pEUHRG
	 38oaWA1Ew/74EQZDulmnFruZ0siVlC9QJDI0yX4P3yb/hyR6Nw4tUhQyiJ7OlTeNLF
	 s/H7JqPZ4G65Ys8NrfNDxyegdZlqTkLHXMWEPs7zbQQD8o3Jj6vlPMDIBrVNC/hrWv
	 iAnPlVvVy77iPtjgjnyv8dA6tKel0eKzdSUsR1tvUxZZgrWmZXgK5HEILlrf2rm02m
	 QRzXJWZWCFNmDs9xfIYPB1g3MsurPFUQORgYl0QLHau1fwZV6rbaSyooEesmBh9z29
	 quvxmeYUTmbGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE09FC561EE;
	Wed, 20 Sep 2023 09:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: dsa: Convert to platform remove callback
 returning void
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169520222397.8158.5375930289513597156.git-patchwork-notify@kernel.org>
Date: Wed, 20 Sep 2023 09:30:23 +0000
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@codeaurora.org
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kurt@linutronix.de, f.fainelli@gmail.com, hauke@hauke-m.de,
 arinc.unal@arinc9.com, daniel@makrotopia.org, Landen.Chao@mediatek.com,
 dqfext@gmail.com, sean.wang@mediatek.com, matthias.bgg@gmail.com,
 colin.foster@in-advantage.com, vladimir.oltean@nxp.com,
 claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
 UNGLinuxDriver@microchip.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
 clement.leger@bootlin.com, netdev@vger.kernel.org, kernel@pengutronix.de,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 18 Sep 2023 21:19:07 +0200 you wrote:
> Hello,
> 
> this series converts all platform drivers below drivers/net/dsa to use
> remove_new. The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: dsa: b53: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/c306171d6914
  - [net-next,2/9] net: dsa: bcm_sf2: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/75f5205f1dd8
  - [net-next,3/9] net: dsa: hirschmann: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/beb8592d0416
  - [net-next,4/9] net: dsa: lantiq_gswip: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/a59f960c4d10
  - [net-next,5/9] net: dsa: mt7530: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/9764bbad3d33
  - [net-next,6/9] net: dsa: ocelot: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/68ace16ce330
  - [net-next,7/9] net: dsa: realtek: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/d48a5472b8f2
  - [net-next,8/9] net: dsa: rzn1_a5psw: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/76be075d7f99
  - [net-next,9/9] net: dsa: vitesse-vsc73xx: Convert to platform remove callback returning void
    https://git.kernel.org/netdev/net-next/c/ce322d45683f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



