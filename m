Return-Path: <netdev+bounces-236248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A199CC3A3A2
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A45CD5068E5
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846292248B4;
	Thu,  6 Nov 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xu1/zo4o"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB91D63F3
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424128; cv=none; b=m2liqqA8MndPVtZhwQbs/wGGtDi4zw1HWTIaONT5JKgmkFM91mfM0uONzuITDL+/hIzbIb4Pzo0dSiuU7PA7d+sIQzS2+Df3HL7IhrkF/C8G4NDmlH36jh+NS01hcxk+sZg4k7mZx3apwNY7htogQMaS7mtbV63PL2nDKZM0dKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424128; c=relaxed/simple;
	bh=o05e4k0s64a8GSrHoa4eAUdVot7nDeyvj6polE6nPNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRa04zPn+6OkjLJVz3kcvSAsqJZZpCoFwchL6dRJUOeDQYbAa0iSNiCfZeEOpujGLL5W1czq/oFJSVglm3btLrVRAvZ0eGLBwn+K4UtxxQAb8657Bt0rmYDGm+eYUejss2NiXl2coiJjzBbYSzjUBNztU/E7PugLAe1To02FdOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xu1/zo4o; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 592F5C0FA83;
	Thu,  6 Nov 2025 10:15:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 66ADA6068C;
	Thu,  6 Nov 2025 10:15:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 886CC118507C0;
	Thu,  6 Nov 2025 11:15:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762424123; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=oJC1ecETHQcoqSbhmGBKBQYTfQjbYdXTsCWcOEh1NPE=;
	b=Xu1/zo4oGkrhtXu+acmaU6SUTcYCqSnjGZK9EaFB6t0xEz/aKHfIMZoqoPdXM+pNlNhwt9
	+3XETErcxRA2C+Zvl6n9438ZXEtrqoLn0+rBcQKrosZj0i3hO449klUQgiUtN2NeKh1T0t
	G+0HO3djusOizRmF02Hf70ZROMwBMGgKRiNdwvwPfe9mWA84ai1AEAP4dgkgAm8E0WswpI
	TqC88ulR4tMIA7JhyhQbFOzW8sN9Tzx4rOwPXpeK6xPw5HrXQQ/zrQJtOpW/lfRMFj0sP9
	xsIi5VPFsSB3T3hoRPZ6vfOExUADsf8MGmQL3e6IGL6kmb43Q4cuQ6XGs1kpWg==
Message-ID: <60bd1571-e293-4748-adde-396bf193bac2@bootlin.com>
Date: Thu, 6 Nov 2025 11:15:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 08/11] net: stmmac: ingenic: simplify
 mac_set_mode() methods
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
 <E1vGvoZ-0000000DWp2-2cxj@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vGvoZ-0000000DWp2-2cxj@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 06/11/2025 09:57, Russell King (Oracle) wrote:
> x1000, x1600 and x1830 only accept RMII mode. PHY_INTF_SEL_RMII is only
> selected with PHY_INTERFACE_MODE_RMII, and PHY_INTF_SEL_RMII has been
> validated by the SoC's .valid_phy_intf_sel bitmask. Thus, checking the
> interface mode in these functions becomes unnecessary. Remove these.
> 
> jz4775 is similar, except for a greater set of PHY_INTF_SEL_x valies.
> Also remove the switch statement here.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 50 +------------------
>  1 file changed, 2 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> index 539513890db1..7b2576fbb1e1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> @@ -75,22 +75,6 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
>  
> -	switch (plat_dat->phy_interface) {
> -	case PHY_INTERFACE_MODE_MII:
> -	case PHY_INTERFACE_MODE_GMII:
> -	case PHY_INTERFACE_MODE_RMII:
> -	case PHY_INTERFACE_MODE_RGMII:
> -	case PHY_INTERFACE_MODE_RGMII_ID:
> -	case PHY_INTERFACE_MODE_RGMII_TXID:
> -	case PHY_INTERFACE_MODE_RGMII_RXID:
> -		break;
> -
> -	default:
> -		dev_err(mac->dev, "Unsupported interface %s\n",
> -			phy_modes(plat_dat->phy_interface));
> -		return -EINVAL;
> -	}
> -
>  	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel) |
>  	      FIELD_PREP(MACPHYC_TXCLK_SEL_MASK, MACPHYC_TXCLK_SEL_INPUT);
>  
> @@ -103,16 +87,6 @@ static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
>  {
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  
> -	switch (plat_dat->phy_interface) {
> -	case PHY_INTERFACE_MODE_RMII:
> -		break;
> -
> -	default:
> -		dev_err(mac->dev, "Unsupported interface %s\n",
> -			phy_modes(plat_dat->phy_interface));
> -		return -EINVAL;
> -	}
> -
>  	/* Update MAC PHY control register */
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, 0);
>  }
> @@ -123,16 +97,6 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
>  
> -	switch (plat_dat->phy_interface) {
> -	case PHY_INTERFACE_MODE_RMII:
> -		break;
> -
> -	default:
> -		dev_err(mac->dev, "Unsupported interface %s\n",
> -			phy_modes(plat_dat->phy_interface));
> -		return -EINVAL;
> -	}
> -
>  	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
>  
>  	/* Update MAC PHY control register */
> @@ -145,18 +109,8 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
>  
> -	switch (plat_dat->phy_interface) {
> -	case PHY_INTERFACE_MODE_RMII:
> -		val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII);
> -		break;
> -
> -	default:
> -		dev_err(mac->dev, "Unsupported interface %s\n",
> -			phy_modes(plat_dat->phy_interface));
> -		return -EINVAL;
> -	}
> -
> -	val |= FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
> +	val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII) |
> +	      FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
>  
>  	/* Update MAC PHY control register */
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);


