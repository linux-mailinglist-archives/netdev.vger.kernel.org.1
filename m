Return-Path: <netdev+bounces-153446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635D59F8010
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AB61697F8
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE5226874;
	Thu, 19 Dec 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nHfD+JbW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A1224B0C
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626374; cv=none; b=tuehR5POYD0BVZh0uuhQf4pcYmVv32J0l45JLjhUHxQLzdOpdTG70CtNdmHICY64ORs3md4E/daiOS2YlXgfzc5XgztRPawBuCeEZqUoGi75w+YX718FTq9TRXp8R2r5YewovaN7slCtXlaC9rQNPvxH1Bt/mRzbDSHt9ZmLqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626374; c=relaxed/simple;
	bh=JLpNUvp39ZrWFOTsmFT6Fa3I9HKVria/UG28vuRjKxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kslcd+qX9C3wTN3UcZDhSaDMxep3JArdJzemOGoU+uXj1csEJxObFPq4SAqkTpaf6CVtIdrmPLpkJ57/tFQqABhMh+EiLeNQIo0aKXO5LmT+F/vs6chj3Xbldrgpd6sgb9Qv+V+bvcNekeHG3decu+pb/XPajepe1dFpRVYeIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nHfD+JbW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XdXOBnvYzvPsqMh8ala7XGqI2pOegNXjUn2e9JKJXas=; b=nHfD+JbWVL96uFNHwp9pdU0eMo
	9gZEEsVvHdUtYts51ZRpUhVAhUnzXka0LpQOKuVNO0+dAPUUrLcip+tg06U/w4SYpBEamiII9sBbP
	kJhYkzYXSi5TfwacVs+aTp6WXKbe+qIc5VytQzulisXIXRRCSjLkJPHrQFrkvC4VrbaQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOJYa-001gOT-SQ; Thu, 19 Dec 2024 17:39:24 +0100
Date: Thu, 19 Dec 2024 17:39:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hfdevel@gmx.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/7] net: phy: aquantia: add essential
 functions to aqr105 driver
Message-ID: <9a0491f6-9743-4588-a3a0-30110e2c7261@lunn.ch>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
 <20241217-tn9510-v3a-v3-4-4d5ef6f686e0@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-tn9510-v3a-v3-4-4d5ef6f686e0@gmx.net>

On Tue, Dec 17, 2024 at 10:07:35PM +0100, Hans-Frieder Vogt via B4 Relay wrote:
> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> This patch makes functions that were provided for aqr107 applicable to
> aqr105, or replaces generic functions with specific ones. Since the aqr105
> was introduced before NBASE-T was defined (or 802.3bz), there are a number
> of vendor specific registers involved in the definition of the
> advertisement, in auto-negotiation and in the setting of the speed. The
> functions have been written following the downstream driver for TN4010
> cards with AQR105 PHY. To avoid duplication of code, aqr_config_aneg was
> split in a common part and a specific part for aqr105 and other aqr PHYs.
> A similar approach has been chosen for the aqr107_read_status function.
> Here, the aqr generation (=1 for aqr105, and =2 for aqr107 and higher) is
> used to decide whether aqr107(and up) specific registers can be used. I
> know this is not particularly elegant, but it is doing the job.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> ---
>  drivers/net/phy/aquantia/aquantia_main.c | 168 ++++++++++++++++++++++++++-----
>  1 file changed, 144 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index 81eeee29ba3e6fb11a476a5b51a8a8be061ca8c3..a112e3473e079822671535c313f3ae816fe186dd 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -33,6 +33,9 @@
>  #define PHY_ID_AQR115C	0x31c31c33
>  #define PHY_ID_AQR813	0x31c31cb2
>  
> +#define MDIO_AN_10GBT_CTRL_ADV_LTIM		BIT(0)
> +#define ADVERTISE_XNP				BIT(12)
> +
>  #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
>  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK	GENMASK(7, 3)
>  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR	0
> @@ -50,6 +53,7 @@
>  #define MDIO_AN_VEND_PROV_1000BASET_HALF	BIT(14)
>  #define MDIO_AN_VEND_PROV_5000BASET_FULL	BIT(11)
>  #define MDIO_AN_VEND_PROV_2500BASET_FULL	BIT(10)
> +#define MDIO_AN_VEND_PROV_EXC_PHYID_INFO	BIT(6)
>  #define MDIO_AN_VEND_PROV_DOWNSHIFT_EN		BIT(4)
>  #define MDIO_AN_VEND_PROV_DOWNSHIFT_MASK	GENMASK(3, 0)
>  #define MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT	4
> @@ -107,6 +111,30 @@
>  #define AQR107_OP_IN_PROG_SLEEP		1000
>  #define AQR107_OP_IN_PROG_TIMEOUT	100000
>  
> +static int aqr105_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* Normal feature discovery */
> +	ret = genphy_c45_pma_read_abilities(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* The AQR105 PHY misses to indicate the 2.5G and 5G modes, so add them
> +	 * here
> +	 */
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			 phydev->supported);
> +
> +	/* The AQR105 PHY suppports both RJ45 and SFP+ interfaces */
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported);
> +
> +	return 0;
> +}
> +
>  static int aqr107_get_sset_count(struct phy_device *phydev)
>  {
>  	return AQR107_SGMII_STAT_SZ;
> @@ -164,6 +192,59 @@ static void aqr107_get_stats(struct phy_device *phydev,
>  	}
>  }
>  
> +static int aqr105_config_speed(struct phy_device *phydev)
> +{
> +	int vend = MDIO_AN_VEND_PROV_EXC_PHYID_INFO;
> +	int ctrl10 = MDIO_AN_10GBT_CTRL_ADV_LTIM;
> +	int adv = ADVERTISE_CSMA;
> +	int ret;
> +
> +	/* Half duplex is not supported */
> +	if (phydev->duplex != DUPLEX_FULL)
> +		return -EINVAL;

Do the half duplex modes make into the phydev->supported modes?  I
would expect the core to raise an error if asked to do half duplex but
it is not in phydev->supported.

> +static int aqr_common_read_rate(struct phy_device *phydev, int aqr_gen)
>  {
>  	u32 config_reg;
>  	int val;
> @@ -377,20 +482,22 @@ static int aqr107_read_rate(struct phy_device *phydev)
>  		return 0;
>  	}
>  
> -	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, config_reg);
> -	if (val < 0)
> -		return val;
> +	if (aqr_gen > 1) {
> +		val = phy_read_mmd(phydev, MDIO_MMD_VEND1, config_reg);
> +		if (val < 0)
> +			return val;
>  
> -	if (FIELD_GET(VEND1_GLOBAL_CFG_RATE_ADAPT, val) ==
> -	    VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE)
> -		phydev->rate_matching = RATE_MATCH_PAUSE;
> -	else
> -		phydev->rate_matching = RATE_MATCH_NONE;
> +		if (FIELD_GET(VEND1_GLOBAL_CFG_RATE_ADAPT, val) ==
> +		    VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE)
> +			phydev->rate_matching = RATE_MATCH_PAUSE;
> +		else
> +			phydev->rate_matching = RATE_MATCH_NONE;
> +	}

This appears to be at the end of read_rate(), which is also called at
the end of read_status. 

> +static int aqr105_read_status(struct phy_device *phydev)
> +{
> +	return aqr_common_read_status(phydev, 1);
> +}
> +
> +static int aqr107_read_status(struct phy_device *phydev)
> +{
> +	return aqr_common_read_status(phydev, 2);

So rather than having this 1, 2, i think you can put the code here.

	Andrew

