Return-Path: <netdev+bounces-211508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8F3B19DA2
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B67A1899360
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25ED1E9B22;
	Mon,  4 Aug 2025 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R50X5kuG"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF47464
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296274; cv=none; b=rDbkPfgKNZlZquZPY3mz5HUr6WG2ZOoGcXIp3jLDYoO/B5XS6bXuUVgRe61Iru7eU46+T43/dG//LwTCtiQYvOOmxV9AR4VI6HTasRvPABgSrCJW2O8LDCfDj+1359Ufnxc70k9V3ZJps/Wb2X2T6MHoBzI+YZfMuAxDTD7TMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296274; c=relaxed/simple;
	bh=9DFp/0jr/e7vUq6dRZ77yWCCQzvP340j2crT/rQHRZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqdPwEsle48eA5RypkLFmOPIk5t+T5vIahGxQFp1Jf8RDAt6Dl9Ujy6IjVQ8J/hsHe0jmZaavvewlbhlVkLXtoTObRjMdc9Gxfxcf6K1LAWclaj9difb1Ted2ws0uWtKsMLzHY6Y6N9wBQQ4vgkKKqX4Ar9uaR6LkxQ7Ry6fEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R50X5kuG; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25ab441c-84e8-4c47-8d13-1b88d78ed4c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754296268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9PJ+Y/FavZJigOXqRIX0OeIMJyTMBv2omxY9KJvj0U=;
	b=R50X5kuGKjYp8qQpUrcVmTeswuDJ/HwZE/GbXV7UnKUelw67QrMJcvTx0IEzxoIgV6coe8
	97mY769V3GlPA+zqo4ukoPaOmw/ejOpzoqgUnR2sev5ACGJtPYdVTD2EnIohsAsviXjRmQ
	9tiplz8S1ByYG194vsz/tjNEExzmqPc=
Date: Mon, 4 Aug 2025 09:31:06 +0100
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <d3bb8295-bb4f-4817-a2dd-017332c489d4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 03/08/2025 12:24, Carolina Jubran wrote:
> 
> 
> On 02/08/2025 9:30, Vadim Fedorenko wrote:
>> diff --git a/Documentation/networking/ethtool-netlink.rst b/ 
>> Documentation/networking/ethtool-netlink.rst
>> index ab20c644af248..b270886c5f5d5 100644
>> --- a/Documentation/networking/ethtool-netlink.rst
>> +++ b/Documentation/networking/ethtool-netlink.rst
>> @@ -1541,6 +1541,11 @@ Drivers fill in the statistics in the following 
>> structure:
>>   .. kernel-doc:: include/linux/ethtool.h
>>       :identifiers: ethtool_fec_stats
>> +Statistics may have FEC bins histogram attribute 
>> ``ETHTOOL_A_FEC_STAT_HIST``
>> +as defined in IEEE 802.3ck-2022 and 802.3df-2024. Nested attributes 
>> will have
>> +the range of FEC errors in the bin (inclusive) and the amount of 
>> error events
>> +in the bin.
>> +
> 
> Maybe worth mentioning per-lane histograms here.

Yep, will do it

> 
>>   FEC_SET
>>   =======
>> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ 
>> ethtool.c
>> index f631d90c428ac..1dc9a6c126b24 100644
>> --- a/drivers/net/netdevsim/ethtool.c
>> +++ b/drivers/net/netdevsim/ethtool.c
>> @@ -164,12 +164,29 @@ nsim_set_fecparam(struct net_device *dev, struct 
>> ethtool_fecparam *fecparam)
>>       ns->ethtool.fec.active_fec = 1 << (fls(fec) - 1);
>>       return 0;
>>   }
>> +static const struct ethtool_fec_hist_range netdevsim_fec_ranges[] = {
>> +    { 0, 0},
>> +    { 1, 3},
>> +    { 4, 7},
>> +    { 0, 0}
>> +};
>>
> 
> Following up on the discussion from v1, I agree with Gal's concern about 
> pushing array management into the driver. It adds complexity especially 
> when ranges depend on FEC mode.

Still don't really get the reason. You have finite amount of FEC bin
configurations, per hardware per FEC type, you know current FEC type
value and can choose static range based on this knowledge. Why do you
want to query device over PCIe multiple times to figure out the same
configuration every time?

> 
> The approach Andrew suggested makes sense to me. A simple helper to add 
> a bin would support both static and dynamic cases.
> 
>>   static void
>> -nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats 
>> *fec_stats)
>> +nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats 
>> *fec_stats,
>> +           const struct ethtool_fec_hist_range **ranges)
>>   {
>> +    *ranges = netdevsim_fec_ranges;
>> +
>>       fec_stats->corrected_blocks.total = 123;
>>       fec_stats->uncorrectable_blocks.total = 4;
>> +
>> +    fec_stats->hist[0].bin_value = 345;
> 
> bin_value is 345 but the per-lane sum is 445.

ahh.. yeah, will fix it

>> +    fec_stats->hist[1].bin_value = 12;
>> +    fec_stats->hist[2].bin_value = 2;
>> +    fec_stats->hist[0].bin_value_per_lane[0] = 125;
>> +    fec_stats->hist[0].bin_value_per_lane[1] = 120;
>> +    fec_stats->hist[0].bin_value_per_lane[2] = 100;
>> +    fec_stats->hist[0].bin_value_per_lane[3] = 100;
>>   }
>> +static int fec_put_hist(struct sk_buff *skb, const struct 
>> fec_stat_hist *hist,
>> +            const struct ethtool_fec_hist_range *ranges)
>> +{
>> +    struct nlattr *nest;
>> +    int i, j;
>> +
>> +    if (!ranges)
>> +        return 0;
>> +
>> +    for (i = 0; i < ETHTOOL_FEC_HIST_MAX; i++) {
>> +        if (i && !ranges[i].low && !ranges[i].high)
>> +            break;
>> +
>> +        nest = nla_nest_start(skb, ETHTOOL_A_FEC_STAT_HIST);
>> +        if (!nest)
>> +            return -EMSGSIZE;
>> +
>> +        if (nla_put_u32(skb, ETHTOOL_A_FEC_HIST_BIN_LOW,
>> +                 ranges[i].low) ||
>> +            nla_put_u32(skb, ETHTOOL_A_FEC_HIST_BIN_HIGH,
>> +                 ranges[i].high) ||
>> +            nla_put_uint(skb, ETHTOOL_A_FEC_HIST_BIN_VAL,
>> +                     hist[i].bin_value))
> 
> Should skip bins where hist[i].bin_value isn’t set.

I'm kinda disagree. If the bin is configured, then the HW must provide a
value for it. Otherwise we will have inconsistency in user's output.

I was thinking of adding WARN_ON_ONCE() for such cases actually.

> 
> 
> Thanks,
> Carolina


