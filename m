Return-Path: <netdev+bounces-226652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BCDBA3963
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7EA1C01D70
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464EA25F988;
	Fri, 26 Sep 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="owG0Wymn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855A1F5435;
	Fri, 26 Sep 2025 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889047; cv=none; b=bGTsHmBDgPHWpjQZ9ilWL5/SL3CVWvaf1jLJO0C5+m8/2/Hp+0C0pJ3kg4C4ordGEKgUkGwwakbMktaVOMWhBf/0qA4R1XTbag+55IA+40qTk84jtiBrsB7gL5wy2ZfKtJrVuBCsDk6onda7WlqjeZ0O/Fe3i91D+TWQKJGEwiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889047; c=relaxed/simple;
	bh=+E/+ytuqiTkVd0tbjOzSD8vXyT/FBxpJSn2yZ26yW5s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgmoseYyjSD6UHIRaHlHfsW095htaCdLvm0XWE7ILotMI5+RSKlOjB48Yb4CQI1NzXpDYj2/xyXEgaPmFYJrxHl09fLOWpztZBjdPCYCTuxM7QdNJN4a4G2gUFm/UNq6J6ylA+eZEIgeYNVNaLBXGuJWYjt/MZ/VLY+3GUtHA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=owG0Wymn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758889046; x=1790425046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+E/+ytuqiTkVd0tbjOzSD8vXyT/FBxpJSn2yZ26yW5s=;
  b=owG0Wymn8Oi81ja9C86nMTesH9LyGKU5cFMkIhye6PvEfgQb+wvTYuZW
   2P/NCVHcsYYjiFlr9Pg+1OTs5JsNlZbdeJmignuxQY36kLwGdd9W21RJF
   oGKOP3a2r+phJo9Zacgmh2l0vc1w6JD9fkSnBFdLk2vnxHs6H8Ev4EwyO
   wns+zz2QW0YYymyR449ugFWb5O+Rsx5QxJ35ItreRrEv1aAjypj2t6koI
   0TlOBoYlsxpO5McL/alykr/HSHv5IIchfLzT7IIgUOks4wYbaVi6bR94F
   q93g8u2ist4j5nIOsDhNhkpzUd3QnJs6XYAtW/kAsR0qu7NTw6ZSiPwRK
   g==;
X-CSE-ConnectionGUID: Gz3HhZdvQV+zY8Pmob1QIg==
X-CSE-MsgGUID: KBZh8JZCQEaNs4xhRQer6Q==
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="47028817"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2025 05:17:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 26 Sep 2025 05:16:53 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 26 Sep 2025 05:16:53 -0700
Date: Fri, 26 Sep 2025 14:12:45 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski
	<kuba@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <vadim.fedorenko@linux.dev>,
	<christophe.jaillet@wanadoo.fr>, <rosenp@gmail.com>,
	<steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] phy: mscc: Fix PTP for vsc8574 and VSC8572
Message-ID: <20250926121245.eqynm74h22d7fhrn@DEN-DL-M31836.microchip.com>
References: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
 <20250918160942.3dc54e9a@kernel.org>
 <20250922121524.3baplkjgw2xnwizr@skbuf>
 <20250922123301.y7qjguatajhci67o@DEN-DL-M31836.microchip.com>
 <aNZhB5LnqH5voBBR@shell.armlinux.org.uk>
 <20250926095203.dqg2vkjr5tdwri7w@skbuf>
 <aNZoyOPu3hUDadWv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aNZoyOPu3hUDadWv@shell.armlinux.org.uk>

The 09/26/2025 11:19, Russell King (Oracle) wrote:

Hi,

> 
> On Fri, Sep 26, 2025 at 12:52:03PM +0300, Vladimir Oltean wrote:
> > On Fri, Sep 26, 2025 at 10:46:47AM +0100, Russell King (Oracle) wrote:
> > > On Mon, Sep 22, 2025 at 02:33:01PM +0200, Horatiu Vultur wrote:
> > > > Thanks for the advice.
> > > > What about to make the PHY_ID_VSC8572 and PHY_ID_VSC8574 to use
> > > > vsc8584_probe() and then in this function just have this check:
> > > >
> > > > ---
> > > > if ((phydev->phy_id & 0xfffffff0) != PHY_ID_VSC8572 &&
> > > >     (phydev->phy_id & 0xfffffff0) != PHY_ID_VSC8574) {
> > > >   if ((phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {
> > > >           dev_err(&phydev->mdio.dev, "Only VSC8584 revB is supported.\n");
> > > >           return -ENOTSUPP;
> > > >   }
> > > > }
> > >
> > > Please, no, not like this. Have a look how the driver already compares
> > > PHY IDs in the rest of the code.
> > >
> > > When a PHY driver is matched, the PHY ID is compared using the
> > > .phy_id and .phy_id_mask members of the phy_driver structure.
> > >
> > > The .phy_id is normally stuff like PHY_ID_VSC8572 and PHY_ID_VSC8574.
> > >
> > > When the driver is probed, phydev->drv is set to point at the
> > > appropriate phy_driver structure. Thus, the tests can be simplified
> > > to merely looking at phydev->drv->phy_id:
> > >
> > >     if (phydev->drv->phy_id != PHY_ID_VSC8572 &&
> > >         phydev->drv->phy_id != PHY_ID_VSC8574 &&
> > >         (phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {
> > > ...
> > >
> > > Alternatively, please look at the phy_id*() and phydev_id_compare()
> > > families of functions.
> > >
> > > --
> > > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> >
> > The phydev->phy_id comparisons are problematic with clause 45 PHYs where
> > this field is zero, but with clause 22 they should technically work.
> > It's good to know coming from a phylib maintainer that it's preferable
> > to use phydev->drv->phy_id everywhere (I also wanted to comment on this
> > aspect, but because technically nothing is broken, I didn't).
> 
> Yes indeed, which is another reason to use phydev->drv->* as these
> get matched against the C22 and C45 IDs during PHY probe.
> 
> If we wish to get more clever (in terms of wanthing to know the
> revision without knowing how the driver was matched) we could store
> the matched ID in phydev, as read from hardware. This would also get
> around the problem that where the ID is provided in the DT compatible,
> we would have the real hardware-read ID to check things like the
> revision against, rather than a fixed value in DT.

Thanks for the explanation and for suggestion.
I will use your suggestion in the next version.

> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
/Horatiu

