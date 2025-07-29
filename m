Return-Path: <netdev+bounces-210847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9B2B15178
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72A5543C64
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07284226D0D;
	Tue, 29 Jul 2025 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P6awYfcR"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B11DF723
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807016; cv=none; b=f7IRqBIfGGp3thuCHs+B2mqvmsQyRXzGPFbcC7c4hRCVjhY7ALUhZG/pD/kRX2bEZeu9lGXu6nK6dWOg+0aUjihE5Yj9uRNTSwzqlrWTXvXDJXhbr9lwOlVPIrHpbBAXCQz5WqKS00lalET4A8c3VIwrcMHUYCiw/Ekl/yEqJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807016; c=relaxed/simple;
	bh=q06V0kZ4Yoa9cvvyVsO+FMgC9HltJEYnWDZq9+jaNpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8xxWoA3miG3uRSaeZDrN75//tKf+PmL92yNlG1BjtXbPJGiv5AHMnSxsEI5eugEOLGRpeqkOiHb9IRerfe9BNsi35Q7IikzwH1u1RFe9nwxUoB0q7QpJ03jOmMUsvr7LjSI1xGMqxhZ7cL0jw0bdj3VIsywTRj4N9Gd+FTl27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P6awYfcR; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4270ff14-06cd-4a78-afe7-1aa5f254ebb6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753807012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o303TqQc5L2rVYjS38dlYBq8enUZvggK8JI5fHePlJ8=;
	b=P6awYfcR4aMNob0r3w1sSfBidQnFh1M1cE0n7rVxx34iBwyxs+rDGu4r0pkv86S65Pk/PJ
	AK33N6+wsbqBwvlUIX3ZpuZPvfz4uAYtE7170lDdUw0+rvVlAhE1yA6ojar9GTaaaVwvQi
	+HhViOT2yNqdrEjPsC6mRX992Wp2l58=
Date: Tue, 29 Jul 2025 17:36:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20250729102354.771859-1-vadfed@meta.com>
 <982c780a-1ff1-4d79-9104-c61605c7e802@lunn.ch>
 <1a7f0aa0-47ae-4936-9e55-576cdf71f4cc@linux.dev>
 <9c1c8db9-b283-4097-bb3f-db4a295de2a5@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <9c1c8db9-b283-4097-bb3f-db4a295de2a5@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/07/2025 17:17, Andrew Lunn wrote:
> On Tue, Jul 29, 2025 at 05:01:06PM +0100, Vadim Fedorenko wrote:
>> On 29/07/2025 14:48, Andrew Lunn wrote:
>>>> +        name: fec-hist-bin-low
>>>> +        type: s32
>>>
>>> Signed 32 bit
>>>
>>>> +struct ethtool_fec_hist_range {
>>>> +	s16 low;
>>>
>>> Signed 16 bit.
>>>
>>>> +		if (nla_put_u32(skb, ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_LOW,
>>>> +				ranges[i].low) ||
>>>
>>> Unsigned 32 bit.
>>>
>>> Could we have some consistency with the types.
>>
>> Yeah, it looks a bit messy. AFAIK, any type of integer less than 32 bits
>> will be extended to 32 bits anyway,
> 
> sign extended, not just extended. That makes things more fun.
> 
>> so I believe it's ok to keep smaller
>> memory footprint
> 
>   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c
>   .../ethernet/fungible/funeth/funeth_ethtool.c
>   .../ethernet/hisilicon/hns3/hns3_ethtool.c
>   drivers/net/ethernet/intel/ice/ice_ethtool.c
>   .../marvell/octeontx2/nic/otx2_ethtool.c
>   .../ethernet/mellanox/mlx5/core/en_ethtool.c
>   drivers/net/ethernet/sfc/ethtool.c
>   drivers/net/ethernet/sfc/siena/ethtool.c
> 
> These are all huge drivers, with extensive memory footprint.  How many
> bins are we talking about? 5? One per PCS? I suspect the size
> difference it deep in the noise.

Well, it's currently up to 18 according to different possible FEC algos,
but I agree, it's not that much.

> 
>> for the histogram definition in the driver but still use
>> s32 as netlink attr type. I'll change the code to use nla_put_s32()
>> to keep sign info.
> 
> So bins can have negative low/high values?

The only one bin will have negative value is the one to signal the end
of the list of the bins, which is not actually put into netlink message.
It actually better to change spec to have unsigned values, I believe.

> 
> 	Andrew


