Return-Path: <netdev+bounces-114130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06494107B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91ADE1F25E4C
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0154D19DF7A;
	Tue, 30 Jul 2024 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WG4o4ScU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454AB19DF8E;
	Tue, 30 Jul 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338977; cv=none; b=APS15u4KbrxbZvnK4grV6EG3/z1PI6FCHxlPrWmSlaOlj8fPyooc6SqdXoJBtVDZiM24V6hgdO+26bWUGxYhjbYEuQ+4upolTbJrK8CEIxtPk0AMyUP11CJLhOJbtG4kFEcFMrp5YTjOoohSlJ/ObZdyf4FaeOMfdIkhOT77ZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338977; c=relaxed/simple;
	bh=/1pWOQ14ozSfFQK/tkD76Lfh3dTPGMLPwzHVYx5iXcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3Ls+0jHmMxAslpsqNn4255Gm2BKVnxz2aI9/f0gviLoB7SKOZI+xfCQMBaHQ8jbJn267en7pOu/pu21jb6xm4jSrw3bEdqNvQqZbgha/KCNxh+yUVyPAJiIDUzzc1bMUKEF/14MDwPvvB2DcItyx4lcK66zkDGO4hnkJVuv6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WG4o4ScU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ki2/TBdxrP8a5ktzFO1CppFcT6yCDwCNmjbPTgHYyOU=; b=WG4o4ScUMxSc7o8zseeiqpQR2R
	A5QrjYcAfq5DmnxWbzcz+pmsorwKH6DTRKFGM+XxCU4pv73wLY5s/MNYX/6OTD0+LSTEUnbYqxuO/
	+w1p80cOCofWLFSvNTVOvO+PstkZ5piTrHRQtW3zziwgsHRv4K1pgfQ/7yGHG+D0kBaG9XuvR4xjC
	hfT7/fl+0mbNdihbOo66oSdQXXgZivTF94hhTuN4lmg87zxxaz7XSUXHsQ1AtsUhSuB0tUdXgpgpE
	YV2dx/0JH5IPlJcVZDT+G+i5ypiuawUr34nwKWlZKHlvdCK1tNLHSa+6CbxCuWkuJltgxtjXpzOsw
	t+9YcbIA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55588)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYl2k-0006Zg-07;
	Tue, 30 Jul 2024 12:29:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYl2m-0005EG-Mh; Tue, 30 Jul 2024 12:29:28 +0100
Date: Tue, 30 Jul 2024 12:29:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew@lunn.ch, horms@kernel.org, hkallweit1@gmail.com,
	richardcochran@gmail.com, rdunlap@infradead.org,
	bryan.whitehead@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V2 3/4] net: lan743x: Migrate phylib to phylink
Message-ID: <ZqjOmOzNLE0+oYP2@shell.armlinux.org.uk>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
 <20240716113349.25527-4-Raju.Lakkaraju@microchip.com>
 <Zqdd1mfSUDK9EifJ@shell.armlinux.org.uk>
 <ZqjE9A8laPxYP1ta@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqjE9A8laPxYP1ta@HYD-DK-UNGSW21.microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 30, 2024 at 04:18:20PM +0530, Raju Lakkaraju wrote:
> Ok. 
> After change, i ran the checkpatch script. it's giving follwoing warning
> i.e.
> "CHECK: Comparison to NULL could be written "dn"" 
> 
> Is it OK ?

Assuming its referring to:

        return dn != NULL;

in a function that returns a bool, I find that utterly perverse, and I
suggest in this case ignoring checkpatch.

> > > +static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
> > > +{
> > > +     struct device_node *dn = adapter->pdev->dev.of_node;
> > > +     struct net_device *dev = adapter->netdev;
> > > +     struct fixed_phy_status fphy_status = {
> > > +             .link = 1,
> > > +             .speed = SPEED_1000,
> > > +             .duplex = DUPLEX_FULL,
> > > +     };
> > > +     struct phy_device *phydev;
> > > +     int ret;
> > > +
> > > +     if (dn)
> > > +             ret = phylink_of_phy_connect(adapter->phylink, dn, 0);
> > > +
> > > +     if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
> > > +             phydev = phy_find_first(adapter->mdiobus);
> > > +             if (!phydev) {
> > > +                     if (((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
> > > +                           ID_REV_ID_LAN7431_) || adapter->is_pci11x1x) {
> > > +                             phydev = fixed_phy_register(PHY_POLL,
> > > +                                                         &fphy_status,
> > > +                                                         NULL);
> > > +                             if (IS_ERR(phydev)) {
> > > +                                     netdev_err(dev, "No PHY/fixed_PHY found\n");
> > > +                                     return PTR_ERR(phydev);
> > > +                             }
> > 
> > Eww. Given that phylink has its own internal fixed-PHY support, can we
> > not find some way to avoid the legacy fixed-PHY usage here?
> 
> Yes. I agree with you. This is very much valid suggestion.
> Andrew also gave same suggestion.
> 
> Currently we don't have Device Tree support for LAN743X driver. 
> For SFP support, I create the software-node an passing the paramters there.
> 
> I don't have fixed-PHY hardware setup currently.
> I would like to take this as action item to fix it after SFP support commits.

Note that SFP shouldn't be using a fixed-phy at all.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

