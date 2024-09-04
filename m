Return-Path: <netdev+bounces-124888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C0F96B478
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAFA28AA89
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED0517D8A6;
	Wed,  4 Sep 2024 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Hc25Tg2C"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCEC54BD4;
	Wed,  4 Sep 2024 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438449; cv=none; b=oRrkdNzIKlb6jqz879EF9MFd5aE9nCLU/8Tg8/Ky1IHHaRzVit4dYkMNcb/t9ECesK+z7wTWNxRV+kl3a6Fcy8zKDmr5cnwoUpdy9ydj/Wo1pHUpKNUDwMmBxwOSlP/sbnbvROTf1h3r64Ui/nftb1ZeosAk/piipwKafV1k+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438449; c=relaxed/simple;
	bh=9aJPh46VMXkJTed+G/eVk69OFJRp8qInSHfOJXkKIfo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5GMy4MAXqjvnqzBJvDnSDSrNqD//eU0lefJS1lQxIz76VqzDbncBET1JjJs7UQmvwKM6WmpUW5wB8hORYMDqV57gaaKo1yKu4Zcpf+j6bHVg4sxb8HHomb0FhLnghof7oHzHaoCUntjVSmhjbsX1iCCac9E5kCpfut5VK/GFFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Hc25Tg2C; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725438447; x=1756974447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9aJPh46VMXkJTed+G/eVk69OFJRp8qInSHfOJXkKIfo=;
  b=Hc25Tg2C9pWTKBjOpFc/SL8KxoL5kN/1mQfP7Slh4MZLYwan2Vcz6Rqk
   WvN/3b6FXaEIfVVhVOxJXxAugvLaxPpQ5io7ZJfETCuJW259y6mkmXpMi
   0Dd1y1VGpxc2RO78ie+dIElOATNvgoUZM53A3YdCxdIDa4y/N1//Dpjdr
   f7r8D6/sexX2JdljZTd/hye9h3ChCJOxU6/xENFRd+vNSuFBtvTR4xY+2
   Mg/PibaTOx1qBs6RRxmiKqr+8eMK71a913A+iZSL0KOrS6Fq84bfjk06J
   5X9nke+hnRo21eMiwYGW884Lbhw5XKTnv+vqivKo+Gzn1hOSPUxslOQdr
   A==;
X-CSE-ConnectionGUID: AyNB24evRQG4cyxIdjyx8A==
X-CSE-MsgGUID: 2O/126pDQNGEiK3UbDjT1g==
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="31939568"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 01:27:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 4 Sep 2024 01:26:45 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 4 Sep 2024 01:26:45 -0700
Date: Wed, 4 Sep 2024 13:53:02 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<hkallweit1@gmail.com>, <richardcochran@gmail.com>, <rdunlap@infradead.org>,
	<Bryan.Whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <horms@kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V4 5/5] net: lan743x: Add support to ethtool
 phylink get and set settings
Message-ID: <ZtgY5jYk4C4z3v2R@HYD-DK-UNGSW21.microchip.com>
References: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
 <20240829055132.79638-6-Raju.Lakkaraju@microchip.com>
 <9f74455e-45ec-495a-bc8e-1c61caab747c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <9f74455e-45ec-495a-bc8e-1c61caab747c@lunn.ch>

Hi Andrew,

Thank you for review the patches.

The 08/30/2024 22:55, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> > @@ -3055,6 +3071,10 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
> >                                         cap & FLOW_CTRL_TX,
> >                                         cap & FLOW_CTRL_RX);
> >
> > +     if (phydev)
> > +             lan743x_mac_eee_enable(adapter, phydev->enable_tx_lpi &&
> > +                                    phydev->eee_enabled);
> 
> This is wrong. The documentation says:
> 
> /**
>  * phy_support_eee - Set initial EEE policy configuration
>  * @phydev: Target phy_device struct
>  *
>  * This function configures the initial policy for Energy Efficient Ethernet
>  * (EEE) on the specified PHY device, influencing that EEE capabilities are
>  * advertised before the link is established. It should be called during PHY
>  * registration by the MAC driver and/or the PHY driver (for SmartEEE PHYs)
>  * if MAC supports LPI or PHY is capable to compensate missing LPI functionality
>  * of the MAC.
>  *
>  * The function sets default EEE policy parameters, including preparing the PHY
>  * to advertise EEE capabilities based on hardware support.
>  *
>  * It also sets the expected configuration for Low Power Idle (LPI) in the MAC
>  * driver. If the PHY framework determines that both local and remote
>  * advertisements support EEE, and the negotiated link mode is compatible with
>  * EEE, it will set enable_tx_lpi = true. The MAC driver is expected to act on
>  * this setting by enabling the LPI timer if enable_tx_lpi is set.
>  */
> 
> So you should only be looking at enable_tx_lpi.

Ok. I will fix.

> 
> Also, do you actually call phy_support_eee() anywhere? I don't see it
> in this patch, but maybe it was already there?

We never call phy_support_eee() anywhere.
I will fix

> 
>         Adrew

-- 
Thanks,                                                                         
Raju

