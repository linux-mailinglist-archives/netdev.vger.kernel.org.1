Return-Path: <netdev+bounces-133845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F098997326
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DE71F23751
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF261E0DC9;
	Wed,  9 Oct 2024 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RtD/q5Fy"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2471CEEAD;
	Wed,  9 Oct 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495273; cv=none; b=ju72ZIAFc0xHhX8EE6utmw/VlYbGkiAWZh9bbGDQTnsjssmpaPnZaXDuQKjvnHE49Lp9ICPZz9+hp/fn8bdIIezQqrIQq0NwqyAKT7TwxP73kl1A8lJhicQNxUy7Z718wZBf0hKHvsW/Cfa6mEs7j7al2jXOMfzji1FAn3vpqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495273; c=relaxed/simple;
	bh=SZPP9A8YiDo07MO8JUs9glfc2DZPltMCM3hygLWpAh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK3JE2WmygZc9fuszHyGHJTpPIwru3Y/BOlcU3oItVHcYgwfK/cJJFNflkE0ngY8yFNOItMlWoJU8nO76ltu8pT/KolmFfhHQ5p7QRDp2IG/xs11B9WlnA93wbgoSI4HMapmJuhrEgGbHNRB7chnIy638rn+j4UMSbjQbSyMqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RtD/q5Fy; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NJRvCliCaq9/6Gp5GJEnLChngxi76N/IwevvsW5caDU=; b=RtD/q5FyTJf7DVleaIDrcVIUxr
	QCFPBpCh25nkDJZppceTcb/tyTkYIpNDRwR0HOcjOHPMaYXom4PdQTk1LqKIJ7BsBIXxEqA9SeFv5
	2Ek2sKkToYiNI79+x8mhc7jlB8Q8ftbPHr/lLlm0TtJpwmW02N0pXBqMVyDikwSmmGIVpqBpNP31a
	S4DCMhOSQ7zlWkMfXeCHMylgBA+aj9/Exi+F3SMD93hR3mgJ5KJY3mU/mvTYZc1bz/7YAb4pyqgCf
	j00BRInwmFc+V2ALTlstUPC8twpdQvpsO2ZM5vCPZpsT9ti7rSFnf2/Gr+MTlsibOj2e1RpjBDgHs
	2seHbPHA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55526)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syaZh-00010C-0v;
	Wed, 09 Oct 2024 18:34:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1syaZb-0006Ry-32;
	Wed, 09 Oct 2024 18:34:08 +0100
Date: Wed, 9 Oct 2024 18:34:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: populate host_interfaces when
 attaching PHY
Message-ID: <Zwa-j1LKB3V2o2r9@shell.armlinux.org.uk>
References: <ae53177a7b68964b2a988934a09f74a4931b862d.1728438951.git.daniel@makrotopia.org>
 <ZwZGVRL_j62tH9Mp@shell.armlinux.org.uk>
 <ZwZubYpZ4JAhyavl@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwZubYpZ4JAhyavl@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 09, 2024 at 12:52:13PM +0100, Daniel Golle wrote:
> Hi Russell,
> 
> On Wed, Oct 09, 2024 at 10:01:09AM +0100, Russell King (Oracle) wrote:
> > On Wed, Oct 09, 2024 at 02:57:03AM +0100, Daniel Golle wrote:
> > > Use bitmask of interfaces supported by the MAC for the PHY to choose
> > > from if the declared interface mode is among those using a single pair
> > > of SerDes lanes.
> > > This will allow 2500Base-T PHYs to switch to SGMII on most hosts, which
> > > results in half-duplex being supported in case the MAC supports that.
> > > Without this change, 2500Base-T PHYs will always operate in 2500Base-X
> > > mode with rate-matching, which is not only wasteful in terms of energy
> > > consumption, but also limits the supported interface modes to
> > > full-duplex only.
> > 
> > We've had a similar patch before, and it's been NAK'd. The problem is
> > that supplying the host_interfaces for built-in PHYs means that the
> > hardware strapping for the PHY interface mode becomes useless, as does
> > the DT property specifying it - and thus we may end up selecting a
> > mode that both the MAC and PHY support, but the hardware design
> > doesn't (e.g. signals aren't connected, signal speed to fast.)
> > 
> > For example, take a board designed to use RXAUI and the host supports
> > 10GBASE-R. The first problem is, RXAUI is not listed in the SFP
> > interface list because it's not usable over a SFP cage.
> 
> I thought about that, also boards configured for RGMII but both MAC
> and PHY supporting SGMII or even 2500Base-X would be such a case.
> In order to make sure we don't switch to link modes not supported
> by the design I check if the interface mode configured in DT is
> among those suitable for use with an SFP (ie. using a single pair
> of SerDes lanes):
> if (test_bit(pl->link_interface, phylink_sfp_interfaces))
> 	phy_interface_and(phy_dev->host_interfaces, phylink_sfp_interfaces,
> 			  pl->config->supported_interfaces);
> 
> Neither RXAUI nor RGMII modes are among phylink_sfp_interfaces, so
> cases in which those modes are configured in DT are already excluded.

This still won't work. There are drivers (boo, hiss, stmmac crap which
is resistant to cleanup and fixing but there's others too) that don't
do the phylink interface switching.

For example, stmmac sets the mode specified in DT and also if there
is a Synopsys XPCS, then the supported interfaces also gets USXGMII,
10GKR, XLGMII, 10GBASER, SGMII, 1000BASEX and 2500BASEX. If DT says
10GBASER, then the PHY must not switch to USXGMII, but if an
88x3310 were to be thrown in, the PHY driver _would_ decide to use
USXGMII against the DT configuration.

phydev->host_interfaces is there to allow PHYs on SFPs be properly
configured according to the host interface, where there is no DT
description for the module. It is not meant for built-in PHYs.

> > So, the
> > host_interfaces excludes that, and thus the PHY thinks that's not
> > supported. It looks at the mask and sees only 10GBASE-R, and
> > decides to use that instead with rate matching. The MAC doesn't have
> > support for flow control, and thus can't use rate matching.
> > 
> > Not only have the electrical charateristics been violated by selecting
> > a faster interface than the hardware was designed for, but we now have
> > rate matching being used when it shouldn't be.
> 
> As we are also using using rate matching right now in cases when it
> should not (and thereby inhibiting support for half-duplex modes), I
> suppose the only good solution would be to allow a set of interface
> modes in DT instead of only a single one.

Two issues... why was the PHY configured via firmware to use rate
matching if that brings with it this restriction, and it's possible
not to?

Second, aqr107_get_rate_matching() is rather basic based on what people
want. It doesn't actually ask the PHY what its going to do. I know
there's a bunch of VEND1_GLOBAL_CFG registers that give the serdes
mode and rate adaption for each speed, and these can be set not only
by firmware configuration, but changed by the host.

So, aqr107_get_rate_matching() should work out whether rate matching
will be used for the interface mode by scanning these registers.

Something like:

	u16 cfg_regs[] = {
		VEND1_GLOBAL_CFG_10M,
		VEND1_GLOBAL_CFG_100M,
		VEND1_GLOBAL_CFG_1G,
		VEND1_GLOBAL_CFG_2_5G,
		VEND1_GLOBAL_CFG_5G,
		VEND1_GLOBAL_CFG_10G
	};
	int i, val;
	u8 mode;

	switch (interface) {
	case PHY_INTERFACE_MODE_10GBASER:
		mode = VEND1_GLOBAL_CFG_SERDES_MODE_XFI;
		break;
	
	case PHY_INTERFACE_MODE_2500BASEX:
		mode = VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII;
		break;

	case PHY_INTERFACE_MODE_5GBASER:
		mode = VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G;
		break;

	default:
		return RATE_MATCH_NONE;
	}

	/* If any speed corresponds to the interface mode and uses pause rate
	 * matching, indicate that this interface mode uses pause rate
	 * matching.
	 */
	for (i = 0; i < ARRAY_SIZE(cfg_regs); i++) {
		val = phy_read_mmd(phydev, MDIO_MMD_VEND1, cfg_regs[i]);
		if (val < 0)
			return val;

		if (FIELD_GET(VEND1_GLOBAL_CFG_SERDES_MODE, val) == mode) {
			if (FIELD_GET(VEND1_GLOBAL_CFG_RATE_ADAPT, val) ==
			    VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE)
				return RATE_MATCH_PAUSE;
		}
	}

	return RATE_MATCH_NONE;

Now, while phylink restricts RATE_MATCH_PAUSE to being full-duplex only,
I'm not sure that is correct. I didn't contribute this support, and I
don't have any platforms that support this, and I don't have any
experience of it.

What I do have is the data sheet for 88x3310, and that doesn't mention
any restriction such as "only full duplex is supported in rate matching
mode".

It is true that to use pause frames, the MAC/PCS must be in full-duplex
mode, but if the PHY supports half-duplex on the media to full-duplex
on the MAC side link, then why should phylink restrict this to be
full-duplex only?

I suspect phylink_get_capabilities() handling for RATE_MATCH_PAUSE is
not correct - or maybe not versatile enough.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

