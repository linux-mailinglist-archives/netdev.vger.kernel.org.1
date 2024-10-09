Return-Path: <netdev+bounces-133897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E938997639
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 22:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECABC284E88
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC431E1A12;
	Wed,  9 Oct 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w/1EA6ew"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E040849;
	Wed,  9 Oct 2024 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728504746; cv=none; b=sgtf/VV0ChJ4w/QFhIeg/89DbYy5m8CUIY3QOSn445qdXCUgj6KqtPvmU3q+9At8p2KsfgjOanlFq/WFCDmYX7MX8687gdKshacBNgZf11czWF42ECtNVjdLK11ow5iHiAvEqZsR5QgsaZpfO5Rq8MDgsjdXnW2tQ7W7FAue0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728504746; c=relaxed/simple;
	bh=fyqJmBKyEQJ6yk/G06DDzwuZ8WD2YSFsYiYx3Q8uprw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ousGUqXd+Biq+0tR7IHbk9WXvqQFcl7A6sbcknW/fx8JdLfiSPLL4UfhKl0JRFQSWhSMuJsfCw2AnkN9V+X37qygrS9Jx8OdSvU3M7If+DquWYGTbSUcmRLtvsLWE51dWKXdMiHO3IB+8zoIHy8/eU268IEBRyl08Ezf9W6Ld00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w/1EA6ew; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cyjV0m/FVHX5OoVTni98jL/NJf0T7IkXtRCLs6LCGxE=; b=w/1EA6ewh3iuoCRnR/b9EJHeIa
	kfOeq7X2rNawGLqVGHkzawWXZ7Q3XbhhYirWxYM8lXzMtVRCYJgtyyNdsGv1u9NVNDuqkdMecjEIZ
	VNICg1cOU2tJLjOOCsLC4iUGcaQnu0f6Nhx3pcmCyGk0xpcPM+atpPrAMGAYn3miq3kxn7vD7aJDN
	p1J9CGRc2gk7GVZDY2jrrIKXhWCyAr6Xy6Mj7+/rHZtfJWX1n29wkheTbqtCLzJbum1kbtXmuwrQG
	hjjNMrNX7EY6o+V7/GgYL8oTYKhuLhFACLzRvROl/foSZ5pEloZ4WzzFuhGiKLMGNPFKC1R0DMKly
	tNdAEh4g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34352)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syd2Z-0001Bq-2i;
	Wed, 09 Oct 2024 21:12:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1syd2U-0006a3-2R;
	Wed, 09 Oct 2024 21:12:06 +0100
Date: Wed, 9 Oct 2024 21:12:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: populate host_interfaces when
 attaching PHY
Message-ID: <Zwbjlln3X5RXTt8x@shell.armlinux.org.uk>
References: <ae53177a7b68964b2a988934a09f74a4931b862d.1728438951.git.daniel@makrotopia.org>
 <ZwZGVRL_j62tH9Mp@shell.armlinux.org.uk>
 <ZwZubYpZ4JAhyavl@makrotopia.org>
 <Zwa-j1LKB3V2o2r9@shell.armlinux.org.uk>
 <ZwbQ-thwDxPfqGnW@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwbQ-thwDxPfqGnW@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 09, 2024 at 07:52:42PM +0100, Daniel Golle wrote:
> On Wed, Oct 09, 2024 at 06:34:07PM +0100, Russell King (Oracle) wrote:
> > On Wed, Oct 09, 2024 at 12:52:13PM +0100, Daniel Golle wrote:
> > > Hi Russell,
> > > 
> > > On Wed, Oct 09, 2024 at 10:01:09AM +0100, Russell King (Oracle) wrote:
> > > > On Wed, Oct 09, 2024 at 02:57:03AM +0100, Daniel Golle wrote:
> > > > > Use bitmask of interfaces supported by the MAC for the PHY to choose
> > > > > from if the declared interface mode is among those using a single pair
> > > > > of SerDes lanes.
> > > > > This will allow 2500Base-T PHYs to switch to SGMII on most hosts, which
> > > > > results in half-duplex being supported in case the MAC supports that.
> > > > > Without this change, 2500Base-T PHYs will always operate in 2500Base-X
> > > > > mode with rate-matching, which is not only wasteful in terms of energy
> > > > > consumption, but also limits the supported interface modes to
> > > > > full-duplex only.
> > > > 
> > > > We've had a similar patch before, and it's been NAK'd. The problem is
> > > > that supplying the host_interfaces for built-in PHYs means that the
> > > > hardware strapping for the PHY interface mode becomes useless, as does
> > > > the DT property specifying it - and thus we may end up selecting a
> > > > mode that both the MAC and PHY support, but the hardware design
> > > > doesn't (e.g. signals aren't connected, signal speed to fast.)
> > > > 
> > > > For example, take a board designed to use RXAUI and the host supports
> > > > 10GBASE-R. The first problem is, RXAUI is not listed in the SFP
> > > > interface list because it's not usable over a SFP cage.
> > > 
> > > I thought about that, also boards configured for RGMII but both MAC
> > > and PHY supporting SGMII or even 2500Base-X would be such a case.
> > > In order to make sure we don't switch to link modes not supported
> > > by the design I check if the interface mode configured in DT is
> > > among those suitable for use with an SFP (ie. using a single pair
> > > of SerDes lanes):
> > > if (test_bit(pl->link_interface, phylink_sfp_interfaces))
> > > 	phy_interface_and(phy_dev->host_interfaces, phylink_sfp_interfaces,
> > > 			  pl->config->supported_interfaces);
> > > 
> > > Neither RXAUI nor RGMII modes are among phylink_sfp_interfaces, so
> > > cases in which those modes are configured in DT are already excluded.
> > 
> > This still won't work. There are drivers (boo, hiss, stmmac crap which
> > is resistant to cleanup and fixing but there's others too) that don't
> > do the phylink interface switching.
> 
> Ok, what a mess. So multiple interfaces modes will have to be declared
> in DT for those boards which actually support that. What you be open
> to something like that:
> 
> phy-mode = "2500base-x", "sgmii";

I think we've tried going down that route before and it wasn't well
received.

> > For example, stmmac sets the mode specified in DT and also if there
> > is a Synopsys XPCS, then the supported interfaces also gets USXGMII,
> > 10GKR, XLGMII, 10GBASER, SGMII, 1000BASEX and 2500BASEX. If DT says
> > 10GBASER, then the PHY must not switch to USXGMII, but if an
> > 88x3310 were to be thrown in, the PHY driver _would_ decide to use
> > USXGMII against the DT configuration.
> > 
> > phydev->host_interfaces is there to allow PHYs on SFPs be properly
> > configured according to the host interface, where there is no DT
> > description for the module. It is not meant for built-in PHYs.
> 
> Imho allowing several available interface modes can still be
> advantageous also for built-in PHYs. Measurable power savings (~100mW on
> MT7986!) and not needing rate matching are both desireable things.
> 
> The question is just how would we get there...

We already do. Let me take an example that I use. Macchiatobin, which
you've probably heard lots about.

The PHY there is the 88x3310, which is configured to run in MAC mode 0
by hardware strapping. MAC mode 0 means the 88x3310 will switch between
10GBASE-R, 5GBASE-R, 2500BASE-X and SGMII on its host interface.

The MAC is Marvell's PP2, which supports all of those, and being one of
the original MACs that phylink was developed against, is coded properly
such that it fully works with phylink dynamically changing the interface
mode.

The interface mode given in DT is just a "guide" because the 88x3310
does no more than verify that the interface mode that it is bound with
is one it supports. However, every time the link comes up, providing
it is not operating in rate matching mode (which the PP2 doesn't
support) it will change its MAC facing interface appropriately.

Another board uses the 88x3310 with XAUI, and if I remember correctly,
the PHY is strapped for XAUI with rate matching mode. It's connected
to an 88e6390x DSA switch port 9, which supports RXAUI, XAUI, SGMII,
1000BASEX, 2500BASEX and maybe other stuff too.

So, what we do is in DT, we specify the maximum mode, and rely on the
hardware being correctly strapped on the PHY to configure how the
MAC side interface will be used.

Now, the thing with that second board is... if we use your original
suggestion, then we end up filling the host_interfaces with just
2500BASEX, 1000BASEX and SGMII. That will lead mv3310_select_mactype()
to select MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER for which the PHY will
attempt to use the modes I listed above for Macchiatobin on its MAC
interface which is wrong.

Let me repeat the point. phydev->host_interfaces is there to allow a
PHY driver to go off and make its own decisions about the interface
mode group that it should use _ignoring_ what's being asked of it
when the MAC binds to it. It should be empty for built-in setups
where this should not be used, and we have precedent on Macchiatobin
that interface switching by the PHY is permitted even in that
situation.


> > > As we are also using using rate matching right now in cases when it
> > > should not (and thereby inhibiting support for half-duplex modes), I
> > > suppose the only good solution would be to allow a set of interface
> > > modes in DT instead of only a single one.
> > 
> > Two issues... why was the PHY configured via firmware to use rate
> > matching if that brings with it this restriction, and it's possible
> > not to?
> 
> Looking at drivers/net/phy/realtek.c you see in rtl822xb_config_init()
> ...
>         has_2500 = test_bit(PHY_INTERFACE_MODE_2500BASEX,
>                             phydev->host_interfaces) ||
>                    phydev->interface == PHY_INTERFACE_MODE_2500BASEX;
> 
>         has_sgmii = test_bit(PHY_INTERFACE_MODE_SGMII,
>                              phydev->host_interfaces) ||
>                     phydev->interface == PHY_INTERFACE_MODE_SGMII;
> 
>         /* fill in possible interfaces */
>         __assign_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces,
>                      has_2500);
>         __assign_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces,
>                      has_sgmii);
> 
>         if (!has_2500 && !has_sgmii)
>                 return 0;
> 
>         /* determine SerDes option mode */
>         if (has_2500 && !has_sgmii) {
>                 mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX;
>                 phydev->rate_matching = RATE_MATCH_PAUSE;
>         } else {
>                 mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII;
>                 phydev->rate_matching = RATE_MATCH_NONE;
>         }
> ...
> 
> So rate-matching is NOT configured in firmware, but rather it is
> selected in cases where we (seemingly) don't have any other option. It
> may not be a good choice (imho it never is), but rather just a last
> resort in case we otherwise can't support lower speeds at all.
> 
> > 
> > Second, aqr107_get_rate_matching() is rather basic based on what people
> > want. It doesn't actually ask the PHY what its going to do. I know
> > there's a bunch of VEND1_GLOBAL_CFG registers that give the serdes
> > mode and rate adaption for each speed, and these can be set not only
> > by firmware configuration, but changed by the host.
> > 
> > So, aqr107_get_rate_matching() should work out whether rate matching
> > will be used for the interface mode by scanning these registers.
> > [...]
> 
> Afaik Aquantia 2.5G PHYs always work only with a fixed interface mode
> and perform rate-matching for lower speeds.

They don't _have_ to. To use a SFP with an AQR PHY on it in a clearfog
platform (which only supports SGMII, 1000BASE-X and 2500BASE-X, I
hacked the aquantia driver to do this:

        phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, MDIO_CTRL1, MDIO_CTRL1_LPOWER);
        mdelay(10);
        phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x31a, 2);
        phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_10M,
                      VEND1_GLOBAL_CFG_SGMII_AN |
                      VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
        phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_100M,
                      VEND1_GLOBAL_CFG_SGMII_AN |
                      VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
        phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_1G,
                      VEND1_GLOBAL_CFG_SGMII_AN |
                      VEND1_GLOBAL_CFG_SERDES_MODE_SGMII);
        phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CFG_2_5G,
                      VEND1_GLOBAL_CFG_SGMII_AN |
                      VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII);
        phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, MDIO_CTRL1,
                           MDIO_CTRL1_LPOWER);

which disables rate matching and causes it to switch interfaces.

Moreover, aqr107_read_status() reads the interface status and sets
the MAC interface accordingly, so the driver does support dynamically
changing the MAC interface just like 88x3310. If all use cases of
this PHY only ever did rate matching, then there would be no point
to that code being there!

> > Now, while phylink restricts RATE_MATCH_PAUSE to being full-duplex only,
> > I'm not sure that is correct. I didn't contribute this support, and I
> > don't have any platforms that support this, and I don't have any
> > experience of it.
> 
> Afaik enforcing half-duplex via rate-maching with pause-frames is
> supported by all the 2.5G PHYs I've seen up to now.

I'm sorry, I don't understand your sentence, because it just flies
wildly against everything that's been said.

First, pause-frames require full duplex on the link on which pause
frames are to be sent and received. That's fundamental.

Second, I'm not sure what "enforcing half-duplex" has to do with
rate-matching with pause-frames.

Third, the 88x3310 without MACSEC in rate matching mode requires the
MAC to pace itself. No support for pause frames at all - you only
get pause frames with the 88x3310P which has MACSEC. This is a 10M
to 10G PHY multi-rate PHY.

So... your comment makes no sense to me, sorry.

> > What I do have is the data sheet for 88x3310, and that doesn't mention
> > any restriction such as "only full duplex is supported in rate matching
> > mode".
> 
> Yep, and I suppose it should work just fine. The same applies for
> RealTek and MaxLinear PHYs. I've tested it.
> 
> > It is true that to use pause frames, the MAC/PCS must be in full-duplex
> > mode, but if the PHY supports half-duplex on the media to full-duplex
> > on the MAC side link, then why should phylink restrict this to be
> > full-duplex only?
> 
> There is no reason for that imho. phylink.c states
> /* Although a duplex-matching phy might exist, we
>  * conservatively remove these modes because the MAC
>  * will not be aware of the half-duplex nature of the
>  * link.
>  */
> 
> Afaik, practially all rate-matching PHYs which do support half-duplex
> modes on the TP interface can perform duplex-matching as well.

So we should remove that restriction!

> > I suspect phylink_get_capabilities() handling for RATE_MATCH_PAUSE is
> > not correct - or maybe not versatile enough.
> 
> I agree. Never the less, why use rate matching at all if we don't have
> to? It's obviously inefficient and wasteful, having the MAC follow the
> PHY speed is preferrable in every case imho.

As I say, I believe this is a matter of how the Aquantia firmware is
commissioned - I believe the defaults for all of the VEND1_GLOBAL_CFG*
registers come from the firmware that the PHY loads.

So much like the pin strapping of 88x3310 determines its set of MAC
modes, which are decided by the board designer, Aquantia firmware
determines the PHY behaviour.

The problem here is we need to be mindful of the existing
implementations, not only those where the MAC/PHY combination would
get stuff wrong, but also of those MACs where multiple different
interfaces are supported through hardware strapping which is not
software determinable, but are not software configurable (like DSA
switches.) Then there's those who hacked phylink into their use
without properly implementing it (e.g. where mac_config() is entirely
empty, and thus support no reconfiguration of the interface yet
support multiple different interfaces at driver initialisation time.)

Yes, some of these situations can be said to be buggy. Feel free to
spend a few years hacking on stmmac to try and fix that god almighty
mess. I've given up with stmmac now after trying several attempts at
cleaning the mess up, and ending up in a very non-productive place
with it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

