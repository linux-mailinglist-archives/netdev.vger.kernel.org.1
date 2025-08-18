Return-Path: <netdev+bounces-214640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 079EAB2AB5A
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7111BC4B93
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F033EAEA;
	Mon, 18 Aug 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z13bQ4w7"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3B33EAE7;
	Mon, 18 Aug 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526990; cv=none; b=kV/ErK/1vtcmbzLSDIT69vqd32eTvCZNHXrGF/7m6Q3DCCRzKc1I6YQo1eGduSBpCmYpJGrk4h+9OKiprywqnsoVRMSsCVN2vDQqB/I/n6NPNV7NAqY5mMnCqZGQTUpk1+H+bR1EgsYMjpbJ/EfmQ7DFRf7tzdQjg6g3j7KhayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526990; c=relaxed/simple;
	bh=xV+yCcq6GkEFZSuRsObv889GnJMU74ErMAVX1xzOIic=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9baNvPMk9c9AK4KFMYjJMOVpYndAcc7qCfW++9ZJQus2mPAbASCDOobCWzf5Puw8p7YgEoz+McYF5oJObbJDAc4SZaSh0Nlc2c63GFY/oy//Ck1s8IuEi140tgHPzAsr2qTxGPTpQce24vPqv7kR7pKieZvGcnErULWO+pbk2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z13bQ4w7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755526989; x=1787062989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xV+yCcq6GkEFZSuRsObv889GnJMU74ErMAVX1xzOIic=;
  b=z13bQ4w7q9WqN4B8P46291iMs0EEDyN4VHnXH5IxSJTdJzsmFN7snSpj
   crQVA9ldspdxGlsYhqN8GrlxvNkpFpx3dhiJMtJVg6xkt04zK8YlDhrga
   RE4L+tBETptKO5W7Rw5qmm2/SXiWphI1bmsY9T0niwXI3jz9/ky4pzJcU
   JcXAV6esuz5lYvdV/nWGDtCEW6ZWHd1G1MXAQnaWRbX//uKZWbU4Ten1j
   6X8NtyGpDzSssNDNqG/hOQqcFCi06Y0NE9qfpDCN/IQv0VgFhzxD2x0qr
   bFxvv/lB7sk297HAu4n11NfcwVQKA7pZFFGwC2cIA2PD78if/7kKx2BpY
   w==;
X-CSE-ConnectionGUID: Om7kd4uvQdGD8bWCpE/DyA==
X-CSE-MsgGUID: YLJTI/MuTwOU11OaMQsH8g==
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="50869351"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2025 07:23:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 18 Aug 2025 07:22:47 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 18 Aug 2025 07:22:47 -0700
Date: Mon, 18 Aug 2025 16:19:25 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <rosenp@gmail.com>,
	<christophe.jaillet@wanadoo.fr>, <viro@zeniv.linux.org.uk>,
	<quentin.schulz@bootlin.com>, <atenart@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v4] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250818141925.l7rvjns26gda3bp7@DEN-DL-M31836.microchip.com>
References: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
 <20250818132141.ezxmflzzg6kj5t7k@skbuf>
 <20250818135658.exs5mrtuio7rm3bf@DEN-DL-M31836.microchip.com>
 <20250818141306.qlytyq3cjryhqkas@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250818141306.qlytyq3cjryhqkas@skbuf>

The 08/18/2025 17:13, Vladimir Oltean wrote:
> 
> On Mon, Aug 18, 2025 at 03:56:58PM +0200, Horatiu Vultur wrote:
> > The 08/18/2025 16:21, Vladimir Oltean wrote:
> >
> > Hi Vladimir,
> >
> > >
> > > On Mon, Aug 18, 2025 at 10:10:29AM +0200, Horatiu Vultur wrote:
> > > > diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
> > > > index 37e3e931a8e53..800da302ae632 100644
> > > > --- a/drivers/net/phy/mscc/mscc_main.c
> > > > +++ b/drivers/net/phy/mscc/mscc_main.c
> > > > @@ -2368,6 +2368,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
> > > >       return vsc85xx_dt_led_modes_get(phydev, default_mode);
> > > >  }
> > > >
> > > > +static void vsc85xx_remove(struct phy_device *phydev)
> > > > +{
> > > > +     struct vsc8531_private *priv = phydev->priv;
> > > > +
> > > > +     skb_queue_purge(&priv->rx_skbs_list);
> > > > +}
> > >
> > > Have you tested this patch with an unbind/bind cycle? Haven't you found
> > > that a call to ptp_clock_unregister() is also missing?
> >
> > I haven't tested unbind/bind cycle. As I said also to Paolo[1], I will need
> > to look in this issue with missing ptp_clock_unregister(). But I want to
> > do that in a separate patch after getting this accepted.
> >
> > [1] https://lkml.org/lkml/2025/8/13/345
> >
> > --
> > /Horatiu
> 
> Ok, is there anything preventing you from looking into that issue as well?

Nothing prevents me for looking at this issue. I just need to alocate
some time for this.

> The two problems are introduced by the same commit, and fixes will be
> backported to all the same stable kernels. I don't exactly understand
> why you'd add some code to the PHY's remove() method, but not enough in
> order for it to work.

Yes, I understand that but the fix for ptp_clock_unregister will fix a
different issue that this patch is trying to fix. That is the reason why
I prefer not to add that fix now, just to make things more clear.

-- 
/Horatiu

