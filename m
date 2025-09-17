Return-Path: <netdev+bounces-223897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB16B7DFEE
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0ED1BC06B4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EF730149C;
	Wed, 17 Sep 2025 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="abMDtPZs"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424EC2D7DFA;
	Wed, 17 Sep 2025 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095468; cv=none; b=l0rCvRapVbvcQrPTZu6JTnf5iVNWAK2t/k5YAi8GBc8iMH8R503+1YBh1/X4hOSX1/3tcThfrUpqI+Y1Ne5zw7Fj7/SSs59SPOqWbmLFm05cA5i+H6O8toj66jGF05PDn6onJ7lVhdQ9VsispwG3ZoB21Dui7elFWh2uNjmXwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095468; c=relaxed/simple;
	bh=sZVrbL1rMNxRBe1AdgwiqrIOQznDMSBlqC7AgllBD1Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CR96Ig9clgqU8dj0G6yuwcW5NVan7zplnlAorvRFo0EPTMzcOHnYkH44O1MbmZQa3oP69pt1+es39Ho4N01dJnYOZ9ppn+S6k06RiVWPi3nfEVZfdIAw3Beq4BQ1/x+HfUjwi6qHRphoaAG2G3XmhgBiVmHA+fqFBSygPjVxKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=abMDtPZs; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758095467; x=1789631467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sZVrbL1rMNxRBe1AdgwiqrIOQznDMSBlqC7AgllBD1Y=;
  b=abMDtPZsoSMV/YyGQYGk3FyDAMX838pWODwtuV+OO0Wy4+5aRrSrDoZp
   eiMPofEF7rxHNi10TudMAKEFE0Y99528gJQus098BaQ25/l3Jg8ZXx83o
   a/QcQ7vnxvFdtt8gJ9tumVz63xPV6p+65KlvycOsf5t7iwContlrFUXE9
   0j6uF7wwE3gv86hqv8wcXbpnJCotwE+TmPaGvUS0/c/PEvbeV/+++8LUV
   4/QLPvopatTUTWm96I0T714iK3VNiDuFfe3OI7JVi4Arc23Yjmsh+i3Zp
   IzdbqvD0Q56abTQ2VeBbVAPCgsTCAqSGLfEiJzvsR95k6HsrnD1oj3xjt
   Q==;
X-CSE-ConnectionGUID: j/mSCPqcSweNUU3i5SbcxA==
X-CSE-MsgGUID: fXOK8C+DSSSpf+spTZ9CPw==
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="47151270"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 00:51:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 17 Sep 2025 00:50:42 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 17 Sep 2025 00:50:42 -0700
Date: Wed, 17 Sep 2025 09:46:45 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<vadim.fedorenko@linux.dev>, <rosenp@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <christophe.jaillet@wanadoo.fr>,
	<steen.hegelund@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] phy: mscc: Fix PTP for vsc8574 and VSC8572
Message-ID: <20250917074645.ajo3wmnkescujepc@DEN-DL-M31836.microchip.com>
References: <20250915080112.3531170-1-horatiu.vultur@microchip.com>
 <64e2cf5f-b2e5-43b9-aea9-a937f6ec1508@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <64e2cf5f-b2e5-43b9-aea9-a937f6ec1508@redhat.com>

The 09/16/2025 15:32, Paolo Abeni wrote:

Hi Paolo,

> 
> On 9/15/25 10:01 AM, Horatiu Vultur wrote:
> > When trying to enable PTP on vsc8574 and vsc8572 it is not working even
> > if the function vsc8584_ptp_init it says that it has support for PHY
> > timestamping. It is not working because there is no PTP device.
> > So, to fix this make sure to create a PTP device also for this PHYs as
> > they have the same PTP IP as the other vsc PHYs.
> 
> [...]
> 
> > diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
> > index ef0ef1570d392..89b5cd96e8720 100644
> > --- a/drivers/net/phy/mscc/mscc_main.c
> > +++ b/drivers/net/phy/mscc/mscc_main.c
> > @@ -2259,6 +2259,7 @@ static int vsc8574_probe(struct phy_device *phydev)
> >       u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
> >          VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
> >          VSC8531_DUPLEX_COLLISION};
> > +     int ret;
> >
> >       vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
> >       if (!vsc8531)
> 
> vsc8574_probe() is also used by 8504 and 8552, is the side effect intended?

No, that side effect is not intended because I have checked the vsc8552
and vsc8504 datasheet and I couldn't find anything about timestamping.
So this is a mistake.
My first thought was to use vsc8514_probe for these devices but this
will introduce another side effect as the statistics will be different.
So, I will need to create another probe function for these 2 devices.

> 
> /P
> 

-- 
/Horatiu

