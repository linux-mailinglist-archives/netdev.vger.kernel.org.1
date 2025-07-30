Return-Path: <netdev+bounces-210939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A3B15B8B
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 11:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE683A46D3
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1526B26657B;
	Wed, 30 Jul 2025 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bElHQAse"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C291D5AC6
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867785; cv=none; b=tOLAloeJwE+3ZBrYmKhUxfvysV/SF+5nDjdRfDDzaYV90slhfv5kh8hif5nAMV/+eBUbUHJeK3bPZDc+j8+0c7y6HwIEYJH8cMbjI3htRjJCTtBypnqscCRpmzM6SelzqdE3kncvOcT4wlqWPGohB/Ef4a4jbi439jKxt0Bq9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867785; c=relaxed/simple;
	bh=eYbnbxfhSQjTG6RGXyGTFiVIs8ijvvlopHiyQelYQbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZoQ5kG/XT+9NDphjHWJyWXbfxdgc0bRgWiZHmLxoACUiDcZRyEkysjeNmfTX9kxmg690MtK30ZF7k8v1rrr61BGRDFCn1fxSyfOzF8h147gQTOGbZcOkndNwQ3HUTJHnoeLHm4gB6yy+mvPBtVytHtjbrbgyKvUfiFexUQVBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bElHQAse; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1129bf26-273e-4685-a0b8-ed8b0e4050f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753867780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJCqdhtK2SorWbMtjErohNTMQWfsrZacHp0nri4+we0=;
	b=bElHQAseWsAYxartJ9Bb5DqQfTt3dZ+c5O6H8Un/zpFTp3jnVAjbHmjjkIBRzETx/P9KIk
	53wUbZZJR809ObhBXSbRhUYxAg3Epg0etCe9F1mpV0fvQLNfsaZ+ynp3rzVB3/sQQLL3CV
	ull0jro3jMEeSbgRx9cxA5AI5xYyItc=
Date: Wed, 30 Jul 2025 10:29:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
To: Gal Pressman <gal@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 intel-wired-lan@lists.osuosl.org, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20250729102354.771859-1-vadfed@meta.com>
 <041f79a2-5f96-4427-b0e2-6a159fbec84a@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <041f79a2-5f96-4427-b0e2-6a159fbec84a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/07/2025 06:54, Gal Pressman wrote:
> On 29/07/2025 13:23, Vadim Fedorenko wrote:
>> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
>> index f631d90c428ac..7257de9ea2f44 100644
>> --- a/drivers/net/netdevsim/ethtool.c
>> +++ b/drivers/net/netdevsim/ethtool.c
>> @@ -164,12 +164,25 @@ nsim_set_fecparam(struct net_device *dev, struct ethtool_fecparam *fecparam)
>>   	ns->ethtool.fec.active_fec = 1 << (fls(fec) - 1);
>>   	return 0;
>>   }
>> +static const struct ethtool_fec_hist_range netdevsim_fec_ranges[] = {
>> +	{  0,  0},
>> +	{  1,  3},
>> +	{  4,  7},
>> +	{ -1, -1}
>> +};
> 
> The driver-facing API works nicely when the ranges are allocated as
> static arrays, but I expect most drivers will need to allocate it
> dynamically as the ranges will be queried from the device.
> In that case, we need to define who is responsible of freeing the ranges
> array.

Well, the ranges will not change during link operation, unless the type
of FEC is changed. You may either have static array of FEC ranges per
supported FEC types. Or query it on link-up event and reuse it on every
call for FEC stats. In this case it's pure driver's responsibility to
manage memory allocations. There is definitely no need to re-query
ranges on every single call for stats.

> 
>>   
>>   static void
>> -nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats)
>> +nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats,
>> +		   const struct ethtool_fec_hist_range **ranges)
>>   {
>> +	*ranges = netdevsim_fec_ranges;
>> +
>>   	fec_stats->corrected_blocks.total = 123;
>>   	fec_stats->uncorrectable_blocks.total = 4;
>> +
>> +	fec_stats->hist[0] = 345;
>> +	fec_stats->hist[1] = 12;
>> +	fec_stats->hist[2] = 2;
>>   }
>>   
>>   static int nsim_get_ts_info(struct net_device *dev,
>> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>> index de5bd76a400ca..9421a5e31af21 100644
>> --- a/include/linux/ethtool.h
>> +++ b/include/linux/ethtool.h
>> @@ -492,6 +492,17 @@ struct ethtool_pause_stats {
>>   };
>>   
>>   #define ETHTOOL_MAX_LANES	8
>> +#define ETHTOOL_FEC_HIST_MAX	18
> 
> I suspect we might need to increase this value in the future, so I like
> the fact that it's not hardcoded anywhere in the uapi.

Yep, that's the plan

