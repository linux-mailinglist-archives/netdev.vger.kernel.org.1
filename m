Return-Path: <netdev+bounces-46759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5646B7E63F9
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 07:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB6F281123
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 06:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118B26AA7;
	Thu,  9 Nov 2023 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZPBjv9f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF6153B8
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 06:37:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C9926AB
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 22:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699511872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtKHEENZYDYmMBeXLLs50ZBkd/xYn42eF6UW6agfhl4=;
	b=JZPBjv9f6DkBPx3l9MZ5Q1UC+5BlcBx9DQSQtGQsLouEKMHIx5gB3ycw5/Unc2KezhZJTj
	Q/XfWB2QhLU6wdik7+gMod+QPa0tcF3ZecB+n46Pb4vtuf8BG6P3VdDkdclNRLvstKolIV
	h94+/Aqdd5kuzBiI5Epcl73bOp6nVqM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-V9rKi1NQOsiW1wGPmbV1AQ-1; Thu, 09 Nov 2023 01:37:51 -0500
X-MC-Unique: V9rKi1NQOsiW1wGPmbV1AQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5090b916b7fso515934e87.1
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 22:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699511870; x=1700116670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtKHEENZYDYmMBeXLLs50ZBkd/xYn42eF6UW6agfhl4=;
        b=qztzV92wfoQK2cilCJiNHGUwkF/R22t0q6pltOxDzDHHghu5qq7LEJhwFWu5X8Rwng
         kDFPDhWWiJIOkrKCgO4Z6yKZMmI5ixGZSHqWWnic+6eTJ/k4QMiiGJUCH3fH5yADsj5N
         tvZvT5bcs/LG5QLt4I6Tg9Ach2sDH+MpdVjanRnRAyTWd+tGq8CEuc5dEy+BEHNa5AjV
         qUWNKLxq2piBjraXf/5wjSN39rt9W58Bd+k5BHUaVpVDQ+xmmty5eWk5AC6raxXWXsyl
         kRj0d1yo9JRMwuisonopIZfCAKLauii1t3742XvqAy+t0MtR3H7mv13dTjBvdoIuBX2B
         PJ+g==
X-Gm-Message-State: AOJu0YwNTgQVTcUBp2Tmryy6JnBsUY02B2UGfLfzWYUZWDQC5mO/dMnQ
	6gjoBlGUDxrmBevCYcKUnm0186N3tYZvp7XBrlHNu4eMII0VX/idX5l0NDOyg+YM2lYs+x23Bi6
	N4p/sTvgPnbeRym4zldf1WmGPHjbXYz4L
X-Received: by 2002:a19:4f17:0:b0:503:2deb:bbc1 with SMTP id d23-20020a194f17000000b005032debbbc1mr457025lfb.22.1699511869959;
        Wed, 08 Nov 2023 22:37:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrnU37I8RO39L7e5VLqPopqt9qCt9JcGusGlz8jhqNX/DaVFn8ZE8ly03jmSQHtSQeYD7ZRfU/yMYJ5WzpZtw=
X-Received: by 2002:a19:4f17:0:b0:503:2deb:bbc1 with SMTP id
 d23-20020a194f17000000b005032debbbc1mr457015lfb.22.1699511869594; Wed, 08 Nov
 2023 22:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com> <20231107031227.100015-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231107031227.100015-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Nov 2023 14:37:38 +0800
Message-ID: <CACGkMEtLee8ELzqFnV_zOu3p5tU6hivouKM=WjtNAq+2wQzAFQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 08/21] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 163 ++++++++++++++++++++++++++++----
>  drivers/net/virtio/virtio_net.h |  16 ++++
>  2 files changed, 163 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 16e75c08639e..f052db459156 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -46,6 +46,7 @@ module_param(napi_tx, bool, 0644);
>  #define VIRTIO_XDP_REDIR       BIT(1)
>
>  #define VIRTIO_XDP_FLAG        BIT(0)
> +#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
>
>  #define VIRTNET_DRIVER_VERSION "1.0.0"
>
> @@ -167,6 +168,29 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
>  }
>
> +static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
> +{
> +       struct virtnet_sq_dma *next, *head;
> +
> +       head =3D (void *)((unsigned long)data & ~VIRTIO_XMIT_DATA_MASK);
> +
> +       data =3D head->data;
> +
> +       while (head) {
> +               virtqueue_dma_unmap_single_attrs(sq->vq, head->addr, head=
->len,
> +                                                DMA_TO_DEVICE, 0);
> +
> +               next =3D head->next;
> +
> +               head->next =3D sq->dmainfo.free;
> +               sq->dmainfo.free =3D head;
> +
> +               head =3D next;
> +       }
> +
> +       return data;
> +}
> +
>  static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
>                             u64 *bytes, u64 *packets)
>  {
> @@ -175,14 +199,24 @@ static void __free_old_xmit(struct virtnet_sq *sq, =
bool in_napi,
>
>         while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
>                 if (!is_xdp_frame(ptr)) {
> -                       struct sk_buff *skb =3D ptr;
> +                       struct sk_buff *skb;
> +
> +                       if (sq->do_dma)
> +                               ptr =3D virtnet_sq_unmap(sq, ptr);
> +
> +                       skb =3D ptr;
>
>                         pr_debug("Sent skb %p\n", skb);
>
>                         *bytes +=3D skb->len;
>                         napi_consume_skb(skb, in_napi);
>                 } else {
> -                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> +                       struct xdp_frame *frame;
> +
> +                       if (sq->do_dma)
> +                               ptr =3D virtnet_sq_unmap(sq, ptr);
> +
> +                       frame =3D ptr_to_xdp(ptr);
>
>                         *bytes +=3D xdp_get_frame_len(frame);
>                         xdp_return_frame(frame);
> @@ -567,22 +601,104 @@ static void *virtnet_rq_alloc(struct virtnet_rq *r=
q, u32 size, gfp_t gfp)
>         return buf;
>  }
>
> -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> +static int virtnet_sq_set_premapped(struct virtnet_sq *sq)
>  {
> -       int i;
> +       struct virtnet_sq_dma *d;
> +       int err, size, i;
>
> -       /* disable for big mode */
> -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> -               return;
> +       size =3D virtqueue_get_vring_size(sq->vq);
> +
> +       size +=3D MAX_SKB_FRAGS + 2;

Btw, the dmainfo seems per sg? If I'm correct, how can vq_size +
MAX_SKB_FRAGS + 2 work?

> +
> +       sq->dmainfo.head =3D kcalloc(size, sizeof(*sq->dmainfo.head), GFP=
_KERNEL);
> +       if (!sq->dmainfo.head)
> +               return -ENOMEM;
> +
> +       err =3D virtqueue_set_dma_premapped(sq->vq);
> +       if (err) {
> +               kfree(sq->dmainfo.head);
> +               return err;
> +       }

Allocating after set_dma_premapped() seems easier.

Btw, is there a benchmark of TX PPS just for this patch to demonstrate
the impact of the performance?

> +
> +       sq->dmainfo.free =3D NULL;
> +
> +       sq->do_dma =3D true;
> +
> +       for (i =3D 0; i < size; ++i) {
> +               d =3D &sq->dmainfo.head[i];
> +
> +               d->next =3D sq->dmainfo.free;
> +               sq->dmainfo.free =3D d;
> +       }
> +
> +       return 0;
> +}
> +
> +static void virtnet_set_premapped(struct virtnet_info *vi)
> +{
> +       int i;
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> -                       continue;
> +               virtnet_sq_set_premapped(&vi->sq[i]);
>
> -               vi->rq[i].do_dma =3D true;
> +               /* disable for big mode */
> +               if (vi->mergeable_rx_bufs || !vi->big_packets) {
> +                       if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
> +                               vi->rq[i].do_dma =3D true;

How about sticking a virtnet_rq_set_premapped() and calling it here?

It seems more clean.

Btw, the big mode support for pre mapping is still worthwhile
regardless whether or not XDP is supported. It has a page pool so we
can avoid redundant DMA map/unmap there.

> +               }
>         }
>  }
>
> +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct virtnet_sq *sq, i=
nt nents, void *data)
> +{
> +       struct virtnet_sq_dma *d, *head;
> +       struct scatterlist *sg;
> +       int i;
> +
> +       head =3D NULL;
> +
> +       for_each_sg(sq->sg, sg, nents, i) {
> +               sg->dma_address =3D virtqueue_dma_map_single_attrs(sq->vq=
, sg_virt(sg),
> +                                                                sg->leng=
th,
> +                                                                DMA_TO_D=
EVICE, 0);
> +               if (virtqueue_dma_mapping_error(sq->vq, sg->dma_address))
> +                       goto err;
> +
> +               d =3D sq->dmainfo.free;
> +               sq->dmainfo.free =3D d->next;
> +
> +               d->addr =3D sg->dma_address;
> +               d->len =3D sg->length;
> +
> +               d->next =3D head;
> +               head =3D d;
> +       }
> +
> +       head->data =3D data;
> +
> +       return (void *)((unsigned long)head | ((unsigned long)data & VIRT=
IO_XMIT_DATA_MASK));

So head contains a pointer to data, any reason we still need to pack a
data pointer here?


> +err:
> +       virtnet_sq_unmap(sq, head);
> +       return NULL;
> +}
> +
> +static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void *data=
)
> +{
> +       int ret;
> +
> +       if (sq->do_dma) {
> +               data =3D virtnet_sq_map_sg(sq, num, data);
> +               if (!data)
> +                       return -ENOMEM;
> +       }
> +
> +       ret =3D virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMI=
C);
> +       if (ret && sq->do_dma)
> +               virtnet_sq_unmap(sq, data);
> +
> +       return ret;
> +}
> +
>  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
>  {
>         u64 bytes, packets =3D 0;
> @@ -686,8 +802,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info=
 *vi,
>                             skb_frag_size(frag), skb_frag_off(frag));
>         }
>
> -       err =3D virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> -                                  xdp_to_ptr(xdpf), GFP_ATOMIC);
> +       err =3D virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
>         if (unlikely(err))
>                 return -ENOSPC; /* Caller handle free/refcnt */
>
> @@ -2126,7 +2241,8 @@ static int xmit_skb(struct virtnet_sq *sq, struct s=
k_buff *skb)
>                         return num_sg;
>                 num_sg++;
>         }
> -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOM=
IC);
> +
> +       return virtnet_add_outbuf(sq, num_sg, skb);
>  }
>
>  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *de=
v)
> @@ -3818,6 +3934,8 @@ static void virtnet_free_queues(struct virtnet_info=
 *vi)
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
>                 __netif_napi_del(&vi->rq[i].napi);
>                 __netif_napi_del(&vi->sq[i].napi);
> +
> +               kfree(vi->sq[i].dmainfo.head);
>         }
>
>         /* We called __netif_napi_del(),
> @@ -3866,10 +3984,23 @@ static void free_receive_page_frags(struct virtne=
t_info *vi)
>
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
> -       if (!is_xdp_frame(buf))
> +       struct virtnet_info *vi =3D vq->vdev->priv;
> +       struct virtnet_sq *sq;
> +       int i =3D vq2rxq(vq);
> +
> +       sq =3D &vi->sq[i];
> +
> +       if (!is_xdp_frame(buf)) {
> +               if (sq->do_dma)
> +                       buf =3D virtnet_sq_unmap(sq, buf);
> +
>                 dev_kfree_skb(buf);
> -       else
> +       } else {
> +               if (sq->do_dma)
> +                       buf =3D virtnet_sq_unmap(sq, buf);
> +
>                 xdp_return_frame(ptr_to_xdp(buf));
> +       }
>  }
>
>  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> @@ -4075,7 +4206,7 @@ static int init_vqs(struct virtnet_info *vi)
>         if (ret)
>                 goto err_free;
>
> -       virtnet_rq_set_premapped(vi);
> +       virtnet_set_premapped(vi);
>
>         cpus_read_lock();
>         virtnet_set_affinity(vi);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index d814341d9f97..ce806afb6d64 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -48,6 +48,18 @@ struct virtnet_rq_dma {
>         u16 need_sync;
>  };
>
> +struct virtnet_sq_dma {
> +       struct virtnet_sq_dma *next;
> +       dma_addr_t addr;
> +       u32 len;
> +       void *data;

I think we need to seek a way to reuse what has been stored by virtio
core. It should be much more efficient.

Thanks

> +};
> +
> +struct virtnet_sq_dma_head {
> +       struct virtnet_sq_dma *free;
> +       struct virtnet_sq_dma *head;
> +};
> +
>  /* Internal representation of a send virtqueue */
>  struct virtnet_sq {
>         /* Virtqueue associated with this virtnet_sq */
> @@ -67,6 +79,10 @@ struct virtnet_sq {
>
>         /* Record whether sq is in reset state. */
>         bool reset;
> +
> +       bool do_dma;
> +
> +       struct virtnet_sq_dma_head dmainfo;
>  };
>
>  /* Internal representation of a receive virtqueue */
> --
> 2.32.0.3.g01195cf9f
>


