Return-Path: <netdev+bounces-211506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD33B19CD9
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 09:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA2118839D9
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 07:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E6123958A;
	Mon,  4 Aug 2025 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xXVHwg+Q"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EBC2E3705;
	Mon,  4 Aug 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293454; cv=none; b=h+RRgNzsEPOhA5nx4LShP5dzuVOeWQBHR/HeDCWVXDu5BW84+ZVQeP0qBcCLjExvMFTyuAB78JnFM0cC1WuEdyYgDmOQjZZllOEnIBdBVtWf9WspcimFEmHprtojHXYmaqDeMhanNnivMMuFrwdAqEN842Welu3a2nIu4BBg52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293454; c=relaxed/simple;
	bh=2t/0ocP7d5snl03JgkYcYu14oN2fOrarqYky++kXOoc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDbzebpk9EbPExW44wW3ylzRaxQNksfGxSa5jbiUDEVphUpL/eV2TITE8Vctjs8fLbjZfF3yu6IqUokdZNfC2zWiRTWJr+suKQMv+ZugAaJ20ACpDzt15zaCxM2Tcf66RV0tK5h6h8jd1JvhgW5UQ05kNRhHWV7l3es/MX5yoEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xXVHwg+Q; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754293453; x=1785829453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2t/0ocP7d5snl03JgkYcYu14oN2fOrarqYky++kXOoc=;
  b=xXVHwg+Qn1Go+6JcS9eE+Wvg+XW3h7yobqQHaHBv/JLqNxmREX7aZRBr
   0w3NDnGev3MKsJYWzL5aNqCxyNP30+FxZdab+hy4lPm3VNbIoR33fRMbT
   O8OX7TsZz8eZS6wNWJS5ddfV76oaGIepE06mts1Pnxg1ISOrX3+zNCi1/
   C72HwmkD1K88/VTCXCLNKKlD8tGxMgiR/3eqpy0VUfSXraOms8YR8huqc
   zHo/+W341OkxGYKbFyUgPF2P1GsY4hs2qnBhd/xR1peq11AW3ibRRUdiU
   fv0ZvB1NWkORPeSbnEhChpEI2xvM5lfPYNcz7T+WcWp5m27R6pbyu/erD
   w==;
X-CSE-ConnectionGUID: Msm8Gc5CRDqR4bZJ2S2GaQ==
X-CSE-MsgGUID: rQtYiwLVRueamVPBUlEJNg==
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="44241110"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2025 00:43:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 4 Aug 2025 00:42:45 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 4 Aug 2025 00:42:45 -0700
Date: Mon, 4 Aug 2025 09:39:40 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <viro@zeniv.linux.org.uk>,
	<quentin.schulz@bootlin.com>, <atenart@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250804073940.4wgpstdm53atrbbq@DEN-DL-M31836.microchip.com>
References: <20250731121920.2358292-1-horatiu.vultur@microchip.com>
 <20250731121920.2358292-1-horatiu.vultur@microchip.com>
 <20250801112648.4hm2h6n3b64guagi@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250801112648.4hm2h6n3b64guagi@skbuf>

The 08/01/2025 14:26, Vladimir Oltean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hi Horatiu,

Hi Vladimir,

> 
> On Thu, Jul 31, 2025 at 02:19:20PM +0200, Horatiu Vultur wrote:
> > diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
> > index 6a3d8a754eb8d..7281eea2395bd 100644
> > --- a/drivers/net/phy/mscc/mscc.h
> > +++ b/drivers/net/phy/mscc/mscc.h
> > @@ -362,6 +362,13 @@ struct vsc85xx_hw_stat {
> >       u16 mask;
> >  };
> >
> > +struct vsc8531_skb {
> > +     struct list_head list;
> > +
> > +     struct sk_buff *skb;
> > +     u32 ns;
> > +};
> 
> Can you map a typed structure over the skb->cb area to avoid allocating
> this encapsulating structure over the sk_buff?

I think it is a great idea. I can map struct vsc8531_skb directly on
skb->cb and then drop the allocation.

-- 
/Horatiu

