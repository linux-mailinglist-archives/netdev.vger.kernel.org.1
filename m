Return-Path: <netdev+bounces-184411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5561A954E5
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 18:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABDE16B995
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027AC1D88D0;
	Mon, 21 Apr 2025 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="r0QPJ3xf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD0A17C77
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745254094; cv=none; b=cF6LYOUpZi9qHpc73IoXtec+eOgIwnXX+z8a9lOyGia0wU/LC/EdUiNTUUPmjcn7lzyv0Jo2zXtElskUgY6+rlCieXwW7EHd7Xd/RjFFFykFXc4sEqcTPHVzX5hcrXA2XNOPoBUI6W+Ym+Wv4aC9dk4mQxGNek6K/zfGAk5RbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745254094; c=relaxed/simple;
	bh=jUSicrNEmTv8RzLjQt/YWviKgPDkq5/4lQCuioRKwQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTFACrM5PRtvsf+Ms9g+yXzkd2xT6lCb6JMFyL/083oXZna8m9cbndIIArW9yBnfZSqIXmhU1MVJAS+h7WXBj+giQhtBNpb2BnF+ZYrFJZpHetVp9svzpHa/D3q3HNrsSGQdhh7dPPqJM2jAey0lBTMidURZGq15aqNrAdnVqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=r0QPJ3xf; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1745254091;
 bh=tmMMVh9ut/6pECDrXwuZNSGIOc+pxyHd/3NaqPyvhi0=;
 b=r0QPJ3xfQBVJKSd9AtRAOTmoufadyhqvB+E6/jAfocaR4xX82i9+Jc1VWB+kTtDdJwOf5krs7
 45ZrNmSv9xJO/JCc0kxAvhOvBKfGrYmmU7107eDar54sEJ+H4zqDjRTRDXT393CN79IY5RKEdH5
 VHK7vm1P4YPjvUTmxsguHC+rDIS2eW9KOU77JETCie7YSfuxJx+jshV6DeGSl+nIdH6PP2avf6P
 ff2I5DdgohDWEGYeO2yQhUHQ8c3deh+UFbgCfyQD3NJm0u/tBjZZsUX2GaPOOkAXEL4Mz4IN/oj
 0A3+DsIvqhMcsuD/RMnpT3mTMNn7L2YyeziqDFPMBwqg==
X-Forward-Email-ID: 680676c88a5cda485177da7b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <afc99921-d9ba-4f6e-b828-bc880d55955c@kwiboo.se>
Date: Mon, 21 Apr 2025 18:48:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] ethernet: stmmac: dwmac-rk: Add gmac support for
 rk3562
To: Kever Yang <kever.yang@rock-chips.com>, heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org, David Wu <david.wu@rock-chips.com>,
 linux-arm-kernel@lists.infradead.org,
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, netdev@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai
 <wens@csie.org>, linux-stm32@st-md-mailman.stormreply.com,
 Eric Dumazet <edumazet@google.com>
References: <20250418095114.271562-1-kever.yang@rock-chips.com>
 <20250418095114.271562-2-kever.yang@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250418095114.271562-2-kever.yang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kever,

On 2025-04-18 11:51, Kever Yang wrote:
> From: David Wu <david.wu@rock-chips.com>
> 
> Add constants and callback functions for the dwmac on RK3562 soc.
> As can be seen, the base structure is the same.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v3:
> - remove unreadable MACRO;
> - use two function for rmii and rgmii speed set;
> - don't check grf and php_grf in function call;
> - rebase on v6.15-rc1
> 
> Changes in v2:
> - Collect review tag
> 
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 190 ++++++++++++++++++
>  1 file changed, 190 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 700858ff6f7c..82174054644a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -2,6 +2,7 @@
>  /**
>   * DOC: dwmac-rk.c - Rockchip RK3288 DWMAC specific glue layer
>   *
> + * Copyright (c) 2014 Rockchip Electronics Co., Ltd.
>   * Copyright (C) 2014 Chen-Zhi (Roger Chen)
>   *
>   * Chen-Zhi (Roger Chen)  <roger.chen@rock-chips.com>
> @@ -1048,6 +1049,194 @@ static const struct rk_gmac_ops rk3528_ops = {
>  	},
>  };
>  
> +/* sys_grf */
> +#define RK3562_GRF_SYS_SOC_CON0			0X0400
> +#define RK3562_GRF_SYS_SOC_CON1			0X0404
> +
> +#define RK3562_GMAC0_CLK_RMII_MODE		GRF_BIT(5)
> +#define RK3562_GMAC0_CLK_RGMII_MODE		GRF_CLR_BIT(5)
> +
> +#define RK3562_GMAC0_CLK_RMII_GATE		GRF_BIT(6)
> +#define RK3562_GMAC0_CLK_RMII_NOGATE		GRF_CLR_BIT(6)
> +
> +#define RK3562_GMAC0_CLK_RMII_DIV2		GRF_BIT(7)
> +#define RK3562_GMAC0_CLK_RMII_DIV20		GRF_CLR_BIT(7)
> +
> +#define RK3562_GMAC0_CLK_RGMII_DIV1		\
> +				(GRF_CLR_BIT(7) | GRF_CLR_BIT(8))
> +#define RK3562_GMAC0_CLK_RGMII_DIV5		\
> +				(GRF_BIT(7) | GRF_BIT(8))
> +#define RK3562_GMAC0_CLK_RGMII_DIV50		\
> +				(GRF_CLR_BIT(7) | GRF_BIT(8))
> +
> +#define RK3562_GMAC0_CLK_RMII_DIV2		GRF_BIT(7)
> +#define RK3562_GMAC0_CLK_RMII_DIV20		GRF_CLR_BIT(7)
> +
> +#define RK3562_GMAC0_CLK_SELET_CRU		GRF_CLR_BIT(9)
> +#define RK3562_GMAC0_CLK_SELET_IO		GRF_BIT(9)

This is probably a typo, SELET, should probably be SELECT?

> +
> +#define RK3562_GMAC1_CLK_RMII_GATE		GRF_BIT(12)
> +#define RK3562_GMAC1_CLK_RMII_NOGATE		GRF_CLR_BIT(12)
> +
> +#define RK3562_GMAC1_CLK_RMII_DIV2		GRF_BIT(13)
> +#define RK3562_GMAC1_CLK_RMII_DIV20		GRF_CLR_BIT(13)
> +
> +#define RK3562_GMAC1_RMII_SPEED100		GRF_BIT(11)
> +#define RK3562_GMAC1_RMII_SPEED10		GRF_CLR_BIT(11)
> +
> +#define RK3562_GMAC1_CLK_SELET_CRU		GRF_CLR_BIT(15)
> +#define RK3562_GMAC1_CLK_SELET_IO		GRF_BIT(15)

Same here.

> +
> +/* ioc_grf */
> +#define RK3562_GRF_IOC_GMAC_IOFUNC0_CON0	0X10400
> +#define RK3562_GRF_IOC_GMAC_IOFUNC0_CON1	0X10404
> +#define RK3562_GRF_IOC_GMAC_IOFUNC1_CON0	0X00400
> +#define RK3562_GRF_IOC_GMAC_IOFUNC1_CON1	0X00404
> +
> +#define RK3562_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(1)
> +#define RK3562_GMAC_RXCLK_DLY_DISABLE		GRF_CLR_BIT(1)
> +#define RK3562_GMAC_TXCLK_DLY_ENABLE		GRF_BIT(0)
> +#define RK3562_GMAC_TXCLK_DLY_DISABLE		GRF_CLR_BIT(0)
> +
> +#define RK3562_GMAC_CLK_RX_DL_CFG(val)		HIWORD_UPDATE(val, 0xFF, 8)
> +#define RK3562_GMAC_CLK_TX_DL_CFG(val)		HIWORD_UPDATE(val, 0xFF, 0)
> +
> +#define RK3562_GMAC0_IO_EXTCLK_SELET_CRU	GRF_CLR_BIT(2)
> +#define RK3562_GMAC0_IO_EXTCLK_SELET_IO		GRF_BIT(2)

Same here.

> +
> +#define RK3562_GMAC1_IO_EXTCLK_SELET_CRU	GRF_CLR_BIT(3)
> +#define RK3562_GMAC1_IO_EXTCLK_SELET_IO		GRF_BIT(3)

And here.

> +
> +static void rk3562_set_to_rgmii(struct rk_priv_data *bsp_priv,
> +				int tx_delay, int rx_delay)
> +{
> +	regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0,
> +		     RK3562_GMAC0_CLK_RGMII_MODE);
> +
> +	regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC0_CON1,
> +		     DELAY_ENABLE(RK3562, tx_delay, rx_delay));
> +	regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC0_CON0,
> +		     RK3562_GMAC_CLK_RX_DL_CFG(rx_delay) |
> +		     RK3562_GMAC_CLK_TX_DL_CFG(tx_delay));
> +
> +	regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC1_CON1,
> +		     DELAY_ENABLE(RK3562, tx_delay, rx_delay));
> +	regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC1_CON0,
> +		     RK3562_GMAC_CLK_RX_DL_CFG(rx_delay) |
> +		     RK3562_GMAC_CLK_TX_DL_CFG(tx_delay));
> +}
> +
> +static void rk3562_set_to_rmii(struct rk_priv_data *bsp_priv)
> +{
> +	if (!bsp_priv->id)
> +		regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0,
> +			     RK3562_GMAC0_CLK_RMII_MODE);
> +}
> +
> +static void rk3562_set_gmac_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +	unsigned int val = 0;
> +
> +	switch (speed) {
> +	case 10:
> +		val = RK3562_GMAC0_CLK_RGMII_DIV50;
> +		break;
> +	case 100:
> +		val = RK3562_GMAC0_CLK_RGMII_DIV5;
> +		break;
> +	case 1000:
> +		val = RK3562_GMAC0_CLK_RGMII_DIV1;
> +		break;
> +	default:
> +		goto err;
> +	}
> +
> +	regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0, val);
> +	return;
> +err:
> +	dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
> +}
> +
> +static void rk3562_set_gmac_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +	unsigned int val = 0, offset;
> +
> +	switch (speed) {
> +	case 10:
> +		if (bsp_priv->id == 1) {
> +			val = RK3562_GMAC1_CLK_RMII_DIV20;
> +			regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0,
> +				     RK3562_GMAC1_RMII_SPEED10);
> +		} else {
> +			val = RK3562_GMAC0_CLK_RMII_DIV20;
> +		}
> +		break;
> +	case 100:
> +		if (bsp_priv->id == 1) {
> +			val = RK3562_GMAC1_CLK_RMII_DIV2;
> +			regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0,
> +				     RK3562_GMAC1_RMII_SPEED100);
> +		} else {
> +			val = RK3562_GMAC0_CLK_RMII_DIV2;
> +		}
> +		break;
> +	default:
> +		goto err;
> +	}
> +
> +	offset = (bsp_priv->id == 1) ? RK3562_GRF_SYS_SOC_CON1 :
> +				       RK3562_GRF_SYS_SOC_CON0;
> +	regmap_write(bsp_priv->grf, offset, val);
> +	return;
> +err:
> +	dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
> +}
> +
> +static void rk3562_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
> +				       bool enable)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +	unsigned int value;
> +
> +	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
> +		dev_err(dev, "Missing rockchip,grf or rockchip,php_grf property\n");
> +		return;
> +	}

This should not be needed after the commit 247e84f66a3d ("net: stmmac:
dwmac-rk: Validate GRF and peripheral GRF during probe") and the use of
php_grf_required=true below.

> +
> +	if (!bsp_priv->id) {
> +		value = input ? RK3562_GMAC0_CLK_SELET_IO :
> +				RK3562_GMAC0_CLK_SELET_CRU;
> +		value |= enable ? RK3562_GMAC0_CLK_RMII_NOGATE :
> +				  RK3562_GMAC0_CLK_RMII_GATE;
> +		regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON0, value);
> +
> +		value = input ? RK3562_GMAC0_IO_EXTCLK_SELET_IO :
> +				RK3562_GMAC0_IO_EXTCLK_SELET_CRU;
> +		regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC0_CON1, value);
> +		regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC1_CON1, value);
> +	} else {
> +		value = input ? RK3562_GMAC1_CLK_SELET_IO :
> +				RK3562_GMAC1_CLK_SELET_CRU;
> +		value |= enable ? RK3562_GMAC1_CLK_RMII_NOGATE :
> +				 RK3562_GMAC1_CLK_RMII_GATE;
> +		regmap_write(bsp_priv->grf, RK3562_GRF_SYS_SOC_CON1, value);
> +
> +		value = input ? RK3562_GMAC1_IO_EXTCLK_SELET_IO :
> +				RK3562_GMAC1_IO_EXTCLK_SELET_CRU;
> +		regmap_write(bsp_priv->php_grf, RK3562_GRF_IOC_GMAC_IOFUNC1_CON1, value);
> +	}
> +}
> +
> +static const struct rk_gmac_ops rk3562_ops = {
> +	.set_to_rgmii = rk3562_set_to_rgmii,
> +	.set_to_rmii = rk3562_set_to_rmii,
> +	.set_rgmii_speed = rk3562_set_gmac_rgmii_speed,
> +	.set_rmii_speed = rk3562_set_gmac_rmii_speed,
> +	.set_clock_selection = rk3562_set_clock_selection,

This is missing the recently added:

	.php_grf_required = true,

Regards,
Jonas

> +};
> +
>  #define RK3568_GRF_GMAC0_CON0		0x0380
>  #define RK3568_GRF_GMAC0_CON1		0x0384
>  #define RK3568_GRF_GMAC1_CON0		0x0388
> @@ -1996,6 +2185,7 @@ static const struct of_device_id rk_gmac_dwmac_match[] = {
>  	{ .compatible = "rockchip,rk3368-gmac", .data = &rk3368_ops },
>  	{ .compatible = "rockchip,rk3399-gmac", .data = &rk3399_ops },
>  	{ .compatible = "rockchip,rk3528-gmac", .data = &rk3528_ops },
> +	{ .compatible = "rockchip,rk3562-gmac", .data = &rk3562_ops },
>  	{ .compatible = "rockchip,rk3568-gmac", .data = &rk3568_ops },
>  	{ .compatible = "rockchip,rk3576-gmac", .data = &rk3576_ops },
>  	{ .compatible = "rockchip,rk3588-gmac", .data = &rk3588_ops },


