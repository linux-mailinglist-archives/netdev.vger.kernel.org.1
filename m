Return-Path: <netdev+bounces-84130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAF5895AEF
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080C42838BF
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 17:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743815AAA0;
	Tue,  2 Apr 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="0EmkGVUL"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D4159910
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079787; cv=none; b=Vz27jWCUjzgV5PJsSAatZIynEuSqaYNQBeV5KmDEwNaDOA4VYffbtmmGcvw/otogpQD4MEY5FvcvE6/dree6Y+lcEzts7cJWo7fwbIl0B7jRT9FGEPSAdK/p52598rsbtf0xUeV2Nkh1unjPh8jHGnsurSFSQwCBf8MrF9i/4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079787; c=relaxed/simple;
	bh=6/tYhRJGVlwAAqKMWpPakGBGT7qTcbeH1D2RgY8vOeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCvdovMHdbPJDhd8GhTXCrUCapCod9VjNO6VJSwuMXXT9VrhZ1VzvXZKZgztMEtfIhVXuoOUTDuLZWN/TsutJPrXevvnLBFTBwygTckrJp4JcyvNJMArTMOhciksITE9XZeNzi2z7k6rlG+yIMak9xym1YCc/6fSC640RcjFj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=0EmkGVUL; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9C41387BE0;
	Tue,  2 Apr 2024 19:43:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712079784;
	bh=LldLY5c9WeZysshe2t8T3YxEAFO4iw2GkaNcG2Hksq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0EmkGVULgiH6ra+ZT12URPgrr7HicnV2SQa0yu7hFvCaKFLG/GW6x73TISvc+sy6A
	 EgaH1Noxg5W6SoiQmqCSRFxSa+9e17pgV4M78nM2wA9LSqVgcpSiHUL+ecO5EN1gLL
	 r7mAEV5IFGAZ4sxXEMP6Sr/7AAqanpxaD+JLyyi6frrYRd0FxzmI25kXYFCbzpG63z
	 LMyK4YmpKTKiTuM2XxRcJpf9nKmxkbqVdcauPUFie/qhmbNbae48Vz70Ptv+EnAgua
	 DJQo+hfAM+WxTeNYReNqtYu1cExNOk2uOYrRWoy3kM9G/niATS4pcdm4L/bAuercl/
	 kgmUPkzOFlZqg==
Message-ID: <96ee283f-53cc-4317-8ac5-f08c4291a887@denx.de>
Date: Tue, 2 Apr 2024 19:38:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: ks8851: Handle softirqs at the end of IRQ thread
 to fix hang
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Mark Brown <broonie@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ronald Wahl <ronald.wahl@raritan.com>,
 Simon Horman <horms@kernel.org>
References: <20240331142353.93792-1-marex@denx.de>
 <20240331142353.93792-2-marex@denx.de> <20240401210642.76f0d989@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240401210642.76f0d989@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/2/24 6:06 AM, Jakub Kicinski wrote:
> On Sun, 31 Mar 2024 16:21:46 +0200 Marek Vasut wrote:
>> diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
>> index 896d43bb8883d..b6b727e651f3d 100644
>> --- a/drivers/net/ethernet/micrel/ks8851_common.c
>> +++ b/drivers/net/ethernet/micrel/ks8851_common.c
>> @@ -299,7 +299,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
>>   					ks8851_dbg_dumpkkt(ks, rxpkt);
>>   
>>   				skb->protocol = eth_type_trans(skb, ks->netdev);
>> -				netif_rx(skb);
>> +				__netif_rx(skb);
> 
> maybe return the packets from ks8851_rx_pkts()
> (you can put them on a queue / struct sk_buff_head)
> and process them once the lock is released?

I think that's what netif_rx() basically already does internally in 
netif_rx_internal():

enqueue_to_backlog(skb, smp_processor_id(), &qtail);

> Also why not NAPI?

I am not quite sure what to answer here. Are you asking me to add NAPI 
support to the driver ?

>>   				ks->netdev->stats.rx_packets++;
>>   				ks->netdev->stats.rx_bytes += rxlen;
>> @@ -325,11 +325,15 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
>>    */
>>   static irqreturn_t ks8851_irq(int irq, void *_ks)
>>   {
>> +	bool need_bh_off = !(hardirq_count() | softirq_count());
> 
> I don't think IRQ / RT developers look approvingly at uses of such
> low level macros in drivers.

I _think_ the need_bh_off will be always true as Ratheesh suggested, so 
this can be dropped. I will test that before doing a V2.

