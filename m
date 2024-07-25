Return-Path: <netdev+bounces-112932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C895393BF29
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA881F211FA
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DC9197A9B;
	Thu, 25 Jul 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fG32LBEB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1AC197A95;
	Thu, 25 Jul 2024 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900283; cv=none; b=mkPbFLWU/Kd/eV6mhwYJEkaGGR2NrpDMhcK8jP7Z6cDvYmkbg7xCsFuiKR7a/2zga6Js6alXL5qT291xBzusOolHIkbsxycs4MDXbCQlsSUnzh4+EoHcJCcOzV4cQMRKI6gZYGD7AYu4iUdIjsCbcIMHw7TY4F1BUoFh+pAYcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900283; c=relaxed/simple;
	bh=VkQQmC+cDGpTHqGfwkH4J5cRWYSBvrFqnFYBf3GcYYE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zv/cjgRG0J/TT4rqKaASDEJ+oxiu8Na7O1lgQs/MWpAfWV+tUnukizpotsl8FTRfEP2nx09kj4GYMo0qQ9DKDKOJJHMPf0clLFR8w8uKsXhJQAl+G4Qw2eZJ6QNBPTvpg56MU2b4iiu8N0LYyPc8MS0KBQ5BFBI2m4a+PKmd07o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fG32LBEB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721900282; x=1753436282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VkQQmC+cDGpTHqGfwkH4J5cRWYSBvrFqnFYBf3GcYYE=;
  b=fG32LBEBZo5nAGVdplztkP682p36F7druScbqgNdQUxd8blOQTvQwe6Z
   mvpeJs9VWbZVGHP16aMYmDz9f2I7ZxV6GkbMaAs+/qjfgdEvMvwyVbBqW
   MPtweBZYnbBgmUOSIaFogI0VLCmw56PUzI0h1rZmhPa0+vL4nXhDrnP73
   qYbwgbEKALS9k3F3gtzm3reUOMysTGeICyhNC+QxSgqrSRZqr5rgVtZ2k
   yjXSso/tsrR/6A8Lm+cjZGYctZtT6Qvz0EaS2YkgS/3gPs0UFG/fIOUXz
   rTf662jA78v3kQeiA5yF5NV3Wg3y4K2auoGVPAiQdMxcGG4D5uR0NAhkt
   A==;
X-CSE-ConnectionGUID: hEn5OPxASvWCQ96luVzNJg==
X-CSE-MsgGUID: b0zKuWM8S2qIBfEsrbIeYg==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="29674287"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 02:37:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 02:37:28 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Jul 2024 02:37:27 -0700
Date: Thu, 25 Jul 2024 15:04:17 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <horms@kernel.org>,
	<hkallweit1@gmail.com>, <richardcochran@gmail.com>, <rdunlap@infradead.org>,
	<linux@armlinux.org.uk>, <bryan.whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V2 3/4] net: lan743x: Migrate phylib to phylink
Message-ID: <ZqIcGbGktHjsILeu@HYD-DK-UNGSW21.microchip.com>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
 <20240716113349.25527-4-Raju.Lakkaraju@microchip.com>
 <cdf2e1e8-39ff-48b3-84b6-73c673ab1eb1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <cdf2e1e8-39ff-48b3-84b6-73c673ab1eb1@lunn.ch>

Hi Andrew,

Thank you for review the patches.

The 07/18/2024 05:43, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Tue, Jul 16, 2024 at 05:03:48PM +0530, Raju Lakkaraju wrote:
> > Migrate phy support from phylib to phylink.
> > Fixed phy support is still used together with phylink since we need to support
> > dynamic fallback when a phy is not found over mdio. While phylink's FIXED mode
> > supports fixed phys that, it's dynamic and requires device tree entries which
> > are most of the time not present for LAN743x devices
> 
> > +static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
> > +{
> > +     struct device_node *dn = adapter->pdev->dev.of_node;
> > +     struct net_device *dev = adapter->netdev;
> > +     struct fixed_phy_status fphy_status = {
> > +             .link = 1,
> > +             .speed = SPEED_1000,
> > +             .duplex = DUPLEX_FULL,
> > +     };
> 
> 
> So you are happy to limit it to 1G, even thought it can do more? That
> is the problem with fixed PHY done this way. If you were to use
> PHYLINK fixed PHY you can use the full bandwidth of the hardware.
> 

I accept your comments. Fixed PHY hard coded to 1Gpbs.

Currenly, LAN743x chip don't have Device Tree implemented. 
As part of SFP support, I would like to add software nodes.
After SFP support development, I will add "fixed-link" option in software nodes.

> You might want to look at what the wangxun drivers do for some ideas
> how you can make use of PHYLINK fixed link without having DT.

I refer the wangxun drivers for "fixed-link". currently wangxun driver did not
implement "fixed-link" in software node.
 
> 
>     Andrew
> 

-- 
Thanks,                                                                         
Raju

