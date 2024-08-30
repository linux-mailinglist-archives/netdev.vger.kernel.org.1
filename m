Return-Path: <netdev+bounces-123590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E777965705
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 07:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966591C21F4E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 05:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E119C14C587;
	Fri, 30 Aug 2024 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R7gT9Y6s"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB04683;
	Fri, 30 Aug 2024 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996425; cv=none; b=eL1AvcCxFIbEWCI8BQ2TqkUE++LBvSwqcI1vmFcgijv2+NWSfTDQZtDh0hEcFGWGiqJ+I3F904H2p7Rpbl4wK+oM6B/Sa56vX8XcXPGKZy3z7ru2vN+5BHWQsoEvK+rhmLFaa1fDBc1sokKPujXL6ij93oS0mDpRvK61zNLbCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996425; c=relaxed/simple;
	bh=TSvZrD4lJmOy7wdjmlljNKPC9vnJyx3eyHMBcM54u7Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khAegb4PLobhPioP+rwph5Jg2URJESkFDtgPhc35mlwhz7ksop9QtSaRkZQBf7t9IHGfil07PX9Ad8FXEIr55ZZBljstEo8jCY5xHoSbhtdiZWI0I1xr7yRc9KzUF/gnXx2d8XKZZO3YmNklzXfjJL8jPLJe1k8adfiIvpF6Ato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R7gT9Y6s; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724996423; x=1756532423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TSvZrD4lJmOy7wdjmlljNKPC9vnJyx3eyHMBcM54u7Q=;
  b=R7gT9Y6sB3b9e5q/ibheBu47+7oUhf+zkow81xFIy61N15jn0oH2c+vP
   j41y3qGUMDlydOTUU/A4EAYBhI2rcxS+qogSknmIr+FCeqgyVrt0EePsA
   LnSqT3LKNMnBrOPFQWzZXueYAgDUcUyqyf/fnxVhFLLTBrtJslBkg4U9M
   LsAGlaYve/X+zwEd0XI7ql8CX8x2LArik+wISRGO7V+KRApVQ/yF8dP8m
   cTBsiwS/wcLCPqG+viOw8tMVBYh2BPy+p10FnyJnNTNxNaG5VsxwaivTJ
   xUyyJ3wj7beL/zEe2jf+8QWsDe3FXDI43KzwI8ItoS5OHMW0pDc9dX+MM
   A==;
X-CSE-ConnectionGUID: LxYZ/VWqTCKqkZobaprtlw==
X-CSE-MsgGUID: IJBPug06SGixdt0yYhiSGQ==
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="31745598"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2024 22:40:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Aug 2024 22:40:12 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 29 Aug 2024 22:40:12 -0700
Date: Fri, 30 Aug 2024 11:06:33 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <Bryan.Whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V4 4/5] net: lan743x: Migrate phylib to phylink
Message-ID: <ZtFaYQRQXi/8Q+qx@HYD-DK-UNGSW21.microchip.com>
References: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
 <20240829055132.79638-5-Raju.Lakkaraju@microchip.com>
 <20240829094910.28ccd6ca@device-28.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240829094910.28ccd6ca@device-28.home>

Hello Maxime,

Thank you for review the patches.

The 08/29/2024 09:49, Maxime Chevallier wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hello Raju,
> 
> On Thu, 29 Aug 2024 11:21:31 +0530
> Raju Lakkaraju <Raju.Lakkaraju@microchip.com> wrote:
> 
> > Migrate phy support from phylib to phylink.
> >
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> 
> [...]
> 
> > +static void lan743x_phylink_disconnect(struct lan743x_adapter *adapter)
> > +{
> > +     struct net_device *netdev = adapter->netdev;
> > +     struct phy_device *phydev = netdev->phydev;
> > +
> > +     phylink_stop(adapter->phylink);
> > +     phylink_disconnect_phy(adapter->phylink);
> > +
> > +     if (phydev)
> > +             if (phy_is_pseudo_fixed_link(phydev))
> > +                     fixed_phy_unregister(phydev);
> 
> You shouldn't manually deal with the fixed_phy when using phylink, it
> handles fixed links already for you, without a PHY.

Sure.
I wll remove this fixed_phy unregister here.

> 
> Thanks,
> 
> Maxime

-- 
Thanks,                                                                         
Raju

