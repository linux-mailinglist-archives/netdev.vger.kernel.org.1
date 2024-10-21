Return-Path: <netdev+bounces-137628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D52E9A730F
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4C71F221B9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8971FBC81;
	Mon, 21 Oct 2024 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pYg/iRxJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764E02209B;
	Mon, 21 Oct 2024 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538065; cv=none; b=A7mYm+zO09KZllTw89Mmx2NBdjKlxrdgDoF4AySk5ilE5LUMNB3iP0t1RdZ0r7OfpTC4i2v4/7doXkAG+tW9ph9Tej9+ZKAZQl0P9r1DCtXcDfyWnDuSdGv/3TEBrSieH1BIYj+S5fNwA49sZ7p4GUWBJ1pMMGa2yQX19BxVltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538065; c=relaxed/simple;
	bh=7wFMp0HxrbR9VJ8qywVbEmIhYSvSbwVhJ8LjTG/7fTs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSqCBpPuOq/ielaICRHRhclLrgZEcabwjSQ6yBTrdUIzeXml6PFamxOUPQdpvHcIA+gbIzfwnMd4gCNNVN1d/2/ARhD5StF4uqKX5nWIOL/KPbwa3qbCgcY50MVzd2dqGEOTi7YiNlicgPInDabLpxqAMeVVcTqqZWtj1rwaaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pYg/iRxJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729538063; x=1761074063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7wFMp0HxrbR9VJ8qywVbEmIhYSvSbwVhJ8LjTG/7fTs=;
  b=pYg/iRxJZbwePJSpvc86czzyZ1uF5CxmurtoPO8P2Vqo26DqxH2kxb5Q
   cb8bR//z+qwMKxdWfrp2exZIZW5LCqjgIUILBdW1yi5YS+prXaSUnVHNY
   rUdw4Y/4gkg0Xxgz20bedMN85Ivb7JtLKZlZ0SxTiuLRqtuGwtlKJS5AC
   mA3rT1eCGiGI6QA7lBk+J0K3nq3DAIUIjdha9pVg2vGU4wNR2qnJAGQxH
   9tevLsvDUsekqjVx/p39ln+85kkAow7nWO6hXq89KPZZzrQC6XR/RCeou
   iwidjj6EEGroXo0fQ4rO5iOY8N6G06vnLZTPR+Zek4HLYrgsZjf3FiBu6
   w==;
X-CSE-ConnectionGUID: 8BSVVT0GSq6qC8d419X4YA==
X-CSE-MsgGUID: +168UpgjR1eYpnndNkotiw==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="33842623"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 12:14:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 12:13:53 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 21 Oct 2024 12:13:49 -0700
Date: Mon, 21 Oct 2024 19:13:48 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 11/15] net: lan969x: add function for
 calculating the DSM calendar
Message-ID: <20241021191348.sd5k5qnxya734muc@DEN-DL-M70577>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
 <20241021-sparx5-lan969x-switch-driver-2-v1-11-c8c49ef21e0f@microchip.com>
 <20241021195140.442c0a4f@device-21.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241021195140.442c0a4f@device-21.home>

Hi Maxime,

> Hi Daniel,
> 
> On Mon, 21 Oct 2024 15:58:48 +0200
> Daniel Machon <daniel.machon@microchip.com> wrote:
> 
> > Lan969x has support for RedBox / HSR / PRP (not implemented yet). In
> > order to accommodate for this in the future, we need to give lan969x it's
> > own function for calculating the DSM calendar.
> >
> > The function calculates the calendar for each taxi bus. The calendar is
> > used for bandwidth allocation towards the ports attached to the taxi
> > bus. A calendar configuration consists of up-to 64 slots, which may be
> > allocated to ports or left unused. Each slot accounts for 1 clock cycle.
> >
> > Also expose sparx5_cal_speed_to_value(), sparx5_get_port_cal_speed,
> > sparx5_cal_bw and SPX5_DSM_CAL_EMPTY for use by lan969x.
> >
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> 
> [...]
> 
> > +     /* Place the remaining devices */
> > +     for (u32 i = 0; i < DSM_CAL_DEV_MAX; i++) {
> > +             speed = &dev_speeds[i];
> > +             for (u32 dev = 0; dev < speed->n_devs; dev++) {
> > +                     u32 idx = 0;
> > +
> > +                     for (n_slots = 0; n_slots < speed->n_slots; n_slots++) {
> > +                             lan969x_dsm_cal_idx_find_next_free(data->schedule,
> > +                                                                cal_len,
> > +                                                                &idx);
> 
> You're not checking the return of lan969x_dsm_cal_idx_find_next_free(),
> can this be a problem ?
> 
> Thanks,
> 
> Maxime

Yes, it should be checked as we have a finite number of calendar slots.

Will fix in v2. Thanks!

/Daniel


