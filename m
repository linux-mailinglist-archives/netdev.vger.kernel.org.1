Return-Path: <netdev+bounces-104707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F69F90E11C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 03:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE8C1F22571
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68318524F;
	Wed, 19 Jun 2024 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6juFcrZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F574C74;
	Wed, 19 Jun 2024 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718759125; cv=none; b=Yx5Pqf2Pj1DwYDGBa10iRNW2+d7CVHI+9rneRc7j9gMr6KTSolIcqeOit/vQJDOcOQhImJQkA1E1FkPAnFHazM4UcLII7P0gtmuywbOcG0yrRt584N1Xr8jf+fG9HvraKp3R9cbUY5a6wTNT/wgWFpZhZTK0Ob+juBSWZ+M736A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718759125; c=relaxed/simple;
	bh=oOwrSvqZA58QNXbz37EYUQNh/FRgOZd5JWpDRpBpFsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4+0dWXJfivi5jwsFkjmvXnMGKQcWF9URFpunu9zCX67cNjFoBIVN2RZh3y+gxGyYNopAyDErFGIVxwvaOzSIcTdEbyf7tzT/J858EX28sSaKn8LKsxUW5VUSpXyC60DrYqqK3CCfqAUteYzrKKuQrIordS1QALN1lCuPzlcJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6juFcrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0675CC3277B;
	Wed, 19 Jun 2024 01:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718759124;
	bh=oOwrSvqZA58QNXbz37EYUQNh/FRgOZd5JWpDRpBpFsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D6juFcrZeckxyYzrDwyOrjYbnhm5eMydGFWnZJaRm43kUEgrX/u+/3wGYt/VGhzcG
	 PLGl4jY0CzIQnfunOoWppYWZn4khA0IDyXgfZY4pWBqlSyTPszR5wHLVK2X1QfuIdZ
	 ekA+NwnPwXdD9ehGHh6qGjzlAtfuf3K6JYUOpSNc9BMSHCUX5LtToeq1ctvtv6kghN
	 /pDxGYpq9vQ6ZZzgEgB0qBydfFvROaW30wOhAu27jaKJm0+7jdxbPGWhrd8xw44qvS
	 SyT/VnUEEQmEVzIJUEuB2j8DdMy1gPDf8x5t71qMqZpNTVbPOg+07Rpv0pfoTBM7an
	 2yG7Cn8XRzp7A==
Date: Tue, 18 Jun 2024 18:05:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kamil =?UTF-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>
Cc: <florian.fainelli@broadcom.com>,
 <bcm-kernel-feedback-list@broadcom.com>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <20240618180523.47ce876f@kernel.org>
In-Reply-To: <20240617113841.3694934-5-kamilh@axis.com>
References: <20240617113841.3694934-1-kamilh@axis.com>
	<20240617113841.3694934-5-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Jun 2024 13:38:41 +0200 Kamil Hor=C3=A1k - 2N wrote:
> Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
> Create set of functions alternative to IEEE 802.3 to handle configuration
> of these modes on compatible Broadcom PHYs.

Some nit picks below, but please don't repost until next week.
Sorry for the delay but it's vacation season, I think some of
the key folks are currently AFK :(

> + * bcm_config_lre_advert - sanitize and advertise Long-Distance Signaling
> + *  auto-negotiation parameters
> + * @phydev: target phy_device struct
> + * @return: 0 if the PHY's advertisement hasn't changed, < 0 on error,
> + *          > 0 if it has changed

 * Return: 0 if the PHY

no @ and after the description

> + *
> + * Description: Writes MII_BCM54XX_LREANAA with the appropriate values,

Please don't prefix the description with the word "description"..

> + *   after sanitizing the values to make sure we only advertise
> + *   what is supported.
> + */
> +int bcm_config_lre_advert(struct phy_device *phydev)
> +{
> +	int err;
> +	u32 adv;
> +
> +	/* Only allow advertising what this PHY supports */
> +	linkmode_and(phydev->advertising, phydev->advertising,
> +		     phydev->supported);
> +
> +	adv =3D bcm_linkmode_adv_to_lre_adv_t(phydev->advertising);
> +
> +	/* Setup BroadR-Reach mode advertisement */
> +	err =3D phy_modify_changed(phydev, MII_BCM54XX_LREANAA,
> +				 LRE_ADVERTISE_ALL | LREANAA_PAUSE |
> +				 LREANAA_PAUSE_ASYM, adv);
> +
> +	if (err < 0)
> +		return err;
> +
> +	return err;

You can return phy_modify_changed(... directly, no need for err

> +}
> +EXPORT_SYMBOL_GPL(bcm_config_lre_advert);
> +
>  MODULE_DESCRIPTION("Broadcom PHY Library");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Broadcom Corporation");
> diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
> index b52189e45a84..fecdd66ad736 100644
> --- a/drivers/net/phy/bcm-phy-lib.h
> +++ b/drivers/net/phy/bcm-phy-lib.h
> @@ -121,4 +121,8 @@ irqreturn_t bcm_phy_wol_isr(int irq, void *dev_id);
>  int bcm_phy_led_brightness_set(struct phy_device *phydev,
>  			       u8 index, enum led_brightness value);
> =20
> +int bcm_setup_master_slave(struct phy_device *phydev);
> +int bcm_config_lre_aneg(struct phy_device *phydev, bool changed);
> +int bcm_config_lre_advert(struct phy_device *phydev);
> +
>  #endif /* _LINUX_BCM_PHY_LIB_H */
> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
> index 370e4ed45098..5e590c8f82c4 100644
> --- a/drivers/net/phy/broadcom.c
> +++ b/drivers/net/phy/broadcom.c
> @@ -5,6 +5,9 @@
>   *	Broadcom BCM5411, BCM5421 and BCM5461 Gigabit Ethernet
>   *	transceivers.
>   *
> + *	Broadcom BCM54810, BCM54811 BroadR-Reach transceivers.
> + *
> + *

double new line

>   *	Copyright (c) 2006  Maciej W. Rozycki
>   *
>   *	Inspired by code written by Amy Fong.
> @@ -553,18 +556,97 @@ static int bcm54810_write_mmd(struct phy_device *ph=
ydev, int devnum, u16 regnum,
>  	return -EOPNOTSUPP;
>  }
> =20
> -static int bcm54811_config_init(struct phy_device *phydev)
> +static int bcm5481x_get_brrmode(struct phy_device *phydev, u8 *data)
>  {
> -	int err, reg;
> +	int reg;
> =20
> -	/* Disable BroadR-Reach function. */
>  	reg =3D bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
> -	reg &=3D ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
> -	err =3D bcm_phy_write_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL,
> -				reg);
> -	if (err < 0)
> +
> +	*data =3D (reg & BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN) ? 1 : 0;
> +
> +	return 0;
> +}
> +
> +static int bcm54811_read_abilities(struct phy_device *phydev)
> +{
> +	static const int modes_array[] =3D { ETHTOOL_LINK_MODE_100baseT1_Full_B=
IT,
> +					   ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
> +					   ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +					   ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> +					   ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
> +					   ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +					   ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> +					   ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +					   ETHTOOL_LINK_MODE_10baseT_Half_BIT };

This is more normal formatting for the kernel:

	static const int modes_array[] =3D {
		ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
		ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,

please try to avoid going over 80 characters

> +static int bcm54811_config_init(struct phy_device *phydev)
> +{
> +	int err, reg;
> +	bool brr =3D false;
> +	struct device_node *np =3D phydev->mdio.dev.of_node;

order variable declaration lines longest to shortest,=20
AKA reverse xmas tree

