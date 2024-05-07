Return-Path: <netdev+bounces-94023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893F08BDF99
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165521F21787
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2459914EC4D;
	Tue,  7 May 2024 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pbGgIpxH"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6814E2DE;
	Tue,  7 May 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077401; cv=none; b=lel0Xj1or3miA9T9jvpDq5D4V/s3WJCkzrjm03XALp+Tsl343KDB2Rez1romslBXoU0qQ+cQ57p5Xx1kNlYpfvTxkN3eBXBPa4jNCzvNkLHjTgZ6xTCnTLjDQGDXPrmQ//IkU4rvBW0te1JOTjC5Q2NJ7mXsbc2/BlO3lX2HInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077401; c=relaxed/simple;
	bh=Gm4GceuR5OxITl9PR6JnqdjWWBcG7QBtr441NLfsuNM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nk1+22No+A5rKTOUQFZ/QUG3EKuf4pCAYjBQGbZyvf/i1lR5nQybTrStAU4A2Sb++4lxE9WYa8arFi4ZmDJcKhzz1k8TTuDzciqwu0uNPe1+QaYxx2ev2vVat3QWlTiGGk+qe/nNqtSIEDX1cjhjkjfG9VrQofYfUd9WVsxbLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pbGgIpxH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715077399; x=1746613399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gm4GceuR5OxITl9PR6JnqdjWWBcG7QBtr441NLfsuNM=;
  b=pbGgIpxH03gmNP8gc/c5PY7HXRsj6cv+skanUy7tk7Z7BC4QrVLuctar
   4D6IOKbzoool62aJZippxfz7hRdF+Mvo8dZvqv7Ane4oZ9CRrv/7gBlbm
   9cFUt8/Htc5jivIWffw30IuXI5JpZh0BiBKXslLhK1SusbgIArBs7k4tU
   UFo7nZHiBv8dzp9y8X7x7gRps8C/vsHxesxD4CKzJFakpBbASX+DUQ0tF
   BwLmmsCPRF93hPAOGTGXnn7hfk8VPBN3sI6z3YhPKYXHjVXLEF4jvRXFg
   M5YNTvlgFC3KIz1qS3jXbDCNBYmuelAa0H2/bdxQQeQgMSO+ZFLu4NsQJ
   Q==;
X-CSE-ConnectionGUID: AI7nB1djQrayuS0RCqpZ+Q==
X-CSE-MsgGUID: m//drMMAT1yv2KkxmHgjVA==
X-IronPort-AV: E=Sophos;i="6.07,261,1708412400"; 
   d="scan'208";a="26124008"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 May 2024 03:23:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 03:23:07 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 7 May 2024 03:23:07 -0700
Date: Tue, 7 May 2024 15:50:39 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Raju Lakkaraju
	<Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<lxu@maxlinear.com>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next] net: phy: add wol config options in phy device
Message-ID: <ZjoAd2vsiqGhCVCv@HYD-DK-UNGSW21.microchip.com>
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
 <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
 <ZjO4VrYR+FCGMMSp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ZjO4VrYR+FCGMMSp@shell.armlinux.org.uk>

Hi Russell King,

Sorry for late response

The 05/02/2024 16:59, Russell King (Oracle) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Thu, May 02, 2024 at 04:51:42PM +0200, Andrew Lunn wrote:
> > On Tue, Apr 30, 2024 at 10:36:35AM +0530, Raju Lakkaraju wrote:
> > > Introduce a new member named 'wolopts' to the 'phy_device' structure to
> > > store the user-specified Wake-on-LAN (WOL) settings. Update this member
> > > within the phy driver's 'set_wol()' function whenever the WOL configuration
> > > is modified by the user.
> > >
> > > Currently, when the system resumes from sleep, the 'phy_init_hw()' function
> > > resets the PHY's configuration and interrupts, which leads to problems upon
> > > subsequent WOL attempts. By retaining the desired WOL settings in 'wolopts',
> > > we can ensure that the PHY's WOL configuration is correctly reapplied
> > > through 'phy_ethtool_set_wol()' before a system suspend, thereby resolving
> > > the issue
> >
> > Sorry it took a white to review this.
> >
> > >
> > > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > > ---
> > >  drivers/net/phy/mxl-gpy.c    | 5 +++++
> > >  drivers/net/phy/phy_device.c | 5 +++++
> > >  include/linux/phy.h          | 2 ++
> > >  3 files changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> > > index b2d36a3a96f1..6edb29a1d77e 100644
> > > --- a/drivers/net/phy/mxl-gpy.c
> > > +++ b/drivers/net/phy/mxl-gpy.c
> > > @@ -680,6 +680,7 @@ static int gpy_set_wol(struct phy_device *phydev,
> > >     struct net_device *attach_dev = phydev->attached_dev;
> > >     int ret;
> > >
> > > +   phydev->wolopts = 0;
> >
> > Is this specific to mlx-gpy?
> >
> > You should be trying to solve the problem for all PHYs which support
> > WoL. So i expect the core to be doing most of the work. In fact, i
> > don't think there is any need for driver specific code.
> 
> It would be good to hear exactly why its necessary for phylib to track
> this state,

Andrew suggested that if PHY device support WOL, Ethernet MAC device should be in
sleep expect interrrupt handling functionality.

To achive this, if we have phy device's wolopts, based on user configuration,
we can configure phy WOL or Ethernet MAC WOL.

PCI11x1x chip MAC can support WOL (i.e. WAKE_MAGIC, WAKE_SECURE, WAKE_UCAST,
WAKE_MCAST, WAKE_BCAST, WAKE_PHY)

GPY211C PHY connect as External PHY to PCI11x1x ethernet device to achive
2.5G/1G/100M/10Mpbs with either SGMII or 2500Base-X mode. GPY211C PHY can
support WOL (i.e. WAKE_PHY or WAKE_MAGIC).

Similarly, KSZ91931 PHY connect as External PHY to PCI11x1x ethernet device to
achive 1G/100M/10Mbps with RGMII or GMII mode. But, KSZ9131 PHY driver does
not support WOL.

If we have phy's wolopts which holds the user configuration, Ethernet MAC
device can configure Power Manager's WOL registers whether handle only 
PHY interrupts or MAC's WOL functionality.

In existing code, we don't have any information about PHY's user configure to
configure the PM mode

> and why the PHY isn't retaining it.
> 

mxl-gpy driver does not have soft_reset( ) function.
In resume sequence, mxl-gpy driver is clearing the WOL configuration and interrupt
i.e.
gpy_config_init( ) and gpy_config_intr( )

> I suspect this may have something to do with resets - the PHY being
> hardware reset when coming out of resume (resulting in all state
> being lost.) What's resetting it would also be good to track down
> (as in hardware, firmware, or the kernel.)
> 
In case of resume, the following sequence executes:

pci_pm_resume( )
--> lan743x_pm_resume()
   --> lan743x_netdev_open( )
      --> phy_connect_direct( )
         --> phy_attach_direct( )
	     --> phy_init_hw( )
	        --> gpy_config_init( )
		--> gpy_config_intr( )

In existing gpy_config_init( ) and gpy_config_intr( ) function don't have any
indication about whether execute in initial operation or WOL's resume
operation.

If we avoid clearing Interrupts in WOL's resume case, we need not re-configure
the WOL on PHY. 

I add the following code and test.  It's working as expected.

In File: drivers/net/phy/mxl-gpy.c
In gpy_config_init( ) function:

+       if (!phydev->wolopts) {
               /* Mask all interrupts */
               ret = phy_write(phydev, PHY_IMASK, 0);
               if (ret)
                       return ret;
+       }

In gpy_config_intr( ) function:

+       if (phydev->wolopts)
+               mask |= (phy_read(phydev, PHY_IMASK) &
+                        (PHY_IMASK_WOL | PHY_IMASK_LSTC));
+

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
Thanks,                                                                         
Raju

