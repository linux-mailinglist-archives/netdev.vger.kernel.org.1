Return-Path: <netdev+bounces-177560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737D8A708FE
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4523B13CB
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16294199FB2;
	Tue, 25 Mar 2025 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XgMYmo0h"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D250190679;
	Tue, 25 Mar 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742927230; cv=none; b=DkbRliGYeGgrqgp7EX+2pssRHrTqo4yaJXAvyhhgNVSRTcZihHNSiPwmSWvlUt0fd6St/ADhjhhyWIrYWbPSKrFmRjgE2Se8xu4Gb+VXNOdnhc+rDAz42bkkStcanE9HKH0O1ch+aOEaD81d9vQ75MTc1O2bM9qPSS77geUfoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742927230; c=relaxed/simple;
	bh=MjWup5n1Y5trpMsv1vexhoBZtWDRpfEikOGRd6DqwfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9KYw1EuDI/WmZH7SAK42iqxndqYqWyCess1r8cEk7ie4U0kpCv4t9d9b1DrZmgdhvADaT6LFTmo18uQJJDPSAn/CHXEmtV02qPn1/agIlLQ+60694dbWeGR8KKiTIIK9RnmVAKaAaHNlRx4Foi/9bp5c3iTxPd9cf77Dsca5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XgMYmo0h; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i/lk6UFZQKBshnKZupy3heVh6FuisIDENlkWeAHkEnI=; b=XgMYmo0hpYdF/F0D39118bm6Rp
	jDXVSJOVPAYFhg5Poq4C7nV7R91plgMpSm6kIxyXGrtpUPGaAvhtXQgdnDHJDn0d+LGFXWWkXAczK
	3rVYUm+T1rbYnnmTF4zz1AjD8NX1yc8NrkBTv9GuNuM9u8rGiuhSf7r7rY6GhjZEI6MUqxqqNW6Dt
	gsrxfiRhrxBA7K2sHLSnYfqCUbnvK9omW6ftYa+b5YKDB1MlhzGlUuO7qhw6lNqOOX6AxEoUginKx
	WPrRSpoWKUZMyWK8HMScNQt7LTHWcDsNfG6E51gIvRQAAF1xWhBNwajL+lppOVVlVWySOxg1Zq4AK
	kemVmu1A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41044)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tx8zF-0005AJ-1Y;
	Tue, 25 Mar 2025 18:26:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tx8zC-0003Wj-1H;
	Tue, 25 Mar 2025 18:26:50 +0000
Date: Tue, 25 Mar 2025 18:26:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Rengarajan.S@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, Thangaraj.S@microchip.com,
	Woojung.Huh@microchip.com, pabeni@redhat.com,
	o.rempel@pengutronix.de, edumazet@google.com, kuba@kernel.org,
	phil@raspberrypi.org, kernel@pengutronix.de, horms@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v5 2/6] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <Z-L1ap2HNc7apxHd@shell.armlinux.org.uk>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
 <20250319084952.419051-3-o.rempel@pengutronix.de>
 <5de15da31f71e1bed8782375b402bcb5df2eb63a.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5de15da31f71e1bed8782375b402bcb5df2eb63a.camel@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 25, 2025 at 05:37:53PM +0000, Rengarajan.S@microchip.com wrote:
> Hi Oleksji,
> 
> On Wed, 2025-03-19 at 09:49 +0100, Oleksij Rempel wrote:
> >         udev = interface_to_usbdev(intf);
> >         net = dev->net;
> > 
> > +       rtnl_lock();
> > +       phylink_stop(dev->phylink);
> > +       phylink_disconnect_phy(dev->phylink);
> > +       rtnl_unlock();
> > +
> > +       netif_napi_del(&dev->napi);
> > +
> >         unregister_netdev(net);
> > 
> >         timer_shutdown_sync(&dev->stat_monitor);
> >         set_bit(EVENT_DEV_DISCONNECT, &dev->flags);
> >         cancel_delayed_work_sync(&dev->wq);
> > 
> > -       phydev = net->phydev;
> > -
> > -       phy_disconnect(net->phydev);
> > -
> > -       if (phy_is_pseudo_fixed_link(phydev)) {
> > -               fixed_phy_unregister(phydev);
> > -               phy_device_free(phydev);
> > -       }
> > +       phylink_destroy(dev->phylink);
> 
> Before destroying phylink here is it possible to add a check to make
> sure dev->phylink is allocated properly.

Not necessary.

How would dev->phylink not be "allocated properly" ?

If it isn't "allocated properly" then lan78xx_phylink_setup() will
return an error, which will cause lan78xx_probe() to fail. If the
probe function fails, then the driver won't be bound.

Having additional nonsense checks for things that shouldn't ever
happen is annying and detracts from code readability.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

