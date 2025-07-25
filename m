Return-Path: <netdev+bounces-209965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B69BB118B6
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 08:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA9CAA843B
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 06:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1067C28937A;
	Fri, 25 Jul 2025 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dbsOCjti"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E31B6D06;
	Fri, 25 Jul 2025 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426380; cv=none; b=MN2eB6qe+G9O1gvtzp6GY0yDUk1jjSk7NcLcoqlYKn1oQAt4W5rse1H5k3NRO4cap29icXolizVnp2h38nEKlQ65Ty9tAX1tA1MDiuM+BWcs1QKeHNOPj+9L6TTvUt3FI1fijiV7Fwr2GaYQtvFoAufNz8HYtfOkmq9atK1tA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426380; c=relaxed/simple;
	bh=20nHIXM9x/K8ItS1GIZjz28u6zUrsz6iqx1gk4P+kng=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKLYZ+7UdCXWh4JnwyO4dq+OZy2uItfLDXQAlypXTbfC/ni471MGwRTlpIJFjm5fPPOKA3/IMOtdOHxCaA6tLCcEnodYzcKCJovNI0v0NabcZDN8YIXeneVHGIbpFq4sYYGEHK4u1ZWE+ezsoOM7ihWkPGcC+q1j+Dr/NMIaKD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dbsOCjti; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753426378; x=1784962378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=20nHIXM9x/K8ItS1GIZjz28u6zUrsz6iqx1gk4P+kng=;
  b=dbsOCjti5U4iNybn7zHPoY88W7euhV6aUVJlGAVUCTSQLS1JZ1BvrLc5
   VikyH5fDjTdFk4/jd017MEXsr/29s610bm96JafGgMLZYAHMdGiOUS4Fj
   8xqd+Yhda4GFif15wqZYbPttfThlydy2RWKuiMXlrxtHGW0v28Aj+nUmQ
   cBj6qicch2Dz2/KY6noiqnOU9yHxU/0Fxpmc16VuXdcHHzRnjGbXx34Zi
   3lKziRAkYvAIjy1RsJV2b/4SmsieKOm3lYcE+lp9FQJjQ14mGE4WtFGjN
   oE+txhsG9c7uUUMVokSOdjPENXmV43RI+Dk0xzah3bWpmuhQBTcSgzOT5
   A==;
X-CSE-ConnectionGUID: CniThB0ESIylVa/zs0YtAg==
X-CSE-MsgGUID: dlpcnZ9sSd6Uz56B2YqMog==
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="49739607"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2025 23:52:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Jul 2025 23:51:32 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 24 Jul 2025 23:51:32 -0700
Date: Fri, 25 Jul 2025 08:48:39 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/4] net: phy: micrel: Replace hardcoded
 pages with defines
Message-ID: <20250725064839.psuzyuxfmyvudfka@DEN-DL-M31836.microchip.com>
References: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
 <20250724200826.2662658-4-horatiu.vultur@microchip.com>
 <aIKbaS8ASndR7Xe_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aIKbaS8ASndR7Xe_@shell.armlinux.org.uk>

The 07/24/2025 21:45, Russell King (Oracle) wrote:
> 
> On Thu, Jul 24, 2025 at 10:08:25PM +0200, Horatiu Vultur wrote:
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index b04c471c11a4a..d20f028106b7d 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -2788,6 +2788,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
> >       return ret;
> >  }
> >
> > +#define LAN_EXT_PAGE_0                                       0
> > +#define LAN_EXT_PAGE_1                                       1
> > +#define LAN_EXT_PAGE_2                                       2
> > +#define LAN_EXT_PAGE_4                                       4
> > +#define LAN_EXT_PAGE_5                                       5
> > +#define LAN_EXT_PAGE_31                                      31

Hi Russell,

> 
> I don't see the point of this change. This is almost as bad as:
> 
> #define ZERO 0
> #define ONE 1
> #define TWO 2
> #define THREE 3
> ...
> #define ONE_HUNDRED_AND_FIFTY_FIVE 155
> etc
> 
> It doesn't give us any new information, and just adds extra clutter,
> making the code less readable.
> 
> The point of using register definitions is to describe the purpose
> of the number, giving the number a meaning, not to just hide the
> number because we don't want to see such things in C code.
> 
> I'm sorry if you were asked to do this in v1, but I think if you
> were asked to do it, it would've been assuming that the definitions
> could be more meaningful.

You are right, I have been ask to change this in version 1:
https://lkml.org/lkml/2025/7/23/672

I have mentioned it that the extended pages don't have any meaningfull
names also in the register description document. But Oleksij says he
will be fine with xxxx_EXT_PAGE_0, so maybe I have missunderstood Oleksij
in what he proposed.

> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
/Horatiu

