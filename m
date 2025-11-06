Return-Path: <netdev+bounces-236251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B15C3A3F9
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489B5424AE4
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518BF26B08F;
	Thu,  6 Nov 2025 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jq/9kXCP"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9B52475D0
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424412; cv=none; b=VdIOFyAk6eIqUTInN25X3OiFJQ3zfhQ9+zMoB166pp2s7Dk2y/4phYoa8v5WX1BiTvl+dj9/DXAHUbQQx7c7fFe2F6ErlRlz1Y76E8SlIcKaWtuBsheqQHsuu8VvfMRe292MVpDTGZrFjj9U5dfx1wqgRS+jqIHcoAgH5BPO1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424412; c=relaxed/simple;
	bh=0rHrSD+l5C0EvX1vmP8pxxAC24rNV1eAzZt5bwshbD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpTjQJw5Cjvuo7pHmv+dkozFmK/KSOc93uZjbBuy4GWvuDMRfX3wF4qwKzQoTiMmTLdU8QYmFBAp1o2O9pJeGhNHtyDY2JAL2nF0Gxi3DVQIq1Fjtnk2zo7yRP8Eb/G/qztwzpFbJLA2eAJeH4rqeRQZCWwtnOe+OKyQS1m4cXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jq/9kXCP; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DB52AC0FA83;
	Thu,  6 Nov 2025 10:19:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D80676068C;
	Thu,  6 Nov 2025 10:20:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DDB3A11850A23;
	Thu,  6 Nov 2025 11:20:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762424406; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=MrtELhIyCno0rfrMQS1AC+bze17pExz4ltwZ19FC44U=;
	b=Jq/9kXCPQZi2LzDTzoftGVWN7+cckHIqtyzVMRR+OGRvHKd9ng3fc1Ww4RwZWNYgL3/iEO
	1SHMwYqYyR+eFMuTAVJ/diFehwENPQCVuDAXOXGmKRj6WD2pcjv0TqnEEd+6feojc2cHyI
	Wc9UiBrCIEjvzBi5zwdB6O373RN7mTK77/y223e7olYEQjrciaf8zqWz94AFvakX6tQKXn
	kRPLRgHoO0wcsraSP9zWQjOOL+KIc8xUXUcjqtPN5JTLzZXfpaVCvEdNSXOnIKHy1Ss/UQ
	C4PLgJrZgIbXH12G321STQlM8+0iVrlFs+oCo6jXVHvxcJBFo+p+4c9BSzIvgQ==
Message-ID: <168cefb5-4a44-4836-8e55-c9c76e99f2aa@bootlin.com>
Date: Thu, 6 Nov 2025 11:20:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 09/11] net: stmmac: ingenic: simplify x2000
 mac_set_mode()
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
 <E1vGvoe-0000000DWp8-37LQ@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vGvoe-0000000DWp8-37LQ@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 06/11/2025 09:58, Russell King (Oracle) wrote:
> As per the previous commit, we have validated that the phy_intf_sel
> value is one that is permissible for this SoC, so there is no need to
> handle invalid PHY interface modes. We can also apply the other
> configuration based upon the phy_intf_sel value rather than the
> PHY interface mode.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 28 +++++--------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> index 7b2576fbb1e1..eb5744e0b9ea 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
> @@ -122,39 +122,25 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
>  	struct ingenic_mac *mac = plat_dat->bsp_priv;
>  	unsigned int val;
>  
> -	switch (plat_dat->phy_interface) {
> -	case PHY_INTERFACE_MODE_RMII:
> -		val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
> -			  FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
> -		break;
> -
> -	case PHY_INTERFACE_MODE_RGMII:
> -	case PHY_INTERFACE_MODE_RGMII_ID:
> -	case PHY_INTERFACE_MODE_RGMII_TXID:
> -	case PHY_INTERFACE_MODE_RGMII_RXID:
> -		val = 0;
> +	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
> +
> +	if (phy_intf_sel == PHY_INTF_SEL_RMII) {
> +		val |= FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
> +		       FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
> +	} else if (phy_intf_sel == PHY_INTF_SEL_RGMII) {
>  		if (mac->tx_delay == 0)
>  			val |= FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN);
>  		else
>  			val |= FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_DELAY) |
> -				   FIELD_PREP(MACPHYC_TX_DELAY_MASK, (mac->tx_delay + 9750) / 19500 - 1);
> +			       FIELD_PREP(MACPHYC_TX_DELAY_MASK, (mac->tx_delay + 9750) / 19500 - 1);
>  
>  		if (mac->rx_delay == 0)
>  			val |= FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
>  		else
>  			val |= FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_DELAY) |
>  				   FIELD_PREP(MACPHYC_RX_DELAY_MASK, (mac->rx_delay + 9750) / 19500 - 1);
> -
> -		break;
> -
> -	default:
> -		dev_err(mac->dev, "Unsupported interface %s\n",
> -			phy_modes(plat_dat->phy_interface));
> -		return -EINVAL;
>  	}
>  
> -	val |= FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
> -
>  	/* Update MAC PHY control register */
>  	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
>  }


