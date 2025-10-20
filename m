Return-Path: <netdev+bounces-230791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21742BEF802
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 08:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B302D1898353
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 06:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167F42D839F;
	Mon, 20 Oct 2025 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oqywBw51"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9992D7DFB;
	Mon, 20 Oct 2025 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760942472; cv=none; b=exE+913164L5+C7ew/g2O8rVxWHDh1mu4qEKeVteO7CwijQLVnYVZBgyQgbzfyKV4e7Dr+2pgSHq1h309Mc8FOB/OlPveOwuKZA4+mw3h3iNDOthvt0EPYWXRk7nX/6ssMQ2uaDg5Vwo+iRZiGubgDyXPfCx+9rtZV1HaQcHXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760942472; c=relaxed/simple;
	bh=HvkZQIT3YWSHEloVSkLh35b3GVu96O2L6Q9lSbh+XQc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8eBu9di+JM+QrtrU0TmCu98axHSL1txz0sW+osHuYdQoL7a48/8+qMCQPmb3qnsQHw0b8FnLeYnIvncrSuJTaJNmrFD6VvQ3bLYs2Qt2xnlH7GQ47Q1VdFkpDF0D7zM3ZdrqAbyOOvo1KlzXBCj4VHO2oJgPa61kUGCWHTNXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oqywBw51; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1760942469; x=1792478469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HvkZQIT3YWSHEloVSkLh35b3GVu96O2L6Q9lSbh+XQc=;
  b=oqywBw51x9eUYgQqWXJajaW9qtb3sv2deRIrktLWWhAulT8ZFcr7iQW4
   uNP8U3DF5NS2bjl+RS+zzhm+oONrpSVo+mketSWtm8BIhkq32DGvXXUo5
   3ockl8W4I5/DCJlxlY9BK9UJV2lxq6XvMGB6bku2iL3AYg7lmaL5pGseT
   3DTkNBgx5L1evvWDFJ03HTJ5OgVQrr1sAu3UKQES/zFW1O5+fO5xfpLqi
   3rpbkJQpQC2nZCN3azWIRoIJTgAwA4mCvTTLBDzaVKtF7K9MQbGiSNWUT
   T0j/LzaqICxX21dKFkzMaRxvC4LZ/MOwGi/TEjWYQTNAjitIQV8hMj//N
   A==;
X-CSE-ConnectionGUID: Xi2sZDkeQe6Wff5fg4d3MA==
X-CSE-MsgGUID: lnWFWEOvRpCYlHV8kcUaDw==
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="215334774"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Oct 2025 23:41:02 -0700
Received: from chn-vm-ex1.mchp-main.com (10.10.87.30) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 19 Oct 2025 23:40:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Sun, 19 Oct 2025 23:40:50 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 19 Oct 2025 23:40:50 -0700
Date: Mon, 20 Oct 2025 08:39:45 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for non PTP SKUs
 for lan8814
Message-ID: <20251020063945.dwqgn5yphdwnt4vk@DEN-DL-M31836.microchip.com>
References: <20251017074730.3057012-1-horatiu.vultur@microchip.com>
 <79f403f0-84ed-43fe-b093-d7ce122d41fd@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <79f403f0-84ed-43fe-b093-d7ce122d41fd@engleder-embedded.com>

The 10/17/2025 23:15, Gerhard Engleder wrote:

Hi Gerhard,

> 
> On 17.10.25 09:47, Horatiu Vultur wrote:
> > The lan8814 has 4 different SKUs and for 2 of these SKUs the PTP is
> > disabled. All these SKUs have the same value in the register 2 and 3
> > meaning we can't differentiate them based on device id therefore check
> 
> Did you miss to start a new sentence?

Yes, I think so. I will update this.

> 
> > the SKU register and based on this allow or not to create a PTP device.
> > 
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >   drivers/net/phy/micrel.c | 38 ++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 38 insertions(+)
> > 
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index 79ce3eb6752b6..16855bf8c3916 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -101,6 +101,8 @@
> >   #define LAN8814_CABLE_DIAG_VCT_DATA_MASK    GENMASK(7, 0)
> >   #define LAN8814_PAIR_BIT_SHIFT                      12
> > 
> > +#define LAN8814_SKUS                         0xB
> > +
> >   #define LAN8814_WIRE_PAIR_MASK                      0xF
> > 
> >   /* Lan8814 general Interrupt control/status reg in GPHY specific block. */
> > @@ -367,6 +369,9 @@
> > 
> >   #define LAN8842_REV_8832                    0x8832
> > 
> > +#define LAN8814_REV_LAN8814                  0x8814
> > +#define LAN8814_REV_LAN8818                  0x8818
> > +
> >   struct kszphy_hw_stat {
> >       const char *string;
> >       u8 reg;
> > @@ -449,6 +454,7 @@ struct kszphy_priv {
> >       bool rmii_ref_clk_sel;
> >       bool rmii_ref_clk_sel_val;
> >       bool clk_enable;
> > +     bool is_ptp_available;
> >       u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
> >       struct kszphy_phy_stats phy_stats;
> >   };
> > @@ -4130,6 +4136,17 @@ static int lan8804_config_intr(struct phy_device *phydev)
> >       return 0;
> >   }
> > 
> > +/* Check if the PHY has 1588 support. There are multiple skus of the PHY and
> > + * some of them support PTP while others don't support it. This function will
> > + * return true is the sku supports it, otherwise will return false.
> > + */
> 
> Hasn't net also switched to the common kernel multiline comment style
> starting with an empty line?

I am not sure because I can see some previous commits where people used
the same comment style:
e82c64be9b45 ("net: stmmac: avoid PHY speed change when configuring MTU")
100dfa74cad9 ("net: dev_queue_xmit() llist adoption")

> 
> > +static bool lan8814_has_ptp(struct phy_device *phydev)
> > +{
> > +     struct kszphy_priv *priv = phydev->priv;
> > +
> > +     return priv->is_ptp_available;
> > +}
> > +
> >   static irqreturn_t lan8814_handle_interrupt(struct phy_device *phydev)
> >   {
> >       int ret = IRQ_NONE;
> > @@ -4146,6 +4163,9 @@ static irqreturn_t lan8814_handle_interrupt(struct phy_device *phydev)
> >               ret = IRQ_HANDLED;
> >       }
> > 
> > +     if (!lan8814_has_ptp(phydev))
> > +             return ret;
> > +
> >       while (true) {
> >               irq_status = lanphy_read_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
> >                                                 PTP_TSU_INT_STS);
> > @@ -4207,6 +4227,9 @@ static void lan8814_ptp_init(struct phy_device *phydev)
> >           !IS_ENABLED(CONFIG_NETWORK_PHY_TIMESTAMPING))
> >               return;
> > 
> > +     if (!lan8814_has_ptp(phydev))
> > +             return;
> > +
> >       lanphy_write_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
> >                             TSU_HARD_RESET, TSU_HARD_RESET_);
> > 
> > @@ -4336,6 +4359,9 @@ static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
> > 
> >   static int lan8814_ptp_probe_once(struct phy_device *phydev)
> >   {
> > +     if (!lan8814_has_ptp(phydev))
> > +             return 0;
> > +
> >       return __lan8814_ptp_probe_once(phydev, "lan8814_ptp_pin",
> >                                       LAN8814_PTP_GPIO_NUM);
> >   }
> > @@ -4450,6 +4476,18 @@ static int lan8814_probe(struct phy_device *phydev)
> >       devm_phy_package_join(&phydev->mdio.dev, phydev,
> >                             addr, sizeof(struct lan8814_shared_priv));
> > 
> > +     /* There are lan8814 SKUs that don't support PTP. Make sure that for
> > +      * those skus no PTP device is created. Here we check if the SKU
> > +      * supports PTP.
> > +      */
> 
> Check comment style.
> 
> > +     err = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> > +                                LAN8814_SKUS);
> > +     if (err < 0)
> > +             return err;
> > +
> > +     priv->is_ptp_available = err == LAN8814_REV_LAN8814 ||
> > +                              err == LAN8814_REV_LAN8818;
> > +
> >       if (phy_package_init_once(phydev)) {
> >               err = lan8814_release_coma_mode(phydev);
> >               if (err)
> 

-- 
/Horatiu

