Return-Path: <netdev+bounces-215926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A07B30EF5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E661CE4A58
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A36C2E54BE;
	Fri, 22 Aug 2025 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TW3GAKcV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890022459CD;
	Fri, 22 Aug 2025 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844296; cv=none; b=p6zipxZS00qBEWp2jpCjwtovzn1HbY9nPFqlrr93DLrexJ/XVQvxZc3bkhEgfhd5j10GLSu1RmQWHwHN9o2DYcRntCXGCsGQ95OfpxNzaZImGffefHdecTlKW839YD5bgxtqmBsm5zTWNGNqSna4ek+03KieJFmKn2wBJbVK97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844296; c=relaxed/simple;
	bh=BfrIP2efQTPMIsUMGQ2GSf0G8ZxHl1U5ZvuSo5I4hyQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/HEURU98k7A6NWUgjU60gtipPgGJxjwmuU2/UEgqtKt4psf5MAy8L3zVxyLRSxV/RvR32LJm0vQc4hBE6B+JfzbPw+k/9ui0ZO1IDdhoR0xgQFT6fK5ghO0oZnzlfDmrwyA7WeJmBUm2grAAHh7/OIvoj3Fi0kmNKq5ashxCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TW3GAKcV; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755844294; x=1787380294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BfrIP2efQTPMIsUMGQ2GSf0G8ZxHl1U5ZvuSo5I4hyQ=;
  b=TW3GAKcVH44HdG3Zo6uvknw8Xguz8k1+JrGgn7TjnUwbsdt/eDkpkf3Q
   opMUcqM7ecyMQdqQsaiGLsmPzNu24NTUUx+tyWm2+WVri10VZ1XhKEZSH
   zYturIAWXvQ+tZNteymRjtHNnOCqJs4XUkS7puH/Kl79bAC3565FYHJir
   JO6vb9cOE+ipvCcJ4ABtax5ghC4h4smmDj88BVbE9vVrBXGvtuFQz4BJs
   q90COHOJbBDIRP5sPWWJtYcTm0nyrL/Lyu4z3C4SLInaxzLH3o64u0ATM
   0iNe+hG20xN2ycevP9+ctCje/6UZUVbsR3LeUL/bc1scIyjDLwxRQNh5A
   g==;
X-CSE-ConnectionGUID: FwPxws7BQ9CIjc8APoX4aw==
X-CSE-MsgGUID: uBBIn80iTQO67UXCd/9b1Q==
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="276910799"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2025 23:31:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 21 Aug 2025 23:30:53 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 21 Aug 2025 23:30:52 -0700
Date: Fri, 22 Aug 2025 08:27:26 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<rmk+kernel@armlinux.org.uk>, <rosenp@gmail.com>,
	<christophe.jaillet@wanadoo.fr>, <viro@zeniv.linux.org.uk>,
	<atenart@kernel.org>, <quentin.schulz@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] phy: mscc: Fix when PTP clock is register and
 unregister
Message-ID: <20250822062726.cv7bdoorf6c4wkvt@DEN-DL-M31836.microchip.com>
References: <20250821104628.2329569-1-horatiu.vultur@microchip.com>
 <3f8cef10-fbfd-42b7-8ab7-f15d46938eb3@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <3f8cef10-fbfd-42b7-8ab7-f15d46938eb3@linux.dev>

The 08/21/2025 14:50, Vadim Fedorenko wrote:

Hi Vadim,

> 
> On 21/08/2025 11:46, Horatiu Vultur wrote:
> > +static void __vsc8584_deinit_ptp(struct phy_device *phydev)
> > +{
> > +     struct vsc8531_private *vsc8531 = phydev->priv;
> > 
> > -     vsc8531->ptp->ptp_clock = ptp_clock_register(&vsc8531->ptp->caps,
> > -                                                  &phydev->mdio.dev);
> > -     return PTR_ERR_OR_ZERO(vsc8531->ptp->ptp_clock);
> > +     ptp_clock_unregister(vsc8531->ptp->ptp_clock);
> > +     skb_queue_purge(&vsc8531->rx_skbs_list);
> >   }
> > 
> >   void vsc8584_config_ts_intr(struct phy_device *phydev)
> > @@ -1552,6 +1549,18 @@ int vsc8584_ptp_init(struct phy_device *phydev)
> >       return 0;
> >   }
> > 
> > +void vsc8584_ptp_deinit(struct phy_device *phydev)
> > +{
> > +     switch (phydev->phy_id & phydev->drv->phy_id_mask) {
> > +     case PHY_ID_VSC8572:
> > +     case PHY_ID_VSC8574:
> > +     case PHY_ID_VSC8575:
> > +     case PHY_ID_VSC8582:
> > +     case PHY_ID_VSC8584:
> > +             return __vsc8584_deinit_ptp(phydev);
> 
> void function has no return value. as well as it shouldn't return
> anything. I'm not quite sure why do you need __vsc8584_deinit_ptp()
> at all, I think everything can be coded inside vsc8584_ptp_deinit()

I understand, I can update not to return anything.
Regarding __vsc8584_deinit_ptp, I have created that function just to be
similar with the __vsc8584_init_ptp.

> 
> > +     }
> > +}

-- 
/Horatiu

