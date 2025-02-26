Return-Path: <netdev+bounces-169772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203A7A45A73
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427433A8627
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B246226D19;
	Wed, 26 Feb 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="kKAH78Bo"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-32.ptr.blmpb.com (va-2-32.ptr.blmpb.com [209.127.231.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186C1E1E18
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562882; cv=none; b=aTQdlT7E71/7ybSqHKEwvWRS30m1BUxO5w7lZnYHi9Fma/ti3lTGfht7Gq9XXxXG9LzgmV20Tt4zXekG40uM3QmC7HVKbFd+7CWGGGfN428b7TM7TsPlqG6GqSGwE5GV26jGW08oBdT1OURhARfKBnVoUFl8Q6wX8e0pvzESul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562882; c=relaxed/simple;
	bh=5gc0n57jTYWn+NpTqq3lzWiMFrggLEupU1eo0wxQ6IE=;
	h=From:Content-Type:References:Subject:Date:Mime-Version:To:
	 Message-Id:In-Reply-To; b=HWOQh5qk+UIqcmgrpMKdQjCrV66F2Pov56DkuE1P0Csj03RD/w3zX6fQMW1F6YIiN0neCkuyj4MVgRbA6Bw2ZySAVvQ8XAbx7/0i/gont2WBo1HMcVt8/ZXeZ+FqbiFIHFQ9ctV5GROwVkpCngb4nX5zH/0BItWbea/5PB0dphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=kKAH78Bo; arc=none smtp.client-ip=209.127.231.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740562727; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=QjQtG4tEcN/1h/qT+hx7qn9RFrfVcbqiSYHU/0cpuFo=;
 b=kKAH78Bo6HsCyq3Zaokl/EV9LNVxbW0NGsM4mw2ez4Xb6nbK8Hd+q7ZaX61ghYgpfkr3vy
 ZbnQTqbTSQPcdfQMVg5GmRXovg4G7Z59pu4svYwPSez9VbxqGjnckvzrmGPX4aEvIy2mbC
 /kf8uI/1Q83SsYiAzkQao/v3o3zQFC2UNOmVVb/WHcPqZfrDNx3Gh9QcSWINAyGnz2BVQ7
 piaspvLsOtzWIks6w2zlMqP/3iwnspWW1YOtTlbnlgyA7EMaPoNfe9ivLjIG0rck6liK7p
 obKRrgU+61s8RSld8SNwThHp3lxtXP/N0lzEsqAf7q1I3KVOrq4WjgXTnDJwCQ==
From: "Xin Tian" <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
References: <20250224172416.2455751-1-tianx@yunsilicon.com> <20250224172443.2455751-14-tianx@yunsilicon.com> <Z706ULnEoemYWdvQ@LQ3V64L9R2>
Subject: Re: [PATCH net-next v5 13/14] xsc: Add eth reception data path
Date: Wed, 26 Feb 2025 17:38:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+267bee125+7bd1a3+vger.kernel.org+tianx@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Wed, 26 Feb 2025 17:38:44 +0800
User-Agent: Mozilla Thunderbird
To: "Joe Damato" <jdamato@fastly.com>, <netdev@vger.kernel.org>, 
	<leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
Message-Id: <10fb2bc9-758f-4788-978a-819608688dac@yunsilicon.com>
In-Reply-To: <Z706ULnEoemYWdvQ@LQ3V64L9R2>

On 2025/2/25 11:34, Joe Damato wrote:
> On Tue, Feb 25, 2025 at 01:24:44AM +0800, Xin Tian wrote:
>> rx data path:
> [...]
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
>> index 72f33bb53..b87105c26 100644
>> --- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
>> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
>> @@ -5,44 +5,594 @@
> [...]
>
>>   struct sk_buff *xsc_skb_from_cqe_linear(struct xsc_rq *rq,
>>   					struct xsc_wqe_frag_info *wi,
>>   					u32 cqe_bcnt, u8 has_pph)
>>   {
>> -	// TBD
>> -	return NULL;
>> +	int pph_len = has_pph ? XSC_PPH_HEAD_LEN : 0;
>> +	u16 rx_headroom = rq->buff.headroom;
>> +	struct xsc_dma_info *di = wi->di;
>> +	struct sk_buff *skb;
>> +	void *va, *data;
>> +	u32 frag_size;
>> +
>> +	va = page_address(di->page) + wi->offset;
>> +	data = va + rx_headroom + pph_len;
>> +	frag_size = XSC_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
>> +
>> +	dma_sync_single_range_for_cpu(rq->cq.xdev->device, di->addr, wi->offset,
>> +				      frag_size, DMA_FROM_DEVICE);
>> +	prefetchw(va); /* xdp_frame data area */
>> +	prefetch(data);
> net_prefetchw and net_prefetch, possibly?
>
> [...]
>
>>   struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
>>   					   struct xsc_wqe_frag_info *wi,
>>   					   u32 cqe_bcnt, u8 has_pph)
>>   {
>> -	// TBD
>> -	return NULL;
>> +	struct xsc_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
>> +	u16 headlen  = min_t(u32, XSC_RX_MAX_HEAD, cqe_bcnt);
>> +	struct xsc_wqe_frag_info *head_wi = wi;
>> +	struct xsc_wqe_frag_info *rx_wi = wi;
>> +	u16 head_offset = head_wi->offset;
>> +	u16 byte_cnt = cqe_bcnt - headlen;
>> +	u16 frag_consumed_bytes = 0;
>> +	u16 frag_headlen = headlen;
>> +	struct net_device *netdev;
>> +	struct xsc_channel *c;
>> +	struct sk_buff *skb;
>> +	struct device *dev;
>> +	u8 fragcnt = 0;
>> +	int i = 0;
>> +
>> +	c = rq->cq.channel;
>> +	dev = c->adapter->dev;
>> +	netdev = c->adapter->netdev;
>> +
>> +	skb = napi_alloc_skb(rq->cq.napi, ALIGN(XSC_RX_MAX_HEAD, sizeof(long)));
>> +	if (unlikely(!skb))
>> +		return NULL;
>> +
>> +	prefetchw(skb->data);
> Same as above: net_prefetchw ?
Sure, I'll update

