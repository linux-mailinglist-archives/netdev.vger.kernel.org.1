Return-Path: <netdev+bounces-68953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9E7848F17
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 17:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50ED11F20EE6
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11433225DA;
	Sun,  4 Feb 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c+SuTy5p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C922611
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062470; cv=none; b=rQhJnrRSrp0KUozOdFda4FkYmCNjyytbETzPpvTsgr89nRiPHdonZVYq7lvUNBJMY6rN2uZn+LsLCGt3c2Wn0BPyiyr+NVWbgBgd8G2EuEIvQGtU6NgYouzBjFocLY6Rn7FvTd6LwlXp/IXsNRgPfcQcI+vjVJpCs5/6ianX8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062470; c=relaxed/simple;
	bh=WuvEB5xfaX8SBkIuY4XjmxEA0Z0cfhaNSttWKF3YT5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ+Txebbohxydls3mSXb5RZN1Dalfd/I2crnXqR4R4/dj7KLyXpWmJdIO0bX1AU3WDWIQf+a4PjgBTQlONagIsrBklz0+78zdj2BgNXD56p8xcE3OgNKbuPnLFvBP8N3RZnh0D+k2GNNzhnf9+cmTL8+ERonV3nsSoSLvZo7rO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c+SuTy5p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=gpIZ+rXziBXhMftRuFCfwSdeeJZllaAcT0ftXTFYyes=; b=c+
	SuTy5pnWMANpGnP/q/iyZQYuyPtkPK2YbJwFvbXqVzsxnCXxFYnII+k3pOyBq8WiG3Xhu9t9gfGH7
	HxhRalyoO8doSjUN9mc0vxhrG4vrm/1JNRCDDIeY/HXfMM47mn4tlRr3EFC6XY23YZtFXDY4eF1Zs
	MRTRODKkxmDseGU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWevT-006y2y-9N; Sun, 04 Feb 2024 17:00:59 +0100
Date: Sun, 4 Feb 2024 17:00:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: phy: realtek: use generic MDIO
 constants
Message-ID: <81779222-dab6-4e11-9fd2-6e447257c0d5@lunn.ch>
References: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
 <732a70d6-4191-4aae-8862-3716b062aa9e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <732a70d6-4191-4aae-8862-3716b062aa9e@gmail.com>

On Sun, Feb 04, 2024 at 03:17:53PM +0100, Heiner Kallweit wrote:
> From: Marek Behún <kabel@kernel.org>
> 
> Drop the ad-hoc MDIO constants used in the driver and use generic
> constants instead.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/realtek.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 894172a3e..ffc13c495 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -57,14 +57,6 @@
>  #define RTL8366RB_POWER_SAVE			0x15
>  #define RTL8366RB_POWER_SAVE_ON			BIT(12)
>  
> -#define RTL_SUPPORTS_5000FULL			BIT(14)
> -#define RTL_SUPPORTS_2500FULL			BIT(13)
> -#define RTL_SUPPORTS_10000FULL			BIT(0)
> -#define RTL_ADV_2500FULL			BIT(7)
> -#define RTL_LPADV_10000FULL			BIT(11)
> -#define RTL_LPADV_5000FULL			BIT(6)
> -#define RTL_LPADV_2500FULL			BIT(5)
> -
>  #define RTL9000A_GINMR				0x14
>  #define RTL9000A_GINMR_LINK_STATUS		BIT(4)
>  
> @@ -674,11 +666,11 @@ static int rtl822x_get_features(struct phy_device *phydev)
>  		return val;
>  
>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> -			 phydev->supported, val & RTL_SUPPORTS_2500FULL);
> +			 phydev->supported, val & MDIO_PMA_SPEED_2_5G);
>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> -			 phydev->supported, val & RTL_SUPPORTS_5000FULL);
> +			 phydev->supported, val & MDIO_PMA_SPEED_5G);
>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> -			 phydev->supported, val & RTL_SUPPORTS_10000FULL);
> +			 phydev->supported, val & MDIO_SPEED_10G);

Now that this only using generic constants, should it move into mdio.h
as a shared helper? Is this a standard register defined in 802.3, just
at a different address?

>  
>  	return genphy_read_abilities(phydev);
>  }
> @@ -692,10 +684,11 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
>  
>  		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>  				      phydev->advertising))
> -			adv2500 = RTL_ADV_2500FULL;
> +			adv2500 = MDIO_AN_10GBT_CTRL_ADV2_5G;
>  
>  		ret = phy_modify_paged_changed(phydev, 0xa5d, 0x12,
> -					       RTL_ADV_2500FULL, adv2500);
> +					       MDIO_AN_10GBT_CTRL_ADV2_5G,
> +					       adv2500);
>  		if (ret < 0)
>  			return ret;
>  	}
> @@ -714,11 +707,14 @@ static int rtl822x_read_status(struct phy_device *phydev)
>  			return lpadv;
>  
>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> -			phydev->lp_advertising, lpadv & RTL_LPADV_10000FULL);
> +				 phydev->lp_advertising,
> +				 lpadv & MDIO_AN_10GBT_STAT_LP10G);
>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> -			phydev->lp_advertising, lpadv & RTL_LPADV_5000FULL);
> +				 phydev->lp_advertising,
> +				 lpadv & MDIO_AN_10GBT_STAT_LP5G);
>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> -			phydev->lp_advertising, lpadv & RTL_LPADV_2500FULL);
> +				 phydev->lp_advertising,
> +				 lpadv & MDIO_AN_10GBT_STAT_LP2_5G);

Is this mii_10gbt_stat_mod_linkmode_lpa_t() ?

Something i've done in the past is to do this sort of conversion to
standard macros, and the followed up with a patch which says that
function X is now clearly the same as helper Y, so delete the function
and use the helper...

    Andrew

