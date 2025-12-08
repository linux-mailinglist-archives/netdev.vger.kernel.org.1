Return-Path: <netdev+bounces-243988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FF3CACD7C
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 11:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2AF5301C96E
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 10:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9867A20B212;
	Mon,  8 Dec 2025 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gUAvfGQj"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1222D7A9
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189274; cv=none; b=Z0qCvfMzZoLio79k2zqZKOxq56vu5dgeC6XxSovlTdd4ivcqLQasn0YjD7xQHLvHamzTql7bJpqaGQEwkz8KOLs0yHivSYQhcWPS6nTH1RDMB+09N6OOceWs/sx+VYD+1heVx3ZckrdIEZQgY6SEFZTAjUMDCqg46EetKmTvWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189274; c=relaxed/simple;
	bh=BuD/eRLGIL1nUptR588WcR8uznpcpXiG+Q7N8DqJ540=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=TB9/WOkm6Mmi8AQ5KG+tldbflfLOzc2ZrUGJZzaPFbi5phfxDOl96sdjx4GqEI/YPbz1or+UTHXONKmpCneoaDY/hS1V2v8dWBujWFxCG6iwsc1xQ+OMTeGdsnjX0QxW0GU+TkowvJo4DLl4/0Oh5oevZiPoPLlgljRfgONx/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gUAvfGQj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2D0684E41AE5;
	Mon,  8 Dec 2025 10:21:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0199560707;
	Mon,  8 Dec 2025 10:21:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6525102F0A9C;
	Mon,  8 Dec 2025 11:21:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765189266; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0naU49eHqfY1aU7/FttUl1CzwY8XkE/WtGF4smHogq8=;
	b=gUAvfGQj9vLOkwQ6KBPrdYw4uAOyzmdSe+LjBqip+EZ/aQ0o8wzZ0ApFy1XdeCqZzMR6Gy
	nLzosMd88qkTJhgWwnD2Mc2LlojAKNCGxlyyWHBfsUAfV7QS1vN1AvLHjgERvDS+6CAV23
	vVu1QVr1wswiPPdvUCzd4qu2/2XKkOXISAwb9OclHXoqnz6K+HC5SXyJRpyq7JunznAfcl
	cf1H+V4LTki7B2IG1LzriJfgy9Zl0A9HPeb1R4/+PowExsm9R/Dj/cgDk+98S6h7QmCbOQ
	PpzNNVkPYzs/cFItqONj8ia6HYlmM6HJDPDKqNWIrWsmpbtenXYh4iOWaSyUBQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Dec 2025 11:21:00 +0100
Message-Id: <DESRDBL2FBUZ.3LXAM56K3CQV2@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next 2/6] cadence: macb/gem: handle
 multi-descriptor frame reception
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-3-pvalerio@redhat.com>
 <DEJIOQFT9I2J.16KSODWK6IH6L@bootlin.com> <87cy4wzt5x.fsf@redhat.com>
In-Reply-To: <87cy4wzt5x.fsf@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Paolo, Th=C3=A9o, netdev,

On Tue Dec 2, 2025 at 6:32 PM CET, Paolo Valerio wrote:
> On 27 Nov 2025 at 02:38:45 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>=
 wrote:
>
>> On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
>>> Add support for receiving network frames that span multiple DMA
>>> descriptors in the Cadence MACB/GEM Ethernet driver.
>>>
>>> The patch removes the requirement that limited frame reception to
>>> a single descriptor (RX_SOF && RX_EOF), also avoiding potential
>>> contiguous multi-page allocation for large frames. It also uses
>>> page pool fragments allocation instead of full page for saving
>>> memory.
>>>
>>> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
>>> ---
>>>  drivers/net/ethernet/cadence/macb.h      |   4 +-
>>>  drivers/net/ethernet/cadence/macb_main.c | 180 ++++++++++++++---------
>>>  2 files changed, 111 insertions(+), 73 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet=
/cadence/macb.h
>>> index dcf768bd1bc1..e2f397b7a27f 100644
>>> --- a/drivers/net/ethernet/cadence/macb.h
>>> +++ b/drivers/net/ethernet/cadence/macb.h
>>> @@ -960,8 +960,7 @@ struct macb_dma_desc_ptp {
>>>  #define PPM_FRACTION	16
>>> =20
>>>  /* The buf includes headroom compatible with both skb and xdpf */
>>> -#define MACB_PP_HEADROOM		XDP_PACKET_HEADROOM
>>> -#define MACB_PP_MAX_BUF_SIZE(num)	(((num) * PAGE_SIZE) - MACB_PP_HEADR=
OOM)
>>> +#define MACB_PP_HEADROOM	XDP_PACKET_HEADROOM
>>> =20
>>>  /* struct macb_tx_skb - data about an skb which is being transmitted
>>>   * @skb: skb currently being transmitted, only set for the last buffer
>>> @@ -1273,6 +1272,7 @@ struct macb_queue {
>>>  	struct napi_struct	napi_rx;
>>>  	struct queue_stats stats;
>>>  	struct page_pool	*page_pool;
>>> +	struct sk_buff		*skb;
>>>  };
>>> =20
>>>  struct ethtool_rx_fs_item {
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
>>> index 985c81913ba6..be0c8e101639 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>> @@ -1250,21 +1250,25 @@ static int macb_tx_complete(struct macb_queue *=
queue, int budget)
>>>  	return packets;
>>>  }
>>> =20
>>> -static void *gem_page_pool_get_buff(struct page_pool *pool,
>>> +static void *gem_page_pool_get_buff(struct  macb_queue *queue,
>>>  				    dma_addr_t *dma_addr, gfp_t gfp_mask)
>>>  {
>>> +	struct macb *bp =3D queue->bp;
>>>  	struct page *page;
>>> +	int offset;
>>> =20
>>> -	if (!pool)
>>> +	if (!queue->page_pool)
>>>  		return NULL;
>>> =20
>>> -	page =3D page_pool_alloc_pages(pool, gfp_mask | __GFP_NOWARN);
>>> +	page =3D page_pool_alloc_frag(queue->page_pool, &offset,
>>> +				    bp->rx_buffer_size,
>>> +				    gfp_mask | __GFP_NOWARN);
>>>  	if (!page)
>>>  		return NULL;
>>> =20
>>> -	*dma_addr =3D page_pool_get_dma_addr(page) + MACB_PP_HEADROOM;
>>> +	*dma_addr =3D page_pool_get_dma_addr(page) + MACB_PP_HEADROOM + offse=
t;
>>> =20
>>> -	return page_address(page);
>>> +	return page_address(page) + offset;
>>>  }
>>> =20
>>>  static void gem_rx_refill(struct macb_queue *queue, bool napi)
>>> @@ -1286,7 +1290,7 @@ static void gem_rx_refill(struct macb_queue *queu=
e, bool napi)
>>> =20
>>>  		if (!queue->rx_buff[entry]) {
>>>  			/* allocate sk_buff for this free entry in ring */
>>> -			data =3D gem_page_pool_get_buff(queue->page_pool, &paddr,
>>> +			data =3D gem_page_pool_get_buff(queue, &paddr,
>>>  						      napi ? GFP_ATOMIC : GFP_KERNEL);
>>>  			if (unlikely(!data)) {
>>>  				netdev_err(bp->dev,
>>> @@ -1344,20 +1348,17 @@ static int gem_rx(struct macb_queue *queue, str=
uct napi_struct *napi,
>>>  		  int budget)
>>>  {
>>>  	struct macb *bp =3D queue->bp;
>>> -	int			buffer_size;
>>>  	unsigned int		len;
>>>  	unsigned int		entry;
>>>  	void			*data;
>>> -	struct sk_buff		*skb;
>>>  	struct macb_dma_desc	*desc;
>>> +	int			data_len;
>>>  	int			count =3D 0;
>>> =20
>>> -	buffer_size =3D DIV_ROUND_UP(bp->rx_buffer_size, PAGE_SIZE) * PAGE_SI=
ZE;
>>> -
>>>  	while (count < budget) {
>>>  		u32 ctrl;
>>>  		dma_addr_t addr;
>>> -		bool rxused;
>>> +		bool rxused, first_frame;
>>> =20
>>>  		entry =3D macb_rx_ring_wrap(bp, queue->rx_tail);
>>>  		desc =3D macb_rx_desc(queue, entry);
>>> @@ -1368,6 +1369,9 @@ static int gem_rx(struct macb_queue *queue, struc=
t napi_struct *napi,
>>>  		rxused =3D (desc->addr & MACB_BIT(RX_USED)) ? true : false;
>>>  		addr =3D macb_get_addr(bp, desc);
>>> =20
>>> +		dma_sync_single_for_cpu(&bp->pdev->dev,
>>> +					addr, bp->rx_buffer_size - bp->rx_offset,
>>> +					page_pool_get_dma_dir(queue->page_pool));
>>
>> page_pool_get_dma_dir() will always return the same value, we could
>> hardcode it.
>>
>>>  		if (!rxused)
>>>  			break;
>>> =20
>>> @@ -1379,13 +1383,6 @@ static int gem_rx(struct macb_queue *queue, stru=
ct napi_struct *napi,
>>>  		queue->rx_tail++;
>>>  		count++;
>>> =20
>>> -		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
>>> -			netdev_err(bp->dev,
>>> -				   "not whole frame pointed by descriptor\n");
>>> -			bp->dev->stats.rx_dropped++;
>>> -			queue->stats.rx_dropped++;
>>> -			break;
>>> -		}
>>>  		data =3D queue->rx_buff[entry];
>>>  		if (unlikely(!data)) {
>>>  			netdev_err(bp->dev,
>>> @@ -1395,64 +1392,102 @@ static int gem_rx(struct macb_queue *queue, st=
ruct napi_struct *napi,
>>>  			break;
>>>  		}
>>> =20
>>> -		skb =3D napi_build_skb(data, buffer_size);
>>> -		if (unlikely(!skb)) {
>>> -			netdev_err(bp->dev,
>>> -				   "Unable to allocate sk_buff\n");
>>> -			page_pool_put_full_page(queue->page_pool,
>>> -						virt_to_head_page(data),
>>> -						false);
>>> -			break;
>>> +		first_frame =3D ctrl & MACB_BIT(RX_SOF);
>>> +		len =3D ctrl & bp->rx_frm_len_mask;
>>> +
>>> +		if (len) {
>>> +			data_len =3D len;
>>> +			if (!first_frame)
>>> +				data_len -=3D queue->skb->len;
>>> +		} else {
>>> +			data_len =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
>>>  		}
>>> =20
>>> -		/* Properly align Ethernet header.
>>> -		 *
>>> -		 * Hardware can add dummy bytes if asked using the RBOF
>>> -		 * field inside the NCFGR register. That feature isn't
>>> -		 * available if hardware is RSC capable.
>>> -		 *
>>> -		 * We cannot fallback to doing the 2-byte shift before
>>> -		 * DMA mapping because the address field does not allow
>>> -		 * setting the low 2/3 bits.
>>> -		 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
>>> -		 */
>>> -		skb_reserve(skb, bp->rx_offset);
>>> -		skb_mark_for_recycle(skb);
>>> +		if (first_frame) {
>>> +			queue->skb =3D napi_build_skb(data, bp->rx_buffer_size);
>>> +			if (unlikely(!queue->skb)) {
>>> +				netdev_err(bp->dev,
>>> +					   "Unable to allocate sk_buff\n");
>>> +				goto free_frags;
>>> +			}
>>> +
>>> +			/* Properly align Ethernet header.
>>> +			 *
>>> +			 * Hardware can add dummy bytes if asked using the RBOF
>>> +			 * field inside the NCFGR register. That feature isn't
>>> +			 * available if hardware is RSC capable.
>>> +			 *
>>> +			 * We cannot fallback to doing the 2-byte shift before
>>> +			 * DMA mapping because the address field does not allow
>>> +			 * setting the low 2/3 bits.
>>> +			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
>>> +			 */
>>> +			skb_reserve(queue->skb, bp->rx_offset);
>>> +			skb_mark_for_recycle(queue->skb);
>>> +			skb_put(queue->skb, data_len);
>>> +			queue->skb->protocol =3D eth_type_trans(queue->skb, bp->dev);
>>> +
>>> +			skb_checksum_none_assert(queue->skb);
>>> +			if (bp->dev->features & NETIF_F_RXCSUM &&
>>> +			    !(bp->dev->flags & IFF_PROMISC) &&
>>> +			    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
>>> +				queue->skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>>> +		} else {
>>> +			if (!queue->skb) {
>>> +				netdev_err(bp->dev,
>>> +					   "Received non-starting frame while expecting it\n");
>>> +				goto free_frags;
>>> +			}
>>
>> Here as well we want `queue->rx_buff[entry] =3D NULL;` no?
>> Maybe put it in the free_frags codepath to ensure it isn't forgotten?
>>
>
> That's correct, that slipped in this RFC.
>
>>> +			struct skb_shared_info *shinfo =3D skb_shinfo(queue->skb);
>>> +			struct page *page =3D virt_to_head_page(data);
>>> +			int nr_frags =3D shinfo->nr_frags;
>>
>> Variable definitions in the middle of a scope? I think it is acceptable
>> when using __attribute__((cleanup)) but otherwise not so much (yet).
>>
>
> I guess I simply forgot to move them.
> Ack for this and for the previous ones.
>
>>> +			if (nr_frags >=3D ARRAY_SIZE(shinfo->frags))
>>> +				goto free_frags;
>>> +
>>> +			skb_add_rx_frag(queue->skb, nr_frags, page,
>>> +					data - page_address(page) + bp->rx_offset,
>>> +					data_len, bp->rx_buffer_size);
>>> +		}
>>> =20
>>>  		/* now everything is ready for receiving packet */
>>>  		queue->rx_buff[entry] =3D NULL;
>>> -		len =3D ctrl & bp->rx_frm_len_mask;
>>> -
>>> -		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
>>> =20
>>> -		dma_sync_single_for_cpu(&bp->pdev->dev,
>>> -					addr, len,
>>> -					page_pool_get_dma_dir(queue->page_pool));
>>> -		skb_put(skb, len);
>>> -		skb->protocol =3D eth_type_trans(skb, bp->dev);
>>> -		skb_checksum_none_assert(skb);
>>> -		if (bp->dev->features & NETIF_F_RXCSUM &&
>>> -		    !(bp->dev->flags & IFF_PROMISC) &&
>>> -		    GEM_BFEXT(RX_CSUM, ctrl) & GEM_RX_CSUM_CHECKED_MASK)
>>> -			skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>>> +		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
>>> =20
>>> -		bp->dev->stats.rx_packets++;
>>> -		queue->stats.rx_packets++;
>>> -		bp->dev->stats.rx_bytes +=3D skb->len;
>>> -		queue->stats.rx_bytes +=3D skb->len;
>>> +		if (ctrl & MACB_BIT(RX_EOF)) {
>>> +			bp->dev->stats.rx_packets++;
>>> +			queue->stats.rx_packets++;
>>> +			bp->dev->stats.rx_bytes +=3D queue->skb->len;
>>> +			queue->stats.rx_bytes +=3D queue->skb->len;
>>> =20
>>> -		gem_ptp_do_rxstamp(bp, skb, desc);
>>> +			gem_ptp_do_rxstamp(bp, queue->skb, desc);
>>> =20
>>>  #if defined(DEBUG) && defined(VERBOSE_DEBUG)
>>> -		netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
>>> -			    skb->len, skb->csum);
>>> -		print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
>>> -			       skb_mac_header(skb), 16, true);
>>> -		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
>>> -			       skb->data, 32, true);
>>> +			netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
>>> +				    queue->skb->len, queue->skb->csum);
>>> +			print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
>>> +				       skb_mac_header(queue->skb), 16, true);
>>> +			print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
>>> +				       queue->skb->data, 32, true);
>>>  #endif
>>> =20
>>> -		napi_gro_receive(napi, skb);
>>> +			napi_gro_receive(napi, queue->skb);
>>> +			queue->skb =3D NULL;
>>> +		}
>>> +
>>> +		continue;
>>> +
>>> +free_frags:
>>> +		if (queue->skb) {
>>> +			dev_kfree_skb(queue->skb);
>>> +			queue->skb =3D NULL;
>>> +		} else {
>>> +			page_pool_put_full_page(queue->page_pool,
>>> +						virt_to_head_page(data),
>>> +						false);
>>> +		}
>>>  	}
>>> =20
>>>  	gem_rx_refill(queue, true);
>>> @@ -2394,7 +2429,10 @@ static void macb_init_rx_buffer_size(struct macb=
 *bp, size_t size)
>>>  	if (!macb_is_gem(bp)) {
>>>  		bp->rx_buffer_size =3D MACB_RX_BUFFER_SIZE;
>>>  	} else {
>>> -		bp->rx_buffer_size =3D size;
>>> +		bp->rx_buffer_size =3D size + SKB_DATA_ALIGN(sizeof(struct skb_share=
d_info))
>>> +			+ MACB_PP_HEADROOM;
>>> +		if (bp->rx_buffer_size > PAGE_SIZE)
>>> +			bp->rx_buffer_size =3D PAGE_SIZE;
>>> =20
>>>  		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
>>>  			netdev_dbg(bp->dev,
>>> @@ -2589,18 +2627,15 @@ static int macb_alloc_consistent(struct macb *b=
p)
>>> =20
>>>  static void gem_create_page_pool(struct macb_queue *queue)
>>>  {
>>> -	unsigned int num_pages =3D DIV_ROUND_UP(queue->bp->rx_buffer_size, PA=
GE_SIZE);
>>> -	struct macb *bp =3D queue->bp;
>>>  	struct page_pool_params pp_params =3D {
>>> -		.order =3D order_base_2(num_pages),
>>> +		.order =3D 0,
>>>  		.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>>>  		.pool_size =3D queue->bp->rx_ring_size,
>>>  		.nid =3D NUMA_NO_NODE,
>>>  		.dma_dir =3D DMA_FROM_DEVICE,
>>>  		.dev =3D &queue->bp->pdev->dev,
>>>  		.napi =3D &queue->napi_rx,
>>> -		.offset =3D bp->rx_offset,
>>> -		.max_len =3D MACB_PP_MAX_BUF_SIZE(num_pages),
>>> +		.max_len =3D PAGE_SIZE,
>>>  	};
>>>  	struct page_pool *pool;
>>
>> I forgot about it in [PATCH 1/6], but the error handling if
>> gem_create_page_pool() fails is odd. We set queue->page_pool to NULL
>> and keep on going. Then once opened we'll fail allocating any buffer
>> but still be open. Shouldn't we fail the link up operation?
>>
>> If we want to support this codepath (page pool not allocated), then we
>> should unmask Rx interrupts only if alloc succeeded. I don't know if
>> we'd want that though.
>>
>> 	queue_writel(queue, IER, bp->rx_intr_mask | ...);
>>
>
> Makes sense to fail the link up.
> Doesn't this imply to move the page pool creation and refill into
> macb_open()?
>
> I didn't look into it, I'm not sure if this can potentially become a
> bigger change.

So I looked into it. Indeed buffer alloc should be done at open, doing
it at link up (that cannot fail) makes no sense. It is probably
historical, because on MACB it is mog_alloc_rx_buffers() that does all
the alloc. On GEM it only does the ring buffer but not each individual
slot buffer, which is done by ->mog_init_rings() / gem_rx_refill().

I am linking a patch that applies before your series. Then the rebase
conflict resolution is pretty simple, and the gem_create_page_pool()
function should be adapted something like:

-- >8 ------------------------------------------------------------------

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/etherne=
t/cadence/macb_main.c
index 3dcba7d672bf..55237b840289 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2865,7 +2865,7 @@ static int macb_alloc_consistent(struct macb *bp)
   return -ENOMEM;
 }

-static void gem_create_page_pool(struct macb_queue *queue, int qid)
+static int gem_create_page_pool(struct macb_queue *queue, int qid)
 {
   struct page_pool_params pp_params =3D {
      .order =3D 0,
@@ -2885,7 +2885,8 @@ static void gem_create_page_pool(struct macb_queue *q=
ueue, int qid)
   pool =3D page_pool_create(&pp_params);
   if (IS_ERR(pool)) {
      netdev_err(queue->bp->dev, "cannot create rx page pool\n");
-     pool =3D NULL;
+     err =3D PTR_ERR(pool);
+     goto clear_pool_ptr;
   }

   queue->page_pool =3D pool;
@@ -2904,13 +2905,15 @@ static void gem_create_page_pool(struct macb_queue =
*queue, int qid)
      goto unreg_info;
   }

-  return;
+  return 0;

 unreg_info:
   xdp_rxq_info_unreg(&queue->xdp_q);
 destroy_pool:
   page_pool_destroy(pool);
+clear_pool_ptr:
   queue->page_pool =3D NULL;
+  return err;
 }

 static void macb_init_tieoff(struct macb *bp)

-- >8 ------------------------------------------------------------------

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


