Return-Path: <netdev+bounces-209275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CDEB0EE00
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05DA3BF5C4
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063ED28312F;
	Wed, 23 Jul 2025 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SehxYpO7"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6021F94A;
	Wed, 23 Jul 2025 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261480; cv=none; b=VlN4Q4B94eH/LHR+7KKhBKX1A0UXoMxIujgez2hFvoFwOGHdx0yqhEmw1iFQulUlwxWsa5iTMggxyS9QqFt+dPur+7TM2P9nGGO+4FTSyQzdJeADiPIxNd6/XeWl2HjYb34zE6lXjmvX+Z4MufXJ+qCP+VvUIyg/iyP3C76Klkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261480; c=relaxed/simple;
	bh=uM1yIeNXaAOrUJx+SIA3ksktxtXkBR6/9c40F73MvHk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9Jg/u4NxSTuArs77Qciwa4SDnZda0KuJSiE+wAkml5pM8YO32NX6dNGzZO1caMS+sZTXvNOYFUzoSoyu47DBXjF6ubMafI1LNcenSaS0DIrDwJM36YK7dIjOISPkWbdbQVKoPcuOXJ6Q1TTdPmdqrHHkAGalH53kdpW8V7lf3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SehxYpO7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753261480; x=1784797480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uM1yIeNXaAOrUJx+SIA3ksktxtXkBR6/9c40F73MvHk=;
  b=SehxYpO71RR3UI2vDteDh+uCdSb9RCpqZokZw7dD4VoAbh3PHG3ji8lG
   EyI6XElA+ziJ4DirMeeWmHSorEl32u/Tom9+FVb8QZJs/C8nkoL5o7e5T
   XLf3FXdTQRhzBu+j/4dSOg5riYnSFyd6VuQZVfl8wKU/6TJerlacrFpwQ
   L6IK4yHcSjGC58F5a8jk/Urk0s1foA/VIJQ2zKxzrNAEv8zNAJ2W3geCc
   9iRGmmmg1try1Ui+sh5q2oX1idEjVXZaXb7smTTEpqr2Mp9IzeGgNplXb
   9bWQQnU4arSY+1QItNKeRbzVelCQEKPWSkMh/n9CCv33CYiAB4azstprK
   g==;
X-CSE-ConnectionGUID: HpDSfaDuQV22XKWexB7eBw==
X-CSE-MsgGUID: 3sx0FfeUSWCSbAk2P3OhuQ==
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="44308986"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2025 02:04:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 23 Jul 2025 02:04:36 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 23 Jul 2025 02:04:36 -0700
Date: Wed, 23 Jul 2025 11:01:45 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan8842
Message-ID: <20250723090145.o2kq4vxcjrih54rt@DEN-DL-M31836.microchip.com>
References: <20250721071405.1859491-1-horatiu.vultur@microchip.com>
 <aIB0VYLqcBKVtAmU@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aIB0VYLqcBKVtAmU@pengutronix.de>

The 07/23/2025 07:34, Oleksij Rempel wrote:
> 
> Hi Horatiu,

Hi Olekij,

> 
> On Mon, Jul 21, 2025 at 09:14:05AM +0200, Horatiu Vultur wrote:
> 
> > +static int lan8842_config_init(struct phy_device *phydev)
> > +{
> > +     int val;
> > +     int ret;
> > +
> > +     /* Reset the PHY */
> > +     val = lanphy_read_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET);
> 
> It would be good to use defines for MMD pages.

Those are extended pages and not MMD pages. Currently in the entire
source code I can see we used hardcoded values, also in the register
description it looks like all these extended pages do not have really
meaningfull names: Extended Page 0, Extended Page 4, Extended Page 5...

> 
> > +     if (val < 0)
> > +             return val;
> > +     val |= LAN8814_QSGMII_SOFT_RESET_BIT;
> > +     lanphy_write_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET, val);
> 
> Please, do not ignore return values.

Good catch, I will fix that in the next version.
There are few others bellow, I will fix those also.

> 
> > +
> > +     /* Disable ANEG with QSGMII PCS Host side
> > +      * It has the same address as lan8814
> > +      */
> > +     val = lanphy_read_page_reg(phydev, 5, LAN8814_QSGMII_PCS1G_ANEG_CONFIG);
> > +     if (val < 0)
> > +             return val;
> > +     val &= ~LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA;
> > +     ret = lanphy_write_page_reg(phydev, 5, LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
> > +                                 val);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Disable also the SGMII_AUTO_ANEG_ENA, this will determine what is the
> > +      * PHY autoneg with the other end and then will update the host side
> > +      */
> > +     lanphy_write_page_reg(phydev, 4, LAN8842_SGMII_AUTO_ANEG_ENA, 0);
> > +
> > +     /* To allow the PHY to control the LEDs the GPIOs of the PHY should have
> > +      * a function mode and not the GPIO. Apparently by default the value is
> > +      * GPIO and not function even though the datasheet it says that it is
> > +      * function. Therefore set this value.
> > +      */
> > +     lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_EN2, 0);
> > +
> > +     /* Enable the Fast link failure, at the top level, at the bottom level
> > +      * it would be set/cleared inside lan8842_config_intr
> > +      */
> > +     val = lanphy_read_page_reg(phydev, 0, LAN8842_FLF);
> > +     if (val < 0)
> > +             return val;
> > +     val |= LAN8842_FLF_ENA | LAN8842_FLF_ENA_LINK_DOWN;
> 
> If I see it correctly, FLF support will make link fail after ~1ms, while
> IEEE 802.3 recommends 750ms. Since a link recovery of a PHY with autoneg
> support usually takes multiple seconds, I see the benefit for FLF
> support only mostly for SyncE environment at same time it seems to be
> a disadvantage for other environments.

Why would be a disadvantage?
> 
> I would prefer to have IEEE 802.3 recommended link behavior by default
> and have separate Netlink configuration interface for FLF.
> 
> Best Regards,
> Oleksij
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-- 
/Horatiu

