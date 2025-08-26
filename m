Return-Path: <netdev+bounces-216864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113EDB358F2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0672A1899926
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D5F23D7C7;
	Tue, 26 Aug 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wbZmprk2"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5456393DCA;
	Tue, 26 Aug 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200667; cv=none; b=HKQ7wCk9jhwQ4Nxu5WBpFUQQ4Vd4LVeiehoKPhVTd16z1tU6IthOTtGpnWTkfItY/rt4QcLyNG2x3qIcfPQWYSCkWUoxkj5VKauMmaB2UKxbB+bYSFAi5TPxJ2mXqMCIt/1Twmxe8m9hwjv9V3HxLmMcLEzb7wmtKiRtJROwiOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200667; c=relaxed/simple;
	bh=leHKkqb/0n2GK8S/i5rR/4vR044JN40o2bSSxMQafxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ubga0tBvS9Z99EBZhhJsideEje7wCkaW6h6c77cM03wW/mFuE/5bye5L5YEttT6QSG0UPVBVi+pyOssynFuvTtbDWG0JsHXTXfxF7x19LxrvG4Xq0I7nyYMcvXHFm07xNaex3wfZfO91apxyiGFrQjWAaF/l3GjBZxqXTYAgxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wbZmprk2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756200662; x=1787736662;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=leHKkqb/0n2GK8S/i5rR/4vR044JN40o2bSSxMQafxM=;
  b=wbZmprk2Ycyz/7VpZa2zuqq2CRM4HezPApAXhJhDJKqwLALjajHX0YzT
   WxTP1yaLl44PrgIDOp6QQoGpTvsnJRdcjFfb1EFcjk6yXBkAlsxShcLZl
   L3HwKFf0h/2D7pXyulEY0Hu/uVvitNYd1lP7U/LA/EVIfxOe+pfDbRNRp
   eGzqei/sChkrwwoxjpBce9puG/y8uyaCDpeK9/OqcOGkKJ6jki0ybb/TB
   MnhAqVVZHJn7wFWV4mlTH+WhKUyfjbevg271x0DYWk8cGf8R1o0Td2XVl
   p02apR+aYsG0AalGxNHr1OsrB8Fd3M4GF1FkM58u8pLFoP+v5wLzh45gT
   A==;
X-CSE-ConnectionGUID: +J9wGsIaTyWt1cmEqfr09w==
X-CSE-MsgGUID: 2kxjsAuKSAa9L/BqhS45uQ==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="213075367"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Aug 2025 02:31:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 26 Aug 2025 02:30:55 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 26 Aug 2025 02:30:52 -0700
Message-ID: <2eedec51-d773-4a3f-a936-4752d768702a@microchip.com>
Date: Tue, 26 Aug 2025 11:30:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 3/5] net: macb: move ring size computation to
 functions
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
	<thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
 <20250820-macb-fixes-v4-3-23c399429164@bootlin.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250820-macb-fixes-v4-3-23c399429164@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/2025 at 16:55, Théo Lebrun wrote:
> The tx/rx ring size calculation is somewhat complex and partially hidden
> behind a macro. Move that out of the {RX,TX}_RING_BYTES() macros and
> macb_{alloc,free}_consistent() functions into neat separate functions.

I agree.

> In macb_free_consistent(), we drop the size variable and directly call
> the size helpers in the arguments list. In macb_alloc_consistent(), we
> keep the size variable that is used by netdev_dbg() calls.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/net/ethernet/cadence/macb_main.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 69325665c766927797ca2e1eb1384105bcde3cb5..d413e8bd4977187fd73f7cc48268baf933aab051 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -51,14 +51,10 @@ struct sifive_fu540_macb_mgmt {
>   #define DEFAULT_RX_RING_SIZE   512 /* must be power of 2 */
>   #define MIN_RX_RING_SIZE       64
>   #define MAX_RX_RING_SIZE       8192
> -#define RX_RING_BYTES(bp)      (macb_dma_desc_get_size(bp)     \
> -                                * (bp)->rx_ring_size)
> 
>   #define DEFAULT_TX_RING_SIZE   512 /* must be power of 2 */
>   #define MIN_TX_RING_SIZE       64
>   #define MAX_TX_RING_SIZE       4096
> -#define TX_RING_BYTES(bp)      (macb_dma_desc_get_size(bp)     \
> -                                * (bp)->tx_ring_size)
> 
>   /* level of occupied TX descriptors under which we wake up TX process */
>   #define MACB_TX_WAKEUP_THRESH(bp)      (3 * (bp)->tx_ring_size / 4)
> @@ -2466,11 +2462,20 @@ static void macb_free_rx_buffers(struct macb *bp)
>          }
>   }
> 
> +static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
> +{
> +       return macb_dma_desc_get_size(bp) * bp->tx_ring_size + bp->tx_bd_rd_prefetch;
> +}
> +
> +static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
> +{
> +       return macb_dma_desc_get_size(bp) * bp->rx_ring_size + bp->rx_bd_rd_prefetch;
> +}
> +
>   static void macb_free_consistent(struct macb *bp)
>   {
>          struct macb_queue *queue;
>          unsigned int q;
> -       int size;
> 
>          if (bp->rx_ring_tieoff) {
>                  dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
> @@ -2484,14 +2489,14 @@ static void macb_free_consistent(struct macb *bp)
>                  kfree(queue->tx_skb);
>                  queue->tx_skb = NULL;
>                  if (queue->tx_ring) {
> -                       size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
> -                       dma_free_coherent(&bp->pdev->dev, size,
> +                       dma_free_coherent(&bp->pdev->dev,
> +                                         macb_tx_ring_size_per_queue(bp),
>                                            queue->tx_ring, queue->tx_ring_dma);
>                          queue->tx_ring = NULL;
>                  }
>                  if (queue->rx_ring) {
> -                       size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
> -                       dma_free_coherent(&bp->pdev->dev, size,
> +                       dma_free_coherent(&bp->pdev->dev,
> +                                         macb_rx_ring_size_per_queue(bp),
>                                            queue->rx_ring, queue->rx_ring_dma);
>                          queue->rx_ring = NULL;
>                  }
> @@ -2542,7 +2547,7 @@ static int macb_alloc_consistent(struct macb *bp)
>          int size;
> 
>          for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
> -               size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
> +               size = macb_tx_ring_size_per_queue(bp);
>                  queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
>                                                      &queue->tx_ring_dma,
>                                                      GFP_KERNEL);
> @@ -2560,7 +2565,7 @@ static int macb_alloc_consistent(struct macb *bp)
>                  if (!queue->tx_skb)
>                          goto out_err;
> 
> -               size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
> +               size = macb_rx_ring_size_per_queue(bp);
>                  queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
>                                                      &queue->rx_ring_dma,
>                                                      GFP_KERNEL);
> 
> --
> 2.50.1
> 


