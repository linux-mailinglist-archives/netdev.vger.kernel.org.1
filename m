Return-Path: <netdev+bounces-44455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3087D8074
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 12:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6AE281CAD
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553802D036;
	Thu, 26 Oct 2023 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kaCMsmaY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6072C1A281
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 10:15:55 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DEE195;
	Thu, 26 Oct 2023 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698315353; x=1729851353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RFivSlyyCN0/u7lSbSw417gmoKe6JNs1oDbyCj3MVR4=;
  b=kaCMsmaYekSE08V0cbsbKN4O6O1G4U19FHs/zynjndJufwtvI+ZZs6UO
   54G1g1+AB5XSuFc8Y7XQW3588li782VIrRVGjRDQaQgXU7B/MW4+oZup3
   U0c/7DrWXO/rxC18u0LuuD/NCbuutJ8UupJPzlVYamEKBkkZsGJwZvXd+
   uGihGVtzMJI0b7TlwJG5U/QZNDGJblnirPRMUGbgJRRNmR9XhbW5QPPAB
   iceEoCG1a4mggEObgShgLScM3Xpq6sLZlfJSpVfSg9aVfv4i9Lve2tXQA
   LEA3k55gLndQXU2XOdsIlfbkslzWCHTV/i+exI+DHSMfI1XW+UPQoZgmG
   A==;
X-CSE-ConnectionGUID: uV9XzKt9TfK6K5PKhz3XAg==
X-CSE-MsgGUID: tkN/U9bESHWBxLYxXil25A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="177802887"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2023 03:15:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 26 Oct 2023 03:15:47 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 26 Oct 2023 03:15:46 -0700
Date: Thu, 26 Oct 2023 15:44:40 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <Jose.Abreu@synopsys.com>,
	<fancer.lancer@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V1] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <ZTo8EL7JhmqY56J0@HYD-DK-UNGSW21>
References: <20231026054305.336968-1-Raju.Lakkaraju@microchip.com>
 <ZToq3n26jDqiueTB@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ZToq3n26jDqiueTB@shell.armlinux.org.uk>

Hi Russell King,

Thank you for review the patch.

The 10/26/2023 10:01, Russell King (Oracle) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Thu, Oct 26, 2023 at 11:13:05AM +0530, Raju Lakkaraju wrote:
> > +     sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
> > +
> > +     state->link = !!(sts & DW_VR_MII_MMD_STS_LINK_STS);
> > +     if (!state->link) {
> > +             state->speed = SPEED_UNKNOWN;
> > +             state->pause = MLO_PAUSE_NONE;
> > +             state->duplex = DUPLEX_UNKNOWN;
> > +             return 0;
> > +     }
> 
> You don't need this. If autoneg is enabled then these are initialised
> prior to calling this by phylink using:
> 
>                 state->speed = SPEED_UNKNOWN;
>                 state->duplex = DUPLEX_UNKNOWN;
>                 state->pause = MLO_PAUSE_NONE;
> 

Ok. I will remove the change.

Thanks,
Raju

> or if not using autoneg:
> 
>                 state->speed =  pl->link_config.speed;
>                 state->duplex = pl->link_config.duplex;
>                 state->pause = pl->link_config.pause;
> 
> so you don't need to touch them if the link is down.
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
--------                                                                        
Thanks,                                                                         
Raju

