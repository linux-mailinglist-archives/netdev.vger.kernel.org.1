Return-Path: <netdev+bounces-114900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF3944A18
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3421F29CA6
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1645418452D;
	Thu,  1 Aug 2024 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NSJ/FhQ6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969E16DC03;
	Thu,  1 Aug 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510543; cv=none; b=GLUDesLlCOwgWdJUcyzegQkH/ToDHqH/n0n73iS8omYrSKMH8wQpvn+AebXNoGtgWhiqjOFOiWlG8qxfpImmkNre1Rw1jZRQJA+PD9Ns1OtcFqwOYST6Dk5JKGpHj+eC6TYJF5pdKoAoBR6W9N3MSCdtmf2NQh+PGtnrG8Kx+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510543; c=relaxed/simple;
	bh=jYHJ3jULPzzri0UFSQOLI1ksRW5bEfCe/jyKBeSnOag=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0rFze925HCvtjiqnjeXZsgcIKdYx215mqmvva4p8817Eyq1Yw7/0cKaSGv75TPRhlrjER9GxbK0wWrT7buI+YJ+flWtmaIZ8u10+PGsXKB7pZ49fH0nwgHbf6HSICvHs7/Y+gr4nPyEFE3pHTdk+BM+LBlBU7iLIR3Jro+xg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NSJ/FhQ6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722510541; x=1754046541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jYHJ3jULPzzri0UFSQOLI1ksRW5bEfCe/jyKBeSnOag=;
  b=NSJ/FhQ6z6yMO5cqPzJGSI9nh71CNTyZH/3c2fPo0Ks1BkkqQYTY4UXJ
   3IQWvOFKsLn7h2obh9WfyylMv3fb86lc5NmUkk/ijGKSpZ4mGBniHNVyh
   4p2pPboMX5P8x5qp28oX6HqY4wmu3Lpzibx8Cn1otR6QACGe+Ff3m3DbD
   QPTZyvUKtkn5zyVjBC22PhapEJxk5hoCsUch3+wTQKQLBSLGPuNqvbMzs
   dAbnNCAaJF39PiUAF2skmPvTByJeZM348MLUANHGbavlP6M5vTtEiN7Wm
   NvtM4EPxBA0Jt3THAlFmF4Z4YbDfFAxH/iF4u3nqyeqMl0PGz0aFLguMu
   A==;
X-CSE-ConnectionGUID: R187luJxSuSsG9JWis5GFw==
X-CSE-MsgGUID: wG0Rg6+8SjqqEXaVQi29MA==
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="30631067"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Aug 2024 04:08:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Aug 2024 04:08:49 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 1 Aug 2024 04:08:48 -0700
Date: Thu, 1 Aug 2024 16:35:33 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <andrew@lunn.ch>,
	<horms@kernel.org>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <Bryan.Whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V3 4/4] net: lan743x: Add support to ethtool
 phylink get and set settings
Message-ID: <Zqtr/ezTMkButA8j@HYD-DK-UNGSW21.microchip.com>
References: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
 <20240730140619.80650-5-Raju.Lakkaraju@microchip.com>
 <ZqkCj9gENW5ILWED@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ZqkCj9gENW5ILWED@shell.armlinux.org.uk>

Hi Russell King,

The 07/30/2024 16:11, Russell King (Oracle) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Tue, Jul 30, 2024 at 07:36:19PM +0530, Raju Lakkaraju wrote:
> > diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> > index 3a63ec091413..a649ea7442a4 100644
> > --- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
> > +++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
> > @@ -1058,61 +1058,48 @@ static int lan743x_ethtool_get_eee(struct net_device *netdev,
> >                                  struct ethtool_keee *eee)
> >  {
> >       struct lan743x_adapter *adapter = netdev_priv(netdev);
> > -     struct phy_device *phydev = netdev->phydev;
> > -     u32 buf;
> > -     int ret;
> > -
> > -     if (!phydev)
> > -             return -EIO;
> > -     if (!phydev->drv) {
> > -             netif_err(adapter, drv, adapter->netdev,
> > -                       "Missing PHY Driver\n");
> > -             return -EIO;
> > -     }
> >
> > -     ret = phy_ethtool_get_eee(phydev, eee);
> > -     if (ret < 0)
> > -             return ret;
> > -
> > -     buf = lan743x_csr_read(adapter, MAC_CR);
> > -     if (buf & MAC_CR_EEE_EN_) {
> > -             /* EEE_TX_LPI_REQ_DLY & tx_lpi_timer are same uSec unit */
> > -             buf = lan743x_csr_read(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT);
> > -             eee->tx_lpi_timer = buf;
> > -     } else {
> > -             eee->tx_lpi_timer = 0;
> > -     }
> > +     eee->tx_lpi_timer = lan743x_csr_read(adapter,
> > +                                          MAC_EEE_TX_LPI_REQ_DLY_CNT);
> > +     eee->eee_enabled = adapter->eee_enabled;
> > +     eee->eee_active = adapter->eee_active;
> > +     eee->tx_lpi_enabled = adapter->tx_lpi_enabled;
> 
> You really need to start paying attention to the commits other people
> make as a result of development to other parts of the kernel.
> 
> First, see:
> 
> commit ef460a8986fa0dae1cdcb158a06127f7af27c92d
> Author: Andrew Lunn <andrew@lunn.ch>
> Date:   Sat Apr 6 15:16:00 2024 -0500
> 
>     net: lan743x: Fixup EEE
> 
> and note that the assignment of eee->eee_enabled, eee->eee_active, and
> eee->tx_lpi_enabled were all removed.
> 

Accepted. I will fix

> Next...
> 
> >
> > -     return 0;
> > +     return phylink_ethtool_get_eee(adapter->phylink, eee);
> 
> phylink_ethtool_get_eee() will call phy_ethtool_get_eee(), which
> in turn calls genphy_c45_ethtool_get_eee() and eeecfg_to_eee().
> 
> genphy_c45_ethtool_get_eee() will do this:
> 
>         data->eee_enabled = is_enabled;
>         data->eee_active = ret;
> 
> thus overwriting your assignment to eee->eee_enabled and
> eee->eee_active.
> 
> eeecfg_to_eee() will overwrite eee->tx_lpi_enabled and
> eee->eee_enabled.
> 
> Thus, writing to these fields and then calling
> phylink_ethtool_get_eee() results in these fields being overwritten.
> 

Ok. I will fix.

> >  static int lan743x_ethtool_set_eee(struct net_device *netdev,
> >                                  struct ethtool_keee *eee)
> >  {
> > -     struct lan743x_adapter *adapter;
> > -     struct phy_device *phydev;
> > -     u32 buf = 0;
> > +     struct lan743x_adapter *adapter = netdev_priv(netdev);
> >
> > -     if (!netdev)
> > -             return -EINVAL;
> > -     adapter = netdev_priv(netdev);
> > -     if (!adapter)
> > -             return -EINVAL;
> > -     phydev = netdev->phydev;
> > -     if (!phydev)
> > -             return -EIO;
> > -     if (!phydev->drv) {
> > -             netif_err(adapter, drv, adapter->netdev,
> > -                       "Missing PHY Driver\n");
> > -             return -EIO;
> > -     }
> > +     if (eee->tx_lpi_enabled)
> > +             lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT,
> > +                               eee->tx_lpi_timer);
> > +     else
> > +             lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, 0);
> >
> > -     if (eee->eee_enabled) {
> > -             buf = (u32)eee->tx_lpi_timer;
> > -             lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, buf);
> > -     }
> > +     adapter->eee_enabled = eee->eee_enabled;
> > +     adapter->tx_lpi_enabled = eee->tx_lpi_enabled;
> 
> Given that phylib stores these and overwrites your copies in the get_eee
> method above, do you need to store these?
> 

OK

> > @@ -3013,7 +3025,12 @@ static void lan743x_phylink_mac_link_down(struct phylink_config *config,
> >                                         unsigned int link_an_mode,
> >                                         phy_interface_t interface)
> >  {
> > +     struct net_device *netdev = to_net_dev(config->dev);
> > +     struct lan743x_adapter *adapter = netdev_priv(netdev);
> > +
> >       netif_tx_stop_all_queues(to_net_dev(config->dev));
> > +     adapter->eee_active = false;
> 
> phylib tracks this for you.
> 

Ok

> > +     lan743x_set_eee(adapter, false);
> >  }
> >
> >  static void lan743x_phylink_mac_link_up(struct phylink_config *config,
> > @@ -3055,6 +3072,14 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
> >                                         cap & FLOW_CTRL_TX,
> >                                         cap & FLOW_CTRL_RX);
> >
> > +     if (phydev && adapter->eee_enabled) {
> > +             bool enable;
> > +
> > +             adapter->eee_active = phy_init_eee(phydev, false) >= 0;
> > +             enable = adapter->eee_active && adapter->tx_lpi_enabled;
> 
> No need. Your enable should be conditional on phydev->enable_tx_lpi
> here. See Andrew's commit and understand his changes, rather than
> just ignoring Andrew's work and continuing with your old pattern of
> EEE support. Things have moved forward.

Ok. I will fix

> 
> Thanks.
> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
Thanks,                                                                         
Raju

