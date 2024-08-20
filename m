Return-Path: <netdev+bounces-120209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAAC95892B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913862817AD
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604F318CBEF;
	Tue, 20 Aug 2024 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fcPsNSae"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB143AB2
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163825; cv=none; b=cyA+lGnyzwerAjJXggdPzaKFFNslgzsDzMTup32eMsDjBk/U5gh9FvnkzwAebl0DrtuQTBcHubNlQ5ZSRTlc3jKLxeN63DHQcRa22hSipUIgtKcyVe77dIOGCpdGdTCnhMa5gKxQSE+02j/9A455mQoiIL2DHqOjCm9zbklCs+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163825; c=relaxed/simple;
	bh=hPd9fYHBNkbPi75u84mOzLhYWbnYUaXvTRVn1M+juJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlsRDDY8sAsETjpm+mtzkoWe3p11Q4qh/mFJ8EnhtSjbyPQi+9q5mTlLwVrcl3h3WJJMrEKxImohGMyktgv8N2GM9OcJbbENriX86GGvqoMQS1iyjaHlseJ5V+AktUlgYYbXedzQnmBRZ/erxm9yAaoziaukQUU+qsIWfvHGmWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fcPsNSae; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fcafcd35-3b31-4628-9035-cb7a90002436@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724163820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlpXumW/D2LzI+LmmZMRvU4lnk1mv1sVLr5hJmtZOYY=;
	b=fcPsNSaetSByD7w9IshUUakw4G2fY5I/kN/wHVwP1S9mVDNNt/AQFIm/UIWDoN/CdgAJgX
	LLCribyCnMuCxw6eB4JP4wjxA/dzjPJMK+/i3X90suxzJlpdhKi4xQqGwxnX1SHm8cFo1D
	J2xDR1J0hPfuVthwd7fyYSfGVFQN5RA=
Date: Tue, 20 Aug 2024 10:23:35 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 2/2] net: xilinx: axienet: Add statistics
 support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240815144031.4079048-1-sean.anderson@linux.dev>
 <20240815144031.4079048-3-sean.anderson@linux.dev>
 <20240816194203.05753edf@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240816194203.05753edf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/16/24 22:42, Jakub Kicinski wrote:
> On Thu, 15 Aug 2024 10:40:31 -0400 Sean Anderson wrote:
>> +	u64 hw_stat_base[STAT_COUNT];
>> +	u64 hw_last_counter[STAT_COUNT];
> 
> I think hw_last_counter has to be u32..
> 
>> +	seqcount_mutex_t hw_stats_seqcount;
>> +	struct mutex stats_lock;
>> +	struct delayed_work stats_work;
>> +	bool reset_in_progress;
>> +
>>  	struct work_struct dma_err_task;
>>  
>>  	int tx_irq;
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index b2d7c396e2e3..9353a4f0ab1b 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -519,11 +519,55 @@ static void axienet_setoptions(struct net_device *ndev, u32 options)
>>  	lp->options |= options;
>>  }
>>  
>> +static u64 axienet_stat(struct axienet_local *lp, enum temac_stat stat)
>> +{
>> +	u32 counter;
>> +
>> +	if (lp->reset_in_progress)
>> +		return lp->hw_stat_base[stat];
>> +
>> +	counter = axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
>> +	return lp->hw_stat_base[stat] + (counter - lp->hw_last_counter[stat]);
> 
> .. or you need to cast the (counter - lp->...) result to u32.
> Otherwise counter's type is getting bumped to 64 and you're just doing
> 64b math here.

Yes, good catch. I think I changed the type while refactoring and forgot about it.

I think I'll expose the byte counters for the next revision to make it
easier to test rollover. I tried testing the packet counters overnight,
but I'm using a trial license for these devices at the moment and it
expired before the counters rolled over.

--Sean

>> +}
>> +
>> +static void axienet_stats_update(struct axienet_local *lp, bool reset)
>> +{
>> +	enum temac_stat stat;
>> +
>> +	write_seqcount_begin(&lp->hw_stats_seqcount);
>> +	lp->reset_in_progress = reset;
>> +	for (stat = 0; stat < STAT_COUNT; stat++) {
>> +		u32 counter = axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
>> +
>> +		lp->hw_stat_base[stat] += counter - lp->hw_last_counter[stat];
>> +		lp->hw_last_counter[stat] = counter;
>> +	}
>> +	write_seqcount_end(&lp->hw_stats_seqcount);

