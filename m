Return-Path: <netdev+bounces-197529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88927AD90B3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE891E36D9
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44901A5BBD;
	Fri, 13 Jun 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AaM9rxBt"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0119FA93
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827063; cv=none; b=oAFNVCHOpm+U6Tn1Ghu3pJy/uJfNkwzpZrTj7eRLErBBXAqLy5knG9n9jHJ+VgAadXUd8uxzqpZt08rPQe/d+YI9gS99TfrbP4EqFOqNHAWeKY/j/n4EFRkjhjifabVZK9OcqhjN4zIAslt0ltKh/ltU5qrHgQwQUXmwOb7wYUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827063; c=relaxed/simple;
	bh=emPt7KVQco9+jsiiDbiVTaJPf6cGPplminFGPTzr5DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwIinYkUPwtJnzMoLmdbUl6zAcd/HEWFBH7isPWz1nRJYvQ6qjVuGb2bQ2PFJqBZXRcv2Yqhmu6c8yyNa40w5KvtFMTkLyhWMzvxUMHfzyjorr16MSGa75tsis8/8hare/YZM6wgja84LHkPEmMOo5ZUvEvD/Kr8lQftfvZJ9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AaM9rxBt; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d59be8aa-a288-4db5-9f93-1716ed1dd64e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749827055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IG+OxXsu7kERE/GwIe4zOanlV/094OyCDQjHMWVkmNQ=;
	b=AaM9rxBtu+HXwYZecQVSVweu/MkF8RykOPy0Q6Y/bPFnMh1MgnwpHo7OPXvn50P6GimC/N
	l5rWB5fWOeD8cA8Jue6rElXn/Algd5cpradoIKTeONWjvv1xTXy0YjB0LbTudQSZEOsOJE
	VppqJO9IdVGc02Uocj12fKCDFH/5YFI=
Date: Fri, 13 Jun 2025 16:04:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/4] net: spacemit: Add K1 Ethernet MAC
To: Vivian Wang <wangruikang@iscas.ac.cn>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@armlinux.org.uk>
Cc: Vivian Wang <uwu@dram.page>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn>
 <20250613-net-k1-emac-v1-2-cc6f9e510667@iscas.ac.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250613-net-k1-emac-v1-2-cc6f9e510667@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/06/2025 03:15, Vivian Wang wrote:
> The Ethernet MACs found on SpacemiT K1 appears to be a custom design
> that only superficially resembles some other embedded MACs. SpacemiT
> refers to them as "EMAC", so let's just call the driver "k1_emac".
> 
> This driver is based on "k1x-emac" in the same directory in the vendor's
> tree [1]. Some debugging tunables have been fixed to vendor-recommended
> defaults, and PTP support is not included yet.
> 
> [1]: https://github.com/spacemit-com/linux-k1x
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
>   drivers/net/ethernet/Kconfig            |    1 +
>   drivers/net/ethernet/Makefile           |    1 +
>   drivers/net/ethernet/spacemit/Kconfig   |   29 +
>   drivers/net/ethernet/spacemit/Makefile  |    6 +
>   drivers/net/ethernet/spacemit/k1_emac.c | 2059 +++++++++++++++++++++++++++++++
>   drivers/net/ethernet/spacemit/k1_emac.h |  416 +++++++
>   6 files changed, 2512 insertions(+)

[...]

> +
> +static int emac_init_hw(struct emac_priv *priv)
> +{
> +	u32 val = 0;
> +
> +	regmap_set_bits(priv->regmap_apmu,
> +			priv->regmap_apmu_offset + APMU_EMAC_CTRL_REG,
> +			AXI_SINGLE_ID);
> +
> +	/* Disable transmit and receive units */
> +	emac_wr(priv, MAC_RECEIVE_CONTROL, 0x0);
> +	emac_wr(priv, MAC_TRANSMIT_CONTROL, 0x0);
> +
> +	/* Enable mac address 1 filtering */
> +	emac_wr(priv, MAC_ADDRESS_CONTROL, MREGBIT_MAC_ADDRESS1_ENABLE);
> +
> +	/* Zero initialize the multicast hash table */
> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE1, 0x0);
> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE2, 0x0);
> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE3, 0x0);
> +	emac_wr(priv, MAC_MULTICAST_HASH_TABLE4, 0x0);
> +
> +	/* Configure Thresholds */
> +	emac_wr(priv, MAC_TRANSMIT_FIFO_ALMOST_FULL, DEFAULT_TX_ALMOST_FULL);
> +	emac_wr(priv, MAC_TRANSMIT_PACKET_START_THRESHOLD, DEFAULT_TX_THRESHOLD);
> +	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
> +
> +	/* RX IRQ mitigation */
> +	val = EMAC_RX_FRAMES & MREGBIT_RECEIVE_IRQ_FRAME_COUNTER_MASK;
> +	val |= (EMAC_RX_COAL_TIMEOUT
> +		<< MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_SHIFT) &
> +	       MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_MASK;
> +
> +	val |= MREGBIT_RECEIVE_IRQ_MITIGATION_ENABLE;
> +	emac_wr(priv, DMA_RECEIVE_IRQ_MITIGATION_CTRL, val);
> +
> +	/* Disable and reset DMA */
> +	emac_wr(priv, DMA_CONTROL, 0x0);
> +
> +	emac_wr(priv, DMA_CONFIGURATION, MREGBIT_SOFTWARE_RESET);
> +	usleep_range(9000, 10000);
> +	emac_wr(priv, DMA_CONFIGURATION, 0x0);
> +	usleep_range(9000, 10000);
> +
> +	val |= MREGBIT_STRICT_BURST;
> +	val |= MREGBIT_DMA_64BIT_MODE;
> +	val |= DEFAULT_DMA_BURST;

        val here will have bits of MREGBIT_RECEIVE_IRQ_FRAME_COUNTER_MASK
        and MREGBIT_RECEIVE_IRQ_TIMEOUT_COUNTER_MASK set. Not sure if
        it's intended

> +
> +	emac_wr(priv, DMA_CONFIGURATION, val);
> +
> +	return 0;
> +}
> +
> +static void emac_set_mac_addr(struct emac_priv *priv, const unsigned char *addr)
> +{
> +	emac_wr(priv, MAC_ADDRESS1_HIGH, ((addr[1] << 8) | addr[0]));
> +	emac_wr(priv, MAC_ADDRESS1_MED, ((addr[3] << 8) | addr[2]));
> +	emac_wr(priv, MAC_ADDRESS1_LOW, ((addr[5] << 8) | addr[4]));
> +}
> +
> +static void emac_dma_start_transmit(struct emac_priv *priv)
> +{
> +	emac_wr(priv, DMA_TRANSMIT_POLL_DEMAND, 0xFF);
> +}
> +
> +static void emac_enable_interrupt(struct emac_priv *priv)
> +{
> +	u32 val;
> +
> +	val = emac_rd(priv, DMA_INTERRUPT_ENABLE);
> +	val |= MREGBIT_TRANSMIT_TRANSFER_DONE_INTR_ENABLE;
> +	val |= MREGBIT_RECEIVE_TRANSFER_DONE_INTR_ENABLE;
> +	emac_wr(priv, DMA_INTERRUPT_ENABLE, val);
> +}
> +
> +static void emac_disable_interrupt(struct emac_priv *priv)
> +{
> +	u32 val;
> +
> +	val = emac_rd(priv, DMA_INTERRUPT_ENABLE);
> +	val &= ~MREGBIT_TRANSMIT_TRANSFER_DONE_INTR_ENABLE;
> +	val &= ~MREGBIT_RECEIVE_TRANSFER_DONE_INTR_ENABLE;
> +	emac_wr(priv, DMA_INTERRUPT_ENABLE, val);
> +}
> +
> +static inline u32 emac_tx_avail(struct emac_priv *priv)

please, avoid "static inline" in .c files, let the compiler to choose
what to inline.

> +{
> +	struct emac_desc_ring *tx_ring = &priv->tx_ring;
> +	u32 avail;
> +
> +	if (tx_ring->tail > tx_ring->head)
> +		avail = tx_ring->tail - tx_ring->head - 1;
> +	else
> +		avail = tx_ring->total_cnt - tx_ring->head + tx_ring->tail - 1;
> +
> +	return avail;
> +}
> +
> +static void emac_tx_coal_timer_resched(struct emac_priv *priv)
> +{
> +	mod_timer(&priv->txtimer,
> +		  jiffies + usecs_to_jiffies(priv->tx_coal_timeout));
> +}
> +
> +static void emac_tx_coal_timer(struct timer_list *t)
> +{
> +	struct emac_priv *priv = timer_container_of(priv, t, txtimer);
> +
> +	napi_schedule(&priv->napi);
> +}
> +
> +static bool emac_tx_coal_should_interrupt(struct emac_priv *priv, u32 pkt_num)
> +{
> +	bool should_interrupt;
> +
> +	/* Manage TX mitigation */
> +	priv->tx_count_frames += pkt_num;
> +	if (likely(priv->tx_coal_frames > priv->tx_count_frames)) {
> +		emac_tx_coal_timer_resched(priv);
> +		should_interrupt = false;
> +	} else {
> +		priv->tx_count_frames = 0;
> +		should_interrupt = true;
> +	}
> +
> +	return should_interrupt;
> +}
> +
> +static void emac_sw_init(struct emac_priv *priv)
> +{
> +	priv->dma_buf_sz = EMAC_DEFAULT_BUFSIZE;
> +
> +	priv->tx_ring.total_cnt = DEFAULT_TX_RING_NUM;
> +	priv->rx_ring.total_cnt = DEFAULT_RX_RING_NUM;
> +
> +	spin_lock_init(&priv->stats_lock);
> +
> +	INIT_WORK(&priv->tx_timeout_task, emac_tx_timeout_task);
> +
> +	priv->tx_coal_frames = EMAC_TX_FRAMES;
> +	priv->tx_coal_timeout = EMAC_TX_COAL_TIMEOUT;
> +
> +	timer_setup(&priv->txtimer, emac_tx_coal_timer, 0);
> +}
> +
> +static int emac_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
> +{
> +	int ret = -EOPNOTSUPP;
> +
> +	if (!netif_running(ndev))
> +		return -EINVAL;
> +
> +	switch (cmd) {
> +	case SIOCGMIIPHY:
> +	case SIOCGMIIREG:
> +	case SIOCSMIIREG:
> +		if (!ndev->phydev)
> +			return -EINVAL;
> +		ret = phy_mii_ioctl(ndev->phydev, rq, cmd);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t emac_interrupt_handler(int irq, void *dev_id)
> +{
> +	struct net_device *ndev = (struct net_device *)dev_id;
> +	struct emac_priv *priv = netdev_priv(ndev);
> +	bool should_schedule = false;
> +	u32 status;
> +	u32 clr = 0;
> +
> +	if (test_bit(EMAC_DOWN, &priv->state))
> +		return IRQ_HANDLED;
> +
> +	status = emac_rd(priv, DMA_STATUS_IRQ);
> +
> +	if (status & MREGBIT_TRANSMIT_TRANSFER_DONE_IRQ) {
> +		clr |= MREGBIT_TRANSMIT_TRANSFER_DONE_IRQ;
> +		should_schedule = true;
> +	}
> +
> +	if (status & MREGBIT_TRANSMIT_DES_UNAVAILABLE_IRQ)
> +		clr |= MREGBIT_TRANSMIT_DES_UNAVAILABLE_IRQ;
> +
> +	if (status & MREGBIT_TRANSMIT_DMA_STOPPED_IRQ)
> +		clr |= MREGBIT_TRANSMIT_DMA_STOPPED_IRQ;
> +
> +	if (status & MREGBIT_RECEIVE_TRANSFER_DONE_IRQ) {
> +		clr |= MREGBIT_RECEIVE_TRANSFER_DONE_IRQ;
> +		should_schedule = true;
> +	}
> +
> +	if (status & MREGBIT_RECEIVE_DES_UNAVAILABLE_IRQ)
> +		clr |= MREGBIT_RECEIVE_DES_UNAVAILABLE_IRQ;
> +
> +	if (status & MREGBIT_RECEIVE_DMA_STOPPED_IRQ)
> +		clr |= MREGBIT_RECEIVE_DMA_STOPPED_IRQ;
> +
> +	if (status & MREGBIT_RECEIVE_MISSED_FRAME_IRQ)
> +		clr |= MREGBIT_RECEIVE_MISSED_FRAME_IRQ;
> +
> +	if (should_schedule) {
> +		if (napi_schedule_prep(&priv->napi)) {
> +			emac_disable_interrupt(priv);
> +			__napi_schedule_irqoff(&priv->napi);
> +		}
> +	}
> +
> +	emac_wr(priv, DMA_STATUS_IRQ, clr);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void emac_configure_tx(struct emac_priv *priv)
> +{
> +	u32 val;
> +
> +	/* Set base address */
> +	val = (u32)(priv->tx_ring.desc_dma_addr);
> +
> +	emac_wr(priv, DMA_TRANSMIT_BASE_ADDRESS, val);
> +
> +	/* TX Inter-frame gap value, enable transmit */
> +	val = emac_rd(priv, MAC_TRANSMIT_CONTROL);
> +	val &= ~MREGBIT_IFG_LEN;
> +	val |= MREGBIT_TRANSMIT_ENABLE;
> +	val |= MREGBIT_TRANSMIT_AUTO_RETRY;
> +	emac_wr(priv, MAC_TRANSMIT_CONTROL, val);
> +
> +	emac_wr(priv, DMA_TRANSMIT_AUTO_POLL_COUNTER, 0x0);
> +
> +	/* Start TX DMA */
> +	val = emac_rd(priv, DMA_CONTROL);
> +	val |= MREGBIT_START_STOP_TRANSMIT_DMA;
> +	emac_wr(priv, DMA_CONTROL, val);
> +}
> +
> +static void emac_configure_rx(struct emac_priv *priv)
> +{
> +	u32 val;
> +
> +	/* Set base address */
> +	val = (u32)(priv->rx_ring.desc_dma_addr);
> +	emac_wr(priv, DMA_RECEIVE_BASE_ADDRESS, val);
> +
> +	/* Enable receive */
> +	val = emac_rd(priv, MAC_RECEIVE_CONTROL);
> +	val |= MREGBIT_RECEIVE_ENABLE;
> +	val |= MREGBIT_STORE_FORWARD;
> +	emac_wr(priv, MAC_RECEIVE_CONTROL, val);
> +
> +	/* Start RX DMA */
> +	val = emac_rd(priv, DMA_CONTROL);
> +	val |= MREGBIT_START_STOP_RECEIVE_DMA;
> +	emac_wr(priv, DMA_CONTROL, val);
> +}
> +
> +static void emac_free_tx_buf(struct emac_priv *priv, int i)
> +{
> +	struct emac_tx_desc_buffer *tx_buf;
> +	struct emac_desc_ring *tx_ring;
> +	struct desc_buf *buf;
> +	int j;
> +
> +	tx_ring = &priv->tx_ring;
> +	tx_buf = &tx_ring->tx_desc_buf[i];
> +
> +	for (j = 0; j < 2; j++) {
> +		buf = &tx_buf->buf[j];
> +		if (buf->dma_addr) {
> +			if (buf->map_as_page)
> +				dma_unmap_page(&priv->pdev->dev, buf->dma_addr,
> +					       buf->dma_len, DMA_TO_DEVICE);
> +			else
> +				dma_unmap_single(&priv->pdev->dev,
> +						 buf->dma_addr, buf->dma_len,
> +						 DMA_TO_DEVICE);
> +
> +			buf->dma_addr = 0;
> +			buf->map_as_page = false;
> +			buf->buff_addr = NULL;
> +		}
> +	}
> +
> +	if (tx_buf->skb) {
> +		dev_kfree_skb_any(tx_buf->skb);
> +		tx_buf->skb = NULL;
> +	}
> +}
> +
> +static void emac_clean_tx_desc_ring(struct emac_priv *priv)
> +{
> +	struct emac_desc_ring *tx_ring = &priv->tx_ring;
> +	u32 i;
> +
> +	/* Free all the TX ring skbs */
> +	for (i = 0; i < tx_ring->total_cnt; i++)
> +		emac_free_tx_buf(priv, i);
> +
> +	tx_ring->head = 0;
> +	tx_ring->tail = 0;
> +}
> +
> +static void emac_clean_rx_desc_ring(struct emac_priv *priv)
> +{
> +	struct emac_rx_desc_buffer *rx_buf;
> +	struct emac_desc_ring *rx_ring;
> +	u32 i;
> +
> +	rx_ring = &priv->rx_ring;
> +
> +	/* Free all the RX ring skbs */
> +	for (i = 0; i < rx_ring->total_cnt; i++) {
> +		rx_buf = &rx_ring->rx_desc_buf[i];
> +		if (rx_buf->skb) {
> +			dma_unmap_single(&priv->pdev->dev, rx_buf->dma_addr,
> +					 rx_buf->dma_len, DMA_FROM_DEVICE);
> +
> +			dev_kfree_skb(rx_buf->skb);
> +			rx_buf->skb = NULL;
> +		}
> +	}
> +
> +	rx_ring->tail = 0;
> +	rx_ring->head = 0;
> +}
> +
> +static int emac_up(struct emac_priv *priv)
> +{
> +	struct platform_device *pdev = priv->pdev;
> +	struct net_device *ndev = priv->ndev;
> +	int ret;
> +
> +#ifdef CONFIG_PM_SLEEP
> +	pm_runtime_get_sync(&pdev->dev);
> +#endif

Not sure why do you depend on CONFIG_PM_SLEEP, but 
pm_runtime_get_sync/pm_runtime_put_sync are available with and without 
CONFIG_PM, no need
for ifdef

> +
> +	ret = emac_phy_connect(ndev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "emac_phy_connect failed\n");
> +		goto err;
> +	}
> +
> +	emac_init_hw(priv);
> +
> +	emac_set_mac_addr(priv, ndev->dev_addr);
> +	emac_configure_tx(priv);
> +	emac_configure_rx(priv);
> +
> +	emac_alloc_rx_desc_buffers(priv);
> +
> +	if (ndev->phydev)
> +		phy_start(ndev->phydev);
> +
> +	ret = request_irq(priv->irq, emac_interrupt_handler, IRQF_SHARED,
> +			  ndev->name, ndev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request_irq failed\n");
> +		goto request_irq_failed;
> +	}
> +
> +	/* Don't enable MAC interrupts */
> +	emac_wr(priv, MAC_INTERRUPT_ENABLE, 0x0);
> +
> +	/* Enable DMA interrupts */
> +	emac_wr(priv, DMA_INTERRUPT_ENABLE,
> +		MREGBIT_TRANSMIT_TRANSFER_DONE_INTR_ENABLE |
> +			MREGBIT_TRANSMIT_DMA_STOPPED_INTR_ENABLE |
> +			MREGBIT_RECEIVE_TRANSFER_DONE_INTR_ENABLE |
> +			MREGBIT_RECEIVE_DMA_STOPPED_INTR_ENABLE |
> +			MREGBIT_RECEIVE_MISSED_FRAME_INTR_ENABLE);
> +
> +	napi_enable(&priv->napi);
> +
> +	netif_start_queue(ndev);
> +	return 0;
> +
> +request_irq_failed:
> +	emac_reset_hw(priv);
> +	if (ndev->phydev) {
> +		phy_stop(ndev->phydev);
> +		phy_disconnect(ndev->phydev);
> +	}
> +err:
> +#ifdef CONFIG_PM_SLEEP
> +	pm_runtime_put_sync(&pdev->dev);
> +#endif
> +	return ret;
> +}
> +
> +static int emac_down(struct emac_priv *priv)
> +{
> +	struct platform_device *pdev = priv->pdev;
> +	struct net_device *ndev = priv->ndev;
> +
> +	netif_stop_queue(ndev);
> +
> +	if (ndev->phydev) {
> +		phy_stop(ndev->phydev);
> +		phy_disconnect(ndev->phydev);
> +	}
> +
> +	priv->link = false;
> +	priv->duplex = DUPLEX_UNKNOWN;
> +	priv->speed = SPEED_UNKNOWN;
> +
> +	emac_wr(priv, MAC_INTERRUPT_ENABLE, 0x0);
> +	emac_wr(priv, DMA_INTERRUPT_ENABLE, 0x0);
> +
> +	free_irq(priv->irq, ndev);
> +
> +	napi_disable(&priv->napi);
> +
> +	emac_reset_hw(priv);
> +	netif_carrier_off(ndev);
> +
> +#ifdef CONFIG_PM_SLEEP
> +	pm_runtime_put_sync(&pdev->dev);
> +#endif

ditto

> +	return 0;
> +}
> +

[...]


