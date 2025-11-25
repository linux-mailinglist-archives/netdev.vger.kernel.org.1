Return-Path: <netdev+bounces-241586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109BDC862AD
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9603B3DC9
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B7C329E73;
	Tue, 25 Nov 2025 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D+wGRgtp"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143C324B0A;
	Tue, 25 Nov 2025 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090928; cv=none; b=oP71tXd5lZBBS2XirqY3YO+3KBR0l8IjN5gLT3V8lvrwl5dXwMmzIBpdI/UEa1i9Y49qRk/XubnSdmxjzBhNIKTzDoaG3mvnPUIdSBfYz10JgelMPiXgCbjlO6JxgT4mP6OmBUWXkQrgUv7M7xkUu4L1hb6Hb6++VpeTGhp9RLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090928; c=relaxed/simple;
	bh=RBivun6zk4kvZILIUbR5Gys3JRzErIoQlYXqM0NpN7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=deoB/nl/mt129iDvIC4N6LV3QFmk/zScpJgRNjpfhft9o8SxuYIoZCuOPn5rA4vxAbZxmybLqIbVw4FKg+awaXEq7qxL4CMru4u999PC5Ff+aZbQDs4ZFpgxcNp59XLGmmcOPSMhK9aBq/b+HdfJLUaq7LcNj3vTfIFTGMLczVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D+wGRgtp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 277334E418B3;
	Tue, 25 Nov 2025 17:15:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA583606A1;
	Tue, 25 Nov 2025 17:15:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9291C102F0891;
	Tue, 25 Nov 2025 18:15:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764090923; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=eRMUjzvc385emaM00QkruAlsCUJkwg3kL1OtudlNM8o=;
	b=D+wGRgtpGAyb2M8Agj+56AXrxl6+occfRjhl8yC2nBpOqT004FDP55HpGanCzwgiqpDbTd
	34z5t8Cgxi+lBpRfxOW3kxXxyaxuPqWLYFBU869BV2x1l7A6Zx4f7PSO5bDPFWrFeJT+lI
	Ul7XzTaYhVCd93gFGSjGbXcJsQMM6ZJOcz6YkNPg6qs2ehKlElkDbco3sypwsEbfzBQYwS
	75mUXzFBtSgWij5Hrh6EtI12mGMUcaEs1W+oiCkaD/4bXvvZ0BLIETnBk1iXjKSoK3GOPU
	PZk481ms0GIAvcoGM30X+uoOFLr9qJNsrTNeP7yGYryFzQT2xBbu57XlSH442A==
Message-ID: <58ec46bb-5850-4dde-a1ea-d242f7d95409@bootlin.com>
Date: Tue, 25 Nov 2025 18:15:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: dwmac: Disable flushing frames on
 Rx Buffer Unavailable
To: rohan.g.thomas@altera.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20251126-a10_ext_fix-v1-1-d163507f646f@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251126-a10_ext_fix-v1-1-d163507f646f@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Rohan,

On 25/11/2025 17:37, Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> In Store and Forward mode, flushing frames when the receive buffer is
> unavailable, can cause the MTL Rx FIFO to go out of sync. This results
> in buffering of a few frames in the FIFO without triggering Rx DMA
> from transferring the data to the system memory until another packet
> is received. Once the issue happens, for a ping request, the packet is
> forwarded to the system memory only after we receive another packet
> and hece we observe a latency equivalent to the ping interval.
> 
> 64 bytes from 192.168.2.100: seq=1 ttl=64 time=1000.344 ms
> 
> Also, we can observe constant gmacgrp_debug register value of
> 0x00000120, which indicates "Reading frame data".
> 
> The issue is not reproducible after disabling frame flushing when Rx
> buffer is unavailable. But in that case, the Rx DMA enters a suspend
> state due to buffer unavailability. To resume operation, software
> must write to the receive_poll_demand register after adding new
> descriptors, which reactivates the Rx DMA.
> 
> This issue is observed in the socfpga platforms which has dwmac1000 IP
> like Arria 10, Cyclone V and Agilex 7. Issue is reproducible after
> running iperf3 server at the DUT for UDP lower packet sizes.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>

Should this be a fix ?

Can you elaborate on how to reproduce this ? I've given this a try on
CycloneV and I can't see any difference in the ping results and iperf3
results.

From the DUT, I've tried :
 - iperf3 -c 192.168.X.X -u -b 0 -l 64
 - iperf3 -c 192.168.X.X -u -b 0 -l 64 -R
 - iperf3 -c 192.168.X.X
 - iperf3 -c 192.168.X.X -R

I'm reading the same results with and without the patch

I've done ping tests as well, the latency seems to be the same with and
without this patch, at around 0.193ms RTT.

I'm not familiar with the SF_DMA_MODE though, any thing special to do to
enter that mode ?

Thanks,

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 5 +++--
>  drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h     | 1 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c     | 5 +++++
>  drivers/net/ethernet/stmicro/stmmac/hwif.h          | 3 +++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 2 ++
>  5 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> index 6d9b8fac3c6d0fd76733ab4a1a8cce2420fa40b4..5877fec9f6c30ed18cdcf5398816e444e0bd0091 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -135,10 +135,10 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
>  
>  	if (mode == SF_DMA_MODE) {
>  		pr_debug("GMAC: enable RX store and forward mode\n");
> -		csr6 |= DMA_CONTROL_RSF;
> +		csr6 |= DMA_CONTROL_RSF | DMA_CONTROL_DFF;
>  	} else {
>  		pr_debug("GMAC: disable RX SF mode (threshold %d)\n", mode);
> -		csr6 &= ~DMA_CONTROL_RSF;
> +		csr6 &= ~(DMA_CONTROL_RSF | DMA_CONTROL_DFF);
>  		csr6 &= DMA_CONTROL_TC_RX_MASK;
>  		if (mode <= 32)
>  			csr6 |= DMA_CONTROL_RTC_32;
> @@ -262,6 +262,7 @@ const struct stmmac_dma_ops dwmac1000_dma_ops = {
>  	.dma_rx_mode = dwmac1000_dma_operation_mode_rx,
>  	.dma_tx_mode = dwmac1000_dma_operation_mode_tx,
>  	.enable_dma_transmission = dwmac_enable_dma_transmission,
> +	.enable_dma_reception = dwmac_enable_dma_reception,
>  	.enable_dma_irq = dwmac_enable_dma_irq,
>  	.disable_dma_irq = dwmac_disable_dma_irq,
>  	.start_tx = dwmac_dma_start_tx,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> index d1c149f7a3dd9e472b237101666e11878707f0f2..054ecb20ce3f68bce5da3efaf36acf33e430d3f0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
> @@ -169,6 +169,7 @@ static inline u32 dma_chan_base_addr(u32 base, u32 chan)
>  #define NUM_DWMAC4_DMA_REGS	27
>  
>  void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan);
> +void dwmac_enable_dma_reception(void __iomem *ioaddr, u32 chan);
>  void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  u32 chan, bool rx, bool tx);
>  void dwmac_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> index 467f1a05747ecf0be5b9f3392cd3d2049d676c21..97a803d68e3a2f120beaa7c3254748cf404236df 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
> @@ -33,6 +33,11 @@ void dwmac_enable_dma_transmission(void __iomem *ioaddr, u32 chan)
>  	writel(1, ioaddr + DMA_CHAN_XMT_POLL_DEMAND(chan));
>  }
>  
> +void dwmac_enable_dma_reception(void __iomem *ioaddr, u32 chan)
> +{
> +	writel(1, ioaddr + DMA_CHAN_RCV_POLL_DEMAND(chan));
> +}
> +
>  void dwmac_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			  u32 chan, bool rx, bool tx)
>  {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index f257ce4b6c66e0bbd3180d54ac7f5be934153a6b..df6e8a567b1f646f83effbb38d8e53441a6f6150 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -201,6 +201,7 @@ struct stmmac_dma_ops {
>  	void (*dma_diagnostic_fr)(struct stmmac_extra_stats *x,
>  				  void __iomem *ioaddr);
>  	void (*enable_dma_transmission)(void __iomem *ioaddr, u32 chan);
> +	void (*enable_dma_reception)(void __iomem *ioaddr, u32 chan);
>  	void (*enable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
>  			       u32 chan, bool rx, bool tx);
>  	void (*disable_dma_irq)(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -261,6 +262,8 @@ struct stmmac_dma_ops {
>  	stmmac_do_void_callback(__priv, dma, dma_diagnostic_fr, __args)
>  #define stmmac_enable_dma_transmission(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, dma, enable_dma_transmission, __args)
> +#define stmmac_enable_dma_reception(__priv, __args...) \
> +	stmmac_do_void_callback(__priv, dma, enable_dma_reception, __args)
>  #define stmmac_enable_dma_irq(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, dma, enable_dma_irq, __priv, __args)
>  #define stmmac_disable_dma_irq(__priv, __args...) \
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 6cacedb2c9b3fefdd4c9ec8ba98d389443d21ebd..1ecca60baf74286da7f156b4c3c835b3cbabf1ba 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4973,6 +4973,8 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
>  	rx_q->rx_tail_addr = rx_q->dma_rx_phy +
>  			    (rx_q->dirty_rx * sizeof(struct dma_desc));
>  	stmmac_set_rx_tail_ptr(priv, priv->ioaddr, rx_q->rx_tail_addr, queue);
> +	/* Wake up Rx DMA from the suspend state if required */
> +	stmmac_enable_dma_reception(priv, priv->ioaddr, queue);
>  }
>  
>  static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
> 
> ---
> base-commit: e3daf0e7fe9758613bec324fd606ed9caa187f74
> change-id: 20251125-a10_ext_fix-5951805b9906
> 
> Best regards,


