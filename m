Return-Path: <netdev+bounces-104626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CA290DA42
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61AF286BF6
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2C11514F4;
	Tue, 18 Jun 2024 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rep0Gl2V"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B115098D
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730237; cv=none; b=WFtnLSRTgGTWzCmVwQa/1gzOrM07xQ5Kpn+3UVn2zegDTwG+ut7QgoTrMqhIekAbpdA9xT/UFUpfzEwjLCAyMKj5gSym5J2yzIn8IXqfTBU5A5pc4hNfjQtj43O0bfurBAwT3UVVzDPY76thT5Rkt0hC49lFe02yfturOoS/xnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730237; c=relaxed/simple;
	bh=tU4Pl8FhzvPz6/+O1I7wCGcjD88hvKemRL7+LEj0dtQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fDhgPBk4eIG9LLeYQO9Hrz7xForjmOaWaHG77oV06rE0OyoOIc0w+CACZPStRi+EYJ6E7/wfxSSAQelslU3RlMcgfx/8GczLEjADEvnTIap7eF+ZjwsymbdhGVuaJFp/AsRIuZ4ZRpTI1hN5vqYJNE5EVhMlyWo2lygwdWUyYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rep0Gl2V; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: andrew@lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718730232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhC3fIlPeEFs/L5Am5S/C/DO9R5qMPwRn4AKQZcbuHg=;
	b=rep0Gl2VcCDeh4HBiHD+VKEdZKbOadCJVC+FQFC0B7rg73n8fHbB2Z1Iy8AjDyYEeNRnZX
	Mnj4qONz7erBHo0XddGSvOaNXm1QUG216f+7WT+njRQV64AFvWUiNzjM1yufmZ35ZF/zvk
	pcXaCKsjNl2JcRdQHz4W6AnyZ0CXwKo=
X-Envelope-To: radhey.shyam.pandey@amd.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux@armlinux.org.uk
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: davem@davemloft.net
Message-ID: <6f4916a0-f949-4289-9839-d89af574600d@linux.dev>
Date: Tue, 18 Jun 2024 13:03:47 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/3] net: xilinx: axienet: Add statistics support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
 <20240610231022.2460953-4-sean.anderson@linux.dev>
 <40cff9a6-bad3-4f85-8cbc-6d4bc72f9b9f@lunn.ch>
 <4d3871c1-afa1-4402-ad62-2fdb9d58dc3c@linux.dev>
Content-Language: en-US
In-Reply-To: <4d3871c1-afa1-4402-ad62-2fdb9d58dc3c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Andrew,

On 6/11/24 11:36, Sean Anderson wrote:
> On 6/10/24 20:26, Andrew Lunn wrote:
>>> +static u64 axienet_stat(struct axienet_local *lp, enum temac_stat stat)
>>> +{
>>> +	return u64_stats_read(&lp->hw_stats[stat]);
>>> +}
>>> @@ -1695,6 +1760,35 @@ axienet_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>>>  		stats->tx_packets = u64_stats_read(&lp->tx_packets);
>>>  		stats->tx_bytes = u64_stats_read(&lp->tx_bytes);
>>>  	} while (u64_stats_fetch_retry(&lp->tx_stat_sync, start));
>>> +
>>> +	if (!(lp->features & XAE_FEATURE_STATS))
>>> +		return;
>>> +
>>> +	do {
>>> +		start = u64_stats_fetch_begin(&lp->hw_stat_sync);
>>> +		stats->rx_length_errors =
>>> +			axienet_stat(lp, STAT_RX_LENGTH_ERRORS);
>> 
>> I'm i reading this correctly. You are returning the counters from the
>> last refresh period. What is that? 2.5Gbps would wrapper around a 32
>> byte counter in 13 seconds. I hope these statistics are not 13 seconds
>> out of date?
> 
> By default we use a 1 Hz refresh period. You can of course configure this
> up to 13 seconds, but we refuse to raise it further since we risk missing
> a wrap-around. It's configurable by userspace so they can determine how
> out-of-date they like their stats (vs how often they want to wake up the
> CPU).
> 
>> Since axienet_stats_update() also uses the lp->hw_stat_sync, i don't
>> see why you cannot read the hardware counter value and update to the
>> latest value.
> 
> We would need to synchronize against updates to hw_last_counter. Imagine
> a scenario like
> 
> CPU 1					CPU 2
> __axienet_device_reset()
> 	axienet_stats_update()
> 					axienet_stat()
> 						u64_stats_read()
> 						axienet_ior()
> 	/* device reset */
> 	hw_last_counter = 0
> 						stats->foo = ... - hw_last_counter[...]
> 
> and now we have a glitch in the counter values, since we effectively are
> double-counting the current counter value. Alternatively, we could read
> the counter after reset but before hw_last_counter was updated and get a
> glitch due to underflow.

Does this make sense to you? If it does, I'll send v2 with just the mutex
change and the variable rename pointed out by Simon.

--Sean


