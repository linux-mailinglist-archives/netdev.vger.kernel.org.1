Return-Path: <netdev+bounces-157030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E56A08C12
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696F7188DF6F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7C20C00C;
	Fri, 10 Jan 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rqevyBnu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CE4209F27;
	Fri, 10 Jan 2025 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501380; cv=none; b=JCCJ5XpIu5qiXUa0USFt1d+vH+TKSxprRd879Pg6g6Zlt5krnncwfKFZeOuNrMIkd4azZQQKGrK9z6BpBkyS56e6ojzwJaRlUoPQOB5PbRD9ddZnh/1662w8L1/7y33Iw9uz9nMNmSEQGm+ovX/zna+Cs8h5vCNmbThQNlbyya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501380; c=relaxed/simple;
	bh=FGkhmBkgK/2ki6XHDU56SkvQQB4yKkPfpIUPnQHxMGo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhEbucoLDwIZotOawW3q+lua2/CV2zw4sC93OUbjVT9rbidsaqW/mr3QM9P3YROE/hi0SrN+O2qk0piycYc8F0WEuLhYCtvFDn1Q8bdElYRPfooA3w2FjLYpjfWJf7UUuVD0BmRISnctrs7ksSwgBC5MRk1/W6UMIi0JU/zay/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rqevyBnu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736501378; x=1768037378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FGkhmBkgK/2ki6XHDU56SkvQQB4yKkPfpIUPnQHxMGo=;
  b=rqevyBnuLUEYiFvbaJJiWk64t7gpF5u73+0hSe0qXWQHgDrAYWlkbsPx
   d3sE/VIWSevycsJuMIfs0L2yRd7A9R2MMvMumK3FtCuXOft4JuIj1aYJv
   tvHOkzzbSrI2TawyY+aVI9hL45LMIB4Q/JREbN2A3K5ycTw0h8uwTt9gO
   VdRYXyActhL4go6WTdDVd+vpDSLbzBmEgfkHpw0iD0T4qoIrAiTTK/Is7
   zmS5WX3aOmFrzw6VbAAmDLqSbYP8UOXGQC1QuVL1Fv1m9mPTS3ZuIraLq
   0Hi6vVK/7DvBDr8LbVSyFmg7Kigrm1e0ciirPSB2qD25sVPOYZo7O8b8O
   g==;
X-CSE-ConnectionGUID: ZXymC1RqQb2YdZpceUKUPA==
X-CSE-MsgGUID: gqk5PFCaQBaNHSW5mBP17Q==
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36030268"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2025 02:29:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 Jan 2025 02:29:32 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 10 Jan 2025 02:29:29 -0700
Date: Fri, 10 Jan 2025 09:29:28 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	<jensemil.schulzostergaard@microchip.com>, <horatiu.vultur@microchip.com>,
	<jacob.e.keller@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next 4/6] net: sparx5: move SKB consumption to xmit()
Message-ID: <20250110092928.thsaqm3ucgyhw7s7@DEN-DL-M70577>
References: <20250109-sparx5-lan969x-switch-driver-5-v1-0-13d6d8451e63@microchip.com>
 <20250109-sparx5-lan969x-switch-driver-5-v1-4-13d6d8451e63@microchip.com>
 <CANn89iKA=ha6y0_UHUp6Pjkf0H4RevRbD-CHswdBqk0O=KkNqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CANn89iKA=ha6y0_UHUp6Pjkf0H4RevRbD-CHswdBqk0O=KkNqg@mail.gmail.com>

Hi Eric,

> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
> > index b6f635d85820..e776fa0845c6 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
> > @@ -272,7 +272,6 @@ netdev_tx_t sparx5_port_xmit_impl(struct sk_buff *skb, struct net_device *dev)
> >             SPARX5_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)
> >                 return NETDEV_TX_OK;
> 
> If packet is freed earlier in sparx5_fdma_xmit(), you have UAF few
> lines above here ..
> 
> stats->tx_bytes += skb->len; // UAF
> ...
> if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&   // UAF
> SPARX5_SKB_CB(skb)->rew_op == IFH_REW_OP_TWO_STEP_PTP)   // UAF
> 

Yes, this needs to be done differently. I will rework the SKB consumption in
v2. Thanks a lot!

/Daniel


