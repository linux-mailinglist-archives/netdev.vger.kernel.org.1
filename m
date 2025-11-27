Return-Path: <netdev+bounces-242321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE45C8F352
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5180E4F266C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9782E336EC3;
	Thu, 27 Nov 2025 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yEy+UqOI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56526336EC4
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256079; cv=none; b=DS0T5Q+FiiMWJrZjuMgiyYrh7BhiOn9j5g3Fa7QdoBIN9LJGsvhrTCm94FU6oeP95yx/zJ/MioyHS2+EaoUrVT1up/V/lEWPjvYstPpp5WRtFyONKOecwNIYphlK0k7DqogLdrQvznD9M5CdVXin1tvbxB0pVcDth7i8kBxzjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256079; c=relaxed/simple;
	bh=8ZvzTTRNEAfD2sAgx5JDxlXB/DDOqQnXLAzKFzy8HA8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=R9b10sOgmQUEms2xicf6ilLr4B4xVf5i/jvFx0dPbfn/kXTV49QV2/kV6wZSb8aGstQMKCWLBixs5Zj60Q/Nu4PGLsRoIa1xqynuv6xw+TNLrQNcmtnLUMVLcvMnAEDBD29eDUg6fIIHmYSKhYHYBRB3ouwlBgV/jOPFkx99hQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yEy+UqOI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E9B1D1A1DB0;
	Thu, 27 Nov 2025 15:07:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEC7C6068C;
	Thu, 27 Nov 2025 15:07:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C7C3102F218C;
	Thu, 27 Nov 2025 16:07:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764256075; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8crqLJchFkTj6DCWTiXRlQ+eBQ+IUxM75HJ4UnuadO4=;
	b=yEy+UqOILIThkQwW4lG2nRqI94Nv3mR8rRFdSZNLO3DgJfk022PoXtFZrPHVjtdie9iNVF
	wpp0q/qSNztOYEg4ixeafn0+s5hc7O1CR3hlj3lyqGhHTUxOA4wxsI6tV/yTampL47UfOj
	scsOA0/txjf1z9KFRIsGQR6NUtMdcCjp7N6KImhom0S3XLrTpjeHtfeR4F+zLnOzv3hrCS
	CG4I2XJoGvMx9N1iBx6Ej/MVu/MOPS6zJ+HLHeB3wgSt6fsdB+ptI9dqPJyagyISZ9XG+M
	NEUnD9foBhxXGcBfjuekmH2g3Y9HyBJWL/FFMwNqjW88U34/hLCOXqFslhtb9g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Nov 2025 16:07:52 +0100
Message-Id: <DEJKKYXTM4TH.2MK2CNLW7L5D3@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RFC net-next 6/6] cadence: macb/gem: introduce xmit
 support
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-7-pvalerio@redhat.com>
In-Reply-To: <20251119135330.551835-7-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Paolo, netdev,

On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
> Add XDP_TX verdict support, also introduce ndo_xdp_xmit function for
> redirection, and update macb_tx_unmap() to handle both skbs and xdp
> frames advertising NETDEV_XDP_ACT_NDO_XMIT capability and the ability
> to process XDP_TX verdicts.
>
> Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 166 +++++++++++++++++++++--
>  1 file changed, 153 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index eeda1a3871a6..bd62d3febeb1 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -969,6 +969,17 @@ static int macb_halt_tx(struct macb *bp)
>  					bp, TSR);
>  }
> =20
> +static void release_buff(void *buff, enum macb_tx_buff_type type, int bu=
dget)
> +{
> +	if (type =3D=3D MACB_TYPE_SKB) {
> +		napi_consume_skb(buff, budget);
> +	} else if (type =3D=3D MACB_TYPE_XDP_TX) {
> +		xdp_return_frame_rx_napi(buff);
> +	} else {
> +		xdp_return_frame(buff);
> +	}
> +}
> +
>  static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
>  			  int budget)
>  {
> @@ -983,10 +994,7 @@ static void macb_tx_unmap(struct macb *bp, struct ma=
cb_tx_buff *tx_buff,
>  	}
> =20
>  	if (tx_buff->data) {
> -		if (tx_buff->type !=3D MACB_TYPE_SKB)
> -			netdev_err(bp->dev, "BUG: Unexpected tx buffer type while unmapping (=
%d)",
> -				   tx_buff->type);
> -		napi_consume_skb(tx_buff->data, budget);
> +		release_buff(tx_buff->data, tx_buff->type, budget);
>  		tx_buff->data =3D NULL;
>  	}
>  }
> @@ -1076,8 +1084,8 @@ static void macb_tx_error_task(struct work_struct *=
work)
>  		tx_buff =3D macb_tx_buff(queue, tail);
> =20
>  		if (tx_buff->type !=3D MACB_TYPE_SKB)
> -			netdev_err(bp->dev, "BUG: Unexpected tx buffer type (%d)",
> -				   tx_buff->type);
> +			goto unmap;
> +
>  		skb =3D tx_buff->data;
> =20
>  		if (ctrl & MACB_BIT(TX_USED)) {
> @@ -1118,6 +1126,7 @@ static void macb_tx_error_task(struct work_struct *=
work)
>  			desc->ctrl =3D ctrl | MACB_BIT(TX_USED);
>  		}
> =20
> +unmap:
>  		macb_tx_unmap(bp, tx_buff, 0);
>  	}
> =20
> @@ -1196,6 +1205,7 @@ static int macb_tx_complete(struct macb_queue *queu=
e, int budget)
>  	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
>  	head =3D queue->tx_head;
>  	for (tail =3D queue->tx_tail; tail !=3D head && packets < budget; tail+=
+) {
> +		void			*data =3D NULL;
>  		struct macb_tx_buff	*tx_buff;
>  		struct sk_buff		*skb;
>  		struct macb_dma_desc	*desc;
> @@ -1218,11 +1228,16 @@ static int macb_tx_complete(struct macb_queue *qu=
eue, int budget)
>  		for (;; tail++) {
>  			tx_buff =3D macb_tx_buff(queue, tail);
> =20
> -			if (tx_buff->type =3D=3D MACB_TYPE_SKB)
> -				skb =3D tx_buff->data;
> +			if (tx_buff->type !=3D MACB_TYPE_SKB) {
> +				data =3D tx_buff->data;
> +				goto unmap;
> +			}
> =20
>  			/* First, update TX stats if needed */
> -			if (skb) {
> +			if (tx_buff->type =3D=3D MACB_TYPE_SKB && tx_buff->data) {
> +				data =3D tx_buff->data;
> +				skb =3D tx_buff->data;
> +
>  				if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
>  				    !ptp_one_step_sync(skb))
>  					gem_ptp_do_txstamp(bp, skb, desc);
> @@ -1238,6 +1253,7 @@ static int macb_tx_complete(struct macb_queue *queu=
e, int budget)
>  				bytes +=3D skb->len;
>  			}
> =20
> +unmap:
>  			/* Now we can safely release resources */
>  			macb_tx_unmap(bp, tx_buff, budget);
> =20
> @@ -1245,7 +1261,7 @@ static int macb_tx_complete(struct macb_queue *queu=
e, int budget)
>  			 * WARNING: at this point skb has been freed by
>  			 * macb_tx_unmap().
>  			 */
> -			if (skb)
> +			if (data)
>  				break;
>  		}
>  	}
> @@ -1357,8 +1373,124 @@ static void discard_partial_frame(struct macb_que=
ue *queue, unsigned int begin,
>  	 */
>  }
> =20
> +static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf=
,
> +				 struct net_device *dev, dma_addr_t addr)
> +{
> +	enum macb_tx_buff_type buff_type;
> +	struct macb_tx_buff *tx_buff;
> +	int cpu =3D smp_processor_id();
> +	struct macb_dma_desc *desc;
> +	struct macb_queue *queue;
> +	unsigned long flags;
> +	dma_addr_t mapping;
> +	u16 queue_index;
> +	int err =3D 0;
> +	u32 ctrl;
> +
> +	queue_index =3D cpu % bp->num_queues;
> +	queue =3D &bp->queues[queue_index];
> +	buff_type =3D !addr ? MACB_TYPE_XDP_NDO : MACB_TYPE_XDP_TX;

I am not the biggest fan of piggy-backing on !!addr to know which
codepath called us. If the macb_xdp_submit_frame() call in gem_xdp_run()
ever gives an addr=3D0 coming from macb_get_addr(bp, desc), then we will
be submitting NDO typed frames and creating additional DMA mappings
which would be a really hard to debug bug.

> +	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
> +
> +	/* This is a hard error, log it. */
> +	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
> +		       bp->tx_ring_size) < 1) {

Hard wrapped line is not required, it fits in one line.

> +		netif_stop_subqueue(dev, queue_index);
> +		netdev_dbg(bp->dev, "tx_head =3D %u, tx_tail =3D %u\n",
> +			   queue->tx_head, queue->tx_tail);
> +		err =3D -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	if (!addr) {
> +		mapping =3D dma_map_single(&bp->pdev->dev,
> +					 xdpf->data,
> +					 xdpf->len, DMA_TO_DEVICE);
> +		if (unlikely(dma_mapping_error(&bp->pdev->dev, mapping))) {
> +			err =3D -ENOMEM;
> +			goto unlock;
> +		}
> +	} else {
> +		mapping =3D addr;
> +		dma_sync_single_for_device(&bp->pdev->dev, mapping,
> +					   xdpf->len, DMA_BIDIRECTIONAL);
> +	}
> +
> +	unsigned int tx_head =3D queue->tx_head + 1;

Middle scope variable definition. Weirdly named as it isn't storing the
current head offset but the future head offset.

> +	ctrl =3D MACB_BIT(TX_USED);
> +	desc =3D macb_tx_desc(queue, tx_head);
> +	desc->ctrl =3D ctrl;
> +
> +	desc =3D macb_tx_desc(queue, queue->tx_head);
> +	tx_buff =3D macb_tx_buff(queue, queue->tx_head);
> +	tx_buff->data =3D xdpf;
> +	tx_buff->type =3D buff_type;
> +	tx_buff->mapping =3D mapping;
> +	tx_buff->size =3D xdpf->len;
> +	tx_buff->mapped_as_page =3D false;
> +
> +	ctrl =3D (u32)tx_buff->size;
> +	ctrl |=3D MACB_BIT(TX_LAST);
> +
> +	if (unlikely(macb_tx_ring_wrap(bp, queue->tx_head) =3D=3D (bp->tx_ring_=
size - 1)))
> +		ctrl |=3D MACB_BIT(TX_WRAP);
> +
> +	/* Set TX buffer descriptor */
> +	macb_set_addr(bp, desc, tx_buff->mapping);
> +	/* desc->addr must be visible to hardware before clearing
> +	 * 'TX_USED' bit in desc->ctrl.
> +	 */
> +	wmb();
> +	desc->ctrl =3D ctrl;
> +	queue->tx_head =3D tx_head;
> +
> +	/* Make newly initialized descriptor visible to hardware */
> +	wmb();
> +
> +	spin_lock(&bp->lock);
> +	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
> +	spin_unlock(&bp->lock);
> +
> +	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
> +		netif_stop_subqueue(dev, queue_index);

The above 30~40 lines are super similar to macb_start_xmit() &
macb_tx_map(). They implement almost the same logic; can we avoid the
duplication?

> +
> +unlock:
> +	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
> +
> +	if (err)
> +		release_buff(xdpf, buff_type, 0);
> +
> +	return err;
> +}
> +
> +static int
> +macb_xdp_xmit(struct net_device *dev, int num_frame,
> +	      struct xdp_frame **frames, u32 flags)
> +{
> +	struct macb *bp =3D netdev_priv(dev);
> +	u32 xmitted =3D 0;
> +	int i;
> +
> +	if (!macb_is_gem(bp))
> +		return -EOPNOTSUPP;
> +
> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < num_frame; i++) {
> +		if (macb_xdp_submit_frame(bp, frames[i], dev, 0))
> +			break;
> +
> +		xmitted++;
> +	}
> +
> +	return xmitted;
> +}
> +
>  static u32 gem_xdp_run(struct macb_queue *queue, struct xdp_buff *xdp,
> -		       struct net_device *dev)
> +		       struct net_device *dev, dma_addr_t addr)
>  {
>  	struct bpf_prog *prog;
>  	u32 act =3D XDP_PASS;
> @@ -1379,6 +1511,12 @@ static u32 gem_xdp_run(struct macb_queue *queue, s=
truct xdp_buff *xdp,
>  			break;
>  		}
>  		goto out;
> +	case XDP_TX:
> +		struct xdp_frame *xdpf =3D xdp_convert_buff_to_frame(xdp);
> +
> +		if (!xdpf || macb_xdp_submit_frame(queue->bp, xdpf, dev, addr))
> +			act =3D XDP_DROP;
> +		goto out;
>  	default:
>  		bpf_warn_invalid_xdp_action(dev, prog, act);
>  		fallthrough;
> @@ -1467,7 +1605,7 @@ static int gem_rx(struct macb_queue *queue, struct =
napi_struct *napi,
>  				 false);
>  		xdp_buff_clear_frags_flag(&xdp);
> =20
> -		ret =3D gem_xdp_run(queue, &xdp, bp->dev);
> +		ret =3D gem_xdp_run(queue, &xdp, bp->dev, addr);
>  		if (ret =3D=3D XDP_REDIRECT)
>  			xdp_flush =3D true;
> =20
> @@ -4546,6 +4684,7 @@ static const struct net_device_ops macb_netdev_ops =
=3D {
>  	.ndo_hwtstamp_get	=3D macb_hwtstamp_get,
>  	.ndo_setup_tc		=3D macb_setup_tc,
>  	.ndo_bpf		=3D macb_xdp,
> +	.ndo_xdp_xmit		=3D macb_xdp_xmit,

I'd expect macb_xdp_xmit() to be called gem_xdp_xmit() as well.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


