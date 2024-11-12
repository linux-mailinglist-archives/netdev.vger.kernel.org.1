Return-Path: <netdev+bounces-144041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0489C536B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931E61F22989
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A8213EEE;
	Tue, 12 Nov 2024 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UWrPSaA6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB357213EDD;
	Tue, 12 Nov 2024 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407191; cv=none; b=LtUi7LaRr8hIBBsw3dqpP+HmOb9Tbwcumt92vjtgry5pos/9Sm5NetmRXY6wfU4u9cRNR8QnOJ+X4IX/Nk9wFj4PpAd7OlLbw6TpQDEW8uYZrauwcWKiHSAuSLzG4QDwQ4c4e6gyvbGW4l8tJ9RlsW5o0xi35xlKs2hbdSOg6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407191; c=relaxed/simple;
	bh=kuZHpQVynWF0dMml92KBBRYvg0segfgTnuEueyOfqWI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZe7s0/ZLRtXal+gmpX+zcNBOFZZFbpMXKYgRKvczZ2gYQhDuHdLfIIYPFIqblsE8XfSMQamg2Mt581qviHuYdVoykblnHzelStkLQpYUvd8sWqmAiTt5vQ6eMnYScmGA/U813y3tjrhnSIu1tK34caui1Re+qIYzy1OPxs+7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UWrPSaA6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731407189; x=1762943189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kuZHpQVynWF0dMml92KBBRYvg0segfgTnuEueyOfqWI=;
  b=UWrPSaA6VtQMT4SBetV7/d0pF1/EbG9rDgpKgHfN5RYkCwDPB1L7n7ke
   wBwkc+CREN8/Uj0wzxfztMDsJyBu/+7OyqOS31d1CjBVfx8gYoFUhQWkp
   GMRvJnhOui9qdPqdWbAp6OMPNtn8othv02ARdkk4MLsmvzJ9WKkHI5I3j
   TP2lWUjodq/jgl59eydYikdHBTR8+XGHMTAW7BCluwz9vv7JgTIz2Hlhl
   xdujAlzBrcAy8usrLPEmd1xx5D2CSeVPAWEt9J260cC43Qo4h0WjD4CzK
   cwCX6E3/fPOrIDD4ZHjGJ9E91iEc7jE7Sm7wIawWC+40d8546i/xhNC7h
   Q==;
X-CSE-ConnectionGUID: 3LJNlechSByP7VxoY/Eupw==
X-CSE-MsgGUID: 9ycbmhISRkmmNQwzqMXIaQ==
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="201628733"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Nov 2024 03:26:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Nov 2024 03:26:20 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Nov 2024 03:26:17 -0700
Date: Tue, 12 Nov 2024 10:26:17 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, <UNGLinuxDriver@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next 7/7] net: lan969x: add function for configuring
 RGMII port devices
Message-ID: <20241112102617.lhb5ou7kxlqm7qhk@DEN-DL-M70577>
References: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
 <20241106-sparx5-lan969x-switch-driver-4-v1-7-f7f7316436bd@microchip.com>
 <6fee4db6-0085-4ce8-a6b5-050fddd0bc5a@lunn.ch>
 <20241108085320.fqbell5bfx3roey4@DEN-DL-M70577>
 <Zy32_Bs7gDAtay5V@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zy32_Bs7gDAtay5V@shell.armlinux.org.uk>

Hi Russel,

> > Hi Andrew,
> >
> > > > +     if (conf->phy_mode == PHY_INTERFACE_MODE_RGMII ||
> > > > +         conf->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
> > > > +             rx_delay = true;
> > > > +
> > > > +     if (conf->phy_mode == PHY_INTERFACE_MODE_RGMII ||
> > > > +         conf->phy_mode == PHY_INTERFACE_MODE_RGMII_RXID)
> > > > +             tx_delay = true;
> > >
> > > O.K, now warning bells are ringing in this reviews head.
> > >
> > > What i don't see is the value you pass to the PHY? You obviously need
> > > to mask out what the MAC is doing when talking to the PHY, otherwise
> > > both ends will add delays.
> > >
> >
> > What value should be passed to the PHY?
> >
> > We (the MAC) add the delays based on the PHY modes - so does the PHY.
> >
> > RGMII, we add both delays.
> > RGMII_ID, the PHY adds both delays.
> > RGMII_TXID, we add the rx delay, the PHY adds the tx delay.
> > RGMII_RXID, we add the tx delay, the PHY adds the rx delay.
> >
> > Am I missing something here? :-)
> 
> What if the board routing adds the necessary delays?
> 
> From Documentation/networking/phy.rst:
> "
> * PHY_INTERFACE_MODE_RGMII: the PHY is not responsible for inserting any
>   internal delay by itself, it assumes that either the Ethernet MAC (if capable)
>   or the PCB traces insert the correct 1.5-2ns delay
> ...

Ack. The case where the PCB traces add the delay is certainly not
handled with the current changes.

> For cases where the PHY is not capable of providing this delay, but the
> Ethernet MAC driver is capable of doing so, the correct phy_interface_t value
> should be PHY_INTERFACE_MODE_RGMII, and the Ethernet MAC driver should be
> configured correctly in order to provide the required transmit and/or receive
> side delay from the perspective of the PHY device. Conversely, if the Ethernet
> MAC driver looks at the phy_interface_t value, for any other mode but
> PHY_INTERFACE_MODE_RGMII, it should make sure that the MAC-level delays are
> disabled."
> 
> The point here is that you have three entities that can deal with the
> required delays - the PHY, the board, and the MAC.
> 
> PHY_INTERFACE_MODE_RGMII* passed to phylink/phylib tells the PHY how it
> should program its delay capabilities.
> 
> We're then down to dealing with the MAC and board induced delays. Many
> implementations use the rx-internal-delay-ps and tx-internal-delay-ps
> properties defined in the ethernet-controller.yaml DT binding to
> control the MAC delays.
> 
> However, there are a few which use PHY_INTERFACE_MODE_RGMII* on the MAC
> end, but in this case, they always pass PHY_INTERFACE_MODE_RGMII to
> phylib to stop the PHY adding any delays.
> 
> However, we don't have a way at present for DSA/phylink etc to handle a
> MAC that wants to ddd its delays with the PHY set to
> PHY_INTERFACE_MODE_RGMII.
> 
> Thanks.

Right, so using the {rx,tx}-internal-delay-ps allows me to configure the
MAC delays, or skip them entirely, in case the PCB adds them.

Thanks!

/Daniel


