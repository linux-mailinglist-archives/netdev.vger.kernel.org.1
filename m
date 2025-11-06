Return-Path: <netdev+bounces-236244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD58C3A324
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091961A46996
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779E130F954;
	Thu,  6 Nov 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TMoJeyI6"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399D30C601
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423541; cv=none; b=ZfqJAvWigYj1qHDYyHZzCu/kve96qNqgsWnWPY6dDQqJhzT+sv/QKXm3ZLp0ize8MCOkgumPfk9SO//rBHdmUJvSoF+5cKZlo08keEIk8FfQN95KWMw0Gg9nCBbLOPlkZS3VUTC3xFegW4jKwC6UlySpBwKQ/MnLAD08gh7lojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423541; c=relaxed/simple;
	bh=WjpzpV/7zb0v0xLKFWaCzrIu1zApO2YOvSy0cNbAO4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivbRYy2CdSmO+TCOBsK2vy/YsSyqumgbnbx4hzEJexj0wgcinp7orkRBUqGrPRMCpp1admZo2ruUf+X4iYbW6uJgydxA9tC9+zFwNGWzmwaA/zZg82diOZPq3sBtL2CSYQlFy5BAQWoMXyE7/2cjleGDuhYoKLJhx7oUnf9XwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TMoJeyI6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1A2B11A18DB;
	Thu,  6 Nov 2025 10:05:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA04C6068C;
	Thu,  6 Nov 2025 10:05:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A255611850861;
	Thu,  6 Nov 2025 11:05:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762423532; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CRpXhhkIPMjFH3h5RapUBS8iw34S2D1EH/TxwZIqBzY=;
	b=TMoJeyI6P8u2/CTYIEpP8w3bd8Ycd61GlWyBIE/GYjMJh6phwkcq5jMZQjnZR0Gmeln14h
	vojfgQ/tuSRw+IC/vLIU5I6wHxKYC+Vi8ED7Cya9IGlRu7xBTFEJFjZSGvw1fJbBiqECgq
	lrGPs5jNwsnzs4x7YnP8GhY5GEDJN3g/blWQcVqFWMdqkVzQKM+0qqMvHph2MeL7qjwPoG
	qm82aYr7W9TWcfinFI8F2Lr+Qj+elFQNxp15TMSqtnN0HB7zTM8Eo3w8kYwsWJdt9ZrOtQ
	NfmF/Q0AEsEwR4PFZ74u0QLPQwYy5toAuqSlZ3TVE1VWloZl9ITCEdaLzUhCYg==
Message-ID: <e9a03b93-50e2-4d1c-a20a-ad243366ebd9@bootlin.com>
Date: Thu, 6 Nov 2025 11:05:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/11] net: stmmac: ingenic: use
 stmmac_get_phy_intf_sel()
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
 <E1vGvoP-0000000DWon-1cOI@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vGvoP-0000000DWon-1cOI@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 06/11/2025 09:57, Russell King (Oracle) wrote:
> Use stmmac_get_phy_intf_sel() to decode the PHY interface mode to the
> phy_intf_sel value, validate the result against the SoC specific
> supported phy_intf_sel values, and pass into the SoC specific
> set_mode() methods, replacing the local phy_intf_sel variable. This
> provides the value for the MACPHYC_PHY_INFT_MASK field.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

This looks correct to me :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 55 ++++++++++++-------
>  1 file changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> index 6680f7d3a469..79735a476e86 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> @@ -64,28 +64,27 @@ struct ingenic_soc_info {
>  	enum ingenic_mac_version version;
>  	u32 mask;
>  
> -	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
> +	int (*set_mode)(struct plat_stmmacenet_data *plat_dat, u8 phy_intf_sel);
> +
> +	u8 valid_phy_intf_sel;
>  };
>  
> -static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
> +static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
> +			       u8 phy_intf_sel)
>  {
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
> -	u8 phy_intf_sel;
>  
>  	switch (plat_dat->phy_interface) {
>  	case PHY_INTERFACE_MODE_MII:
> -		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_MII\n");
>  		break;
>  
>  	case PHY_INTERFACE_MODE_GMII:
> -		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_GMII\n");
>  		break;
>  
>  	case PHY_INTERFACE_MODE_RMII:
> -		phy_intf_sel = PHY_INTF_SEL_RMII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  
> @@ -93,7 +92,6 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	case PHY_INTERFACE_MODE_RGMII_ID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
> -		phy_intf_sel = PHY_INTF_SEL_RGMII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RGMII\n");
>  		break;
>  
> @@ -110,7 +108,8 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }
>  
> -static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
> +static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
> +			      u8 phy_intf_sel)
>  {
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  
> @@ -129,15 +128,14 @@ static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, 0);
>  }
>  
> -static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
> +static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
> +			      u8 phy_intf_sel)
>  {
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
> -	u8 phy_intf_sel;
>  
>  	switch (plat_dat->phy_interface) {
>  	case PHY_INTERFACE_MODE_RMII:
> -		phy_intf_sel = PHY_INTF_SEL_RMII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  
> @@ -153,16 +151,15 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }
>  
> -static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
> +static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
> +			      u8 phy_intf_sel)
>  {
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
> -	u8 phy_intf_sel;
>  
>  	switch (plat_dat->phy_interface) {
>  	case PHY_INTERFACE_MODE_RMII:
>  		val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII);
> -		phy_intf_sel = PHY_INTF_SEL_RMII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  
> @@ -178,17 +175,16 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }
>  
> -static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
> +static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
> +			      u8 phy_intf_sel)
>  {
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
> -	u8 phy_intf_sel;
>  
>  	switch (plat_dat->phy_interface) {
>  	case PHY_INTERFACE_MODE_RMII:
>  		val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
>  			  FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
> -		phy_intf_sel = PHY_INTF_SEL_RMII;
>  		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  
> @@ -197,8 +193,6 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
>  		val = 0;
> -		phy_intf_sel = PHY_INTF_SEL_RGMII;
> -
>  		if (mac->tx_delay == 0)
>  			val |= FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN);
>  		else
> @@ -229,10 +223,21 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
>  {
>  	struct ingenic_mac *mac = bsp_priv;
> -	int ret;
> +	phy_interface_t interface;
> +	int phy_intf_sel, ret;
>  
>  	if (mac->soc_info->set_mode) {
> -		ret = mac->soc_info->set_mode(mac->plat_dat);
> +		interface = mac->plat_dat->phy_interface;
> +
> +		phy_intf_sel = stmmac_get_phy_intf_sel(interface);
> +		if (phy_intf_sel < 0 || phy_intf_sel >= BITS_PER_BYTE ||
> +		    ~mac->soc_info->valid_phy_intf_sel & BIT(phy_intf_sel)) {
> +			dev_err(mac->dev, "unsupported interface %s\n",
> +				phy_modes(interface));
> +			return phy_intf_sel < 0 ? phy_intf_sel : -EINVAL;
> +		}
> +
> +		ret = mac->soc_info->set_mode(mac->plat_dat, phy_intf_sel);
>  		if (ret)
>  			return ret;
>  	}
> @@ -309,6 +314,9 @@ static struct ingenic_soc_info jz4775_soc_info = {
>  	.mask = MACPHYC_TXCLK_SEL_MASK | MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
>  
>  	.set_mode = jz4775_mac_set_mode,
> +	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_GMII_MII) |
> +			      BIT(PHY_INTF_SEL_RGMII) |
> +			      BIT(PHY_INTF_SEL_RMII),
>  };
>  
>  static struct ingenic_soc_info x1000_soc_info = {
> @@ -316,6 +324,7 @@ static struct ingenic_soc_info x1000_soc_info = {
>  	.mask = MACPHYC_SOFT_RST_MASK,
>  
>  	.set_mode = x1000_mac_set_mode,
> +	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_RMII),
>  };
>  
>  static struct ingenic_soc_info x1600_soc_info = {
> @@ -323,6 +332,7 @@ static struct ingenic_soc_info x1600_soc_info = {
>  	.mask = MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
>  
>  	.set_mode = x1600_mac_set_mode,
> +	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_RMII),
>  };
>  
>  static struct ingenic_soc_info x1830_soc_info = {
> @@ -330,6 +340,7 @@ static struct ingenic_soc_info x1830_soc_info = {
>  	.mask = MACPHYC_MODE_SEL_MASK | MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
>  
>  	.set_mode = x1830_mac_set_mode,
> +	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_RMII),
>  };
>  
>  static struct ingenic_soc_info x2000_soc_info = {
> @@ -338,6 +349,8 @@ static struct ingenic_soc_info x2000_soc_info = {
>  			MACPHYC_RX_DELAY_MASK | MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
>  
>  	.set_mode = x2000_mac_set_mode,
> +	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_RGMII) |
> +			      BIT(PHY_INTF_SEL_RMII),
>  };
>  
>  static const struct of_device_id ingenic_mac_of_matches[] = {


