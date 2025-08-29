Return-Path: <netdev+bounces-218129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B37BB3B368
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E146B189160F
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 06:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABF424166D;
	Fri, 29 Aug 2025 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nlcaxgS7"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94578221558;
	Fri, 29 Aug 2025 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449042; cv=none; b=DLeDfDzxZwkaMCixyuNGiWecm8w5rznhfHI8gprmY4/JAEeW/RuSbSRZa8lSrAwBtDPyQgoExU2CqE8u04WvoVkTtL/9BSo808IDx0dcxNBW0vNUvvMgzkXSNdW7ciqrP6Pg3SirVvOdivSPLf8z95Vcwy+eALSBLL/O1aA6RFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449042; c=relaxed/simple;
	bh=a60Kxd0gylPgvKsaQN/vOZH38VX9J+FWssmcxcn3Ic8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cg31xodscIvb3NPNbp7m4p8K339OFUeh66zIDPMJWYuizfjQsT+wvs50T8Rk7S90FJ4+XKFBEmtXUI+LUNXfhDgCUqzi1zUmADkP7xwHp4KeYtPoVyYXt2wvnVQg95TwxnH+GkIV0wTTA6yT7HKzJeZCDjynxozs3eJX5ZT61/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nlcaxgS7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756449040; x=1787985040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a60Kxd0gylPgvKsaQN/vOZH38VX9J+FWssmcxcn3Ic8=;
  b=nlcaxgS7YSz6nhBfrm354brW1tZQV2CAywBD261yDMOUUuyr++G3M+l7
   ktazTpBUXnYuouRAv9EGNpr562n6O8Tun4gS7qLey92oJZQW2c1LsqAbo
   5ddyqvlswmSttFy6Ai/YzaXM5ooPAOgj631tNeVL+1CJI+QDxFsiOZNfB
   Nxk/JRqR/LY9Mb+kp2T+TfhoNOdaDbYz9Lclk45HIYPwjEUUrHWBb77aY
   OwIksPU1F/d0XSr5TWupZJlb/Ci3MoLlSvIFcyQob4kaQ0qS/qSG+d+lt
   P20TOmRw9SUU7m6qW4eyha59yeXFMRTdUOEPOCiKDPKKGwLbSQYVY5Okw
   g==;
X-CSE-ConnectionGUID: VMdseqpKTbaP3+xhRFmKvA==
X-CSE-MsgGUID: e3E9XbdaRFyEud8sBuhf8w==
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="51464038"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2025 23:30:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 28 Aug 2025 23:30:29 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 28 Aug 2025 23:30:28 -0700
Date: Fri, 29 Aug 2025 08:26:54 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <Parthiban.Veerasooran@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/2] net: phy: micrel: Add PTP support for
 lan8842
Message-ID: <20250829062654.mr7fos3yp63d2wjv@DEN-DL-M31836.microchip.com>
References: <20250828073425.3999528-1-horatiu.vultur@microchip.com>
 <20250828073425.3999528-3-horatiu.vultur@microchip.com>
 <aLAS9SV_AhEeQIGM@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aLAS9SV_AhEeQIGM@shell.armlinux.org.uk>

The 08/28/2025 09:27, Russell King (Oracle) wrote:
> Hi,

Hi Russell,

> 
> Just a few comments.
> 
> On Thu, Aug 28, 2025 at 09:34:25AM +0200, Horatiu Vultur wrote:
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index 9a90818481320..95ba1a2859a9a 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -457,6 +457,9 @@ struct lan8842_phy_stats {
> >
> >  struct lan8842_priv {
> >       struct lan8842_phy_stats phy_stats;
> > +     int rev;
> 
> Maybe make this a u16 and move it at the end of the struct?

Yes, I can make it u16 and move it at the end.
Just for understanding, do you want to move it at the end not to have
any holes in the struct?

> 
> > +     struct phy_device *phydev;
> 
> Why do you need this member? In this patch, you initialise this, but
> never use it.

Actually is not needed, I forgot to remove it before sending the first
version.

> 
> > @@ -5817,6 +5833,41 @@ static int lan8842_probe(struct phy_device *phydev)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /* Revision lan8832 doesn't have support for PTP, therefore don't add
> > +      * any PTP clocks
> > +      */
> > +     priv->rev = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> > +                                      LAN8842_SKU_REG);
> > +     if (priv->rev < 0)
> > +             return priv->rev;
> 
>         ret = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
>                                    LAN8842_SKU_REG);
>         if (ret < 0)
>                 return ret;
> 
>         priv->rev = ret;

Yes, I will update it like you suggested in the next version.

> 
> Thanks.
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
/Horatiu

