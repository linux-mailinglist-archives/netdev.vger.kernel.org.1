Return-Path: <netdev+bounces-140668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62A9B77AA
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 10:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554EBB23D95
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4D41953BB;
	Thu, 31 Oct 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jubE+MuV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE6193078;
	Thu, 31 Oct 2024 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367404; cv=none; b=PpBpeJj8psrZA/bS7Fjwv3GWMTWd5cc/IAEzMUebDnVFIhz99fB4VQCeXDKeDNySFWSUGJfkEmhqboMbqu113TFG+K6nYVBsZKg0Ql/dW5t4v3J3qaB4V23NZMI3qdF3wyIXmzvsN+y2weIfPoJ10Kd+6cBoLHidFN3s60LxOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367404; c=relaxed/simple;
	bh=Jk/UL+5rTj1PV/YoegypnMhOCixtc3MMVbc/scCFjOE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQXJ1n3FZUo/v4m6jOisjixUaWHdwVbib/NfeTg+WGsJT1ccVCeD7/D3FmfpeQj7wPXu7VdEKqTlLWgsYv7p7darLhr52uBNnDLJVLWKTyLyhJtoEm7hpJItxtylcinzXXwgQBXLBlX0Whk6nRCy43Kx6dDBFAU2F24zzvSHQEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jubE+MuV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730367402; x=1761903402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jk/UL+5rTj1PV/YoegypnMhOCixtc3MMVbc/scCFjOE=;
  b=jubE+MuVTxyQuBiUO+J29NNC7KOpMVE6nvODKhQymuilXDPlWY7I2Sws
   S8xG2ll7XO6Hy9HvH+F75D0WE2p6IaJ9zn4MN0lZs9+vsPwQWIk9JP8Hh
   xqJhnbFnPU8A140WHlFSr4XzdYKREw52in1/UTS1lGogzthks/fTznATz
   KVXxbSB8EbOG/7F1wfvQ2cWS7ptMTSaELsoC5H6J4nhQZt3nXBXvXOtBh
   4K69wsDf/xk3NTxXX1JeGz+4rjpGl1nqcUKOf75rGJh6d19t5YkhiMpDX
   Uocjl3k9vun3HEGlU5sb6OC62c2GUvcnozpcwUx9Nya2mHPqcHKkwlabi
   Q==;
X-CSE-ConnectionGUID: U7/DaQSZR9qiaEJq3md8kg==
X-CSE-MsgGUID: BBxWSfWVS0+qtiQRUILoGg==
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="34234608"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2024 02:36:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 31 Oct 2024 02:36:33 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 31 Oct 2024 02:36:29 -0700
Date: Thu, 31 Oct 2024 09:36:28 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v2 10/15] net: lan969x: add PTP handler function
Message-ID: <20241031093628.faiupqqny7oco7uz@DEN-DL-M70577>
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
 <20241024-sparx5-lan969x-switch-driver-2-v2-10-a0b5fae88a0f@microchip.com>
 <20241030180742.2143cb59@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241030180742.2143cb59@kernel.org>

> On Thu, 24 Oct 2024 00:01:29 +0200 Daniel Machon wrote:
> > +             spin_lock_irqsave(&port->tx_skbs.lock, flags);
> > +             skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
> > +                     if (SPARX5_SKB_CB(skb)->ts_id != id)
> > +                             continue;
> > +
> > +                     __skb_unlink(skb, &port->tx_skbs);
> > +                     skb_match = skb;
> > +                     break;
> > +             }
> > +             spin_unlock_irqrestore(&port->tx_skbs.lock, flags);
> 
> For a followup for both drivers -- you're mixing irqsave and bare
> spin_lock() here. The _irqsave/_irqrestore is not necessary, let's
> drop it.
> 
> > +             spin_lock(&sparx5->ptp_ts_id_lock);

Hi Jakub,

I agree it seems wrong to mix these.

I just talked to Horatiu, and he mentioned posting a similar fix for the
lan966x driver some time ago [1]. Only this fix added
_irqsave/_irqrestore to the ptp_ts_id_lock - so basically the opposite
of what you are suggesting. Why do you think that the
_irqsave/_irqrestore is not necessary?

[1] 3a70e0d4c9d7 ("net: lan966x: Fix possible deadlock inside PTP")

/Daniel

