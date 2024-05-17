Return-Path: <netdev+bounces-96946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E56148C8520
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B7F1C22D0E
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007F3A1C5;
	Fri, 17 May 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jUHeZ22+"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448773AC01;
	Fri, 17 May 2024 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715943227; cv=none; b=fIE+xlS1rnKVbyAxICaP9kP21rbAzizXqLzmi9FWZQ5k+zfTWs99eAGv300OjIKn0bf8DfgCEbr0/yJyyoI4/Dw/c5/ph/OCLmEhpP07w+RuPSQ1KT16fMHtoxSXOZhS5AaAXCuyl5UX24p7/Qp1CD4bik6k8z3mxytHevYNYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715943227; c=relaxed/simple;
	bh=cbiQBZy2De/m3cV+GNTDOXSmIL6b0Vw8lm2BYiT840E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLqH6VaaHEt2oW93EE04qyeSIQZsQvj/fLfbVc2VH18pUQUs7AtjDv95HnQrXSYorbEb1D67Qmpkjxw96ZqlcL7J9sycZPmlX4AQA8TZpHBAiEua1IIvVFtdJgxhRCsm9QE1oorwg9pcWaMWHlfYdnhsz9xCJcssksgvjkuHDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jUHeZ22+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715943225; x=1747479225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cbiQBZy2De/m3cV+GNTDOXSmIL6b0Vw8lm2BYiT840E=;
  b=jUHeZ22+H62LGifIjxGUj4Gas1bZXyMRdVCAbuFtVsPjFa31f25Y61Lt
   HR9hG1dhGcLkxMUfssxRHZWQmCgsap2r5N7ZIEECC8nrLUMpJoGXX0crd
   iTumkiQKLYYfWXPUDCP3GZi5J3LfOaASDOqKX6JF0KuQ1wEfdPcbEPd3y
   AYIXO41givfqc/9cc/gzal2O3sgLCAYGE7B3k4d33GWBKF3ODzMmobxkH
   h0JgxuN5fVxFseP7m3cCn3mEM8jn0RNwlY2WDxPpKUraiO75TCCT7w+5T
   934T5ihap1wiLIKcr9IHenZ5EIoDiTuSQYQMh7ngc/oUC3z9ZXtmpPziw
   w==;
X-CSE-ConnectionGUID: 8/AyTWloQsq9+IZ75FlhEg==
X-CSE-MsgGUID: fRuB+mRcSBeRvzdCZ+FE/w==
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="25039004"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 May 2024 03:53:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 17 May 2024 03:53:33 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 17 May 2024 03:53:33 -0700
Date: Fri, 17 May 2024 12:53:33 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net] net: lan966x: Remove ptp traps in case the ptp is
 not enabled.
Message-ID: <20240517105333.y62xzytnebpapayl@DEN-DL-M31836.microchip.com>
References: <20240514193500.577403-1-horatiu.vultur@microchip.com>
 <20240514222149.mhwtp3kduebb4zzs@skbuf>
 <20240516064855.ne6uf3xanns4hh2o@DEN-DL-M31836.microchip.com>
 <20240517100425.l5ddxbuyxbgx42ti@skbuf>
 <20240517101811.vsqcg7moapixlfpj@DEN-DL-M31836.microchip.com>
 <20240517102307.7we5psrgbf56mden@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240517102307.7we5psrgbf56mden@skbuf>

The 05/17/2024 13:23, Vladimir Oltean wrote:
> 
> On Fri, May 17, 2024 at 12:18:11PM +0200, Horatiu Vultur wrote:
> > The 05/17/2024 13:04, Vladimir Oltean wrote:
> > >
> > > On Thu, May 16, 2024 at 08:48:55AM +0200, Horatiu Vultur wrote:
> > > > > Alternatively, the -EOPNOTSUPP check could be moved before programming
> > > > > the traps in the first place.
> > > >
> > > > Thanks for the review.
> > > > Actually I don't think this alternative will work. In case of PHY
> > > > timestamping, we would still like to add those rules regardless if
> > > > ptp is enabled on lan966x.
> > > >
> > > > >
> > > > > Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > >
> > > > --
> > > > /Horatiu
> > >
> > > I don't understand why this would not have worked?
> > >
> > > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > > index b12d3b8a64fd..1439a36e8394 100644
> > > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> > > @@ -474,14 +474,14 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
> > >             cfg->source != HWTSTAMP_SOURCE_PHYLIB)
> > >                 return -EOPNOTSUPP;
> > >
> > > +       if (cfg->source == HWTSTAMP_SOURCE_NETDEV && !port->lan966x->ptp)
> > > +               return -EOPNOTSUPP;
> > > +
> >
> > This should also work.
> > Initially I thought you wanted to have only the check for
> > port->lan966x->ptp here. And that is why I said it would not work.
> 
> Ok. I see the patch was marked as "changes requested". I think the
> second alternative would be better anyway, because a requested
> configuration which cannot be supported will be rejected outright,
> rather than doing some stuff, figuring out it cannot be done, then
> undoing what was done. Would you mind sending a v2 like this?

I will send a v2 as you suggested.

-- 
/Horatiu

