Return-Path: <netdev+bounces-161612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3729A22B7C
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 11:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFFE167BF7
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4392B1B21B5;
	Thu, 30 Jan 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VvJOfYdX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5221F95E;
	Thu, 30 Jan 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738232131; cv=none; b=Rf5BDw6NsHWmn7qDfqx6EnSpOdAHHk9EpNXSAG0HYTyDzSZyPC7OfxGxhgaO8ouTss7UP313tJTpwcobRypVK5HbDWhP5slx69Q/rgdaAnqyYPjRig/IwJOHimwFHCqyb0Ppkr8ReVzM8PAN+dTPFZVrsvQPDwtXei8MAuy0faE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738232131; c=relaxed/simple;
	bh=pBjFopFTIz/A5Zz3Us1V/Fl727xQA5IBNO+q4qWloNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/fVcXeZT+kyWYQ0euOprdR/Gp+P87B0/2oEj/TDaO/AXYEilsAZeUT27Z+Px/2H2JM5YhEnIrpSDbb2Ivp8ArlAdsyLueIz3sDwBPc7eTzouqr2Prlor9yjhia3g15WgxkHElqcp8glihx0H8TirkQdMSZJP5Ym3/v6XewjnE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VvJOfYdX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=65d9H1YHsrkqrMlCIpWUa4AJacnKGhXrM6Fqbtals0E=; b=VvJOfYdXoTlqCvEqRjSet9EepF
	Zf6+X2YoVBpPriMnSM9yJqaQMN4/w1RQIhDS3JVe8atGajDeKJ9p0UeEwssPNq3i5OV7dnvruswAx
	DLkG5XnQBVbiG3vjVpRXjTaq1BPAfKIPSO1v+6a/zCOV0Iu3fdWCAkppJ7gV0f4GIYUdVLkOGCJTs
	+8Vkz3Emq+GcRDEZCkDZ1pUDbdtIYZ2Kao9K5QUbatdY7qkE7ypUVAjqZsFQCuSzInpSxO39FOIMA
	gqwRr/dFumfZFuN3qhtdSwIWLUFG4Ousef79KXRIf+9NtN+aYw2hegfqMyxmEalZ3lcByFBhG8Mwg
	duQJbJ9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38278)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tdRZt-0003pg-1t;
	Thu, 30 Jan 2025 10:15:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tdRZr-0004ft-1O;
	Thu, 30 Jan 2025 10:15:15 +0000
Date: Thu, 30 Jan 2025 10:15:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: olteanv@gmail.com, Woojung.Huh@microchip.com, andrew@lunn.ch,
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Message-ID: <Z5tRM5TYuMeCPXb-@shell.armlinux.org.uk>
References: <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 30, 2025 at 04:50:18AM +0000, Tristram.Ha@microchip.com wrote:
> > The next question would be whether it's something that we _could_
> > always do - if it has no effect for anyone else, then removing a
> > conditional simplifies the code.
> 
> I explained in the other email that this SGMII_LINK_STS |
> TX_CONFIG_PHY_SIDE_SGMII setting is only required for 1000BASEX where
> C37_1000BASEX is used instead of C37_SGMII and auto-negotiation is
> enabled.

This sentence reads to me "if we want to use 1000base-X mode, and we
configure the XPCS to use 1000base-X rather than Cisco SGMII then
setting both SGMII_LINK_STS and TX_CONFIG_PHY_SIDE_SGMII bits are
required.

Thanks, that tells me nothing that I don't already know. I know full
well that hardware needs to be configured for 1000base-X mode to use
1000base-X negotiation. I also have been saying for some time that
KSZ9477 documetation states that these two "SGMII" bits need to be
set in 1000base-X mode.

This is not what I'm questioning here. What I am questioning is whether
we can set these two "SGMII" bits _unconditionally_ in the
xpcs_config_aneg_c37_1000basex() path in the driver without impacting
newer XPCS IPs.

> > > Never touched by whom? xpcs_config_aneg_c37_sgmii() surely tries to
> > > touch it... Don't you think that the absence of this bit from the
> > > KSZ9477 implementation might have something to do with KSZ9477's unique
> > > need to force the link speed when in in-band mode?
> > 
> > I think Tristram is talking about xpcs_config_aneg_c37_1000basex()
> > here, not SGMII.
> > 
> > Tristram, as a general note: there is a reason I utterly hate the term
> > "SGMII" - and the above illustrates exactly why. There is Cisco SGMII
> > (the modified 1000base-X protocol for use with PHYs.) Then there is the
> > "other" SGMII that manufacturers like to band about because they want
> > to describe their "Serial Gigabit Media Independent Interface" and they
> > use it to describe an interface that supports both 1000base-X and Cisco
> > SGMII.
> > 
> > This overloading of "SGMII" leads to nothing but confusion - please be
> > specific about whether you are talking about 1000base-X or Cisco SGMII,
> > and please please please avoid using "SGMII".
> > 
> > However, in the kernel code, we use "SGMII" exclusively to mean Cisco
> > SGMII.
> 
> I use the terms SGMII and 1000BASEX just like in Linux driver where there
> are PHY_INTERFACE_MODE_SGMII and PHY_INTERFACE_MODE_1000BASEX, and it is
> also how the SGMII module operates where there are two register settings
> to use on these modes.

Useful to know, but its not always clear when discussing.

> What is confusing is how to call the SFPs using which mode.
> 
> All the fiber transceivers like 1000Base-SX and 1000Base-LX operate in
> 1000BASEX mode.

I already know this.

> All 10/100/1000Base-T SFPs I tested operate in SGMII mode.
> All 1000Base-T SFPs with RJ45 connector operate in 1000BASEX mode at the
> beginning.  If a PHY is found inside (typically Marvell) that PHY driver
> can change the mode to SGMII.  If that PHY driver is forced to not change
> it to SGMII mode then 1000BASEX mode can still be used.

I already know this.

> The major difference between 1000BASEX and SGMII modes in KSZ9477 is
> there are link up and link down interrupts in SGMII mode but only link up
> interrupt in 1000BASEX mode.  The phylink code can use the SFP cage logic
> to detect the fiber cable is unplugged and say the link is down, so that
> may be why the implementation behaves like that, but that does not work
> for 1000Base-T SFP that operates in 1000BASEX mode.

At this point, given all the discussion that has occurred, I'm really
not sure how to take "only link up in 1000base-X mode" - whether you're
talking about using 1000base-X with the other side operating in Cisco
SGMII mode or whether you're talking about e.g. a fibre link.

So I'm going to say it clearly: never operate the link with dis-similar
negotiation protocols. Don't operate the link with 1000base-X at one end
and Cisco SGMII at the other end. It's wrong. It's incorrect. The
configuration words are different formats. The interpretation of the
configuration words are different. Don't do it. Am I clear?

If it's still that 1000base-X mode to another 1000base-X partner doesn't
generate a link-down interrupt, then you will have no option but to use
phylink's polling mode for all protocols with this version of XPCS.

> > Hang on one moment... I think we're going off to another problem.
> > 
> > For 1000base-X, we do use phylink_mii_c22_pcs_encode_advertisement()
> > which will generate the advertisement word for 1000base-X.
> > 
> > For Cisco SGMII, it will generate the tx_config word for a MAC-side
> > setup (which is basically the fixed 0x4001 value.) From what I read
> > in KSZ9477, this value would be unsuitable for a case where the
> > following register values are:
> > 
> >         DW_VR_MII_PCS_MODE_C37_SGMII set
> >         DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII set
> >         DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL clear
> > 
> > meaning that we're generating a SGMII PHY-side word indicating the
> > parameters to be used from the registers rather than hardware signals.
> > 
> > > > The default value of this register is 0x20.  This update
> > > > depends on SFP.  So far I did not find a SGMII SFP that requires this
> > > > setting.  This issue is more like the hardware did not set the default
> > > > value properly.  As I said, the SGMII port works with SGMII SFP after
> > > > power up without programming anything.
> 
> TX_CONFIG_PHY_SIDE_SGMII is never set for C37_SGMII mode.
> Again I am not sure how this problem can be triggered.  I was just told
> to set this value.  And a different chip with new IP has this value by
> default.

I'm at a loss to work out how to respond to this. You've cut the
context to which I was replying to, and instead included following
context. Confused.

> > > > I am always confused by the master/slave - phy/mac nature of the SFP.
> > > > The hardware designers seem to think the SGMII module is acting as a
> > > > master then the slave is on the other side, like physically outside the
> > > > chip.  I generally think of the slave is inside the SFP, as every board
> > > > is programmed that way.
> > 
> > I think you're getting confused by microchip terminology.
> > 
> > Cisco SGMII is an asymmetric protocol. Cisco invented it as a way of:
> > 1. supporting 10M and 100M speeds over a single data pair in each
> >    direction.
> > 2. sending the parameters of that link from the PHY to the MAC/PCS over
> >    that single data pair.
> > 
> > They took the IEEE 1000base-X specification as a basis (which is
> > symmetric negotiation via a 16-bit word).
> > 
> > The Cisco SGMII configuration word from the PHY to the PCS/MAC
> > contains:
> > 
> >         bit 15 - link status
> >         bit 14 - (reserved for AN acknowledge as per 1000base-X)
> >         bit 13 - reserved (zero)
> >         bit 12 - duplex mode
> >         bit 11, 10 - speed
> >         bits 9..1 - reserved (zero)
> >         bit 0 - set to 1
> > 
> > This is "PHY" mode, or in Microchip parlence "master" mode - because
> > the PHY is dictating what the other end should be doing.
> > 
> > When the PCS/MAC receives this, the PCS/MAC is expected to respond
> > with a configuration word containing:
> > 
> >         bit 15 - zero
> >         bit 14 - set to 1 (indicating acknowledge)
> >         bit 13..1 - zero
> >         bit 0 - set to 1
> > 
> > This is MAC mode, or in Microchip parlence "slave" mode - because the
> > MAC is being told what it should do.
> > 
> > So, for a Cisco SGMII link with a SFP module which has a PHY embedded
> > inside, you definitely want to be using MAC mode, because the PHY on
> > the SFP module will be dictating the speed and duplex to the components
> > outside of the SFP - in other words the PCS and MAC.
> 
> I do not know the internal working in the SGMII module where the
> registers may have incorrect values.  I only verify the SGMII port is
> working by sending and receiving traffic after changing some registers.

The information I've provided is to aid you in understanding "master" and
"slave" mode SGMII. I'm trying to educate you. I'm not questioning
register values or anything like that. I'm giving you information to aid
your understanding of SGMII.

> > > > There are some SFPs
> > > > that will use only 1000BaseX mode.  I wonder why the SFP manufacturers do
> > > > that.  It seems the PHY access is also not reliable as some registers
> > > > always have 0xff value in lower part of the 16-bit value.  That may be
> > > > the reason that there is a special Marvell PHY id just for Finisar.
> > 
> > I don't have any modules that have a Finisar PHY rather than a Marvell
> > PHY. I wonder if the problem is that the Finisar module doesn't like
> > multi-byte I2C accesses to the PHY.
> > 
> > Another thing - make sure that the I2C bus to the SFP cage is running
> > at 100kHz, not 400kHz.
> 
> What I meant is this Marvell PHY ID 0x01ff0cc0.  Basically it is
> 0x01410cc0 for Marvell 88E1111 with 0x41 replaced with 0xff.  Some
> registers like the status register even has 0xff value all the time so
> the PHY can never report the link is down.

Which module does this happen with, and is it still available to buy
(can I get one to test with?)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

