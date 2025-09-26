Return-Path: <netdev+bounces-226601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50018BA2AAD
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025E7383EA8
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABF82472A4;
	Fri, 26 Sep 2025 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TWZgccce"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A45D1E503D;
	Fri, 26 Sep 2025 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758870969; cv=none; b=R7w6P/SED1mTkC/yDZwGdOHA7o7aX5Nb+bYfifQvQz+1rFKuuk68vf2uleEtCCszmJbzLoHCHTPajy/l14/TDIhUMV9ee0IOtszzyEQ3LCrB1qrUpUefoXhz5Z8Q5HE4wOUBV48dJfPYOXs8AijkqdmJyjGZG68DdpUPaT2nacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758870969; c=relaxed/simple;
	bh=ZdACV22BjkW/Y27c1XltJ7WBPOP763D7G5MAFoqJgY8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGcLLDJaEOclb1wp/scfNQCejUUVatLGEzHC1mw8+YEPUO26c0npdv+eyx4NN7yo06tZsY45imIc8ILcjH46rPOufdmjCBC6af0ymSxBuzhgKgghJViMfPWlXq+hwL+R77jFxLDOqpVYpMyQ59mA9Jq8aOULYjlasPHHThRpmSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TWZgccce; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758870967; x=1790406967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZdACV22BjkW/Y27c1XltJ7WBPOP763D7G5MAFoqJgY8=;
  b=TWZgccceqsh78N2ZppYiPJAhTxKM45cHF9geEb0dCRewMdkAFy3zznSe
   qlWOYYIkWZBCYmXU9rdNrXqekKYBxdUD6eM4TC20TUtV9J6vVC+bI6dwX
   2RUrzKXuIEZo6kT4cI2mooNTHlh56KCdbz4PNx4zDUYX/YZc2m3Uwn7WQ
   3Ka+A1RFNKw7N5/Tamkf+YJAmSdU21gHfNM1sjSSl+aEMT2ofQiO8yIlt
   /vU33UUugQTCCbEdcEeU/tV1CGppakFWic4KwN6oui2/M5n2hlG7Ast0E
   UeJ7RaJFRClubwv4bURHJtCeDrLgWCvj4ICQI0/VRev7pr+P3wS86+0da
   A==;
X-CSE-ConnectionGUID: adtckK8bQgKJXJZbdyXOCA==
X-CSE-MsgGUID: yKLtYzkgTCSpO59bXGSDhA==
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="214391105"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2025 00:15:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 26 Sep 2025 00:15:19 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 26 Sep 2025 00:15:18 -0700
Date: Fri, 26 Sep 2025 09:11:11 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Jakub Kicinski <kuba@kernel.org>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>, <rmk+kernel@armlinux.org.uk>,
	<christophe.jaillet@wanadoo.fr>, <rosenp@gmail.com>,
	<steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] phy: mscc: Fix PTP for vsc8574 and VSC8572
Message-ID: <20250926071111.bdxffjghguawcobp@DEN-DL-M31836.microchip.com>
References: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
 <20250918160942.3dc54e9a@kernel.org>
 <20250922121524.3baplkjgw2xnwizr@skbuf>
 <20250922123301.y7qjguatajhci67o@DEN-DL-M31836.microchip.com>
 <20250922132846.jkch266gd2p6k4w5@skbuf>
 <20250923071924.mv6ytwtifuu5limg@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250923071924.mv6ytwtifuu5limg@DEN-DL-M31836.microchip.com>

The 09/23/2025 09:19, Horatiu Vultur wrote:

Hi,

> The 09/22/2025 16:28, Vladimir Oltean wrote:
> > 
> > On Mon, Sep 22, 2025 at 02:33:01PM +0200, Horatiu Vultur wrote:
> > > Thanks for the advice.
> > > What about to make the PHY_ID_VSC8572 and PHY_ID_VSC8574 to use
> > > vsc8584_probe() and then in this function just have this check:
> > >
> > > ---
> > > if ((phydev->phy_id & 0xfffffff0) != PHY_ID_VSC8572 &&
> > >     (phydev->phy_id & 0xfffffff0) != PHY_ID_VSC8574) {
> > >       if ((phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {
> > >               dev_err(&phydev->mdio.dev, "Only VSC8584 revB is supported.\n");
> > >               return -ENOTSUPP;
> > >       }
> > > }
> > 
> > Personally, I think you are making the code harder to understand what
> > PHYs the test is referring to, and why it exists in the first place.
> > 
> > Ideally this test would have not existed. Instead of the open-coded
> > phy_id and phy_id_mask fields from the struct phy_driver array entries,
> > one could have used PHY_ID_MATCH_MODEL() for those entries where the
> > bits 3:0 of the PHY ID do not matter, and PHY_ID_MATCH_EXACT() where
> > they do. Instead of failing the probe, just not match the device with
> > this driver and let the system handle it some other way (Generic PHY).
> 
> Yes, I can see your point. That would be a nicer fix.
> 
> > 
> > I'm not sure if this is intended or not, but the combined effect of:
> > - commit a5afc1678044 ("net: phy: mscc: add support for VSC8584 PHY")
> > - commit 75a1ccfe6c72 ("mscc.c: Add support for additional VSC PHYs")
> > 
> > is that for VSC856X, VSC8575, VSC8582, VSC8584, the driver will only
> > probe on Rev B silicon, and fail otherwise. Initially, the revision test
> > was only there for VSC8584, and it transferred to the others by virtue
> > of reusing the same vsc8584_probe() function. I don't see signs that
> > this was 100% intentional. I say this because when probing e.g. on
> > VSC8575 revA, the kernel will print "Only VSC8584 revB is supported."
> > which looks more like an error than someone's actual intention.
> > 
> > By excluding VSC8574 and VSC8572 from the above revision test, it feels
> > like a double workaround rather than using the conventional PHY ID match
> > helpers as intended.
> > 
> > As a Microchip employee, maybe you have access to some info regarding
> > whether the limitations mentioned by Quentin Schulz for VSC8584 revA
> > are valid for all the other PHYs for which they are currently imposed.
> > What makes VSC8574/VSC8572 unlike the others in this regard?
> 
> Let me start by asking my colleagues and figure out which revisions were
> produced for which PHYs.
> Thanks for the advice.

I have been asking around about these revisions of the PHYs and what is
available:
vsc856x - only rev B exists
vsc8575 - only rev B exists
vsc8582 - only rev B exists
vsc8584 - only rev B exists
vsc8574 - rev A,B,C,D,E exists
vsc8572 - rev A,B,C,D,E exists

For vsc856x, vsc8575, vsc8582, vsc8584 the lower 4 bits in register 3
will have a value of 1.
For vsc8574 and vsc8572 the lower 4 bits in register 3 will have a value
of 0 for rev A, 1 for rev B and C, 2 for D and E.

Based on this information, I think both commits a5afc1678044 and
75a1ccfe6c72 are correct regarding the revision check.

So, now to be able to fix the PTP for vsc8574 and vsc8572, I can do the
following:
- start to use PHY_ID_MATCH_MODEL for vsc856x, vsc8575, vsc8582, vsc8584
- because of this change I will need to remove also the WARN_ON() in the
  function vsc8584_config_init()
- then I can drop the check for revision in vsc8584_probe()
- then I can make vsc8574 and vsc8572 to use vsc8584_probe()

What do you think about this?

> 
> > 
> > It looks like the review comments to clean things up are getting bigger.
> > I'm not sure this is all adequate for 'net' any longer.
> > On the other hand, you said PTP never worked for VSC8574/VSC8572,
> > without any crash, it was just not enabled. Maybe this can all be
> > reconsidered as new functionality for net-next, and there we have more
> > space for shuffling things around?
> 
> -- 
> /Horatiu

-- 
/Horatiu

