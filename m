Return-Path: <netdev+bounces-110926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3592F92EF47
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 21:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEC4282AD9
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 19:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4343C16E895;
	Thu, 11 Jul 2024 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="38RwiT9X"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A1E1EEF8;
	Thu, 11 Jul 2024 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724527; cv=none; b=aTECLNGs9rXJSuw+fMDhM1PuzgxDhQ0+BDCcLhX1T/I9UBAxZ0OfMEq2j2T9RH3RdF52Y5FBZpcGmCvuOafsK2m2aLRBjXTngdetSLYlOSuMNTdmptAGQhtS+0aJNoaoJEnnE4PhBMVij1qRAUsUz/ErEigL7poxsxkuPAlzQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724527; c=relaxed/simple;
	bh=T5ur6kTMiFkf6ydxqgDppTo0id0QsIx/TC9h4lnYQlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3osi+7dbOnJNMFet7fRoqNNtMiEWiodt+wRPczuBxE5i06e/lbQK6pUVQWTKHytrsNKBqAEM02NXZArGgYadsx+UkV4eq6xa8Ej9scQFkxBFQChP5SdlV0az/lJBdXhOFGwY2T4dhSzYFItsXMxMo/69IBneWo76dIsqvGVDmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=38RwiT9X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oICfSKcVVEwr9lphhag1D//hdbq9wT1yKGoVIaAkzZM=; b=38RwiT9Xpuk8RpGPbWTjeK8nSv
	Eb5BgasInFjvbdq/uyC7f6aRNrJYcawfB5gZMCPGJyQZPOfWiq89IbbPmLIk9GQWOhhsT/XxW+cSj
	Us21iANKJpy8Oazhd6O1A6qfEBojrdrlpMkEDqmvZa9XrDBGCvysiJcamxBjIInX6jU8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sRz3E-002LP6-G2; Thu, 11 Jul 2024 21:01:56 +0200
Date: Thu, 11 Jul 2024 21:01:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?Q?Hor=E1k_=282N=29?= <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <885eec03-b4d0-4bd1-869f-c334bb22888c@lunn.ch>
References: <20240708102716.1246571-1-kamilh@axis.com>
 <20240708102716.1246571-5-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708102716.1246571-5-kamilh@axis.com>

> +static int bcm5481x_get_brrmode(struct phy_device *phydev, u8 *data)
>  {
> -	int err, reg;
> +	int reg;
>  
> -	/* Disable BroadR-Reach function. */
>  	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
> -	reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
> -	err = bcm_phy_write_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL,
> -				reg);
> -	if (err < 0)

bcm_phy_read_exp() could fail. So you should keep the test. Also, the
caller of this function does look at the return value.

> +/**
> + * bcm5481x_read_abilities - read PHY abilities from LRESR or Clause 22
> + * (BMSR) registers, based on whether the PHY is in BroadR-Reach or IEEE mode
> + * @phydev: target phy_device struct
> + *
> + * Description: Reads the PHY's abilities and populates
> + * phydev->supported accordingly. The register to read the abilities from is
> + * determined by current brr mode setting of the PHY.
> + * Note that the LRE and IEEE sets of abilities are disjunct.
> + *
> + * Returns: 0 on success, < 0 on failure
> + */
> +static int bcm5481x_read_abilities(struct phy_device *phydev)
> +{
> +	int i, val, err;
> +	u8 brr_mode;
> +
> +	for (i = 0; i < ARRAY_SIZE(bcm54811_linkmodes); i++)
> +		linkmode_clear_bit(bcm54811_linkmodes[i], phydev->supported);
> +
> +	err = bcm5481x_get_brrmode(phydev, &brr_mode);

> +static int bcm5481x_set_brrmode(struct phy_device *phydev, bool on)
> +{
> +	int reg;
> +	int err;
> +	u16 val;
> +
> +	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
> +
> +	if (on)
> +		reg |= BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
> +	else
> +		reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
> +

> +static int bcm54811_config_init(struct phy_device *phydev)
> +{
> +	struct device_node *np = phydev->mdio.dev.of_node;
> +	bool brr = false;
> +	int err, reg;
> +
>  	err = bcm54xx_config_init(phydev);
>  
>  	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
> @@ -576,29 +687,80 @@ static int bcm54811_config_init(struct phy_device *phydev)
>  			return err;
>  	}
>  
> -	return err;
> +	/* Configure BroadR-Reach function. */
> +	brr = of_property_read_bool(np, "brr-mode");
> +
> +	/* With BCM54811, BroadR-Reach implies no autoneg */
> +	if (brr)
> +		phydev->autoneg = 0;
> +
> +	return bcm5481x_set_brrmode(phydev, brr);
>  }

The ordering seems a bit strange here.

phy_probe() will call phydrv->get_features. At this point, the PHY is
in whatever mode it resets to, or maybe what it is strapped
to. phydev->supported could thus be set to standard IEEE modes,
despite the board design is actually for BroadR-Reach.

Sometime later, when the MAC is connected to the PHY config_init() is
called. At that point, you poke around in DT and find how the PHY is
connected to the cable. At that point, you set the PHY mode, and
change phydev->supported to reflect reality.

I really think that reading DT should be done much earlier, maybe in
the driver probe function, or maybe get_features. get_features should
always return the correct values from the board.

> +static int bcm5481_config_aneg(struct phy_device *phydev)
> +{
> +	u8 brr_mode;
> +	int ret;
> +
> +	ret = bcm5481x_get_brrmode(phydev, &brr_mode);

Rather than read it from the hardware every single time, could you
store the DT value in bcm54xx_phy_priv ?

> +/* Read LDS Link Partner Ability in BroadR-Reach mode */
> +static int bcm_read_lpa(struct phy_device *phydev)

This function seems to be missing an lds or lre prefix.

> +static int bcm_read_status_fixed(struct phy_device *phydev)

and here. Please make sure the naming is consistent. Anything which
only accesses lre or lds registers should make that clear in its name.

> +static int bcm54811_read_status(struct phy_device *phydev)
> +{
> +	u8 brr_mode;
> +	int err;
> +
> +	err = bcm5481x_get_brrmode(phydev, &brr_mode);
> +
> +	if (err)
> +		return err;
> +
> +	if (brr_mode) {
> +		/* Get the status in BroadRReach mode just like
> +		 *   genphy_read_status does in normal mode
> +		 */
> +
> +		int err, old_link = phydev->link;
> +
> +		/* Update the link, but return if there was an error */
> +
> +		err = lre_update_link(phydev);
> +		if (err)
> +			return err;
> +
> +		/* why bother the PHY if nothing can have changed */
> +		if (phydev->autoneg ==
> +		    AUTONEG_ENABLE && old_link && phydev->link)
> +			return 0;
> +
> +		phydev->speed = SPEED_UNKNOWN;
> +		phydev->duplex = DUPLEX_UNKNOWN;
> +		phydev->pause = 0;
> +		phydev->asym_pause = 0;
> +
> +		err = bcm_read_master_slave(phydev);
> +		if (err < 0)
> +			return err;
> +
> +		/* Read LDS Link Partner Ability */
> +		err = bcm_read_lpa(phydev);
> +		if (err < 0)
> +			return err;
> +
> +		if (phydev->autoneg ==
> +		    AUTONEG_ENABLE && phydev->autoneg_complete) {
> +			phy_resolve_aneg_linkmode(phydev);
> +		} else if (phydev->autoneg == AUTONEG_DISABLE) {
> +			err = bcm_read_status_fixed(phydev);
> +			if (err < 0)
> +				return err;
> +		}

This would probably look better if you pulled this code out into a
helper bcm54811_lre_read_status().

    Andrew

---
pw-bot: cr

