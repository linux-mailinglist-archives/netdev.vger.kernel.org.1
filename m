Return-Path: <netdev+bounces-101275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF5D8FDF06
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CD828D5F7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4A513A3F3;
	Thu,  6 Jun 2024 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RBuQdhw8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED7130482;
	Thu,  6 Jun 2024 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656238; cv=none; b=dMzwFXuUFWhF213+8NqLl6CxesIdid/tW2fyJnwediThQodOKF2VgbSIzc+u6fxUTQMe+qu2KHI68g0YhF642ELKBWhAQriv5+VJPE7gkh7CmxwjtX14kto5mCIa0Hdz05NPkm7v+iYWNkrFPf+GXhAm6Xd4MJwr+FjFUIeZfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656238; c=relaxed/simple;
	bh=32L8G+FZMjkCPqq/m+QVmmb5J2ZOiAF+Tzy4v6bCN5I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXJHoPKoTJ57o+weq/Aelndu5XUd07jsHQZ8kifukXycEQGM4oWKI+k00ttxLbZ8JuaOUZzocHCXWxM77IxwrcH0Scz8RNbeDbZy3h6LrwFKOKaP7EAjxm08Ut1NGw1AqCBk6LaQXwrYAooQCLZGtHgCWZWDanS/TSTkE2FG2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RBuQdhw8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717656236; x=1749192236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=32L8G+FZMjkCPqq/m+QVmmb5J2ZOiAF+Tzy4v6bCN5I=;
  b=RBuQdhw89eFDO0nCpgYzVZ+1hAJfm/RLUfeqBdIBnKedkenbB5/3bY8U
   ePjOz7SDsBfpsXdThq8XvzL+irW0dcdtRLw/3v6d+drFiXgXTANIYv5Hc
   oN0RqqspqkMfpz36y41LIQLwFhqoaLt+lrJNLipWfJ08QS5/fk+yG6/pF
   U7vcIoa05w2JXg0R6ly+9aW2vAFDAgK73zIE6dKbjnnGFcd3C9fIslS17
   4wJD/9JBTKk3JFKlrp5mq0rcKIWnGc2vu6Uq4mf7+5/AwRo4pAz+65vJm
   eHL8mlEr9stkEdGvia4dx3vJR/rbBht8M0od2StYmyVmncKH2/3pQcsl4
   w==;
X-CSE-ConnectionGUID: TJ+w9vbOSBmBbzdOv8xviA==
X-CSE-MsgGUID: 5YT6fVzyRhOdZkjKzntlGw==
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="257898861"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2024 23:43:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Jun 2024 23:43:45 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 23:43:44 -0700
Date: Thu, 6 Jun 2024 12:11:05 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Wojciech Drewek <wojciech.drewek@intel.com>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net V3 3/3] net: phy: mxl-gpy: Remove interrupt mask
 clearing from config_init
Message-ID: <ZmFaATrK6ORRzHv6@HYD-DK-UNGSW21.microchip.com>
References: <20240605101611.18791-1-Raju.Lakkaraju@microchip.com>
 <20240605101611.18791-4-Raju.Lakkaraju@microchip.com>
 <05146417-c29b-41f4-89ac-bc9e1af2cee7@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <05146417-c29b-41f4-89ac-bc9e1af2cee7@intel.com>

Hi Wojciech,

The 06/05/2024 13:24, Wojciech Drewek wrote:
> [Some people who received this message don't often get email from wojciech.drewek@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 05.06.2024 12:16, Raju Lakkaraju wrote:
> > When the system resumes from sleep, the phy_init_hw() function invokes
> > config_init(), which clears all interrupt masks and causes wake events to be
> > lost in subsequent wake sequences. Remove interrupt mask clearing from
> > config_init() and preserve relevant masks in config_intr()
> >
> > Fixes: 7d901a1e878a ("net: phy: add Maxlinear GPY115/21x/24x driver")
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > ---
> 
> One nit, other than that:
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> > Change List:
> > ------------
> > V0 -> V3:
> >   - Address the https://lore.kernel.org/lkml/4a565d54-f468-4e32-8a2c-102c1203f72c@lunn.ch/T/
> >     review comments
> >
> >  drivers/net/phy/mxl-gpy.c | 58 +++++++++++++++++++++++++--------------
> >  1 file changed, 38 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> > index b2d36a3a96f1..e5f8ac4b4604 100644
> > --- a/drivers/net/phy/mxl-gpy.c
> > +++ b/drivers/net/phy/mxl-gpy.c
> > @@ -107,6 +107,7 @@ struct gpy_priv {
> >
> >       u8 fw_major;
> >       u8 fw_minor;
> > +     u32 wolopts;
> >
> >       /* It takes 3 seconds to fully switch out of loopback mode before
> >        * it can safely re-enter loopback mode. Record the time when
> > @@ -221,6 +222,15 @@ static int gpy_hwmon_register(struct phy_device *phydev)
> >  }
> >  #endif
> >
> > +static int gpy_ack_interrupt(struct phy_device *phydev)
> > +{
> > +     int ret;
> > +
> > +     /* Clear all pending interrupts */
> > +     ret = phy_read(phydev, PHY_ISTAT);
> > +     return ret < 0 ? ret : 0;
> 
> Can we just return phy_read?
> 

No.
PHY_ISTAT (i.e.16 bit) is Max Linear's GPY211 PHY interrupt status register.
These bits are ROSC (i.e. "Read Only, Self-Clearing) bits.
Read Status gives us the interrupts details
Any negative number is indicate the error in accessing PHY registgers. 
Return either success (i.e. 0) or Error ( < 0)

> > +}
> > +
> >  static int gpy_mbox_read(struct phy_device *phydev, u32 addr)
> >  {
> >       struct gpy_priv *priv = phydev->priv;
> > @@ -262,16 +272,8 @@ static int gpy_mbox_read(struct phy_device *phydev, u32 addr)
> >

-- 
Thanks,                                                                         
Raju

