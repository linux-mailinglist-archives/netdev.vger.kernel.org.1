Return-Path: <netdev+bounces-188587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23026AADA33
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 10:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C0A1C22E53
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 08:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E540149C64;
	Wed,  7 May 2025 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="h89FVN2i"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B9F4C83;
	Wed,  7 May 2025 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606735; cv=none; b=QmVTBmZmnF9eTWykVjV8dN7xxaIr98qSb5bsLGsUxjhzd73eMrVckm8Yt4OIv5QE0CArDhn+WzWUzRfu/crEPvQq6aF2Z3NPm9oiRJMePlS1Xn7MnYFVKpMXOZVBBbsZ0ZRO4Spx2Txh9tjZNyJrUzykoTutSgIr90kSEjmuzqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606735; c=relaxed/simple;
	bh=QWivGVOh5g2umg1/BM0yxs7g+cJ8e6EIBYj2jbSiUnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ham5Cc7B7sWhzv8RYObYl7AuQHYWbiWJvdEu7RSz+Up6kiQPnG4UechYLOCgHAki8XE0tfCoLNPCW73zI8VZ2syRyezO8sTKbgtHTys/6LBDnj1+ZsNyF6uUcNRyvt7kqIU4oNJ+Y08bfs2UZEWoev571ldsgiKEYJ5rYPdw7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=h89FVN2i; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HPiAYftUUPWio4/q+oc8C8g2Gd6+x1qqIiF0EyxjjUo=; b=h89FVN2itmZPtDrDYf75SX0Noo
	0bLdOXxzsksGtjfBn2K1/6GPd29UO/HeG/L7pm+5fzwGpDraUCpW4znLxRAYwLvmkbnV7gEZRt7hK
	AXkUChU9ywF6HjtIFTJd1hmiZ5j6fYgGi8ppb6e6hyGW4MISK5SKHGgT2UeaZJgMP18noeCLJWYaX
	l0G2JkILcwexz2w1+kamjJsf8rUBrXzCLyAEyken7hBgfb3AYDUwPiPEgYc0ffmoOTKFY4Jo7YBsa
	Z+JFwWrd4jNmhcol9ZeUOXI7v5ubLGwZG48AWvOjvMeUCHT9K4XCdnJXhosqF3u5HOD8718i7pWZy
	ek1QhGwA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37748)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uCaC0-0007Cu-0l;
	Wed, 07 May 2025 09:31:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uCaBw-0005dC-0x;
	Wed, 07 May 2025 09:31:48 +0100
Date: Wed, 7 May 2025 09:31:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Tristram.Ha@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <aBsadO2IB_je91Jx@shell.armlinux.org.uk>
References: <20250507000911.14825-1-Tristram.Ha@microchip.com>
 <20250507094449.60885752@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507094449.60885752@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 07, 2025 at 09:44:49AM +0200, Maxime Chevallier wrote:
> Hi Tristram,
> 
> On Tue, 6 May 2025 17:09:11 -0700
> <Tristram.Ha@microchip.com> wrote:
> 
> > From: Tristram Ha <tristram.ha@microchip.com>
> > 
> > The KSZ9477 switch driver uses the XPCS driver to operate its SGMII
> > port.  However there are some hardware bugs in the KSZ9477 SGMII
> > module so workarounds are needed.  There was a proposal to update the
> > XPCS driver to accommodate KSZ9477, but the new code is not generic
> > enough to be used by other vendors.  It is better to do all these
> > workarounds inside the KSZ9477 driver instead of modifying the XPCS
> > driver.
> > 
> > There are 3 hardware issues.  The first is the MII_ADVERTISE register
> > needs to be write once after reset for the correct code word to be
> > sent.  The XPCS driver disables auto-negotiation first before
> > configuring the SGMII/1000BASE-X mode and then enables it back.  The
> > KSZ9477 driver then writes the MII_ADVERTISE register before enabling
> > auto-negotiation.  In 1000BASE-X mode the MII_ADVERTISE register will
> > be set, so KSZ9477 driver does not need to write it.
> > 
> > The second issue is the MII_BMCR register needs to set the exact speed
> > and duplex mode when running in SGMII mode.  During link polling the
> > KSZ9477 will check the speed and duplex mode are different from
> > previous ones and update the MII_BMCR register accordingly.
> > 
> > The last issue is 1000BASE-X mode does not work with auto-negotiation
> > on.  The cause is the local port hardware does not know the link is up
> > and so network traffic is not forwarded.  The workaround is to write 2
> > additional bits when 1000BASE-X mode is configured.
> > 
> > Note the SGMII interrupt in the port cannot be masked.  As that
> > interrupt is not handled in the KSZ9477 driver the SGMII interrupt bit
> > will not be set even when the XPCS driver sets it.
> >
> > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> 
> [...]
> 
> > +
> > +static int ksz9477_pcs_read(struct mii_bus *bus, int phy, int mmd, int reg)
> > +{
> > +	struct ksz_device *dev = bus->priv;
> > +	int port = ksz_get_sgmii_port(dev);
> > +	u16 val;
> > +
> > +	port_sgmii_r(dev, port, mmd, reg, &val);
> > +
> > +	/* Simulate a value to activate special code in the XPCS driver if
> > +	 * supported.
> > +	 */
> > +	if (mmd == MDIO_MMD_PMAPMD) {
> > +		if (reg == MDIO_DEVID1)
> > +			val = 0x9477;
> > +		else if (reg == MDIO_DEVID2)
> > +			val = 0x22 << 10;
> > +	} else if (mmd == MDIO_MMD_VEND2) {
> > +		struct ksz_port *p = &dev->ports[port];
> > +
> > +		/* Need to update MII_BMCR register with the exact speed and
> > +		 * duplex mode when running in SGMII mode and this register is
> > +		 * used to detect connected speed in that mode.
> > +		 */
> > +		if (reg == MMD_SR_MII_AUTO_NEG_STATUS) {
> > +			int duplex, speed;
> > +
> > +			if (val & SR_MII_STAT_LINK_UP) {
> > +				speed = (val >> SR_MII_STAT_S) & SR_MII_STAT_M;
> > +				if (speed == SR_MII_STAT_1000_MBPS)
> > +					speed = SPEED_1000;
> > +				else if (speed == SR_MII_STAT_100_MBPS)
> > +					speed = SPEED_100;
> > +				else
> > +					speed = SPEED_10;
> > +
> > +				if (val & SR_MII_STAT_FULL_DUPLEX)
> > +					duplex = DUPLEX_FULL;
> > +				else
> > +					duplex = DUPLEX_HALF;
> > +
> > +				if (!p->phydev.link ||
> > +				    p->phydev.speed != speed ||
> > +				    p->phydev.duplex != duplex) {
> > +					u16 ctrl;
> > +
> > +					p->phydev.link = 1;
> > +					p->phydev.speed = speed;
> > +					p->phydev.duplex = duplex;
> > +					port_sgmii_r(dev, port, mmd, MII_BMCR,
> > +						     &ctrl);
> > +					ctrl &= BMCR_ANENABLE;
> > +					ctrl |= mii_bmcr_encode_fixed(speed,
> > +								      duplex);
> > +					port_sgmii_w(dev, port, mmd, MII_BMCR,
> > +						     ctrl);
> > +				}
> > +			} else {
> > +				p->phydev.link = 0;
> > +			}
> > +		} else if (reg == MII_BMSR) {
> > +			p->phydev.link = (val & BMSR_LSTATUS);
> > +		}
> > +	}
> > +	return val;
> > +}
> > +
> > +static int ksz9477_pcs_write(struct mii_bus *bus, int phy, int mmd, int reg,
> > +			     u16 val)
> > +{
> > +	struct ksz_device *dev = bus->priv;
> > +	int port = ksz_get_sgmii_port(dev);
> > +
> > +	if (mmd == MDIO_MMD_VEND2) {
> > +		struct ksz_port *p = &dev->ports[port];
> > +
> > +		if (reg == MMD_SR_MII_AUTO_NEG_CTRL) {
> > +			u16 sgmii_mode = SR_MII_PCS_SGMII << SR_MII_PCS_MODE_S;
> > +
> > +			/* Need these bits for 1000BASE-X mode to work with
> > +			 * AN on.
> > +			 */
> > +			if (!(val & sgmii_mode))
> > +				val |= SR_MII_SGMII_LINK_UP |
> > +				       SR_MII_TX_CFG_PHY_MASTER;
> > +
> > +			/* SGMII interrupt in the port cannot be masked, so
> > +			 * make sure interrupt is not enabled as it is not
> > +			 * handled.
> > +			 */
> > +			val &= ~SR_MII_AUTO_NEG_COMPLETE_INTR;
> > +		} else if (reg == MII_BMCR) {
> > +			/* The MII_ADVERTISE register needs to write once
> > +			 * before doing auto-negotiation for the correct
> > +			 * config_word to be sent out after reset.
> > +			 */
> > +			if ((val & BMCR_ANENABLE) && !p->sgmii_adv_write) {
> > +				u16 adv;
> > +
> > +				/* The SGMII port cannot disable flow contrl
> > +				 * so it is better to just advertise symmetric
> > +				 * pause.
> > +				 */
> > +				port_sgmii_r(dev, port, mmd, MII_ADVERTISE,
> > +					     &adv);
> > +				adv |= ADVERTISE_1000XPAUSE;
> > +				adv &= ~ADVERTISE_1000XPSE_ASYM;
> > +				port_sgmii_w(dev, port, mmd, MII_ADVERTISE,
> > +					     adv);
> > +				p->sgmii_adv_write = 1;
> > +			} else if (val & BMCR_RESET) {
> > +				p->sgmii_adv_write = 0;
> > +			}
> > +		} else if (reg == MII_ADVERTISE) {
> > +			/* XPCS driver writes to this register so there is no
> > +			 * need to update it for the errata.
> > +			 */
> > +			p->sgmii_adv_write = 1;
> > +		}
> > +	}
> > +	port_sgmii_w(dev, port, mmd, reg, val);
> > +	return 0;
> > +}
> 
> I'm a bit confused here, are you intercepting r/w ops that are supposed
> to be handled by xpcs ?
> 
> Russell has sent a series [1] (not merged yet, I think we were waiting
> on some feedback from Synopsys folks ?) to properly support the XPCS
> version that's in KSZ9477, and you also had a patchset that didn't
> require all this sgmii_r/w snooping [2].
> 
> I've been running your previous patchset on top of Russell's for a few
> months, if works fine with SGMII as well as 1000BaseX :)
> 
> Can we maybe focus on getting pcs-xpcs to properly support this version
> of the IP instead of these 2 R/W functions ? Or did I miss something in
> the previous discussions ?

Honestly, I don't think Tristram is doing anything unreasonable here,
given what Vladimir has been saying. Essentially, we've been blocking
a way forward on the pcs-xpcs driver. We've had statements from the
hardware designers from Microchip. We've had statements from Synopsys.
The two don't quite agree, but that's not atypical. Yet, we're still
demanding why the Microchip version of XPCS is different.

So what's left for Tristram to do other than to hack around the blockage
we're causing by intercepting the read/write ops and bodging them.

As I understand the situation, this is Jose's response having asked
internally at my request:

https://lore.kernel.org/netdev/DM4PR12MB5088BA650B164D5CEC33CA08D3E82@DM4PR12MB5088.namprd12.prod.outlook.com/

To put it another way, as far as Synopsys can tell us, they are unaware
of the Microchip behaviour, but customers can modify the Synopsys IP.

Maybe Microchip's version is based on an old Synopsys version, but
which was modified by Microchip a long time ago and those engineers
have moved on, and no one really knows anymore. I doubt that we are
ever going to get to the bottom of the different behaviour.

So, what do we do now? Do we continue playing hardball and basically
saying "no" to changing the XPCS driver, demanding information that
doesn't seem to exist anymore? Or do we try to come up with an
approach that works.

I draw attention to the last sentence in Jose's quote in his reply.
As far as the Synopsys folk are concerned, setting these bits to 1
should have no effect provided there aren't customer modifications to
the IP that depend on these being set to zero.

That last bit is where I think the sticking point between Vladimir and
myself is - I'm in favour of keeping things simple and just setting
the bits. Vladimir feels it would be safer to make it conditional,
which leads to more complicated code.

I didn't progress my series because I decided it was a waste of time
to try and progress this any further - I'd dug up the SJA1105 docs to
see what they said, I'd reached out to Synopsys and got a statement
back, and still Vladimir wasn't happy.

With Vladimir continuing to demand information from Tristram that just
didn't exist, I saw that the

[rest of the email got deleted because Linux / X11 / KDE got confused
about the state the backspace key and decided it was going to be
continuously pressed and doing nothing except shutting the laptop
down would stop it.]

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

