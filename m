Return-Path: <netdev+bounces-154774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30679FFC05
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C5816336F
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BAA14F9D9;
	Thu,  2 Jan 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WtaGBtaz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A308714293
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835975; cv=none; b=Fh1toRdnQlsHO7aMUDbE6ho85qIrAne9HVnXiEL5AsOQbqTCqVfrYpcRvy59OW3ONQgZOcF35+MEPGohM8ktUo8VSvBaH9i99ZNf0klIjtawFzl2+6siW1CCj/TrTn/5g31CE2oiSriv7/tydjKmr8BTqnAfW06l391Yyoeu1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835975; c=relaxed/simple;
	bh=wTSnaCDZqWXUramp/LIWtMlQgqk8n+MG9FhixHzq/hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP4Lb5chYiPtIv49o9dlWlaCR9iPCMrTIqDegXoAh8uv/8F1kq1iZdfeXj6tOXqB1OwPquE0LGIJ8KcBnkfUVVLiPlLOh0ujGuSDSInevPjhpfwUE0jEbCDoBJP/M6VRyusQpm2gmJb6G+YEw5a7lWWl/2HMIVyJ85GikZRNmRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WtaGBtaz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N4gwQgAceOgugYioc9gwWOevAxppasD0GcV0j/Nx3lk=; b=WtaGBtazoBvWiuqP7/Ew4Nf0z7
	Gm4ZBayII2DfmsND+Zr7wRX5Xt4y2QQe6rUwQ6M953CcLMjwnuF2Py5nBIyDIH0Zj18NU1H38AR7U
	KUKDOzjP8cK9lwf9kXt9zHbNhI+m2CbcUEssbnJQqOouOf4H6CHQP6Wq87Ss56FrA6AvqR2yo+l6J
	QthJi18+YJZTGTkeVYI4q0wH2cytwZuVdcIRfkH3XYgjGuRc9mQN4dMW9t4s8aNcVSyQmb1Dzf7Gf
	A/35k1k61tK1BXDfaFtorMWuYnnln4k6NU2+O5g2SF7TX5PRt8A3wChTgT1lzuK1a4yQV1F0L+Gfu
	u03XdnSQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41592)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTOEK-0002BD-0v;
	Thu, 02 Jan 2025 16:39:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTOEI-0000Qu-2O;
	Thu, 02 Jan 2025 16:39:26 +0000
Date: Thu, 2 Jan 2025 16:39:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 05/10] net: phylink: add EEE management
Message-ID: <Z3bBPtKpTqARV8gR@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefi-006SMp-Hw@rmk-PC.armlinux.org.uk>
 <928c2613-b028-4073-818c-5cf38bd304ca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <928c2613-b028-4073-818c-5cf38bd304ca@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Dec 15, 2024 at 12:38:24AM +0100, Heiner Kallweit wrote:
> On 09.12.2024 15:23, Russell King (Oracle) wrote:
> > Add EEE management to phylink, making use of the phylib implementation.
> > This will only be used where a MAC driver populates the methods and
> > capabilities bitfield, otherwise we keep our old behaviour.
> > 
> > Phylink will keep track of the EEE configuration, including the clock
> > stop abilities at each end of the MAC to PHY link, programming the PHY
> > appropriately and preserving the EEE configuration should the PHY go
> > away.
> > 
> > It will also call into the MAC driver when LPI needs to be enabled or
> > disabled, with the expectation that the MAC have LPI disabled during
> > probe.
> > 
> > Support for phylink managed EEE is enabled by populating both tx_lpi
> > MAC operations method pointers.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/phy/phylink.c | 123 ++++++++++++++++++++++++++++++++++++--
> >  include/linux/phylink.h   |  44 ++++++++++++++
> >  2 files changed, 163 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 03509fdaa1ec..750356b6a2e9 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -81,12 +81,19 @@ struct phylink {
> >  	unsigned int pcs_state;
> >  
> >  	bool link_failed;
> > +	bool mac_supports_eee;
> > +	bool phy_enable_tx_lpi;
> > +	bool mac_enable_tx_lpi;
> > +	bool mac_tx_clk_stop;
> > +	u32 mac_tx_lpi_timer;
> >  
> >  	struct sfp_bus *sfp_bus;
> >  	bool sfp_may_have_phy;
> >  	DECLARE_PHY_INTERFACE_MASK(sfp_interfaces);
> >  	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
> >  	u8 sfp_port;
> > +
> > +	struct eee_config eee_cfg;
> >  };
> >  
> >  #define phylink_printk(level, pl, fmt, ...) \
> > @@ -1563,6 +1570,47 @@ static const char *phylink_pause_to_str(int pause)
> >  	}
> >  }
> >  
> > +static void phylink_deactivate_lpi(struct phylink *pl)
> > +{
> > +	if (pl->mac_enable_tx_lpi) {
> > +		pl->mac_enable_tx_lpi = false;
> > +
> > +		phylink_dbg(pl, "disabling LPI\n");
> > +
> > +		pl->mac_ops->mac_disable_tx_lpi(pl->config);
> > +	}
> > +}
> > +
> > +static void phylink_activate_lpi(struct phylink *pl)
> > +{
> > +	if (!test_bit(pl->cur_interface, pl->config->lpi_interfaces)) {
> > +		phylink_dbg(pl, "MAC does not support LPI with %s\n",
> > +			    phy_modes(pl->cur_interface));
> > +		return;
> > +	}
> > +
> > +	phylink_dbg(pl, "LPI timer %uus, tx clock stop %u\n",
> > +		    pl->mac_tx_lpi_timer, pl->mac_tx_clk_stop);
> > +
> > +	pl->mac_ops->mac_enable_tx_lpi(pl->config, pl->mac_tx_lpi_timer,
> > +				       pl->mac_tx_clk_stop);
> > +
> > +	pl->mac_enable_tx_lpi = true;
> > +}
> > +
> > +static void phylink_phy_restrict_eee(struct phylink *pl, struct phy_device *phy)
> > +{
> > +	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_supported);
> > +
> > +	/* Convert the MAC's LPI capabilities to linkmodes */
> > +	linkmode_zero(eee_supported);
> > +	phylink_caps_to_linkmodes(eee_supported, pl->config->lpi_capabilities);
> > +
> > +	/* Mask out EEE modes that are not supported */
> > +	linkmode_and(phy->supported_eee, phy->supported_eee, eee_supported);
> > +	linkmode_and(phy->advertising_eee, phy->advertising_eee, eee_supported);
> > +}
> > +
> 
> Something similar we may need in phylib too. An example is cpsw MAC driver which
> doesn't support EEE. Issues have been reported if the PHY's on both sides negotiate
> EEE, workaround is to use property eee-broken-xxx in the respective DT's to disable
> PHY EEE advertisement. I'm thinking of adding a simple phy_disable_eee() which can
> be called by MAC drivers to clear EEE supported and advertising bitmaps.
> 
> A similar case is enetc (using phylink) which doesn't support EEE. See following in
> enetc.c:
> 
> /* disable EEE autoneg, until ENETC driver supports it */
> memset(&edata, 0, sizeof(struct ethtool_keee));
> phylink_ethtool_set_eee(priv->phylink, &edata);
> 
> Russell, do you plan to change this driver too, based on phylink extensions?
> I think already now, based on the quoted code piece, several (all?) eee-broken-xxx
> properties can be removed under arch/arm64/boot/dts/freescale .

At the moment, phylink-managed EEE is opt-in, so what you get without
this patch is what you get with the patch but no driver changes. This
allows existing drivers that support EEE and that use phylink to
continue to support EEE, and those that don't to continue in their
current situation (if they use work-arounds to disable EEE, then
those will continue to work.)

Rather than adding something explicit to phylink to disable EEE, I
would much rather we work towards a situation where, if a driver
uses phylink, then if EEE is supported, the EEE methods and other
configuration get populated. If not, then phylink disables EEE on
the PHY.

However, we can only get there once we have EEE implemented on all
the phylink-using drivers that currently support EEE.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

