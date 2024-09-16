Return-Path: <netdev+bounces-128582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5016497A75E
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 20:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6770D1C234E3
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2CE43ADE;
	Mon, 16 Sep 2024 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jt6bRMeb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAF539FC1;
	Mon, 16 Sep 2024 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512075; cv=none; b=rC1fP8hkqSIuzxcwIOd2VsRqWKvy8AAoNRmZU2QJE2FxQY3gVljJVSF/Ar0ZTZbcv9lI3ijbW6/nvPJ8ZcEi3CENa0AoNptGy8zY9LYHdODyTjkVyG4lL55QOA/fi78JpZ2IrP57+38WJxprr1dRDcHZHZ6zy4IhXnrK0nH4jLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512075; c=relaxed/simple;
	bh=XpdhDl2amKTsW7cX44kPhzF8ygCTl7YLSEjyonexzFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6FoiX4cC7yelkTyO04wz4ureqYyZWlWt7thoNBaE2DqWkuSKtDflG4aa79hfn8dSISc3ek79X/ygNPZXVCkKRMQX7wcEBDciImRxtUYPxqiYsxOScGL20PZ6v54P9Hydge6/pbzYkmJlMBFXnMj85LP7PwPUfdCRXnXFXD4VoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Jt6bRMeb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2zkhXVqbGItk7W+miVPkM8oZ60eORRfKMCD7sTnjBZY=; b=Jt6bRMebc4csHFW4Fch7g0enFv
	JQdTCFqUhwqhciFkJj5f284FDwV2m7+0HoccVYWLomP+Qsak9QVpAfpWLEI8haRAiq6X213Zb7ZVC
	L0KEngX06zrcZoZ9etfMvZOR78rzZ0NcLYD7paMvaZ5TUOslQRsxYUHqG0mkq4p1FCx5YZYXmdU8P
	sPINfb4tgWM+Pma4Kw6vJqWHM3NPViO669z7TM147JIl5laz9ZTJ78EpaUjYSO7DscaE2HeIRosz6
	IUi+pNHoJadF3cDs9h2atVBBR+GfPl0V6udlOKiIRjYFbCcM6yOt3PeEPtZmootaEHucQWJBkqK1W
	70XXxHjA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34824)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqGer-0006I3-2M;
	Mon, 16 Sep 2024 19:41:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqGeo-0007CQ-0y;
	Mon, 16 Sep 2024 19:41:06 +0100
Date: Mon, 16 Sep 2024 19:41:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ronnie.Kunin@microchip.com, Raju.Lakkaraju@microchip.com,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Bryan.Whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, maxime.chevallier@bootlin.com,
	rdunlap@infradead.org, Steen.Hegelund@microchip.com,
	Daniel.Machon@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
Message-ID: <Zuh7wtfajqRWoAFs@shell.armlinux.org.uk>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
 <a40de4e3-28a9-4628-960c-894b6c912229@lunn.ch>
 <ZuKKMIz2OuL8UbgS@HYD-DK-UNGSW21.microchip.com>
 <e5e4659c-a9e2-472b-957b-9eee80741ccf@lunn.ch>
 <PH8PR11MB7965848234A8DF14466E49C095642@PH8PR11MB7965.namprd11.prod.outlook.com>
 <ad0813aa-1a11-4a26-8bc7-528ef51cf0c2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad0813aa-1a11-4a26-8bc7-528ef51cf0c2@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 12, 2024 at 05:58:14PM +0200, Andrew Lunn wrote:
> > > > > > +     if (adapter->is_pci11x1x && !adapter->is_sgmii_en &&
> > > > > > +         adapter->is_sfp_support_en) {
> > > > > > +             netif_err(adapter, drv, adapter->netdev,
> > > > > > +                       "Invalid eeprom cfg: sfp enabled with sgmii disabled");
> > > > > > +             return -EINVAL;
> > > > >
> > > > > is_sgmii_en actually means PCS? An SFP might need 1000BaseX or
> > > > > SGMII,
> > > >
> > > > No, not really.
> > > > The PCI11010/PCI1414 chip can support either an RGMII interface or an
> > > > SGMII/1000Base-X/2500Base-X interface.
> > > 
> > > A generic name for SGMII/1000Base-X/2500Base-X would be PCS, or maybe SERDES. To me, is_sgmii_en
> > > means SGMII is enabled, but in fact it actually means SGMII/1000Base-X/2500Base-X is enabled. I just
> > > think this is badly named. It would be more understandable if it was is_pcs_en.
> > > 
> > > > According to the datasheet,
> > > > the "Strap Register (STRAP)" bit 6 is described as "SGMII_EN_STRAP"
> > > > Therefore, the flag is named "is_sgmii_en".
> > > 
> > > Just because the datasheet uses a bad name does not mean the driver has to also use it.
> > > 
> > >         Andrew
> > 
> > The hardware architect, who is a very bright guy (it's not me :-), just called the strap SGMII_EN in order not to make the name too long and to contrast it with the opposite polarity of the bit which means the interface is set to RGMII; but in the description of the strap he clearly stated what it is:
> > 	SGMII_EN_STRAP
> > 	0 = RGMII
> > 	1 = SGMII / 1000/2500BASE-X
> > 
> > I don't think PCS or Serdes (both of which get used in other technologies - some of which are also included in this chip and are therefore bound to create even more confusion if used) are good choices either.

While I can understand the desire to name stuff as documentation names
it, just because documentation calls an apple a banana does not mean
that everyone who doesn't have the documentation will understand that
is_a_banana will be true for an apple.

This is the problem here. SGMII has two meanings (and thanks to the
network industry for creating this in the first place).

First, there is Cisco SGMII, an adaptation of IEEE 802.3 1000base-X.
Secondly, there is its use as "Serial gigabit media independent
interface" which various manufacturers seem to use to refer to their
serial network interface supporting both Cisco SGMII, 1000base-X and
2500base-X.

_That_ is exactly where the problem is. "SGMII" is ambiguous. One can
not even use much in the way of context to separate out which it's
referring to, and naming a variable "is_sgmii_en" just doesn't have
the context. This ambiguous nature adds to the kernel maintenance
burden for those of us who look after subsystems.

It is unfortunate that people continue not to recognise this as the
problem that it is, but everyone loves acronyms... and acronyms are
a way of talking in code that excludes people from discussions or
understanding.

So, consider this a formal request _not_ to name your variable
"is_sgmii_en" but something else.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

