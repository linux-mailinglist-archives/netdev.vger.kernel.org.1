Return-Path: <netdev+bounces-242300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A68C8E818
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3B63B07B8
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D35827703C;
	Thu, 27 Nov 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sdenKurl"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4724429A1
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250736; cv=none; b=CFp0vuWEToxb294n5EjCkXZs97JT+PBkg63fOXRbSrIxMz27Y+GllMm/qv8omiV/WTG73LcjukAuG6LX9Kcp4MYyK93zOKT6shOMmWsJlhjDAjzEpqoSAqrbs1DFuB/ZxX3r8jMxNhfRR/abwWncJvQHxuJ/mW1LvpGlngYSCzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250736; c=relaxed/simple;
	bh=iAqOVwWgKogsbyIZ/QF1R7BcAXoHbhzeYKOSqFVOshs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=g8oqvD+ZQJsUuNT4PjnHTacLFTXf5SZdHox/UweLGbQ25p15WhpICD19GudJNmPK3m/wVyQ1ZsaZUv4fhL/pD89Z5TwrxNjmQUtL5LLuyCkYz96tfskhAoi4llWQdvKWuQ0Fkh63wGO1wUDi21Nn0oFxceUbDopt0s/ss0Shq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sdenKurl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3CF4D1A1DC3;
	Thu, 27 Nov 2025 13:38:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 097396068C;
	Thu, 27 Nov 2025 13:38:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C1F9102F2772;
	Thu, 27 Nov 2025 14:38:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764250728; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gOuN+UVPz8uRQd/4TeqkfCBVMWkoXElH/Mjy8DKgOaE=;
	b=sdenKurlrQZQMtqPW727ezGElHd6uCu+lsDvh2T20MiDgpgmE+fpH8xjO/xUaomPxHXy0c
	mD3aEF9w43Xqvlt8yoWUoUmiESp6Gro9FrLpb6LAKxmVxtYbmw4+LNR2N0lEKzLXe0pPJD
	/f3dQvgEdx3ryDDEhvoVAL3SObE8lrqqNFVXhgdYNbBzpNjT/2c0PpwnBnI8nSntdUIcYt
	4j5Mll266SV6h8AmDM67Xg51WQITKdl7NqASj3cf5y4Nfj5wDazueA5nBR77KXDN+Hj2zz
	zbIaak9UnneFmA7RJ0vXQiy3Y+kIop2UcYTpDNP15EVX+VByuB329Kg/AYriKA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Nov 2025 14:38:45 +0100
Message-Id: <DEJIOQFT9I2J.16KSODWK6IH6L@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next 2/6] cadence: macb/gem: handle
 multi-descriptor frame reception
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-3-pvalerio@redhat.com>
In-Reply-To: <20251119135330.551835-3-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
> Add support for receiving network frames that span multiple DMA
> descriptors in the Cadence MACB/GEM Ethernet driver.
>
> The patch removes the requirement that limited frame reception to
> a single descriptor (RX_SOF && RX_EOF), also avoiding potential
> contiguous multi-page allocation for large frames. It also uses
> page pool fragments allocation instead of full page for saving
> memory.
>
> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |   4 +-
>  drivers/net/ethernet/cadence/macb_main.c | 180 ++++++++++++++---------
>  2 files changed, 111 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/c=
adence/macb.h
> index dcf768bd1bc1..e2f397b7a27f 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -960,8 +960,7 @@ struct macb_dma_desc_ptp {
>  #define PPM_FRACTION	16
> =20
>  /* The buf includes headroom compatible with both skb and xdpf */
> -#define MACB_PP_HEADROOM		XDP_PACKET_HEADROOM
> -#define MACB_PP_MAX_BUF_SIZE(num)	(((num) * PAGE_SIZE) - MACB_PP_HEADROO=
M)
> +#define MACB_PP_HEADROOM	XDP_PACKET_HEADROOM
> =20
>  /* struct macb_tx_skb - data about an skb which is being transmitted
>   * @skb: skb currently being transmitted, only set for the last buffer
> @@ -1273,6 +1272,7 @@ struct macb_queue {
>  	struct napi_struct	napi_rx;
>  	struct queue_stats stats;
>  	struct page_pool	*page_pool;
> +	struct sk_buff		*skb;
>  };
> =20
>  struct ethtool_rx_fs_item {
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 985c81913ba6..be0c8e101639 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1250,21 +1250,25 @@ static int macb_tx_complete(struct macb_queue *qu=
eue, int budget)
>  	return packets;
>  }
> =20
> -static void *gem_page_pool_get_buff(struct page_pool *pool,
> +static void *gem_page_pool_get_buff(struct  macb_queue *queue,
>  				    dma_addr_t *dma_addr, gfp_t gfp_mask)
>  {
> +	struct macb *bp =3D queue->bp;
>  	struct page *page;
> +	int offset;
> =20
> -	if (!pool)
> +	if (!queue->page_pool)
>  		return NULL;
> =20
> -	page =3D page_pool_alloc_pages(pool, gfp_mask | __GFP_NOWARN);
> +	page =3D page_pool_alloc_frag(queue->page_pool, &offset,
> +				    bp->rx_buffer_size,
> +				    gfp_mask | __GFP_NOWARN);
>  	if (!page)
>  		return NULL;
> =20
> -	*dma_addr =3D page_pool_get_dma_addr(page) + MACB_PP_HEADROOM;
> +	*dma_addr =3D page_pool_get_dma_addr(page) + MACB_PP_HEADROOM + offset;
> =20
> -	return page_address(page);
> +	return page_address(page) + offset;
>  }
> =20
>  static void gem_rx_refill(struct macb_queue *queue, bool napi)
> @@ -1286,7 +1290,7 @@ static void gem_rx_refill(struct macb_queue *queue,=
 bool napi)
> =20
>  		if (!queue->rx_buff[entry]) {
>  			/* allocate sk_buff for this free entry in ring */
> -			data =3D gem_page_pool_get_buff(queue->page_pool, &paddr,
> +			data =3D gem_page_pool_get_buff(queue, &paddr,
>  						      napi ? GFP_ATOMIC : GFP_KERNEL);
>  			if (unlikely(!data)) {
>  				netdev_err(bp->dev,
> @@ -1344,20 +1348,17 @@ static int gem_rx(struct macb_queue *queue, struc=
t napi_struct *napi,
>  		  int budget)
>  {
>  	struct macb *bp =3D queue->bp;
> -	int			buffer_size;
>  	unsigned int		len;
>  	unsigned int		entry;
>  	void			*data;
> -	struct sk_buff		*skb;
>  	struct macb_dma_desc	*desc;
> +	int			data_len;
>  	int			count =3D 0;
> =20
> -	buffer_size =3D DIV_ROUND_UP(bp->rx_buffer_size, PAGE_SIZE) * PAGE_SIZE=
;
> -
>  	while (count < budget) {
>  		u32 ctrl;
>  		dma_addr_t addr;
> -		bool rxused;
> +		bool rxused, first_frame;
> =20
>  		entry =3D macb_rx_ring_wrap(bp, queue->rx_tail);
>  		desc =3D macb_rx_desc(queue, entry);
> @@ -1368,6 +1369,9 @@ static int gem_rx(struct macb_queue *queue, struct =
napi_struct *napi,
>  		rxused =3D (desc->addr & MACB_BIT(RX_USED)) ? true : false;
>  		addr =3D macb_get_addr(bp, desc);
> =20
> +		dma_sync_single_for_cpu(&bp->pdev->dev,
> +					addr, bp->rx_buffer_size - bp->rx_offset,
> +					page_pool_get_dma_dir(queue->page_pool));

page_pool_get_dma_dir() will always return the same value, we could
hardcode it.

>  		if (!rxused)
>  			break;
> =20
> @@ -1379,13 +1383,6 @@ static int gem_rx(struct macb_queue *queue, struct=
 napi_struct *napi,
>  		queue->rx_tail++;
>  		count++;
> =20
> -		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
> -			netdev_err(bp->dev,
> -				   "not whole frame pointed by descriptor\n");
> -			bp->dev->stats.rx_dropped++;
> -			queue->stats.rx_dropped++;
> -			break;
> -		}
>  		data =3D queue->rx_buff[entry];
>  		if (unlikely(!data)) {
>  			netdev_err(bp->dev,
> @@ -1395,64 +1392,102 @@ static int gem_rx(struct macb_queue *queue, stru=
ct napi_struct *napi,
>  			break;
>  		}
> =20
> -		skb =3D napi_build_skb(data, buffer_size);
> -		if (unlikely(!skb)) {
> -			netdev_err(bp->dev,
> -				   "Unable to allocate sk_buff\n");
> -			page_pool_put_full_page(queue->page_pool,
> -						virt_to_head_page(data),
> -						false);
> -			break;
> +		first_frame =3D ctrl & MACB_BIT(RX_SOF);
> +		len =3D ctrl & bp->rx_frm_len_mask;
> +
> +		if (len) {
> +			data_len =3D len;
> +			if (!first_frame)
> +				data_len -=3D queue->skb->len;
> +		} else {
> +			data_len =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
>  		}
> =20
> -		/* Properly align Ethernet header.
> -		 *
> -		 * Hardware can add dummy bytes if asked using the RBOF
> -		 * field inside the NCFGR register. That feature isn't
> -		 * available if hardware is RSC capable.
> -		 *
> -		 * We cannot fallback to doing the 2-byte shift before
> -		 * DMA mapping because the address field does not allow
> -		 * setting the low 2/3 bits.
> -		 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
> -		 */
> -		skb_reserve(skb, bp->rx_offset);
> -		skb_mark_for_recycle(skb);
> +		if (first_frame) {
> +			queue->skb =3D napi_build_skb(data, bp->rx_buffer_size);
> +			if (unlikely(!queue->skb)) {
> +				netdev_err(bp->dev,
> +					   "Unable to allocate sk_buff\n");
> +				goto free_frags;
> +			}
> +
> +			/* Properly align Ethernet header.
> +			 *
> +			 * Hardware can add dummy bytes if asked using the RBOF
> +			 * field inside the NCFGR register. That feature isn't
> +			 * available if hardware is RSC capable.
> +			 *
> +			 * We cannot fallback to doing the 2-byte shift before
> +			 * DMA mapping because the address field does not allow
> +			 * setting the low 2/3 bits.
> +			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
> +			 */
> +			skb_reserve(queue->skb, bp->rx_offset);
> +			skb_mark_for_recycle(queue->skb);
> +			skb_put(queue->skb, data_len);
> +			queue->skb->protocol =3D eth_type_trans(queue->skb, bp->dev);
> +
> +			skb_checksum_none_assert(queue->skb);
> +			if (bp->dev->features & NETIF_F_RXCSUM &&
> +			    !(bp->dev->flags & IFF_PROMISC) &&
> +			    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
> +				queue->skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +		} else {
> +			if (!queue->skb) {
> +				netdev_err(bp->dev,
> +					   "Received non-starting frame while expecting it\n");
> +				goto free_frags;
> +			}

Here as well we want `queue->rx_buff[entry] =3D NULL;` no?
Maybe put it in the free_frags codepath to ensure it isn't forgotten?

> +			struct skb_shared_info *shinfo =3D skb_shinfo(queue->skb);
> +			struct page *page =3D virt_to_head_page(data);
> +			int nr_frags =3D shinfo->nr_frags;

Variable definitions in the middle of a scope? I think it is acceptable
when using __attribute__((cleanup)) but otherwise not so much (yet).

> +			if (nr_frags >=3D ARRAY_SIZE(shinfo->frags))
> +				goto free_frags;
> +
> +			skb_add_rx_frag(queue->skb, nr_frags, page,
> +					data - page_address(page) + bp->rx_offset,
> +					data_len, bp->rx_buffer_size);
> +		}
> =20
>  		/* now everything is ready for receiving packet */
>  		queue->rx_buff[entry] =3D NULL;
> -		len =3D ctrl & bp->rx_frm_len_mask;
> -
> -		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
> =20
> -		dma_sync_single_for_cpu(&bp->pdev->dev,
> -					addr, len,
> -					page_pool_get_dma_dir(queue->page_pool));
> -		skb_put(skb, len);
> -		skb->protocol =3D eth_type_trans(skb, bp->dev);
> -		skb_checksum_none_assert(skb);
> -		if (bp->dev->features & NETIF_F_RXCSUM &&
> -		    !(bp->dev->flags & IFF_PROMISC) &&
> -		    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
> -			skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
> =20
> -		bp->dev->stats.rx_packets++;
> -		queue->stats.rx_packets++;
> -		bp->dev->stats.rx_bytes +=3D skb->len;
> -		queue->stats.rx_bytes +=3D skb->len;
> +		if (ctrl & MACB_BIT(RX_EOF)) {
> +			bp->dev->stats.rx_packets++;
> +			queue->stats.rx_packets++;
> +			bp->dev->stats.rx_bytes +=3D queue->skb->len;
> +			queue->stats.rx_bytes +=3D queue->skb->len;
> =20
> -		gem_ptp_do_rxstamp(bp, skb, desc);
> +			gem_ptp_do_rxstamp(bp, queue->skb, desc);
> =20
>  #if defined(DEBUG) && defined(VERBOSE_DEBUG)
> -		netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
> -			    skb->len, skb->csum);
> -		print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
> -			       skb_mac_header(skb), 16, true);
> -		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
> -			       skb->data, 32, true);
> +			netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
> +				    queue->skb->len, queue->skb->csum);
> +			print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
> +				       skb_mac_header(queue->skb), 16, true);
> +			print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
> +				       queue->skb->data, 32, true);
>  #endif
> =20
> -		napi_gro_receive(napi, skb);
> +			napi_gro_receive(napi, queue->skb);
> +			queue->skb =3D NULL;
> +		}
> +
> +		continue;
> +
> +free_frags:
> +		if (queue->skb) {
> +			dev_kfree_skb(queue->skb);
> +			queue->skb =3D NULL;
> +		} else {
> +			page_pool_put_full_page(queue->page_pool,
> +						virt_to_head_page(data),
> +						false);
> +		}
>  	}
> =20
>  	gem_rx_refill(queue, true);
> @@ -2394,7 +2429,10 @@ static void macb_init_rx_buffer_size(struct macb *=
bp, size_t size)
>  	if (!macb_is_gem(bp)) {
>  		bp->rx_buffer_size =3D MACB_RX_BUFFER_SIZE;
>  	} else {
> -		bp->rx_buffer_size =3D size;
> +		bp->rx_buffer_size =3D size + SKB_DATA_ALIGN(sizeof(struct skb_shared_=
info))
> +			+ MACB_PP_HEADROOM;
> +		if (bp->rx_buffer_size > PAGE_SIZE)
> +			bp->rx_buffer_size =3D PAGE_SIZE;
> =20
>  		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
>  			netdev_dbg(bp->dev,
> @@ -2589,18 +2627,15 @@ static int macb_alloc_consistent(struct macb *bp)
> =20
>  static void gem_create_page_pool(struct macb_queue *queue)
>  {
> -	unsigned int num_pages =3D DIV_ROUND_UP(queue->bp->rx_buffer_size, PAGE=
_SIZE);
> -	struct macb *bp =3D queue->bp;
>  	struct page_pool_params pp_params =3D {
> -		.order =3D order_base_2(num_pages),
> +		.order =3D 0,
>  		.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>  		.pool_size =3D queue->bp->rx_ring_size,
>  		.nid =3D NUMA_NO_NODE,
>  		.dma_dir =3D DMA_FROM_DEVICE,
>  		.dev =3D &queue->bp->pdev->dev,
>  		.napi =3D &queue->napi_rx,
> -		.offset =3D bp->rx_offset,
> -		.max_len =3D MACB_PP_MAX_BUF_SIZE(num_pages),
> +		.max_len =3D PAGE_SIZE,
>  	};
>  	struct page_pool *pool;

I forgot about it in [PATCH 1/6], but the error handling if
gem_create_page_pool() fails is odd. We set queue->page_pool to NULL
and keep on going. Then once opened we'll fail allocating any buffer
but still be open. Shouldn't we fail the link up operation?

If we want to support this codepath (page pool not allocated), then we
should unmask Rx interrupts only if alloc succeeded. I don't know if
we'd want that though.

	queue_writel(queue, IER, bp->rx_intr_mask | ...);

> @@ -2784,8 +2819,9 @@ static void macb_configure_dma(struct macb *bp)
>  	unsigned int q;
>  	u32 dmacfg;
> =20
> -	buffer_size =3D bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
>  	if (macb_is_gem(bp)) {
> +		buffer_size =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
> +		buffer_size /=3D RX_BUFFER_MULTIPLE;
>  		dmacfg =3D gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
>  		for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) =
{
>  			if (q)
> @@ -2816,6 +2852,8 @@ static void macb_configure_dma(struct macb *bp)
>  		netdev_dbg(bp->dev, "Cadence configure DMA with 0x%08x\n",
>  			   dmacfg);
>  		gem_writel(bp, DMACFG, dmacfg);
> +	} else {
> +		buffer_size =3D bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
>  	}
>  }

You do:

static void macb_configure_dma(struct macb *bp)
{
	u32 buffer_size;

	if (macb_is_gem(bp)) {
		buffer_size =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
		buffer_size /=3D RX_BUFFER_MULTIPLE;
		// ... use buffer_size ...
	} else {
		buffer_size =3D bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
	}
}

Instead I'd vote for:

static void macb_configure_dma(struct macb *bp)
{
	u32 buffer_size;

	if (!macb_is_gem(bp))
		return;

	buffer_size =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
	buffer_size /=3D RX_BUFFER_MULTIPLE;
	// ... use buffer_size ...
}

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


