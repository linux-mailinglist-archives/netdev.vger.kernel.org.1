Return-Path: <netdev+bounces-173464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D2EA59106
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70D03A98BA
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBE222652D;
	Mon, 10 Mar 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="19FPdQbR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC82B9A7;
	Mon, 10 Mar 2025 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602212; cv=none; b=aggZy9nGZEYAkUu0gUFE3caFrEAp7IwDz5bLs1YSUlmFBIwMzXdb0x3nciyAEvuZcQbeSERAUFNWmt6mdVIbTtcduRstCl6JBUvXFhn5OF/o+YIANQa2Ept/7uZfOYkb5jcmHmHoFB3cuOt+nWfqLesUv+4GGeKUc+vNfvF4kNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602212; c=relaxed/simple;
	bh=Qm494IXouHJfzxVJIxXKepFKziCY8+8LovLWpSX5aG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVI7mMYbzfAHQOSXdM95+2sdeRwzDGntK8j1n15QoRprdveabCBT/9rFB6N2Ni0rMk6AAEmBLuh4KvDfnxtmCj5/Q98dJv5uBuPS5ki2u8A2ayxKM+YsS2kpU3hYkCFsP2CuVtfHh30w+JQvTlv71ulrSsfUR9jVojM/kX78GMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=19FPdQbR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GitiaqC7LjmHhDKtZ+LDT+LSsI6ZPHCbODuJvW3+aF0=; b=19FPdQbRnN9Jvw1POiDkVJOB0v
	YB86PWZU7kFxe3RrkNVVn0PNUpmrAUM02ZlKglf7RIm4tqbPCjh/mwTB6zsV+rGs4Ze2cj0MK59+D
	QwdnWo0b6ZSof5gOXKK9bYPRDnKlnEHdw4kEqBIQuqJ5BxmgbfNExHWYFAMw/RXLHogUafQE2iq3u
	ADJVIHoCgg3a5jNd0TOmB7vJH6hWrRDMV7McAj6bnME5nhCoCJ2djBfDdv4VhGanqwXK3ERi7VxLv
	oig/NWJEuWAp+iWDPPq4Xv4s6mZU8DaAzGTBTW98i233NRB6P8prplhEWo5X06Xyl5lwJee8dKMTa
	6vPoZWZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51298)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1traI4-0002Ni-2i;
	Mon, 10 Mar 2025 10:23:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1traI3-0002Nt-0x;
	Mon, 10 Mar 2025 10:23:19 +0000
Date: Mon, 10 Mar 2025 10:23:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thangaraj.S@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	Rengarajan.S@microchip.com, Woojung.Huh@microchip.com,
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	phil@raspberrypi.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 1/7] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <Z869l9q5tXj6Fcjl@shell.armlinux.org.uk>
References: <20250307182432.1976273-1-o.rempel@pengutronix.de>
 <20250307182432.1976273-2-o.rempel@pengutronix.de>
 <1bb51aad80be4bb5e0413089e1b1bf747db4e123.camel@microchip.com>
 <Z863zsYNM8hkfB19@pengutronix.de>
 <Z8660bKssi3rX_ny@shell.armlinux.org.uk>
 <Z8676rcaq6h4X8To@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8676rcaq6h4X8To@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 10, 2025 at 11:16:10AM +0100, Oleksij Rempel wrote:
> On Mon, Mar 10, 2025 at 10:11:29AM +0000, Russell King (Oracle) wrote:
> > On Mon, Mar 10, 2025 at 10:58:38AM +0100, Oleksij Rempel wrote:
> > > Hi Thangaraj,
> > > 
> > > On Mon, Mar 10, 2025 at 09:29:45AM +0000, Thangaraj.S@microchip.com wrote:
> > > > > -       mii_adv_to_linkmode_adv_t(fc, mii_adv);
> > > > > -       linkmode_or(phydev->advertising, fc, phydev->advertising);
> > > > > +       phy_suspend(phydev);
> > > > > 
> > > > 
> > > > Why phy_suspend called in the init? Is there any specific reason?
> > > 
> > > In my tests with EVB-LAN7801-EDS, the attached PHY stayed UP in initial
> > > state.
> > 
> > Why is that an issue?
> 
> The local interface was in the administrative DOWN state, but link was up:
> - port LEDs are on
> - link partner sees the link is UP.
> 
> It is not a big deal, but for me it looks inconsistent.

That's not an uncommon situation.

Given that the link was up for a period of time before the driver
probes, taking it down on probe, only to then have userspace then
bring the interface up and have to wait for negotiation to complete
slows down the interface initialisation.

As for the link partner, in such a situation the link partner can't
assume that this end is up _anyway_ because the link will be up
before the driver has probed.

So, I don't see the point of forcing the link down on probe.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

