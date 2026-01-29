Return-Path: <netdev+bounces-254589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPSkMZP+emmHAQIAu9opvQ
	(envelope-from <netdev+bounces-254589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:30:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D890AC3C5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B0173019534
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A24318BB5;
	Thu, 29 Jan 2026 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvSJnoKt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGSb+xvT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972223793BD
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769668218; cv=none; b=RBPRq2IMFltCQD22jCmEAtaBXs3eLnBUnFUIN/owbu5/1+DMDE37x/yePtgbbItDADlnucogDF76MxNu3SnQvvu2DGF/hn5NyWVju2jPaeiXgmCWP1w8iHFTBVAQc8Aw4IyPgkczC232f0KI5/XHbinuXmAfl6G/xAENHGQDtO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769668218; c=relaxed/simple;
	bh=8QClyySW+wJVgknArgrur9ktWhv9cOQWP2hM9vwZEUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM/gj34tqB2VOK74FpPKbWL569/gMLk9O6LB71MF3K+3kbwN+RR1j4xiIC9zXHxMw+jMTN9PUCdvq84z2rOwqIKbC/hXqiNwvxVsYDoZfmLS2iBPpaE+V9PEvZS7qcv07dc5XzRLtW6uxnKxZjj9BxRChTwjwJekwTR152oWo4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvSJnoKt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGSb+xvT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769668215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYa8EZaTCN3bCG6/fsxPsqgYySk+lPWQCwt/l6kwY1g=;
	b=JvSJnoKt470YCuFhaLWnrupnCGV/izx9FSZ3c8TBXPUbaUAeqWS+y8oLUME3zeqMstY0AL
	SPhpO2EZ+wf9E2u7Up78tTcrIDtNWIEP5xMfFVzm93WlLexUrby6Uyb8jXLjpHmL4H5+3h
	Qye/ytBMuSdQTFqgF81prCKjGC9r7jY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-G3KvAzvEOwOstOKnZ97KNg-1; Thu, 29 Jan 2026 01:30:13 -0500
X-MC-Unique: G3KvAzvEOwOstOKnZ97KNg-1
X-Mimecast-MFC-AGG-ID: G3KvAzvEOwOstOKnZ97KNg_1769668212
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so4615215e9.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769668212; x=1770273012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYa8EZaTCN3bCG6/fsxPsqgYySk+lPWQCwt/l6kwY1g=;
        b=dGSb+xvTUyIABQ23P3RyjGpWC/cW0+OUGvh9O1+YF8KfS55bJnM3w1IHA4/HGGy6pB
         BtWOS3qNXAt60uqUKqmSfMWPiqevY8c/FtxbMcPjO3aAKEfe/nIhDtcSgvXO5ubwI1jp
         1KNL1Ktzps5c5TQ0WgrV130l26wj5UIWMcnvgLPG3BPqYykVsyEQK1o4SnDgMUqrDq+K
         g2ikkG0NLH+Kf3ydYPG0XCk+Yzy2kAmDtbvGUKLsr7J/hEfFU0wqZkfUjvFfkbMoX1Cb
         mPntSpG00u7Nik09WxdkMH0yxdhE7u1pM2TSu3toe0ceuxaEsrVWZGCYVuH3x6CD53I7
         cHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769668212; x=1770273012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYa8EZaTCN3bCG6/fsxPsqgYySk+lPWQCwt/l6kwY1g=;
        b=sfPp99GD+OpEqERPXtusRYECSAEaaXd/pMZxogz1GIeLBkui9QZCDDW5HHrzFMXPDs
         Y5yrPm+NGM0ThY8ZQ+OjTW46Zs2jGg4jfmFZJKwb2Jyewwcbv/rTMZA/LxKUwEOmoFe5
         NkOpJ+Awrs0oJRsVwZuA5g4o47yw8XzTiREjSfvwU7l1YMHAI3wJ7wl9neDPlqUQhIYi
         nW6wezuheyS6i690+qx2I45TCrdQyQB9N+cn4Tsch6mUibJxg639cOANhaclePZw9Pw3
         JEZCulRtR/t4jD1iLRWwK/Kr+D79xCXB984JZxPxyquz8YGCUH/z5G4XASWqxzL4UxbJ
         MaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5zkNnEOJLs9C9GJQpVec/Fh7W9CEa4Z+1OCTBeodsWJ5x6qFloGtModIWAL7jWSoNPeSLNC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3tWftiE33Z2yGhHiPqGA66gOMfzdC8oqLGGNbg1Eyz4VGJYx
	KImUdMFyuXPgaR3zQzU4HZjH5q2ZcOI03ZRosqx5poooFGWBN1mVObR+4Bh0RSs2E1dNVO0CDU7
	83TqVDjcLJuys3v5l38g/IHRS78u6vfouTQa2JDEU2gHg4utVmuRrAb4pZA==
X-Gm-Gg: AZuq6aJntm0xPWJBAAC6WPUBIk7Rsfbmo5+HY4zN66ppaLjlKpTGpfT631APJtDaNkH
	JaypKytFGo0l5xWENNIAsZV7cSoB91K3q0ZHDMUPXAkohyWJY1yfppVXBDLrxmTqTCJlBa8bZ0T
	yOMN/839AW42wRGZ5DlWsYPB3XOYG0T+PsNFB0thTK9qbiZghojZLnX4Mltbv3OP2upUxYaJZ4s
	mbsg00xMGss2Bo4XuOA8U7gHCI22NZFxcfsS2v2E3V/lWFymqSk3J0K1KhoHKwkOh1q6P+sGQgA
	m0IjkpH2fVwqJbNwdQNkCNrZz3VTysM6pFOzaVGQtzNISwKDvhiIkwq2vl1OVt/gB5mpak0yyX1
	PWOWMvNDl1cTBCXHG2X0rfdCdoRnddKisQQ==
X-Received: by 2002:a05:600c:458a:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-48069c16459mr88749005e9.5.1769668211903;
        Wed, 28 Jan 2026 22:30:11 -0800 (PST)
X-Received: by 2002:a05:600c:458a:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-48069c16459mr88748675e9.5.1769668211366;
        Wed, 28 Jan 2026 22:30:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5d3199csm2677665e9.3.2026.01.28.22.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 22:30:10 -0800 (PST)
Date: Thu, 29 Jan 2026 01:30:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/2] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260129012534-mutt-send-email-mst@kernel.org>
References: <20260128212031.1431746-1-vishs@meta.com>
 <20260128212031.1431746-2-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128212031.1431746-2-vishs@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254589-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D890AC3C5
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 01:20:30PM -0800, Vishwanath Seshagiri wrote:
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
> The rx_mode_work_enabled flag prevents virtnet_rx_mode_work() from
> sending control virtqueue commands while ndo_close is tearing down
> device state, avoiding virtqueue corruption during concurrent operations.
> 
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  drivers/net/Kconfig      |   1 +
>  drivers/net/virtio_net.c | 353 ++++++++++++++++++++++-----------------
>  2 files changed, 203 insertions(+), 151 deletions(-)
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
> index db88dcaefb20..df2a5fc5187e 100644
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
> @@ -706,15 +714,21 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>  	return p;
>  }
>  
> +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
> +			     bool allow_direct)
> +{
> +	page_pool_put_page(rq->page_pool, page, -1, allow_direct);
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


what I dislike here is how big_packets mode still pokes
at give_pages but other modes use the page pool.

Given all modes operate with struct page it's hard to
shake the feeling we could be trying to put a page
we did not get from the pool back into the pool,
or vice versa.



>  
>  static void enable_rx_mode_work(struct virtnet_info *vi)
> @@ -877,9 +891,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  		if (unlikely(!skb))
>  			return NULL;
>  
> -		page = (struct page *)page->private;
> -		if (page)
> -			give_pages(rq, page);
>  		goto ok;
>  	}
>

For example above you did not touch give_pages, here
you are ripping out give_pages. Superficially, weird.


I ask myself whether page pool is not better than the
homegrown linked list that give_pages uses, anyway.

Will need some perf testing though.

-- 
MST


