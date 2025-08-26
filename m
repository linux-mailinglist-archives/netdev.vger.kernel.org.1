Return-Path: <netdev+bounces-216863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7725B358DA
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D95E168182
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239EA2FDC22;
	Tue, 26 Aug 2025 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="l8+OreqH"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A0629ACDB;
	Tue, 26 Aug 2025 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200481; cv=none; b=CUpSmBiuw1HJIQtb8yqWsM7prNR9VG5aZkfiedU8k60aZBnR4DOHSz17tqOeiVXiueUosT/w8id+/1AipwjM9eTHK0k5oEpnymrXv8DYX9bP8JdgSt5PKrEUE746kVSiBgai9CBmkZb/vq/mUqnMRa/HJu3SgXlf43D4dTTTYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200481; c=relaxed/simple;
	bh=I2yhGHVhERBe7uNdR16HUj2j56kAwXIRLmWhj3vFdYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kM7z4Cl70N+y3h/09NQU9lcoUE5rur0Jzf4mtj0xk6dl6bo2p6gX02oMHUvZK4SWWTEGqvRQ6/PkWFh/zHpg3phaAc54BfoNseK5+S+O3Dsqpv1xwdwzR4sthk1t+djy4Bm3ZXnocVBCIiwqU7f0tHkBZgG2hPWGmPePOqU2gDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=l8+OreqH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756200479; x=1787736479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I2yhGHVhERBe7uNdR16HUj2j56kAwXIRLmWhj3vFdYM=;
  b=l8+OreqHkLxHnnkkW07uKEBRgcgd/01a8hoLpckCZmlsgKU60HdhFhqO
   p2sjap9UQ+NqrRXjJetrhzeV4XdrHgroNPa0Kp2cWu2wafd4zaHmzTaeO
   kHK6foRp3oBmkrtdpArASaNYWaIBwmpFiVQfn3XRAuU0URBsbIPsQQpzB
   xsBncwcTt/Kmd3D42JGsoc/7RqjyVU79mCayxSWaPDY7iM83lQxEme9KJ
   CUCB7I3NIBYmATd46L7kjwMaLBuDyQJZSQv3aPGupYCINza6kveX7NI54
   WdCPz5pEV/ckfd8ePK5QohyWMfYvH1ynSqrdPzjzHZvGNtxUMJeWx8h0T
   w==;
X-CSE-ConnectionGUID: HPcLko+0T12Lr7BpqvofZA==
X-CSE-MsgGUID: FHJWgdLpQe2L+nuMAQg2QA==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="45654231"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2025 02:27:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 26 Aug 2025 02:27:26 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 26 Aug 2025 02:27:23 -0700
Message-ID: <8a97b5a0-d21e-431b-9b4e-5f73960becdb@microchip.com>
Date: Tue, 26 Aug 2025 11:27:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/5] net: macb: remove illusion about TBQPH/RBQPH
 being per-queue
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Geert Uytterhoeven <geert@linux-m68k.org>, Harini
 Katakam <harini.katakam@xilinx.com>, Richard Cochran
	<richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Sean Anderson <sean.anderson@linux.dev>
References: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
 <20250820-macb-fixes-v4-2-23c399429164@bootlin.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250820-macb-fixes-v4-2-23c399429164@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/2025 at 16:55, Théo Lebrun wrote:
> The MACB driver acts as if TBQPH/RBQPH are configurable on a per queue
> basis; this is a lie. A single register configures the upper 32 bits of
> each DMA descriptor buffers for all queues.
> 
> Concrete actions:
> 
>   - Drop GEM_TBQPH/GEM_RBQPH macros which have a queue index argument.
>     Only use MACB_TBQPH/MACB_RBQPH constants.
> 
>   - Drop struct macb_queue->TBQPH/RBQPH fields.
> 
>   - In macb_init_buffers(): do a single write to TBQPH and RBQPH for all
>     queues instead of a write per queue.
> 
>   - In macb_tx_error_task(): drop the write to TBQPH.
> 
>   - In macb_alloc_consistent(): if allocations give different upper
>     32-bits, fail. Previously, it would have lead to silent memory
>     corruption as queues would have used the upper 32 bits of the alloc
>     from queue 0 and their own low 32 bits.
> 
>   - In macb_suspend(): if we use the tie off descriptor for suspend, do
>     the write once for all queues instead of once per queue.

Indeed, agreed.

> Fixes: fff8019a08b6 ("net: macb: Add 64 bit addressing support for GEM")
> Fixes: ae1f2a56d273 ("net: macb: Added support for many RX queues")
> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Théo, best regards,
   Nicolas

> ---
>   drivers/net/ethernet/cadence/macb.h      |  4 ---
>   drivers/net/ethernet/cadence/macb_main.c | 57 ++++++++++++++------------------
>   2 files changed, 24 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index c9a5c8beb2fa8166195d1d83f187d2d0c62668a8..a7e845fee4b3a2e3d14abb49abdbaf3e8e6ea02b 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -213,10 +213,8 @@
> 
>   #define GEM_ISR(hw_q)          (0x0400 + ((hw_q) << 2))
>   #define GEM_TBQP(hw_q)         (0x0440 + ((hw_q) << 2))
> -#define GEM_TBQPH(hw_q)                (0x04C8)
>   #define GEM_RBQP(hw_q)         (0x0480 + ((hw_q) << 2))
>   #define GEM_RBQS(hw_q)         (0x04A0 + ((hw_q) << 2))
> -#define GEM_RBQPH(hw_q)                (0x04D4)
>   #define GEM_IER(hw_q)          (0x0600 + ((hw_q) << 2))
>   #define GEM_IDR(hw_q)          (0x0620 + ((hw_q) << 2))
>   #define GEM_IMR(hw_q)          (0x0640 + ((hw_q) << 2))
> @@ -1214,10 +1212,8 @@ struct macb_queue {
>          unsigned int            IDR;
>          unsigned int            IMR;
>          unsigned int            TBQP;
> -       unsigned int            TBQPH;
>          unsigned int            RBQS;
>          unsigned int            RBQP;
> -       unsigned int            RBQPH;
> 
>          /* Lock to protect tx_head and tx_tail */
>          spinlock_t              tx_ptr_lock;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ce95fad8cedd7331d4818ba9f73fb6970249e85c..69325665c766927797ca2e1eb1384105bcde3cb5 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -495,19 +495,19 @@ static void macb_init_buffers(struct macb *bp)
>          struct macb_queue *queue;
>          unsigned int q;
> 
> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +       /* Single register for all queues' high 32 bits. */
> +       if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
> +               macb_writel(bp, RBQPH,
> +                           upper_32_bits(bp->queues[0].rx_ring_dma));
> +               macb_writel(bp, TBQPH,
> +                           upper_32_bits(bp->queues[0].tx_ring_dma));
> +       }
> +#endif
> +
>          for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>                  queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
> -#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> -               if (bp->hw_dma_cap & HW_DMA_CAP_64B)
> -                       queue_writel(queue, RBQPH,
> -                                    upper_32_bits(queue->rx_ring_dma));
> -#endif
>                  queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
> -#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> -               if (bp->hw_dma_cap & HW_DMA_CAP_64B)
> -                       queue_writel(queue, TBQPH,
> -                                    upper_32_bits(queue->tx_ring_dma));
> -#endif
>          }
>   }
> 
> @@ -1166,10 +1166,6 @@ static void macb_tx_error_task(struct work_struct *work)
> 
>          /* Reinitialize the TX desc queue */
>          queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
> -#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> -       if (bp->hw_dma_cap & HW_DMA_CAP_64B)
> -               queue_writel(queue, TBQPH, upper_32_bits(queue->tx_ring_dma));
> -#endif
>          /* Make TX ring reflect state of hardware */
>          queue->tx_head = 0;
>          queue->tx_tail = 0;
> @@ -2542,6 +2538,7 @@ static int macb_alloc_consistent(struct macb *bp)
>   {
>          struct macb_queue *queue;
>          unsigned int q;
> +       u32 upper;
>          int size;
> 
>          for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> @@ -2549,7 +2546,9 @@ static int macb_alloc_consistent(struct macb *bp)
>                  queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
>                                                      &queue->tx_ring_dma,
>                                                      GFP_KERNEL);
> -               if (!queue->tx_ring)
> +               upper = upper_32_bits(queue->tx_ring_dma);
> +               if (!queue->tx_ring ||
> +                   upper != upper_32_bits(bp->queues[0].tx_ring_dma))
>                          goto out_err;
>                  netdev_dbg(bp->dev,
>                             "Allocated TX ring for queue %u of %d bytes at %08lx (mapped %p)\n",
> @@ -2563,8 +2562,11 @@ static int macb_alloc_consistent(struct macb *bp)
> 
>                  size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
>                  queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
> -                                                &queue->rx_ring_dma, GFP_KERNEL);
> -               if (!queue->rx_ring)
> +                                                   &queue->rx_ring_dma,
> +                                                   GFP_KERNEL);
> +               upper = upper_32_bits(queue->rx_ring_dma);
> +               if (!queue->rx_ring ||
> +                   upper != upper_32_bits(bp->queues[0].rx_ring_dma))
>                          goto out_err;
>                  netdev_dbg(bp->dev,
>                             "Allocated RX ring of %d bytes at %08lx (mapped %p)\n",
> @@ -4305,12 +4307,6 @@ static int macb_init(struct platform_device *pdev)
>                          queue->TBQP = GEM_TBQP(hw_q - 1);
>                          queue->RBQP = GEM_RBQP(hw_q - 1);
>                          queue->RBQS = GEM_RBQS(hw_q - 1);
> -#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> -                       if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
> -                               queue->TBQPH = GEM_TBQPH(hw_q - 1);
> -                               queue->RBQPH = GEM_RBQPH(hw_q - 1);
> -                       }
> -#endif
>                  } else {
>                          /* queue0 uses legacy registers */
>                          queue->ISR  = MACB_ISR;
> @@ -4319,12 +4315,6 @@ static int macb_init(struct platform_device *pdev)
>                          queue->IMR  = MACB_IMR;
>                          queue->TBQP = MACB_TBQP;
>                          queue->RBQP = MACB_RBQP;
> -#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> -                       if (bp->hw_dma_cap & HW_DMA_CAP_64B) {
> -                               queue->TBQPH = MACB_TBQPH;
> -                               queue->RBQPH = MACB_RBQPH;
> -                       }
> -#endif
>                  }
> 
>                  /* get irq: here we use the linux queue index, not the hardware
> @@ -5450,6 +5440,11 @@ static int __maybe_unused macb_suspend(struct device *dev)
>                   */
>                  tmp = macb_readl(bp, NCR);
>                  macb_writel(bp, NCR, tmp & ~(MACB_BIT(TE) | MACB_BIT(RE)));
> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +               if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
> +                       macb_writel(bp, RBQPH,
> +                                   upper_32_bits(bp->rx_ring_tieoff_dma));
> +#endif
>                  for (q = 0, queue = bp->queues; q < bp->num_queues;
>                       ++q, ++queue) {
>                          /* Disable RX queues */
> @@ -5459,10 +5454,6 @@ static int __maybe_unused macb_suspend(struct device *dev)
>                                  /* Tie off RX queues */
>                                  queue_writel(queue, RBQP,
>                                               lower_32_bits(bp->rx_ring_tieoff_dma));
> -#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> -                               queue_writel(queue, RBQPH,
> -                                            upper_32_bits(bp->rx_ring_tieoff_dma));
> -#endif
>                          }
>                          /* Disable all interrupts */
>                          queue_writel(queue, IDR, -1);
> 
> --
> 2.50.1
> 


