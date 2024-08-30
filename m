Return-Path: <netdev+bounces-123871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 187A6966B37
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C27E1F22DDB
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D41BFDEB;
	Fri, 30 Aug 2024 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k79a1sHZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC516DEC8;
	Fri, 30 Aug 2024 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052957; cv=none; b=KbR1lbNezAiorEzMicG3T+0fB4GHmxQ4J99vIdZB5iv5lrRc1YfqPg7LLRcen5XFzxuRmm7l4Mbon7tEI/clajOeUqKodIxezvH+KFUx/blEdw3da5HsuyJLSg9QoQ0MEbCZyhG6N4dJB+4TIIb4gKMVZGiKbvP4daaCDhMvwOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052957; c=relaxed/simple;
	bh=Os5/RnZW/qxRUPFtDFX+ps/hR3vJ2+KZ7bqf+kBiu4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoX0EBizdsdboNIBDZo1fCpMdmPRCNmHBzT2kiY3cfSnz5OhQNOzqRxINZwZ+rhrbnUfrjD5U60j9p+RR+eUpPdLuopiU8DbdyzV7h8hvEG6hacH7OA4hZQgfMCS4axnEJKsWdh8g02QOClY6gRhRE16NPgex+Zwix9vxtmeLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k79a1sHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BC7C4CEC2;
	Fri, 30 Aug 2024 21:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725052956;
	bh=Os5/RnZW/qxRUPFtDFX+ps/hR3vJ2+KZ7bqf+kBiu4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k79a1sHZWgmD+qU9X/BFm8jZz/ibRtrDooiosh7d3quD3PRy2dWG1DWmsfi5Ndwo/
	 j3Anf5hYMoIA9Udx2exvruzhenHdm17ZnEvPz7j/riF5N43ea7uBLxQWOyy+twcGy0
	 kKJAqkbsYVs1q8GYyVqNCSY/DSdWfToh0Lef2HBRe2sKbZVwpyW+rleUzXhrE0UPmZ
	 9olAOvAANAKXiddbZgocTj0uRpytTbtVDaiGoWPrCxDif2id30qWK6L1S7mKXXtEKo
	 Nivi9HcC549ljZisC3y+UCwyInzkQIkNMuaSImFzFrnEqiWr+ei+gOvGN9sDbBDjj1
	 tybSSzU50CHGw==
Date: Fri, 30 Aug 2024 14:22:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
 hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com,
 skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens <danielj@nvidia.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <20240830142235.352dbad5@kernel.org>
In-Reply-To: <ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-6-jdamato@fastly.com>
	<20240829153105.6b813c98@kernel.org>
	<ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 11:43:00 +0100 Joe Damato wrote:
> On Thu, Aug 29, 2024 at 03:31:05PM -0700, Jakub Kicinski wrote:
> > On Thu, 29 Aug 2024 13:12:01 +0000 Joe Damato wrote:  
> > > +	napi = napi_by_id(napi_id);
> > > +	if (napi)
> > > +		err = netdev_nl_napi_set_config(napi, info);
> > > +	else
> > > +		err = -EINVAL;  
> > 
> > if (napi) {
> > ...
> > } else {
> > 	NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID])
> > 	err = -ENOENT;
> > }  
> 
> Thanks, I'll make that change in the v2.
> 
> Should I send a Fixes for the same pattern in
> netdev_nl_napi_get_doit ?

SG, standalone patch is good, FWIW, no need to add to the series.

> > > +      doc: Set configurable NAPI instance settings.  
> > 
> > We should pause and think here how configuring NAPI params should
> > behave. NAPI instances are ephemeral, if you close and open the
> > device (or for some drivers change any BPF or ethtool setting)
> > the NAPIs may get wiped and recreated, discarding all configuration.
> > 
> > This is not how the sysfs API behaves, the sysfs settings on the device
> > survive close. It's (weirdly?) also not how queues behave, because we
> > have struct netdev{_rx,}_queue to store stuff persistently. Even tho
> > you'd think queues are as ephemeral as NAPIs if not more.
> > 
> > I guess we can either document this, and move on (which may be fine,
> > you have more practical experience than me). Or we can add an internal
> > concept of a "channel" (which perhaps maybe if you squint is what
> > ethtool -l calls NAPIs?) or just "napi_storage" as an array inside
> > net_device and store such config there. For simplicity of matching
> > config to NAPIs we can assume drivers add NAPI instances in order. 
> > If driver wants to do something more fancy we can add a variant of
> > netif_napi_add() which specifies the channel/storage to use.
> > 
> > Thoughts? I may be overly sensitive to the ephemeral thing, maybe
> > I work with unfortunate drivers...  
> 
> Thanks for pointing this out. I think this is an important case to
> consider. Here's how I'm thinking about it.
> 
> There are two cases:
> 
> 1) sysfs setting is used by existing/legacy apps: If the NAPIs are
> discarded and recreated, the code I added to netif_napi_add_weight
> in patch 1 and 3 should take care of that case preserving how sysfs
> works today, I believe. I think we are good on this case ?

Agreed.

> 2) apps using netlink to set various custom settings. This seems
> like a case where a future extension can be made to add a notifier
> for NAPI changes (like the netdevice notifier?).

Yes, the notifier may help, but it's a bit of a stop gap / fallback.

> If you think this is a good idea, then we'd do something like:
>   1. Document that the NAPI settings are wiped when NAPIs are wiped
>   2. In the future (not part of this series) a NAPI notifier is
>      added
>   3. User apps can then listen for NAPI create/delete events
>      and update settings when a NAPI is created. It would be
>      helpful, I think, for user apps to know about NAPI
>      create/delete events in general because it means NAPI IDs are
>      changing.
> 
> One could argue:
> 
>   When wiping/recreating a NAPI for an existing HW queue, that HW
>   queue gets a new NAPI ID associated with it. User apps operating
>   at this level probably care about NAPI IDs changing (as it affects
>   epoll busy poll). Since the settings in this series are per-NAPI
>   (and not per HW queue), the argument could be that user apps need
>   to setup NAPIs when they are created and settings do not persist
>   between NAPIs with different IDs even if associated with the same
>   HW queue.

IDK if the fact that NAPI ID gets replaced was intentional in the first
place. I would venture a guess that the person who added the IDs was
working with NICs which have stable NAPI instances once the device is
opened. This is, unfortunately, not universally the case.

I just poked at bnxt, mlx5 and fbnic and all of them reallocate NAPIs
on an open device. Closer we get to queue API the more dynamic the whole
setup will become (read: the more often reconfigurations will happen).

> Admittedly, from the perspective of a user it would be nice if a new
> NAPI created for an existing HW queue retained the previous
> settings so that I, as the user, can do less work.
> 
> But, what happens if a HW queue is destroyed and recreated? Will any
> HW settings be retained? And does that have any influence on what we
> do in software? See below.

Up to the driver, today. But settings we store in queue structs in 
the core are not wiped.

> This part of your message:
> 
> > we can assume drivers add NAPI instances in order. If driver wants
> > to do something more fancy we can add a variant of
> > netif_napi_add() which specifies the channel/storage to use.  
> 
> assuming drivers will "do a thing", so to speak, makes me uneasy.

Yeah.. :(

> I started to wonder: how do drivers handle per-queue HW IRQ coalesce
> settings when queue counts increase? It's a different, but adjacent
> problem, I think.
> 
> I tried a couple experiments on mlx5 and got very strange results
> suitable for their own thread and I didn't want to get this thread
> too far off track.

Yes, but ethtool is an old shallow API from the times when semantics
were simpler. It's precisely this mess which we try to avoid by storing
more of the config in the core, in a consistent fashion.

> I think you have much more practical experience when it comes to
> dealing with drivers, so I am happy to follow your lead on this one,
> but assuming drivers will "do a thing" seems mildly scary to me with
> limited driver experience.
> 
> My two goals with this series are:
>   1. Make it possible to set these values per NAPI
>   2. Unblock the IRQ suspension series by threading the suspend
>      parameter through the code path carved in this series
> 
> So, I'm happy to proceed with this series as you prefer whether
> that's documentation or "napi_storage"; I think you are probably the
> best person to answer this question :)

How do you feel about making this configuration opt-in / require driver
changes? What I'm thinking is that having the new "netif_napi_add()"
variant (or perhaps extending netif_napi_set_irq()) to take an extra
"index" parameter would make the whole thing much simpler.

Index would basically be an integer 0..n, where n is the number of
IRQs configured for the driver. The index of a NAPI instance would
likely match the queue ID of the queue the NAPI serves.

We can then allocate an array of "napi_configs" in net_device -
like we allocate queues, the array size would be max(num_rx_queue,
num_tx_queues). We just need to store a couple of ints so it will
be tiny compared to queue structs, anyway.

The NAPI_SET netlink op can then work based on NAPI index rather 
than the ephemeral NAPI ID. It can apply the config to all live
NAPI instances with that index (of which there really should only 
be one, unless driver is mid-reconfiguration somehow but even that
won't cause issues, we can give multiple instances the same settings)
and also store the user config in the array in net_device.

When new NAPI instance is associate with a NAPI index it should get
all the config associated with that index applied.

Thoughts? Does that makes sense, and if so do you think it's an
over-complication?

