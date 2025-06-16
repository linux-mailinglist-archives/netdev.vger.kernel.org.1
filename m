Return-Path: <netdev+bounces-197934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDB3ADA6A2
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182897A5E0B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 03:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A328D2882C7;
	Mon, 16 Jun 2025 03:04:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFE2AD00;
	Mon, 16 Jun 2025 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750043079; cv=none; b=JZFT7DEeG45WMoYXRqze8Drd0bWRKnjVduhP5NoM9ZDu+v2LxFZzujqvSN29YTPNGIsRp9EB6lE8JBkxVFDfyUAfWr20mBE0dlEPGubyBXSNakuIs4iHU/m0HfyfPF54exN7smmWomi6ZN/DXWje0U4uhqsxns5MdmmjkL+iS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750043079; c=relaxed/simple;
	bh=GLD868Lt3rwplzHc6koaktrkoTMzJIQmtK2QLOZylz0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gmbOtkAT5Mtj5XZQle9t/4kZ6ETEGYTyjnLZ7fakYUwPEqg1+fA95O/Bt0wMI3WCCBNubtAzfDuKadq13/9Wc8bg85IDBfTs+Hwg3bqqO4j0G9PY7+0TlNObaKMym7w0lIVKRSsvOcM6I3RD8MKFFPMIpwse0Agi7GALEyp0t+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.33.113] (unknown [210.73.43.2])
	by APP-01 (Coremail) with SMTP id qwCowACnV9amiU9onFbWBg--.18579S2;
	Mon, 16 Jun 2025 11:04:08 +0800 (CST)
Message-ID: <440e3913-e41a-446d-92ba-b3599f57170e@iscas.ac.cn>
Date: Mon, 16 Jun 2025 11:04:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: Re: [PATCH net-next 2/4] net: spacemit: Add K1 Ethernet MAC
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@armlinux.org.uk>
Cc: Vivian Wang <uwu@dram.page>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn>
 <20250613-net-k1-emac-v1-2-cc6f9e510667@iscas.ac.cn>
 <d59be8aa-a288-4db5-9f93-1716ed1dd64e@linux.dev>
Content-Language: en-US
In-Reply-To: <d59be8aa-a288-4db5-9f93-1716ed1dd64e@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnV9amiU9onFbWBg--.18579S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF1DtF1kZr1UJr4kAr17trb_yoWfXr1fpa
	1kJFZ5AFyUJFn5Jr4fJr4UJFy3Ar18t3WDA3WfZay8XFnFyr12gryjqr1qgr1xur48Jr15
	Ar18XrnrurnrXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUvMUqUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Vadim,

Thanks for the review.

On 6/13/25 23:04, Vadim Fedorenko wrote:
> On 13/06/2025 03:15, Vivian Wang wrote:
>> The Ethernet MACs found on SpacemiT K1 appears to be a custom design
>> that only superficially resembles some other embedded MACs. SpacemiT
>> refers to them as "EMAC", so let's just call the driver "k1_emac".
>>
>> This driver is based on "k1x-emac" in the same directory in the vendor's
>> tree [1]. Some debugging tunables have been fixed to vendor-recommended
>> defaults, and PTP support is not included yet.
>>
>> [1]: https://github.com/spacemit-com/linux-k1x
>>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>> ---
>>   drivers/net/ethernet/Kconfig            |    1 +
>>   drivers/net/ethernet/Makefile           |    1 +
>>   drivers/net/ethernet/spacemit/Kconfig   |   29 +
>>   drivers/net/ethernet/spacemit/Makefile  |    6 +
>>   drivers/net/ethernet/spacemit/k1_emac.c | 2059
>> +++++++++++++++++++++++++++++++
>>   drivers/net/ethernet/spacemit/k1_emac.h |  416 +++++++
>>   6 files changed, 2512 insertions(+)
>
> [...]
>
>> +
>> +static int emac_init_hw(struct emac_priv *priv)
>> +{
>> +    u32 val = 0;
>> +
>> +    regmap_set_bits(priv->regmap_apmu,
>> +            priv->regmap_apmu_offset + APMU_EMAC_CTRL_REG,
>> +            AXI_SINGLE_ID);
>> +
>> +    /* Disable transmit and receive units */
>> +    emac_wr(priv, MAC_RECEIVE_CONTROL, 0x0);
>> +    emac_wr(priv, MAC_TRANSMIT_CONTROL, 0x0);
>> +
>> +    /* Enable mac address 1 filtering */
>> +    emac_wr(priv, MAC_ADDRESS_CONTROL, MREGBIT_MAC_ADDRESS1_ENABLE);
>> +
>> +    /* Zero initialize the multicast hash table */
>> +    emac_wr(priv, MAC_MULTICAST_HASH_TABLE1, 0x0);
>> +    emac_wr(priv, MAC_MULTICAST_HASH_TABLE2, 0x0);
>> +    emac_wr(priv, MAC_MULTICAST_HASH_TABLE3, 0x0);
>> +    emac_wr(priv, MAC_MULTICAST_HASH_TABLE4, 0x0);
>> +
>> +    /* Configure Thresholds */
>> +    emac_wr(priv, MAC_TRANSMIT_FIFO_ALMOST_FULL,
>> DEFAULT_TX_ALMOST_FULL);
>> +    emac_wr(priv, MAC_TRANSMIT_PACKET_START_THRESHOLD,
>> DEFAULT_TX_THRESHOLD);
>> +    emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD,
>> DEFAULT_RX_THRESHOLD);
>> +
>> +    /* RX IRQ mitigation */
>> +    val = EMAC_RX_FRAMES & MREGBIT_RECEIVE_IRQ_FRAME_COUNTER_MASK;
>> +    val |= (EMAC_RX_COAL_TIMEOUT
>> +        << MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_SHIFT) &
>> +           MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_MASK;
>> +
>> +    val |= MREGBIT_RECEIVE_IRQ_MITIGATION_ENABLE;
>> +    emac_wr(priv, DMA_RECEIVE_IRQ_MITIGATION_CTRL, val);
>> +
>> +    /* Disable and reset DMA */
>> +    emac_wr(priv, DMA_CONTROL, 0x0);
>> +
>> +    emac_wr(priv, DMA_CONFIGURATION, MREGBIT_SOFTWARE_RESET);
>> +    usleep_range(9000, 10000);
>> +    emac_wr(priv, DMA_CONFIGURATION, 0x0);
>> +    usleep_range(9000, 10000);
>> +
>> +    val |= MREGBIT_STRICT_BURST;
>> +    val |= MREGBIT_DMA_64BIT_MODE;
>> +    val |= DEFAULT_DMA_BURST;
>
>        val here will have bits of MREGBIT_RECEIVE_IRQ_FRAME_COUNTER_MASK
>        and MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_MASK set. Not sure if
>        it's intended
>
Thanks for the catch. I will fix this in the next version.
>> +
>> +    emac_wr(priv, DMA_CONFIGURATION, val);
>> +
>> +    return 0;
>> +}
>> +
>> +static void emac_set_mac_addr(struct emac_priv *priv, const unsigned
>> char *addr)
>> +{
>> +    emac_wr(priv, MAC_ADDRESS1_HIGH, ((addr[1] << 8) | addr[0]));
>> +    emac_wr(priv, MAC_ADDRESS1_MED, ((addr[3] << 8) | addr[2]));
>> +    emac_wr(priv, MAC_ADDRESS1_LOW, ((addr[5] << 8) | addr[4]));
>> +}
>> +
>> +static void emac_dma_start_transmit(struct emac_priv *priv)
>> +{
>> +    emac_wr(priv, DMA_TRANSMIT_POLL_DEMAND, 0xFF);
>> +}
>> +
>> +static void emac_enable_interrupt(struct emac_priv *priv)
>> +{
>> +    u32 val;
>> +
>> +    val = emac_rd(priv, DMA_INTERRUPT_ENABLE);
>> +    val |= MREGBIT_TRANSMIT_TRANSFER_DONE_INTR_ENABLE;
>> +    val |= MREGBIT_RECEIVE_TRANSFER_DONE_INTR_ENABLE;
>> +    emac_wr(priv, DMA_INTERRUPT_ENABLE, val);
>> +}
>> +
>> +static void emac_disable_interrupt(struct emac_priv *priv)
>> +{
>> +    u32 val;
>> +
>> +    val = emac_rd(priv, DMA_INTERRUPT_ENABLE);
>> +    val &= ~MREGBIT_TRANSMIT_TRANSFER_DONE_INTR_ENABLE;
>> +    val &= ~MREGBIT_RECEIVE_TRANSFER_DONE_INTR_ENABLE;
>> +    emac_wr(priv, DMA_INTERRUPT_ENABLE, val);
>> +}
>> +
>> +static inline u32 emac_tx_avail(struct emac_priv *priv)
>
> please, avoid "static inline" in .c files, let the compiler to choose
> what to inline.
>
I will remove inline in next version.
>> +{
>> +    struct emac_desc_ring *tx_ring = &priv->tx_ring;
>> +    u32 avail;
>> +
>> +    if (tx_ring->tail > tx_ring->head)
>> +        avail = tx_ring->tail - tx_ring->head - 1;
>> +    else
>> +        avail = tx_ring->total_cnt - tx_ring->head + tx_ring->tail - 1;
>> +
>> +    return avail;
>> +}
>> +
[...]
>> +static int emac_up(struct emac_priv *priv)
>> +{
>> +    struct platform_device *pdev = priv->pdev;
>> +    struct net_device *ndev = priv->ndev;
>> +    int ret;
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +    pm_runtime_get_sync(&pdev->dev);
>> +#endif
>
> Not sure why do you depend on CONFIG_PM_SLEEP, but
> pm_runtime_get_sync/pm_runtime_put_sync are available with and without
> CONFIG_PM, no need
> for ifdef
>
I will remove #ifdef in next version.
>> +
>> +    ret = emac_phy_connect(ndev);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "emac_phy_connect failed\n");
>> +        goto err;
>> +    }
>> +
>> +    emac_init_hw(priv);
>> +
>> +    emac_set_mac_addr(priv, ndev->dev_addr);
>> +    emac_configure_tx(priv);
>> +    emac_configure_rx(priv);
>> +
>> +    emac_alloc_rx_desc_buffers(priv);
>> +
>> +    if (ndev->phydev)
>> +        phy_start(ndev->phydev);
>> +
>> +    ret = request_irq(priv->irq, emac_interrupt_handler, IRQF_SHARED,
>> +              ndev->name, ndev);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "request_irq failed\n");
>> +        goto request_irq_failed;
>> +    }
>> +
>> +    /* Don't enable MAC interrupts */
>> +    emac_wr(priv, MAC_INTERRUPT_ENABLE, 0x0);
>> +
>> +    /* Enable DMA interrupts */
>> +    emac_wr(priv, DMA_INTERRUPT_ENABLE,
>> +        MREGBIT_TRANSMIT_TRANSFER_DONE_INTR_ENABLE |
>> +            MREGBIT_TRANSMIT_DMA_STOPPED_INTR_ENABLE |
>> +            MREGBIT_RECEIVE_TRANSFER_DONE_INTR_ENABLE |
>> +            MREGBIT_RECEIVE_DMA_STOPPED_INTR_ENABLE |
>> +            MREGBIT_RECEIVE_MISSED_FRAME_INTR_ENABLE);
>> +
>> +    napi_enable(&priv->napi);
>> +
>> +    netif_start_queue(ndev);
>> +    return 0;
>> +
>> +request_irq_failed:
>> +    emac_reset_hw(priv);
>> +    if (ndev->phydev) {
>> +        phy_stop(ndev->phydev);
>> +        phy_disconnect(ndev->phydev);
>> +    }
>> +err:
>> +#ifdef CONFIG_PM_SLEEP
>> +    pm_runtime_put_sync(&pdev->dev);
>> +#endif
>> +    return ret;
>> +}
>> +
>> +static int emac_down(struct emac_priv *priv)
>> +{
>> +    struct platform_device *pdev = priv->pdev;
>> +    struct net_device *ndev = priv->ndev;
>> +
>> +    netif_stop_queue(ndev);
>> +
>> +    if (ndev->phydev) {
>> +        phy_stop(ndev->phydev);
>> +        phy_disconnect(ndev->phydev);
>> +    }
>> +
>> +    priv->link = false;
>> +    priv->duplex = DUPLEX_UNKNOWN;
>> +    priv->speed = SPEED_UNKNOWN;
>> +
>> +    emac_wr(priv, MAC_INTERRUPT_ENABLE, 0x0);
>> +    emac_wr(priv, DMA_INTERRUPT_ENABLE, 0x0);
>> +
>> +    free_irq(priv->irq, ndev);
>> +
>> +    napi_disable(&priv->napi);
>> +
>> +    emac_reset_hw(priv);
>> +    netif_carrier_off(ndev);
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +    pm_runtime_put_sync(&pdev->dev);
>> +#endif
>
> ditto
>
I will remove #ifdef in next version.

Thanks again for your review.

Regards,
Vivian "dramforever" Wang

>> +    return 0;
>> +}
>> +
>
> [...]


