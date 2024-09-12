Return-Path: <netdev+bounces-127702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A748C976201
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5CD1C23137
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7B518BB89;
	Thu, 12 Sep 2024 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AR7MExp4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCDB18BC3A;
	Thu, 12 Sep 2024 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124272; cv=none; b=Rwuwmmn6UvA9lTOFh/MRKumGVX8fDvOsvCCCEKcrbYMGu5RtupIyTQAmgEA/UsYfN3t7i8d9n1ncDbNOtYLXOr3q61g5og0AiYZmYYfhqb2bkLhARwmDo716M0u6LuRuu6J00vEDewqmR4sf3kioJWwseQAharnTjPnvNKLxBY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124272; c=relaxed/simple;
	bh=5+bIPMEoA1yR7Xwl0KRUCi7BMbclI9D7vD34OylTPuQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaiuKuF2TOAHUMIH/RYfRuO47myddY4LS6de8EBJHAbPw+LG6UJAu8yrD2QwHuep5sTqUmUbGUBKKn5LUQGp/AmYtEnGI/GbsKUxXLHkWcQZPTDuRWCIcK9ne75hVdk+3HedXFuLa1A1wt7q7+ZEc3KalwnRwM354xbrvIF01/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AR7MExp4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726124270; x=1757660270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5+bIPMEoA1yR7Xwl0KRUCi7BMbclI9D7vD34OylTPuQ=;
  b=AR7MExp4/pGgv4JMg+448kZ3CuRd8ENIkIqI94B42MuBOJ2Mz+dwqqu9
   9o8HzgAI73ED15wVGf1DBUfLM0tyT+ZnzjDD+uXhsqsmN95YOQSH+lqXj
   9rcw31Kan2mLsp2lpIPUwAMTbMkEVIYRx/CqdK2lUt6AqC6mE7tdDO2Hb
   KI9vODp9E6TI5IZApAfQYDgRjHQhke+iA0eWfDnABNg56HxDNqJ3zGZNL
   uQGOmkY/ruCWfEbb7keZ39WEvYCZruiO8zWkiepbeswDh89YS+gRNLhoO
   usxR7f4Ti4vuWEsbfSXO1vmMYCSPWkPMMX0HGZzV3q5Plpx0Kme+CYZtN
   w==;
X-CSE-ConnectionGUID: CUekk07YRKqJfpKvVdTizw==
X-CSE-MsgGUID: WVzQ85OpRauNniz+ATj5yA==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="31575821"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 23:57:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 23:57:19 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 11 Sep 2024 23:57:18 -0700
Date: Thu, 12 Sep 2024 12:23:29 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Message-ID: <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>

Hi Andrew,

The 09/11/2024 19:26, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> > +static int pci11x1x_pcs_read(struct mii_bus *bus, int addr, int devnum,
> > +                          int regnum)
> > +{
> > +     struct lan743x_adapter *adapter = bus->priv;
> > +
> > +     if (addr)
> > +             return -EOPNOTSUPP;
> > +
> > +     return lan743x_sgmii_read(adapter, devnum, regnum);
> > +}
> 
> >  static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
> >  {
> > +     struct dw_xpcs *xpcs;
> >       u32 sgmii_ctl;
> >       int ret;
> >
> > @@ -3783,8 +3823,17 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
> >                                 "SGMII operation\n");
> >                       adapter->mdiobus->read = lan743x_mdiobus_read_c22;
> >                       adapter->mdiobus->write = lan743x_mdiobus_write_c22;
> > -                     adapter->mdiobus->read_c45 = lan743x_mdiobus_read_c45;
> > -                     adapter->mdiobus->write_c45 = lan743x_mdiobus_write_c45;
> > +                     if (adapter->is_sfp_support_en) {
> > +                             adapter->mdiobus->read_c45 =
> > +                                     pci11x1x_pcs_read;
> > +                             adapter->mdiobus->write_c45 =
> > +                                     pci11x1x_pcs_write;
> 
> As you can see, the naming convention is to put the bus transaction
> type on the end. So please name these pci11x1x_pcs_read_c45...

Accpeted. I will fix

> 
> Also, am i reading this correct. C22 transfers will go out a
> completely different bus to C45 transfers when there is an SFP?

No. You are correct.
This LAN743x driver support following chips
1. LAN7430 - C22 only with GMII/RGMII I/F
2. LAN7431 - C22 only with MII I/F
3. PCI11010/PCI11414 - C45 with RGMII or SGMII/1000Base-X/2500Base-X
   If SFP enable, then XPCS's C45 PCS access
   If SGMII only enable, then SGMII (PCS) C45 access

> 
> If there are two physical MDIO busses, please instantiate two Linux
> MDIO busses.
> 

XPCS driver is doing.
Am i miss anything there?

>     Andrew
> 
> ---
> pw-bot: cr

-- 
Thanks,                                                                         
Raju

