Return-Path: <netdev+bounces-256971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCW6NpsrhGla0QMAu9opvQ
	(envelope-from <netdev+bounces-256971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:33:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDCEEEC04
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A64FA3024A46
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682CF31ED64;
	Thu,  5 Feb 2026 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+M65Prb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJ46Sb8v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837631B836
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269469; cv=none; b=dyIBkgnOktQLOK9ciGRy4V6YG4lObFPKFT17WmQCZmJM2bwRTZhtiUBhgqOBErxBBU8Wm8n4pVSY5bTLuO9W8vhXVJohMPcrdh5YEaBVkgluyPOvOdRl29mXjfu+HuYXe2ysAsQMhUjJCkVPwacBzYfVHenLq2++3UAOCOx9BQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269469; c=relaxed/simple;
	bh=TzbDhsC3xE5HrBSJro8b2lQfRwy+44wkEE9fdTCzzWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F29HsnJLx+HJ3GR5fEAOxUlYlqfI2Ufo2WKoJrXsMvLSNMTJU25aN2HJJHiqvuHEIcP5BmS6uaAyuSit9nERdWPZvGNSyPReUNvLiI/A6XH2Qf58Wde/Cm4zyx+xMOV9i38tPY5Ol0ntubMn1EShbiqc7+SfNQRqx906QEyYaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+M65Prb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJ46Sb8v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770269468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XwFDx4vz/u5PsNLw+XbCPRfEwJWkhfYgzo4oGPhH690=;
	b=e+M65Prbsb8aGp1VboRREwasUP6yG1hPchwoS44mEXiaNKJXKQWSQcMYOMHZicGNqZGOhh
	jOIxWO683j7XeRyik3/XZ/iy32TKbDSUyyv1tm5Hk9aj0wFCB/Ya5PvKdo3iy1fFLurBKR
	xwmZrdjSFuP408KWcK70KHjUnAssvsM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-1zdkKFG5PkmMyPOkRI_9hQ-1; Thu, 05 Feb 2026 00:31:05 -0500
X-MC-Unique: 1zdkKFG5PkmMyPOkRI_9hQ-1
X-Mimecast-MFC-AGG-ID: 1zdkKFG5PkmMyPOkRI_9hQ_1770269464
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4362197d1easo327865f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 21:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770269464; x=1770874264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XwFDx4vz/u5PsNLw+XbCPRfEwJWkhfYgzo4oGPhH690=;
        b=VJ46Sb8vnnuHV+dUu96+5i9Mor27oWFxLgvq2YKtTLfujq7l4p0EOcnSJaGxr4XmiQ
         WYMTKPhXd1Z7aCUcIa+jipLhQGI2k5Jrpo2YrR24H+w1aG37NZGyJ6ylT6VYUSiZpkgo
         WEttxth2kRD2YzNoABxKC+dMYcbXeUFHS0ya8v8ElPiDJdDoQIQOtGeFm9Xs+8pFzXSY
         F4nfRe+Uu35pFgtJy6ZPz6u/g2xhqNqZ1m1LUQoHPu6Ao39WdQCBYS0zQu6RxN7mgSLu
         JOiYFZSpFr0Zmx9MRh57MVgcaZ3SBWwwgqNVc1CVH+z15a+xEV3FOuZJIgRR2kiZ84/8
         9xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770269464; x=1770874264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwFDx4vz/u5PsNLw+XbCPRfEwJWkhfYgzo4oGPhH690=;
        b=Pd/WdtbaUPRx/SVDm6RwsZVwhVvDVvb+qAi61kWNtHWRSITb1eXN+0NRVduuuxJ4Ys
         ltmsBmH+QcGLEhVXKktIYaDUwr/tNGsVuw0j/QMNvWKAFh68QyykojCnv8iAiZZves91
         lKOi45VRwJiNoXe1hlt2DWolcP6gvSl2ykOpLdtY4dWNax5RZNPsKDO1CZGmX3n/2eNZ
         aAZvwuyxZMeZBht+iGX4t7xCZ77xj9fO62nVY86zMTnx6pAmRdlroQ1z0x1W2RGRqN62
         Z/xi6rF7X4RsjPdJWhfhrqZOC80Ag/d4unNvwmO3wbxEL6V/O6ywrYlSWqAwqx4BJy2Z
         qyxw==
X-Forwarded-Encrypted: i=1; AJvYcCX2eTAQ44wlSpO3VIJJyOxCBZCcFkF4/CccVtzik71hpZ/WL1ovSaJDdRpFSmzjoxBOztwdX+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrzIcGeBxfs9Hk1mWx/cqFZxV3JEoodztBbJ5GNR1woc3AVH8
	aJKkZsubrjp+vG5AKwbTHBVOZkVaq/mFOmEaxG5MYjZASOw5rGHBx8HnB5E1WnhRfLc6qv79pr9
	5PggE9OZSi4DSncDGAzppXXNvOvlF8WU8aAQ81+I1550dWoOQONTapWM8wA==
X-Gm-Gg: AZuq6aL0DpB30kLjy8rCbswgFQPvwdVK6aOmHP+6+5+A/PRJkhjWY7rU1xAGQP6TIVi
	qb7o17Cgq7a5sqzgMTsW1qIPdMLj728Nd8RVbJcsqni8zvACeVA2E66vdzpYB7w6PWI1SPPJpOx
	f6cekN2MrRC3Fyl7xtges+Tv1A8EQjn2L5BELwRoN73x5jtjHHCSd63bSZIN1R2bKvY9Cef9yLQ
	uRRFnceObljAbsCBZ9kDmoFFtALOcOY4Xzbz2sTsnQ2fiot6DS8xTWPsNztHcTFRnqsRCldD3Q/
	miD2202/6R/jyDlGbJp/txjtPjEesRjFHnc2Qf9AmluxgLH6bWfInLNk6bL9Ak59jMLGrHq7BNW
	JAgvhfVTl56IqjfdfVRZtOX8XXwdoFsUTOw==
X-Received: by 2002:a05:6000:438a:b0:435:96b7:e0db with SMTP id ffacd0b85a97d-43617e410b4mr7285337f8f.17.1770269464000;
        Wed, 04 Feb 2026 21:31:04 -0800 (PST)
X-Received: by 2002:a05:6000:438a:b0:435:96b7:e0db with SMTP id ffacd0b85a97d-43617e410b4mr7285299f8f.17.1770269463212;
        Wed, 04 Feb 2026 21:31:03 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43618058473sm11403362f8f.22.2026.02.04.21.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 21:31:02 -0800 (PST)
Date: Thu, 5 Feb 2026 00:30:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v4 1/2] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260205000916-mutt-send-email-mst@kernel.org>
References: <20260204193617.1200752-1-vishs@meta.com>
 <20260204193617.1200752-2-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204193617.1200752-2-vishs@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256971-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CDCEEEC04
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:36:16AM -0800, Vishwanath Seshagiri wrote:
> Use page_pool for RX buffer allocation in mergeable and small buffer
> modes to enable page recycling and avoid repeated page allocator calls.
> skb_mark_for_recycle() enables page reuse in the network stack.
> 
> Big packets mode is unchanged because it uses page->private for linked
> list chaining of multiple pages per buffer, which conflicts with
> page_pool's internal use of page->private.
> 
> Implement conditional DMA premapping using virtqueue_dma_dev():
> - When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
>   handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
> - When NULL (VDUSE, direct physical): page_pool handles allocation only,
>   submit via virtqueue_add_inbuf_ctx()
> 
> This preserves the DMA premapping optimization from commit 31f3cd4e5756b
> ("virtio-net: rq submits premapped per-buffer") while adding page_pool
> support as a prerequisite for future zero-copy features (devmem TCP,
> io_uring ZCRX).
> 
> Page pools are created in probe and destroyed in remove (not open/close),
> following existing driver behavior where RX buffers remain in virtqueues
> across interface state changes.
> 
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  drivers/net/Kconfig      |   1 +
>  drivers/net/virtio_net.c | 351 ++++++++++++++++++++++-----------------
>  2 files changed, 201 insertions(+), 151 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index ac12eaf11755..f1e6b6b0a86f 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -450,6 +450,7 @@ config VIRTIO_NET
>  	depends on VIRTIO
>  	select NET_FAILOVER
>  	select DIMLIB
> +	select PAGE_POOL
>  	help
>  	  This is the virtual network driver for virtio.  It can be used with
>  	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..74c51e597c3f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
> +#include <net/page_pool/helpers.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -359,6 +360,11 @@ struct receive_queue {
>  	/* Page frag for packet buffer allocation. */
>  	struct page_frag alloc_frag;
>  
> +	struct page_pool *page_pool;
> +
> +	/* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
> +	bool use_page_pool_dma;
> +
>  	/* RX: fragments + linear part + virtio header */
>  	struct scatterlist sg[MAX_SKB_FRAGS + 2];
>  
> @@ -521,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  			       struct virtnet_rq_stats *stats);
>  static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
>  				 struct sk_buff *skb, u8 flags);
> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> +					       struct sk_buff *head_skb,
>  					       struct sk_buff *curr_skb,
>  					       struct page *page, void *buf,
>  					       int len, int truesize);
>  static void virtnet_xsk_completed(struct send_queue *sq, int num);
> +static void free_unused_bufs(struct virtnet_info *vi);
>  
>  enum virtnet_xmit_type {
>  	VIRTNET_XMIT_TYPE_SKB,
> @@ -706,15 +714,24 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>  	return p;
>  }
>  
> +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
> +			     bool allow_direct)
> +{
> +	if (page_pool_page_is_pp(page))
> +		page_pool_put_page(rq->page_pool, page, -1, allow_direct);
> +	else
> +		put_page(page);
> +}
> +
>  static void virtnet_rq_free_buf(struct virtnet_info *vi,
>  				struct receive_queue *rq, void *buf)
>  {
>  	if (vi->mergeable_rx_bufs)
> -		put_page(virt_to_head_page(buf));
> +		virtnet_put_page(rq, virt_to_head_page(buf), false);
>  	else if (vi->big_packets)
>  		give_pages(rq, buf);
>  	else
> -		put_page(virt_to_head_page(buf));
> +		virtnet_put_page(rq, virt_to_head_page(buf), false);
>  }
>  
>  static void enable_rx_mode_work(struct virtnet_info *vi)
> @@ -877,9 +894,12 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  		if (unlikely(!skb))
>  			return NULL;
>  
> -		page = (struct page *)page->private;
> -		if (page)
> -			give_pages(rq, page);
> +		if (!rq->page_pool) {

I think this is ok because big_packets is exactly when this happens.
but it is confusing that the conditions on free and alloc are
written differently. A comment with an explanation, at least?


> +			page = (struct page *)page->private;
> +			if (page)
> +				give_pages(rq, page);
> +		}
> +
>  		goto ok;
>  	}
>  
> @@ -925,7 +945,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	hdr = skb_vnet_common_hdr(skb);
>  	memcpy(hdr, hdr_p, hdr_len);
>  	if (page_to_free)
> -		put_page(page_to_free);
> +		virtnet_put_page(rq, page_to_free, true);
>  
>  	return skb;
>  }
> @@ -965,93 +985,10 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
>  static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>  {
>  	struct virtnet_info *vi = rq->vq->vdev->priv;
> -	void *buf;
> -
> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -	if (buf)
> -		virtnet_rq_unmap(rq, buf, *len);
> -
> -	return buf;
> -}
> -
> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
> -{
> -	struct virtnet_info *vi = rq->vq->vdev->priv;
> -	struct virtnet_rq_dma *dma;
> -	dma_addr_t addr;
> -	u32 offset;
> -	void *head;
> -
> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -	head = page_address(rq->alloc_frag.page);
> -
> -	offset = buf - head;
> -
> -	dma = head;
> -
> -	addr = dma->addr - sizeof(*dma) + offset;
> -
> -	sg_init_table(rq->sg, 1);
> -	sg_fill_dma(rq->sg, addr, len);
> -}
> -
> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> -{
> -	struct page_frag *alloc_frag = &rq->alloc_frag;
> -	struct virtnet_info *vi = rq->vq->vdev->priv;
> -	struct virtnet_rq_dma *dma;
> -	void *buf, *head;
> -	dma_addr_t addr;
>  
>  	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>  
> -	head = page_address(alloc_frag->page);
> -
> -	dma = head;
> -
> -	/* new pages */
> -	if (!alloc_frag->offset) {
> -		if (rq->last_dma) {
> -			/* Now, the new page is allocated, the last dma
> -			 * will not be used. So the dma can be unmapped
> -			 * if the ref is 0.
> -			 */
> -			virtnet_rq_unmap(rq, rq->last_dma, 0);
> -			rq->last_dma = NULL;
> -		}
> -
> -		dma->len = alloc_frag->size - sizeof(*dma);
> -
> -		addr = virtqueue_map_single_attrs(rq->vq, dma + 1,
> -						  dma->len, DMA_FROM_DEVICE, 0);
> -		if (virtqueue_map_mapping_error(rq->vq, addr))
> -			return NULL;
> -
> -		dma->addr = addr;
> -		dma->need_sync = virtqueue_map_need_sync(rq->vq, addr);

it gives me pause that this patch never does sync.
don't you need page_pool_dma_sync_for_cpu somewhere?



> -
> -		/* Add a reference to dma to prevent the entire dma from
> -		 * being released during error handling. This reference
> -		 * will be freed after the pages are no longer used.
> -		 */
> -		get_page(alloc_frag->page);
> -		dma->ref = 1;
> -		alloc_frag->offset = sizeof(*dma);
> -
> -		rq->last_dma = dma;
> -	}
> -
> -	++dma->ref;
> -
> -	buf = head + alloc_frag->offset;
> -
> -	get_page(alloc_frag->page);
> -	alloc_frag->offset += size;
> -
> -	return buf;
> +	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>  }
>  
>  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> @@ -1067,9 +1004,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>  		return;
>  	}
>  
> -	if (!vi->big_packets || vi->mergeable_rx_bufs)
> -		virtnet_rq_unmap(rq, buf, 0);
> -
>  	virtnet_rq_free_buf(vi, rq, buf);
>  }
>  
> @@ -1335,7 +1269,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>  
>  		truesize = len;
>  
> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>  						    buf, len, truesize);
>  		if (!curr_skb) {
>  			put_page(page);
> @@ -1771,7 +1705,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	return ret;
>  }
>  
> -static void put_xdp_frags(struct xdp_buff *xdp)
> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp)
>  {
>  	struct skb_shared_info *shinfo;
>  	struct page *xdp_page;
> @@ -1781,7 +1715,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>  		shinfo = xdp_get_shared_info_from_buff(xdp);
>  		for (i = 0; i < shinfo->nr_frags; i++) {
>  			xdp_page = skb_frag_page(&shinfo->frags[i]);
> -			put_page(xdp_page);
> +			virtnet_put_page(rq, xdp_page, true);
>  		}
>  	}
>  }
> @@ -1873,7 +1807,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>  	if (page_off + *len + tailroom > PAGE_SIZE)
>  		return NULL;
>  
> -	page = alloc_page(GFP_ATOMIC);
> +	page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>  	if (!page)
>  		return NULL;
>  
> @@ -1897,7 +1831,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>  		off = buf - page_address(p);
>  
>  		if (check_mergeable_len(dev, ctx, buflen)) {
> -			put_page(p);
> +			virtnet_put_page(rq, p, true);
>  			goto err_buf;
>  		}
>  
> @@ -1905,21 +1839,21 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>  		 * is sending packet larger than the MTU.
>  		 */
>  		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
> -			put_page(p);
> +			virtnet_put_page(rq, p, true);
>  			goto err_buf;
>  		}
>  
>  		memcpy(page_address(page) + page_off,
>  		       page_address(p) + off, buflen);
>  		page_off += buflen;
> -		put_page(p);
> +		virtnet_put_page(rq, p, true);
>  	}
>  
>  	/* Headroom does not contribute to packet length */
>  	*len = page_off - XDP_PACKET_HEADROOM;
>  	return page;
>  err_buf:
> -	__free_pages(page, 0);
> +	page_pool_put_page(rq->page_pool, page, -1, true);
>  	return NULL;
>  }
>  
> @@ -1996,7 +1930,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  			goto err_xdp;
>  
>  		buf = page_address(xdp_page);
> -		put_page(page);
> +		virtnet_put_page(rq, page, true);
>  		page = xdp_page;
>  	}
>  
> @@ -2028,13 +1962,15 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  	if (metasize)
>  		skb_metadata_set(skb, metasize);
>  
> +	skb_mark_for_recycle(skb);
> +
>  	return skb;
>  
>  err_xdp:
>  	u64_stats_inc(&stats->xdp_drops);
>  err:
>  	u64_stats_inc(&stats->drops);
> -	put_page(page);
> +	virtnet_put_page(rq, page, true);
>  xdp_xmit:
>  	return NULL;
>  }
> @@ -2082,12 +2018,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	}
>  
>  	skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
> -	if (likely(skb))
> +	if (likely(skb)) {
> +		skb_mark_for_recycle(skb);
>  		return skb;
> +	}
>  
>  err:
>  	u64_stats_inc(&stats->drops);
> -	put_page(page);
> +	virtnet_put_page(rq, page, true);
>  	return NULL;
>  }
>  
> @@ -2142,7 +2080,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>  		}
>  		u64_stats_add(&stats->bytes, len);
>  		page = virt_to_head_page(buf);
> -		put_page(page);
> +		virtnet_put_page(rq, page, true);
>  	}
>  }
>  
> @@ -2253,7 +2191,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  		offset = buf - page_address(page);
>  
>  		if (check_mergeable_len(dev, ctx, len)) {
> -			put_page(page);
> +			virtnet_put_page(rq, page, true);
>  			goto err;
>  		}
>  
> @@ -2272,7 +2210,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  	return 0;
>  
>  err:
> -	put_xdp_frags(xdp);
> +	put_xdp_frags(rq, xdp);
>  	return -EINVAL;
>  }
>  
> @@ -2337,7 +2275,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  		if (*len + xdp_room > PAGE_SIZE)
>  			return NULL;
>  
> -		xdp_page = alloc_page(GFP_ATOMIC);
> +		xdp_page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>  		if (!xdp_page)
>  			return NULL;
>  
> @@ -2347,7 +2285,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  
>  	*frame_sz = PAGE_SIZE;
>  
> -	put_page(*page);
> +	virtnet_put_page(rq, *page, true);
>  
>  	*page = xdp_page;
>  
> @@ -2393,6 +2331,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>  		if (unlikely(!head_skb))
>  			break;
> +
> +		skb_mark_for_recycle(head_skb);
>  		return head_skb;
>  
>  	case XDP_TX:
> @@ -2403,10 +2343,10 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  		break;
>  	}
>  
> -	put_xdp_frags(&xdp);
> +	put_xdp_frags(rq, &xdp);
>  
>  err_xdp:
> -	put_page(page);
> +	virtnet_put_page(rq, page, true);
>  	mergeable_buf_free(rq, num_buf, dev, stats);
>  
>  	u64_stats_inc(&stats->xdp_drops);
> @@ -2414,7 +2354,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  	return NULL;
>  }
>  
> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> +					       struct sk_buff *head_skb,
>  					       struct sk_buff *curr_skb,
>  					       struct page *page, void *buf,
>  					       int len, int truesize)
> @@ -2446,7 +2387,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>  
>  	offset = buf - page_address(page);
>  	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
> -		put_page(page);
> +		virtnet_put_page(rq, page, true);
>  		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>  				     len, truesize);
>  	} else {
> @@ -2499,6 +2440,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  
>  	if (unlikely(!curr_skb))
>  		goto err_skb;
> +
> +	skb_mark_for_recycle(head_skb);
>  	while (--num_buf) {
>  		buf = virtnet_rq_get_buf(rq, &len, &ctx);
>  		if (unlikely(!buf)) {
> @@ -2517,7 +2460,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  			goto err_skb;
>  
>  		truesize = mergeable_ctx_to_truesize(ctx);
> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>  						    buf, len, truesize);
>  		if (!curr_skb)
>  			goto err_skb;
> @@ -2527,7 +2470,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	return head_skb;
>  
>  err_skb:
> -	put_page(page);
> +	virtnet_put_page(rq, page, true);
>  	mergeable_buf_free(rq, num_buf, dev, stats);
>  
>  err_buf:
> @@ -2666,32 +2609,42 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  			     gfp_t gfp)
>  {
> -	char *buf;
>  	unsigned int xdp_headroom = virtnet_get_headroom(vi);
>  	void *ctx = (void *)(unsigned long)xdp_headroom;
>  	int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
> +	unsigned int offset;
> +	struct page *page;
> +	dma_addr_t addr;
> +	char *buf;
>  	int err;
>  
>  	len = SKB_DATA_ALIGN(len) +
>  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> -	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> -		return -ENOMEM;
> -
> -	buf = virtnet_rq_alloc(rq, len, gfp);
> -	if (unlikely(!buf))
> +	page = page_pool_alloc_frag(rq->page_pool, &offset, len, gfp);
> +	if (unlikely(!page))
>  		return -ENOMEM;
>  
> +	buf = page_address(page) + offset;
>  	buf += VIRTNET_RX_PAD + xdp_headroom;
>  
> -	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
> +	if (rq->use_page_pool_dma) {
> +		addr = page_pool_get_dma_addr(page) + offset;
> +		addr += VIRTNET_RX_PAD + xdp_headroom;
>  
> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
> -	if (err < 0) {
> -		virtnet_rq_unmap(rq, buf, 0);
> -		put_page(virt_to_head_page(buf));
> +		sg_init_table(rq->sg, 1);
> +		sg_fill_dma(rq->sg, addr, vi->hdr_len + GOOD_PACKET_LEN);
> +		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
> +						    buf, ctx, gfp);
> +	} else {
> +		sg_init_one(rq->sg, buf, vi->hdr_len + GOOD_PACKET_LEN);
> +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
> +					      buf, ctx, gfp);
>  	}
>  
> +	if (err < 0)
> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
> +				   -1, false);
>  	return err;
>  }
>  
> @@ -2764,13 +2717,15 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>  static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  				 struct receive_queue *rq, gfp_t gfp)
>  {
> -	struct page_frag *alloc_frag = &rq->alloc_frag;
>  	unsigned int headroom = virtnet_get_headroom(vi);
>  	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>  	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
>  	unsigned int len, hole;
> -	void *ctx;
> +	unsigned int offset;
> +	struct page *page;
> +	dma_addr_t addr;
>  	char *buf;
> +	void *ctx;
>  	int err;
>  
>  	/* Extra tailroom is needed to satisfy XDP's assumption. This
> @@ -2779,18 +2734,14 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	 */
>  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>  
> -	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> -		return -ENOMEM;
> -
> -	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> -		len -= sizeof(struct virtnet_rq_dma);
> -
> -	buf = virtnet_rq_alloc(rq, len + room, gfp);
> -	if (unlikely(!buf))
> +	page = page_pool_alloc_frag(rq->page_pool, &offset, len + room, gfp);
> +	if (unlikely(!page))
>  		return -ENOMEM;
>  
> +	buf = page_address(page) + offset;
>  	buf += headroom; /* advance address leaving hole at front of pkt */
> -	hole = alloc_frag->size - alloc_frag->offset;
> +
> +	hole = PAGE_SIZE - (offset + len + room);
>  	if (hole < len + room) {
>  		/* To avoid internal fragmentation, if there is very likely not
>  		 * enough space for another buffer, add the remaining space to
> @@ -2800,18 +2751,27 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  		 */
>  		if (!headroom)
>  			len += hole;
> -		alloc_frag->offset += hole;

Hmm. All these allocations are tricky.
So we used to advance offset by hole but with page pool api
what advances pool->frag_offset? If nothing will not the next
small allocation reuse the space and overlap the buffer?


>  	}
>  
> -	virtnet_rq_init_one_sg(rq, buf, len);
> -
>  	ctx = mergeable_len_to_ctx(len + room, headroom);
> -	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
> -	if (err < 0) {
> -		virtnet_rq_unmap(rq, buf, 0);
> -		put_page(virt_to_head_page(buf));
> +
> +	if (rq->use_page_pool_dma) {
> +		addr = page_pool_get_dma_addr(page) + offset;
> +		addr += headroom;
> +
> +		sg_init_table(rq->sg, 1);
> +		sg_fill_dma(rq->sg, addr, len);
> +		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
> +						    buf, ctx, gfp);
> +	} else {
> +		sg_init_one(rq->sg, buf, len);
> +		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
> +					      buf, ctx, gfp);
>  	}
>  
> +	if (err < 0)
> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
> +				   -1, false);
>  	return err;
>  }
>  
> @@ -3128,7 +3088,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  		return err;
>  
>  	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
> -					 MEM_TYPE_PAGE_SHARED, NULL);
> +					 vi->rq[qp_index].page_pool ?
> +						MEM_TYPE_PAGE_POOL :
> +						MEM_TYPE_PAGE_SHARED,
> +					 vi->rq[qp_index].page_pool);
>  	if (err < 0)
>  		goto err_xdp_reg_mem_model;
>  
> @@ -3168,6 +3131,81 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>  		vi->duplex = duplex;
>  }
>  
> +static int virtnet_create_page_pools(struct virtnet_info *vi)
> +{
> +	int i, err;
> +
> +	if (!vi->mergeable_rx_bufs && vi->big_packets)
> +		return 0;
> +
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		struct receive_queue *rq = &vi->rq[i];
> +		struct page_pool_params pp_params = { 0 };
> +		struct device *dma_dev;
> +
> +		if (rq->page_pool)
> +			continue;
> +
> +		if (rq->xsk_pool)
> +			continue;
> +
> +		pp_params.order = 0;
> +		pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
> +		pp_params.nid = dev_to_node(vi->vdev->dev.parent);
> +		pp_params.netdev = vi->dev;
> +		pp_params.napi = &rq->napi;
> +
> +		/* Check if backend supports DMA API (e.g., vhost, virtio-pci).
> +		 * If so, use page_pool's DMA mapping for premapped buffers.
> +		 * Otherwise (e.g., VDUSE), page_pool only handles allocation.
> +		 */
> +		dma_dev = virtqueue_dma_dev(rq->vq);
> +		if (dma_dev) {
> +			pp_params.dev = dma_dev;
> +			pp_params.flags = PP_FLAG_DMA_MAP;
> +			pp_params.dma_dir = DMA_FROM_DEVICE;
> +			rq->use_page_pool_dma = true;
> +		} else {
> +			pp_params.dev = vi->vdev->dev.parent;
> +			pp_params.flags = 0;
> +			rq->use_page_pool_dma = false;
> +		}
> +
> +		rq->page_pool = page_pool_create(&pp_params);
> +		if (IS_ERR(rq->page_pool)) {
> +			err = PTR_ERR(rq->page_pool);
> +			rq->page_pool = NULL;
> +			goto err_cleanup;
> +		}
> +	}
> +	return 0;
> +
> +err_cleanup:
> +	while (--i >= 0) {
> +		struct receive_queue *rq = &vi->rq[i];
> +
> +		if (rq->page_pool) {
> +			page_pool_destroy(rq->page_pool);
> +			rq->page_pool = NULL;
> +		}
> +	}
> +	return err;
> +}
> +
> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		struct receive_queue *rq = &vi->rq[i];
> +
> +		if (rq->page_pool) {
> +			page_pool_destroy(rq->page_pool);
> +			rq->page_pool = NULL;
> +		}
> +	}
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -6441,10 +6479,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
>  		vi->sq[i].vq = vqs[txq2vq(i)];
>  	}
> -
>  	/* run here: ret == 0. */
>  
> -
>  err_find:
>  	kfree(ctx);
>  err_ctx:
> @@ -6945,6 +6981,14 @@ static int virtnet_probe(struct virtio_device *vdev)
>  			goto free;
>  	}
>  
> +	/* Create page pools for receive queues.
> +	 * Page pools are created at probe time so they can be used
> +	 * with premapped DMA addresses throughout the device lifetime.
> +	 */
> +	err = virtnet_create_page_pools(vi);
> +	if (err)
> +		goto free_irq_moder;
> +
>  #ifdef CONFIG_SYSFS
>  	if (vi->mergeable_rx_bufs)
>  		dev->sysfs_rx_queue_group = &virtio_net_mrg_rx_group;
> @@ -6958,7 +7002,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		vi->failover = net_failover_create(vi->dev);
>  		if (IS_ERR(vi->failover)) {
>  			err = PTR_ERR(vi->failover);
> -			goto free_vqs;
> +			goto free_page_pools;
>  		}
>  	}
>  
> @@ -7075,7 +7119,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	unregister_netdev(dev);
>  free_failover:
>  	net_failover_destroy(vi->failover);
> -free_vqs:
> +free_page_pools:
> +	virtnet_destroy_page_pools(vi);
> +free_irq_moder:
> +	virtnet_free_irq_moder(vi);
>  	virtio_reset_device(vdev);
>  	free_receive_page_frags(vi);
>  	virtnet_del_vqs(vi);
> @@ -7104,6 +7151,8 @@ static void remove_vq_common(struct virtnet_info *vi)
>  
>  	free_receive_page_frags(vi);
>  
> +	virtnet_destroy_page_pools(vi);
> +
>  	virtnet_del_vqs(vi);
>  }
>  
> -- 
> 2.47.3


