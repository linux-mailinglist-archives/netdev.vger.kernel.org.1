Return-Path: <netdev+bounces-236243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DDEC39FD5
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AA81A4225D
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD230C36E;
	Thu,  6 Nov 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LdOnRkoY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211832D8379
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423274; cv=none; b=hL3IOiGe/khY+PS+uCOhHyKLQFUHcDlQS0WJqbfh3KlUryTXA2CHVHHEPPypDQdqKCZOmDwTahmkwMofR5RhEXjPxeykaJUyjEpn97i55cNFBXf3nJlmjy9lkPidgF2DSco74DaRdpnKnL06lJ3hNBn4sIifgNIc9WDi1GQwKZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423274; c=relaxed/simple;
	bh=hhEu1Q6Gd7jGbORieZKXOxJOEjS2oFBwEmtOil1AoXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajXSBmDazQQ+LP9Famb6R6CPVAOPaJzQMTQikEmNwPFXh6t7/DlwMbxcQ4rTtxq7Q41otJivYX9adal/SWhbJwGdI4EEEa6mYVFlwVN+lBGQESZEkfoyhoE2TBnZpehf2QMlX6PjBgI3GVkE1h10QbxExps1xVR0bAfxbXlpZhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LdOnRkoY; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 71B8FC0FA83;
	Thu,  6 Nov 2025 10:00:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F1566068C;
	Thu,  6 Nov 2025 10:01:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D9CD11850850;
	Thu,  6 Nov 2025 11:01:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762423269; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/Ximp9a4IDmgxJZytTPrygSnU5qt872YCT1Ldh4VuFU=;
	b=LdOnRkoY6K/bIgJtnGiQsaOKa1XEKBZLXgKUeON5opBq0cd8VP2ymeNAKofkuBkkr16e6T
	1knMoKiyD6GlGUevfppUrC2szEGQqQ+IUJFnSZZ9oQ9ti+8bs9s2pVoHCFuPYSlYyDrru3
	qu45iJSk1pUj1Qg6OwUTECg8RrtVLSYSeX7rZNhAjV4o2l4FY9l8CrVXIWpCUblEKiAjni
	k1BagL5/0qW+kDq9iUewXaVhJYjlNhy2/il2ckSCZ47lPneZGTjhew/X1eAxZWIyc9S3MY
	vzM0ignHs6A3SFm5bvPkLs4DC/bunaj/wpNxnGj7mKpvKGzrsCCXSSFKiBpR2w==
Message-ID: <39e143f2-a0fc-4b3e-801b-23983d546461@bootlin.com>
Date: Thu, 6 Nov 2025 11:01:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/11] net: stmmac: ingenic: prep
 PHY_INTF_SEL_x field after switch()
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
 <E1vGvoK-0000000DWoh-15Ge@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vGvoK-0000000DWoh-15Ge@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 06/11/2025 09:57, Russell King (Oracle) wrote:
> Move the preparation of the PHY_INTF_SEL_x bitfield out of the switch()
> statement such that it only appears once.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 34 +++++++++++++------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> index b56d7ada1939..6680f7d3a469 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> @@ -71,20 +71,21 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  {
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
> +	u8 phy_intf_sel;
>  
>  	switch (plat_dat->phy_interface) {
>  	case PHY_INTERFACE_MODE_MII:
> -		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_GMII_MII);
> +		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_MII\n");
>  		break;
>  
>  	case PHY_INTERFACE_MODE_GMII:
> -		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_GMII_MII);
> +		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_GMII\n");
>  		break;
>  
>  	case PHY_INTERFACE_MODE_RMII:
> -		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_RMII);
> +		phy_intf_sel = PHY_INTF_SEL_RMII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  
> @@ -92,7 +93,7 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	case PHY_INTERFACE_MODE_RGMII_ID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
> -		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_RGMII);
> +		phy_intf_sel = PHY_INTF_SEL_RGMII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RGMII\n");
>  		break;
>  
> @@ -102,7 +103,8 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  		return -EINVAL;
>  	}
>  
> -	val |= FIELD_PREP(MACPHYC_TXCLK_SEL_MASK, MACPHYC_TXCLK_SEL_INPUT);
> +	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel) |
> +	      FIELD_PREP(MACPHYC_TXCLK_SEL_MASK, MACPHYC_TXCLK_SEL_INPUT);
>  
>  	/* Update MAC PHY control register */
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
> @@ -131,10 +133,11 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  {
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
> +	u8 phy_intf_sel;
>  
>  	switch (plat_dat->phy_interface) {
>  	case PHY_INTERFACE_MODE_RMII:
> -		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_RMII);
> +		phy_intf_sel = PHY_INTF_SEL_RMII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  
> @@ -144,6 +147,8 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  		return -EINVAL;
>  	}
>  
> +	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
> +
>  	/* Update MAC PHY control register */
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }
> @@ -152,11 +157,12 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  {
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
> +	u8 phy_intf_sel;
>  
>  	switch (plat_dat->phy_interface) {
>  	case PHY_INTERFACE_MODE_RMII:
> -		val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII) |
> -			  FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_RMII);
> +		val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII);
> +		phy_intf_sel = PHY_INTF_SEL_RMII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  
> @@ -166,6 +172,8 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  		return -EINVAL;
>  	}
>  
> +	val |= FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
> +
>  	/* Update MAC PHY control register */
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }
> @@ -174,12 +182,13 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  {
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
> +	u8 phy_intf_sel;
>  
>  	switch (plat_dat->phy_interface) {
>  	case PHY_INTERFACE_MODE_RMII:
>  		val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
> -			  FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN) |
> -			  FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_RMII);
> +			  FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
> +		phy_intf_sel = PHY_INTF_SEL_RMII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  
> @@ -187,7 +196,8 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	case PHY_INTERFACE_MODE_RGMII_ID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
> -		val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, PHY_INTF_SEL_RGMII);
> +		val = 0;
> +		phy_intf_sel = PHY_INTF_SEL_RGMII;
>  
>  		if (mac->tx_delay == 0)
>  			val |= FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN);
> @@ -210,6 +220,8 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  		return -EINVAL;
>  	}
>  
> +	val |= FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
> +
>  	/* Update MAC PHY control register */
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }


