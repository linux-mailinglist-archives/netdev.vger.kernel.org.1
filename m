Return-Path: <netdev+bounces-83745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B33F893AC7
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 14:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9A31F21D60
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 12:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8081B21340;
	Mon,  1 Apr 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="O3e4/dlJ"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C941E867
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711973235; cv=none; b=nQsTkSQX4J70jeMdRI1icLpMdn9Q9z7ef0TBc/S4s0gYqJp/q5OwZ1SsRfmQNFuoKJdc8gjjxcFELekXbJKcUwmoe/fPOrMu4tnURHSWVm3szhO6UM9OpjGJ/lOoGofD9O9C+0fem9L3kLVsu/PIUm+HKb66fP2+IK93/K6IvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711973235; c=relaxed/simple;
	bh=NglGyb4RetQTQtfTT++GnImT6lhP1UeZveOoypGkqLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TuFRyoDic45RLXMgmCOjcdKBcNO46oggyoFBprfsZZGwNOD/BWfW7mMvzVdkBbR/3hwyrRt+WZF/EONk4BcvjvYWviPJGXiAc4uKy6umSnu2Mx0mnCFBaOC2zq5H7uGCePCBJseliSLGP0hWD7jBQxj21fkhS6G5Qpju3Cyi/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=O3e4/dlJ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 509228800D;
	Mon,  1 Apr 2024 14:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711973225;
	bh=OFof0NH4aKINz2fEH7BBzororrwklPSelMmUd5/ZM/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O3e4/dlJNcpsiyIo0vPO0SSPQ9m9EuHq89lYpJq4mBHjhSIkA4lAwKLcUcI+/k9t8
	 BoRbb1AijSfRyKygApslDiOHr6+WprCkE80ftWac1rPXl25P6vE405Vs7D59AF9Bms
	 jmN7Wsa40fzgrnVlcE5u+S5JyvNSHwZf2iEu6nrpTOdDe20n9wIHYFGNLuQOlOkZ99
	 rDMDMFjcXw+5XP6lzS2gKHus2YH25rArtCyOUl1V6OUuKUUA8AchOaOdHnxttqo2X4
	 9Qw8eSxTFtRv7OPntZe4CLLaF82kgB1jUC0vVGzSjRURS/mxM9uG5AJvm3FJXaqyBV
	 STocNUCQM7MXQ==
Message-ID: <09dd9be4-a59e-472f-81fc-7686121a18bf@denx.de>
Date: Mon, 1 Apr 2024 12:41:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: ks8851: Handle softirqs at the end of IRQ thread
 to fix hang
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ronald Wahl <ronald.wahl@raritan.com>, Simon Horman <horms@kernel.org>
References: <20240331142353.93792-1-marex@denx.de>
 <20240331142353.93792-2-marex@denx.de>
 <20240401041810.GA1639126@maili.marvell.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240401041810.GA1639126@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/1/24 6:18 AM, Ratheesh Kannoth wrote:
> On 2024-03-31 at 19:51:46, Marek Vasut (marex@denx.de) wrote:
>> The ks8851_irq() thread may call ks8851_rx_pkts() in case there are
>> any packets in the MAC FIFO, which calls netif_rx(). This netif_rx()
>> implementation is guarded by local_bh_disable() and local_bh_enable().
>> The local_bh_enable() may call do_softirq() to run softirqs in case
>> any are pending. One of the softirqs is net_rx_action, which ultimately
>> reaches the driver .start_xmit callback. If that happens, the system
>> hangs. The entire call chain is below:
>>
>> ks8851_start_xmit_par from netdev_start_xmit
>> netdev_start_xmit from dev_hard_start_xmit
>> dev_hard_start_xmit from sch_direct_xmit
>> sch_direct_xmit from __dev_queue_xmit
>> __dev_queue_xmit from __neigh_update
>> __neigh_update from neigh_update
>> neigh_update from arp_process.constprop.0
>> arp_process.constprop.0 from __netif_receive_skb_one_core
>> __netif_receive_skb_one_core from process_backlog
>> process_backlog from __napi_poll.constprop.0
>> __napi_poll.constprop.0 from net_rx_action
>> net_rx_action from __do_softirq
>> __do_softirq from call_with_stack
>> call_with_stack from do_softirq
>> do_softirq from __local_bh_enable_ip
>> __local_bh_enable_ip from netif_rx
>> netif_rx from ks8851_irq
>> ks8851_irq from irq_thread_fn
>> irq_thread_fn from irq_thread
>> irq_thread from kthread
>> kthread from ret_from_fork
>>
>> The hang happens because ks8851_irq() first locks a spinlock in
>> ks8851_par.c ks8851_lock_par() spin_lock_irqsave(&ksp->lock, ...)
>> and with that spinlock locked, calls netif_rx(). Once the execution
>> reaches ks8851_start_xmit_par(), it calls ks8851_lock_par() again
>> which attempts to claim the already locked spinlock again, and the
>> hang happens.
>>
>> Move the do_softirq() call outside of the spinlock protected section
>> of ks8851_irq() by disabling BHs around the entire spinlock protected
>> section of ks8851_irq() handler. Place local_bh_enable() outside of
>> the spinlock protected section, so that it can trigger do_softirq()
>> without the ks8851_par.c ks8851_lock_par() spinlock being held, and
>> safely call ks8851_start_xmit_par() without attempting to lock the
>> already locked spinlock.
>>
>> Since ks8851_irq() is protected by local_bh_disable()/local_bh_enable()
>> now, replace netif_rx() with __netif_rx() which is not duplicating the
>> local_bh_disable()/local_bh_enable() calls.

[...]

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
>>
>>   				ks->netdev->stats.rx_packets++;
>>   				ks->netdev->stats.rx_bytes += rxlen;
>> @@ -325,11 +325,15 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
>>    */
>>   static irqreturn_t ks8851_irq(int irq, void *_ks)
>>   {
>> +	bool need_bh_off = !(hardirq_count() | softirq_count());
> IMO, in_task() macro would be better.

I don't think in_task() is exactly identical to !(hardirq_count() | 
softirq_count()) according to include/linux/preempt.h , it also takes 
NMI into consideration. I am not sure if that could pose a problem or not ?

This test here has been taken from net/core/dev.c netif_rx() , it is the 
same one used there around __netif_rx() invocation.

>>   	struct ks8851_net *ks = _ks;
>>   	unsigned handled = 0;
>>   	unsigned long flags;
>>   	unsigned int status;
>>
>> +	if (need_bh_off)
>> +		local_bh_disable();
> This threaded irq's thread function (ks8851_irq()) will always run in process context, right ?

I think so.

> Do you need "if(need_bh_off)" loop?

It is not a loop, it is invoked once. It is here to disable BHs so that 
the net_rx_action BH wouldn't run until after the spinlock protected 
section of the IRQ handler. Te net_rx_action may end up calling 
ks8851_start_xmit_par, which must be called with the spinlock released, 
otherwise the system would lock up.

