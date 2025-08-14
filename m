Return-Path: <netdev+bounces-213651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F752B26181
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176A57A9FCE
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F092F60BA;
	Thu, 14 Aug 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nCQJ2Dh8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA22F60C2;
	Thu, 14 Aug 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165146; cv=none; b=VAteC5+RneRj7JbWGvwmqh96sznePjRdsYgdIk0F2eaMqaAtwxArkBO5ZcWl/Tr7VGzWsxKzvs/KMoUzxk2HBrU8uVgJRNdqdQgqKbZikvmZWLK9jcuOdd3TmqjPQv9PkTAENdmsaHFBB1z7Olvu1kI4hjqFiYpL4BcibLUgy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165146; c=relaxed/simple;
	bh=misePll3ECBb8a6M2wwdvZstJOjHFrMN7LnrYSzeMpM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHAyeA7RI1dq3Cpky3xc7YEhSQuam2aGHEXZ/Gp3ReJRRel8ksTMKv11l2y8Kgq70x7IpMMWS5Ly/rdxtIQD6qtTk51xx5yPDpUOJh6y09Qj8N5whChRI7u5DO26Py6JETAFCbdbTAARarS4ABJ9gmOe+RBr9tmAspzgkXPJxgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nCQJ2Dh8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755165145; x=1786701145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=misePll3ECBb8a6M2wwdvZstJOjHFrMN7LnrYSzeMpM=;
  b=nCQJ2Dh8U31+sETIV6b0hrRWMSEjy48uFBy8eMgAZT74GS8HselTgrzM
   t+nE/erQ04XkCcQ5ti2TdnzdMuLtKtrw9z8d3uzq5ukNMx2kdLOjsIHrg
   VbDClBkuJ6hILZPKO05OBwrWc5jnTg3brFIbMEn01dQU8tPDlSHugW25S
   GjXaYUl2eLTPqCdnHVBZq9TB/VfohsHGnXeeilPMQhXopvVJbM6XjXYXZ
   AJNP0noNZqZAd5X34KR9nL30C7RU2YIXmGWtA1T9eE42ENLjZC8fDoRAE
   dEEAiocERXacNS7az93FI3OYI3VKgWasYFobxd+ecd5lEYc2Xw9BBY5lR
   g==;
X-CSE-ConnectionGUID: fQJ0eNneSP2eGfB28XrYdg==
X-CSE-MsgGUID: 6r3nhnl8QT6+HzZl/CecFA==
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="45182527"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2025 02:52:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 14 Aug 2025 02:52:05 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 14 Aug 2025 02:52:04 -0700
Date: Thu, 14 Aug 2025 11:48:48 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<alok.a.tiwari@oracle.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/4] net: phy: micrel: Start using
 PHY_ID_MATCH_MODEL
Message-ID: <20250814094848.ffjslpwlajwaqukf@DEN-DL-M31836.microchip.com>
References: <20250814082624.696952-1-horatiu.vultur@microchip.com>
 <20250814082624.696952-2-horatiu.vultur@microchip.com>
 <aJ2sHPDAkaQq5jjC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aJ2sHPDAkaQq5jjC@shell.armlinux.org.uk>

The 08/14/2025 10:27, Russell King (Oracle) wrote:

Hi Russell,

> 
> On Thu, Aug 14, 2025 at 10:26:21AM +0200, Horatiu Vultur wrote:
> > Start using PHY_ID_MATCH_MODEL for all the drivers.
> > While at this add also PHY_ID_KSZ8041RNLI to micrel_tbl.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> I'm not sure about this patch. You're subsituting a match that uses
> the desired ID with a mask of 0x00fffff0 with PHY_ID_MATCH_MODEL(id)
> which uses a mask of 0xfffffff0.
> 
> The commit description ought to explain why it is safe to match using
> bits 31:24, whereas the old code was ignoring these bits.

To be honest, I don't know why that old code was ignoring the MSB. I can
see that this has been done like this from 2011. From what I can see the
PHYs has always a value of 0 in the MSB, so I though it would be safe to
update this. Also the MSB contains the Organization Unique Identifier
and I don't think that will change.
I can definetly update the commit message to explain why it is safe to
change the mask.

> 
> Thanks.
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
/Horatiu

