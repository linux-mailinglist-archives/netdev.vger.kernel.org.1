Return-Path: <netdev+bounces-42902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966277D08E9
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8282823B6
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 06:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC27ACA67;
	Fri, 20 Oct 2023 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhirjYki"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E55CA46
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 06:57:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564F198
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697785025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nuA0GPocUhVBXyHIV4VhNfFkda7gJjp7f9qx99UuIo=;
	b=JhirjYkiPtaQbnM7WcEhKmPLMKXgzRZl7NGxcOJ354TppxPeExxd053Q71F/5I/hbrg608
	ew9EW5E9V3QqllVqpKJxjeuR0hMoWHabF7gTFaL7eISUfHjoBfDv5z6/VTppTBi4TTzGlp
	D/T9sCo5jFGFowXCKFBJ58JMe/rSbMA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-BgnsHrjTOEuyAQ9FcJdzGA-1; Fri, 20 Oct 2023 02:57:04 -0400
X-MC-Unique: BgnsHrjTOEuyAQ9FcJdzGA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c50ef18b04so4088471fa.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697785022; x=1698389822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nuA0GPocUhVBXyHIV4VhNfFkda7gJjp7f9qx99UuIo=;
        b=gorGTKS7XF8Jwc4BSnuXsuG1OWANKKh5OsKJnMZNk4MsavoQ0NTidpXIRPRrwcuR0h
         H793lrw5SKRPidjn2OAzCK00EQkuJM8anCl9nD7kk21YYknG4crY5a1jK2wWSnriefNV
         Mt4JCKnbAiqV8nTWWSUISjQNn4l6iQfLPLfWkdeV7zb6SrZtVHlnvT6JCZtf8M3QF2jG
         cg7LdCrThha7KGIlQxCW/43+9b096RGkvo6Eq8nEcm/bVsXp48EnUjoTH9xqEi3vGRRe
         YHGa3Qn1tNQXfb5meWDXxhvMH1EwdBk9yaoSI0TZvwlII/SDdF9a7OY0FzJznwDOvoHu
         Rrag==
X-Gm-Message-State: AOJu0YxTggz4WQ8SjfSW/dJh+K6oeAW8cmlUSfGhZzG7DTEZ/zgcHujm
	botfab4hjFxhKLvoUdOHDU1w9vA0xeX0d07m49/4bqkBmXym6N1W3e8y+hqss2/qEXRI3VPQpnu
	bvQh+Hv+opjnSAyalEbVCVG0YP4INUZMB
X-Received: by 2002:a05:651c:503:b0:2b9:f13b:6139 with SMTP id o3-20020a05651c050300b002b9f13b6139mr933647ljp.20.1697785022602;
        Thu, 19 Oct 2023 23:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyiS9CtJpivNcN/BC7UP8A2JRRyUTtrbDm5S2vFHS4NRmSoZ9el8dfhVRFAkG3XMCzSSNmBlUmLSOyOvq7pQQ=
X-Received: by 2002:a05:651c:503:b0:2b9:f13b:6139 with SMTP id
 o3-20020a05651c050300b002b9f13b6139mr933628ljp.20.1697785022253; Thu, 19 Oct
 2023 23:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-16-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-16-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:56:51 +0800
Message-ID: <CACGkMEvmtUp4NxqiDVD3w5eDi5T4UYgnwYkGty+nfQS9h-bsuA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 15/19] virtio_net: xsk: rx: introduce add_recvbuf_xsk()
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
> Implement the logic of filling vq with XSK buffer.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 13 +++++++
>  drivers/net/virtio/virtio_net.h |  5 +++
>  drivers/net/virtio/xsk.c        | 66 ++++++++++++++++++++++++++++++++-
>  drivers/net/virtio/xsk.h        |  2 +
>  4 files changed, 85 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 58bb38f9b453..0e740447b142 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -1787,9 +1787,20 @@ static int add_recvbuf_mergeable(struct virtnet_in=
fo *vi,
>  static bool try_fill_recv(struct virtnet_info *vi, struct virtnet_rq *rq=
,
>                           gfp_t gfp)
>  {
> +       struct xsk_buff_pool *pool;
>         int err;
>         bool oom;
>
> +       rcu_read_lock();

A question here: should we sync with refill work during rx_pause?

> +       pool =3D rcu_dereference(rq->xsk.pool);
> +       if (pool) {
> +               err =3D virtnet_add_recvbuf_xsk(vi, rq, pool, gfp);
> +               oom =3D err =3D=3D -ENOMEM;
> +               rcu_read_unlock();
> +               goto kick;
> +       }
> +       rcu_read_unlock();

And if we synchronize with that there's probably no need for the rcu
and we can merge the logic with the following ones?

Thanks


> +
>         do {
>                 if (vi->mergeable_rx_bufs)
>                         err =3D add_recvbuf_mergeable(vi, rq, gfp);
> @@ -1802,6 +1813,8 @@ static bool try_fill_recv(struct virtnet_info *vi, =
struct virtnet_rq *rq,
>                 if (err)
>                         break;
>         } while (rq->vq->num_free);
> +
> +kick:
>         if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq)) {
>                 unsigned long flags;
>
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index d4e620a084f4..6e71622fca45 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -156,6 +156,11 @@ struct virtnet_rq {
>
>                 /* xdp rxq used by xsk */
>                 struct xdp_rxq_info xdp_rxq;
> +
> +               struct xdp_buff **xsk_buffs;
> +               u32 nxt_idx;
> +               u32 num;
> +               u32 size;
>         } xsk;
>  };
>
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index 973e783260c3..841fb078882a 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -37,6 +37,58 @@ static void virtnet_xsk_check_queue(struct virtnet_sq =
*sq)
>                 netif_stop_subqueue(dev, qnum);
>  }
>
> +static int virtnet_add_recvbuf_batch(struct virtnet_info *vi, struct vir=
tnet_rq *rq,
> +                                    struct xsk_buff_pool *pool, gfp_t gf=
p)
> +{
> +       struct xdp_buff **xsk_buffs;
> +       dma_addr_t addr;
> +       u32 len, i;
> +       int err =3D 0;
> +
> +       xsk_buffs =3D rq->xsk.xsk_buffs;
> +
> +       if (rq->xsk.nxt_idx >=3D rq->xsk.num) {
> +               rq->xsk.num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq-=
>xsk.size);
> +               if (!rq->xsk.num)
> +                       return -ENOMEM;
> +               rq->xsk.nxt_idx =3D 0;
> +       }
> +
> +       while (rq->xsk.nxt_idx < rq->xsk.num) {
> +               i =3D rq->xsk.nxt_idx;
> +
> +               /* use the part of XDP_PACKET_HEADROOM as the virtnet hdr=
 space */
> +               addr =3D xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len=
;
> +               len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> +
> +               sg_init_table(rq->sg, 1);
> +               sg_fill_dma(rq->sg, addr, len);
> +
> +               err =3D virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[=
i], gfp);
> +               if (err)
> +                       return err;
> +
> +               rq->xsk.nxt_idx++;
> +       }
> +
> +       return 0;
> +}
> +
> +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *=
rq,
> +                           struct xsk_buff_pool *pool, gfp_t gfp)
> +{
> +       int err;
> +
> +       do {
> +               err =3D virtnet_add_recvbuf_batch(vi, rq, pool, gfp);
> +               if (err)
> +                       return err;
> +
> +       } while (rq->vq->num_free);
> +
> +       return 0;
> +}
> +
>  static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
>                                 struct xsk_buff_pool *pool,
>                                 struct xdp_desc *desc)
> @@ -244,7 +296,7 @@ static int virtnet_xsk_pool_enable(struct net_device =
*dev,
>         struct virtnet_sq *sq;
>         struct device *dma_dev;
>         dma_addr_t hdr_dma;
> -       int err;
> +       int err, size;
>
>         /* In big_packets mode, xdp cannot work, so there is no need to
>          * initialize xsk of rq.
> @@ -276,6 +328,16 @@ static int virtnet_xsk_pool_enable(struct net_device=
 *dev,
>         if (!dma_dev)
>                 return -EPERM;
>
> +       size =3D virtqueue_get_vring_size(rq->vq);
> +
> +       rq->xsk.xsk_buffs =3D kcalloc(size, sizeof(*rq->xsk.xsk_buffs), G=
FP_KERNEL);
> +       if (!rq->xsk.xsk_buffs)
> +               return -ENOMEM;
> +
> +       rq->xsk.size =3D size;
> +       rq->xsk.nxt_idx =3D 0;
> +       rq->xsk.num =3D 0;
> +
>         hdr_dma =3D dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO=
_DEVICE);
>         if (dma_mapping_error(dma_dev, hdr_dma))
>                 return -ENOMEM;
> @@ -338,6 +400,8 @@ static int virtnet_xsk_pool_disable(struct net_device=
 *dev, u16 qid)
>         err1 =3D virtnet_sq_bind_xsk_pool(vi, sq, NULL);
>         err2 =3D virtnet_rq_bind_xsk_pool(vi, rq, NULL);
>
> +       kfree(rq->xsk.xsk_buffs);
> +
>         return err1 | err2;
>  }
>
> diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> index 7ebc9bda7aee..bef41a3f954e 100644
> --- a/drivers/net/virtio/xsk.h
> +++ b/drivers/net/virtio/xsk.h
> @@ -23,4 +23,6 @@ int virtnet_xsk_pool_setup(struct net_device *dev, stru=
ct netdev_bpf *xdp);
>  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
>                       int budget);
>  int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
> +int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct virtnet_rq *=
rq,
> +                           struct xsk_buff_pool *pool, gfp_t gfp);
>  #endif
> --
> 2.32.0.3.g01195cf9f
>


