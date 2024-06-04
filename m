Return-Path: <netdev+bounces-100712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70288FBA5A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 19:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308711F24DF4
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7114114A61E;
	Tue,  4 Jun 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="fRYQaIBk"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D814A4D9;
	Tue,  4 Jun 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522036; cv=none; b=ZTYy3EoUxTLC57cHdPjVPEpJyTqa9Db0SZCOXbuRqQJaubVhUCJNRj/hlyuoqimBLvVnW64+SEPAB8aBO/tE7pwaJ9XOtMGM4TIfRI00zhS6WuyJLrFhcQwD7tIARDCCZsmtQM+SS34Em5hoFzmyS5yGq9Bx9lYSJadnhwXPIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522036; c=relaxed/simple;
	bh=AhkZuPpHQ3cux+x+mZLwO0uQb8cbs9T4dTiGLFrCc7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSzuro6o8CbI6yLOVI/0doRhMsDDDxK5FACmwkgH+MLRP7Dx9yT+9YqW87JB+/BbvHHM/m8oaQPWN88PxJH3sGy63Wm9C43MQ02dG4H+QHX+fESEhr+9uWWy4NKFWaxC9/TRDaTqzRcB2+++ye8bz6naufQc7pLXbbvZJ8aoq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=fRYQaIBk; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9C08688481;
	Tue,  4 Jun 2024 19:27:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717522032;
	bh=3NtwaV0lVIbVvfefAVmPkJRULKlNZkvRewz4sAE2MzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fRYQaIBkivP15jB/9X0FMmdKthdY+zvzdWW92V4p6yGsqzOGdWqpb9FRfQKpDSLAd
	 Y51mmCbzifnmHvC0MvNGQ6pmx1jLWIQNuclUNV68E+1Zq1YuNPBX8AFccRjsAwREV9
	 MWLZIRuIJPS5m4BtikgjEzKEPzJe9lSq+N0nc74/+civjx6Tqv2Junym+QPeZuzX5+
	 cNLw5XdO80KCpfw8zO5E13IvyO+poL6K3ptYTQmKt3WokfCYL4rCC9NwiJx0m4RoZz
	 jB1ucAFMzuLhRdH2aJy0/hT13GDA5GwizjfWubH/taAzqnuZlYWM/jQlUZx6GIwrwd
	 6lWUekjtvuF1g==
Message-ID: <3c40352b-ad69-4847-b665-e7b2df86a684@denx.de>
Date: Tue, 4 Jun 2024 19:05:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] net: ethernet: stmmac: add management of
 stm32mp13 for stm32
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
 <20240604143502.154463-8-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240604143502.154463-8-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/4/24 4:34 PM, Christophe Roullier wrote:
> Add Ethernet support for STM32MP13.
> STM32MP13 is STM32 SOC with 2 GMACs instances.
> GMAC IP version is SNPS 4.20.
> GMAC IP configure with 1 RX and 1 TX queue.
> DMA HW capability register supported
> RX Checksum Offload Engine supported
> TX Checksum insertion supported
> Wake-Up On Lan supported
> TSO supported
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 50 +++++++++++++++----
>   1 file changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index bed2be129b2d2..e59f8a845e01e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> @@ -84,12 +84,14 @@ struct stm32_dwmac {
>   	struct clk *clk_eth_ck;
>   	struct clk *clk_ethstp;
>   	struct clk *syscfg_clk;
> +	bool is_mp13;
>   	int ext_phyclk;
>   	int enable_eth_ck;
>   	int eth_clk_sel_reg;
>   	int eth_ref_clk_sel_reg;
>   	int irq_pwr_wakeup;
>   	u32 mode_reg;		 /* MAC glue-logic mode register */
> +	u32 mode_mask;
>   	struct regmap *regmap;
>   	u32 speed;
>   	const struct stm32_ops *ops;
> @@ -102,8 +104,8 @@ struct stm32_ops {
>   	void (*resume)(struct stm32_dwmac *dwmac);
>   	int (*parse_data)(struct stm32_dwmac *dwmac,
>   			  struct device *dev);
> -	u32 syscfg_eth_mask;
>   	bool clk_rx_enable_in_suspend;
> +	u32 syscfg_clr_off;
>   };
>   
>   static int stm32_dwmac_clk_enable(struct stm32_dwmac *dwmac, bool resume)
> @@ -227,7 +229,14 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
>   
>   	switch (plat_dat->mac_interface) {
>   	case PHY_INTERFACE_MODE_MII:
> -		val = SYSCFG_PMCR_ETH_SEL_MII;
> +		/*
> +		 * STM32MP15xx supports both MII and GMII, STM32MP13xx MII only.
> +		 * SYSCFG_PMCSETR ETH_SELMII is present only on STM32MP15xx and
> +		 * acts as a selector between 0:GMII and 1:MII. As STM32MP13xx
> +		 * supports only MII, ETH_SELMII is not present.
> +		 */
> +		if (!dwmac->is_mp13)	/* Select MII mode on STM32MP15xx */
> +			val |= SYSCFG_PMCR_ETH_SEL_MII;
>   		break;
>   	case PHY_INTERFACE_MODE_GMII:
>   		val = SYSCFG_PMCR_ETH_SEL_GMII;
> @@ -256,13 +265,16 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
>   
>   	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
>   
> +	/* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
> +	val <<= ffs(dwmac->mode_mask) - ffs(SYSCFG_MP1_ETH_MASK);
> +
>   	/* Need to update PMCCLRR (clear register) */
> -	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
> -		     dwmac->ops->syscfg_eth_mask);
> +	regmap_write(dwmac->regmap, dwmac->ops->syscfg_clr_off,
> +		     dwmac->mode_mask);
>   
>   	/* Update PMCSETR (set register) */
>   	return regmap_update_bits(dwmac->regmap, reg,
> -				 dwmac->ops->syscfg_eth_mask, val);
> +				 dwmac->mode_mask, val);
>   }
>   
>   static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
> @@ -303,7 +315,7 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
>   	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
>   
>   	return regmap_update_bits(dwmac->regmap, reg,
> -				 dwmac->ops->syscfg_eth_mask, val << 23);
> +				 SYSCFG_MCU_ETH_MASK, val << 23);
>   }
>   
>   static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, bool suspend)
> @@ -348,8 +360,15 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
>   		return PTR_ERR(dwmac->regmap);
>   
>   	err = of_property_read_u32_index(np, "st,syscon", 1, &dwmac->mode_reg);
> -	if (err)
> +	if (err) {
>   		dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
> +		return err;
> +	}
> +
> +	dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
> +	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
> +	if (err)
> +		pr_debug("Warning sysconfig register mask not set\n");

I _think_ you need to left-shift the mode mask by 8 for STM32MP13xx 
second GMAC somewhere in here, right ?

>   	return err;
>   }
> @@ -361,6 +380,8 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
>   	struct device_node *np = dev->of_node;
>   	int err = 0;
>   
> +	dwmac->is_mp13 = of_device_is_compatible(np, "st,stm32mp13-dwmac");

You could make is_mp13 part of struct stm32_ops {} just like 
syscfg_clr_off is part of struct stm32_ops {} .

>   	/* Ethernet PHY have no crystal */
>   	dwmac->ext_phyclk = of_property_read_bool(np, "st,ext-phyclk");
>   
> @@ -540,8 +561,7 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
>   	stm32_dwmac_suspend, stm32_dwmac_resume);
>   
>   static struct stm32_ops stm32mcu_dwmac_data = {
> -	.set_mode = stm32mcu_set_mode,
> -	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
> +	.set_mode = stm32mcu_set_mode

It is not necessary to remove the trailing comma ','

>   };
>   
>   static struct stm32_ops stm32mp1_dwmac_data = {
> @@ -549,13 +569,23 @@ static struct stm32_ops stm32mp1_dwmac_data = {
>   	.suspend = stm32mp1_suspend,
>   	.resume = stm32mp1_resume,
>   	.parse_data = stm32mp1_parse_data,
> -	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
> +	.syscfg_clr_off = 0x44,
> +	.clk_rx_enable_in_suspend = true
> +};
> +
> +static struct stm32_ops stm32mp13_dwmac_data = {
> +	.set_mode = stm32mp1_set_mode,
> +	.suspend = stm32mp1_suspend,
> +	.resume = stm32mp1_resume,
> +	.parse_data = stm32mp1_parse_data,
> +	.syscfg_clr_off = 0x08,
>   	.clk_rx_enable_in_suspend = true
>   };
>   
>   static const struct of_device_id stm32_dwmac_match[] = {
>   	{ .compatible = "st,stm32-dwmac", .data = &stm32mcu_dwmac_data},
>   	{ .compatible = "st,stm32mp1-dwmac", .data = &stm32mp1_dwmac_data},
> +	{ .compatible = "st,stm32mp13-dwmac", .data = &stm32mp13_dwmac_data},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, stm32_dwmac_match);

This patch definitely looks MUCH better than what this series started 
with, it is much easier to grasp the MP13 specific changes.

You could possibly improve this further and split the 
dwmac->ops->syscfg_eth_mask to dwmac->mode_mask conversion into separate 
preparatory patch (as a 6.5/11 in context of this series), and then add 
the few MP13 changes on top (as 7/11 patch).

