Return-Path: <netdev+bounces-242295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91022C8E707
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1080F343022
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF23B1E0B9C;
	Thu, 27 Nov 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gSw2ayDf"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4E17A2E0
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249723; cv=none; b=AhoTpKZZB33O6qmKuGPCHTbzcqmlo6mzGxo00NyaneP69xA9y/xeVRtewC2eDR6PGoPgUqULy3x7eMDQmkTKHvm1AVbR/dhrGxwsBpk0Sj2bXuAezv0iV5vuRaM8ZAKG+G2IxI/9t47GBrW94XCc3AlKX3ZJlFqMMefwYph9JHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249723; c=relaxed/simple;
	bh=38i99MzDfb2hhc5uhaJfl6AdBxfYXsbw5xwaKcjC06Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=XYg5fuTjCLI+BVvT31kfvUMvsABQB/rSm2lHasfEJeCYW7a1fsdo+X8ZmLOo+0admcLg8GlFO/akY0w+0WP3V76vrtZbiLmIdA1ue30C0YEExr5qTGwGOXodo+TLT+D2Xw5BDhDJ+8P8YzCkv43njXi/AeNdo47cY+9vsGu0WzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gSw2ayDf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6050F1A1DBF;
	Thu, 27 Nov 2025 13:21:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2887B6068C;
	Thu, 27 Nov 2025 13:21:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8946102F2767;
	Thu, 27 Nov 2025 14:21:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764249716; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8mr4wjVmWLd6MFjWI29nQzZAl05whLdZX6g5CnHvI8A=;
	b=gSw2ayDfYGgb8bm3ucDbcn64ETy1l0IRvjlRN43IxbbAMFWTpucRj9c5Zzh0GtJOcAtYWo
	3eZqDAl9+ecOcHGiAuBdacm9HfXYT17IjZfZicT/XA+kbDmqwAmkyWomvJ3JrfFtKWEAsu
	fLJ3BkQ9x2IDyWi1UySoqKrujPGxoPRZ8yVRmxeUk/1wJmHrVy+rkVdXVzbw+I/E3MuznA
	kh7oKuHKkqcjCUEfSL8pZyq73f/aJlXKNwDN4urxra5HqdjepvBjMXM5LdoQ3FcXnvonm3
	kcSjl8Zd8gtZtrEBOO1g0g7fclfQnIkxaXsEcEcvXoRXtTN4f0HRRYSn5LBUbg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Nov 2025 14:21:52 +0100
Message-Id: <DEJIBSTL1UKX.2IQYBHZMHS65O@bootlin.com>
Subject: Re: [PATCH RFC net-next 1/6] cadence: macb/gem: Add page pool
 support
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-2-pvalerio@redhat.com>
In-Reply-To: <20251119135330.551835-2-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Paolo,

On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
> Subject: [PATCH RFC net-next 1/6] cadence: macb/gem: Add page pool suppor=
t

`git log --oneline drivers/net/ethernet/cadence/` tells us all commits
in this series should be prefixed with "net: macb: ".

> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/c=
adence/macb.h
> index 87414a2ddf6e..dcf768bd1bc1 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -14,6 +14,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/phy/phy.h>
>  #include <linux/workqueue.h>
> +#include <net/page_pool/helpers.h>
> +#include <net/xdp.h>
> =20
>  #define MACB_GREGS_NBR 16
>  #define MACB_GREGS_VERSION 2
> @@ -957,6 +959,10 @@ struct macb_dma_desc_ptp {
>  /* Scaled PPM fraction */
>  #define PPM_FRACTION	16
> =20
> +/* The buf includes headroom compatible with both skb and xdpf */
> +#define MACB_PP_HEADROOM		XDP_PACKET_HEADROOM
> +#define MACB_PP_MAX_BUF_SIZE(num)	(((num) * PAGE_SIZE) - MACB_PP_HEADROO=
M)

From my previous review, you know I think MACB_PP_MAX_BUF_SIZE() should
disappear.

I also don't see the point of MACB_PP_HEADROOM. Maybe if it was
max(XDP_PACKET_HEADROOM, NET_SKB_PAD) it would be more useful, but that
isn't useful anyway. Can we drop it and use XDP_PACKET_HEADROOM directly
in the code?

>  /* struct macb_tx_skb - data about an skb which is being transmitted
>   * @skb: skb currently being transmitted, only set for the last buffer
>   *       of the frame
> @@ -1262,10 +1268,11 @@ struct macb_queue {
>  	unsigned int		rx_tail;
>  	unsigned int		rx_prepared_head;
>  	struct macb_dma_desc	*rx_ring;
> -	struct sk_buff		**rx_skbuff;
> +	void			**rx_buff;

It would help review if the s/rx_skbuff/rx_buff/ renaming was done in a
separate commit with a commit message being "this only renames X and
implies no functional changes".

>  	void			*rx_buffers;
>  	struct napi_struct	napi_rx;
>  	struct queue_stats stats;
> +	struct page_pool	*page_pool;
>  };
> =20
>  struct ethtool_rx_fs_item {
> @@ -1289,6 +1296,7 @@ struct macb {
>  	struct macb_dma_desc	*rx_ring_tieoff;
>  	dma_addr_t		rx_ring_tieoff_dma;
>  	size_t			rx_buffer_size;
> +	u16			rx_offset;

u16 makes me worried that we might do mistakes. For example the
following propagates the u16 type.

        bp->rx_offset + data - page_address(page)

We can spare the additional 6 bytes and turn it into a size_t. It'll
fall in holes anyway, at least it does for my target according to pahole.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index e461f5072884..985c81913ba6 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1250,11 +1250,28 @@ static int macb_tx_complete(struct macb_queue *qu=
eue, int budget)
>  	return packets;
>  }
> =20
> -static void gem_rx_refill(struct macb_queue *queue)
> +static void *gem_page_pool_get_buff(struct page_pool *pool,
> +				    dma_addr_t *dma_addr, gfp_t gfp_mask)
> +{
> +	struct page *page;
> +
> +	if (!pool)
> +		return NULL;
> +
> +	page =3D page_pool_alloc_pages(pool, gfp_mask | __GFP_NOWARN);
> +	if (!page)
> +		return NULL;
> +
> +	*dma_addr =3D page_pool_get_dma_addr(page) + MACB_PP_HEADROOM;
> +
> +	return page_address(page);
> +}

Do we need a separate function called from only one location? Or we
could change its name to highlight it allocates and does not just "get"
a buffer.

> @@ -1267,25 +1284,17 @@ static void gem_rx_refill(struct macb_queue *queu=
e)
> =20
>  		desc =3D macb_rx_desc(queue, entry);
> =20
> -		if (!queue->rx_skbuff[entry]) {
> +		if (!queue->rx_buff[entry]) {
>  			/* allocate sk_buff for this free entry in ring */
> -			skb =3D netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
> -			if (unlikely(!skb)) {
> +			data =3D gem_page_pool_get_buff(queue->page_pool, &paddr,
> +						      napi ? GFP_ATOMIC : GFP_KERNEL);

I don't get why the gfp flags computation is spread across
gem_page_pool_get_buff() and gem_rx_refill().

> @@ -1349,12 +1344,16 @@ static int gem_rx(struct macb_queue *queue, struc=
t napi_struct *napi,
>  		  int budget)
>  {
>  	struct macb *bp =3D queue->bp;
> +	int			buffer_size;
>  	unsigned int		len;
>  	unsigned int		entry;
> +	void			*data;
>  	struct sk_buff		*skb;
>  	struct macb_dma_desc	*desc;
>  	int			count =3D 0;
> =20
> +	buffer_size =3D DIV_ROUND_UP(bp->rx_buffer_size, PAGE_SIZE) * PAGE_SIZE=
;

This looks like

        buffer_size =3D ALIGN(bp->rx_buffer_size, PAGE_SIZE);

no? Anyway I think it should be dropped. It does get dropped next patch
in this RFC.

> @@ -1387,24 +1386,49 @@ static int gem_rx(struct macb_queue *queue, struc=
t napi_struct *napi,
>  			queue->stats.rx_dropped++;
>  			break;
>  		}
> -		skb =3D queue->rx_skbuff[entry];
> -		if (unlikely(!skb)) {
> +		data =3D queue->rx_buff[entry];
> +		if (unlikely(!data)) {
>  			netdev_err(bp->dev,
>  				   "inconsistent Rx descriptor chain\n");
>  			bp->dev->stats.rx_dropped++;
>  			queue->stats.rx_dropped++;
>  			break;
>  		}
> +
> +		skb =3D napi_build_skb(data, buffer_size);
> +		if (unlikely(!skb)) {
> +			netdev_err(bp->dev,
> +				   "Unable to allocate sk_buff\n");
> +			page_pool_put_full_page(queue->page_pool,
> +						virt_to_head_page(data),
> +						false);
> +			break;

We should `queue->rx_skbuff[entry] =3D NULL` here no?
We free a page and keep a pointer to it.

> +		}
> +
> +		/* Properly align Ethernet header.
> +		 *
> +		 * Hardware can add dummy bytes if asked using the RBOF
> +		 * field inside the NCFGR register. That feature isn't
> +		 * available if hardware is RSC capable.
> +		 *
> +		 * We cannot fallback to doing the 2-byte shift before
> +		 * DMA mapping because the address field does not allow
> +		 * setting the low 2/3 bits.
> +		 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
> +		 */
> +		skb_reserve(skb, bp->rx_offset);
> +		skb_mark_for_recycle(skb);

I have a platform with RSC support and NET_IP_ALIGN=3D2. What is yours
like? It'd be nice if we can test different cases of this RBOF topic.

>  		/* now everything is ready for receiving packet */
> -		queue->rx_skbuff[entry] =3D NULL;
> +		queue->rx_buff[entry] =3D NULL;
>  		len =3D ctrl & bp->rx_frm_len_mask;
> =20
>  		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
> =20
> +		dma_sync_single_for_cpu(&bp->pdev->dev,
> +					addr, len,
> +					page_pool_get_dma_dir(queue->page_pool));

Any reason for the call to dma_sync_single_for_cpu(), we could hardcode
it to DMA_FROM_DEVICE no?

> @@ -2477,13 +2497,13 @@ static int gem_alloc_rx_buffers(struct macb *bp)
> =20
>  	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) {
>  		size =3D bp->rx_ring_size * sizeof(struct sk_buff *);

sizeof is called with the wrong type. Not that it matters because
pointers are pointers, but we can take this opportunity to move to

        sizeof(*queue->rx_buff)

> -		queue->rx_skbuff =3D kzalloc(size, GFP_KERNEL);
> -		if (!queue->rx_skbuff)
> +		queue->rx_buff =3D kzalloc(size, GFP_KERNEL);
> +		if (!queue->rx_buff)
>  			return -ENOMEM;
>  		else
>  			netdev_dbg(bp->dev,
> -				   "Allocated %d RX struct sk_buff entries at %p\n",
> -				   bp->rx_ring_size, queue->rx_skbuff);
> +				   "Allocated %d RX buff entries at %p\n",
> +				   bp->rx_ring_size, queue->rx_buff);

Opportunity to deindent this block?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


