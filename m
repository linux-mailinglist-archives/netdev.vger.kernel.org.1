Return-Path: <netdev+bounces-161610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4B9A22B18
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 10:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58337163E83
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5142F1B85F6;
	Thu, 30 Jan 2025 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VRFRmuXS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CABB1B982E;
	Thu, 30 Jan 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231172; cv=none; b=g29euFU5S3AvO/Qh4kkD6gs/qOcXTpJMqJnE58Y6YIM+IxExL3FfO3aIDWTnsDOiSkAED9Rew2xufL95vv4/mLHM1QWYEvjhWa61t+2kbDDQCq82tuzG8hEfNh65HeDjAyfJ78rhr3hSzxEo6pIhMYiGhAdztPY8pe7gi+x4sAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231172; c=relaxed/simple;
	bh=oq24UHMaPmGCo5HlfeS2N50Nmm5122a0qZ9LgL1yOtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9Lk9hDQ8tgiIIovZr3X+E+AHH/mD04sXy7BTdlus14Qq4YxQi+sM8ZtddlEI2B//mAYxgGVITfYQYmo7I9ZwCqu65EKIG40GStw5nqJnaGn3eMchr7kUYOkEcb0VP+tSmQfsADGV53GacpwFjq6REliXrDL7LcgDwGwgK5di/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VRFRmuXS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Xq/dbKn2cqYFDFkwa2MlzXwxzo24l5ayOV+fVmFP4tU=; b=VRFRmuXSXlO6pk86fKSPvuFsHB
	YAUCH6S+xPl1ceL1/oKT7I9KkZjQzYdbNJqQTuMsqu0WgBPyz/DDgWe41gxtZF38HGrsaNKuD7wPH
	Pw7mxEzf9BzHoeCVhioHPK88d+FjhhCKmS0pPspnCAlukAvFQ6EcsegoB9aCXNHi8v1WoUpggwVPO
	5lUF6BKAC0OVzn3XkUdA1GvAiSN+rJVBj1A3sg4Xy4LdOZGjl0XVz1f//yeT6v4cdbGtoDdBB1oro
	gvDZ7acSK4ClliyBnO1WnwSTO161NbihSz8dv5UFaVlOib1g4JzR6/To4YrSJc4dsQi37VMBZj2cW
	PVHqqZSg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36802)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tdRKO-0003mS-2w;
	Thu, 30 Jan 2025 09:59:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tdRKK-0004eo-1x;
	Thu, 30 Jan 2025 09:59:12 +0000
Date: Thu, 30 Jan 2025 09:59:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: olteanv@gmail.com, Woojung.Huh@microchip.com, andrew@lunn.ch,
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <Z5tNcNINk1CMDBeo@shell.armlinux.org.uk>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <DM3PR11MB87365B3AD3C360B0EF0432F3ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB87365B3AD3C360B0EF0432F3ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 30, 2025 at 04:50:14AM +0000, Tristram.Ha@microchip.com wrote:
> > On Wed, Jan 29, 2025 at 12:31:09AM +0000, Tristram.Ha@microchip.com wrote:
> > > The default value of DW_VR_MII_AN_CTRL is DW_VR_MII_PCS_MODE_C37_SGMII
> > > (0x04).  When a SGMII SFP is used the SGMII port works without any
> > > programming.  So for example network communication can be done in U-Boot
> > > through the SGMII port.  When a 1000BaseX SFP is used that register needs
> > > to be programmed (DW_VR_MII_SGMII_LINK_STS |
> > > DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII |
> > DW_VR_MII_PCS_MODE_C37_1000BASEX)
> > > (0x18) for it to work.
> > 
> > Can it be that DW_VR_MII_PCS_MODE_C37_1000BASEX is the important setting
> > when writing 0x18, and the rest is just irrelevant and bogus? If not,
> > could you please explain what is the role of DW_VR_MII_SGMII_LINK_STS |
> > DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII for 1000Base-X? The XPCS data book
> > does not suggest they would be considered for 1000Base-X operation. Are
> > you suggesting for KSZ9477 that is different? If so, please back that
> > statement up.
> 
> As I mentioned before, the IP used in KSZ9477 is old and so may not match
> the behavior in current DesignWare specifications.  I experimented with
> different settings and observed these behaviors.
> 
> DW_VR_MII_DIG_CTRL1 has default value 0x2200.  Setting MAC_AUTO_SW (9)
> has no effect as the value read back does not retain the bit.  Setting
> PHY_MODE_CTRL (0) retains the bit but does not seem to have any effect
> and it is not required for operation.  So we can ignore this register
> for KSZ9477.

So the value of 0x2200 for DIG_CTRL1 means that bits 13 and 9 are both
set, which are the EN_VSMMD1 and MAC_AUTO_SW bits. So, are you saying
that MAC_AUTO_SW can't be cleared in KSZ9477? This is key information
that we need.

PHY_MODE_CTRL only has an effect when:
	DW_VR_MII_PCS_MODE_C37_SGMII
	DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII
are both set.

are set, and it determines the source for the bits in the configuration
word to be sent to the _MAC_ (since XPCS is acting as a PHY with both
these bits set.) 

> DW_VR_MII_AN_CTRL has default value 0x0004, which means C37_SGMII is
> enabled.  Plugging in a 10/100/1000Base-T SFP will work without doing
> anything.
> 
> Setting TX_CONFIG_PHY_SIDE_SGMII (3) requires auto-negotiation to be
> disabled in MII_BMCR for the port to work.

If you have a SFP plugged in, then setting PHY-side on the XPCS is
wrong. TX_CONFIG_MAC_SIDE_SGMII should be used, and thus PHY_MODE_CTRL
is irrelevant as we are not generating a PHY-side Cisco SGMII config
word (as I detailed when I described the Cisco SGMII config words which
are asymmetric in nature.)

> SGMII_LINK_STS (4) depends on TX_CONFIG_PHY_SIDE_SGMII.  If that bit is
> not set then this bit has no effect.  The result of setting this bit is
> auto-negotiation can be enabled in MII_BMCR.

"that bit" and "this bit" makes this difficult to follow as I'm not
sure which of SGMII_LINK_STS or TX_CONFIG_PHY_SIDE_SGMII that "this"
and "that" are referring to. Please be explicit to avoid confusion.

Since in later documentation, SGMII_LINK_STS is used to populate bit
15 of the Cisco SGMII configuration word when operating in PHY mode
when these bits are set:

	TX_CONFIG_PHY_SIDE_SGMII
	PHY_MODE_CTRL

then, as PHY_MODE_CTRL is not supported by your hardware (it's marked
as reserved) I suggest that this older version of XPCS either has this
PHY_MODE_CTRL as an integration-time option, or the logic of taking
the values from registers was not implemented in that revision. Thus
why it only depends on TX_CONFIG_PHY_SIDE_SGMII in your case.

> So C37_SGMII mode can still work with TX_CONFIG_PHY_SIDE_SGMII on and
> auto-negotiation disabled.

That's because if the XPCS acts as a PHY and is talking to another PHY,
the only then that the remote PHY (in the SFP module) is looking for is
an acknowledgement (bit 14 set.) It's possible that XPCS does this
despite operating as a PHY. However, there is another (remote)
possibility.

> But the problem is when the cable is
> unplugged and plugged the port does not work as the module cannot detect
> the link.  Enabling auto-negotiation and then disabling it will cause
> the port to work again.

... because the XPCS is operating in the wrong mode, and when operating
as a PHY does not expect the other end "the MAC" to be signalling link
status to it. One end of a Cisco SGMII link must operate as a PHY and
the other end must operate as a MAC to be correct. Other configurations
may sort-of work but are incorrect to the Cisco SGMII documentation.

> Now for 1000BaseX mode C37_1000BASEX is used and when auto-negotiation
> is disabled the port works.

There's something which can complicate "works" - some implementations
have a "bypass" mode for negotiation. If they only receive idles
without any sign of negotiation, after a timeout expires, they enter
"bypass" mode and bring the data link up anyway.

> For the XPCS driver this can be done by setting neg_mode to false at
> the beginning. Problem is this flag can > only be set once at driver
> initialization.

Sigh. So you are referring to struct phylink_pcs's boolean neg_mode
member here, and fiddling with that is _wrong_. This flag is a
property of the driver code. It's "this driver code wants to see the
PHYLINK_PCS_NEG_* constants passed into its functions" when set,
as opposed to the MLO_AN_* constants that legacy drivers had. This
flag _must_ match the driver. It is _not_ to be fiddled with depending
on IP versions or other crap like that. It's purely about the code in
the driver. Do not touch this boolean. Do not change it in the XPCS
driver. It is correct. Setting it to false is incorrect. Am I clear?

> So for 1000BaseX mode TX_CONFIG_PHY_SIDE_SGMII can be turned on and then
> SGMII_LINK_STS allows auto-negotiation to be enabled all the time for
> both SGMII and 1000BaseX modes to work.
> 
> C37_SGMII working:
> 
> Auto-negotiation enabled
> 
> Auto-negotiation disabled
> TX_CONFIG_PHY_SIDE_SGMII on
> (stop working after cable is unplugged and re-plugged)
> 
> C37_1000BASEX working:
> 
> Auto-negotiation disabled
> 
> Auto-negotiation disabled
> TX_CONFIG_PHY_SIDE_SGMII on
> 
> Auto-negotiation enabled
> TX_CONFIG_PHY_SIDE_SGMII on
> SGMII_LINK_STS on
> 
> Note this behavior for 1000BaseX mode only occurs in KSZ9477, so we can
> stop finding the reasons with current specs.

Right, and its as documented in the KSZ9477 documentation. 1000base-X
mode requires TX_CONFIG_PHY_SIDE_SGMII and SGMII_LINK_STS. Likely
because of the older IP version.

Let me get back to what I said in my previous email - but word it
differently:

   Can we think that setting both TX_CONFIG_PHY_SIDE_SGMII and
   SGMII_LINK_STS unconditionally in the 1000base-X path with will
   not have any deterimental effects on newer IP versions?

> Microchip has another chip with newer IP version that does not have this
> behavior for 1000BaseX mode.  That is, it does not require
> auto-negotiation to be disabled for the port to work.  However, that chip
> has major issues when using 2.5G mode so I do not know how reliable it is
> when using 1G mode.

I think we're getting mixed up here. I think you've said that:

In Cisco SGMII mode, setting MAC mode with AN enabled works.
In 1000base-X mode, setting both TX_CONFIG_PHY_SIDE_SGMII and
SGMII_LINK_STS with AN enabled works.

To me, this seems to be the right configuration. The problem all along
that Vladimir has been trying to get to the bottom of is why you need
TX_CONFIG_PHY_SIDE_SGMII and SGMII_LINK_STS set in 1000base-X mode,
and the answer to that is: KSZ9477 documentation for an older XPCS IP
version states that this is necessary.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

