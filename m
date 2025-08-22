Return-Path: <netdev+bounces-216028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3B7B319A0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B05B582740
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EDC2FF17D;
	Fri, 22 Aug 2025 13:27:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9942FE586;
	Fri, 22 Aug 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869270; cv=none; b=mq1PzxIp62g7DMFjfoMzFByWI6l5NItt+FN8UMusF2IZZveF3Wsve3kUpb8GGBBxVIv0x93vJiJE7aA+D5nb4dPnNcraqSMQ3qmwo7OWRNOEagvHOCrvN4sGaLMq6gExQlKeVLDoSUIkVuUg7DsVKyF5R0wPg7ctZpvAq1a9B1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869270; c=relaxed/simple;
	bh=CvQW0D4khBGNDHhog9aZU9HwDtvPDlg7O4IlJEZ4bfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKQmOtD6vg5vYrJ+oiAjkdNF3ecnd3CLJZTTD3B4iaCh2CRvSL/gdIXXsSMfITQH+5P7rTK4g9CuEjOcgXZKP3M1FetRvpwqRGIYT53gSub3P3r6ojIXkhaVbKtwd5So67yHsrwBKjLIYUPlJVfbhtn7um30IRg6kXUDXFyVwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.105] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowADnQIIncKhoqZtfDg--.14333S2;
	Fri, 22 Aug 2025 21:27:04 +0800 (CST)
Message-ID: <50926ebd-f8c0-485b-87cd-f7552df4bcd4@iscas.ac.cn>
Date: Fri, 22 Aug 2025 21:27:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/5] net: spacemit: Add K1 Ethernet MAC
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Vivian Wang <uwu@dram.page>
References: <20250820-net-k1-emac-v6-0-c1e28f2b8be5@iscas.ac.cn>
 <20250820-net-k1-emac-v6-2-c1e28f2b8be5@iscas.ac.cn>
 <20250821161420.7c9804f7@kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250821161420.7c9804f7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowADnQIIncKhoqZtfDg--.14333S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy3XFyxKFyDAr15urW3ZFb_yoW7ArW8pF
	W8Wa1DAF48Xrn7Cr47Xr4UAFnFvr1xXw15u3WYyaya9F9IkrySgryrKrWak34rCr909r1F
	vr4jv343WFn5KrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07bIBTOUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Jakub,

Thank you for the comments.

On 8/22/25 07:14, Jakub Kicinski wrote:
> On Wed, 20 Aug 2025 14:47:51 +0800 Vivian Wang wrote:
>> +static void emac_tx_mem_map(struct emac_priv *priv, struct sk_buff *skb)
>> +{
>> +	struct emac_desc_ring *tx_ring = &priv->tx_ring;
>> +	struct emac_desc tx_desc, *tx_desc_addr;
>> +	struct device *dev = &priv->pdev->dev;
>> +	struct emac_tx_desc_buffer *tx_buf;
>> +	u32 head, old_head, frag_num, f;
>> +	bool buf_idx;
>> +
>> +	frag_num = skb_shinfo(skb)->nr_frags;
>> +	head = tx_ring->head;
>> +	old_head = head;
>> +
>> +	for (f = 0; f < frag_num + 1; f++) {
>> +		buf_idx = f % 2;
>> +
>> +		/*
>> +		 * If using buffer 1, initialize a new desc. Otherwise, use
>> +		 * buffer 2 of previous fragment's desc.
>> +		 */
>> +		if (!buf_idx) {
>> +			tx_buf = &tx_ring->tx_desc_buf[head];
>> +			tx_desc_addr =
>> +				&((struct emac_desc *)tx_ring->desc_addr)[head];
>> +			memset(&tx_desc, 0, sizeof(tx_desc));
>> +
>> +			/*
>> +			 * Give ownership for all but first desc initially. For
>> +			 * first desc, give at the end so DMA cannot start
>> +			 * reading uninitialized descs.
>> +			 */
>> +			if (head != old_head)
>> +				tx_desc.desc0 |= TX_DESC_0_OWN;
>> +
>> +			if (++head == tx_ring->total_cnt) {
>> +				/* Just used last desc in ring */
>> +				tx_desc.desc1 |= TX_DESC_1_END_RING;
>> +				head = 0;
>> +			}
>> +		}
>> +
>> +		if (emac_tx_map_frag(dev, &tx_desc, tx_buf, skb, f)) {
>> +			netdev_err(priv->ndev, "Map TX frag %d failed", f);
>> +			goto dma_map_err;
>> +		}
>> +
>> +		if (f == 0)
>> +			tx_desc.desc1 |= TX_DESC_1_FIRST_SEGMENT;
>> +
>> +		if (f == frag_num) {
>> +			tx_desc.desc1 |= TX_DESC_1_LAST_SEGMENT;
>> +			tx_buf->skb = skb;
>> +			if (emac_tx_should_interrupt(priv, frag_num + 1))
>> +				tx_desc.desc1 |=
>> +					TX_DESC_1_INTERRUPT_ON_COMPLETION;
>> +		}
>> +
>> +		*tx_desc_addr = tx_desc;
>> +	}
>> +
>> +	/* All descriptors are ready, give ownership for first desc */
>> +	tx_desc_addr = &((struct emac_desc *)tx_ring->desc_addr)[old_head];
>> +	dma_wmb();
>> +	WRITE_ONCE(tx_desc_addr->desc0, tx_desc_addr->desc0 | TX_DESC_0_OWN);
>> +
>> +	emac_dma_start_transmit(priv);
>> +
>> +	tx_ring->head = head;
>> +
>> +	return;
>> +
>> +dma_map_err:
>> +	dev_kfree_skb_any(skb);
> You free the skb here.. 
>
>> +	priv->ndev->stats.tx_dropped++;
>> +}
>> +
>> +static netdev_tx_t emac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>> +{
>> +	struct emac_priv *priv = netdev_priv(ndev);
>> +	int nfrags = skb_shinfo(skb)->nr_frags;
>> +	struct device *dev = &priv->pdev->dev;
>> +
>> +	if (unlikely(emac_tx_avail(priv) < nfrags + 1)) {
>> +		if (!netif_queue_stopped(ndev)) {
>> +			netif_stop_queue(ndev);
>> +			dev_err_ratelimited(dev, "TX ring full, stop TX queue\n");
>> +		}
>> +		return NETDEV_TX_BUSY;
>> +	}
>> +
>> +	emac_tx_mem_map(priv, skb);
>> +
>> +	ndev->stats.tx_packets++;
>> +	ndev->stats.tx_bytes += skb->len;
> .. and then you use skb here.
>
>> +	/* Make sure there is space in the ring for the next TX. */
>> +	if (unlikely(emac_tx_avail(priv) <= MAX_SKB_FRAGS + 2))
>> +		netif_stop_queue(ndev);
>> +
>> +	return NETDEV_TX_OK;
>> +}

Thanks for the catch. I'll fix the error handling here in the next version.

>> +static void emac_get_ethtool_stats(struct net_device *dev,
>> +				   struct ethtool_stats *stats, u64 *data)
>> +{
>> +	struct emac_priv *priv = netdev_priv(dev);
>> +	u64 *rx_stats = (u64 *)&priv->rx_stats;
>> +	int i;
>> +
>> +	scoped_guard(spinlock_irqsave, &priv->stats_lock) {
> Why is this spin lock taken in irqsave mode?
> Please convert the code not to use scoped_guard()
> There's not a single flow control (return) in any of them.
> It's just hiding the information that you're unnecessarily masking irqs.
> See
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

I'll fix these in the next version.

>> +		emac_stats_update(priv);
>> +
>> +		for (i = 0; i < ARRAY_SIZE(emac_ethtool_rx_stats); i++)
>> +			data[i] = rx_stats[emac_ethtool_rx_stats[i].offset];
>> +	}
>> +static void emac_tx_timeout_task(struct work_struct *work)
>> +{
>> +	struct net_device *ndev;
>> +	struct emac_priv *priv;
>> +
>> +	priv = container_of(work, struct emac_priv, tx_timeout_task);
>> +	ndev = priv->ndev;
> I don't see this work ever being canceled.
> What prevents ndev from being freed before it gets to run?
Oops. I'll fix the handling of this timer in the next version.
>> +/* Called when net interface is brought up. */
>> +static int emac_open(struct net_device *ndev)
>> +{
>> +	struct emac_priv *priv = netdev_priv(ndev);
>> +	struct device *dev = &priv->pdev->dev;
>> +	int ret;
>> +
>> +	ret = emac_alloc_tx_resources(priv);
>> +	if (ret) {
>> +		dev_err(dev, "Error when setting up the Tx resources\n");
>> +		goto emac_alloc_tx_resource_fail;
>> +	}
>> +
>> +	ret = emac_alloc_rx_resources(priv);
>> +	if (ret) {
>> +		dev_err(dev, "Error when setting up the Rx resources\n");
>> +		goto emac_alloc_rx_resource_fail;
>> +	}
>> +
>> +	ret = emac_up(priv);
>> +	if (ret) {
>> +		dev_err(dev, "Error when bringing interface up\n");
>> +		goto emac_up_fail;
>> +	}
>> +	return 0;
>> +
>> +emac_up_fail:
> please name the jump labels after the destination not the source.
> Please fix everywhere in the driver.
> This is covered in the kernel coding style docs.
>
I'll fix in next version.

Thanks,
Vivian "dramforever" Wang


