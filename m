Return-Path: <netdev+bounces-45432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 212957DCF44
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 15:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95C32817AF
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEA6134DB;
	Tue, 31 Oct 2023 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jXMEbn58"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1F1DFD4
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:33:56 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D8EA
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:33:55 -0700 (PDT)
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D98153F19A
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1698762832;
	bh=COgus/3ZSuwT+db+ge/hLLqZedK9bhS7aDmQpcwmeRs=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=jXMEbn58CbZZ3KoHutFiOPx3grW56ovuFGjvdz6LXU9NbH5MgMND7rAwDZZ84HCme
	 b/bb0gqu52HlyXRDqRHriG/8fQ+fmS83USW2ytM/pUuuQz2gyzMnXhfUlsdiwWbBj8
	 +dYaVaOV8yZh/uuXF9xAu5EW3Igc8kJm/lBj57yPSl3yy61akETtoM3ARabmeO3H65
	 muJ4gSjhCSuIdKDXW8g+OUfpfwokIgqj9LTHG7iyaspjDSdzCm2k0gxHD3Me2KGpEY
	 +0gKARxUQj6O54LD6wkbJnygaw0bzJDthaf7o+P1R9vWucH6Rb+S28aSj4pWBytJGb
	 z/O7ZXGu2G6ZQ==
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66cffe51b07so73504076d6.3
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698762831; x=1699367631;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COgus/3ZSuwT+db+ge/hLLqZedK9bhS7aDmQpcwmeRs=;
        b=GwLaR6ninGrboVj+368PinBd4vOQ2cUerOXM1G0k55w964bfipykY8y5SyKdrtmIYo
         4NLlS0fzmHfj7rv2W7RIAQbi6eypUk/ZJhmES2voYkouGpdSOfACob+Fkoc05VJvhPxO
         nNDANqle+aX6kURJjynuqGqK/Loa+Aztfw+A5TOZz7f+OdIGEz9DNE4f+hmnqkHO4kcZ
         K3wFAuNsjWr3vHYyDdWQWkkZKQlSqsmVjZrMDeHg8sM5qw1iFXckXe+0QB/ujrlJLaSO
         MOXPIxv0t/8wj/ay2lkkfk3qTCQiW7WGZJMfvpCGeO7njEtybWV81lxDlSzX/VWzUlCR
         koaA==
X-Gm-Message-State: AOJu0YzK1RR4GuQD4ILI2KnNBFxAgOxV4hed0qqoPkGZO37e5dZmPsFL
	8nRzw3qGkEFTWDC2Cd23mK+8oZVsV0oLgerPsd+Iz+GAsOcEVTur7Au4WHeTDK3YXlNNivXTkpw
	3VDtTGpz/fqwKKXxW8h46XkB9YuGpTiTy9/3BTHYhEmM66j61Ig==
X-Received: by 2002:a05:6214:29c7:b0:671:9c02:cba9 with SMTP id gh7-20020a05621429c700b006719c02cba9mr8520630qvb.51.1698762831409;
        Tue, 31 Oct 2023 07:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF74SsUAurkkruUb75fgXBV0BIjaQzXoMkI8lq6APUuq85/spyU3nh/61hrUO+aeB6Sqk13/8jIe+UO0RD6jOs=
X-Received: by 2002:a05:6214:29c7:b0:671:9c02:cba9 with SMTP id
 gh7-20020a05621429c700b006719c02cba9mr8520611qvb.51.1698762831069; Tue, 31
 Oct 2023 07:33:51 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 Oct 2023 07:33:50 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231029042712.520010-6-cristian.ciocaltea@collabora.com>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com> <20231029042712.520010-6-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 31 Oct 2023 07:33:50 -0700
Message-ID: <CAJM55Z8K5QztgU9NYiJ1kv+-BSsgP=LCABN7BYDtQ30_G1Nc7w@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] net: stmmac: dwmac-starfive: Add support for
 JH7100 SoC
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Samin Guo <samin.guo@starfivetech.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

Cristian Ciocaltea wrote:
> Add a missing quirk to enable support for the StarFive JH7100 SoC.
>
> Additionally, for greater flexibility in operation, allow using the
> rgmii-rxid and rgmii-txid phy modes.
>
> Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Hi Cristian,

Thanks for working on this! This driver has code to update the phy clock for
different line speeds. I don't think that will work without the
CLK_SET_RATE_PARENT flag added to the clock in [1] which in turn depends on
[2].

[1]: https://github.com/esmil/linux/commit/b200c3054b58a49ba25af67aff82d9045e3c3666
[2]: https://github.com/esmil/linux/commit/dce189542c16bf0eb8533d96c0305cb59d149dae

Two more comments below..

> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  6 ++--
>  .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 32 ++++++++++++++++---
>  2 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index a2b9e289aa36..c3c2c8360047 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -165,9 +165,9 @@ config DWMAC_STARFIVE
>  	help
>  	  Support for ethernet controllers on StarFive RISC-V SoCs
>
> -	  This selects the StarFive platform specific glue layer support for
> -	  the stmmac device driver. This driver is used for StarFive JH7110
> -	  ethernet controller.
> +	  This selects the StarFive platform specific glue layer support
> +	  for the stmmac device driver. This driver is used for the
> +	  StarFive JH7100 and JH7110 ethernet controllers.
>
>  config DWMAC_STI
>  	tristate "STi GMAC support"
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> index 5d630affb4d1..88c431edcea0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> @@ -15,13 +15,20 @@
>
>  #include "stmmac_platform.h"
>
> -#define STARFIVE_DWMAC_PHY_INFT_RGMII	0x1
> -#define STARFIVE_DWMAC_PHY_INFT_RMII	0x4
> -#define STARFIVE_DWMAC_PHY_INFT_FIELD	0x7U
> +#define STARFIVE_DWMAC_PHY_INFT_RGMII		0x1
> +#define STARFIVE_DWMAC_PHY_INFT_RMII		0x4
> +#define STARFIVE_DWMAC_PHY_INFT_FIELD		0x7U
> +
> +#define JH7100_SYSMAIN_REGISTER49_DLYCHAIN	0xc8
> +
> +struct starfive_dwmac_data {
> +	unsigned int gtxclk_dlychain;
> +};
>
>  struct starfive_dwmac {
>  	struct device *dev;
>  	struct clk *clk_tx;
> +	const struct starfive_dwmac_data *data;
>  };
>
>  static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
> @@ -67,6 +74,8 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
>
>  	case PHY_INTERFACE_MODE_RGMII:
>  	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
>  		mode = STARFIVE_DWMAC_PHY_INFT_RGMII;
>  		break;
>
> @@ -89,6 +98,14 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	if (err)
>  		return dev_err_probe(dwmac->dev, err, "error setting phy mode\n");
>
> +	if (dwmac->data) {

I think you want something like this so future quirks don't need to touch this
code:

	if (dwmac->data && dwmac->data->gtxclk_dlychain)

> +		err = regmap_write(regmap, JH7100_SYSMAIN_REGISTER49_DLYCHAIN,
> +				   dwmac->data->gtxclk_dlychain);
> +		if (err)
> +			return dev_err_probe(dwmac->dev, err,
> +					     "error selecting gtxclk delay chain\n");
> +	}
> +
>  	return 0;
>  }
>
> @@ -114,6 +131,8 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
>  	if (!dwmac)
>  		return -ENOMEM;
>
> +	dwmac->data = device_get_match_data(&pdev->dev);
> +
>  	dwmac->clk_tx = devm_clk_get_enabled(&pdev->dev, "tx");
>  	if (IS_ERR(dwmac->clk_tx))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->clk_tx),
> @@ -144,8 +163,13 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
>  	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
>  }
>
> +static const struct starfive_dwmac_data jh7100_data = {
> +	.gtxclk_dlychain = 4

Please add a , at the end of this line. I know it's unlikely that we need to
add more properties, but it's still good practice to do. This way such patches
won't need to touch this line.

> +};
> +
>  static const struct of_device_id starfive_dwmac_match[] = {
> -	{ .compatible = "starfive,jh7110-dwmac"	},
> +	{ .compatible = "starfive,jh7100-dwmac", .data = &jh7100_data },
> +	{ .compatible = "starfive,jh7110-dwmac" },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, starfive_dwmac_match);
> --
> 2.42.0
>

