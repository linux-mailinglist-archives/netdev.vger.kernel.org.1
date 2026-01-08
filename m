Return-Path: <netdev+bounces-248134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A5D042AC
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E215231B0D7F
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61882777EA;
	Thu,  8 Jan 2026 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lKVKw12E"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE47D29BDA0
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887035; cv=none; b=L+fMKzcn4PagpsVlzU70HJ+OnAk4QatUJNOCiVou6eNIdx41x5QDJzAGIdxpXEd/d8t89IKRlJto5j/8zRmnSOOF39WhcY7rPDd5/WsuTYI4pGe8keJ4UeQN9F12A9R2IB7drdQQpg+cWEDJ/Q16JvjfAsOR3M+VXJLQjwfKSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887035; c=relaxed/simple;
	bh=CWVJ5gXyj3Oy58JMeBfi4VgWEWWoxoJDa7ZSFbliu7Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=K89uKTAONHApsZq6lfad7YtFk7dLVoKa/JzrgGWi+kUV6zqw8tqTOJ4EPOv1BqBSfzu4Zcvb9E7jotrddNrgYoVbTh2srN7PkEqcUmIbZsh8Bx/LS2wEpvhabU4cD4mC7vpFQxhyZmQLzo80gtibn4pcOriB+JOehARca5mQHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lKVKw12E; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 30EC8C1ECB5;
	Thu,  8 Jan 2026 15:43:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 601EE6072B;
	Thu,  8 Jan 2026 15:43:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1FA1A103C88A4;
	Thu,  8 Jan 2026 16:43:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767887027; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Fq1ItO8iayYq6k+I2GMwljKrGLaTjIFJPtGBhVnl42U=;
	b=lKVKw12EiNwinowfX51GpkRd5/lQvir1W42aXwGC3y/CSU+LSEA0ryp3oNHegLuR1uYmYk
	81GcLsU2D+oc4QWZc0EVwd8QiT8iCbdr3HVmSPKGddQ+rBH0ItX6Sx5CxRySdfb5TXMpUo
	IHy7K8f3xvhZTTSQMXUtBkUtYhGzaog8Y0rihhQoCDgAoIKYvwuMtEYpA5BriA33YfAMpQ
	kfETSac7wTij7ifbFr2PHy0r9jbM+75SUkRcqdiiLG2NZWblYX7pPSVcd2CehRVl0zDdD4
	Q2SptTdR0+Jb5hmuKZWU/BvfYWmnA1bfxrE85My+h/pKVe27GCe+L/VEpnJbjA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Jan 2026 16:43:43 +0100
Message-Id: <DFJBNAK0H1KV.1HVW5GR7V4Q2B@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 3/8] cadence: macb: Add page pool
 support handle multi-descriptor frame rx
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251220235135.1078587-1-pvalerio@redhat.com>
 <20251220235135.1078587-4-pvalerio@redhat.com>
In-Reply-To: <20251220235135.1078587-4-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sun Dec 21, 2025 at 12:51 AM CET, Paolo Valerio wrote:
> Use the page pool allocator for the data buffers and enable skb recycling
> support, instead of relying on netdev_alloc_skb allocating the entire skb
> during the refill.
>
> The patch also add support for receiving network frames that span multipl=
e
> DMA descriptors in the Cadence MACB/GEM Ethernet driver.
>
> The patch removes the requirement that limited frame reception to
> a single descriptor (RX_SOF && RX_EOF), also avoiding potential
> contiguous multi-page allocation for large frames.
>
> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
> ---
>  drivers/net/ethernet/cadence/Kconfig     |   1 +
>  drivers/net/ethernet/cadence/macb.h      |   5 +
>  drivers/net/ethernet/cadence/macb_main.c | 345 +++++++++++++++--------
>  3 files changed, 235 insertions(+), 116 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/=
cadence/Kconfig
> index 5b2a461dfd28..ae500f717433 100644
> --- a/drivers/net/ethernet/cadence/Kconfig
> +++ b/drivers/net/ethernet/cadence/Kconfig
> @@ -25,6 +25,7 @@ config MACB
>  	depends on PTP_1588_CLOCK_OPTIONAL
>  	select PHYLINK
>  	select CRC32
> +	select PAGE_POOL
>  	help
>  	  The Cadence MACB ethernet interface is found on many Atmel AT32 and
>  	  AT91 parts.  This driver also supports the Cadence GEM (Gigabit
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/c=
adence/macb.h
> index 3b184e9ac771..45c04157f153 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -14,6 +14,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/phy/phy.h>
>  #include <linux/workqueue.h>
> +#include <net/page_pool/helpers.h>
> +#include <net/xdp.h>

nit: `#include <net/xdp.h>` is not needed yet.

> =20
>  #define MACB_GREGS_NBR 16
>  #define MACB_GREGS_VERSION 2
> @@ -1266,6 +1268,8 @@ struct macb_queue {
>  	void			*rx_buffers;
>  	struct napi_struct	napi_rx;
>  	struct queue_stats stats;
> +	struct page_pool	*page_pool;
> +	struct sk_buff		*skb;
>  };
> =20
>  struct ethtool_rx_fs_item {
> @@ -1289,6 +1293,7 @@ struct macb {
>  	struct macb_dma_desc	*rx_ring_tieoff;
>  	dma_addr_t		rx_ring_tieoff_dma;
>  	size_t			rx_buffer_size;
> +	size_t			rx_headroom;
> =20
>  	unsigned int		rx_ring_size;
>  	unsigned int		tx_ring_size;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index b4e2444b2e95..9e1efc1f56d8 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1249,14 +1249,22 @@ static int macb_tx_complete(struct macb_queue *qu=
eue, int budget)
>  	return packets;
>  }
> =20
> -static int gem_rx_refill(struct macb_queue *queue)
> +static int gem_total_rx_buffer_size(struct macb *bp)
> +{
> +	return SKB_HEAD_ALIGN(bp->rx_buffer_size + bp->rx_headroom);
> +}

nit: something closer to a buffer size, either `unsigned int` or
`size_t`, sounds better than an int return type.

> +
> +static int gem_rx_refill(struct macb_queue *queue, bool napi)
>  {
>  	unsigned int		entry;
> -	struct sk_buff		*skb;
>  	dma_addr_t		paddr;
> +	void			*data;
>  	struct macb *bp =3D queue->bp;
>  	struct macb_dma_desc *desc;
> +	struct page *page;
> +	gfp_t gfp_alloc;
>  	int err =3D 0;
> +	int offset;
> =20
>  	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
>  			bp->rx_ring_size) > 0) {
> @@ -1268,25 +1276,20 @@ static int gem_rx_refill(struct macb_queue *queue=
)
>  		desc =3D macb_rx_desc(queue, entry);
> =20
>  		if (!queue->rx_buff[entry]) {
> -			/* allocate sk_buff for this free entry in ring */
> -			skb =3D netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
> -			if (unlikely(!skb)) {
> +			gfp_alloc =3D napi ? GFP_ATOMIC : GFP_KERNEL;
> +			page =3D page_pool_alloc_frag(queue->page_pool, &offset,
> +						    gem_total_rx_buffer_size(bp),
> +						    gfp_alloc | __GFP_NOWARN);
> +			if (!page) {
>  				netdev_err(bp->dev,
> -					   "Unable to allocate sk_buff\n");
> +					   "Unable to allocate page\n");
>  				err =3D -ENOMEM;
>  				break;
>  			}
> =20
> -			/* now fill corresponding descriptor entry */
> -			paddr =3D dma_map_single(&bp->pdev->dev, skb->data,
> -					       bp->rx_buffer_size,
> -					       DMA_FROM_DEVICE);
> -			if (dma_mapping_error(&bp->pdev->dev, paddr)) {
> -				dev_kfree_skb(skb);
> -				break;
> -			}
> -
> -			queue->rx_buff[entry] =3D skb;
> +			paddr =3D page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM + offset=
;
> +			data =3D page_address(page) + offset;
> +			queue->rx_buff[entry] =3D data;
> =20
>  			if (entry =3D=3D bp->rx_ring_size - 1)
>  				paddr |=3D MACB_BIT(RX_WRAP);
> @@ -1296,20 +1299,6 @@ static int gem_rx_refill(struct macb_queue *queue)
>  			 */
>  			dma_wmb();
>  			macb_set_addr(bp, desc, paddr);
> -
> -			/* Properly align Ethernet header.
> -			 *
> -			 * Hardware can add dummy bytes if asked using the RBOF
> -			 * field inside the NCFGR register. That feature isn't
> -			 * available if hardware is RSC capable.
> -			 *
> -			 * We cannot fallback to doing the 2-byte shift before
> -			 * DMA mapping because the address field does not allow
> -			 * setting the low 2/3 bits.
> -			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
> -			 */
> -			if (!(bp->caps & MACB_CAPS_RSC))
> -				skb_reserve(skb, NET_IP_ALIGN);
>  		} else {
>  			desc->ctrl =3D 0;
>  			dma_wmb();
> @@ -1353,14 +1342,19 @@ static int gem_rx(struct macb_queue *queue, struc=
t napi_struct *napi,
>  	struct macb *bp =3D queue->bp;
>  	unsigned int		len;
>  	unsigned int		entry;
> -	struct sk_buff		*skb;
>  	struct macb_dma_desc	*desc;
> +	int			data_len;
>  	int			count =3D 0;
> +	void			*buff_head;
> +	struct skb_shared_info	*shinfo;
> +	struct page		*page;
> +	int			nr_frags;

nit: you add 5 new stack variables, maybe you could apply reverse xmas
tree while at it. You do it for the loop body in [5/8].

> +
> =20
>  	while (count < budget) {
>  		u32 ctrl;
>  		dma_addr_t addr;
> -		bool rxused;
> +		bool rxused, first_frame;
> =20
>  		entry =3D macb_rx_ring_wrap(bp, queue->rx_tail);
>  		desc =3D macb_rx_desc(queue, entry);
> @@ -1374,6 +1368,12 @@ static int gem_rx(struct macb_queue *queue, struct=
 napi_struct *napi,
>  		if (!rxused)
>  			break;
> =20
> +		if (!(bp->caps & MACB_CAPS_RSC))
> +			addr +=3D NET_IP_ALIGN;
> +
> +		dma_sync_single_for_cpu(&bp->pdev->dev,
> +					addr, bp->rx_buffer_size,
> +					page_pool_get_dma_dir(queue->page_pool));
>  		/* Ensure ctrl is at least as up-to-date as rxused */
>  		dma_rmb();
> =20
> @@ -1382,58 +1382,118 @@ static int gem_rx(struct macb_queue *queue, stru=
ct napi_struct *napi,
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
> -		skb =3D queue->rx_buff[entry];
> -		if (unlikely(!skb)) {
> +		buff_head =3D queue->rx_buff[entry];
> +		if (unlikely(!buff_head)) {
>  			netdev_err(bp->dev,
>  				   "inconsistent Rx descriptor chain\n");
>  			bp->dev->stats.rx_dropped++;
>  			queue->stats.rx_dropped++;
>  			break;
>  		}
> -		/* now everything is ready for receiving packet */
> -		queue->rx_buff[entry] =3D NULL;
> +
> +		first_frame =3D ctrl & MACB_BIT(RX_SOF);
>  		len =3D ctrl & bp->rx_frm_len_mask;
> =20
> -		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
> +		if (len) {
> +			data_len =3D len;
> +			if (!first_frame)
> +				data_len -=3D queue->skb->len;
> +		} else {
> +			data_len =3D bp->rx_buffer_size;
> +		}

Why deal with the `!len` case? How can it occur? User guide doesn't hint
that. It would mean we would grab uninitialised bytes as we assume len
is the max buffer size.

> +
> +		if (first_frame) {
> +			queue->skb =3D napi_build_skb(buff_head, gem_total_rx_buffer_size(bp)=
);
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
> +			skb_reserve(queue->skb, bp->rx_headroom);
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
> +
> +			shinfo =3D skb_shinfo(queue->skb);
> +			page =3D virt_to_head_page(buff_head);
> +			nr_frags =3D shinfo->nr_frags;
> +
> +			if (nr_frags >=3D ARRAY_SIZE(shinfo->frags))
> +				goto free_frags;
> =20
> -		skb_put(skb, len);
> -		dma_unmap_single(&bp->pdev->dev, addr,
> -				 bp->rx_buffer_size, DMA_FROM_DEVICE);
> +			skb_add_rx_frag(queue->skb, nr_frags, page,
> +					buff_head - page_address(page) + bp->rx_headroom,
> +					data_len, gem_total_rx_buffer_size(bp));
> +		}
> +
> +		/* now everything is ready for receiving packet */
> +		queue->rx_buff[entry] =3D NULL;
> =20
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
> +			print_hex_dump(KERN_DEBUG, "buff_head: ", DUMP_PREFIX_ADDRESS, 16, 1,
> +				       queue->skb->buff_head, 32, true);
>  #endif

nit: while you are at it, maybe replace with print_hex_dump_debug()?

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
> +						virt_to_head_page(buff_head),
> +						false);
> +		}
> +
> +		bp->dev->stats.rx_dropped++;
> +		queue->stats.rx_dropped++;
> +		queue->rx_buff[entry] =3D NULL;
>  	}
> =20
> -	gem_rx_refill(queue);
> +	gem_rx_refill(queue, true);
> =20
>  	return count;
>  }
> @@ -2367,12 +2427,25 @@ static netdev_tx_t macb_start_xmit(struct sk_buff=
 *skb, struct net_device *dev)
>  	return ret;
>  }
> =20
> -static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
> +static void macb_init_rx_buffer_size(struct macb *bp, unsigned int mtu)
>  {
> +	int overhead;

nit: Maybe `unsigned int` or `size_t` rather than `int`?

> +	size_t size;
> +
>  	if (!macb_is_gem(bp)) {
>  		bp->rx_buffer_size =3D MACB_RX_BUFFER_SIZE;
>  	} else {
> -		bp->rx_buffer_size =3D size;
> +		size =3D mtu + ETH_HLEN + ETH_FCS_LEN;
> +		if (!(bp->caps & MACB_CAPS_RSC))
> +			size +=3D NET_IP_ALIGN;

NET_IP_ALIGN looks like it is accounted for twice, once in
bp->rx_headroom and once in bp->rx_buffer_size. This gets fixed in
[5/8] where gem_max_rx_data_size() gets introduced.

> +
> +		bp->rx_buffer_size =3D SKB_DATA_ALIGN(size);
> +		if (gem_total_rx_buffer_size(bp) > PAGE_SIZE) {
> +			overhead =3D bp->rx_headroom +
> +				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +			bp->rx_buffer_size =3D rounddown(PAGE_SIZE - overhead,
> +						       RX_BUFFER_MULTIPLE);
> +		}

I've seen your comment in [0/8]. Do you have any advice on how to test
this clamping? All I can think of is to either configure a massive MTU
or, more easily, cheat with the headroom.

Also, should we warn? It means MTU-sized packets will be received in
fragments. It will work but is probably unexpected by users and a
slowdown reason that users might want to know about.

--

nit: while in macb_init_rx_buffer_size(), can you tweak the debug line
from mtu & rx_buffer_size to also have rx_headroom and total? So that
we have everything available to understand what is going on buffer size
wise. Something like:

-       netdev_dbg(bp->dev, "mtu [%u] rx_buffer_size [%zu]\n",
-                  bp->dev->mtu, bp->rx_buffer_size);
+       netdev_info(bp->dev, "mtu [%u] rx_buffer_size [%zu] rx_headroom [%z=
u] total [%u]\n",
+                   bp->dev->mtu, bp->rx_buffer_size, bp->rx_headroom,
+                   gem_total_rx_buffer_size(bp));

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


