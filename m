Return-Path: <netdev+bounces-214723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90462B2B094
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7017A6841E4
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398724503F;
	Mon, 18 Aug 2025 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gEO4tuua"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0279223DEE
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542208; cv=none; b=by0YKtckrNtFPpEzbaPNv18tcEgr/K2rmxvx7QHmLHSSBiQBKqIAnVntzZnRMFvQEmumSnQfuh24awfjdYh90VB3qdnIA3CQBfZBTu71Xz1X3FiHDHTKT6EjZi7XZMiubbls5wXxAlf2RDZyoZVXwLYRMyM2/M3amxOArB5+Rtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542208; c=relaxed/simple;
	bh=VFTAGHUcOhCsVCHbgqwMOmNRPxnfj8LmI2zeZpIYYZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZn84IgIRPE4B12N8Q1aRBAki+wkIbOZ2bl+kiKsrbA3o4pGQOk0GUqev8cUWzu8jeCA8p/zozM13ITH6wTIInqgqEAj4uLWHAS9dBrlii74EDNLNFK+i13fIBBRnlzabGlarYFVBRAhm4xkR1aR39Muv6dO+VYsPpegJN5Ncxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gEO4tuua; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cab8df87-46fc-49f4-be1d-a55585587e61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755542204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEleciuqCzDP1u7gctFkcDKDnO/+TN1KeFYy+R1jcs0=;
	b=gEO4tuua+R3qWKY7ae9B34t7MxPPMhZhAhTH88tS8smrXk0vsQoY18b7cdkNGb7wp5ywpu
	2ijpvi/fRAFYTVHfQWmNV8+5fo9gDY8h8EYE5KqqCf0X/fzenRAdz5YSYOOr50s1qSh449
	18YHT00stMsUcbE8itf5NUgvjm1SD68=
Date: Mon, 18 Aug 2025 19:35:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v5] ethtool: add FEC bins histogramm report
To: Carolina Jubran <cjubran@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20250815132729.2251597-1-vadfed@meta.com>
 <5b8da3d8-f24c-43d8-9d82-0bcc257e1dac@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <5b8da3d8-f24c-43d8-9d82-0bcc257e1dac@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 18/08/2025 19:17, Carolina Jubran wrote:
> 
> 
> On 15/08/2025 16:27, Vadim Fedorenko wrote:
>> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>> index de5bd76a400ca..6c0dc6ae080a8 100644
>> --- a/include/linux/ethtool.h
>> +++ b/include/linux/ethtool.h
>> @@ -492,7 +492,25 @@ struct ethtool_pause_stats {
>>   };
>>   #define ETHTOOL_MAX_LANES    8
>> +#define ETHTOOL_FEC_HIST_MAX    18
> 
> Could you clarify why it is set to 18?
> AFAIU IEEE 802.3ck/df define 16 bins.

Yeah, the standard defines 16 bins, but this value came out of the
discussion with Gal and Yael because the hardware supports more bins,
I believe, in RDMA mode

>> diff --git a/net/ethtool/fec.c b/net/ethtool/fec.c
>> index e7d3f2c352a34..9313bd17544fd 100644
>> --- a/net/ethtool/fec.c
>> +++ b/net/ethtool/fec.c
>> @@ -17,6 +17,7 @@ struct fec_reply_data {
>>           u64 stats[1 + ETHTOOL_MAX_LANES];
>>           u8 cnt;
>>       } corr, uncorr, corr_bits;
>> +    struct ethtool_fec_hist fec_stat_hist;
>>   };
>>   #define FEC_REPDATA(__reply_base) \
>> @@ -113,7 +114,11 @@ static int fec_prepare_data(const struct 
>> ethnl_req_info *req_base,
>>           struct ethtool_fec_stats stats;
>>           ethtool_stats_init((u64 *)&stats, sizeof(stats) / 8);
>> -        dev->ethtool_ops->get_fec_stats(dev, &stats);
>> +        ethtool_stats_init((u64 *)data->fec_stat_hist.values,
>> +                   ETHTOOL_MAX_LANES *
> this should be ETHTOOL_FEC_HIST_MAX since we’re initializing the 
> histogram bins array.

Yes, you're right, I'll change it in the next version

