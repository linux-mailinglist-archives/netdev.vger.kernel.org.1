Return-Path: <netdev+bounces-213637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D9B2607D
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2752A25ABB
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133152E8E1A;
	Thu, 14 Aug 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="goePpoV4"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A86D2E92C9;
	Thu, 14 Aug 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162429; cv=none; b=J58uezCqM4aKiGV2Q1/81KZxpjJ57x/PgVmTJIUmscv756r1bYxN53m5qNaAmWvoCMt+fqIehpnZemEdfxyg+6dEM1IRE66gULrFPDL1UPGfn0Zo75A4QBOPRtnrS/H8FxPt9tVMeur3iJMdvmr8Ub/bJwvbQSRW+vU7CHC2SKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162429; c=relaxed/simple;
	bh=Oz25PrJT73NTSuDI+0EIdhpAxjaJMOCBOM65v5PEcuw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmO9E5HzMf6HaMclTn2XTbUlIPjj4k3hA8RibbL3Z3dl4txS0gEM80ZmSPRQbvwBJCrLv8CQu1EofUcnkW22HZDqBGFesru9pbklw48CAzFHDIjLRYe8Rc8F/fwOfWNeGHPa4TJeStgvBnzD+kX05flGK2iM+skWjm68TArEx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=goePpoV4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755162427; x=1786698427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oz25PrJT73NTSuDI+0EIdhpAxjaJMOCBOM65v5PEcuw=;
  b=goePpoV4EP8cc33JOmw0Cpwv6vUwzX1aP0R0T19uAtDnl5BFFm2yAFNg
   W93NXY2OO/K087IdHqpurcepmhbDUs3TF7upDDX19QKHLXRxD8S4rAy5+
   QqD0Ba/JpILAPvDb42XJtOSjy71z0mrfNy3oHqRCf9skfjbkKIAty/+KN
   nDkm1ctnTz8QXhz0MozBLnrlp2oNePlQZWFRDGBqRFRURiJ5v2JNCreFi
   QDAeMvGat3o/85kAcnliAKH9qRScUSctljiDltGL3Q5cxoRh/YZ/F/p2r
   bi2+QcH2K1C4dFrK6KNFIGFJqAtrRtOwX8JVRHN+NoYXG+o9xnLnbh1Dn
   Q==;
X-CSE-ConnectionGUID: yj3lUMp6SW2eGwJyvl0idQ==
X-CSE-MsgGUID: Dyac/4emT1Kx5ST6zmZa2w==
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="50710161"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2025 02:07:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 14 Aug 2025 02:06:05 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 14 Aug 2025 02:06:05 -0700
Date: Thu, 14 Aug 2025 11:02:48 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <viro@zeniv.linux.org.uk>,
	<atenart@kernel.org>, <quentin.schulz@bootlin.com>, <olteanv@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250814090248.e7o6rzfr7vfcgfsc@DEN-DL-M31836.microchip.com>
References: <20250806054605.3230782-1-horatiu.vultur@microchip.com>
 <b25635ec-0ab3-4c90-9fb9-b9c5c1748590@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <b25635ec-0ab3-4c90-9fb9-b9c5c1748590@linux.dev>

The 08/13/2025 22:51, Vadim Fedorenko wrote:

Hi Vadim,

> 
> On 06/08/2025 06:46, Horatiu Vultur wrote:
> > There was a problem when we received frames and the frames were
> > timestamped. The driver is configured to store the nanosecond part of
> > the timestmap in the ptp reserved bits and it would take the second part
> > by reading the LTC. The problem is that when reading the LTC we are in
> > atomic context and to read the second part will go over mdio bus which
> > might sleep, so we get an error.
> > The fix consists in actually put all the frames in a queue and start the
> > aux work and in that work to read the LTC and then calculate the full
> > received time.
> 
> The expectation here is that aux worker will kick in immediately and the
> processing will happen within 1 second of the first stamped skb in the
> list. Why cannot you keep cached value of PHC, which is updated roughly
> every 500ms and use it to extend timestamp? Your aux worker will be much
> simpler, and packet processing will be faster...

Thanks for the suggestion but I don't think it would work in this case.
(if I understood correctly).
The problem is that I don't know if the cache value happened after or
before the timestamp. Let me give you an example: If the ns part in the
received frame is 900ms and the cached value is 2 sec and 400ms. Now I
don't know if the final timestamp should be 1 sec and 400ms or should be
2 sec and 900ms.
I am doing something similar for lan8841 in micrel.c but in that case in
the PTP header I get also the 2 LS bits of the second and then it is
easier to see if the timestamp happen before or after the cached was
updated.

> 
> > 
> > Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > 
> > ---
> > v1->v2:
> > - use sk_buff_head instead of a list_head and spinlock_t
> > - stop allocating vsc8431_skb but put the timestamp in skb->cb
> > ---
> >   drivers/net/phy/mscc/mscc.h     | 12 ++++++++
> >   drivers/net/phy/mscc/mscc_ptp.c | 50 +++++++++++++++++++++++++--------
> >   2 files changed, 50 insertions(+), 12 deletions(-)
> > 
> 
> 
> [...]
> 
> >   /* Shared structure between the PHYs of the same package.
> > diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
> > index 275706de5847c..d368d4fd82e17 100644
> > --- a/drivers/net/phy/mscc/mscc_ptp.c
> > +++ b/drivers/net/phy/mscc/mscc_ptp.c
> > @@ -1194,9 +1194,8 @@ static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
> >   {
> >       struct vsc8531_private *vsc8531 =
> >               container_of(mii_ts, struct vsc8531_private, mii_ts);
> > -     struct skb_shared_hwtstamps *shhwtstamps = NULL;
> > +
> >       struct vsc85xx_ptphdr *ptphdr;
> 
> No empty line needed.

Good catch, I will update this in the next version.

> 
> > -     struct timespec64 ts;
> >       unsigned long ns;
> > 

-- 
/Horatiu

