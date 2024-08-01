Return-Path: <netdev+bounces-114899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE16944A08
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB04BB20B5E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C032C183CA7;
	Thu,  1 Aug 2024 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zrs1ICXV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF83E47B;
	Thu,  1 Aug 2024 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510434; cv=none; b=S68deJimxvJ+LyH6LAvxtJGRho4l5CF6YXlLcb+sS/7ssgv/rPn8E7UhXKbRNRAFFZP4pWhM09Zr6YonIDrzTAy5Kbbv0yiRoXWHmV7uR5V4eQdNqF8Z9xbcUGVZbhSQnJxPbBzEMwNZ81rA5i5u+F6+QiQ/flNb630zgvU1MCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510434; c=relaxed/simple;
	bh=31mM82ebSebB9a5nveyhbtj2mdaB7JaaiK1wFzqXGf8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSOLqYPZC3D+C0Wl1t1ZfFbQWSfNoWVDrW/FEMCOPFFwr7QP9RZBsddjZ6mDulsLl5lxlHJIBZTi4ZF4cS7yNO1d2I8xRaABLS+Kk9hOtad+4zaqSAJ5RMunDwYQPiKn04B7Oq7dB2KD74AP9ESNhPZ9EPPmHBAvXGH9FpkzHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zrs1ICXV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722510432; x=1754046432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=31mM82ebSebB9a5nveyhbtj2mdaB7JaaiK1wFzqXGf8=;
  b=zrs1ICXVp1dFUkdNv3ykMg5DO+Ipbn/dYuEXYgzbR3lzTRBpigUGm6JM
   dGFU+BdBA3jVrg80pC84CH9PpDsTCBtzEJPXDBZP/qjjYL+1o/OMoFFCl
   52ff4GyhrTPtjmBFCPcvzUoUy8GY/RTshuhFnA05pLlCq4r2Sg8rplIHI
   B11NuySETwXk/WOaiagVucPL7pvGktIvukqwlsJkPFTCBaAdbS+afGDkF
   9LwmRsSfqGzmbk0sOSbqsy/+etfS+L2yV8BZi7fTIjSo0CETWphQXS8ka
   hV3cqG7Hb0TzQhBvqYBxFD+Wm930ruKmGuC/aK5e4mkzwHAWNF6QEBIt9
   Q==;
X-CSE-ConnectionGUID: KTsYQVRSSuyctp97GVx0PQ==
X-CSE-MsgGUID: HNcQmoaaQq2ma9hafXCacQ==
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="30631010"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Aug 2024 04:07:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Aug 2024 04:06:29 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 1 Aug 2024 04:06:28 -0700
Date: Thu, 1 Aug 2024 16:33:13 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <andrew@lunn.ch>,
	<horms@kernel.org>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <Bryan.Whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phylink
Message-ID: <ZqtrcRfRVBR6H9Ri@HYD-DK-UNGSW21.microchip.com>
References: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
 <20240730140619.80650-4-Raju.Lakkaraju@microchip.com>
 <Zqj/Mdoy5rhD2YXx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <Zqj/Mdoy5rhD2YXx@shell.armlinux.org.uk>

Hi Russell King,

Thank you for review the patches.

The 07/30/2024 15:56, Russell King (Oracle) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Tue, Jul 30, 2024 at 07:36:18PM +0530, Raju Lakkaraju wrote:
> > +     default:
> > +             __set_bit(PHY_INTERFACE_MODE_RGMII,
> > +                       adapter->phylink_config.supported_interfaces);
> > +             __set_bit(PHY_INTERFACE_MODE_RGMII_ID,
> > +                       adapter->phylink_config.supported_interfaces);
> > +             __set_bit(PHY_INTERFACE_MODE_RGMII_RXID,
> > +                       adapter->phylink_config.supported_interfaces);
> > +             __set_bit(PHY_INTERFACE_MODE_RGMII_TXID,
> > +                       adapter->phylink_config.supported_interfaces);
> 
> There's a shorter way to write this:
> 
>                 phy_interface_set_rgmii(adapter->phylink_config.supported_interfaces);

Ok. I will change.

> 
> > +static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
> > +{
> > +     struct device_node *dn = adapter->pdev->dev.of_node;
> > +     struct net_device *dev = adapter->netdev;
> > +     struct fixed_phy_status fphy_status = {
> > +             .link = 1,
> > +             .speed = SPEED_1000,
> > +             .duplex = DUPLEX_FULL,
> > +     };
> > +     struct phy_device *phydev;
> > +     int ret;
> > +
> > +     if (dn)
> > +             ret = phylink_of_phy_connect(adapter->phylink, dn, 0);
> > +
> > +     if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
> > +             phydev = phy_find_first(adapter->mdiobus);
> > +             if (!phydev) {
> > +                     if (((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
> > +                           ID_REV_ID_LAN7431_) || adapter->is_pci11x1x) {
> > +                             phydev = fixed_phy_register(PHY_POLL,
> > +                                                         &fphy_status,
> > +                                                         NULL);
> 
> I thought something was going to happen with this?

Our SQA confirmed that it's working ping as expected (i.e Speed at 1Gbps
with full duplex) with Intel I210 NIC as link partner.

Do you suspect any corner case where it's fail?
 
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
Thanks,                                                                         
Raju

