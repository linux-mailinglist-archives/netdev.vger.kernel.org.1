Return-Path: <netdev+bounces-158838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5012FA13742
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A215167BAA
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F0D1DDC29;
	Thu, 16 Jan 2025 10:02:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA331D79B3;
	Thu, 16 Jan 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021732; cv=none; b=WKL3icijNHzj6bXtaQZ4845E+pq7+vliI0/+k43uGVopEsvymyYJtw7JgYlK6o58Ly50Xd3O8gcO9TG3CkE8VtMXQ8H7k5zDlwUKWRpAkkaIt6FzwoIq1Apcvz5yw6O8FUbXoBUo5HqiL5B76fasZy0oHsKdWUz/wuVMi6tZ3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021732; c=relaxed/simple;
	bh=1h8m6ntPXPlwARbPTa8i3ayWHYBbGQZnsWOOkMW3KI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlxWvO/qX1tj0AlWH9mCqgbJegGZaiAhtNn012QyTk3/eM2OeHBqm4B3xoefyAbISWhKBfSeyIwjHwvAH546P5P7f6yyFUPZ7POaknkKmBXOmHExE7SPd8kaE85AzT/B7FLXhsXouesZXe4jvma0YN+NeH5cRHdHpfT5OGCnTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 16 Jan 2025 19:02:09 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id DC6F22006E93;
	Thu, 16 Jan 2025 19:02:09 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Thu, 16 Jan 2025 19:02:09 +0900
Received: from [10.212.247.91] (unknown [10.212.247.91])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id E56A21A8;
	Thu, 16 Jan 2025 19:02:08 +0900 (JST)
Message-ID: <2d88c997-f417-4fd0-a871-a9af4a28213e@socionext.com>
Date: Thu, 16 Jan 2025 19:02:08 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: stmmac: Limit the number of MTL queues to
 maximum value
To: Furong Xu <0x1207@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250116020853.2835521-1-hayashi.kunihiko@socionext.com>
 <20250116020853.2835521-2-hayashi.kunihiko@socionext.com>
 <20250116112814.00005bef@gmail.com>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20250116112814.00005bef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Furong,

Thank you for your comment.

On 2025/01/16 12:28, Furong Xu wrote:
> On Thu, 16 Jan 2025 11:08:53 +0900, Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
> 
>> The number of MTL queues to use is specified by the parameter
>> "snps,{tx,rx}-queues-to-use" from the platform layer.
>>
>> However, the maximum number of queues is determined by
>> the macro MTL_MAX_{TX,RX}_QUEUES. It's appropriate to limit the
>> values not to exceed the upper limit values.
>>
> 
> The Fixes: tag is required too.

I see. I'll find it.

>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> index ad868e8d195d..471eb1a99d90 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> @@ -165,6 +165,8 @@ static int stmmac_mtl_setup(struct platform_device
> *pdev,
>>   	if (of_property_read_u32(rx_node, "snps,rx-queues-to-use",
>>   				 &plat->rx_queues_to_use))
>>   		plat->rx_queues_to_use = 1;
>> +	if (plat->rx_queues_to_use > MTL_MAX_RX_QUEUES)
>> +		plat->rx_queues_to_use = MTL_MAX_RX_QUEUES;
> 
> MTL_MAX_RX_QUEUES, MTL_MAX_TX_QUEUES and STMMAC_CH_MAX are defined to 8,
> this is correct for gmac4, but xgmac has 16 channels at most.

Yes, but these macros are used as the number of elements in some arrays.
(used in common.h and stmmac.h)

We can change these value to the maximum (16), though, the size of some
structures will increase so be careful.

> Drop these legacy defines and always use
> priv->dma_cap.number_rx_queues,
> priv->dma_cap.number_tx_queues,
> priv->dma_cap.number_tx_channel,
> priv->dma_cap.number_rx_channel,
> seems like a good option.

These values can be obtained in stmmac_dvr_probe() and this patch checks
the queue sizes before stmmac_dvr_probe(). I think we need to change the
way how to check them.

And when checking only with dma_cap values, the number of elements in 
the arrays might be exceeded.  It is necessary to take care of both the
arrays and the capabilities.

Thank you,

---
Best Regards
Kunihiko Hayashi

