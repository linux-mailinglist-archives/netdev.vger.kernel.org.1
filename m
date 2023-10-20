Return-Path: <netdev+bounces-42895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6FE7D08C9
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA5F1C20E3B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 06:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09563CA43;
	Fri, 20 Oct 2023 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3jXItfA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37028C8D5
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 06:51:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC201A3
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697784667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crwaKaePMEZqRzjOk6ARvGGv9aJDmk5zOwJBkKiIeIc=;
	b=D3jXItfAFM4Aa/xMHYhgGzbi+n69JvopkG5sFfd2i6BZHY1Nu+GW3V380RAZelVPCN/wo7
	0KNjkrMRISZcgZF6tQc+Rqsa6QIQSWzFdUI3IGTh4YNVrjbk/bSHfABMqnDu4p7HomqSOh
	H7AX69ImgZd7lU1oOcDeP3DKrdmRQ50=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-3zGGOKhtN6uMzPNbLa_hcw-1; Fri, 20 Oct 2023 02:51:05 -0400
X-MC-Unique: 3zGGOKhtN6uMzPNbLa_hcw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5079fd97838so428617e87.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784664; x=1698389464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crwaKaePMEZqRzjOk6ARvGGv9aJDmk5zOwJBkKiIeIc=;
        b=avp1OViDnsLEKGqRi4cTSM8Ea69OdFoFp4n3PCRjyA7OGiXKmqZNqO1wFFeJ6wRs6b
         BOQjyU+gl9TLLdD2a+ZUf4M0lCYydjavXOiXCSnt/u/xN0HiQnZHz0g6S42gFC7TehGl
         lMlfeYm95jAZq+3WUY5iU6vX+gY+OwzUjn/aLBVchvJEeFgVXXlGWhTox+Az9VmNIg/w
         3C+UNtTc4S7gqIvwdorEWoGswf3H52B19ITUPj8dgMTiFfMdahWWchOAS6fhXeKAc0ke
         aKgex2TUlPBt3cfs1lCAMZIStfXk5R5aUmaczMokLd4iH5QBoTqVMWjqrLHN/N6rSnu+
         hdhQ==
X-Gm-Message-State: AOJu0YwrrHiQQb/mCgm1L9N10Znfx7y/3xSw91oxPuvcQRI0catJKY/6
	s71ZuEIvWnT51mRyUPaoik7/W0xsxeMOp2G7e7XnGFUmAd4MqIsXylgFOxIwE6qPN+jgkvgtk3F
	Ak/LPKDNt9u4v/WfsC8sKZfWUbPE3iHjb
X-Received: by 2002:a05:6512:3094:b0:500:9dd4:2969 with SMTP id z20-20020a056512309400b005009dd42969mr619352lfd.59.1697784664115;
        Thu, 19 Oct 2023 23:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYQPJLf7vs3BLmZJ52qeoke4CdfBTo8vgI6dD81vASHojo8uRB5TjPI7cvhTZebQi6LtEdhmZ9zb7VvjcDQ/8=
X-Received: by 2002:a05:6512:3094:b0:500:9dd4:2969 with SMTP id
 z20-20020a056512309400b005009dd42969mr619342lfd.59.1697784663734; Thu, 19 Oct
 2023 23:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:50:52 +0800
Message-ID: <CACGkMEuq8i9_PX+vRESS3g2BpaWBv3FxDLMryG=aEJ+gAOsSaA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 08/19] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 108 ++++++++++++++++++++++++++++----
>  drivers/net/virtio/virtio_net.h |  54 +++++++++++++++-
>  2 files changed, 149 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 8da84ea9bcbe..02d27101fef1 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -514,20 +514,104 @@ static void *virtnet_rq_alloc(struct virtnet_rq *r=
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

Not specific to this patch but any plan to fix the big mode?


> +       size =3D virtqueue_get_vring_size(sq->vq);
> +
> +       size +=3D MAX_SKB_FRAGS + 2;
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
> +               if (!virtnet_sq_set_premapped(&vi->sq[i]))
> +                       vi->sq[i].do_dma =3D true;
> +
> +               /* disable for big mode */
> +               if (!vi->mergeable_rx_bufs && vi->big_packets)
>                         continue;
>
> -               vi->rq[i].do_dma =3D true;
> +               if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
> +                       vi->rq[i].do_dma =3D true;
> +       }
> +}
> +
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

It's really a pity that we need to duplicate those DMA metata twice.
Could we invent a new API to just fetch it from the virtio core?

> +       }
> +
> +       head->data =3D data;
> +
> +       return (void *)((unsigned long)head | ((unsigned long)data & VIRT=
IO_XMIT_DATA_MASK));

If we packed everything into dmainfo, we can leave the type (XDP vs
skb) there to avoid trick like packing it into the pointer here?

Thanks


