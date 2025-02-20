Return-Path: <netdev+bounces-168194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE7A3DFF8
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69FE77A8B9D
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01F02080CC;
	Thu, 20 Feb 2025 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mUiBEOnh"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04531FFC4E
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067334; cv=none; b=tO8WPEn1xN6Q8lHyRFqKU2zNLFRRg88B9buxRfxoyxBNjj8YJ9+lkPSAspN7WIokGSyLHbl6aSYtAnoSLlLZ4/rXOuZgX1aiHMK3mL9Kqdq9fKv83QD1c2ylWxX0Ke2oin+ykxa8kAYElw1ephe2htq0lUEgRxXycYjAXh7sUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067334; c=relaxed/simple;
	bh=Ycd4i0bncaJVHEdlZV00H3hIQXZTrcKhKlTHaRcghNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkZUKGxUWF8Zg81cpHgf4BqTXEtj6yfDG5C5vFxhxDVICSHQzPh72ciBAT8pD2JQZS0lY6P3/Jrpj0+SQxNJbuxRAGIsptqBzOnodccrOprl/vK+BeE6Y6musf26p50JKpFm+oi8T/oSbkUn9DJ2koqLqLIe3ImbH99ZD8KdAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mUiBEOnh; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <451aca38-3b58-46c8-b6ce-6460f0504314@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740067330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0Y3+j7XSfdZ8z+5CWNHcH4kXI1FyK6N0PGbkacF2ag=;
	b=mUiBEOnh+GmKlUIACFY8Lv4VGRHrCDFemOgIHbs23rmbFMPaewp/v8RXEQpdzc9NqR6gIY
	61duQGLHZkN1Eyjw39NHNt1qjFb3vNdG2nfo+w7wt2kc8tkUm2j3T4qiqvR2gMK6XDLeSn
	9J7XJYiFhoacjBzM42iBTNvi0UmeQu8=
Date: Thu, 20 Feb 2025 11:02:07 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: cadence: macb: Synchronize stats calculations
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
References: <20250218195036.37137-1-sean.anderson@linux.dev>
 <20250219094851.0419759f@2a02-8440-d103-5c0b-874f-3af8-c06f-cd89.rev.sfr.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250219094851.0419759f@2a02-8440-d103-5c0b-874f-3af8-c06f-cd89.rev.sfr.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/19/25 03:48, Maxime Chevallier wrote:
> Hello Sean,
> 
> On Tue, 18 Feb 2025 14:50:36 -0500
> Sean Anderson <sean.anderson@linux.dev> wrote:
> 
>> Stats calculations involve a RMW to add the stat update to the existing
>> value. This is currently not protected by any synchronization mechanism,
>> so data races are possible. Add a spinlock to protect the update. The
>> reader side could be protected using u64_stats, but we would still need
>> a spinlock for the update side anyway. And we always do an update
>> immediately before reading the stats anyway.
>> 
>> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  drivers/net/ethernet/cadence/macb.h      |  2 ++
>>  drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++--
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
>> index 5740c98d8c9f..2847278d9cd4 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>> @@ -1279,6 +1279,8 @@ struct macb {
>>  	struct clk		*rx_clk;
>>  	struct clk		*tsu_clk;
>>  	struct net_device	*dev;
>> +	/* Protects hw_stats and ethtool_stats */
>> +	spinlock_t		stats_lock;
>>  	union {
>>  		struct macb_stats	macb;
>>  		struct gem_stats	gem;
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index 48496209fb16..990a3863c6e1 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1978,10 +1978,12 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
>>  
>>  		if (status & MACB_BIT(ISR_ROVR)) {
>>  			/* We missed at least one packet */
>> +			spin_lock(&bp->stats_lock);
>>  			if (macb_is_gem(bp))
>>  				bp->hw_stats.gem.rx_overruns++;
>>  			else
>>  				bp->hw_stats.macb.rx_overruns++;
>> +			spin_unlock(&bp->stats_lock);
>>  
>>  			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
>>  				queue_writel(queue, ISR, MACB_BIT(ISR_ROVR));
>> @@ -3102,6 +3104,7 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
>>  	if (!netif_running(bp->dev))
>>  		return nstat;
>>  
>> +	spin_lock(&bp->stats_lock);
>>  	gem_update_stats(bp);
>>  
>>  	nstat->rx_errors = (hwstat->rx_frame_check_sequence_errors +
>> @@ -3131,6 +3134,7 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
>>  	nstat->tx_aborted_errors = hwstat->tx_excessive_collisions;
>>  	nstat->tx_carrier_errors = hwstat->tx_carrier_sense_errors;
>>  	nstat->tx_fifo_errors = hwstat->tx_underrun;
>> +	spin_unlock(&bp->stats_lock);
>>  
>>  	return nstat;
>>  }
>> @@ -3138,12 +3142,13 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
>>  static void gem_get_ethtool_stats(struct net_device *dev,
>>  				  struct ethtool_stats *stats, u64 *data)
>>  {
>> -	struct macb *bp;
>> +	struct macb *bp = netdev_priv(dev);
>>  
>> -	bp = netdev_priv(dev);
>> +	spin_lock(&bp->stats_lock);
> 
> Sorry if I missed something, but as you're using that lock within the
> macb_interrupt(), shouldn't it be a spin_lock_irqsave() for all the
> callsites that aren't in irq context ?
> 
> You would risk a deadlock otherwise.

Yeah, looks like I missed this. Although I tested on a kernel with
lockdep enabled, and I thought that was supposed to catch this sort of
thing. Will send a v2.

--Sean

