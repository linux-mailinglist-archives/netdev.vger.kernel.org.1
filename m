Return-Path: <netdev+bounces-222047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62310B52E41
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF28480EEB
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7655B30FF3F;
	Thu, 11 Sep 2025 10:24:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94630F93E;
	Thu, 11 Sep 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586266; cv=none; b=uKNkwjEaqUsfmrjw7wf1yPcUgpg5ODQrx10iYy+yy2N7rARht7WIwa/BHU+L1JMqzBEjhjDMCykwrrWvI4D7XZCB5oU8RuS4ybs4SBh0BTSsnA5LK8OpjyTOC365tjvEZIhFW7LHTGqzOUPoV23YuQJsW1tYPOlVL1yL7TnKjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586266; c=relaxed/simple;
	bh=uMraBvcxnOW3qr8ZpGaYaLUWx50wDsuxhEvd7ZJe6Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwpRFy4O1TIChJskQE28CmL8kxEV+9DyIG9IBWQlIC3Ldz/D2dYGiYLejs+bo9IISXr50puTP7MuVIPX2H5X3fGQ7r8HC6qhb/MAovBo/wjnOtcU27vK5t0LasA31Tz4Gv0cZry9SzPgGjzY2r5WZM4CiWXAvfCqqX1DbDPr0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.105] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowAD3mBIQo8Joe2xDAg--.40639S2;
	Thu, 11 Sep 2025 18:23:12 +0800 (CST)
Message-ID: <7895b23a-2b50-4f3e-bdef-f9b7397beef2@iscas.ac.cn>
Date: Thu, 11 Sep 2025 18:23:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 2/5] net: spacemit: Add K1 Ethernet MAC
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
References: <20250908-net-k1-emac-v10-0-90d807ccd469@iscas.ac.cn>
 <20250908-net-k1-emac-v10-2-90d807ccd469@iscas.ac.cn>
 <20250911094404.GE30363@horms.kernel.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250911094404.GE30363@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAD3mBIQo8Joe2xDAg--.40639S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr4UGF43WF4fWF17ZFyxZrb_yoWfGw4UpF
	WUKa1DAFW0vF1xtrsFqayDJrnIv34ftr1j9FyYy3yI9FnIy3WSyas5KrWY934kuryq9r1F
	vw4jv3srGa90vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi Simon,

On 9/11/25 17:44, Simon Horman wrote:
> On Mon, Sep 08, 2025 at 08:34:26PM +0800, Vivian Wang wrote:
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
>> ---
>>  drivers/net/ethernet/Kconfig            |    1 +
>>  drivers/net/ethernet/Makefile           |    1 +
>>  drivers/net/ethernet/spacemit/Kconfig   |   29 +
>>  drivers/net/ethernet/spacemit/Makefile  |    6 +
>>  drivers/net/ethernet/spacemit/k1_emac.c | 2156 +++++++++++++++++++++++++++++++
> This is a large patch, so I'm sure I've missed some things.
> But, overall, I think this is coming together.
> Thanks for your recent updates.
>
> As the Kernel Patch Robot noticed a problem,
> I've provided some minor feedback for your consideration.

(That's the function at the end)

> ...
>
>> +static void emac_wr(struct emac_priv *priv, u32 reg, u32 val)
>> +{
>> +	writel(val, priv->iobase + reg);
>> +}
>> +
>> +static int emac_rd(struct emac_priv *priv, u32 reg)
> nit: maybe u32 would be a more suitable return type.
>
Ah, right, will change to u32 in the next version.

>> +{
>> +	return readl(priv->iobase + reg);
>> +}
> ...
>
>> +static int emac_alloc_tx_resources(struct emac_priv *priv)
>> +{
>> +	struct emac_desc_ring *tx_ring = &priv->tx_ring;
>> +	struct platform_device *pdev = priv->pdev;
>> +	u32 size;
>> +
>> +	size = sizeof(struct emac_tx_desc_buffer) * tx_ring->total_cnt;
>> +
>> +	tx_ring->tx_desc_buf = kzalloc(size, GFP_KERNEL);
> nit: I think you can use kcalloc() here.
>
>> +	if (!tx_ring->tx_desc_buf)
>> +		return -ENOMEM;
>> +
>> +	tx_ring->total_size = tx_ring->total_cnt * sizeof(struct emac_desc);
>> +	tx_ring->total_size = ALIGN(tx_ring->total_size, PAGE_SIZE);
>> +
>> +	tx_ring->desc_addr = dma_alloc_coherent(&pdev->dev, tx_ring->total_size,
>> +						&tx_ring->desc_dma_addr,
>> +						GFP_KERNEL);
>> +	if (!tx_ring->desc_addr) {
>> +		kfree(tx_ring->tx_desc_buf);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	tx_ring->head = 0;
>> +	tx_ring->tail = 0;
>> +
>> +	return 0;
>> +}
> ...
>
>> +static int emac_alloc_rx_resources(struct emac_priv *priv)
>> +{
>> +	struct emac_desc_ring *rx_ring = &priv->rx_ring;
>> +	struct platform_device *pdev = priv->pdev;
>> +	u32 buf_len;
>> +
>> +	buf_len = sizeof(struct emac_rx_desc_buffer) * rx_ring->total_cnt;
>> +
>> +	rx_ring->rx_desc_buf = kzalloc(buf_len, GFP_KERNEL);
> Ditto.

Will change these uses of kcalloc for these array allocations in next
version.

>> +	if (!rx_ring->rx_desc_buf)
>> +		return -ENOMEM;
>> +
>> +	rx_ring->total_size = rx_ring->total_cnt * sizeof(struct emac_desc);
>> +
>> +	rx_ring->total_size = ALIGN(rx_ring->total_size, PAGE_SIZE);
>> +
>> +	rx_ring->desc_addr = dma_alloc_coherent(&pdev->dev, rx_ring->total_size,
>> +						&rx_ring->desc_dma_addr,
>> +						GFP_KERNEL);
>> +	if (!rx_ring->desc_addr) {
>> +		kfree(rx_ring->rx_desc_buf);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	rx_ring->head = 0;
>> +	rx_ring->tail = 0;
>> +
>> +	return 0;
>> +}
> ...
>
>> +static int emac_mii_read(struct mii_bus *bus, int phy_addr, int regnum)
>> +{
>> +	struct emac_priv *priv = bus->priv;
>> +	u32 cmd = 0, val;
>> +	int ret;
>> +
>> +	cmd |= phy_addr & 0x1F;
>> +	cmd |= (regnum & 0x1F) << 5;
> nit: I think this could benefit from using FIELD_PREP
>      Likewise for similar patterns in this patch.
>
Right... I'll take a look, thanks.

>> +	cmd |= MREGBIT_START_MDIO_TRANS | MREGBIT_MDIO_READ_WRITE;
>> +
>> +	emac_wr(priv, MAC_MDIO_DATA, 0x0);
>> +	emac_wr(priv, MAC_MDIO_CONTROL, cmd);
>> +
>> +	ret = readl_poll_timeout(priv->iobase + MAC_MDIO_CONTROL, val,
>> +				 !((val >> 15) & 0x1), 100, 10000);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = emac_rd(priv, MAC_MDIO_DATA);
>> +	return val;
>> +}
> ...
>
>> +/*
>> + * Even though this MAC supports gigabit operation, it only provides 32-bit
>> + * statistics counters. The most overflow-prone counters are the "bytes" ones,
>> + * which at gigabit overflow about twice a minute.
>> + *
>> + * Therefore, we maintain the high 32 bits of counters ourselves, incrementing
>> + * every time statistics seem to go backwards. Also, update periodically to
>> + * catch overflows when we are not otherwise checking the statistics often
>> + * enough.
>> + */
>> +
>> +#define EMAC_STATS_TIMER_PERIOD		20
>> +
>> +static int emac_read_stat_cnt(struct emac_priv *priv, u8 cnt, u32 *res,
>> +			      u32 control_reg, u32 high_reg, u32 low_reg)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	/* The "read" bit is the same for TX and RX */
>> +
>> +	val = MREGBIT_START_TX_COUNTER_READ | cnt;
>> +	emac_wr(priv, control_reg, val);
>> +	val = emac_rd(priv, control_reg);
>> +
>> +	ret = readl_poll_timeout_atomic(priv->iobase + control_reg, val,
>> +					!(val & MREGBIT_START_TX_COUNTER_READ),
>> +					100, 10000);
>> +
>> +	if (ret) {
>> +		netdev_err(priv->ndev, "Read stat timeout\n");
>> +		return ret;
>> +	}
>> +
>> +	*res = emac_rd(priv, high_reg) << 16;
>> +	*res |= (u16)emac_rd(priv, low_reg);
> nit: I think lower_16_bits() and lower_16_bits() would be appropriate here.

This one is building up a 32-bit value instead of splitting a 32-bit
value in two, and we don't have those macros in linux/wordpart.h. So I
think I'll make a local helper:

static u32 emac_make_stat(u16 high, u16 low)

>> +
>> +	return 0;
>> +}
> ...
>
>> +static void emac_update_counter(u64 *counter, u32 new_low)
>> +{
>> +	u32 old_low = (u32)*counter;
>> +	u64 high = *counter >> 32;
> Similarly, lower_32_bits() and upper_32_bits here.
>
Thanks, this one I'll change to {lower,upper}_32_bits.

>> +
>> +	if (old_low > new_low) {
>> +		/* Overflowed, increment high 32 bits */
>> +		high++;
>> +	}
>> +
>> +	*counter = (high << 32) | new_low;
>> +}
>> +
>> +static void emac_stats_update(struct emac_priv *priv)
>> +{
>> +	u64 *tx_stats_off = (u64 *)&priv->tx_stats_off;
>> +	u64 *rx_stats_off = (u64 *)&priv->rx_stats_off;
>> +	u64 *tx_stats = (u64 *)&priv->tx_stats;
>> +	u64 *rx_stats = (u64 *)&priv->rx_stats;
> nit: I think it would be interesting to use a union containing
>      1. the existing tx/rx stats struct and 2. an array of u64.
>      This may allow avoiding this cast. Which seems nice to me.
>      But YMMV.

Looks like I can use a union with a DECLARE_FLEX_ARRAY for this. I'll
change it in the next version.

>> +	u32 i, res;
>> +
>> +	assert_spin_locked(&priv->stats_lock);
>> +
>> +	if (!netif_running(priv->ndev) || !netif_device_present(priv->ndev)) {
>> +		/* Not up, don't try to update */
>> +		return;
>> +	}
>> +
>> +	for (i = 0; i < sizeof(priv->tx_stats) / sizeof(*tx_stats); i++) {
>> +		/*
>> +		 * If reading stats times out, everything is broken and there's
>> +		 * nothing we can do. Reading statistics also can't return an
>> +		 * error, so just return without updating and without
>> +		 * rescheduling.
>> +		 */
>> +		if (emac_tx_read_stat_cnt(priv, i, &res))
>> +			return;
>> +
>> +		/*
>> +		 * Re-initializing while bringing interface up resets counters
>> +		 * to zero, so to provide continuity, we add the values saved
>> +		 * last time we did emac_down() to the new hardware-provided
>> +		 * value.
>> +		 */
>> +		emac_update_counter(&tx_stats[i], res + (u32)tx_stats_off[i]);
> nit: maybe lower_32_bits(tx_stats_off[i]) ?
>
>> +	}
>> +
>> +	/* Similar remarks as TX stats */
>> +	for (i = 0; i < sizeof(priv->rx_stats) / sizeof(*rx_stats); i++) {
>> +		if (emac_rx_read_stat_cnt(priv, i, &res))
>> +			return;
>> +		emac_update_counter(&rx_stats[i], res + (u32)rx_stats_off[i]);
> Likewise, here for rx_stats_off[i].
>
Thanks, these I will use lower_32_bits in these two places in the next
version.

>> +	}
>> +
>> +	mod_timer(&priv->stats_timer, jiffies + EMAC_STATS_TIMER_PERIOD * HZ);
>> +}
> ...
>
>> +static u64 emac_get_stat_tx_dropped(struct emac_priv *priv)
>> +{
>> +	u64 result;
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		result += READ_ONCE(per_cpu(*priv->stat_tx_dropped, cpu));
>> +	}
> nit: no need for {} here ?

Thanks for the catch, but with regards to this entire function, I'm
moving tx_dropped to dstats, so this would be moot.

>> +
>> +	return result;
>> +}
> ...

Thanks for your review.

Vivian "dramforever" Wang


