Return-Path: <netdev+bounces-217224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9ABB37DB4
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2011B63088
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123D62FD1A9;
	Wed, 27 Aug 2025 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0PEvmLKd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30C192B84;
	Wed, 27 Aug 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756283106; cv=none; b=ILV/a1qwK0y+OJN4KcW6imVzqa1Y6If1q+3Mh1IhoKx20fDqc/QmsUslE5ECAmBvhnAVP7JJoHFzQR1XUIR1RUnawBVizqGGhFIF+IRgmF51vCYWPULxPWKI22kxbqH1aXVmFIFJLRTVoz9tHdSr0vxwXRvuKN/4YCw9jQ00YUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756283106; c=relaxed/simple;
	bh=7MzOmrm8rrQp+hXTksvCOI2puqNTUDNWi4DQ91lmPf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wph6dHwolw0GMCOUi89wc6m4Ma7pwzdIt4dVBrc9/7+eQavMWCpEY4cUVzlQaLzqHN5pdu8E+m+sLGfYYBvCuereM1jg5qk42xHmv4/MLRmwf2NTYqDEu2U+QQhjGwjgQV+1Ju2ImjXvUCg1IVYt/gnfac7P1WzkqCqS9qXus/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0PEvmLKd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KGZ9fOwje4MlqtMCuczbLxb/Olo2qc1yHQaGkujfbWg=; b=0PEvmLKdfidIG6CQlBbJ38O/N6
	35bcf3xx776W1e4TOIvZSQ1ph3SkNL4KmOvzUsxl3WOTm3FPJhEC21oe/elTgB+K1ar2o40rqS3pb
	l4uc1hMPr+dT7TlvbY9TexsZXSRxN61QOcriD1wl2ckYcv6ae92U0oerZimP3HdoHPNEAV9B2lYVe
	eQtW9kz80lNScz26Qdhn8ssO3pmqStU/7nq3IRR07KV1+b16otoYYKktKYPjPzl0upNPIFAqO3uq5
	Je5W8yMySwD1lERtOW6Kq+GI/Ajrl7ievIhVgEZSBDj2CJ5DeWVic3Dv/YtsXkNJFupr4IGppXXYa
	StGQS9dA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33890)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1urBSi-000000000Cj-3ECE;
	Wed, 27 Aug 2025 09:24:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1urBSd-0000000022P-2QG2;
	Wed, 27 Aug 2025 09:24:51 +0100
Date: Wed, 27 Aug 2025 09:24:51 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: weishangjuan@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com, faizal.abdul.rahim@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	jan.petrous@oss.nxp.com, jszhang@kernel.org, p.zabel@pengutronix.de,
	boon.khai.ng@altera.com, 0x1207@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com
Subject: Re: [PATCH v4 2/2] ethernet: eswin: Add eic7700 ethernet driver
Message-ID: <aK7A0-nYxBQM03zq@shell.armlinux.org.uk>
References: <20250827081135.2243-1-weishangjuan@eswincomputing.com>
 <20250827081418.2347-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827081418.2347-1-weishangjuan@eswincomputing.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 27, 2025 at 04:14:17PM +0800, weishangjuan@eswincomputing.com wrote:
> +struct eic7700_qos_priv {
> +	struct device *dev;
> +	struct regmap *hsp_regmap;
> +	struct clk *clk_tx;

Consider putting a pointer to the plat_dat here instead of clk_tx.

> +	struct clk *clk_axi;
> +	struct clk *clk_cfg;

Consider moving these into plat_dat->clks.

> +	u32 tx_delay_ps;
> +	u32 rx_delay_ps;
> +};
> +
> +/**
> + * eic7700_apply_delay - Update TX or RX delay bits in delay parameter value.
> + * @delay_ps: Delay in picoseconds (capped at 12.7ns).
> + * @reg:      Pointer to register value to modify.
> + * @is_rx:    True for RX delay (bits 30:24), false for TX delay (bits 14:8).
> + *
> + * Converts delay to 0.1ns units, caps at 0x7F, and sets appropriate bits.
> + * Only RX or TX bits are updated; other bits remain unchanged.
> + */
> +static inline void eic7700_apply_delay(u32 delay_ps, u32 *reg, bool is_rx)
> +{
> +	if (!reg)
> +		return;
> +
> +	u32 val = min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
> +
> +	if (is_rx) {
> +		*reg &= ~EIC7700_ETH_RX_ADJ_DELAY;
> +		*reg |= (val << 24) & EIC7700_ETH_RX_ADJ_DELAY;
> +	} else {
> +		*reg &= ~EIC7700_ETH_TX_ADJ_DELAY;
> +		*reg |= (val << 8) & EIC7700_ETH_TX_ADJ_DELAY;
> +	}
> +}
> +
> +static int eic7700_clks_config(void *priv, bool enabled)
> +{
> +	struct eic7700_qos_priv *dwc = (struct eic7700_qos_priv *)priv;
> +	int ret = 0;
> +
> +	if (enabled) {
> +		ret = clk_prepare_enable(dwc->clk_tx);
> +		if (ret < 0) {
> +			dev_err(dwc->dev, "Failed to enable tx clock: %d\n",
> +				ret);
> +			goto err;
> +		}
> +
> +		ret = clk_prepare_enable(dwc->clk_axi);
> +		if (ret < 0) {
> +			dev_err(dwc->dev, "Failed to enable axi clock: %d\n",
> +				ret);
> +			goto err_tx;
> +		}
> +
> +		ret = clk_prepare_enable(dwc->clk_cfg);
> +		if (ret < 0) {
> +			dev_err(dwc->dev, "Failed to enable cfg clock: %d\n",
> +				ret);
> +			goto err_axi;
> +		}

You can then use clk_bulk_prepare_enable() here without the complex
unwinding if one enable fails.

> +	} else {
> +		clk_disable_unprepare(dwc->clk_tx);
> +		clk_disable_unprepare(dwc->clk_axi);
> +		clk_disable_unprepare(dwc->clk_cfg);

and clk_bulk_disable_unprepare() here.

> +	}
> +	return ret;
> +
> +err_axi:
> +	clk_disable_unprepare(dwc->clk_axi);
> +err_tx:
> +	clk_disable_unprepare(dwc->clk_tx);
> +err:
> +	return ret;
> +}
> +
> +static int eic7700_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct stmmac_resources stmmac_res;
> +	struct eic7700_qos_priv *dwc_priv;
> +	u32 eth_axi_lp_ctrl_offset;
> +	u32 eth_phy_ctrl_offset;
> +	u32 eth_phy_ctrl_regset;
> +	u32 eth_rxd_dly_offset;
> +	u32 eth_dly_param = 0;
> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				"failed to get resources\n");
> +
> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat_dat))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
> +				"dt configuration failed\n");
> +
> +	dwc_priv = devm_kzalloc(&pdev->dev, sizeof(*dwc_priv), GFP_KERNEL);
> +	if (!dwc_priv)
> +		return -ENOMEM;
> +
> +	dwc_priv->dev = &pdev->dev;
> +
> +	/* Read rx-internal-delay-ps and update rx_clk delay */
> +	if (!of_property_read_u32(pdev->dev.of_node,
> +				  "rx-internal-delay-ps",
> +				  &dwc_priv->rx_delay_ps)) {
> +		eic7700_apply_delay(dwc_priv->rx_delay_ps,
> +				    &eth_dly_param, true);
> +	} else {
> +		dev_warn(&pdev->dev, "can't get rx-internal-delay-ps\n");
> +	}
> +
> +	/* Read tx-internal-delay-ps and update tx_clk delay */
> +	if (!of_property_read_u32(pdev->dev.of_node,
> +				  "tx-internal-delay-ps",
> +				  &dwc_priv->tx_delay_ps)) {
> +		eic7700_apply_delay(dwc_priv->tx_delay_ps,
> +				    &eth_dly_param, false);
> +	} else {
> +		dev_warn(&pdev->dev, "can't get tx-internal-delay-ps\n");
> +	}
> +
> +	dwc_priv->hsp_regmap =
> +		syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +						"eswin,hsp-sp-csr");
> +	if (IS_ERR(dwc_priv->hsp_regmap))
> +		return dev_err_probe(&pdev->dev,
> +				PTR_ERR(dwc_priv->hsp_regmap),
> +				"Failed to get hsp-sp-csr regmap\n");
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node,
> +					 "eswin,hsp-sp-csr",
> +					 1, &eth_phy_ctrl_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev,
> +				ret,
> +				"can't get eth_phy_ctrl_offset\n");
> +
> +	regmap_read(dwc_priv->hsp_regmap, eth_phy_ctrl_offset,
> +		    &eth_phy_ctrl_regset);
> +	eth_phy_ctrl_regset |=
> +		(EIC7700_ETH_TX_CLK_SEL | EIC7700_ETH_PHY_INTF_SELI);
> +	regmap_write(dwc_priv->hsp_regmap, eth_phy_ctrl_offset,
> +		     eth_phy_ctrl_regset);
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node,
> +					 "eswin,hsp-sp-csr",
> +					 2, &eth_axi_lp_ctrl_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev,
> +				ret,
> +				"can't get eth_axi_lp_ctrl_offset\n");
> +
> +	regmap_write(dwc_priv->hsp_regmap, eth_axi_lp_ctrl_offset,
> +		     EIC7700_ETH_CSYSREQ_VAL);
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node,
> +					 "eswin,hsp-sp-csr",
> +					 3, &eth_rxd_dly_offset);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev,
> +				ret,
> +				"can't get eth_rxd_dly_offset\n");
> +
> +	regmap_write(dwc_priv->hsp_regmap, eth_rxd_dly_offset,
> +		     eth_dly_param);
> +
> +	dwc_priv->clk_tx = devm_clk_get(&pdev->dev, "tx");
> +	if (IS_ERR(dwc_priv->clk_tx))
> +		return dev_err_probe(&pdev->dev,
> +				PTR_ERR(dwc_priv->clk_tx),
> +				"error getting tx clock\n");
> +
> +	dwc_priv->clk_axi = devm_clk_get(&pdev->dev, "axi");
> +	if (IS_ERR(dwc_priv->clk_axi))
> +		return dev_err_probe(&pdev->dev,
> +				PTR_ERR(dwc_priv->clk_axi),
> +				"error getting axi clock\n");
> +
> +	dwc_priv->clk_cfg = devm_clk_get(&pdev->dev, "cfg");
> +	if (IS_ERR(dwc_priv->clk_cfg))
> +		return dev_err_probe(&pdev->dev,
> +				PTR_ERR(dwc_priv->clk_cfg),
> +				"error getting cfg clock\n");

These then become devm_clk_bulk_get_all().

> +
> +	ret = eic7700_clks_config(dwc_priv, true);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev,
> +				ret,
> +				"error enable clock\n");

Maybe even devm_clk_bulk_get_all_enabled() which will omit this
step...

> +
> +	plat_dat->clk_tx_i = dwc_priv->clk_tx;
> +	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
> +	plat_dat->bsp_priv = dwc_priv;
> +	plat_dat->clks_config = eic7700_clks_config;
> +
> +	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> +	if (ret) {
> +		eic7700_clks_config(dwc_priv, false);

... and means you don't need this call...

> +		return dev_err_probe(&pdev->dev,
> +				ret,
> +				"Failed to driver probe\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static void eic7700_dwmac_remove(struct platform_device *pdev)
> +{
> +	struct eic7700_qos_priv *dwc_priv = get_stmmac_bsp_priv(&pdev->dev);
> +
> +	stmmac_pltfr_remove(pdev);
> +	eic7700_clks_config(dwc_priv, false);
> +}

... and you can remove this function entirely ...

> +
> +static const struct of_device_id eic7700_dwmac_match[] = {
> +	{ .compatible = "eswin,eic7700-qos-eth" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, eic7700_dwmac_match);
> +
> +static struct platform_driver eic7700_dwmac_driver = {
> +	.probe  = eic7700_dwmac_probe,
> +	.remove = eic7700_dwmac_remove,

... replacing this with stmmac_pltfr_remove().

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

