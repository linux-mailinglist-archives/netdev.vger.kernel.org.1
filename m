Return-Path: <netdev+bounces-213654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D700B261B1
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A38583780
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24C32F7443;
	Thu, 14 Aug 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wROdkiKb"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DAB2741CD;
	Thu, 14 Aug 2025 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165566; cv=none; b=e7EU5/vSHoKSoew4aOGsBWCadLMaNIOmox01SvjUcQbQX2e/9o08Mw0ajiHelKCg8tiTa8eKq+veznQpJaQmTeAwZtOzx2NVCk8Lz5cc02RPMVnyu8aI7tp8FjVVwdnFjZPIHNjTpchXcEYoPd1mr3Sbw1WYPEPzwdCl47KCl+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165566; c=relaxed/simple;
	bh=xeT0dGXRv1bptAHCQGFx8vyfq1VIKHXEDhIsjHpAn+I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkedqjzUXXsOqd1mXzvT8P6oJRsjDt4udDG5KhYaoCCJMFMG9pRVh0/kgra/HadVNnTud0z0BvhYLG3BbQ/5BxJTmPX4wCgKXa0G+HjJoXwKPlUJd2xWRbx2yN0M7ujbm3mNvlrK/voNgbngVoIx6JRzns1v2gs6Jb/pJEdFGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wROdkiKb; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755165565; x=1786701565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xeT0dGXRv1bptAHCQGFx8vyfq1VIKHXEDhIsjHpAn+I=;
  b=wROdkiKbFds4g0pFbu+7j4WaCY77KxRSuTrkw4D/9FTBjWANY4dUxGBL
   fZYBWebf46e7u9ww0V2cXukPdwQ1M6eY5IEpL6adFvZFI8bruZn904+FL
   eYaZ/E0jfJkDoyfoHVO1qJX4cGli98M/6W5sXr6WmvkuAeJk+QSoEIEja
   rwbt0PcFP8H9kq/qBocyex7sPATriFL8/StaYmYvho4oM2deU686sY/Vv
   2TZnPL9R0VDX70ZckdbvF3ZLr1TLnC7wzVPESqGp1UJRPI/kAA5fHT9c1
   YEpV3FEJN6bTv8QqTm9GswHku9ogF2ttbD2s82u1gR+0fcoa2i9pDKDRY
   w==;
X-CSE-ConnectionGUID: F9m7b+GcTjmxrNK+m1cJwg==
X-CSE-MsgGUID: P7PiFCzbRsa/fECHcHxhpg==
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="50711981"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2025 02:59:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 14 Aug 2025 02:58:43 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 14 Aug 2025 02:58:43 -0700
Date: Thu, 14 Aug 2025 11:55:26 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<alok.a.tiwari@oracle.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 4/4] net: phy: micrel: Add support for lan8842
Message-ID: <20250814095526.v3ft2d55piohvhby@DEN-DL-M31836.microchip.com>
References: <20250814082624.696952-1-horatiu.vultur@microchip.com>
 <20250814082624.696952-5-horatiu.vultur@microchip.com>
 <aJ2qd9SkUPg5tmYL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aJ2qd9SkUPg5tmYL@shell.armlinux.org.uk>

The 08/14/2025 10:20, Russell King (Oracle) wrote:

Hi Russell,

> On Thu, Aug 14, 2025 at 10:26:24AM +0200, Horatiu Vultur wrote:
> > +static int lan8842_config_init(struct phy_device *phydev)
> > +{
> > +     int ret;
> > +
> > +     /* Reset the PHY */
> > +     ret = lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> > +                                  LAN8814_QSGMII_SOFT_RESET,
> > +                                  LAN8814_QSGMII_SOFT_RESET_BIT,
> > +                                  LAN8814_QSGMII_SOFT_RESET_BIT);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Disable ANEG with QSGMII PCS Host side
> > +      * It has the same address as lan8814
> > +      */
> > +     ret = lanphy_modify_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
> > +                                  LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
> > +                                  LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA,
> > +                                  0);
> > +     if (ret < 0)
> > +             return ret;
> 
> Could you explain exactly what effect this has please?

The effect of this and the next write is to disable the auto-negotiation
between the PHY and the MAC.

> 
> > +
> > +     /* Disable also the SGMII_AUTO_ANEG_ENA, this will determine what is the
> > +      * PHY autoneg with the other end and then will update the host side
> > +      */
> > +     ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> > +                                 LAN8842_SGMII_AUTO_ANEG_ENA, 0);
> > +     if (ret < 0)
> > +             return ret;
> 
> Also please explain this a bit more.

This write disables the PHY to update the host side advertise abilities
with what it autonegotiate on the link side. I will need to double check
but I think this is not needed if the autonegotiation on the host side
is already disabled.

> 
> If this changes whether host-side "negotiation" is used, then please
> consider implementing the two phy driver inbnad operations as well.

Yes, I will implement the functions: config_inband and inband_caps.

> 
> > +static u64 lan8842_get_stat(struct phy_device *phydev, int count, int *regs)
> > +{
> > +     int val;
> i> +    u64 ret = 0;
> 
> Please remember... reverse Christmas tree for variable declarations.

Argh.. goot catch!

> 
> Thanks.
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
/Horatiu

