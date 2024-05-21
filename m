Return-Path: <netdev+bounces-97375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55E08CB24D
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DAF1C220ED
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A965914430B;
	Tue, 21 May 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R125lnd/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B314291B;
	Tue, 21 May 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309405; cv=none; b=F+MwEzHIBsTfj0Y6q1H2VdS67SvpWf5Ks4YnTljISsNfBXf62HSme6pnM483vcAbWMOq07iJRWoaS7H3VFP20AcdCdyX0fLUvZ89qU0+izrHhOJlzbW6U7dNht/jyDU//7/oSPJYEWNhQsPtnjqYl5OhBVTYvvVUNEd7uLvDMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309405; c=relaxed/simple;
	bh=lYt216ymFJHBZ77aQufJ3Q3bw6WnfSXmHT40ibI+voI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHamugJo4dc8JmCZoxXMIIFKlhyPnML6B83vrSWl8BL9ix4HrvYTkbSxLZZ3totwdEuqEU3MEBE6qwMNCExNBDQFk4z0gz4VvBdh6dTSXLPJEgrt03zEcgoGCrzv8iaDiTssib4Un5cyNw8j4J1y/WGqc6/P2kq0NxNgBWVhDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R125lnd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D4DC4AF09;
	Tue, 21 May 2024 16:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716309405;
	bh=lYt216ymFJHBZ77aQufJ3Q3bw6WnfSXmHT40ibI+voI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R125lnd/GrW8NgD1Z4m0tbheWzZqVzXgZ+EsSDoel2OsjLM3dXYDHKxiV8i7szfBL
	 nGYAuwPC6KixOq3bAkHAX4scDgOhC3h8U/zPhYkYa6ZiuwRyNv3bivkKE+v4FnT/p6
	 Vo3xKNFwHnJ/ehFdJY6W8RoHOuybIgv5kirLnk5lBZgZYrqQdxg3K1TftWnvM1mvkU
	 c3Ezvo6WAXWP5zdlPdBfp64eNQc1D4WPuJZcpbZLDt6UJguBNGDi2fXI0Y9RD8tp/l
	 u2A2FoQlZkmXmHnBosKB+rJA9kAJDm1xN0JjCstmU+1sa8SJi0yiTbdVtA7bS3H1M7
	 xnPG0srtngn2w==
Date: Tue, 21 May 2024 17:36:39 +0100
From: Simon Horman <horms@kernel.org>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v4 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Message-ID: <20240521163639.GB839490@kernel.org>
References: <20240521101548.9286-1-SkyLake.Huang@mediatek.com>
 <20240521101548.9286-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521101548.9286-2-SkyLake.Huang@mediatek.com>

On Tue, May 21, 2024 at 06:15:44PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> Re-organize MediaTek ethernet phy driver files and get ready to integrate
> some common functions and add new 2.5G phy driver.
> mtk-ge.c: MT7530 Gphy on MT7621 & MT7531 Gphy
> mtk-ge-soc.c: Built-in Gphy on MT7981 & Built-in switch Gphy on MT7988
> mtk-2p5ge.c: Planned for built-in 2.5G phy on MT7988
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

...

> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 1df0595..e0e4b5e 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -251,22 +251,7 @@ config MAXLINEAR_GPHY
>  	  Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
>  	  GPY241, GPY245 PHYs.
>  
> -config MEDIATEK_GE_PHY
> -	tristate "MediaTek Gigabit Ethernet PHYs"
> -	help
> -	  Supports the MediaTek Gigabit Ethernet PHYs.
> -
> -config MEDIATEK_GE_SOC_PHY
> -	tristate "MediaTek SoC Ethernet PHYs"
> -	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
> -	depends on NVMEM_MTK_EFUSE
> -	help
> -	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
> -
> -	  Include support for built-in Ethernet PHYs which are present in
> -	  the MT7981 and MT7988 SoCs. These PHYs need calibration data
> -	  present in the SoCs efuse and will dynamically calibrate VCM
> -	  (common-mode voltage) during startup.
> +source "drivers/net/phy/mediatek/Kconfig"
>  
>  config MICREL_PHY
>  	tristate "Micrel PHYs"

...

> diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
> new file mode 100644
> index 0000000..2fa3a78
> --- /dev/null
> +++ b/drivers/net/phy/mediatek/Kconfig
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config MEDIATEK_GE_PHY
> +	tristate "MediaTek Gigabit Ethernet PHYs"
> +	help
> +	  Supports the MediaTek non-built-in Gigabit Ethernet PHYs.
> +
> +	  Non-built-in Gigabit Ethernet PHYs include mt7530/mt7531.
> +	  You may find mt7530 inside mt7621. This driver shares some
> +	  common operations with MediaTek SoC built-in Gigabit
> +	  Ethernet PHYs.
> +
> +config MEDIATEK_GE_SOC_PHY
> +	bool "MediaTek SoC Ethernet PHYs"

Hi,

This patch changes this kconfig option from tristate to bool.

This seems to break allmodconfig builds.

I think that is because MEDIATEK_GE_SOC_PHY is builtin while
PHYLIB is a module, and this driver uses symbols from PHYLIB.

> +	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
> +	select NVMEM_MTK_EFUSE
> +	help
> +	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
> +
> +	  Include support for built-in Ethernet PHYs which are present in
> +	  the MT7981 and MT7988 SoCs. These PHYs need calibration data
> +	  present in the SoCs efuse and will dynamically calibrate VCM
> +	  (common-mode voltage) during startup.

...

-- 
pw-bot: changes-requested

