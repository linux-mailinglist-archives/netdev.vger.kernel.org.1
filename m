Return-Path: <netdev+bounces-242319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9588C8EE1A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29063B76B6
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144D332EA0;
	Thu, 27 Nov 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1AX9yiFw"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7911289811
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254962; cv=none; b=gshzpbqF5x/PRnYORI5nsnlJ7sRWTc4q2MzCnk4UkgPGoMVahQiWFXXjpuElaNLT7gj4/4FguOBrI7sIPidyfgH4JnD703omKSVU24y88fgoQKAqEXL5jLHo3wHEuEPFN+LCUGEdKDwO/WjLEfXfrQIxxwSz3L6bTV3pl1SpnbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254962; c=relaxed/simple;
	bh=t3ex5EOjbUiVdpNVvo7BncJUZmnxvuOmZiQhj4t7p3Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=k63puVk4TUUVfIB7m0+mupEIezmDZADxM0rdRAsEJbMDwT4yjz6mHceQND2hmg3HRxPggXiZzQg4DySljCEeW4ZaMpJneSAW1wzeeG0pLqgLXzsbb1sGVQ7WiDLqP1pC030nUZcRDw/rWpWVXe1QtY6h9/1naCb8MdlO8yO0mNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1AX9yiFw; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BF4BB4E4191E
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 14:49:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 86F286068C;
	Thu, 27 Nov 2025 14:49:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCAD3102F291E;
	Thu, 27 Nov 2025 15:49:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764254955; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JJJY1tbBPWIy3naowekaQgQzifdfIBGO3uWRgP0IWEg=;
	b=1AX9yiFwB+4APhQlWfEI12CsUvkd+ymUgN0AAgpY+aYw+euQxkmRu0N0YnGZBIsYm73ZAo
	lZ4BSOJQmfPJPkgsY15vWRgMkmR0lvyTBijRkrSqHpYyGPuuWr57dmvD3OySKT+Hc9XSvC
	nTSRrSJYKwbX6ksqcA8YCsmdhEB4bW+jOpf75iBW2P0A+V/D1qMbAH7iFkjDSkX+g2oeWd
	mjePNP252kd4OIxgcLn8J+5j4T7I5Kj3zBC88wMKrTZlhEbCuEnOyV7AsmJVNSVIWV6UXJ
	ivdHSIwjEJxD8uy8JP+Dgq7EApQfVGdtL1a1KzxSX9FiXN+Ko4kjok18ITPsiQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Nov 2025 15:49:13 +0100
Message-Id: <DEJK6OLX6FL7.2SV8LF9U4S0VU@bootlin.com>
Subject: Re: [PATCH RFC net-next 5/6] cadence: macb/gem: make tx path skb
 agnostic
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-6-pvalerio@redhat.com>
In-Reply-To: <20251119135330.551835-6-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/c=
adence/macb.h
> index 2f665260a84d..67bb98d3cb00 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -964,19 +964,27 @@ struct macb_dma_desc_ptp {
>  #define MACB_PP_HEADROOM	XDP_PACKET_HEADROOM
>  #define MACB_MAX_PAD		(MACB_PP_HEADROOM + SKB_DATA_ALIGN(sizeof(struct s=
kb_shared_info)))
> =20
> -/* struct macb_tx_skb - data about an skb which is being transmitted
> - * @skb: skb currently being transmitted, only set for the last buffer
> - *       of the frame
> +enum macb_tx_buff_type {
> +	MACB_TYPE_SKB,
> +	MACB_TYPE_XDP_TX,
> +	MACB_TYPE_XDP_NDO,
> +};
> +
> +/* struct macb_tx_buff - data about an skb or xdp frame which is being t=
ransmitted
> + * @data: pointer to skb or xdp frame being transmitted, only set
> + *        for the last buffer for sk_buff
>   * @mapping: DMA address of the skb's fragment buffer
>   * @size: size of the DMA mapped buffer
>   * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
>   *                  false when buffer was mapped with dma_map_single()
> + * @type: type of buffer (MACB_TYPE_SKB, MACB_TYPE_XDP_TX, MACB_TYPE_XDP=
_NDO)
>   */
> -struct macb_tx_skb {
> -	struct sk_buff		*skb;
> -	dma_addr_t		mapping;
> -	size_t			size;
> -	bool			mapped_as_page;
> +struct macb_tx_buff {
> +	void				*data;
> +	dma_addr_t			mapping;
> +	size_t				size;
> +	bool				mapped_as_page;
> +	enum macb_tx_buff_type		type;
>  };

Here as well, reviewing would be helped by moving the tx_skb to tx_buff
renaming to a separate commit that has no functional change.

As said in [0], I am not a fan of the field name `data`.
Let's discuss it there.

[0]: https://lore.kernel.org/all/DEITSIO441QL.X81MVLL3EIV4@bootlin.com/

> -static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, i=
nt budget)
> +static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
> +			  int budget)
>  {
> -	if (tx_skb->mapping) {
> -		if (tx_skb->mapped_as_page)
> -			dma_unmap_page(&bp->pdev->dev, tx_skb->mapping,
> -				       tx_skb->size, DMA_TO_DEVICE);
> +	if (tx_buff->mapping) {
> +		if (tx_buff->mapped_as_page)
> +			dma_unmap_page(&bp->pdev->dev, tx_buff->mapping,
> +				       tx_buff->size, DMA_TO_DEVICE);
>  		else
> -			dma_unmap_single(&bp->pdev->dev, tx_skb->mapping,
> -					 tx_skb->size, DMA_TO_DEVICE);
> -		tx_skb->mapping =3D 0;
> +			dma_unmap_single(&bp->pdev->dev, tx_buff->mapping,
> +					 tx_buff->size, DMA_TO_DEVICE);
> +		tx_buff->mapping =3D 0;
>  	}
> =20
> -	if (tx_skb->skb) {
> -		napi_consume_skb(tx_skb->skb, budget);
> -		tx_skb->skb =3D NULL;
> +	if (tx_buff->data) {
> +		if (tx_buff->type !=3D MACB_TYPE_SKB)
> +			netdev_err(bp->dev, "BUG: Unexpected tx buffer type while unmapping (=
%d)",
> +				   tx_buff->type);
> +		napi_consume_skb(tx_buff->data, budget);
> +		tx_buff->data =3D NULL;
>  	}

This code does not make much sense by itself. We check `tx_buff->type !=3D
MACB_TYPE_SKB` but call napi_consume_skb() in all cases. I remember it
changes in the next commit.

> @@ -1069,16 +1073,23 @@ static void macb_tx_error_task(struct work_struct=
 *work)
> =20
>  		desc =3D macb_tx_desc(queue, tail);
>  		ctrl =3D desc->ctrl;
> -		tx_skb =3D macb_tx_skb(queue, tail);
> -		skb =3D tx_skb->skb;
> +		tx_buff =3D macb_tx_buff(queue, tail);
> +
> +		if (tx_buff->type !=3D MACB_TYPE_SKB)
> +			netdev_err(bp->dev, "BUG: Unexpected tx buffer type (%d)",
> +				   tx_buff->type);
> +		skb =3D tx_buff->data;

Same here: `tx_buff->type !=3D MACB_TYPE_SKB` does not make sense if we
keep on going with the SKB case anyways.

> =20
>  		if (ctrl & MACB_BIT(TX_USED)) {
>  			/* skb is set for the last buffer of the frame */
>  			while (!skb) {
> -				macb_tx_unmap(bp, tx_skb, 0);
> +				macb_tx_unmap(bp, tx_buff, 0);
>  				tail++;
> -				tx_skb =3D macb_tx_skb(queue, tail);
> -				skb =3D tx_skb->skb;
> +				tx_buff =3D macb_tx_buff(queue, tail);
> +				if (tx_buff->type !=3D MACB_TYPE_SKB)
> +					netdev_err(bp->dev, "BUG: Unexpected tx buffer type (%d)",
> +						   tx_buff->type);
> +				skb =3D tx_buff->data;

Same.

> @@ -5050,7 +5066,7 @@ static netdev_tx_t at91ether_start_xmit(struct sk_b=
uff *skb,
>  		netif_stop_queue(dev);
> =20
>  		/* Store packet information (to free when Tx completed) */
> -		lp->rm9200_txq[desc].skb =3D skb;
> +		lp->rm9200_txq[desc].data =3D skb;
>  		lp->rm9200_txq[desc].size =3D skb->len;
>  		lp->rm9200_txq[desc].mapping =3D dma_map_single(&lp->pdev->dev, skb->d=
ata,
>  							      skb->len, DMA_TO_DEVICE);

We might want to assign `lp->rm9200_txq[desc].type` here, to ensure all
`struct macb_tx_buff` instances are fully initialised.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


