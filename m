Return-Path: <netdev+bounces-103731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4720190938B
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380FF1C21253
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E41C14534B;
	Fri, 14 Jun 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fq43c13W"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5E143C7A
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718398461; cv=none; b=LNmZF9KH71/awarqGUU/t30gqNlh8VhMUk+qsSK6xotmzTaD6suYgVWCQZnfjXzntLy3GESPZNYCJDd2wQc+rRirFemvpQ2iXqbRmRRu+TmIqo++xlI9LsawYQv62HsGen6jxNGXhXHu+RktvNvUpEHBAO5udCS/dz+nAfkAGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718398461; c=relaxed/simple;
	bh=5tFnLSP33aYSES0MD32VcfyfckmdVgkIQ7KT4ZPO6QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifU4opdaVmQsweQxNqYjdBKvug20QBJBASYi7a+dJZ6RKdL81GBo1Q1Su43bJTdgKMepahv32H+cmoPtd+jK7DCwSIodSXShqwO7CuowUHFo6KJrQ5ULXf/MKfHf6TsB8dx8VTSyTF8jokCKLrPoYYJWdq44i3bBRIif3jNPhs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fq43c13W; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: horms@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718398457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+Snf0whftzfpHgqudrfGK4VVlgcRO8EISXLh2sXflY=;
	b=Fq43c13WJaFpPaFsTzFOH0sjUUwEp7vNoWiYtvMmNX7gB8YQRYxqQjqH+ck51zL4x8uC4s
	cFPbkJcKNS/Cglkq+EJcwITZL9gZY4g0uKV8/DnFvSuqTWO7FjxrkB41kDE6pW1w554mSn
	TZlA3LKhvrg3FZneLZ//nIHMAPI5BC8=
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
Message-ID: <b06f648c-927e-4eee-9934-e549fbd3c3b9@linux.dev>
Date: Fri, 14 Jun 2024 16:54:12 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/3] net: xilinx: axienet: Add statistics support
To: Simon Horman <horms@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
 <20240610231022.2460953-4-sean.anderson@linux.dev>
 <20240614163050.GV8447@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240614163050.GV8447@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/14/24 12:30, Simon Horman wrote:
> On Mon, Jun 10, 2024 at 07:10:22PM -0400, Sean Anderson wrote:
>> Add support for reading the statistics counters, if they are enabled.
>> The counters may be 64-bit, but we can't detect this as there's no
>> ability bit for it and the counters are read-only. Therefore, we assume
>> the counters are 32-bits. To ensure we don't miss an overflow, we need
>> to read all counters at regular intervals, configurable with
>> stats-block-usecs. This should be often enough to ensure the bytes
>> counters don't wrap at 2.5 Gbit/s.
>> 
>> Another complication is that the counters may be reset when the device
>> is reset (depending on configuration). To ensure the counters persist
>> across link up/down (including suspend/resume), we maintain our own
>> 64-bit versions along with the last counter value we saw. Because we
>> might wait up to 100 ms for the reset to complete, we use a mutex to
>> protect writing hw_stats. We can't sleep in ndo_get_stats64, so we use a
>> u64_stats_sync to protect readers.
>> 
>> We can't use the byte counters for either get_stats64 or
>> get_eth_mac_stats. This is because the byte counters include everything
>> in the frame (destination address to FCS, inclusive). But
>> rtnl_link_stats64 wants bytes excluding the FCS, and
>> ethtool_eth_mac_stats wants to exclude the L2 overhead (addresses and
>> length/type).
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |  81 ++++++
>>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 267 +++++++++++++++++-
>>  2 files changed, 345 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> 
> ...
> 
>> @@ -434,6 +502,11 @@ struct skbuf_dma_descriptor {
>>   * @tx_packets: TX packet count for statistics
>>   * @tx_bytes:	TX byte count for statistics
>>   * @tx_stat_sync: Synchronization object for TX stats
>> + * @hw_last_counter: Last-seen value of each statistic
>> + * @hw_stats: Interface statistics periodically updated from hardware counters
>> + * @hw_stats_sync: Synchronization object for @hw_stats
> 
> nit: s/hw_stats_sync/hw_stat_sync/
> 
>      Flagged by kernel-doc -none

I think I will rename the member instead.

--Sean

>> + * @stats_lock: Lock for writing @hw_stats and @hw_last_counter
>> + * @stats_work: Work for reading the hardware statistics counters
>>   * @dma_err_task: Work structure to process Axi DMA errors
>>   * @tx_irq:	Axidma TX IRQ number
>>   * @rx_irq:	Axidma RX IRQ number
>> @@ -452,6 +525,7 @@ struct skbuf_dma_descriptor {
>>   * @coalesce_usec_rx:	IRQ coalesce delay for RX
>>   * @coalesce_count_tx:	Store the irq coalesce on TX side.
>>   * @coalesce_usec_tx:	IRQ coalesce delay for TX
>> + * @coalesce_usec_stats: Delay between hardware statistics refreshes
>>   * @use_dmaengine: flag to check dmaengine framework usage.
>>   * @tx_chan:	TX DMA channel.
>>   * @rx_chan:	RX DMA channel.
>> @@ -505,6 +579,12 @@ struct axienet_local {
>>  	u64_stats_t tx_bytes;
>>  	struct u64_stats_sync tx_stat_sync;
>>  
>> +	u32 hw_last_counter[STAT_COUNT];
>> +	u64_stats_t hw_stats[STAT_COUNT];
>> +	struct u64_stats_sync hw_stat_sync;
>> +	struct mutex stats_lock;
>> +	struct delayed_work stats_work;
>> +
>>  	struct work_struct dma_err_task;
>>  
>>  	int tx_irq;
> 
> ...


