Return-Path: <netdev+bounces-117202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF1C94D103
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670C5284072
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BC8194C93;
	Fri,  9 Aug 2024 13:17:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F92F37;
	Fri,  9 Aug 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209422; cv=none; b=cmchyC3HKc4tfd+l3wGsn6k6U6mabs8DLQAMaaVouX2xBGJzmuYmBHyyUVzYjm5qGxUBhtPn3zJcAZu69bzCEECq3Iqqr7XrjRJMfdUqY6aP1a3M93UmX4ruvOuSXwILFxuFgdvCLpEPSZsAZgYyCG1jRrf/FvdUyj4aNI9rvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209422; c=relaxed/simple;
	bh=QHLWQ9mpMsfHRRIAi/pbTsHewE4sjulFRdL77xUI7ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmCzzvciZ1fFdeEtr8+sO+q2EtHr1Rp5iXLoGQbeOgoPwOtj/kZU6eckvGHVdWGciYe/Z7M995A2Wfrxz83RTYCKKiZ3RCtgYwKx/qdPWijTRypdxfy/ZGeF1KPQuQCZ0rRxtpptC1dSCCnEcJBikda17o5XVk83f+K0bQsMaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b02.versanet.de ([83.135.91.2] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1scPU5-00076L-DZ; Fri, 09 Aug 2024 15:16:45 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 David Wu <david.wu@rock-chips.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 kernel@collabora.com, Detlev Casanova <detlev.casanova@collabora.com>
Subject:
 Re: [PATCH v2 2/2] ethernet: stmmac: dwmac-rk: Add GMAC support for RK3576
Date: Fri, 09 Aug 2024 15:16:44 +0200
Message-ID: <3724132.9z1YWOviru@diego>
In-Reply-To: <20240808170113.82775-3-detlev.casanova@collabora.com>
References:
 <20240808170113.82775-1-detlev.casanova@collabora.com>
 <20240808170113.82775-3-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Detlev,

Am Donnerstag, 8. August 2024, 19:00:18 CEST schrieb Detlev Casanova:
> From: David Wu <david.wu@rock-chips.com>
> 
> Add constants and callback functions for the dwmac on RK3576 soc.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> [rebase, extracted bindings]
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 156 ++++++++++++++++++
>  1 file changed, 156 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 7ae04d8d291c8..e1fa8fc9f4012 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1116,6 +1116,161 @@ static const struct rk_gmac_ops rk3568_ops = {
>  	},
>  };
>  
> +/* VCCIO0_1_3_IOC */
> +#define RK3576_VCCIO0_1_3_IOC_CON2		0X6408
> +#define RK3576_VCCIO0_1_3_IOC_CON3		0X640c
> +#define RK3576_VCCIO0_1_3_IOC_CON4		0X6410
> +#define RK3576_VCCIO0_1_3_IOC_CON5		0X6414
> +
> +#define RK3576_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(15)
> +#define RK3576_GMAC_RXCLK_DLY_DISABLE		GRF_CLR_BIT(15)
> +#define RK3576_GMAC_TXCLK_DLY_ENABLE		GRF_BIT(7)
> +#define RK3576_GMAC_TXCLK_DLY_DISABLE		GRF_CLR_BIT(7)
> +
> +#define RK3576_GMAC_CLK_RX_DL_CFG(val)		HIWORD_UPDATE(val, 0x7F, 8)
> +#define RK3576_GMAC_CLK_TX_DL_CFG(val)		HIWORD_UPDATE(val, 0x7F, 0)
> +
> +/* SDGMAC_GRF */
> +#define RK3576_GRF_GMAC_CON0			0X0020
> +#define RK3576_GRF_GMAC_CON1			0X0024
> +
> +#define RK3576_GMAC_RMII_MODE			GRF_BIT(3)
> +#define RK3576_GMAC_RGMII_MODE			GRF_CLR_BIT(3)
> +
> +#define RK3576_GMAC_CLK_SELET_IO		GRF_BIT(7)
> +#define RK3576_GMAC_CLK_SELET_CRU		GRF_CLR_BIT(7)

nit: typos _CLK_SELECT_ ... missing the C in select

> +
> +#define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
> +#define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)

I think those are backwards
The TRM says bit[5]=0: 25MHz (DIV2) and bit[5]=1: 2.5MHz (DIV20)

I guess nobody also on Rockchip's side tested a RMII phy on those controllrs


> +
> +#define RK3576_GMAC_CLK_RGMII_DIV1		\
> +			(GRF_CLR_BIT(6) | GRF_CLR_BIT(5))
> +#define RK3576_GMAC_CLK_RGMII_DIV5		\
> +			(GRF_BIT(6) | GRF_BIT(5))
> +#define RK3576_GMAC_CLK_RGMII_DIV50		\
> +			(GRF_BIT(6) | GRF_CLR_BIT(5))
> +

in contrast, these are correct and match the TRM


> +#define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
> +#define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
> +
> +static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
> +				int tx_delay, int rx_delay)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +	unsigned int offset_con;
> +
> +	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
> +		dev_err(dev, "Missing rockchip,grf or rockchip,php_grf property\n");
> +		return;
> +	}
> +
> +	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
> +					 RK3576_GRF_GMAC_CON0;
> +
> +	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RGMII_MODE);
> +
> +	offset_con = bsp_priv->id == 1 ? RK3576_VCCIO0_1_3_IOC_CON4 :
> +					 RK3576_VCCIO0_1_3_IOC_CON2;
> +
> +	/* m0 && m1 delay enabled */
> +	regmap_write(bsp_priv->php_grf, offset_con,
> +		     DELAY_ENABLE(RK3576, tx_delay, rx_delay));
> +	regmap_write(bsp_priv->php_grf, offset_con + 0x4,
> +		     DELAY_ENABLE(RK3576, tx_delay, rx_delay));
> +
> +	/* m0 && m1 delay value */
> +	regmap_write(bsp_priv->php_grf, offset_con,
> +		     RK3576_GMAC_CLK_TX_DL_CFG(tx_delay) |
> +		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
> +	regmap_write(bsp_priv->php_grf, offset_con + 0x4,
> +		     RK3576_GMAC_CLK_TX_DL_CFG(tx_delay) |
> +		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
> +}
> +
> +static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +	unsigned int offset_con;
> +
> +	if (IS_ERR(bsp_priv->php_grf)) {
> +		dev_err(dev, "%s: Missing rockchip,php_grf property\n", __func__);
> +		return;
> +	}
> +
> +	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
> +					 RK3576_GRF_GMAC_CON0;
> +
> +	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RMII_MODE);
> +}
> +
> +static void rk3576_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +	unsigned int val = 0, offset_con;
> +
> +	switch (speed) {
> +	case 10:
> +		if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII)
> +			val = RK3576_GMAC_CLK_RMII_DIV20;
> +		else
> +			val = RK3576_GMAC_CLK_RGMII_DIV50;

		val = bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII ?
				RK3576_GMAC_CLK_RMII_DIV20 :
				RK3576_GMAC_CLK_RGMII_DIV50;
perhaps?

> +		break;
> +	case 100:
> +		if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII)
> +			val = RK3576_GMAC_CLK_RMII_DIV2;
> +		else
> +			val = RK3576_GMAC_CLK_RGMII_DIV5;

same as above?

> +		break;
> +	case 1000:
> +		if (bsp_priv->phy_iface != PHY_INTERFACE_MODE_RMII)
> +			val = RK3576_GMAC_CLK_RGMII_DIV1;
> +		else
> +			goto err;

		if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_RMII)
			goto err;

		val = RK3576_GMAC_CLK_RGMII_DIV1;


> +		break;
> +	default:
> +		goto err;
> +	}
> +
> +	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
> +					 RK3576_GRF_GMAC_CON0;
> +
> +	regmap_write(bsp_priv->grf, offset_con, val);
> +
> +	return;
> +err:
> +	dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
> +}
> +
> +static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
> +				       bool enable)
> +{
> +	unsigned int val = input ? RK3576_GMAC_CLK_SELET_IO :
> +				   RK3576_GMAC_CLK_SELET_CRU;
> +	unsigned int offset_con;
> +
> +	val |= enable ? RK3576_GMAC_CLK_RMII_NOGATE :
> +			RK3576_GMAC_CLK_RMII_GATE;
> +
> +	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
> +					 RK3576_GRF_GMAC_CON0;

nit: alignment of both looks like it could be nicer

Heiko



