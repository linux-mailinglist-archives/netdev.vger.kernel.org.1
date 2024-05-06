Return-Path: <netdev+bounces-93858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471708BD67E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 22:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C286281BAC
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 20:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707015B574;
	Mon,  6 May 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VbAbkC7j"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-208.smtpout.orange.fr [193.252.23.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D9656B76;
	Mon,  6 May 2024 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028547; cv=none; b=VwxxlO7wAN9tyYmn4RY6eq3WG/rdNGFNfviCInqhexhyWtpAHW3ZYsz0BJzOn+pUnPvG2eBHclu584rEr4stAp8LRJvyDEtNBO+dAKYzpYzV1Gi4xzu/U9hI+4hax1G9Ww3yqgW3qBXTnOWkvH98d+vmVbtGyN1RbBFeA+gJNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028547; c=relaxed/simple;
	bh=AzcBAaZO3ROn+bWQ95qFg7Azdq32by4KnJ3p6zsfpqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRyIS7Q2XebxI93bf2pIkILF6z4T+2px53Z+qm33vpFAvdjWZVcK+8TWrmDme1GAw7v8+tp0xzeUSz6VD1mvxgiOb0I5XqlSxQED2F5BJAzP6x3G/u1mJWudHtYGPH/o+GhggeARTheuB4D5zJyKFSXmn5zx9w2jf9ucaQlNf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VbAbkC7j; arc=none smtp.client-ip=193.252.23.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 44j7sdneSxwPD44j7shlDL; Mon, 06 May 2024 22:14:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715026464;
	bh=hbiv2nWG7B/SdO90N/VuiBE7SFRkK+pLReH7u0DOFuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=VbAbkC7jTVCU+/sUUPJtfTcz4kTgLbqPHFBne1DUnjpsWZTfj9ytgbU1pKWJ0hYVN
	 IkRJEuoV0Cnkxit3EAGY4332wmEiNRoGTuoc2MBf+APBymbIX6u9OQ2LFcOgYLLCNN
	 7fVDKbfNflnAQe+cVXQrciJC1C0pIZljQjigC0kbqfUhhHQpl8k4oz2qOL+Ek02Hgw
	 zUPyjC842zhYNFalDOmp9kIm4KBebJlRDARq4C9VNOsKI38tBZQZlhkWFeHTSJzMKY
	 M1YzIpg7aDmuB9awx0i6echjbYa96F0eDLi53SGfVlz+xMhnww+RDFI8xrNaxFSYDx
	 f+aWpmima+FcQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 06 May 2024 22:14:24 +0200
X-ME-IP: 86.243.17.157
Message-ID: <c435e879-33c2-4cee-a2b1-56e82a0e9281@wanadoo.fr>
Date: Mon, 6 May 2024 22:14:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach link
 modes
To: =?UTF-8?Q?Kamil_Hor=C3=A1k_-_2N?= <kamilh@axis.com>,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-4-kamilh@axis.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240506144015.2409715-4-kamilh@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/05/2024 à 16:40, Kamil Horák - 2N a écrit :
> Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
> Create set of functions alternative to IEEE 802.3 to handle configuration
> of these modes on compatible Broadcom PHYs.
> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
> ---
>   drivers/net/phy/bcm-phy-lib.c | 122 ++++++++++++
>   drivers/net/phy/bcm-phy-lib.h |   4 +
>   drivers/net/phy/broadcom.c    | 338 ++++++++++++++++++++++++++++++++--
>   3 files changed, 449 insertions(+), 15 deletions(-)

Hi,

a few nitpicks below, should it help.

...

> +int bcm_config_aneg(struct phy_device *phydev, bool changed)
> +{
> +	int err;
> +
> +	if (genphy_config_eee_advert(phydev))
> +		changed = true;
> +
> +	err = bcm_setup_master_slave(phydev);
> +	if (err < 0)
> +		return err;
> +	else if (err)
> +		changed = true;
> +
> +	if (phydev->autoneg != AUTONEG_ENABLE)
> +		return bcm_setup_forced(phydev);
> +
> +	err = bcm_config_advert(phydev);
> +	if (err < 0) /* error */

Nitpick: the comment could be removed, IMHO (otherwise maybe it should 
be added a few lines above too)

> +		return err;
> +	else if (err)
> +		changed = true;
> +
> +	return genphy_check_and_restart_aneg(phydev, changed);
> +}
> +EXPORT_SYMBOL_GPL(bcm_config_aneg);
> +
> +/**
> + * bcm_config_advert - sanitize and advertise auto-negotiation parameters
> + * @phydev: target phy_device struct
> + *
> + * Description: Writes MII_BCM54XX_LREANAA with the appropriate values,
> + *   after sanitizing the values to make sure we only advertise
> + *   what is supported.  Returns < 0 on error, 0 if the PHY's advertisement
> + *   hasn't changed, and > 0 if it has changed.
> + */
> +int bcm_config_advert(struct phy_device *phydev)
> +{
> +	int err;
> +	u32 adv;
> +
> +	/* Only allow advertising what this PHY supports */
> +	linkmode_and(phydev->advertising, phydev->advertising,
> +		     phydev->supported);
> +
> +	adv = bcm_linkmode_adv_to_mii_adv_t(phydev->advertising);
> +
> +	/* Setup BroadR-Reach mode advertisement */
> +	err = phy_modify_changed(phydev, MII_BCM54XX_LREANAA,
> +				 LRE_ADVERTISE_ALL | LREANAA_PAUSE |
> +				 LREANAA_PAUSE_ASYM, adv);
> +
> +	if (err < 0)
> +		return err;
> +
> +	return err > 0 ? 1 : 0;

Nitpick: Could be: return err;
(at this point it can be only 0 or 1 anyway)

> +}
> +EXPORT_SYMBOL_GPL(bcm_config_advert);

...

> @@ -576,18 +604,16 @@ static int bcm54811_config_init(struct phy_device *phydev)
>   			return err;
>   	}
>   
> -	return err;
> +	/* Configure BroadR-Reach function. */
> +	return  bcm5481x_set_brrmode(phydev, ETHTOOL_PHY_BRR_MODE_OFF);

Nitpick: 2 spaces before "bcm5481x_set_brrmode"

>   }
>   
> -static int bcm5481_config_aneg(struct phy_device *phydev)
> +static int bcm5481x_config_delay_swap(struct phy_device *phydev)
>   {
>   	struct device_node *np = phydev->mdio.dev.of_node;
> -	int ret;
> -
> -	/* Aneg firstly. */
> -	ret = genphy_config_aneg(phydev);
> +	int ret = 0;

I think that ret can be left un-initialized and use return 0; at the end 
of the function.

>   
> -	/* Then we can set up the delay. */
> +	/* Set up the delay. */
>   	bcm54xx_config_clock_delay(phydev);
>   
>   	if (of_property_read_bool(np, "enet-phy-lane-swap")) {
> @@ -601,6 +627,56 @@ static int bcm5481_config_aneg(struct phy_device *phydev)
>   	return ret;
>   }

...

> +static int bcm54811_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +	u8 brr_mode;
> +
> +	/* Aneg firstly. */
> +	ret = bcm5481x_get_brrmode(phydev, &brr_mode);
> +	if (ret)
> +		return ret;
> +
> +	if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON) {
> +		/* BCM54811 is only capable of autonegotiation in IEEE mode */
> +		if (phydev->autoneg)
> +			return -EOPNOTSUPP;
> +
> +		ret = bcm_config_aneg(phydev, false);
> +

Nitpick: unneeded new line

> +	} else {
> +		ret = genphy_config_aneg(phydev);
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Then we can set up the delay and swap. */
> +	return bcm5481x_config_delay_swap(phydev);
> +}
> +
>   struct bcm54616s_phy_priv {
>   	bool mode_1000bx_en;
>   };
> @@ -1062,6 +1138,234 @@ static void bcm54xx_link_change_notify(struct phy_device *phydev)
>   	bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_EXP08, ret);
>   }
>   
> +static int bcm54811_read_abilities(struct phy_device *phydev)
> +{
> +	int val, err;
> +	int i;
> +	static const int modes_array[] = {ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
> +					  ETHTOOL_LINK_MODE_1BR10_BIT,
> +					  ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +					  ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> +					  ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
> +					  ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +					  ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> +					  ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +					  ETHTOOL_LINK_MODE_10baseT_Half_BIT};
> +

Nitpick: unneeded new line. Or maybe brr_mode could be defined above 
this struct?

Should there be an extra space after { and before }?
(see br_bits below)

> +	u8 brr_mode;
> +
> +	for (i = 0; i < ARRAY_SIZE(modes_array); i++)
> +		linkmode_clear_bit(modes_array[i], phydev->supported);
> +
> +	err = bcm5481x_get_brrmode(phydev, &brr_mode);
> +

Nitpick: unneeded new line

> +	if (err)
> +		return err;
> +
> +	if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON) {
> +		linkmode_set_bit_array(phy_basic_ports_array,
> +				       ARRAY_SIZE(phy_basic_ports_array),
> +				       phydev->supported);
> +
> +		val = phy_read(phydev, MII_BCM54XX_LRESR);
> +		if (val < 0)
> +			return val;
> +
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> +				 phydev->supported, 1);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
> +				 phydev->supported,
> +				 val & LRESR_100_1PAIR);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_1BR10_BIT,
> +				 phydev->supported,
> +				 val & LRESR_10_1PAIR);
> +	} else {
> +		return genphy_read_abilities(phydev);
> +	}
> +
> +	return err;

Nitpick: return 0; ?

> +}

...

> +/* Read LDS Link Partner Ability in BroadR-Reach mode */
> +static int bcm_read_lpa(struct phy_device *phydev)
> +{
> +	int i, lrelpa;
> +
> +	if (phydev->autoneg != AUTONEG_ENABLE) {
> +		if (!phydev->autoneg_complete) {
> +			/* aneg not yet done, reset all relevant bits */
> +			static int br_bits[] = { ETHTOOL_LINK_MODE_Autoneg_BIT,

Nitpick: add const? (but maybe the line would get too long)

> +						 ETHTOOL_LINK_MODE_Pause_BIT,
> +						 ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> +						 ETHTOOL_LINK_MODE_1BR10_BIT,
> +						 ETHTOOL_LINK_MODE_100baseT1_Full_BIT };
> +			for (i = 0; i < ARRAY_SIZE(br_bits); i++)
> +				linkmode_clear_bit(br_bits[i], phydev->lp_advertising);
> +
> +			return 0;
> +		}
> +
> +		/* Long-Distance-Signalling Link Partner Ability */

Typo? Signaling?

> +		lrelpa = phy_read(phydev, MII_BCM54XX_LRELPA);
> +		if (lrelpa < 0)
> +			return lrelpa;
> +
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> +				 phydev->lp_advertising, lrelpa & LRELPA_PAUSE_ASYM);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> +				 phydev->lp_advertising, lrelpa & LRELPA_PAUSE);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
> +				 phydev->lp_advertising, lrelpa & LRELPA_100_1PAIR);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_1BR10_BIT,
> +				 phydev->lp_advertising, lrelpa & LRELPA_10_1PAIR);
> +	} else {
> +		linkmode_zero(phydev->lp_advertising);
> +	}
> +
> +	return 0;
> +}

...

CJ


