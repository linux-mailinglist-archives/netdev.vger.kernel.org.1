Return-Path: <netdev+bounces-211666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2060B1B106
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 11:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0603BB92B
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 09:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC4225D209;
	Tue,  5 Aug 2025 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BhMFZqAz"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB8251799
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386138; cv=none; b=OSiMl3lIVrueM2Nzceux5WGROUDAIkjwGGsqrGEk06wi5vVu+FUOHUP6w4HtCZdJ99tVVOtqxHH+kVG7wCsPeBCc2ezCQuPhi68JVPCNxVNTTIcBYsiRzrcvjOB7afKpkyv4ktd7+bC5bR/VF8vFKeRv4f36/HWMS78VpSEDykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386138; c=relaxed/simple;
	bh=+/ONE53PJr4Zv3a/0yB3dh+z8LBg5nSOorrUvdMvcoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUx258J5RfNzAZzfv4pnTJq4LWPWpacBvN2aSKvk32OQfkkWPRnSJvZy0vSBW6Coz82poqBfH/udI/I4uwh8yOUxMTSUFkb9O3v3EQV93mH3Ut+u2AQ5+6LImmuSokt/GZ5uCQ2bWGVbDgPaIG8Ti7pf18SzWFe/zy2d3nBuEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BhMFZqAz; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e85af6d4-45f9-4011-a6e4-f06aa6662dad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754386134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMeyoPAhWUvFydE5qvLWxr4Zd9OGViAzNZI+UazFToM=;
	b=BhMFZqAz0VDYI+3Pk73GSDzeLrMFq/cm4Y9balxjRDtYgt78/PBY0IVb03XxT3D5rDTzpk
	KK3T5mDjdU1XFViuCtL2T50SBw9Jg5wxm6SigiFsgO7ney4I41Tc2Y1AC+Q9vWNAOJDSbW
	dhPH7S8JEKREG/qNLKNZTd5gVHNcUwM=
Date: Tue, 5 Aug 2025 10:28:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v3] ethtool: add FEC bins histogramm report
To: Carolina Jubran <cjubran@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20250802063024.2423022-1-vadfed@meta.com>
 <d3bb8295-bb4f-4817-a2dd-017332c489d4@nvidia.com>
 <25ab441c-84e8-4c47-8d13-1b88d78ed4c6@linux.dev>
 <e55b8200-1fed-410c-a5b8-e37cad5d84b0@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <e55b8200-1fed-410c-a5b8-e37cad5d84b0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 05/08/2025 10:03, Carolina Jubran wrote:
> 
> 
> On 04/08/2025 11:31, Vadim Fedorenko wrote:
>> On 03/08/2025 12:24, Carolina Jubran wrote:
>>>
>>>
>>> On 02/08/2025 9:30, Vadim Fedorenko wrote:
>>>> diff --git a/Documentation/networking/ethtool-netlink.rst b/ 
>>>> Documentation/networking/ethtool-netlink.rst
>>>> index ab20c644af248..b270886c5f5d5 100644
>>>> --- a/Documentation/networking/ethtool-netlink.rst
>>>> +++ b/Documentation/networking/ethtool-netlink.rst
>>>> @@ -1541,6 +1541,11 @@ Drivers fill in the statistics in the 
>>>> following structure:
>>>>   .. kernel-doc:: include/linux/ethtool.h
>>>>       :identifiers: ethtool_fec_stats
>>>> +Statistics may have FEC bins histogram attribute 
>>>> ``ETHTOOL_A_FEC_STAT_HIST``
>>>> +as defined in IEEE 802.3ck-2022 and 802.3df-2024. Nested attributes 
>>>> will have
>>>> +the range of FEC errors in the bin (inclusive) and the amount of 
>>>> error events
>>>> +in the bin.
>>>> +
>>>
>>> Maybe worth mentioning per-lane histograms here.
>>
>> Yep, will do it
>>
>>>
>>>>   FEC_SET
>>>>   =======
>>>> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/ 
>>>> netdevsim/ ethtool.c
>>>> index f631d90c428ac..1dc9a6c126b24 100644
>>>> --- a/drivers/net/netdevsim/ethtool.c
>>>> +++ b/drivers/net/netdevsim/ethtool.c
>>>> @@ -164,12 +164,29 @@ nsim_set_fecparam(struct net_device *dev, 
>>>> struct ethtool_fecparam *fecparam)
>>>>       ns->ethtool.fec.active_fec = 1 << (fls(fec) - 1);
>>>>       return 0;
>>>>   }
>>>> +static const struct ethtool_fec_hist_range netdevsim_fec_ranges[] = {
>>>> +    { 0, 0},
>>>> +    { 1, 3},
>>>> +    { 4, 7},
>>>> +    { 0, 0}
>>>> +};
>>>>
>>>
>>> Following up on the discussion from v1, I agree with Gal's concern 
>>> about pushing array management into the driver. It adds complexity 
>>> especially when ranges depend on FEC mode.
>>
>> Still don't really get the reason. You have finite amount of FEC bin
>> configurations, per hardware per FEC type, you know current FEC type
>> value and can choose static range based on this knowledge. Why do you
>> want to query device over PCIe multiple times to figure out the same
>> configuration every time?
>>
> 
> That’s true, we have known FEC modes, but we don’t always know the 
> actual bin layout, it can vary per device. So the driver still needs to 
> query the device to get the correct ranges, even if the FEC type is fixed.

Correct me if I'm wrong, but I believe it's not per device but rather
per device generation. Cutting out old devices which don't support
reporting FEC histogram at all, and CX7 and CX8 supporting bins layout
as per standard, I would say there are 4 different variants, plus
RS(272, 257) for Infiniband. Not much to make it constant and avoid any
allocations and memory management, and keep maintenance easy for both
parties...

On the other side, if you want to dynamically fill in this data, it will
take proper amount of requests over PCIe: 1 (the amount of bins) + 2 *
16 (low and high boundary per bin for RS(544,514)) + 2 * 16 (64 bits
value per bin) = 65. In case of continues monitoring may be potentially
disruptive for high speed low latency traffic, but I believe we can
avoid at least half of these transactions.

>>>
>>> The approach Andrew suggested makes sense to me. A simple helper to 
>>> add a bin would support both static and dynamic cases.
>>>
>>>>   static void
>>>> -nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats 
>>>> *fec_stats)
>>>> +nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats 
>>>> *fec_stats,
>>>> +           const struct ethtool_fec_hist_range **ranges)
>>>>   {
>>>> +    *ranges = netdevsim_fec_ranges;
>>>> +
>>>>       fec_stats->corrected_blocks.total = 123;
>>>>       fec_stats->uncorrectable_blocks.total = 4;
>>>> +
>>>> +    fec_stats->hist[0].bin_value = 345;
>>>
>>> bin_value is 345 but the per-lane sum is 445.
>>
>> ahh.. yeah, will fix it
>>
>>>> +    fec_stats->hist[1].bin_value = 12;
>>>> +    fec_stats->hist[2].bin_value = 2;
>>>> +    fec_stats->hist[0].bin_value_per_lane[0] = 125;
>>>> +    fec_stats->hist[0].bin_value_per_lane[1] = 120;
>>>> +    fec_stats->hist[0].bin_value_per_lane[2] = 100;
>>>> +    fec_stats->hist[0].bin_value_per_lane[3] = 100;
>>>>   }
>>>> +static int fec_put_hist(struct sk_buff *skb, const struct 
>>>> fec_stat_hist *hist,
>>>> +            const struct ethtool_fec_hist_range *ranges)
>>>> +{
>>>> +    struct nlattr *nest;
>>>> +    int i, j;
>>>> +
>>>> +    if (!ranges)
>>>> +        return 0;
>>>> +
>>>> +    for (i = 0; i < ETHTOOL_FEC_HIST_MAX; i++) {
>>>> +        if (i && !ranges[i].low && !ranges[i].high)
>>>> +            break;
>>>> +
>>>> +        nest = nla_nest_start(skb, ETHTOOL_A_FEC_STAT_HIST);
>>>> +        if (!nest)
>>>> +            return -EMSGSIZE;
>>>> +
>>>> +        if (nla_put_u32(skb, ETHTOOL_A_FEC_HIST_BIN_LOW,
>>>> +                 ranges[i].low) ||
>>>> +            nla_put_u32(skb, ETHTOOL_A_FEC_HIST_BIN_HIGH,
>>>> +                 ranges[i].high) ||
>>>> +            nla_put_uint(skb, ETHTOOL_A_FEC_HIST_BIN_VAL,
>>>> +                     hist[i].bin_value))
>>>
>>> Should skip bins where hist[i].bin_value isn’t set.
>>
>> I'm kinda disagree. If the bin is configured, then the HW must provide a
>> value for it. Otherwise we will have inconsistency in user's output.
>>
>> I was thinking of adding WARN_ON_ONCE() for such cases actually.
>>
> I see your point, yeah I’m good with the WARN_ON_ONCE()
> 
>>>
>>>
>>> Thanks,
>>> Carolina
>>
> 


