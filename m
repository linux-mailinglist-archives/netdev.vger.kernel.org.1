Return-Path: <netdev+bounces-119265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6884E955024
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE8D281FB3
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E91C2316;
	Fri, 16 Aug 2024 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dcRZbT32"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94101BCA1C;
	Fri, 16 Aug 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830155; cv=none; b=pDfLyqD+yJqg2lKO+L+cLBSassPelTQqvwuYR435K9Xx6e/6FimQw/hibiiRt78pEcK2QJLpKHEaGvt1GduSoGwCzuO7cmUu5ySmkMMiptc86kdm0oyCY8ovbjbZCPAPrkOVsyFT41NNZHfpKAoFzEDb6wd7lwLnw6DD1NPDS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830155; c=relaxed/simple;
	bh=OPIKK1vicChc6JvUK5svq4fBKneS8NOBdxmG8GsIpUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8U+PhInNi1IwQIn6bMDOGkY1t67es2AbJDCU+3L+eK4ZWbSVzD/uDlfhEC1Ng4YePQbXted/UKV7TJGBe5ga25i7NRBxOKnPJt6vTq1pWTNEU+3xmefLq/h9oSla34ODyTu4h2haDJ22Vlc4Kn8wU1ToJuZvg5yrTZRw5srpcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dcRZbT32; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723830153; x=1755366153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OPIKK1vicChc6JvUK5svq4fBKneS8NOBdxmG8GsIpUk=;
  b=dcRZbT329HmjtB1gyDsXDBX3/Dxd2JROYQkcV9+IVvZ2kTalf8kP8PGn
   0Fd1gHTGh7KrDZArZwAuDh/2XVPCYgavR0H8o9pFk4YfDb1oPeqqNfVb5
   q3rOmXhRC8J2VJIPawCZoHSBpJ9WI18yKGNRleXLyWprSqnAuMGLDcZeW
   0hWyZrUb4dLQqqXbtUTT04ZUxsUA0334T1eIjmUa4ekx/Soi1NsofMWm0
   2RiyMTLURhcjIs6Ik/FuJBsLjT6su6va5c+SzEdA5c66ngPbhbmsFnY/9
   TJu+HOr5F/l124v/D8vk/KmWWibuP3yuJuCFW5WBgFlVcnCNbN/Vga6oc
   w==;
X-CSE-ConnectionGUID: ambDj8oNS0yn7p2fBFvxdw==
X-CSE-MsgGUID: Sp5FtKxYTH6iX1y2gMoQvg==
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="30591296"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2024 10:42:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Aug 2024 10:42:27 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 16 Aug 2024 10:42:27 -0700
Date: Fri, 16 Aug 2024 23:08:59 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <Ronnie.Kunin@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <horms@kernel.org>, <hkallweit1@gmail.com>,
	<richardcochran@gmail.com>, <rdunlap@infradead.org>,
	<Bryan.Whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phylink
Message-ID: <Zr+OsygS+YRkRnL6@HYD-DK-UNGSW21.microchip.com>
References: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
 <20240730140619.80650-4-Raju.Lakkaraju@microchip.com>
 <Zqj/Mdoy5rhD2YXx@shell.armlinux.org.uk>
 <ZqtrcRfRVBR6H9Ri@HYD-DK-UNGSW21.microchip.com>
 <Zqu3aHJzAnb3KDvz@shell.armlinux.org.uk>
 <PH8PR11MB79655D0005E227742CBA1A8A95B22@PH8PR11MB7965.namprd11.prod.outlook.com>
 <Zqyau+JjwQdzBNaI@shell.armlinux.org.uk>
 <PH8PR11MB796562D6C8964A6B6A1CC7E595B92@PH8PR11MB7965.namprd11.prod.outlook.com>
 <ZrUzkF8jj50ZgGhk@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ZrUzkF8jj50ZgGhk@shell.armlinux.org.uk>

Hi Russell King,

Thank you for quick response.

The 08/08/2024 22:07, Russell King (Oracle) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Thu, Aug 08, 2024 at 08:23:38PM +0000, Ronnie.Kunin@microchip.com wrote:
> > We looked into an alternate way to migrate our lan743x driver from phylib to phylink continuing to support our existing hardware out in the field, without using the phylib's fixed-phy approach that you opposed to, but without modifying the phylib framework either.
> > While investigating how to implement it we came across this which Raju borrowed ideas from: https://lore.kernel.org/linux-arm-kernel/YtGPO5SkMZfN8b%2Fs@shell.armlinux.org.uk/ . He is in the process of testing/cleaning it up and expects to submit it early next week.
> 
> That series died a death because it wasn't acceptable to the swnode
> folk. In any case, that's clearly an over-complex solution for what is
> a simple problem here.
> 
> The simplest solution would be for phylink to provide a new function,
> e.g.
> 
> int phylink_set_fixed_link(struct phylink *pl,
>                            const struct phylink_state *state)
> {
>         const struct phy_setting *s;
>         unsigned long *adv;
> 
>         if (pl->cfg_link_an_mode != MLO_AN_PHY || !state ||
>             !test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
>                 return -EINVAL;
> 
>         s = phy_lookup_setting(state->speed, state->duplex,
>                                pl->supported, true);
>         if (!s)
>                 return -EINVAL;
> 
>         adv = pl->link_config.advertising;
>         linkmode_zero(adv);
>         linkmode_set_bit(s->bit, adv);
>         linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, adv);
> 
>         pl->link_config.speed = state->speed;
>         pl->link_config.duplex = state->duplex;
>         pl->link_config.link = 1;
>         pl->link_config.an_complete = 1;
> 
>         pl->cfg_link_an_mode = MLO_AN_FIXED;
>         pl->cur_link_an_mode = pl->cfg_link_an_mode;
> 
>         return 0;
> }
> 
> You can then call this _instead_ of attaching a PHY to switch phylink
> into fixed-link mode with the specified speed and duplex (assuming
> they are supported by the MAC.)
> 
> Isn't this going to be simpler than trying to use swnodes that need
> to be setup before phylink_create() gets called?
> 

Your suggestion seems to be working well for us. I'm currently testing it on
different boards and checking for corner cases.
I plan to submit it for code review next week.

Quick question: Should I submit your suggested code along with our patches, or
will you be submitting it separately?

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
Thanks,                                                                         
Raju

