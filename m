Return-Path: <netdev+bounces-210434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F5FB13541
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 09:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D583AB6B5
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 07:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47DF157A55;
	Mon, 28 Jul 2025 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ujDjvBvy"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111627404E;
	Mon, 28 Jul 2025 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686027; cv=none; b=l0pCXGaBaxXT8WwZ+mMVkktcLCGd5lZYY3p7Y5VCPq0g6J5DSBF4PqMu/XQIpJLbjXXcSlY6eG8Ce0jROCvEMGp7U4ML45RuH3tvTQfTOyex8A2SZns/jlXwHT8MWkYhrDS3lhJjpiQ/OHYMKNtPDgOw9N6qLiMTgCo5rG2iVA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686027; c=relaxed/simple;
	bh=Pqzvk7wNdC1fgZEn4Fcn44FxjsmLU9AcZQxluHZxnLc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTuI6Y1NOExwSqm4M5xpuxHIObrjlyKxudgUPjP6mdO/jDOAIsHElockLO4a+HAE2BVge9sGYKF1nR9ozHmoJZ61ufnRPpalKnlwMMDaiJG7h2Cs0lrHzxpJqfnKLuFHrTNfBpC4mgZbQlkOMIBueHDKt9w+3Bn309uf8yMlKzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ujDjvBvy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753686025; x=1785222025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pqzvk7wNdC1fgZEn4Fcn44FxjsmLU9AcZQxluHZxnLc=;
  b=ujDjvBvy+DdN964bWKaO2c2tvxtTHUPKPbCYJQevobBW3qeoH37ARiOr
   lVlL5F9JySAROaqOO6xrV1FytHOTWm/0vXjj0FBxSaMuztK3BEDYw6hzB
   VTqCBA2CMQdZ81/S/93yXr9NvahOynCGWTlHccYzGsUd1r6MZ5Zt3Agpo
   hkfhbelPJAKK9Sa/eQKSLHIhfyEKTK21IwvKaf/TcboOJYp9kIW+nF7yq
   1rz8NFZQMiRB1zP0RtzoSFb59/BquOlCbJgjPuiIJPe8Q6XneGTalJIOQ
   33e7FK/X0tOZ1dOtoY/zWGCZbzgwqgjK/XwVB03UuKRBZFQ6fqJ1gc19E
   A==;
X-CSE-ConnectionGUID: Ia+OUj9HS7KJCkW2hMR6bQ==
X-CSE-MsgGUID: aOXMy5zaRjGrLIqDEx8WXg==
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="211919683"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2025 00:00:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 27 Jul 2025 23:59:43 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Sun, 27 Jul 2025 23:59:42 -0700
Date: Mon, 28 Jul 2025 08:56:46 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/4] net: phy: micrel: Replace hardcoded
 pages with defines
Message-ID: <20250728065646.c7bozpk4pxkqrswz@DEN-DL-M31836.microchip.com>
References: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
 <20250724200826.2662658-4-horatiu.vultur@microchip.com>
 <aIKbaS8ASndR7Xe_@shell.armlinux.org.uk>
 <20250725064839.psuzyuxfmyvudfka@DEN-DL-M31836.microchip.com>
 <aIRz_EvHUWSNAUVH@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aIRz_EvHUWSNAUVH@pengutronix.de>

The 07/26/2025 08:21, Oleksij Rempel wrote:

Hi,

> 
> On Fri, Jul 25, 2025 at 08:48:39AM +0200, Horatiu Vultur wrote:
> > The 07/24/2025 21:45, Russell King (Oracle) wrote:
> > >
> > > On Thu, Jul 24, 2025 at 10:08:25PM +0200, Horatiu Vultur wrote:
> > > > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > > > index b04c471c11a4a..d20f028106b7d 100644
> > > > --- a/drivers/net/phy/micrel.c
> > > > +++ b/drivers/net/phy/micrel.c
> > > > @@ -2788,6 +2788,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
> > > >       return ret;
> > e >  }
> > > >
> > > > +#define LAN_EXT_PAGE_0                                       0
> > > > +#define LAN_EXT_PAGE_1                                       1
> > > > +#define LAN_EXT_PAGE_2                                       2
> > > > +#define LAN_EXT_PAGE_4                                       4
> > > > +#define LAN_EXT_PAGE_5                                       5
> > > > +#define LAN_EXT_PAGE_31                                      31
> >
> > Hi Russell,
> >
> > >
> > > I don't see the point of this change. This is almost as bad as:
> > >
> > > #define ZERO 0
> > > #define ONE 1
> > > #define TWO 2
> > > #define THREE 3
> > > ...
> > > #define ONE_HUNDRED_AND_FIFTY_FIVE 155
> > > etc
> > >
> > > It doesn't give us any new information, and just adds extra clutter,
> > > making the code less readable.
> > >
> > > The point of using register definitions is to describe the purpose
> > > of the number, giving the number a meaning, not to just hide the
> > > number because we don't want to see such things in C code.
> > >
> > > I'm sorry if you were asked to do this in v1, but I think if you
> > > were asked to do it, it would've been assuming that the definitions
> > > could be more meaningful.
> >
> > You are right, I have been ask to change this in version 1:
> > https://lkml.org/lkml/2025/7/23/672
> >
> > I have mentioned it that the extended pages don't have any meaningfull
> > names also in the register description document. But Oleksij says he
> > will be fine with xxxx_EXT_PAGE_0, so maybe I have missunderstood Oleksij
> 
> Hi,
> 
> I requested these defines because it's much easier to search for a specific
> define than for a raw number - especially when debugging or comparing with
> datasheets. Even if the names are generic, it helps track down usage when
> documentation becomes available or evolves.
> 
> To improve the situation, I reviewed the LAN8814 documentation and observed how
> the existing driver and patches (for LAN8842) use these extended pages.
> Based on that, I suggest following names:
> 
> Documented Extended Pages:
> 
> These are described in the LAN8814 documentation:
> 
> /**
>  * LAN8814_PAGE_COMMON_REGS - Selects Extended Page 4.
>  *
>  * This page contains device-common registers that affect the entire chip.
>  * It includes controls for chip-level resets, strap status, GPIO,
>  * QSGMII, the shared 1588 PTP block, and the PVT monitor.
>  */
> #define LAN8814_PAGE_COMMON_REGS 4
> 
> /**
>  * LAN8814_PAGE_PORT_REGS - Selects Extended Page 5.
>  *
>  * This page contains port-specific registers that must be accessed
>  * on a per-port basis. It includes controls for port LEDs, QSGMII PCS,
>  * rate adaptation FIFOs, and the per-port 1588 TSU block.
>  */
> #define LAN8814_PAGE_PORT_REGS 5
> 
> Undocumented Pages (based on driver and patch analysis):
> 
> These pages are not officially documented, but their use is visible in the
> driver and LAN8842 patch:
> 
> /**
>  * LAN8814_PAGE_AFE_PMA - Selects Extended Page 1.
>  *
>  * This page appears to control the Analog Front-End (AFE) and Physical
>  * Medium Attachment (PMA) layers. It is used to access registers like
>  * LAN8814_PD_CONTROLS and LAN8814_LINK_QUALITY.
>  */
> #define LAN8814_PAGE_AFE_PMA 1
> 
> /**
>  * LAN8814_PAGE_PCS_DIGITAL - Selects Extended Page 2.
>  *
>  * This page seems dedicated to the Physical Coding Sublayer (PCS) and other
>  * digital logic. It is used for MDI-X alignment (LAN8814_ALIGN_SWAP) and EEE
>  * state (LAN8814_EEE_STATE) in the LAN8814, and is repurposed for statistics
>  * and self-test counters in the LAN8842.
>  */
> #define LAN8814_PAGE_PCS_DIGITAL 2
> 
> /**
>  * LAN8814_PAGE_SYSTEM_CTRL - Selects Extended Page 31.
>  *
>  * This page appears to hold fundamental system or global controls. In the
>  * driver, it is used by the related LAN8804 to access the
>  * LAN8814_CLOCK_MANAGEMENT register.
>  */
> #define LAN8814_PAGE_SYSTEM_CTRL 31
> 
> While these names are not official, they still give useful hints and make the
> code more readable. I doubt the LAN8842 has an identical layout, but it looks
> similar enough to reuse these patterns for now.

I think the name of the defines matches pretty good with the
functionality of those pages.

> 
> Are there any plans to make the LAN8842 register documentation public? That
> would help clarify this further and improve upstream support.

I don't know exactly but I have started to ask around when and if they will
make the lan8842 register description public.

> 
> Best regards,
> Oleksij
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-- 
/Horatiu

