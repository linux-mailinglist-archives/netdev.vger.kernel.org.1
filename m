Return-Path: <netdev+bounces-220403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575FFB45D01
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607C77C7215
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B5C31D742;
	Fri,  5 Sep 2025 15:46:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821ED31D746;
	Fri,  5 Sep 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087168; cv=none; b=l5IhRk+MPpUkUWf+CgkEutaAw9LHYJnr+SXgAjzY6BAAF+qHNXJSkiyQLzCEa3e9Vc9/SA+GOIgCve57zcHHbjTyk5L56YW6cGuT5ks8tcOEDRI+fUSSlAwcpdK8VdoCBni+THJQmoTVQ0qmnnrSZpHskuICR9T/f792cGlukL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087168; c=relaxed/simple;
	bh=OKhzNW9ZD2RgTy4457MbKDaoTUd9Wh+DG8e3zQRGXwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7LPeZV/tvrPO7YnVmvbHY19Ti86okmIdLbHKka6Ftpb0kl/+2qvNYSZMQmTec3tfVkeiwRHwZSzGoZ5OxBouxkCxd8oh/t4aooy4gOFL3QrdD8PfMveWvFCZkUNsWWS2TG/g6lHtEMfzn0RdyKam8ygE0cMA8FicmHGFWVxkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.106] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowAAnd4GZBbtosNvWAA--.30834S2;
	Fri, 05 Sep 2025 23:45:29 +0800 (CST)
Message-ID: <0605f176-5cdb-4f5b-9a6b-afa139c96732@iscas.ac.cn>
Date: Fri, 5 Sep 2025 23:45:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/5] net: spacemit: Add K1 Ethernet MAC
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, Vivian Wang <uwu@dram.page>
References: <20250905-net-k1-emac-v9-0-f1649b98a19c@iscas.ac.cn>
 <20250905-net-k1-emac-v9-2-f1649b98a19c@iscas.ac.cn>
 <20250905153500.GH553991@horms.kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250905153500.GH553991@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowAAnd4GZBbtosNvWAA--.30834S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8tw4rWFykAF18GFy7trb_yoW7JrWrpa
	y5ta1DCF1UXF4jgrnaqF4UZFn3t3WfJr1UuFyYyrWF9FnFyrs7KFy8Kr17K34xCFW8uF4Y
	9w1j9347GFZ8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUvaZXDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Simon,

Thanks for the review.

(I have a question about the use of ndev->stats - see below.)

On 9/5/25 23:35, Simon Horman wrote:
> On Fri, Sep 05, 2025 at 07:09:31PM +0800, Vivian Wang wrote:
>> The Ethernet MACs found on SpacemiT K1 appears to be a custom design
>> that only superficially resembles some other embedded MACs. SpacemiT
>> refers to them as "EMAC", so let's just call the driver "k1_emac".
>>
>> Supports RGMII and RMII interfaces. Includes support for MAC hardware
>> statistics counters. PTP support is not implemented.
>>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>> Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> Tested-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ...
>
>> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
> ...
>
>> +static void emac_init_hw(struct emac_priv *priv)
>> +{
>> +	/* Destination address for 802.3x Ethernet flow control */
>> +	u8 fc_dest_addr[ETH_ALEN] = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x01 };
>> +
>> +	u32 rxirq = 0, dma = 0;
>> +
>> +	regmap_set_bits(priv->regmap_apmu,
>> +			priv->regmap_apmu_offset + APMU_EMAC_CTRL_REG,
>> +			AXI_SINGLE_ID);
>> +
>> +	/* Disable transmit and receive units */
>> +	emac_wr(priv, MAC_RECEIVE_CONTROL, 0x0);
>> +	emac_wr(priv, MAC_TRANSMIT_CONTROL, 0x0);
>> +
>> +	/* Enable MAC address 1 filtering */
>> +	emac_wr(priv, MAC_ADDRESS_CONTROL, MREGBIT_MAC_ADDRESS1_ENABLE);
>> +
>> +	/* Zero initialize the multicast hash table */
>> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE1, 0x0);
>> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE2, 0x0);
>> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE3, 0x0);
>> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE4, 0x0);
>> +
>> +	/* Configure thresholds */
>> +	emac_wr(priv, MAC_TRANSMIT_FIFO_ALMOST_FULL, DEFAULT_TX_ALMOST_FULL);
>> +	emac_wr(priv, MAC_TRANSMIT_PACKET_START_THRESHOLD,
>> +		DEFAULT_TX_THRESHOLD);
>> +	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
>> +
>> +	/* Configure flow control (enabled in emac_adjust_link() later) */
>> +	emac_set_mac_addr_reg(priv, fc_dest_addr, MAC_FC_SOURCE_ADDRESS_HIGH);
>> +	emac_wr(priv, MAC_FC_PAUSE_HIGH_THRESHOLD, DEFAULT_FC_FIFO_HIGH);
>> +	emac_wr(priv, MAC_FC_HIGH_PAUSE_TIME, DEFAULT_FC_PAUSE_TIME);
>> +	emac_wr(priv, MAC_FC_PAUSE_LOW_THRESHOLD, 0);
>> +
>> +	/* RX IRQ mitigation */
>> +	rxirq = EMAC_RX_FRAMES & MREGBIT_RECEIVE_IRQ_FRAME_COUNTER_MASK;
>> +	rxirq |= (EMAC_RX_COAL_TIMEOUT
>> +		  << MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_SHIFT) &
>> +		 MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_MASK;
> Probably this driver can benefit from using FIELD_PREP and FIELD_GET
> in a number of places. In this case I think it would mean that
> MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_SHIFT can be removed entirely.

That looks useful. There's a few more uses of *_SHIFT in this driver,
and I think I can get them all to use FIELD_PREP. I'll change those in
the next version.

>> +
>> +	rxirq |= MREGBIT_RECEIVE_IRQ_MITIGATION_ENABLE;
>> +	emac_wr(priv, DMA_RECEIVE_IRQ_MITIGATION_CTRL, rxirq);
> ...
>
>> +/* Returns number of packets received */
>> +static int emac_rx_clean_desc(struct emac_priv *priv, int budget)
>> +{
>> +	struct net_device *ndev = priv->ndev;
>> +	struct emac_rx_desc_buffer *rx_buf;
>> +	struct emac_desc_ring *rx_ring;
>> +	struct sk_buff *skb = NULL;
>> +	struct emac_desc *rx_desc;
>> +	u32 got = 0, skb_len, i;
>> +	int status;
>> +
>> +	rx_ring = &priv->rx_ring;
>> +
>> +	i = rx_ring->tail;
>> +
>> +	while (budget--) {
>> +		rx_desc = &((struct emac_desc *)rx_ring->desc_addr)[i];
>> +
>> +		/* Stop checking if rx_desc still owned by DMA */
>> +		if (READ_ONCE(rx_desc->desc0) & RX_DESC_0_OWN)
>> +			break;
>> +
>> +		dma_rmb();
>> +
>> +		rx_buf = &rx_ring->rx_desc_buf[i];
>> +
>> +		if (!rx_buf->skb)
>> +			break;
>> +
>> +		got++;
>> +
>> +		dma_unmap_single(&priv->pdev->dev, rx_buf->dma_addr,
>> +				 rx_buf->dma_len, DMA_FROM_DEVICE);
>> +
>> +		status = emac_rx_frame_status(priv, rx_desc);
>> +		if (unlikely(status == RX_FRAME_DISCARD)) {
>> +			ndev->stats.rx_dropped++;
> As per the comment in struct net-device,
> ndev->stats should not be used in modern drivers.
>
> Probably you want to implement NETDEV_PCPU_STAT_TSTATS.
>
> Sorry for not mentioning this in an earlier review of
> stats in this driver.
>
On a closer look, these counters in ndev->stats seems to be redundant
with the hardware-tracked statistics, so maybe I should just not bother
with updating ndev->stats. Does that make sense?

Thanks,
Vivian "dramforever" Wang


