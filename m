Return-Path: <netdev+bounces-241603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 457DAC866EA
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02B8934EFC8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D932C333;
	Tue, 25 Nov 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2MT85Y8W"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE8F32C93B;
	Tue, 25 Nov 2025 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093957; cv=none; b=XphZuKqStmpO7RNMwY2OryUv+zTZx4I0X7VHDpp9YTzETzyNgE1bgFyoSYKYCTencIQVOW4X0eP/lWFXVQhXazO9ky90vqBz1Qxi24IGwkfta5hGm6H11LdINOOvhCzwlKumIhW1l2pQfEUm8VbCatZDpUPJsZD2sszms+fHKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093957; c=relaxed/simple;
	bh=5U/S5kssDGyaZEH+ttQKL5xYLbM+ySOM7z6cUAiJ8Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fR0VT6w9Q3QMpsB5UChmFiQigmbmugjM0sY++i5vjryukpfqZ3mrHdVAv8DfeP25J47WJd5Xrjk11Po0N/8SHKIcNjSFJ1xqL2n27USptf2PYlFPKtPfaLg1GEdAU0Xzc8QUjXl8eGJRF6odCX65XAJYRUE6cDYDzdyH7ac/XzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2MT85Y8W; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B748E4E418B9;
	Tue, 25 Nov 2025 18:05:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 83FEF606A1;
	Tue, 25 Nov 2025 18:05:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C31A102F08B4;
	Tue, 25 Nov 2025 19:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764093951; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=lp+Mc2LjVyhDfZiwstCaChFpHcgAv27Nujzsi0u4HYw=;
	b=2MT85Y8WbOH/m30D+UIp0mzIxbW0XIkxpgaKXoqNFqVjl+uJrbiMolxTm7BkcQ8ICAOtDc
	lQoeSqDR/N+HxoZohW3agU9D8VRYd6MpLCAtXB1t82kHFtzMgcR8s9cE8U+o3Jclhgl1Ot
	iRjxhH/2dY/9lyEZLceMytSCQ2THl5kCZmcWNIV3ehsEFcyBEi011lxuFp6cnQQIvE2EjI
	Ijcd30oQ6zCON1gSoZMHi052SrixULQ2AUvBuzAQGpp6vPIKCPQTcQnssJVwknWhJcngGx
	PPTWJEAFiKTJ6Z6Wa16J+lFLf5ZwMvUJuNF745DCtiAlv/iCGHKIetdBzZFPaA==
Message-ID: <bcfcfcb1-33d3-4e03-95c7-565f6a76f3d8@bootlin.com>
Date: Tue, 25 Nov 2025 19:05:47 +0100
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

Hi,

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

I'll let others comment on the correctness of the dwmac1000 part, but
still :

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

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


