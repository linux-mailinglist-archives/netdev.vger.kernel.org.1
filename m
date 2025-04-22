Return-Path: <netdev+bounces-184486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A716A95C23
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 04:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7885A3A95FA
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 02:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B11519DF4D;
	Tue, 22 Apr 2025 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V8eB9Lvf"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1AE16F288
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288990; cv=none; b=rEuP8OZgDPhWW4A41FfdyJ8sgTtp3Fk4GJrWRXMbq30cJz5TMjMuLnevwsm3shov/E/HKYfFT6yJtfTnQIxco6aHRqEtqORmokqQmADp2+KPx6ioOSSEslH8d4/S/j3u5CE9LYGEMGpW3uaV/DKDIzNnbtWXWGB8ctWW+elHdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288990; c=relaxed/simple;
	bh=tVa7GIhpI0NwTOHCDlMqhyckvtYinVRvJ22Q+x1zBS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2XToGeVlky8ym4SNX8wPrJxUdr+kKbB2z7/Z6ZVVRW7IJqVHMy1XKb9I/Jrn5eYeOwb8nYGnvQALxHuaOQSbZqTUaDdU8MFOq7DBx5GrSK6o3TwcJdk+4Zi/3mKgVor4zkbxq2diPGE8ObCspphgNwufvJ1h/z6hnbScaC+h7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V8eB9Lvf; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <99ae096a-e14f-44bc-a520-a3198e7c0671@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745288983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ua+k9/MdgJ0TKCXUAuG1GGWStOBoaKgVe0E5C+mR/mY=;
	b=V8eB9Lvf/fZU07PBzUN6ggY+QD0SgC8dL+LlvrnCYwIkEKYk5UMllS3MUXpAOEa6Z17Bjh
	CN4cxxDyjf3tROqqduPs6IsUx0SwcA7KpXsVR6/4HsBLePStarr7x41FYq4Zk0i2qmvWZx
	aRqqM4vMyMTk2OkXcyJiFEZFeZL0roE=
Date: Tue, 22 Apr 2025 10:29:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next V2 2/3] net: stmmac: dwmac-loongson: Add new
 multi-chan IP core support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Feiyang Chen <chris.chenfeiyang@gmail.com>,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Henry Chen <chenx97@aosc.io>, Biao Dong <dongbiao@loongson.cn>,
 Baoqi Zhang <zhangbaoqi@loongson.cn>
References: <20250416144132.3857990-1-chenhuacai@loongson.cn>
 <20250416144132.3857990-3-chenhuacai@loongson.cn>
 <fe0a5e7a-6bb2-45ef-8172-c06684885b36@linux.dev>
 <CAAhV-H5ELoqM8n5A-DD7LOzjb2mkRDR+pM-CAOcfGwZYcVQQ-A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <CAAhV-H5ELoqM8n5A-DD7LOzjb2mkRDR+pM-CAOcfGwZYcVQQ-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 4/21/25 12:20 PM, Huacai Chen 写道:
> Hi, Yanteng,
>
> On Mon, Apr 21, 2025 at 10:04 AM Yanteng Si <si.yanteng@linux.dev> wrote:
>>
>> 在 4/16/25 10:41 PM, Huacai Chen 写道:
>>> Add a new multi-chan IP core (0x12) support which is used in Loongson-
>>> 2K3000/Loongson-3B6000M. Compared with the 0x10 core, the new 0x12 core
>>> reduces channel numbers from 8 to 4, but checksum is supported for all
>>> channels.
>>>
>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>>> Tested-by: Henry Chen <chenx97@aosc.io>
>>> Tested-by: Biao Dong <dongbiao@loongson.cn>
>>> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>> ---
>>>    .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 62 +++++++++++--------
>>>    1 file changed, 37 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>> index 2fb7a137b312..57917f26ab4d 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>>> @@ -68,10 +68,11 @@
>>>
>>>    #define PCI_DEVICE_ID_LOONGSON_GMAC 0x7a03
>>>    #define PCI_DEVICE_ID_LOONGSON_GNET 0x7a13
>>> -#define DWMAC_CORE_LS_MULTICHAN      0x10    /* Loongson custom ID */
>>> -#define CHANNEL_NUM                  8
>>> +#define DWMAC_CORE_MULTICHAN_V1      0x10    /* Loongson custom ID 0x10 */
>>> +#define DWMAC_CORE_MULTICHAN_V2      0x12    /* Loongson custom ID 0x12 */
>>>
>>>    struct loongson_data {
>>> +     u32 multichan;
>> In order to make the logic clearer, I suggest splitting this patch.：
>>
>>
>> 2/4  Add multichan for loongson_data
>>
>> 3/4 Add new multi-chan IP core support
> I don't think the patch is unclear now, the multichan flag is really a
> combination of DWMAC_CORE_MULTICHAN_V1 and DWMAC_CORE_MULTICHAN_V2.
OK, please describe this code modification in the commit message.
>
>>
>>>        u32 loongson_id;
>>>        struct device *dev;
>>>    };
>>> @@ -119,18 +120,29 @@ static void loongson_default_data(struct pci_dev *pdev,
>>>        plat->dma_cfg->pbl = 32;
>>>        plat->dma_cfg->pblx8 = true;
>>>
>>> -     if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
>>> -             plat->rx_queues_to_use = CHANNEL_NUM;
>>> -             plat->tx_queues_to_use = CHANNEL_NUM;
>>> +     switch (ld->loongson_id) {
>>> +     case DWMAC_CORE_MULTICHAN_V1:
>> How about adding some comments? For example:
>>
>> case DWMAC_CORE_MULTICHAN_V1:   /* 2K2000 */
>> case DWMAC_CORE_MULTICHAN_V2:   /* 2K3000 and 3B6000M */
> Do you know why we deprecate PRID (a.k.a SOC name) detection and
> prefer CPUCFG detection in cpu_probe()? Because SOC-types and function
> features are orthogonal, they should not be strictly bound. There will
> be other SOCs using MULTICHAN_V1 or MULTICHAN_V2, should we update the
> comments every time when a new SOC publishes? There may also be one
> SOC with different IP-cores, then how to comment on this case?

In my opinion, having something is better than having nothing.

I've come up with a way to address your concerns:


case DWMAC_CORE_MULTICHAN_V1:   /* 2K2000 ... */
case DWMAC_CORE_MULTICHAN_V2:   /* 2K3000, 3B6000M ...*/


These limited comments are very friendly to developers outside

Loongson Company. Of course, I don't want to discuss this matter

any further. If you don't want to add code comments, I won't object

to this patch because of that.

>
>> ...
>>
>>> +             ld->multichan = 1;
>>> +             plat->rx_queues_to_use = 8;
>>> +             plat->tx_queues_to_use = 8;
>>>
>>>                /* Only channel 0 supports checksum,
>>>                 * so turn off checksum to enable multiple channels.
>>>                 */
>>> -             for (int i = 1; i < CHANNEL_NUM; i++)
>>> +             for (int i = 1; i < 8; i++)
>>>                        plat->tx_queues_cfg[i].coe_unsupported = 1;
>>> -     } else {
>>> +
>>> +             break;
>>> +     case DWMAC_CORE_MULTICHAN_V2:
>>> +             ld->multichan = 1;
>>> +             plat->rx_queues_to_use = 4;
>>> +             plat->tx_queues_to_use = 4;
>>> +             break;
>>> +     default:
>>> +             ld->multichan = 0;
>>>                plat->tx_queues_to_use = 1;
>>>                plat->rx_queues_to_use = 1;
>>> +             break;
>>>        }
>>>    }
>>>
>>> @@ -328,14 +340,14 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
>>>                return NULL;
>>>
>>>        /* The Loongson GMAC and GNET devices are based on the DW GMAC
>>> -      * v3.50a and v3.73a IP-cores. But the HW designers have changed the
>>> -      * GMAC_VERSION.SNPSVER field to the custom 0x10 value on the
>>> -      * network controllers with the multi-channels feature
>>> +      * v3.50a and v3.73a IP-cores. But the HW designers have changed
>>> +      * the GMAC_VERSION.SNPSVER field to the custom 0x10/0x12 value
>>> +      * on the network controllers with the multi-channels feature
>>>         * available to emphasize the differences: multiple DMA-channels,
>>>         * AV feature and GMAC_INT_STATUS CSR flags layout. Get back the
>>>         * original value so the correct HW-interface would be selected.
>>>         */
>>> -     if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
>>> +     if (ld->multichan) {
>>>                priv->synopsys_id = DWMAC_CORE_3_70;
>>>                *dma = dwmac1000_dma_ops;
>>>                dma->init_chan = loongson_dwmac_dma_init_channel;
>>> @@ -356,13 +368,13 @@ static struct mac_device_info *loongson_dwmac_setup(void *apriv)
>>>        if (mac->multicast_filter_bins)
>>>                mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
>>>
>>> -     /* Loongson GMAC doesn't support the flow control. LS2K2000
>>> -      * GNET doesn't support the half-duplex link mode.
>>> +     /* Loongson GMAC doesn't support the flow control. Loongson GNET
>>> +      * without multi-channel doesn't support the half-duplex link mode.
>>>         */
>>>        if (pdev->device == PCI_DEVICE_ID_LOONGSON_GMAC) {
>>>                mac->link.caps = MAC_10 | MAC_100 | MAC_1000;
>>>        } else {
>>> -             if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
>>> +             if (ld->multichan)
>>>                        mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
>>>                                         MAC_10 | MAC_100 | MAC_1000;
>>>                else
>>> @@ -391,9 +403,11 @@ static int loongson_dwmac_msi_config(struct pci_dev *pdev,
>>>                                     struct plat_stmmacenet_data *plat,
>>>                                     struct stmmac_resources *res)
>>>    {
>>> -     int i, ret, vecs;
>>> +     int i, ch_num, ret, vecs;
>>>
>>> -     vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
>>> +     ch_num = min(plat->tx_queues_to_use, plat->rx_queues_to_use);
>> I'm curious. Will there still be hardware with RX not equal to TX in the
>> future?
> Currently rx queue number is equal to tx queue number, but
> min(plat->tx_queues_to_use, plat->rx_queues_to_use) is still the best
> solution. If not, which one should be used here? tx_queues_to_use or
> rx_queues_to_use?

All right.


Thanks,

Yanteng

>
> Huacai
>
>>
>> Thanks,
>>
>> Yanteng
>>
>>

