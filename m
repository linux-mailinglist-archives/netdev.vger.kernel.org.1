Return-Path: <netdev+bounces-213618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B78B25E65
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8874189F837
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ECA2E2664;
	Thu, 14 Aug 2025 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I5BA8u3O"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F12DEA7D;
	Thu, 14 Aug 2025 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158877; cv=none; b=iU4BB2kKBSkUhs7/b+7nTcClBzDAu33W3DtbHBsWM7jN7pn8XwlLICru0rJN+K0KrxB4w6S3cBYYwzA/dKofITgM/NttC8M9T7SySU7AbzEc0WQkfBaFEHA6ojaQ3eqRY5Ie8YcrOBrTliV1w+6rAyAsRGX9z3zSRBCE17t3hqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158877; c=relaxed/simple;
	bh=PZPM7meDx2Gyvh3HYYPLVAPrBTz8aV7EF5SdK5XKU6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIbY81JnrwhrZ9mmUFvEuJwFmSXzf6Ccr1HYcRs89LaqQQq6saH9IzD0R0qQ+CvFKRkDlDGbmPv1DzKH8jYu6MyUNoKpLe3Mz4uQIJMWZQX1y5InDWqcmWpEyepIYI8kT9BZwipep+eKDxIXrBnMW44ZGrju1D1eQ78fOAAyRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I5BA8u3O; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755158876; x=1786694876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PZPM7meDx2Gyvh3HYYPLVAPrBTz8aV7EF5SdK5XKU6c=;
  b=I5BA8u3O4grhizt323NtRqGeiXSdF2vMaTzNjl4LKkFumdk9PmoympPb
   TW+Fqs9wPzAafUNWvliOhcb+hFJv9GcTKfM61toAUX739BaAexmmGQqNK
   mu4VnQ8Us5IVda1ZwxdmjHJuq4x19V8i1HDa4F16QFOzudpsz8bOBSeKJ
   stoV6adXXpZKtVYQFAodxdSUkZ96xzAVT4KEy9aucBomLDDxm0F3URF0M
   3996H/xyi9FjpyRKnNWVzf2hLtAFGZi7TXL60WbbsE+4TURjZKuRL4fyR
   /CdB96YXpxLibDFLiq/tYqjovsoZTJ7diMDd2Ch+k0XW5FgxlT5i0ySk8
   A==;
X-CSE-ConnectionGUID: sBxkgD5GTO+OjeSPvacauQ==
X-CSE-MsgGUID: MSyXl6cOTTeaSoZ8RkRdgg==
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="276580983"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2025 01:07:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 14 Aug 2025 01:07:43 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 14 Aug 2025 01:07:43 -0700
Date: Thu, 14 Aug 2025 10:04:26 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<alok.a.tiwari@oracle.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/3] net: phy: micrel: Introduce
 lanphy_modify_page_reg
Message-ID: <20250814080426.7xl53jzcey6rycby@DEN-DL-M31836.microchip.com>
References: <20250813063044.421661-1-horatiu.vultur@microchip.com>
 <20250813063044.421661-2-horatiu.vultur@microchip.com>
 <aJw_aMhqa4M9Jy1j@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aJw_aMhqa4M9Jy1j@shell.armlinux.org.uk>

The 08/13/2025 08:31, Russell King (Oracle) wrote:

Hi Russell,

> 
> On Wed, Aug 13, 2025 at 08:30:42AM +0200, Horatiu Vultur wrote:
> > +static int lanphy_modify_page_reg(struct phy_device *phydev, int page, u16 addr,
> > +                               u16 mask, u16 set)
> > +{
> > +     int ret;
> > +
> > +     phy_lock_mdio_bus(phydev);
> > +     __phy_write(phydev, LAN_EXT_PAGE_ACCESS_CONTROL, page);
> > +     __phy_write(phydev, LAN_EXT_PAGE_ACCESS_ADDRESS_DATA, addr);
> > +     __phy_write(phydev, LAN_EXT_PAGE_ACCESS_CONTROL,
> > +                 (page | LAN_EXT_PAGE_ACCESS_CTRL_EP_FUNC));
> > +     ret = __phy_modify_changed(phydev, LAN_EXT_PAGE_ACCESS_ADDRESS_DATA,
> > +                                mask, set);
> > +     if (ret < 0)
> > +             phydev_err(phydev, "Error: __phy_modify_changed has returned error %d\n",
> > +                        ret);
> 
> Error: is not necessary, we have log levels.
> 
> What would be useful is to print the readable version of the error, and
> it probably makes sense to do it outside of the bus lock.
> 
> > +
> > +     phy_unlock_mdio_bus(phydev);
> 
>         if (ret < 0)
>                 phydev_err(phydev, "__phy_modify_changed() failed: %pe\n",
>                            ERR_PTR(ret));

Thanks for suggestion. I will update this in the next version.

> 
> Thanks.
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
/Horatiu

