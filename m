Return-Path: <netdev+bounces-218615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A05B3D9DB
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518BB164F7D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 06:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A28B20E032;
	Mon,  1 Sep 2025 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QfaS5yZR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4722156A;
	Mon,  1 Sep 2025 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707942; cv=none; b=eXpHhP35+eRZV584Tpvg9gXrDjDQETjAhWTkugUADUvk2pNFB4xXQA2YRvaszIUHdaGtz36n7vcn52+jumnKnqw9O3SeqqImmGLcupIdDDjKIcbi74kT6bgAcbI6mcU38iCPiuF1X/1oa7NXSNtO380/8inoI9kVTd/JuK71UqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707942; c=relaxed/simple;
	bh=7HI3Ro/EE5rzV6n5s5bDuj18Rzg2uhMCG0Mah0c++i0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHCz8r+FLGCojZA51ncSmh+c4y3smWzu1PvdNGDQxxCQxXKZ8UmV1EeIc9pkDQkr8Esl7IgOL1/2OvbYHxLIA1tmsjQp7lwYnYUnPSljDPL9rnVc6jO1gFMOPLEgzjRp0BN7dI0VT09AdkcTf+3flfCLUabgTLAW3xpU8wHIP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QfaS5yZR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756707940; x=1788243940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7HI3Ro/EE5rzV6n5s5bDuj18Rzg2uhMCG0Mah0c++i0=;
  b=QfaS5yZR9v+v+bAzrjvPpegMqOFJ4RZyCQKP+Q0CJBM3VSBApUwmWnci
   deX4klyVrqtjdOYMlLSuTMBlBQOenM18+szgH7aE0IjhNTz+fiot+wGmB
   rTI9TM1ui+u7IQ8CyjvgryVs/xgV33RgBGsZJhtuGc+R6HVGrbWrsgDwc
   OK1zvUVTOMROLQPHE2FE3poMb3abFN9ZNhwul1jAT5Bap73Bd+lIKWebK
   sRTWTgnLepvSAQrVjohKNm83ggKcGwVG7zsFpbfRdHf5ui0gXDHYWj1EM
   PwOlpS5w3x7NUjctTQpINLeAPoKkBkctG0yb2roI+UID7Sk31yi+AeRsj
   A==;
X-CSE-ConnectionGUID: P1DTPltMS2ie8GsA4XUqfg==
X-CSE-MsgGUID: vaIqiNDtRpGipA7cJJ5VXg==
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="46446076"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Aug 2025 23:25:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 31 Aug 2025 23:25:18 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Sun, 31 Aug 2025 23:25:18 -0700
Date: Mon, 1 Sep 2025 08:21:40 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Parthiban.Veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 2/2] net: phy: micrel: Add PTP support for
 lan8842
Message-ID: <20250901062140.df6pqpvs7dyv564l@DEN-DL-M31836.microchip.com>
References: <20250829134836.1024588-1-horatiu.vultur@microchip.com>
 <20250829134836.1024588-3-horatiu.vultur@microchip.com>
 <20250829165310.2b97569b@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829165310.2b97569b@kmaincent-XPS-13-7390>

The 08/29/2025 16:53, Kory Maincent wrote:
> 
> On Fri, 29 Aug 2025 15:48:36 +0200
> Horatiu Vultur <horatiu.vultur@microchip.com> wrote:
> 
> > It has the same PTP IP block as lan8814, only the number of GPIOs is
> > different, all the other functionality is the same. So reuse the same
> > functions as lan8814 for lan8842.
> > There is a revision of lan8842 called lan8832 which doesn't have the PTP
> > IP block. So make sure in that case the PTP is not initialized.
> 
> ...
> 
> > @@ -5817,6 +5831,43 @@ static int lan8842_probe(struct phy_device *phydev)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /* Revision lan8832 doesn't have support for PTP, therefore don't add
> > +      * any PTP clocks
> > +      */
> > +     ret = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> > +                                LAN8842_SKU_REG);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     priv->rev = ret;
> > +     if (priv->rev == 0x8832)
> > +             return 0;
> 
> Is the lan8832 PHY ID the same as the lan8842? This would be surprising.
> If they have different PHY ID, it will never enter the lan8842 probe function as
> it is not added to mdio_device_id.
> Also you should add a define instead of using several time 0x8832.

They will have the same PHY ID. And it is the LAN8842_SKU_REG which
determines which revision of the PHY it is.
I will add a define for 0x8832.
> 
> ...
> 
> > @@ -5912,6 +5989,26 @@ static irqreturn_t lan8842_handle_interrupt(struct
> > phy_device *phydev) ret = IRQ_HANDLED;
> >       }
> >
> > +     /* Phy revision lan8832 doesn't have support for PTP threrefore
> 
> nitpick: therefore

Good catch. I will fix this in the next version.

> 
> Regards,
> --
> Köry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

-- 
/Horatiu

