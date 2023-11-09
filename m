Return-Path: <netdev+bounces-46829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335E97E6951
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AA31C20982
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D09A199C7;
	Thu,  9 Nov 2023 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRFQaGs3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B63199B9
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 11:11:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40CF2D61
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 03:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699528317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yt46k1gaWUK9F9QI0TVQheyvh5AEUMeq8PXPEShUUi4=;
	b=aRFQaGs3GMsFNbvUgeBRlrvsEvyZv8BHYPIFJxm+rwwTx1Tmyy+sUQREto5VkXMaZ6p6Ym
	W+NzoJKfuaGpk6LIiQ3pfwbJQ1utlIgOSFapx+uguzABwy/QaFhdTwUXYrZKoOm1PWI7XO
	H8SEE/mEGwfF0jpvCtM+DWeHBlLEKJw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-slC_Nyf0O7Kx3dLpYbIbyw-1; Thu, 09 Nov 2023 06:11:55 -0500
X-MC-Unique: slC_Nyf0O7Kx3dLpYbIbyw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9d28dd67464so60627066b.0
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 03:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699528314; x=1700133114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt46k1gaWUK9F9QI0TVQheyvh5AEUMeq8PXPEShUUi4=;
        b=YSe1qgPXI1vhHWr4dksG7jqnhnnItkVk1Z0JP07VT4pjA1HdiJfne51HHstFWkuhGd
         eWL7gRRP1ZQIcs52Nik4e5wzq7nPwTpIjHWH9hkKAI9oAmvogWUUuj/JHNPzNmRL6OVA
         WKvrq4QaZHXVBr1e52bSeo5Pvg/Jau1tmcnXux1KaW5gMmhrqMUOD/R9P8gclROUSZkB
         o7maJD2lfUHrlE5dFDGTFLIYVCf8qF1Sdk66dJ4Mrzad92lkH4AQLHt0WU0YxTTbaUJ5
         uZ6PizdLB94N8/ZG21gr7Qa0doSSe21V/qzLtaFWLgeSNC4RNex4UzDQWHwXq0ONV/8u
         YWCw==
X-Gm-Message-State: AOJu0YzRrGYtL/Zeq8X9whbQwN9KZ6RT4Hk1jEag2LjAei4wM/sKTnvY
	8w73RfkOXrGBBCkjGdCpnT6CvvD68VvgDR5fkH5XLL8x7LjGLke26ZOMiass+mo5UyTn+4PfEYZ
	NURsHCj9w8fnWUTFC
X-Received: by 2002:a17:906:6ad2:b0:9e3:b1e5:aec3 with SMTP id q18-20020a1709066ad200b009e3b1e5aec3mr3584083ejs.0.1699528314424;
        Thu, 09 Nov 2023 03:11:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjIMBXqhnmChgJrfCkCeXUiEtZSoZ7DFa981GF1hUgpwf/KohLlOYFimkA42A2/YDlj0hP5g==
X-Received: by 2002:a17:906:6ad2:b0:9e3:b1e5:aec3 with SMTP id q18-20020a1709066ad200b009e3b1e5aec3mr3584070ejs.0.1699528314115;
        Thu, 09 Nov 2023 03:11:54 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id qu25-20020a170907111900b009de11cc12d2sm2406072ejb.55.2023.11.09.03.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:11:53 -0800 (PST)
Date: Thu, 9 Nov 2023 06:11:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 14/21] virtio_net: xsk: tx:
 virtnet_free_old_xmit() distinguishes xsk buffer
Message-ID: <20231109061056-mutt-send-email-mst@kernel.org>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-15-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107031227.100015-15-xuanzhuo@linux.alibaba.com>

On Tue, Nov 07, 2023 at 11:12:20AM +0800, Xuan Zhuo wrote:
> virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
> buffer) by the last bits of the pointer.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/virtio_net.h | 18 ++++++++++++++++--
>  drivers/net/virtio/xsk.h        |  5 +++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> index a431a2c1ee47..a13d6d301fdb 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -225,6 +225,11 @@ struct virtnet_info {
>  	struct failover *failover;
>  };
>  
> +static inline bool virtnet_is_skb_ptr(void *ptr)
> +{
> +	return !((unsigned long)ptr & VIRTIO_XMIT_DATA_MASK);
> +}
> +
>  static inline bool virtnet_is_xdp_frame(void *ptr)
>  {
>  	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> @@ -235,6 +240,8 @@ static inline struct xdp_frame *virtnet_ptr_to_xdp(void *ptr)
>  	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
>  }
>  
> +static inline u32 virtnet_ptr_to_xsk(void *ptr);
> +

I don't understand why you need this here.


>  static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
>  {
>  	struct virtnet_sq_dma *next, *head;
> @@ -261,11 +268,12 @@ static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
>  static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
>  					 u64 *bytes, u64 *packets)
>  {
> +	unsigned int xsknum = 0;
>  	unsigned int len;
>  	void *ptr;
>  
>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> -		if (!virtnet_is_xdp_frame(ptr)) {
> +		if (virtnet_is_skb_ptr(ptr)) {
>  			struct sk_buff *skb;
>  
>  			if (sq->do_dma)
> @@ -277,7 +285,7 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
>  
>  			*bytes += skb->len;
>  			napi_consume_skb(skb, in_napi);
> -		} else {
> +		} else if (virtnet_is_xdp_frame(ptr)) {
>  			struct xdp_frame *frame;
>  
>  			if (sq->do_dma)
> @@ -287,9 +295,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
>  
>  			*bytes += xdp_get_frame_len(frame);
>  			xdp_return_frame(frame);
> +		} else {
> +			*bytes += virtnet_ptr_to_xsk(ptr);
> +			++xsknum;
>  		}
>  		(*packets)++;
>  	}
> +
> +	if (xsknum)
> +		xsk_tx_completed(sq->xsk.pool, xsknum);
>  }
>  
>  static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> index 1bd19dcda649..7ebc9bda7aee 100644
> --- a/drivers/net/virtio/xsk.h
> +++ b/drivers/net/virtio/xsk.h
> @@ -14,6 +14,11 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
>  	return (void *)(p | VIRTIO_XSK_FLAG);
>  }
>  
> +static inline u32 virtnet_ptr_to_xsk(void *ptr)
> +{
> +	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
> +}
> +
>  int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
>  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
>  		      int budget);
> -- 
> 2.32.0.3.g01195cf9f


