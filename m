Return-Path: <netdev+bounces-94235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4D38BEAF6
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222A228268A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816B216C864;
	Tue,  7 May 2024 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uFT5Pj6i"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3C16C84E;
	Tue,  7 May 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104630; cv=none; b=UupR/yITElx0z5pG/Jyi3VEzI1dxh3z4IllnvZ+1iVj1EUUJE8vhoDpgTxBp8jG+SBCMUKAy2yGe5d2H4H62TLQtiEZX3Di5/Q3wiX7TRmu5U0v9rxFIAI+ENPw6bd8EbQPUilm2d7nKZFmo10I541UcKTFAAJHAOjpwWKmUo+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104630; c=relaxed/simple;
	bh=r10QfMSDmh85E+Oesb+yGZtr7oLwmQ4ppUfBKTBED/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf+XCbRhl93QHxqjX6hfdLOhpffJpaNlbAgjaxmEYe3z0sKIJrXt94V3/KyvoVPoiujoJGx+5oY+EE9G6xn1MrIlQspGyGIi0wa9+kMPYmrmjgyn18M3o1u1NoF4YrtJ30RjOnBY3L1lgyedbTU/ELSrpPLk2j0HjjMFjzm5pYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uFT5Pj6i; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aha/0e4Br4Rhm5frPp17CLqnlYgVg7Rrr8RUbo7VEZg=; b=uFT5Pj6itZA2g5wou/p8YZG8B9
	ohZOhRHeF6Hwcv5kg+tSIXvUG3wXFVmFlTUnn1TQhc+CxNPoI+6GAe7F4NMHNj9mX/XsVWo4oCvIS
	kgeOgZWEhjjPeLv178lWHwM+1cMx5bbdof2VyKoh75p0BpbAMTI2eTXezSRl1KrVz4LaZZnOKOeU/
	2zbCf7lIwzGvob60u6zdxwT6GrgvGqgs9UxiR5j5zUI0PHFEttV8MIamG7Y0mveXwmMlerpzCRCqs
	CDMUQHBwh2HqnXA25GoYj+JzQ4kFvBuK9rG78m6aAy5atEbAhuJTrV7UMdjTndV0iInBrzr0KZmJ/
	Cd0QvUfw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54408)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s4P3h-00046z-0B;
	Tue, 07 May 2024 18:56:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s4P3f-0000Vg-2V; Tue, 07 May 2024 18:56:55 +0100
Date: Tue, 7 May 2024 18:56:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ronnie.Kunin@microchip.com
Cc: Raju.Lakkaraju@microchip.com, andrew@lunn.ch, netdev@vger.kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next] net: phy: add wol config options in phy device
Message-ID: <ZjprZjKfewKRqRJL@shell.armlinux.org.uk>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
 <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
 <ZjO4VrYR+FCGMMSp@shell.armlinux.org.uk>
 <ZjoAd2vsiqGhCVCv@HYD-DK-UNGSW21.microchip.com>
 <ZjoWSJNS0BbeySuQ@shell.armlinux.org.uk>
 <PH8PR11MB79658C7D202D67EEDDBD861495E42@PH8PR11MB7965.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH8PR11MB79658C7D202D67EEDDBD861495E42@PH8PR11MB7965.namprd11.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 07, 2024 at 04:18:27PM +0000, Ronnie.Kunin@microchip.com wrote:
> > So you want the MAC driver to access your new phydev->wolopts. What if there isn't a PHY, or the PHY
> > is on a pluggable module (e.g. SFP.) No, you don't want to have phylib tracking this for the MAC. The
> > MAC needs to track this itself if required.
> 
> There is definite value to having the phy be able to effectively
> communicate which specific wol events it currently has enabled so the
> mac driver can make better decisions on what to enable or not in the
> mac hardware (which of course will lead to more efficient power
> management). While not really needed for the purpose of fixing this
> driver's bugs, Raju's proposed addition of a wolopts tracking variable
> to phydev was also providing a direct way to access that information.
> In the current patch Raju is working on, the first call the lan743x
> mac driver does in its set_wol() function is to call the phy's
> set_wol() so that it gives the phy priority in wol handling. I guess
> when you say that phylib does not need to track this by adding a
> wolops member to the phydev structure, if we need that information
> the alternative way is to just immediately call the phy's get_wol()
> after set_wol() returns, correct ?

Depends what the driver wants to do.

From the subset of drivers that implement WoL and use phylib:

drivers/net/ethernet/socionext/sni_ave.c:
	ave_init()
	ave_suspend() - to save the wolopts from the PHY
	ave_resume() - to restore them to the PHY - so presumably
		working around a buggy PHY driver, but no idea which
		PHY driver because although it uses DT, there's no way
		to know from DT which PHYs get used on this platform.

drivers/net/ethernet/ti/cpsw_ethtool.c:
	does nothing more than forwarding the set_wol()/get_wol()
	ethtool calls to phylib.

drivers/net/ethernet/freescale/enetc/enetc_ethtool.c:
	enetc_set_wol() merely sets the device for wakeup as appropriate
	based on the wolopts after passing it to phylib.

drivers/net/ethernet/microchip/lan743x_ethtool.c:
	lan743x_ethtool_set_wol() tracks the wolopts *before* passing
	to phylib, and enables the device for wakeup as appropriate.
	The whole:
	"return netdev->phydev ? phy_ethtool_set_wol(netdev->phydev, wol)
                        : -ENETDOWN;"
	thing at the end is buggy. You're updating the adapters state
	and the device wakeup enable, _then_ checking whether we have a
	phydev. If we don't have a phydev, you're then telling userspace
	that the request to change the WoL settings failed but you've
	already changed your configuration!

	Moreover, looking at lan743x_ethtool_get_wol(), you set
	WAKE_MAGIC | WAKE_PHY irrespective of what the PHY actually
	supports. This makes a total nonsense of the purpose of the
	supported flags here.

	I guess the _reason_ you do this is because the PHY may not be
	present (because you look it up in the .ndo_open() method) and
	thus you're trying to work around that... but then set_wol()
	fails in that instance. This all seems crazy.

	Broadcom bcmgenet also connects to the PHY in .ndo_open() and
	has sane semantics for .get_wol/.set_wol. I'd suggest having
	a look at that driver...

drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c:
	bcmgenet_set_wol() saves the value of wolopts in its
	private data structure and bcmgenet_wol_power_down_cfg()/
	bcmgenet_wol_power_up_cfg() uses this to decide what to
	power down/up.

Now, let's look at what ethtool already does for us when attempting
a set_wol() peration.

1. It retrieves the current WoL configuration from the netdev into
   'wol'.
2. It modifies wol.wolopts according to the users request.
3. It validates that the options set in wol.wolopts do _not_ include
   anything that is not reported as supported (in other words, no
   bits are set that aren't in wol.supported.)
4. It deals with the WoL SecureOn™ password.
5. It calls the netdev to set the new configuration.
6. If successful, it updates the netdev's flag which indicates whether
   WoL is currently enabled _in some form_ for this netdev.

Ergo, network device drivers are *not* supposed to report modes in
wol.supported that they do not support, and thus a network driver
can be assured that wol.wolopts will not contain any modes that are
not supported.

Therefore, if a network device wishes to track which WoL modes are
currently enabled, it can do this simply by:

1. calling phy_ethtool_set_wol(), and if that call is successful, then
2. save the value of wol.wolopts to its own private data structure to
   determine what it needs to do at suspend/resume.

This should be independent of which modes the PHY supports, because the
etwork driver should be using phy_ethtool_get_wol() to retrieve the
modes which the PHY supports, and then augmenting the wol.supported
mask with whatever additional modes the network driver supports
beyond that.

So, there is no real need for a network driver to query phylib for the
current configuration except possibly during probe or when connecting
to its PHY.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

