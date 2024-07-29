Return-Path: <netdev+bounces-113589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4093F316
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417831F22C67
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29E6144D16;
	Mon, 29 Jul 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GZ2fZMgx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9EC163;
	Mon, 29 Jul 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250054; cv=none; b=huiljgGDOKMjzfdX5rw2HNz7xMrQPWPgUNV6EMKxELND2lvBV5uzDa1MP1fWKfx5pBAyRIvvo6B4txYOqGse15ZOYE0YBJXEF6w/gHK3VnMO59BkBOkvYjg3VCXAtJMbvfICGvawP0AyDQI3DL95QO5i7UPTfIp+1sbhletKpcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250054; c=relaxed/simple;
	bh=7DZuWVwoT2/9BxU3q2pFtDwVaUZa9TXe5YZPwcZMr6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt8fRIBUV6AO0H4SZxhImkyQ6/tl6xVP1EtNTf4hBKObiMCuLpo/q2BpgVHE43McAYMuITPL3EY7e4FvtGFi5KSF9Mfx2b/7uZba6eWieyojghZpkvblc6mwYXI7AhyJl9U7grpuVvrbIeTAfZXcVEX7A9k+ejvuxO679TyJ4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GZ2fZMgx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S2bvKTS2ajQjVrvGH4NgM0T/qEj2eflm/tj2ydxLow8=; b=GZ2fZMgxXNc+oouKs5SmXdFCIn
	6mg0E34osSM43B5lRqX0h8WIbAMxzGRjMS+1QqwG/aDV3SFHdF7h2LGP2f0A3IVnOSlXfcxNRmzN8
	WWEOelIq4alkRBA2MkNAbz/4qY9oVNbTrhxN23UDI0FBnPZAhYJ7f2hwOMqAtR3oaFY/VvBjftAAF
	n4oeLlEJmjo2bg4NzpsDGKAw3/ZsfNtOe6OWQkRnt+cPiEFJ/qXD5Wya9YH3uMeYaEm3sWXmp3wNR
	MeapSKFQXS04OV/K9+ALgw3mSTIU9FHLYaE4gLR3rCAe5M10Mz5IidvW+P8+kuQAAqpZq8UohiZGX
	NZsGANWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54852)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYNuS-0003vP-0v;
	Mon, 29 Jul 2024 11:47:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYNuV-0004Fs-VY; Mon, 29 Jul 2024 11:47:24 +0100
Date: Mon, 29 Jul 2024 11:47:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Revanth Kumar Uppala <ruppala@nvidia.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system
 side
Message-ID: <ZqdzOxYJiRyft1Nh@shell.armlinux.org.uk>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-3-ruppala@nvidia.com>
 <ZJw2u6BIShe2ZGsw@shell.armlinux.org.uk>
 <BL3PR12MB64504E3A40CD6D8EAB7FF0C8C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
 <ZL5nQxCyj8x+5lWk@shell.armlinux.org.uk>
 <bb949d68-3229-45b8-964c-54ccf812f6f8@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb949d68-3229-45b8-964c-54ccf812f6f8@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jul 19, 2024 at 02:27:24PM +0100, Jon Hunter wrote:
> Hi Russell,
> 
> On 24/07/2023 12:57, Russell King (Oracle) wrote:
> > On Mon, Jul 24, 2023 at 11:29:33AM +0000, Revanth Kumar Uppala wrote:
> > > > -----Original Message-----
> > > > From: Russell King <linux@armlinux.org.uk>
> > > > Sent: Wednesday, June 28, 2023 7:04 PM
> > > > To: Revanth Kumar Uppala <ruppala@nvidia.com>
> > > > Cc: andrew@lunn.ch; hkallweit1@gmail.com; netdev@vger.kernel.org; linux-
> > > > tegra@vger.kernel.org
> > > > Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system side
> > > > 
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Wed, Jun 28, 2023 at 06:13:25PM +0530, Revanth Kumar Uppala wrote:
> > > > > +     /* Lane bring-up failures are seen during interface up, as interface
> > > > > +      * speed settings are configured while the PHY is still initializing.
> > > > > +      * To resolve this, poll until PHY system side interface gets ready
> > > > > +      * and the interface speed settings are configured.
> > > > > +      */
> > > > > +     ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PHYXS,
> > > > MDIO_PHYXS_VEND_IF_STATUS,
> > > > > +                                     val, (val & MDIO_PHYXS_VEND_IF_STATUS_TX_READY),
> > > > > +                                     20000, 2000000, false);
> > > > 
> > > > What does this actually mean when the condition succeeds? Does it mean that
> > > > the system interface is now fully configured (but may or may not have link)?
> > > Yes, your understanding is correct.
> > > It means that the system interface is now fully configured and has the link.
> > 
> > As you indicate that it also indicates that the system interface has
> > link, then you leave me no option but to NAK this patch, sorry. The
> > reason is:
> > 
> > > > ... If it doesn't succeed because the system
> > > > interface doesn't have link, then that would be very bad, because _this_ function
> > > > needs to return so the MAC side can then be configured to gain link with the PHY
> > > > with the appropriate link parameters.
> > 
> > Essentially, if the PHY changes its host interface because the media
> > side has changed, we *need* the read_status() function to succeed, tell
> > us that the link is up, and what the parameters are for the media side
> > link _and_ the host side interface.
> > 
> > At this point, if the PHY has changed its host-side interface, then the
> > link with the host MAC will be _down_ because the MAC driver is not yet
> > aware of the new parameters for the link. read_status() has to succeed
> > and report the new parameters to the MAC so that the MAC (or phylink)
> > can reconfigure the MAC and PCS for the PHY's new operating mode.
> > 
> > Sorry, but NAK.
> 
> 
> Apologies for not following up before on this and now that is has been a
> year I am not sure if it is even appropriate to dig this up as opposed to
> starting a new thread completely.
> 
> However, I want to resume this conversation because we have found that this
> change does resolve a long-standing issue where we occasionally see our
> ethernet controller fail to get an IP address.
> 
> I understand that your objection to the above change is that (per Revanth's
> feedback) this change assumes interface has the link. However, looking at
> the aqr107_read_status() function where this change is made the function has
> the following ...
> 
> static int aqr107_read_status(struct phy_device *phydev)
> {
>         int val, ret;
> 
>         ret = aqr_read_status(phydev);
>         if (ret)
>                 return ret;
> 
>         if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
>                 return 0;
> 
> 
> So my understanding is that if we don't have the link, then the above test
> will return before we attempt to poll the TX ready status. If that is the
> case, then would the change being proposed be OK?

Here, phydev->link will be the _media_ side link. This is fine - if the
media link is down, there's no point doing anything further. However,
if the link is up, then we need the PHY to update phydev->interface
_and_ report that the link was up (phydev->link is true).

When that happens, the layers above (e.g. phylib, phylink, MAC driver)
then know that the _media_ side interface has come up, and they also
know the parameters that were negotiated. They also know what interface
mode the PHY is wanting to use.

At that point, the MAC driver can then reconfigure its PHY facing
interface according to what the PHY is using. Until that point, there
is a very real chance that the PHY <--> MAC connection will remain
_down_.

The patch adds up to a _two_ _second_ wait for the PHY <--> MAC
connection to come up before aqr107_read_status() will return. This
is total nonsense - because waiting here means that the MAC won't
get the notification of which interface mode the PHY is expecting
to use, therefore the MAC won't configure its PHY facing hardware
for that interface mode, and therefore the PHY <--> MAC connection
will _not_ _come_ _up_.

You can not wait for the PHY <--> MAC connection to come up in the
phylib read_status method. Ever.

This is non-negotiable because it is just totally wrong to do this
and leads to pointless two second delays.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

