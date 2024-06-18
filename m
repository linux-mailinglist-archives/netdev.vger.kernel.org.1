Return-Path: <netdev+bounces-104648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7735F90DB85
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 20:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E7F1C2244F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE7E15E5D2;
	Tue, 18 Jun 2024 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bXnk0DbK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0D15E5CF;
	Tue, 18 Jun 2024 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734777; cv=none; b=k5T08lIsFj3GUbRK7qgmDFvNviRjcQwB6VIkUOwtAfU1SX2PfE5ru3+WlLckBNuw42Xf7Sg0sa5F+HcVKLnJENIEOM/d3BDubTtRFq4o7VmqA8wwd15x436RL+vhISoTRnXWkr/4qkJPoZkyghEN0GnRJAQCY5QlYkWvzS6cA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734777; c=relaxed/simple;
	bh=CLRncUBTVR45wvAAsnnxKrLdiCWAIAAdhMnHTW424Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISUFgDySGaXmWCNl3RHoaEe4q0vgeNjTPwOCHpIa67ULxLBssd8Podcvd40/pngmDqAVDp39824xEjj3JJTV2TTS79xFni3aNa0wlGZy/TCCfxgKomKxmgpHeL/wLW+9+c03XYZr/6/vwsoHEaHbsPoCPIEo+oSzUbEPrltTYCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bXnk0DbK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6rF013NYkWJ7vC3dig6F3esypwWGqLP9D25G+i9avEQ=; b=bXnk0DbK9InWp0ysw0ZGDBc6yC
	6QCcBK5AvURctxeWVAS/qAiQzwQRUh1a3iYpJ5+6wRi/mO0hUrIKygoT6F5m5CXlH1f7+PctwVwPS
	JebNBhHZyVcami3ElkOslYTSNM3KSCGByLSPGKbGp52izFyC1CSh4FCVTAau4PZ0bk+g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sJdQE-000PKk-Jc; Tue, 18 Jun 2024 20:19:10 +0200
Date: Tue, 18 Jun 2024 20:19:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 3/3] net: xilinx: axienet: Add statistics support
Message-ID: <a4bea058-c5cd-4d8f-ab0f-cd637ccb3969@lunn.ch>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
 <20240610231022.2460953-4-sean.anderson@linux.dev>
 <40cff9a6-bad3-4f85-8cbc-6d4bc72f9b9f@lunn.ch>
 <4d3871c1-afa1-4402-ad62-2fdb9d58dc3c@linux.dev>
 <6f4916a0-f949-4289-9839-d89af574600d@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4916a0-f949-4289-9839-d89af574600d@linux.dev>

On Tue, Jun 18, 2024 at 01:03:47PM -0400, Sean Anderson wrote:
> Hi Andrew,
> 
> On 6/11/24 11:36, Sean Anderson wrote:
> > On 6/10/24 20:26, Andrew Lunn wrote:
> >>> +static u64 axienet_stat(struct axienet_local *lp, enum temac_stat stat)
> >>> +{
> >>> +	return u64_stats_read(&lp->hw_stats[stat]);
> >>> +}
> >>> @@ -1695,6 +1760,35 @@ axienet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
> >>>  		stats->tx_packets = u64_stats_read(&lp->tx_packets);
> >>>  		stats->tx_bytes = u64_stats_read(&lp->tx_bytes);
> >>>  	} while (u64_stats_fetch_retry(&lp->tx_stat_sync, start));
> >>> +
> >>> +	if (!(lp->features & XAE_FEATURE_STATS))
> >>> +		return;
> >>> +
> >>> +	do {
> >>> +		start = u64_stats_fetch_begin(&lp->hw_stat_sync);
> >>> +		stats->rx_length_errors =
> >>> +			axienet_stat(lp, STAT_RX_LENGTH_ERRORS);
> >> 
> >> I'm i reading this correctly. You are returning the counters from the
> >> last refresh period. What is that? 2.5Gbps would wrapper around a 32
> >> byte counter in 13 seconds. I hope these statistics are not 13 seconds
> >> out of date?
> > 
> > By default we use a 1 Hz refresh period. You can of course configure this
> > up to 13 seconds, but we refuse to raise it further since we risk missing
> > a wrap-around. It's configurable by userspace so they can determine how
> > out-of-date they like their stats (vs how often they want to wake up the
> > CPU).
> > 
> >> Since axienet_stats_update() also uses the lp->hw_stat_sync, i don't
> >> see why you cannot read the hardware counter value and update to the
> >> latest value.
> > 
> > We would need to synchronize against updates to hw_last_counter. Imagine
> > a scenario like
> > 
> > CPU 1					CPU 2
> > __axienet_device_reset()
> > 	axienet_stats_update()
> > 					axienet_stat()
> > 						u64_stats_read()
> > 						axienet_ior()
> > 	/* device reset */
> > 	hw_last_counter = 0
> > 						stats->foo = ... - hw_last_counter[...]
> > 
> > and now we have a glitch in the counter values, since we effectively are
> > double-counting the current counter value. Alternatively, we could read
> > the counter after reset but before hw_last_counter was updated and get a
> > glitch due to underflow.
> 
> Does this make sense to you? If it does, I'll send v2 with just the mutex
> change and the variable rename pointed out by Simon.

What you have is O.K. I just think you can do better.

As you point out, there is a potential race. There are a few
synchronisation mechanisms for that.

Often you arrange to have exclusive access to a data structure, so you
know it cannot change while you use it. But as you pointed out, you
are not in a context which can block on a mutex.

Another mechanism is to know if the data structure has changed while
you where using it. If it has, throw away what you have, and start
again. That is what lp->hw_stat_sync etc is all about. You loop while
its value changes, indicating something made changes. You should be
able to use this when returning statistics to user space, to return
the real current statistics, not old cached values.

    Andrew


