Return-Path: <netdev+bounces-124583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD3A96A0E5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F891C2363E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5E113D28C;
	Tue,  3 Sep 2024 14:42:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9D13D278;
	Tue,  3 Sep 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374524; cv=none; b=lrg1rS9lizCbSXxf0rLIIkkO1a50YaEwruGl68tQhkhC65rFffHdQOtMaHfHFlEFmsJZ/ZriJUKhHvWgLrMa7S20AQj+KOCR4iupzRJ0aKVc4gt9mpYiz2WCef4WAOhFAM6PhKAFuC8RKhjnciocbucrYxvARALRglJOGagkLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374524; c=relaxed/simple;
	bh=HHs8jW5i+MFVV9WvFuQXQ+AAl3XL0OqfehWw3PVFi6A=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ebw9KM47PTZOrWFgrck23iM0E6FBpVmeFEI87TNFsUlC/DcqRyHyYlnTXk89Z3DOTRmrUbSeNHnyYG9cwItoETJ6IaRA2wSlvJIopSKebyuuMCUcbgoT6JVM7DKQX7U9WpQ0jY/jRCzAIntyYix2vT8cQROnPDqpT/PSR1NQVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WypG72V4lzyR2M;
	Tue,  3 Sep 2024 22:41:03 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id E24A518010A;
	Tue,  3 Sep 2024 22:41:59 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 22:41:58 +0800
Message-ID: <55fbd21f-ac81-465f-b164-7e5b6c0ca7d9@huawei.com>
Date: Tue, 3 Sep 2024 22:41:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <andrew@lunn.ch>, <jdamato@fastly.com>,
	<horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 06/11] net: hibmcge: Implement .ndo_start_xmit
 function
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>
References: <20240830121604.2250904-1-shaojijie@huawei.com>
 <20240830121604.2250904-7-shaojijie@huawei.com>
 <2bc090db-7bc1-4810-80c7-61218fb49acf@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <2bc090db-7bc1-4810-80c7-61218fb49acf@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/3 21:31, Paolo Abeni wrote:
> On 8/30/24 14:15, Jijie Shao wrote:
>> +netdev_tx_t hbg_net_start_xmit(struct sk_buff *skb, struct 
>> net_device *net_dev)
>> +{
>> +    struct hbg_ring *ring = netdev_get_tx_ring(net_dev);
>> +    struct hbg_priv *priv = netdev_priv(net_dev);
>> +    /* This smp_load_acquire() pairs with smp_store_release() in
>> +     * hbg_tx_buffer_recycle() called in tx interrupt handle process.
>> +     */
>> +    u32 ntc = smp_load_acquire(&ring->ntc);
>> +    struct hbg_buffer *buffer;
>> +    struct hbg_tx_desc tx_desc;
>> +    u32 ntu = ring->ntu;
>> +
>> +    if (unlikely(!hbg_nic_is_open(priv))) {
>> +        dev_kfree_skb_any(skb);
>> +        return NETDEV_TX_OK;
>> +    }
>> +
>> +    if (unlikely(!skb->len ||
>> +             skb->len > hbg_spec_max_frame_len(priv, HBG_DIR_TX))) {
>> +        dev_kfree_skb_any(skb);
>> +        net_dev->stats.tx_errors++;
>> +        return NETDEV_TX_OK;
>> +    }
>> +
>> +    if (unlikely(hbg_queue_is_full(ntc, ntu, ring) ||
>> +             hbg_fifo_is_full(ring->priv, ring->dir))) {
>> +        netif_stop_queue(net_dev);
>> +        return NETDEV_TX_BUSY;
>> +    }
>> +
>> +    buffer = &ring->queue[ntu];
>> +    buffer->skb = skb;
>> +    buffer->skb_len = skb->len;
>> +    if (unlikely(hbg_dma_map(buffer))) {
>> +        dev_kfree_skb_any(skb);
>> +        return NETDEV_TX_OK;
>> +    }
>> +
>> +    buffer->state = HBG_TX_STATE_START;
>> +    hbg_init_tx_desc(buffer, &tx_desc);
>> +    hbg_hw_set_tx_desc(priv, &tx_desc);
>> +
>> +    /* This smp_store_release() pairs with smp_load_acquire() in
>> +     * hbg_tx_buffer_recycle() called in tx interrupt handle process.
>> +     */
>> +    smp_store_release(&ring->ntu, hbg_queue_next_prt(ntu, ring));
>
> Here you should probably check for netif_txq_maybe_stop()
>
>> +    net_dev->stats.tx_bytes += skb->len;
>> +    net_dev->stats.tx_packets++;
>
> Try to avoid 'dev->stats' usage. Instead you could use per napi stats 
> accounting (no contention).

use dev_sw_netstats_tx_add() or dev_sw_netstats_rx_add() ?

>
> Side note: 'net_dev' is quite an unusual variable name for a network 
> device.

sure, 'dev' is ok.
	
	Thanks,
	Jijie Shao


