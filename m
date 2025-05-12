Return-Path: <netdev+bounces-189647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B1FAB3076
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246B618946BA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 07:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618072561D7;
	Mon, 12 May 2025 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ieZauyCL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72F610D
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747034658; cv=none; b=GPFSWlSPe0XYXSy/EF85tyy6fkaEslkPlzzI4aN0ekzIpmIafypCRPjIFwcVKWTjSUlQ8ZgsNhNaVi5HyFg5QptfL8Dt/4sFvc/8LcHl2llUZYlzVp54yJfbjpK8JqGHusPT7atENaq94gqe/zeXkblxlsLNCtDtqrVkQWgb/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747034658; c=relaxed/simple;
	bh=PeXyXIHP/RU8DBQh7ZsPnR78m2y+ncwDffB4JH/enLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/pcEzL/zNuaEU+nzote4Lf4b3ZpxR/dOv7DMq59BPEOIjO8onFhXy34Y/NSSCS96y7nJqFwugfuuzfeblujx6UQFoQTniJhF8Ru3dRZo/S6zJ4yXUz3KCG7rE9zp7eUX+05GwTYMnZRmkKECaxwglrZGLZuMskYrB531/OCCwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ieZauyCL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747034656; x=1778570656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PeXyXIHP/RU8DBQh7ZsPnR78m2y+ncwDffB4JH/enLM=;
  b=ieZauyCLiQnZLSGrhmzBqqJoV6UvesSaJFNeaVpCL4IftQJ0AAP1tolB
   aTxlcDBa7L12zkISyhD9J2/7o12mP9ih7xkIEc6YKayQY+kD/rxx19HSs
   hGIgjgCjn/6uVyYin+QN8lY4vHMvPpNED17KIU0ux2nvobtL4fewjTG9H
   VTqwIomhvzoMCtCFxElxjAzLrc6DRVCDPAi0XuIpeJLiGR7AnqtZlU8tR
   lg114wmKobMaOq9xlHjxUj7f2Mx0tIEaMMxdBoMgDx8Sjj1qOSkc/ndUO
   f13AVnIyMQzq85XLBX+idvqYi4wURMG6jwtUGDU3muPeVJgO/FAVlRZUZ
   w==;
X-CSE-ConnectionGUID: 091CbATtSFuA8m3t6yrqew==
X-CSE-MsgGUID: /Wt3H8mkQnCi7uvGKztFrQ==
X-IronPort-AV: E=Sophos;i="6.15,281,1739862000"; 
   d="scan'208";a="41986285"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 May 2025 00:24:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 12 May 2025 00:23:55 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 12 May 2025 00:23:54 -0700
Date: Mon, 12 May 2025 09:22:27 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: Jason Xing <kerneljasonxing@gmail.com>, <irusskikh@marvell.com>,
	<andrew+netdev@lunn.ch>, <bharat@chelsio.com>, <ayush.sawal@chelsio.com>,
	<UNGLinuxDriver@microchip.com>, <mcoquelin.stm32@gmail.com>,
	<alexandre.torgue@foss.st.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<sgoutham@marvell.com>, <willemb@google.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH net-next v1 4/4] net: lan966x: generate software
 timestamp just before the doorbell
Message-ID: <20250512072227.wseiy7kfxyxbnj2l@DEN-DL-M31836.microchip.com>
References: <20250508033328.12507-1-kerneljasonxing@gmail.com>
 <20250508033328.12507-5-kerneljasonxing@gmail.com>
 <20250508070700.m3bufh2q4v4llbfx@DEN-DL-M31836.microchip.com>
 <CAL+tcoCuvxfQUbzjSfk+7vPWLEqQgVK8muqkOQe+N6jQQwXfUw@mail.gmail.com>
 <20250508094156.kbegdd5vianotsrr@DEN-DL-M31836.microchip.com>
 <20250508142157.sk7u37baqsl7yb64@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250508142157.sk7u37baqsl7yb64@skbuf>

The 05/08/2025 17:21, Vladimir Oltean wrote:
> 
> Horatiu,

Hi Vladimir,

> 
> On Thu, May 08, 2025 at 11:41:56AM +0200, Horatiu Vultur wrote:
> > > > > -       skb_tx_timestamp(skb);
> > > >
> > > > Changing this will break the PHY timestamping because the frame gets
> > > > modified in the next line, meaning that the classify function will
> > > > always return PTP_CLASS_NONE.
> > >
> > > Sorry that I'm not that familiar with the details. I will remove it
> > > from this series, but still trying to figure out what cases could be.
> > >
> > > Do you mean it can break when bpf prog is loaded because
> > > 'skb_push(skb, IFH_LEN_BYTES);' expands the skb->data area?
> >
> > Well, the bpf program will check if it is a PTP frame that needs to be
> > timestamp when it runs ptp_classify_raw, and as we push some data in
> > front of the frame, the bpf will run from that point meaning that it
> > would failed to detect the PTP frames.
> >
> > > May I ask
> > > how the modified data of skb breaks the PHY timestamping feature?
> >
> > If it fails to detect that it is a PTP frame, then the frame will not be
> > passed to the PHY using the callback txtstamp. So the PHY will timestamp the
> > frame but it doesn't have the frame to attach the timestamp.
> 
> While I was further discussing this in private with Jason, a thought
> popped up in my head.
> 
> Shouldn't skb_tx_timestamp(skb); be done _before_ this section?
> 
>         /* skb processing */
>         needed_headroom = max_t(int, IFH_LEN_BYTES - skb_headroom(skb), 0);
>         needed_tailroom = max_t(int, ETH_FCS_LEN - skb_tailroom(skb), 0);
>         if (needed_headroom || needed_tailroom || skb_header_cloned(skb)) {
>                 err = pskb_expand_head(skb, needed_headroom, needed_tailroom,
>                                        GFP_ATOMIC);
>                 if (unlikely(err)) {
>                         dev->stats.tx_dropped++;
>                         err = NETDEV_TX_OK;
>                         goto release;
>                 }
>         }
> 
> The idea is that skb_tx_timestamp() calls skb_clone_tx_timestamp(), and
> that should require skb_unshare() before you make any further
> modification like insert an IFH here, so that the IFH is not visible to
> clones (and thus to user space, on the socket error queue).
> 
> I think pskb_expand_head() serves the role of skb_unshare(), because I
> see skb_header_cloned() is one of the conditions on which it is called.
> 
> But the problem is that skb_header_cloned() may have been false, then
> skb_tx_timestamp() makes skb_header_cloned() true, but pskb_expand_head()
> has already run. So the IFH is shared with the clone made for TX
> timestamping purposes, I guess.
> 
> Am I completely off?

Sorry for late reply.
I think you are right!. I just want to double check by actually trying
it.

> 
> Also, I believe you can set dev->needed_headroom = IFH_LEN_BYTES,
> dev->needed_tailroom = ETH_FCS_LEN, and then just call
> skb_ensure_writable_head_tail().

Thanks for the advice. I will look also into this.

-- 
/Horatiu

