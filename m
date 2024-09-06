Return-Path: <netdev+bounces-125844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A652196EE9F
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3DB286E7C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF26157E61;
	Fri,  6 Sep 2024 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Kh68HxSI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685C53376;
	Fri,  6 Sep 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613053; cv=none; b=mn412L860tUSyjgtYdiDb0vz55uyddvf4QzH7MDYsZHUmaTowHicXe6XD0iP9P156JnOTAUWzfKfUso15RlGGJJjMzAA0dO5ssuou0Y/wbzXG1e2/4UMEpMQOONU2sZZ+lkg3wur13Dlw2CwuZlOGPGlaJ16b3/DwE6dVQQhsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613053; c=relaxed/simple;
	bh=aFUeVODQjMQy+fAcAaN2UvE3fQPybs5hbHXpRE+xB8c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL7eBoDIRYzlgfqYHvJng9639iwOmw3nkDlO08cF9WChQh95zvWRGcpbUXLeQbuaOuBj2FaAl/w0A5/RL+vhj0QJz9XC8IarR70tDiHf7iPoPnZjjLW6yGsXuQRSohotwawRF37CBvh5Di20sy/AghXDU/NoR9BuOOKKJxuQdu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Kh68HxSI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725613051; x=1757149051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aFUeVODQjMQy+fAcAaN2UvE3fQPybs5hbHXpRE+xB8c=;
  b=Kh68HxSIaTz4j2J1Kg4Z8Ic6BmzcHyvNfqoryst2Tw2UWlbBoWk4pCAE
   yklAgqJinS5p01LCwLctUpBBK0SzQXARgOEWff192EKekER7Zx1UIzzCP
   xvCbSz5qteTFT8sng7rmbxIYLQ0msWMGMpFvUkcG7e/gb8tsJfgotiBUB
   6EqcJOnJNV/Umz3d9Gm7IADSmVrBnpAJel8beuz3IP4elrPw0LNWTwIif
   O/vw9KCL2PAccGgeGEL+nEughqDRftUik2uhE9lFG/XSQ8aaOyo40Mj3P
   gqId60nSTUgvNQlI5Tdd9n23gpJJi4CFJJoehtsnd+NJSccTp8QANLwj0
   w==;
X-CSE-ConnectionGUID: G5wQRom0R4mVf5hBNXy5nQ==
X-CSE-MsgGUID: EPETK67MRtOBdfO8H1hoLA==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="31411637"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 01:57:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Sep 2024 01:57:02 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 6 Sep 2024 01:57:02 -0700
Date: Fri, 6 Sep 2024 14:23:18 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<hkallweit1@gmail.com>, <richardcochran@gmail.com>, <rdunlap@infradead.org>,
	<bryan.whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<maxime.chevallier@bootlin.com>, <linux-kernel@vger.kernel.org>,
	<horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V5 4/5] net: lan743x: Migrate phylib to phylink
Message-ID: <ZtrC/sCeXN5IgjWd@HYD-DK-UNGSW21.microchip.com>
References: <20240904090645.8742-1-Raju.Lakkaraju@microchip.com>
 <20240904090645.8742-5-Raju.Lakkaraju@microchip.com>
 <cad5b31d-7713-4a1d-88e4-58d6878e90c5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <cad5b31d-7713-4a1d-88e4-58d6878e90c5@lunn.ch>

Hi Andrew,

Thank you for review the patches.

The 09/05/2024 15:11, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> > +static struct {
> > +     unsigned long mask;
> > +     int speed;
> > +     int duplex;
> > +} lan743x_mac_caps_params[] = {
> > +     { MAC_2500FD,   SPEED_2500,   DUPLEX_FULL },
> > +     { MAC_1000FD,   SPEED_1000,   DUPLEX_FULL },
> > +     { MAC_100FD,    SPEED_100,    DUPLEX_FULL },
> > +     { MAC_10FD,     SPEED_10,     DUPLEX_FULL },
> > +     { MAC_100HD,    SPEED_100,    DUPLEX_HALF },
> > +     { MAC_10HD,     SPEED_10,     DUPLEX_HALF },
> > +};
> > +
> > +static int lan743x_find_max_speed(unsigned long caps, int *speed, int *duplex)
> > +{
> > +     int i;
> > +
> > +     *speed = SPEED_UNKNOWN;
> > +     *duplex = DUPLEX_UNKNOWN;
> > +     for (i = 0; i < ARRAY_SIZE(lan743x_mac_caps_params); i++) {
> > +             if (caps & lan743x_mac_caps_params[i].mask) {
> > +                     *speed = lan743x_mac_caps_params[i].speed;
> > +                     *duplex = lan743x_mac_caps_params[i].duplex;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return *speed == SPEED_UNKNOWN ? -EINVAL : 0;
> > +}
> > +
> > +static int lan743x_phylink_create(struct lan743x_adapter *adapter)
> > +{
> > +     struct net_device *netdev = adapter->netdev;
> > +     struct phylink *pl;
> > +
> > +     adapter->phylink_config.dev = &netdev->dev;
> > +     adapter->phylink_config.type = PHYLINK_NETDEV;
> > +     adapter->phylink_config.mac_managed_pm = false;
> > +
> > +     adapter->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
> > +             MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000FD;
> > +
> 
> 
> > +     case PHY_INTERFACE_MODE_SGMII:
> > +             __set_bit(PHY_INTERFACE_MODE_SGMII,
> > +                       adapter->phylink_config.supported_interfaces);
> > +             __set_bit(PHY_INTERFACE_MODE_1000BASEX,
> > +                       adapter->phylink_config.supported_interfaces);
> > +             __set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > +                       adapter->phylink_config.supported_interfaces);
> > +             adapter->phylink_config.mac_capabilities |= MAC_2500FD;
> 
> 
> > +static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
> > +{
> > +     struct device_node *dn = adapter->pdev->dev.of_node;
> > +     struct net_device *dev = adapter->netdev;
> > +     struct phy_device *phydev;
> > +     int ret;
> > +
> > +     if (dn)
> > +             ret = phylink_of_phy_connect(adapter->phylink, dn, 0);
> > +
> > +     if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
> > +             phydev = phy_find_first(adapter->mdiobus);
> > +             if (phydev) {
> > +                     /* attach the mac to the phy */
> > +                     ret = phylink_connect_phy(adapter->phylink, phydev);
> > +             } else if (((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
> > +                           ID_REV_ID_LAN7431_) || adapter->is_pci11x1x) {
> > +                     struct phylink_link_state state;
> > +                     unsigned long caps;
> > +
> > +                     caps = adapter->phylink_config.mac_capabilities;
> > +                     ret = lan743x_find_max_speed(caps, &state.speed,
> > +                                                  &state.duplex);
> 
> This seems like an overly complicated way to determine the speed. If
> MAC_2500FD is set, you know it is 2500. Otherwise it must by 1000. Why
> not use a simple if?

Ok. I will fix

> 
> I'm not the best at reviewing phylink patches, but since Russell is
> off-lime, i'm the best you have. So
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> but please do consider simplifying the code above.
> 
>     Andrew

-- 
Thanks,                                                                         
Raju

