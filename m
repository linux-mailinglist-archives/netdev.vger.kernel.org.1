Return-Path: <netdev+bounces-262783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLF6OBrdpWkvHgAAu9opvQ
	(envelope-from <netdev+bounces-262783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 19:55:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2B21DE80A
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 19:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C0CF300361D
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 18:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FA93382E8;
	Mon,  2 Mar 2026 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0dONb+i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYFm85rY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFCF3382DC
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772477597; cv=none; b=FwIlSvib7phwx0sMOVHyiM/1oTSE5/PXR6TuvcQZuKJTJpNmI4PfnSOH+O+vTuT0svIbVpYrYuOzdX7uaknqSNEBrkyR4d80oXazhJqs8mEgdbeNEni+Z6Ti/b92ZWmagOjozyNIucIt5W3DDxVREHq2UqaiPZxdNYoIO9P5OVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772477597; c=relaxed/simple;
	bh=rGb+d3eXV4/WG6UZVYz2+NJz33h47kbcneDn0cpgFpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXVusZZBwp2NZ6hmaaKhX5Qe94vWoXbPgSVU8K4UcGGgG+FG7fvgHzYzVRaa7YpyflATgQxH53saMMPfNX5+6aiTB5Y5Rlls9SBvm+kJ/Xn6Yq4U+qfeE8wDhnZ68u6uRKdn4FPfp23OJl8QN2kYInhRh/RDDAgDjNICYK+DSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D0dONb+i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYFm85rY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772477594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X5Qbo2pQOAmuJWNlaaVNuPWK+hvBjNdcsVen+Csw5XQ=;
	b=D0dONb+ig5RNKI9F2dqhQ634Qd2ZqPfxsGY89KpUEDlzN9y+aN/ZVk+4f6UmUtv5TrJIPh
	DyW8yIq6LE+ncCoEpktYLS0zPkqljk6xV4CmwFgrGInT772DDdR9X/1QJPEPS4a/0KXNah
	34ARXPir4pifKPEd7zx/SE5o15YwJ88=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-xw_OwKGeMmWUZ6jRqU9Mig-1; Mon, 02 Mar 2026 13:53:13 -0500
X-MC-Unique: xw_OwKGeMmWUZ6jRqU9Mig-1
X-Mimecast-MFC-AGG-ID: xw_OwKGeMmWUZ6jRqU9Mig_1772477592
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48378df3469so33353495e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 10:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772477592; x=1773082392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5Qbo2pQOAmuJWNlaaVNuPWK+hvBjNdcsVen+Csw5XQ=;
        b=aYFm85rY2FrG2xizcvQRKsz4QRMVa+iXxBkQEMJsQcfg6h1oc5KgABc1ofIuJiMvaY
         AFfTIU69Q1ILtGh5q8lQ0E13WrOJQYePq00UKiqaBufPpE+Pci1hf7f+vQD9bf2QNMrf
         xtPplSUly7R20zIhsCKuUtwlJZJfE8MdUysXMwceEL1rsj3/LnS1Euy6xsu6zrZn1Nh0
         5EbdwE7Sz/lmIzk4Q6b84XwAfGwxncLPr/hWzJOgkSzqsZzNJG+FUJ4EA/O5SU6sePuI
         dlBzOeUzUDM7eu3gewWFq1akrIl+0D/vmnkOXeX+eePMpx/I7mvgdrTlSy9AuOc6DamT
         b8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772477592; x=1773082392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5Qbo2pQOAmuJWNlaaVNuPWK+hvBjNdcsVen+Csw5XQ=;
        b=iXYTvFZJ4VcfZCLGrwJ/K1JS7AFGyvkwpB/7NS3zaexv6ycVSSxwXvlAulLrCh15wa
         jgU1FltwjlzGj6c97Tu9/DpzwPvxCSkbmx1us7m4NEnl3STiqnziAgUPXINDGF7tasYp
         TbTYmwLoYf303mHjlYPDTNIutrIYWS5lhEpSppfLIZMIMzuyaU8jcgy3OnDpmZvuTbGW
         etuoUBibMeDuAeQ7iH1lBxsd4Ef25Zrpl7T1JtfrF+eHu3ww3YHCoeBe2r8byiICz7Au
         QuIRgAzqhZjiHK+B1xXQ6cdT98MNDHE/syNhkja9YgvxaHk9yw5U6bpvZZ/udgD+wrtk
         fveQ==
X-Gm-Message-State: AOJu0Yy/kmiGhZLUw1WNwJvKcphEdpZR9NeUGLWxd+/jMbk3idF7rs/+
	A8ZWLGncvsWYbUgfc+G9/AAcBjGDXAWl+Hh4iOpnB+bLaTzAO8gYK/mHh6YQdo0FWBg5rE5dec9
	qsUtJek9xjH16nzCzuzkIPFOI4I9Vv/7zd+lpNBMvCAULd2S7R+crzrlQrQ==
X-Gm-Gg: ATEYQzySiAqHEe6V/sFc/vyR9CYoY5SUo+jI3qf/YFPuXN4eMTnZYnseJ0n2/JJ+Wbz
	ju2hPrlnKA8cic9TV9y0z8HQR8EsoWL2o3Xz6ABaoIOwrh+VgENM6ySKg5m3H8id/j2J5rl4dMr
	vN6raIIaLcI2sDuU5pDi9pze6ZbL4nnOJFMPsCzzxjOb+y3c6FLShudNeNTI30K5ChaWykqeGmM
	zf0r1rD1KVP4di74DXDAz6ct+qacfYiSeJuqj88kxRhFn1h8pcoxJS2f/GZ9V/4Te8jhmi/QwAS
	lEJVvc0sDTwNhcIdC39fhDlVsMmaImrgA05XtPH3EiIvYgmO4gWK77hF0fjKQiZjHZgnjXdn2n/
	BqOhpTqxskkKjpQzk9cVR6oDYJ5OP9GCKUbQ1Hq/CWm67Tw==
X-Received: by 2002:a05:600c:820c:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-483c9937b2dmr210989095e9.15.1772477592373;
        Mon, 02 Mar 2026 10:53:12 -0800 (PST)
X-Received: by 2002:a05:600c:820c:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-483c9937b2dmr210988605e9.15.1772477591814;
        Mon, 02 Mar 2026 10:53:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b44207sm315022535e9.7.2026.03.02.10.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 10:53:11 -0800 (PST)
Date: Mon, 2 Mar 2026 13:53:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] virtio-net: xsk: Support wakeup on RX side
Message-ID: <20260302135032-mutt-send-email-mst@kernel.org>
References: <20260302164158.4394-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302164158.4394-1-minhquangbui99@gmail.com>
X-Rspamd-Queue-Id: 4D2B21DE80A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-262783-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:41:58PM +0700, Bui Quang Minh wrote:
> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
> wasting CPU cycles on polling. Users will be notified and they need to
> make a wakeup call after refilling the ring.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v2:
> - Fix the flag check in virtnet_xsk_wakeup
> - Link to v1: https://lore.kernel.org/netdev/20260227150949.13089-1-minhquangbui99@gmail.com/
> ---
>  drivers/net/virtio_net.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..3614002fc87c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>  	xsk_buffs = rq->xsk_buffs;
>  
>  	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> -	if (!num)
> +	if (!num) {
> +		if (xsk_uses_need_wakeup(pool)) {
> +			xsk_set_rx_need_wakeup(pool);
> +			/* Return 0 instead of -ENOMEM so that NAPI is
> +			 * descheduled.
> +			 */
> +			return 0;

With this change, try_fill_recv() can return true even though zero RX
buffers were posted in need_wakeup mode, which contradicts its
documentation ("Returns false if we couldn't fill entirely (OOM)").

Methinks we need to at least update the comment near try_fill_recv.



> +		}
> +
>  		return -ENOMEM;
> +	} else {
> +		xsk_clear_rx_need_wakeup(pool);
> +	}
>  
>  	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>  
> @@ -1588,20 +1599,19 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>  	return sent;
>  }
>  
> -static void xsk_wakeup(struct send_queue *sq)
> +static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
>  {
> -	if (napi_if_scheduled_mark_missed(&sq->napi))
> +	if (napi_if_scheduled_mark_missed(napi))
>  		return;
>  
>  	local_bh_disable();
> -	virtqueue_napi_schedule(&sq->napi, sq->vq);
> +	virtqueue_napi_schedule(napi, vq);
>  	local_bh_enable();
>  }
>  
>  static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	struct send_queue *sq;
>  
>  	if (!netif_running(dev))
>  		return -ENETDOWN;
> @@ -1609,9 +1619,18 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>  	if (qid >= vi->curr_queue_pairs)
>  		return -EINVAL;
>  
> -	sq = &vi->sq[qid];
> +	if (flag & XDP_WAKEUP_TX) {
> +		struct send_queue *sq = &vi->sq[qid];
> +
> +		xsk_wakeup(&sq->napi, sq->vq);
> +	}
> +
> +	if (flag & XDP_WAKEUP_RX) {
> +		struct receive_queue *rq = &vi->rq[qid];
> +
> +		xsk_wakeup(&rq->napi, rq->vq);
> +	}
>  
> -	xsk_wakeup(sq);
>  	return 0;
>  }
>  
> @@ -1623,7 +1642,7 @@ static void virtnet_xsk_completed(struct send_queue *sq, int num)
>  	 * wakeup the tx napi to consume the xsk tx queue, because the tx
>  	 * interrupt may not be triggered.
>  	 */
> -	xsk_wakeup(sq);
> +	xsk_wakeup(&sq->napi, sq->vq);
>  }
>  
>  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> -- 
> 2.43.0


