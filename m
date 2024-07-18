Return-Path: <netdev+bounces-112000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B33934766
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 07:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFC61C216A9
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 05:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835E40855;
	Thu, 18 Jul 2024 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dRjyajwm"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC48640861;
	Thu, 18 Jul 2024 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279525; cv=none; b=PYltkUx69sRoOEtqSylOFlr7bLJUCGJ3JyJwidqPozv0aMpB1nqwWgwZY1iAx/D92wZKmIQYJg76qu2z+TCBasVPsc+pTY7bdhITfxBCWcYlqkGwWRc2i9ePL8kFxEHgALoD04aemf262RpfPDoEi92p1m1eu2czfe6ecwh/JYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279525; c=relaxed/simple;
	bh=VIEBYTpAjZN+UgLodJBvJtvrCc2b0+NH87gEfc/WNj0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpTB2aNGO+3aOi5FjG6iKnamA0VReWGG3LRI81VdlkAsiiwna+RTCLrA0VjqV/WD+tzfwTuj9enLX2mUmTzQ/gVHr1LtmoH2A6OexzNbxybxPhYUb2bfiGfTX46c6VIKU4OhjxDtZeYnx2HKe4GHqUE24vxebJ+u2TKANvjGrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dRjyajwm; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721279523; x=1752815523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VIEBYTpAjZN+UgLodJBvJtvrCc2b0+NH87gEfc/WNj0=;
  b=dRjyajwm/xKAl3j7+l173VEgl1AQNcl1lGdAM+KGBTUg1syz522a/D9V
   wKxIkYZ1JQUfWDtBtVPktSYHYKwsAcynBKQAkaR1SmzeXjcKqEPbj9TOJ
   9iVq+5cUz720j9gAVJ94zjmh1R67VY2OZ0hMBj+u6yXwDDL5tsdEPU27D
   yjjokTHRq7Hhs6BXiUb4RVlzIqZKWFI1rX+Geu5oe2/dZlF9TnxoJ0eWN
   XbTpcsr1RDQ5F1n5XtIpWed1JaOIISh7KZ9VfK8EmF3Shrkpye2dbdTO1
   f36Y7xi7mo8QdRZtbUHSWvVVtPDgJURVXdD2GZmqpO0WgQZVYIomVE9ab
   g==;
X-CSE-ConnectionGUID: dHwi0Lr9T4Kg8fGFDQyBHQ==
X-CSE-MsgGUID: HV/0SB5LT4OYIwWcHwTocg==
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="260276296"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jul 2024 22:12:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jul 2024 22:12:00 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 17 Jul 2024 22:11:59 -0700
Date: Thu, 18 Jul 2024 10:38:52 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <horms@kernel.org>,
	<hkallweit1@gmail.com>, <richardcochran@gmail.com>, <rdunlap@infradead.org>,
	<linux@armlinux.org.uk>, <bryan.whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V2 0/4] Add support to PHYLINK for
 LAN743x/PCI11x1x chips
Message-ID: <ZpijZH4pwymNbefz@HYD-DK-UNGSW21.microchip.com>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
 <2d8d38c2-0781-47ff-bff8-aec57d68ef05@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <2d8d38c2-0781-47ff-bff8-aec57d68ef05@lunn.ch>

Hi Andrew,

Thank you for review the patches.

The 07/18/2024 05:27, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Tue, Jul 16, 2024 at 05:03:45PM +0530, Raju Lakkaraju wrote:
> > This is the follow-up patch series of
> > https://lkml.iu.edu/hypermail/linux/kernel/2310.2/02078.html
> >
> > Divide the PHYLINK adaptation and SFP modifications into two separate patch
> > series.
> 
> You appear to be missing the PHYLINK maintainer in your Cc: list.
> 
I add all PHYLINK maintainers email id's in cc

i.e.
$ ./scripts/get_maintainer.pl drivers/net/phy/phylink.c
Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT)
Andrew Lunn <andrew@lunn.ch> (maintainer:ETHERNET PHY LIBRARY)
Heiner Kallweit <hkallweit1@gmail.com> (maintainer:ETHERNET PHY LIBRARY)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
netdev@vger.kernel.org (open list:SFF/SFP/SFP+ MODULE SUPPORT)
linux-kernel@vger.kernel.org (open list)

Do i need to add any more PHY maintainer id's apart from above list ?

>         Andrew

-- 
Thanks,                                                                         
Raju

