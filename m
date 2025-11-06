Return-Path: <netdev+bounces-236241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849BCC3A11F
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00B53BAC71
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAAD30CD8B;
	Thu,  6 Nov 2025 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YrjL7w8U"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B82405FD
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423220; cv=none; b=YjwQRKsZgTea8Ue/5N5Bs+XcSVuSI/zurAjSRwmCUI+8g466FxeDti4g1FMcI94JmxT4MTIG2NHyyMFZW39Qx3y7xz1zedmCIEeLs1+1EI0MN4Yh1+GD8En8kNCLW2HKde9Xp/xlKshU980xU5TkhEEkU/Xy9Us5GYUiwqGkSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423220; c=relaxed/simple;
	bh=URiTdKbEiV7KVJChfWqiyvk0q+SWL7nMtfVNcAY/Ux4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDB3pF+oql5uOUl/Bz9pUv9BhHP5Ld2fESApuAVIQCVk+xKegMlcNMQwg1NgkrA57KHwFFo7hXJMhwjcofeXBEbf+cm7rzy82GsBkCKa0+p+8OQPm+bdjAZHrfzRQ2kubMsqAVBJ5A4xCJ1oG8CKuXo74CCx8FVhpiQ/7satjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YrjL7w8U; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 46266C0FA83;
	Thu,  6 Nov 2025 09:59:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 533D86068C;
	Thu,  6 Nov 2025 10:00:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B1401185084C;
	Thu,  6 Nov 2025 11:00:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762423214; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fUzCMD/zXAKLues4eh9rQeqDZK1DbWkuv062LLflVL4=;
	b=YrjL7w8UXqJlkgZO52td1MVfoQwZK4LlPP0faOmhLRUQX3s9/m/uzyn3uAsuAjclIfV7y/
	S7wc9M2ECXrcqbFz+rA8mVWACpPwUqIvX/T6gCdBq8K5Eefzi9FcK830yaAnBeXqfmbFYW
	w7E8KDCWOeFXxpwHQPlpRq4dQcwtDBGgyGDpGjkLSi8j/tdA6RIfZVJqv+wR+sNulwpUoY
	4zdCO93iz6SxON2jxGsafFOzrteRo0bgmvABtTFbPP3FjsYcnAQc9yuv+x+vD8JVFQXm9k
	OEPTXuISE4UDE6kD5G2wQNoTpct+0xh5SwBvSSt64U5Q11mRnitZnZWY2THQFg==
Message-ID: <01429961-6d7d-4c83-8712-f065e78a1be9@bootlin.com>
Date: Thu, 6 Nov 2025 11:00:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/11] net: stmmac: ingenic: use
 PHY_INTF_SEL_x directly
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
 <E1vGvoF-0000000DWob-0c8R@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vGvoF-0000000DWob-0c8R@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 06/11/2025 09:57, Russell King (Oracle) wrote:
> Use the PHY_INTF_SEL_x values directly in each of the mac_set_mode
> methods rather than the driver private MACPHYC_PHY_INFT_x definitions.
> Remove the MACPHYC_PHY_INFT_x definitions.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 20 ++++++++-----------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> index 5de2bd984d34..b56d7ada1939 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> @@ -35,10 +35,6 @@
>  #define MACPHYC_RX_DELAY_MASK		GENMASK(10, 4)
>  #define MACPHYC_SOFT_RST_MASK		GENMASK(3, 3)
>  #define MACPHYC_PHY_INFT_MASK		GENMASK(2, 0)
> -#define MACPHYC_PHY_INFT_RMII		PHY_INTF_SEL_RMII
> -#define MACPHYC_PHY_INFT_RGMII		PHY_INTF_SEL_RGMII
> -#define MACPHYC_PHY_INFT_GMII		PHY_INTF_SEL_GMII_MIIReviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> -#define MACPHYC_PHY_INFT_MII		PHY_INTF_SEL_GMII_MII
>  
>  #define MACPHYC_TX_DELAY_PS_MAX		2496
>  #define MACPHYC_TX_DELAY_PS_MIN		20
> @@ -78,17 +74,17 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  
>  	switch (plat_dat->phy_interface) {
>  	case PHY_INTERFACE_MODE_MII:
> -		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_MII);
> +		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_GMII_MII);
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_MII\n");
>  		break;
>  
>  	case PHY_INTERFACE_MODE_GMII:
> -		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_GMII);
> +		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_GMII_MII);
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_GMII\n");
>  		break;
>  
>  	case PHY_INTERFACE_MODE_RMII:
> -		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_RMII);
> +		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_RMII);
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  
> @@ -96,7 +92,7 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	case PHY_INTERFACE_MODE_RGMII_ID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
> -		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_RGMII);
> +		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_RGMII);
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RGMII\n");
>  		break;
>  
> @@ -138,7 +134,7 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  
>  	switch (plat_dat->phy_interface) {
>  	case PHY_INTERFACE_MODE_RMII:
> -		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_RMII);
> +		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_RMII);
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  
> @@ -160,7 +156,7 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	switch (plat_dat->phy_interface) {
>  	case PHY_INTERFACE_MODE_RMII:
>  		val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII) |
> -			  FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_RMII);
> +			  FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_RMII);
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  
> @@ -183,7 +179,7 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	case PHY_INTERFACE_MODE_RMII:
>  		val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
>  			  FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN) |
> -			  FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_RMII);
> +			  FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_RMII);
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  
> @@ -191,7 +187,7 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	case PHY_INTERFACE_MODE_RGMII_ID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
> -		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, MACPHYC_PHY_INFT_RGMII);
> +		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_RGMII);
>  
>  		if (mac->tx_delay == 0)
>  			val |= FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN);


