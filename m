Return-Path: <netdev+bounces-22142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC85D76628F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 05:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0BE282609
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5976D3D68;
	Fri, 28 Jul 2023 03:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF03D76
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E700C43391;
	Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690515623;
	bh=nh7VNF71Px8+ehWsNezgTEu3Q5hpaEOt5oKxXH92/qA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n5OOA0hexFDJfGiqn8bTgbsd1NxuBlbkYDKSx4jve1A1uhS5AnTOvFTQV4JWG7aBf
	 g/w60ZUiuyy1xVob0CGewYJXVq1VL+QTFR/Web3ZJJ2NNh+cY5USv/q3z7SDcq/wTR
	 lonQnxK346qjNlcQZfWCfeuaLMI8E7TUSZjSKMLEMehF+DgMrtLu+XmXsACHxfUrce
	 uCl8v7KPKSe+YopRiOOHSvNs0MFFYZuVftoYlnB7ke0VUB/3LypcDS6Ej2rHAU9kNd
	 8tKWHNxo+5s5dfDX+o4x42ap7+FrTJwJM45yRjAs4oZ8Nub3PfEMVbrmDiV7UKUGPk
	 vMj95R4jHRhaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 417E1C691EE;
	Fri, 28 Jul 2023 03:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: Explicitly include correct DT includes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169051562326.23821.4231940284607437337.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 03:40:23 +0000
References: <20230727014944.3972546-1-robh@kernel.org>
In-Reply-To: <20230727014944.3972546-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: andreas@gaisler.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, iyappan@os.amperecomputing.com,
 keyur@os.amperecomputing.com, chris.snook@gmail.com,
 nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
 madalin.bucur@nxp.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 linux-imx@nxp.com, sean.anderson@seco.com, pantelis.antoniou@gmail.com,
 leoyang.li@nxp.com, yisen.zhuang@huawei.com, salil.mehta@huawei.com,
 dougmill@linux.ibm.com, mw@semihalf.com, linux@armlinux.org.uk,
 taras.chornyi@plvision.eu, mlindner@marvell.com, stephen@networkplumber.org,
 nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, horatiu.vultur@microchip.com,
 UNGLinuxDriver@microchip.com, alexandre.belloni@bootlin.com,
 timur@kernel.org, s.shtylyov@omp.ru, steve.glendinning@shawell.net,
 hayashi.kunihiko@socionext.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, vkoul@kernel.org,
 bhupesh.sharma@linaro.org, kernel@esmil.dk, samin.guo@starfivetech.com,
 wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com,
 nobuhiro1.iwamatsu@toshiba.co.jp, grygorii.strashko@ti.com,
 kevinbrace@bracecomputerlab.com, romieu@fr.zoreil.com, michal.simek@amd.com,
 radhey.shyam.pandey@amd.com, alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, elder@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, richardcochran@gmail.com, elder@linaro.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-amlogic@lists.infradead.org,
 linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-wpan@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 19:49:39 -0600 you wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: Explicitly include correct DT includes
    https://git.kernel.org/netdev/net-next/c/3d40aed86287

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



