Return-Path: <netdev+bounces-216976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FBCB36DA9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 17:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC3E7A993F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1139A27467F;
	Tue, 26 Aug 2025 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pV7Kxrwi"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B602701B1;
	Tue, 26 Aug 2025 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221866; cv=none; b=m4aOSZje+kBW1xBjRltW1Q6G6B4+EyVDkiS2EeZObRQDDT+NHsXKabDF7XGVZhPzW5DhoOBOK7uADs4uzBOY+JuoXgwh3XvbV9iTORS0IuvmaVGznbDtX+iqBLMdSbub1kwh/kjo/UGWzAKnP0PLqnLxYUMjyqVFUFB9LdSCXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221866; c=relaxed/simple;
	bh=4q/Ro7ZgXCV5mMoZl1m9B3B75aym6pb7Rqjp32Hj+aQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=DZge6tqw/U1csvUQ4N72xLej0JcgkJt+Srq8ROd9H5924Qd6O2Y64oTPP3F+Z9gcjmEfOcYImG263f7TCNcXm5tiB8/C8vGQZctJjQmUPzAu3IN4aM7byTUooL0ru9a6cgOxgKK93Qqdesm1/vOQKI74RDdsodV0cm9ZK7NiIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pV7Kxrwi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756221864; x=1787757864;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=4q/Ro7ZgXCV5mMoZl1m9B3B75aym6pb7Rqjp32Hj+aQ=;
  b=pV7Kxrwi4jLQkDGkXJ6//EY+WNg7hFisOCPngX62TY1zOalu/QNYupYC
   mCDs+RgNuv90xh2wir4pt2SPfv4xu8S/TmhtPdjdQHBYkz+HoN9i3BaID
   ZZFRrwk6CH5AkvImPQPtYaO5FO7eCAg6ugPjwxQDnlb0nVfSMGn+46MUW
   n+Td4a/HlzkoG210wVTmtGKO8xT1weOiceqzbuoSO3PbwLNMbhWqsH3fC
   fgkgUHuWt2k0STUmMIOmj+9gsCIAENuLcsTxwcItH3p1HL9Zb34AkvgAX
   VL8M3rv7P15kMQ2ly3zLoPMekCC267atHbzGB2M+hO7V5lg/c5hxJFfgA
   Q==;
X-CSE-ConnectionGUID: cqTEly2STb6W85yqGPE9tw==
X-CSE-MsgGUID: 69vNB5feRI6VqwsfNf06ng==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="51293750"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2025 08:24:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 26 Aug 2025 08:23:52 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 26 Aug 2025 08:23:49 -0700
Message-ID: <010e0551-58b8-4b61-8ad7-2f03ecc6baa3@microchip.com>
Date: Tue, 26 Aug 2025 17:23:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH net v4 4/5] net: macb: single dma_alloc_coherent() for DMA
 descriptors
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
 <20250820-macb-fixes-v4-4-23c399429164@bootlin.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250820-macb-fixes-v4-4-23c399429164@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/2025 at 16:55, Théo Lebrun wrote:
> Move from 2*NUM_QUEUES dma_alloc_coherent() for DMA descriptor rings to
> 2 calls overall.
> 
> Issue is with how all queues share the same register for configuring the
> upper 32-bits of Tx/Rx descriptor rings. Taking Tx, notice how TBQPH
> does *not* depend on the queue index:
> 
>          #define GEM_TBQP(hw_q)          (0x0440 + ((hw_q) << 2))
>          #define GEM_TBQPH(hw_q)         (0x04C8)
> 
>          queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
>          #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>          if (bp->hw_dma_cap & HW_DMA_CAP_64B)
>                  queue_writel(queue, TBQPH, upper_32_bits(queue->tx_ring_dma));
>          #endif
> 
> To maximise our chances of getting valid DMA addresses, we do a single
> dma_alloc_coherent() across queues. This improves the odds because
> alloc_pages() guarantees natural alignment. Other codepaths (IOMMU or
> dev/arch dma_map_ops) don't give high enough guarantees
> (even page-aligned isn't enough).
> 
> Two consideration:
> 
>   - dma_alloc_coherent() gives us page alignment. Here we remove this
>     constraint meaning each queue's ring won't be page-aligned anymore.

However... We must guarantee alignement depending on the controller's 
bus width (32 or 64 bits)... but being page aligned and having 
descriptors multiple of 64 bits anyway, we're good for each descriptor 
(might be worth explicitly adding).

> 
>   - This can save some tiny amounts of memory. Fewer allocations means
>     (1) less overhead (constant cost per alloc) and (2) less wasted bytes
>     due to alignment constraints.
> 
>     Example for (2): 4 queues, default ring size (512), 64-bit DMA
>     descriptors, 16K pages:
>      - Before: 8 allocs of 8K, each rounded to 16K => 64K wasted.
>      - After:  2 allocs of 32K => 0K wasted.
> 
> Fixes: 02c958dd3446 ("net/macb: add TX multiqueue support for gem")
> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com> # on sam9x75


> ---
>   drivers/net/ethernet/cadence/macb_main.c | 80 ++++++++++++++++----------------
>   1 file changed, 41 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index d413e8bd4977187fd73f7cc48268baf933aab051..7f31f264a6d342ea01e2f61944b12c9b9a3fe66e 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2474,32 +2474,30 @@ static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
> 
>   static void macb_free_consistent(struct macb *bp)
>   {
> +       struct device *dev = &bp->pdev->dev;
>          struct macb_queue *queue;
>          unsigned int q;
> +       size_t size;
> 
>          if (bp->rx_ring_tieoff) {
> -               dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
> +               dma_free_coherent(dev, macb_dma_desc_get_size(bp),
>                                    bp->rx_ring_tieoff, bp->rx_ring_tieoff_dma);
>                  bp->rx_ring_tieoff = NULL;
>          }
> 
>          bp->macbgem_ops.mog_free_rx_buffers(bp);
> 
> +       size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
> +       dma_free_coherent(dev, size, bp->queues[0].tx_ring, bp->queues[0].tx_ring_dma);
> +
> +       size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
> +       dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
> +
>          for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>                  kfree(queue->tx_skb);
>                  queue->tx_skb = NULL;
> -               if (queue->tx_ring) {
> -                       dma_free_coherent(&bp->pdev->dev,
> -                                         macb_tx_ring_size_per_queue(bp),
> -                                         queue->tx_ring, queue->tx_ring_dma);
> -                       queue->tx_ring = NULL;
> -               }
> -               if (queue->rx_ring) {
> -                       dma_free_coherent(&bp->pdev->dev,
> -                                         macb_rx_ring_size_per_queue(bp),
> -                                         queue->rx_ring, queue->rx_ring_dma);
> -                       queue->rx_ring = NULL;
> -               }
> +               queue->tx_ring = NULL;
> +               queue->rx_ring = NULL;
>          }
>   }
> 
> @@ -2541,41 +2539,45 @@ static int macb_alloc_rx_buffers(struct macb *bp)
> 
>   static int macb_alloc_consistent(struct macb *bp)
>   {
> +       struct device *dev = &bp->pdev->dev;
> +       dma_addr_t tx_dma, rx_dma;
>          struct macb_queue *queue;
>          unsigned int q;
> -       u32 upper;
> -       int size;
> +       void *tx, *rx;
> +       size_t size;
> +
> +       /*
> +        * Upper 32-bits of Tx/Rx DMA descriptor for each queues much match!
> +        * We cannot enforce this guarantee, the best we can do is do a single
> +        * allocation and hope it will land into alloc_pages() that guarantees
> +        * natural alignment of physical addresses.
> +        */
> +
> +       size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
> +       tx = dma_alloc_coherent(dev, size, &tx_dma, GFP_KERNEL);
> +       if (!tx || upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
> +               goto out_err;
> +       netdev_dbg(bp->dev, "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
> +                  size, bp->num_queues, (unsigned long)tx_dma, tx);
> +
> +       size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
> +       rx = dma_alloc_coherent(dev, size, &rx_dma, GFP_KERNEL);
> +       if (!rx || upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
> +               goto out_err;
> +       netdev_dbg(bp->dev, "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
> +                  size, bp->num_queues, (unsigned long)rx_dma, rx);
> 
>          for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> -               size = macb_tx_ring_size_per_queue(bp);
> -               queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
> -                                                   &queue->tx_ring_dma,
> -                                                   GFP_KERNEL);
> -               upper = upper_32_bits(queue->tx_ring_dma);
> -               if (!queue->tx_ring ||
> -                   upper != upper_32_bits(bp->queues[0].tx_ring_dma))
> -                       goto out_err;
> -               netdev_dbg(bp->dev,
> -                          "Allocated TX ring for queue %u of %d bytes at %08lx (mapped %p)\n",
> -                          q, size, (unsigned long)queue->tx_ring_dma,
> -                          queue->tx_ring);
> +               queue->tx_ring = tx + macb_tx_ring_size_per_queue(bp) * q;
> +               queue->tx_ring_dma = tx_dma + macb_tx_ring_size_per_queue(bp) * q;
> +
> +               queue->rx_ring = rx + macb_rx_ring_size_per_queue(bp) * q;
> +               queue->rx_ring_dma = rx_dma + macb_rx_ring_size_per_queue(bp) * q;
> 
>                  size = bp->tx_ring_size * sizeof(struct macb_tx_skb);
>                  queue->tx_skb = kmalloc(size, GFP_KERNEL);
>                  if (!queue->tx_skb)
>                          goto out_err;
> -
> -               size = macb_rx_ring_size_per_queue(bp);
> -               queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
> -                                                   &queue->rx_ring_dma,
> -                                                   GFP_KERNEL);
> -               upper = upper_32_bits(queue->rx_ring_dma);
> -               if (!queue->rx_ring ||
> -                   upper != upper_32_bits(bp->queues[0].rx_ring_dma))
> -                       goto out_err;
> -               netdev_dbg(bp->dev,
> -                          "Allocated RX ring of %d bytes at %08lx (mapped %p)\n",
> -                          size, (unsigned long)queue->rx_ring_dma, queue->rx_ring);
>          }
>          if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
>                  goto out_err;
> 
> --
> 2.50.1
> 


