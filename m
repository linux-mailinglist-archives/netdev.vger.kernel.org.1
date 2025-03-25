Return-Path: <netdev+bounces-177539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F243DA70800
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881A4169CCD
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B08C261396;
	Tue, 25 Mar 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrjVHxK4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65C1ACEA6;
	Tue, 25 Mar 2025 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923258; cv=none; b=oMsSY2LdwRxHI6u//+LbK2qi4P+DSyBqHzn6oIooEl1aTJqR/EoawgXppVnUKphb0WWWA66ZnEsF+jiP6k3IT5/+B2KhMcj3GrsfF1POgZ/rIIpIgPeaW6dZ6tL156WAiEKTYtKJwP7UO81JGNzmAqk0hGH+rgEP9UocgyIP1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923258; c=relaxed/simple;
	bh=xc1ElJ+b62y35nkWclbBi+8sfEbTXnBuisi6UIeMPJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CE/GmHQiZAbzpQYS1Q/ph9KBCd2XEL9LsnEFKrERs0P5nNrih2S8XCfniWs6TMp6vxeI2yk8zKQKCgslxIC4XtO4Ja+eiCbBhdqKtw+bpXgz+WVZABdOjx9mASPDH1Phyz+x0W7Rg7urIM3WfQLPgl4+FIZ9Vg83LdeB4Ot9LFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrjVHxK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEABC4CEE4;
	Tue, 25 Mar 2025 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742923257;
	bh=xc1ElJ+b62y35nkWclbBi+8sfEbTXnBuisi6UIeMPJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JrjVHxK4qUYgdAElLMMKqzlJL6Nkc6XDXr0vM1YN5NBCHJG/j+YfSIXUjSSe7T6r9
	 /deraSB+/od4aB7zmCzwXQz2DlVcoMq0mnilNc7CdQTK65JUJuogbM9tzBYmaUGMYP
	 ute+DegIAWcQzgtAdujrIJBZ4xqzlW5YQJif1GO46z4ryTfaQ3IDVfG81bbS9m4v/6
	 UcnBxZQjyhIl0/ymnIKFxFPSLwF88wtqfBmd1kAskMFlnIZ1Ut8VbIPVa0tEYP0gsd
	 cimXHWRQOVEayDRaDhOoX3As6Ao03ASrQ1go6UJDitIKmveWaRelKhU1aLJ3AmJFIM
	 nCeXT7uz7foJw==
Date: Tue, 25 Mar 2025 17:20:53 +0000
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next] rtase: Add ndo_setup_tc support for CBS offload
 in traffic control setup
Message-ID: <20250325172053.GX892515@horms.kernel.org>
References: <20250314094021.10120-1-justinlai0215@realtek.com>
 <20250319123407.GC280585@kernel.org>
 <6824bd62f05644ec8d301457449eae19@realtek.com>
 <ab27fd1a1e9d40759e090346eafb5881@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab27fd1a1e9d40759e090346eafb5881@realtek.com>

On Mon, Mar 24, 2025 at 12:06:09PM +0000, Justin Lai wrote:
> > 
> > > On Fri, Mar 14, 2025 at 05:40:21PM +0800, Justin Lai wrote:
> > > > Add support for ndo_setup_tc to enable CBS offload functionality as
> > > > part of traffic control configuration for network devices.
> > > >
> > > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > >
> > > ...
> > >
> > > > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > > index 2aacc1996796..2a61cd192026 100644
> > > > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > > @@ -1661,6 +1661,54 @@ static void rtase_get_stats64(struct
> > > > net_device
> > > *dev,
> > > >       stats->rx_length_errors = tp->stats.rx_length_errors;  }
> > > >
> > > > +static void rtase_set_hw_cbs(const struct rtase_private *tp, u32
> > > > +queue) {
> > > > +     u32 idle = tp->tx_qos[queue].idleslope * RTASE_1T_CLOCK;
> > > > +     u32 val, i;
> > > > +
> > > > +     val = u32_encode_bits(idle / RTASE_1T_POWER,
> > > RTASE_IDLESLOPE_INT_MASK);
> > > > +     idle %= RTASE_1T_POWER;
> > > > +
> > > > +     for (i = 1; i <= RTASE_IDLESLOPE_INT_SHIFT; i++) {
> > > > +             idle *= 2;
> > > > +             if ((idle / RTASE_1T_POWER) == 1)
> > > > +                     val |= BIT(RTASE_IDLESLOPE_INT_SHIFT - i);
> > > > +
> > > > +             idle %= RTASE_1T_POWER;
> > > > +     }
> > > > +
> > > > +     rtase_w32(tp, RTASE_TXQCRDT_0 + queue * 4, val); }
> > > > +
> > > > +static void rtase_setup_tc_cbs(struct rtase_private *tp,
> > > > +                            const struct tc_cbs_qopt_offload *qopt)
> > {
> > > > +     u32 queue = qopt->queue;
> > >
> > > Hi Justin,
> > >
> > > Does queue need to be checked somewhere to make sure it is in range?
> > 
> > Hi Simon,
> > 
> > Thank you for your response. I will add a check to ensure that the queue is
> > within the specified range.
> 
> Hi Simon,
> 
> Given that our hardware supports CBS offload on each queue, could it
> be possible that checking the range of qopt->queue might not be
> necessary?

Hi Justin,

If qopt->queue can only be a valid queue, and all queues support
CBS, then I guess it would not be necessary.

