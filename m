Return-Path: <netdev+bounces-242314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE8BC8ECF6
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D06E14ED901
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3000A33436A;
	Thu, 27 Nov 2025 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ktlmqj47"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A403126AF
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254527; cv=none; b=jB6qslsa5qZiy1/SwCmBJbtrj4vP5nayHAK1kWuXkWnLCJ10xbbvxWdTJkNGqwmTuXPjdqEWD9qHFGUemiGmzXymSq5ynOlm0PvQ92nJEPkBLVztl+laJ2JvTe7wrHrMOnMNIg7KznsqRfZ2rHEgvevT9HZRbYkeT3FuKPU7nSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254527; c=relaxed/simple;
	bh=iLkUD4pSCsikoaPolBY/mWRvj/yCGTQRGb5jKnxePt0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=g0hXtYIqs5uDJgHrkmgbp/cWBQi/JQQF5G3XSUSMQSmjtdzCy5ASePUflkZpJjbo+ghc/Fs1KRqAGKGBPNvb4xeAPLhELdeKjfIwVJzDCRoJnoH7MR9/cwEwJhy+znP5EOa9knHdiGy2PH8HKM6TZE5RHeDKWmg/ONdyxtvF7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ktlmqj47; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F27081A1DA8;
	Thu, 27 Nov 2025 14:42:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6C416068C;
	Thu, 27 Nov 2025 14:42:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87D07102F286B;
	Thu, 27 Nov 2025 15:41:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764254521; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sCylEavWagMAEEvunYMOMJ9eD8KUby8nciwuMPPPrAQ=;
	b=ktlmqj47OAI+ZrR9v30WURQJW0lkqEP0F0AD+AKRrZyT96vOMqqM5aJstZUZKlSw9D8aI6
	4E/t4sWW0cqkaLzanIMLJN9RpTg/BL5f6UvbVauM2ZuF7pVmahSZ/VUmrAslWOp7jK0RQK
	JN1t05aluMaxzpQKLwEYEjHsOrdOsEN6LQ0L5JAar1wBdABxpDMW+RUtuktCN0IzUpWmGw
	DmzLVpwaGJPDbMHhNl+b7iYUqzcoKLOyWjeBZGwYGTKPa7GYK3WYwzDf02n1YP+ayQaQqf
	8qbBGA2HRY5Z6ikjGJaDtwKKoFLxZqpcV8892LyhowDTQ+UAa9AqEaTJHgKVYQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Nov 2025 15:41:56 +0100
Message-Id: <DEJK1461002Y.TQON2T91OS6B@bootlin.com>
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
Subject: Re: [PATCH RFC net-next 4/6] cadence: macb/gem: add XDP support for
 gem
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <20251119135330.551835-5-pvalerio@redhat.com>
In-Reply-To: <20251119135330.551835-5-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Nov 19, 2025 at 2:53 PM CET, Paolo Valerio wrote:
> @@ -1273,6 +1275,7 @@ struct macb_queue {
>  	struct queue_stats stats;
>  	struct page_pool	*page_pool;
>  	struct sk_buff		*skb;
> +	struct xdp_rxq_info	xdp_q;
>  };

Those are always named `xdp_rxq` inside the kernel, we should stick with
the calling convention no?

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 5829c1f773dd..53ea1958b8e4 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1344,10 +1344,51 @@ static void discard_partial_frame(struct macb_que=
ue *queue, unsigned int begin,
>  	 */
>  }
> =20
> +static u32 gem_xdp_run(struct macb_queue *queue, struct xdp_buff *xdp,
> +		       struct net_device *dev)

Why pass `struct net_device` explicitly? It is in queue->bp->dev.

> +{
> +	struct bpf_prog *prog;
> +	u32 act =3D XDP_PASS;
> +
> +	rcu_read_lock();
> +
> +	prog =3D rcu_dereference(queue->bp->prog);
> +	if (!prog)
> +		goto out;
> +
> +	act =3D bpf_prog_run_xdp(prog, xdp);
> +	switch (act) {
> +	case XDP_PASS:
> +		goto out;
> +	case XDP_REDIRECT:
> +		if (unlikely(xdp_do_redirect(dev, xdp, prog))) {
> +			act =3D XDP_DROP;
> +			break;
> +		}
> +		goto out;

Why the `unlikely()`?

> +	default:
> +		bpf_warn_invalid_xdp_action(dev, prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +		trace_xdp_exception(dev, prog, act);
> +		fallthrough;
> +	case XDP_DROP:
> +		break;
> +	}
> +
> +	page_pool_put_full_page(queue->page_pool,
> +				virt_to_head_page(xdp->data), true);

Maybe move that to the XDP_DROP, it is the only `break` in the above
switch statement. It will be used by the default and XDP_ABORTED cases
through fallthrough. We can avoid the out label and its two gotos that
way.

>  static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
>  		  int budget)
>  {
>  	struct macb *bp =3D queue->bp;
> +	bool			xdp_flush =3D false;
>  	unsigned int		len;
>  	unsigned int		entry;
>  	void			*data;
> @@ -1356,9 +1397,11 @@ static int gem_rx(struct macb_queue *queue, struct=
 napi_struct *napi,
>  	int			count =3D 0;
> =20
>  	while (count < budget) {
> -		u32 ctrl;
> -		dma_addr_t addr;
>  		bool rxused, first_frame;
> +		struct xdp_buff xdp;
> +		dma_addr_t addr;
> +		u32 ctrl;
> +		u32 ret;
> =20
>  		entry =3D macb_rx_ring_wrap(bp, queue->rx_tail);
>  		desc =3D macb_rx_desc(queue, entry);
> @@ -1403,6 +1446,22 @@ static int gem_rx(struct macb_queue *queue, struct=
 napi_struct *napi,
>  			data_len =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offset;
>  		}
> =20
> +		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF)))
> +			goto skip_xdp;
> +
> +		xdp_init_buff(&xdp, bp->rx_buffer_size, &queue->xdp_q);
> +		xdp_prepare_buff(&xdp, data, bp->rx_offset, len,
> +				 false);
> +		xdp_buff_clear_frags_flag(&xdp);

You prepare the XDP buffer before checking an XDP program is attached.
Could we avoid this work? We'd move the xdp_buff preparation into
gem_xdp_run(), after the RCU pointer dereference.

> -static void gem_create_page_pool(struct macb_queue *queue)
> +static void gem_create_page_pool(struct macb_queue *queue, int qid)
>  {
>  	struct page_pool_params pp_params =3D {
>  		.order =3D 0,
>  		.flags =3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>  		.pool_size =3D queue->bp->rx_ring_size,
>  		.nid =3D NUMA_NO_NODE,
> -		.dma_dir =3D DMA_FROM_DEVICE,
> +		.dma_dir =3D rcu_access_pointer(queue->bp->prog)
> +				? DMA_BIDIRECTIONAL
> +				: DMA_FROM_DEVICE,

Ah, that is the reason for page_pool_get_dma_dir() calls!

>  static int macb_change_mtu(struct net_device *dev, int new_mtu)
>  {
> +	int frame_size =3D new_mtu + ETH_HLEN + ETH_FCS_LEN + MACB_MAX_PAD;
> +	struct macb *bp =3D netdev_priv(dev);
> +	struct bpf_prog *prog =3D bp->prog;

No fancy RCU macro?

> +static int macb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
> +{
> +	struct macb *bp =3D netdev_priv(dev);
> +
> +	if (!macb_is_gem(bp))
> +		return 0;

Returning 0 sounds like a mistake, -EOPNOTSUPP sounds more appropriate.

> +	switch (xdp->command) {
> +	case XDP_SETUP_PROG:
> +		return gem_xdp_setup(dev, xdp->prog, xdp->extack);
> +	default:
> +		return -EINVAL;

Same here: we want -EOPNOTSUPP. Otherwise caller cannot dissociate an
unsupported call from one that is supported but failed.

> +	}
> +}
> +
>  static void gem_update_stats(struct macb *bp)
>  {
>  	struct macb_queue *queue;
> @@ -4390,6 +4529,7 @@ static const struct net_device_ops macb_netdev_ops =
=3D {
>  	.ndo_hwtstamp_set	=3D macb_hwtstamp_set,
>  	.ndo_hwtstamp_get	=3D macb_hwtstamp_get,
>  	.ndo_setup_tc		=3D macb_setup_tc,
> +	.ndo_bpf		=3D macb_xdp,

We want it to be "gem_" prefixed as it does not support MACB.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


