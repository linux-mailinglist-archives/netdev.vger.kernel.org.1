Return-Path: <netdev+bounces-104817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2129290E85E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973D71F2121F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C4785626;
	Wed, 19 Jun 2024 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r2Su73Gb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1B78C91;
	Wed, 19 Jun 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793265; cv=none; b=MK/5+m85Qp1hoO+lafZ3E5ESsq4JBcwOiIhc6T/PyMl3/zvwpkWhE8kZJQzAbCjXHACouff4tJnGyxuh0nwGpAMVLxiKf/xiQ+BY4vEb/dVFfof8ru4K2UhC2K8/K7v3E8b0VpMb4kPpe6qBZuC+YKkYDN5Qi4HD4WJyd8cXhWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793265; c=relaxed/simple;
	bh=PhPqKYQCQkwNWu5LZ8dFzl8sb446Y/Jiz4a2i59MxrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg94QS9IQlCtFp7Xw7St2QumriiC/Kiuppid3jK3kci6/CArJt19gYZrAsnswCnWt34x+Tt19mc2s7KZo5Bu2i/9JgkQmp45qhYEMiHxSO4SVMGsz5liNy/I7TGneuB4bJ8Sv6YFAgCrnQ97oXV3E3fRSqN2Ee3duL7wGBXjMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=r2Su73Gb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=21JYkOIbkZLNfZaVuKtNV1fZ9lm08Q1ez/4bhTivuJs=; b=r2Su73GbRCbIlY2/iqWB7driHX
	quxDMxWk0YUthRbIbspUrjyzRjLCaZv0QhdewwLqfW9gLF4ZJoP9ZBbY42LSHcRiF3e+lo0Xi9b2S
	TDuG1upXycLH5eUOyPoLXxKevZX+gQFopQ2Vj6AqfDNWrtlMfMAFRECg15evJJCctN0PGU9iykGgt
	if+JD5Qy8b/edoWAldiQ4tbPgIiQ27+LNPbljowhZ6nDxNFrq0x6cqtUVaRaV94OHw6GHkWfkOF49
	o33FgEI8pig5WgD5Ab2Cdh8vUp34FKwbY1HoBNklTD2lMHZTL8XW+N0QUypd5L0fKGLdcK5GlFN+D
	ju6zndKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42498)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sJsdh-0008CM-1M;
	Wed, 19 Jun 2024 11:34:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sJsdg-0006g3-Tz; Wed, 19 Jun 2024 11:34:04 +0100
Date: Wed, 19 Jun 2024 11:34:04 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <ZnK0HL+pO9/2ZMKz@shell.armlinux.org.uk>
References: <20240617113841.3694934-1-kamilh@axis.com>
 <20240617113841.3694934-5-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617113841.3694934-5-kamilh@axis.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 17, 2024 at 01:38:41PM +0200, Kamil Horák - 2N wrote:
> +int bcm_config_lre_advert(struct phy_device *phydev)
> +{
> +	int err;
> +	u32 adv;
> +
> +	/* Only allow advertising what this PHY supports */
> +	linkmode_and(phydev->advertising, phydev->advertising,
> +		     phydev->supported);

Isn't this already done by phy_ethtool_ksettings_set() ?

        linkmode_copy(advertising, cmd->link_modes.advertising);
...
        /* We make sure that we don't pass unsupported values in to the PHY */
        linkmode_and(advertising, advertising, phydev->supported);
...
        linkmode_copy(phydev->advertising, advertising);

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

Nit: why two blank lines?

> +static int bcm54811_read_abilities(struct phy_device *phydev)
> +{
> +	static const int modes_array[] = { ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
> +					   ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
> +					   ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +					   ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> +					   ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
> +					   ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +					   ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> +					   ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +					   ETHTOOL_LINK_MODE_10baseT_Half_BIT };

Formatting...

	static const int modes_array[] = {
		ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
		...
		ETHTOOL_LINK_MODE_10baseT_Half_BIT
	};

please. This avoids wrapping beyond column 80, and is to kernel coding
standards.

> +	int i, val, err;
> +	u8 brr_mode;
> +
> +	for (i = 0; i < ARRAY_SIZE(modes_array); i++)
> +		linkmode_clear_bit(modes_array[i], phydev->supported);
> +
> +	err = bcm5481x_get_brrmode(phydev, &brr_mode);
> +	if (err)
> +		return err;
> +
> +	if (brr_mode) {
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

		linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
				 phydev->supported);

...
> +	/* Ensure LRE or IEEE register set is accessed according to the brr on/off,
> +	 *  thus set the override
> +	 */
> +	return bcm_phy_write_exp(phydev, BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL,
> +		BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN |
> +		(on ? 0 : BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL));

Needless parens, wrong formatting. Consider a local variable:

	val = BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN;
	if (!on)
		val |= BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL;

	return bcm_phy_write_exp(phydev,
				 BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL, val);

would be much nicer to read.

> +	if (phydev->autoneg != AUTONEG_ENABLE) {
> +		if (!phydev->autoneg_complete) {
> +			/* aneg not yet done, reset all relevant bits */
> +			static const int br_bits[] = { ETHTOOL_LINK_MODE_Autoneg_BIT,
> +						       ETHTOOL_LINK_MODE_Pause_BIT,
> +						       ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> +						       ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
> +						       ETHTOOL_LINK_MODE_100baseT1_Full_BIT };

More formatting issues. Maybe consider moving these out of the function?

> +			for (i = 0; i < ARRAY_SIZE(br_bits); i++)
> +				linkmode_clear_bit(br_bits[i], phydev->lp_advertising);

Formatting issue...

...
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> +				 phydev->lp_advertising, lrelpa & LRELPA_PAUSE_ASYM);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> +				 phydev->lp_advertising, lrelpa & LRELPA_PAUSE);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
> +				 phydev->lp_advertising, lrelpa & LRELPA_100_1PAIR);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
> +				 phydev->lp_advertising, lrelpa & LRELPA_10_1PAIR);

More formatting issues.

> +static int bcm54811_read_status(struct phy_device *phydev)
> +{
> +	int err;
> +	u8 brr_mode;

Reverse Christmas tree please.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

