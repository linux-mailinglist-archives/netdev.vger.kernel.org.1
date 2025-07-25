Return-Path: <netdev+bounces-209962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E65EB1189C
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 08:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752065A0139
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 06:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A053D239E6B;
	Fri, 25 Jul 2025 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z4fXY+4+"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12591F2B88;
	Fri, 25 Jul 2025 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426003; cv=none; b=Qm7KERa+IB9Vgh1UG3CNwFvcUsEywqqdXXMQoD5v1A2vFE7i5AnIv3l08sTxpyQu2R925Q+iYfHdb5WeCv9KUzyVwSyYreJOJqUDrWVQMI5BHf1FCpSdEGQu2e4d/gh0H/11jXQxn4Uiv53i/c4OLuq/VMZKRR8evUzqHmvit4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426003; c=relaxed/simple;
	bh=Zd+54Y3inceXc+vIgpXa6b6vYninuhpkOVvXHoKuZ4E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm3ep40la0YrXmu2v7p7qHxoo5ewwb4AL7vXn/QJhmHvLje8ifYg6+WQa5BBCs28knGCA4tXiPb45SQB4nP4YoIiHjTE49JPa2SIUJBRUf3XbqtXF2T7AR1zOi3BBcgkWjKyKGVqaTrs9PIjCNnwqInfM9PcHZtpW7UFJFXLP24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z4fXY+4+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753426001; x=1784962001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zd+54Y3inceXc+vIgpXa6b6vYninuhpkOVvXHoKuZ4E=;
  b=Z4fXY+4+/jhPaEtDZN1UN/F6Nj9p/WdawwhwO63QHEVmI+4uMBgRkeRf
   EmSm8WZgGhqXZ7vV8Zj0A+pnKlslw61nKdSfU5GpdBir2llkU8oe6YmfL
   HvJgnbA5+TSX6oYZSaAkVqFkZ57S5aLA2UGiwBAwd/xk1v2paFYyd0JdG
   Qv2Z4r49vcX4uTZGFkkUBaIwc/UA5XoB+C0byw3MNbcJ78cFwlbE3OELK
   S4eE2MTmE1cPdqxHfdpzPM0XzeCwDazvIxcgJRTFsv0miIzThhS3lQbFM
   4Uxp8bWYK+p8AfcCuIrnzkRKBdHwM2tpsoDv3gygoKIxgUXWqAimoPviU
   w==;
X-CSE-ConnectionGUID: rcERsJM1QxCBN70AEs1UGA==
X-CSE-MsgGUID: 61/072HWSfuVHxUgPKPMfQ==
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="43884697"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2025 23:46:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Jul 2025 23:45:57 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 24 Jul 2025 23:45:57 -0700
Date: Fri, 25 Jul 2025 08:43:04 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/4] net: phy: micrel: Introduce
 lanphy_modify_page_reg
Message-ID: <20250725064304.nrpzgaz6ur3zsidc@DEN-DL-M31836.microchip.com>
References: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
 <20250724200826.2662658-3-horatiu.vultur@microchip.com>
 <aIKaZNI3fo85vw1_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aIKaZNI3fo85vw1_@shell.armlinux.org.uk>

The 07/24/2025 21:41, Russell King (Oracle) wrote:

Hi Russell,

> 
> On Thu, Jul 24, 2025 at 10:08:24PM +0200, Horatiu Vultur wrote:
> > +static int lanphy_modify_page_reg(struct phy_device *phydev, int page, u16 addr,
> > +                               u16 mask, u16 set)
> > +{
> > +     int new, ret;
> > +
> > +     ret = lanphy_read_page_reg(phydev, page, addr);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     new = (ret & ~mask) | set;
> > +     if (new == ret)
> > +             return 0;
> > +
> > +     ret = lanphy_write_page_reg(phydev, page, addr, new);
> 
> Please implement this more safely. Another user could jump in between
> the read and the write and change this same register.
> 
>         phy_lock_mdio_bus(phydev);
>         __phy_write(phydev, LAN_EXT_PAGE_ACCESS_CONTROL, page);
>         __phy_write(phydev, LAN_EXT_PAGE_ACCESS_ADDRESS_DATA, addr);
>         __phy_write(phydev, LAN_EXT_PAGE_ACCESS_CONTROL,
>                     (page | LAN_EXT_PAGE_ACCESS_CTRL_EP_FUNC));
>         ret = __phy_modify_changed(phydev, LAN_EXT_PAGE_ACCESS_ADDRESS_DATA,
>                                    mask, set);
>         if (ret < 0)
>                 phydev_err(phydev, "Error: phy_modify has returned error %d\n",
>                            ret);
> 
> unlock:
>         phy_unlock_mdio_bus(phydev);
> 
>         return ret;
> 
> is all that it'll take (assuming the control/address register doesn't
> need to be rewritten.)

Thanks, I will look into this.

> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
/Horatiu

