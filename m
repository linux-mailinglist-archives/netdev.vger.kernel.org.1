Return-Path: <netdev+bounces-210433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A9EB13519
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 08:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173CF3A34B9
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 06:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469CD22126D;
	Mon, 28 Jul 2025 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qZEEM+i4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE75621B9D2;
	Mon, 28 Jul 2025 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685506; cv=none; b=YK2ycgs/vuo+OkeDzt8a63QEiPMe49bEsvOwN+mQWflP+4ez9ulpztJMGturu//g1qfG7/DorMdqQQS6ChAlBTlXfN5h3D0l99kbo/leP923I244+vch9PxPddDr+e2r39AtVqDSeCXFCJViiLMz3r/T4y8aaKtssTAzxU8UerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685506; c=relaxed/simple;
	bh=bXXezclLq7GUihaytnk+fZzRsjecBR4qfRXrwCRq0MM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXXqhvQNuAxKXZXQBK7Yt2BbKxvOrxUVCQEgEUdCB3vwGkzggdKZN2ZbuEAcKtxAHVcvjFxAxLDRNBgk/iFeWS6RJBnRkUnMOZzy36ez1OC5NXs9GpluCGc0uo/yRdL0X+O4ihqdWZXBgvzHQTnNQ4M3W7NMRFl3zQwNSeG3JlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qZEEM+i4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753685504; x=1785221504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bXXezclLq7GUihaytnk+fZzRsjecBR4qfRXrwCRq0MM=;
  b=qZEEM+i4tEbtRC+QORMPfDxbMpoOX2duFHLJ2TTmyPqErlTS14Orn/X+
   fJGoIEIm26zkpIdYPiBpeO427ACx1AyDvlNUVzDzstDpeRmo8q2Q1l4rC
   JXI71mNocVEfj/VN6aiqi5NiaGtnNgL6w4szWbfdUrvpf4avsk22p16uh
   Kg65dbtBhUoDmL+355kygISqnGYKOMC1KFP/MI2nbA6V1ncG2ZA6yo190
   drFeKYgWDvN4ViHdWOZJKo58jLrVekRrs75MGkKQcbRZWta1ec3MXRGOZ
   UkUoYuLjGXTHMi0zbqnP+rsfNtfmN7m2v8VgA7ea0XPpnagvnXzko4ppp
   w==;
X-CSE-ConnectionGUID: XleGp8bISDuSuljufyssoA==
X-CSE-MsgGUID: /QZttT4jQQ6frzyes6/K+g==
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="49824900"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2025 23:51:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 27 Jul 2025 23:51:27 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Sun, 27 Jul 2025 23:51:26 -0700
Date: Mon, 28 Jul 2025 08:48:29 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/4] net: phy: micrel: Add support for lan8842
Message-ID: <20250728064829.wdcatrtypgb6ihcp@DEN-DL-M31836.microchip.com>
References: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
 <20250724200826.2662658-5-horatiu.vultur@microchip.com>
 <2c681a15-71b0-4514-b0ce-ce6d28c74971@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <2c681a15-71b0-4514-b0ce-ce6d28c74971@oracle.com>

The 07/26/2025 17:23, ALOK TIWARI wrote:

Hi Alok,

> 
> On 7/25/2025 1:38 AM, Horatiu Vultur wrote:
> > +static void lan8842_get_phy_stats(struct phy_device *phydev,
> > +                               struct ethtool_eth_phy_stats *eth_stats,
> > +                               struct ethtool_phy_stats *stats)
> > +{
> > +     struct lan8842_priv *priv = phydev->priv;
> > +
> > +     stats->rx_packets = priv->phy_stats.rx_packets;
> > +     stats->rx_errors = priv->phy_stats.rx_errors;
> > +     stats->tx_packets = priv->phy_stats.tx_packets;
> > +     stats->tx_errors = priv->phy_stats.rx_errors;
> 
> looks like a copy-paste mistake
> stats->tx_errors = priv->phy_stats.tx_errors;

That is a good catch!
I will fix it in the next version.

> 
> > +}
> > +
> 
> 
> Thanks,
> Alok

-- 
/Horatiu

