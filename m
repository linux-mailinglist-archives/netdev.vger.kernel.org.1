Return-Path: <netdev+bounces-216383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982A2B3362F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534C53A3409
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373F0272E43;
	Mon, 25 Aug 2025 06:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qtgCFOlo"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A605123CEF9
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756102083; cv=none; b=NpYmm9MQD1X87YPDhMu2NK01dV5QhwUaQbDwxHgFKUtqtOiMVglpxTleMOqGJp1YDriEa1shKS80VEqrwiVo4yXcWMHkK9fq6CR7CxbIL37zyo372F86bOf1ackbAo1jbnb++Pr6TrRjKSYxyk1aZ9j0yRY4ok3htFLZ+FA2jbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756102083; c=relaxed/simple;
	bh=F5An7CWpWEgTDXbqOxRr1wQf6WQZWTnKVdeWaOTplE4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jItwG65azliUbUaWhntrmpWY6sOnT/lLzZdTg51fWFFOg++dyuawNyL6MtjwOEoEwYYQAPWrzlwWcd5NGK47jzLHaOcHqeyHVHLGb5Mw+oNYvOvyatyzr0UvYHzU5JZUbYfAR3cqmItkrEllZIrik0sAxgMbWcOEdCE6pfRnquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qtgCFOlo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756102081; x=1787638081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F5An7CWpWEgTDXbqOxRr1wQf6WQZWTnKVdeWaOTplE4=;
  b=qtgCFOloLdd8zXxCl3yhoy/CW/R2EJ9RVvS4zNxoWQtNHYXs4rTD2TdR
   ttGpwMsWsg6Ss5LYX7+nmDh5ih/hjF9ugjrYyppY5yJAGc58icI3zgrPm
   88rDy92dmaRtLVtL08Ite0pPbT4yVzQ02mGurLYUpLuiMax0sMxVCivim
   Sw3cFTd8DtmxCDdy4M4oegh4iu77ZN2iKWz4hICWlKpCzYLdzDkHPclTy
   BtEH6+aNaFULaeyzuBgy/73sDSf7jUlZ5YtzHDccrouGnpl3QHVikwXSh
   TCynngFIVvPqmbZyPPi0r6XpE4LFH7rtI1vxm3CWr4KKuFMmReQTJma5e
   w==;
X-CSE-ConnectionGUID: doKgWSY1Rc2VR8FmNXxORA==
X-CSE-MsgGUID: 1QoT1MRFTcGEuv7mFUSrgw==
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="51205421"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Aug 2025 23:07:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 24 Aug 2025 23:07:52 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Sun, 24 Aug 2025 23:07:51 -0700
Date: Mon, 25 Aug 2025 08:04:22 +0200
From: Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
To: Parthiban Veerasooran - I17164 <Parthiban.Veerasooran@microchip.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phy: micrel: Add PTP support for
 lan8842
Message-ID: <20250825060422.t4psl5rlol4fg2zo@DEN-DL-M31836.microchip.com>
References: <20250822092714.2554262-1-horatiu.vultur@microchip.com>
 <20250822092714.2554262-3-horatiu.vultur@microchip.com>
 <0072c273-ed0b-4008-846a-2de23f7e7bfd@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <0072c273-ed0b-4008-846a-2de23f7e7bfd@microchip.com>

The 08/22/2025 10:17, Parthiban Veerasooran - I17164 wrote:
> Hi Horatiu,

Hi Parthiban,

> 
> > +static void lan8842_handle_ptp_interrupt(struct phy_device *phydev, u16 status)
> > +{
> > +	struct lan8842_priv *priv = phydev->priv;
> > +	struct kszphy_ptp_priv *ptp_priv = &priv->ptp_priv;
> Please follow reverse Christmas tree style.

That is a goot catch. I will update it in the next version. Thanks.

> 
> Best regards,
> Parthiban V
> > +
> > +	if (status & PTP_TSU_INT_STS_PTP_TX_TS_EN_)
> > +		lan8814_get_tx_ts(ptp_priv);
> > +
> > +	if (status & PTP_TSU_INT_STS_PTP_RX_TS_EN_)
> > +		lan8814_get_rx_ts(ptp_priv);
> > +
> > +	if (status & PTP_TSU_INT_STS_PTP_TX_TS_OVRFL_INT_) {
> > +		lan8814_flush_fifo(phydev, true);
> > +		skb_queue_purge(&ptp_priv->tx_queue);
> > +	}
> > +
> > +	if (status & PTP_TSU_INT_STS_PTP_RX_TS_OVRFL_INT_) {
> > +		lan8814_flush_fifo(phydev, false);
> > +		skb_queue_purge(&ptp_priv->rx_queue);
> > +	}
> > +}
> > +
> >   static irqreturn_t lan8842_handle_interrupt(struct phy_device *phydev)
> >   {
> > +	struct lan8842_priv *priv = phydev->priv;
> >   	int ret = IRQ_NONE;
> >   	int irq_status;
> >   
> > @@ -5912,6 +5983,25 @@ static irqreturn_t lan8842_handle_interrupt(struct phy_device *phydev)
> >   		ret = IRQ_HANDLED;
> >   	}
> >   
> > +	/* Phy revision lan8832 doesn't have support for PTP threrefore there is
> > +	 * not need to check the PTP and GPIO interrupts
> > +	 */
> > +	if (priv->rev == 0x8832)
> > +		goto out;
> > +
> > +	while (true) {
> > +		irq_status = lanphy_read_page_reg(phydev, 5, PTP_TSU_INT_STS);
> > +		if (!irq_status)
> > +			break;
> > +
> > +		lan8842_handle_ptp_interrupt(phydev, irq_status);
> > +		ret = IRQ_HANDLED;
> > +	}
> > +
> > +	if (!lan8814_handle_gpio_interrupt(phydev, irq_status))
> > +		ret = IRQ_HANDLED;
> > +
> > +out:
> >   	return ret;
> >   }
> >   
> 

-- 
/Horatiu

