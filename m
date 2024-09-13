Return-Path: <netdev+bounces-128056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9D7977BB7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 10:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BF81C20C1B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7980D1D6DDC;
	Fri, 13 Sep 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EVUh3awF"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84E1D6C52;
	Fri, 13 Sep 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217920; cv=none; b=c8Aoe/gbWam1tr692eyoYNTxrJ3fLO3gsHxSoA+w7iSp985nzZpK82c94GQYjq/OeM+upzFfMQdDgKEbo3AQf8AsI4K+W5IokwtWnGwN77wTRkKPlktTbvmSp4qZpaxAOtOWSjoQ8e++e5kNUNNX7KIz899MfzzxMWX+Wkqlz3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217920; c=relaxed/simple;
	bh=5Dl1QNldlIlDNbxg9s0OvAL2DSD5njuCRP7qF/7NheQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSt4kBLqBmwBjujRxdlmNOVKlTWsJ12G+RUbs2yEyfYpJAtNy/UYtuRLk8fWFjHYG6TvV2xRsjVVn9sWuH5SmPMbHIr9RaeubR0fxyJrDrRJY3yiDNDGC6+EynwJRe8A0I9ear31JdCDK/mw/pvrySmYsk49qbkJXCC1ksj+fKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EVUh3awF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726217917; x=1757753917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Dl1QNldlIlDNbxg9s0OvAL2DSD5njuCRP7qF/7NheQ=;
  b=EVUh3awFcmL+zTJ6BBRzNc6uStqWTs7XxaPoOeUgOZTHeWHBm3Gjn5GH
   K6KA0Z7Qadsl7ZgAjqSIw2fcFL+iITdh/1WwldQzMgUWTXK/VhYzObLYN
   Cho26nHF4IYlIFQa8kj/NRNMlHV0f8+7jSSubSSzlNgW9/xd34sf6J0JZ
   jwYseO4hatZK800IaVqlpqWdS1RWXZ000c7bcs9r0hThXakKDzkWHe3ZY
   eXxmkjrgCuwMWDo7gAkRDMp4ElbSpCh2zB+dQY7gpHgwDM6V/fACvHy4b
   GfKjYt1s6DRzwx1TMkLSeG0Dsh33P4zfm7uOS2t34NJ3kecVm65vhR3kY
   g==;
X-CSE-ConnectionGUID: 9rjvo6qoSyKZdgJH0FKZdw==
X-CSE-MsgGUID: 9ccq/p0aQc2RkArkkfEoVQ==
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="31630117"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Sep 2024 01:58:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Sep 2024 01:58:26 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 13 Sep 2024 01:58:25 -0700
Date: Fri, 13 Sep 2024 14:24:35 +0530
From: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
To: Ronnie Kunin - C21729 <Ronnie.Kunin@microchip.com>
CC: Andrew Lunn <andrew@lunn.ch>, Raju Lakkaraju - I30499
	<Raju.Lakkaraju@microchip.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Bryan Whitehead
 - C21958" <Bryan.Whitehead@microchip.com>, UNGLinuxDriver
	<UNGLinuxDriver@microchip.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, Steen Hegelund - M31857
	<Steen.Hegelund@microchip.com>, Daniel Machon - M70577
	<Daniel.Machon@microchip.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Message-ID: <ZuP9y+5YntuUJNTe@HYD-DK-UNGSW21.microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
 <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>
 <cbc505ca-3df0-4139-87a1-db603f9f426a@lunn.ch>
 <PH8PR11MB79651A4A42D0492064F6541B95642@PH8PR11MB7965.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <PH8PR11MB79651A4A42D0492064F6541B95642@PH8PR11MB7965.namprd11.prod.outlook.com>

Hi Andrew / Ronnie,

The 09/12/2024 16:04, Ronnie Kunin - C21729 wrote:
> 
> 
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Thursday, September 12, 2024 11:28 AM
> > To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> > Cc: netdev@vger.kernel.org; davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> > <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; maxime.chevallier@bootlin.com;
> > rdunlap@infradead.org; Steen Hegelund - M31857 <Steen.Hegelund@microchip.com>; Daniel Machon -
> > M70577 <Daniel.Machon@microchip.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > > > Also, am i reading this correct. C22 transfers will go out a
> > > > completely different bus to C45 transfers when there is an SFP?
> > >
> > > No. You are correct.
> > > This LAN743x driver support following chips 1. LAN7430 - C22 only with
> > > GMII/RGMII I/F 2. LAN7431 - C22 only with MII I/F
> > 
> > Fine, simple, not a problem.
> > 
> > > 3. PCI11010/PCI11414 - C45 with RGMII or SGMII/1000Base-X/2500Base-X
> > >    If SFP enable, then XPCS's C45 PCS access
> > >    If SGMII only enable, then SGMII (PCS) C45 access
> > 
> > Physically, there are two MDIO busses? There is an external MDIO bus with two pins along side the
> > RGMII/SGMII pins? And internally, there is an MDIO bus to the PCS block?
> > 
> > Some designs do have only one bus, the internal PCS uses address X on the bus and you are simply not
> > allowed to put an external device at that address.
> > 
> > But from my reading of the code, you have two MDIO busses, so you need two Linux MDIO busses.
> > 
> >         Andrew
> 
> Our PCI11x1x hardware has a single MDIO controller that gets used regardless of whether the chip interface is set to RGMII or to SGMII/BASE-X.
> When we are using an SFP, the MDIO lines from our controller are not used / connected at all to the SFP.
> 
> Raju can probably explain this way better than me since the how all this interaction in the linux mdio/sfp/xpcs frameworks work honestly goes over my head. From what he told me even when we are not using our mdio controller lines, since there is indirect access to the PHY (the one inside of the SFP) via the I2C controller (which btw does not share any hardware pins with those used by the MDIO controller), he had to change the PHY management functions for that indirect access to be used when SFP is selected.
> 
> Ronnie

It's my mistake. We don't need 2 MDIO buses. 
If SFP present, XPC's MDIO bus can use,
If not sfp, LAN743x MDIO bus can use. 

We will fix.

> 

-- 
Thanks,                                                                         
Raju

