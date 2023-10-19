Return-Path: <netdev+bounces-42493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD387CEE9A
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 06:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28987B20E63
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 04:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B4A46669;
	Thu, 19 Oct 2023 04:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEqFaGsG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D003817C2
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 04:24:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FCE121
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 21:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697689443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uje06+IDMOt/vx/J8KUApszxQg4fGF227v/uCWaECeA=;
	b=cEqFaGsGY9oY1ctsDGt1IqqyZmlEmROmHyLkx6Jpo2pS9+YIygixq4Czx+w/bYJj2kLATT
	0aOUnMDiaAkSzsAXw+gpviHfOWGp2iLYVZ4wbq2cgl0tcou5Se5VL0CXzEwyTG4EhHXSwo
	AisMQR3u1gGnoHlatZ45icQM41kW2+M=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-4HE0zxCGPbeDm08jxSGmfw-1; Thu, 19 Oct 2023 00:24:01 -0400
X-MC-Unique: 4HE0zxCGPbeDm08jxSGmfw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507d2e150c2so31595e87.3
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 21:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697689440; x=1698294240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uje06+IDMOt/vx/J8KUApszxQg4fGF227v/uCWaECeA=;
        b=TvLllRUPdgsJgAoYp7LOtikCCjvMg7DRjyPcnGvQav+rkuy622evXX5CrBeHJhtAAM
         0FWGGQdawNKgD8EHbBjajOa0d/7xZ44owgXuMvxihhVRaFgx0OfxEShIG7/NF16XAc69
         VdBq5iRz/U8+YXqJ0dCZTz6jOd7/8ZUNGhBTALscRz1UJpZ/f0WTinyOeeJWdE+sDhYk
         lwVz6tu14mmnsCK4tHv++/K3LWN5gN4NtKuqAQrRVktp1wA0Mgo9GGyF6muid+cbBknA
         8IMRsPcwwstUE1VmSX9xaiFELtcPrBHZmVrYPZVvMdUrWTsguYvFOt/A3pJkea78oziW
         vKuw==
X-Gm-Message-State: AOJu0Yy3/HpaftszSczXuyuIXAAd+pAq7RKlEANGuMjzG+rvV7pPxsbL
	dfBNdHKr6ohRHfOY4ilufAZo/0XzmUy/u6puaaz1wzJJGXjIPtfOyPm+Opj0d9RCpjfFeMejZog
	jgvE4w1qKI4sdN6p6oyE8IryqVbPT2nV5
X-Received: by 2002:a19:ee14:0:b0:500:7685:83d with SMTP id g20-20020a19ee14000000b005007685083dmr568833lfb.48.1697689439819;
        Wed, 18 Oct 2023 21:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0cSd1leA1z1IEbWaSrC+PUAKHLFPVSoCz7pyb25FZIitCtvt4UQzpR1S+XpCSPSBkYRmEQ65C+ZNEeRGxNQA=
X-Received: by 2002:a19:ee14:0:b0:500:7685:83d with SMTP id
 g20-20020a19ee14000000b005007685083dmr568824lfb.48.1697689439457; Wed, 18 Oct
 2023 21:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 12:23:48 +0800
Message-ID: <CACGkMEvU+nhC=Qaj_gWGi3osGgTYdwVDav4-1fs2BrbvDOEpyg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 02/19] virtio_net: unify the code for
 recycling the xmit ptr
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> There are two completely similar and independent implementations. This
> is inconvenient for the subsequent addition of new types. So extract a
> function from this piece of code and call this function uniformly to
> recover old xmit ptr.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 76 +++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3d87386d8220..6cf77b6acdab 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -352,6 +352,30 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
>  }
>
> +static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> +                           struct virtnet_sq_stats *stats)
> +{
> +       unsigned int len;
> +       void *ptr;
> +
> +       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> +               if (!is_xdp_frame(ptr)) {
> +                       struct sk_buff *skb =3D ptr;
> +
> +                       pr_debug("Sent skb %p\n", skb);
> +
> +                       stats->bytes +=3D skb->len;
> +                       napi_consume_skb(skb, in_napi);
> +               } else {
> +                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> +
> +                       stats->bytes +=3D xdp_get_frame_len(frame);
> +                       xdp_return_frame(frame);
> +               }
> +               stats->packets++;
> +       }
> +}
> +
>  /* Converting between virtqueue no. and kernel tx/rx queue no.
>   * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
>   */
> @@ -746,37 +770,19 @@ static void virtnet_rq_set_premapped(struct virtnet=
_info *vi)
>
>  static void free_old_xmit(struct send_queue *sq, bool in_napi)
>  {
> -       unsigned int len;
> -       unsigned int packets =3D 0;
> -       unsigned int bytes =3D 0;
> -       void *ptr;
> +       struct virtnet_sq_stats stats =3D {};
>
> -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> -               if (likely(!is_xdp_frame(ptr))) {
> -                       struct sk_buff *skb =3D ptr;
> -
> -                       pr_debug("Sent skb %p\n", skb);
> -
> -                       bytes +=3D skb->len;
> -                       napi_consume_skb(skb, in_napi);
> -               } else {
> -                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> -
> -                       bytes +=3D xdp_get_frame_len(frame);
> -                       xdp_return_frame(frame);
> -               }
> -               packets++;
> -       }
> +       __free_old_xmit(sq, in_napi, &stats);
>
>         /* Avoid overhead when no packets have been processed
>          * happens when called speculatively from start_xmit.
>          */
> -       if (!packets)
> +       if (!stats.packets)
>                 return;
>
>         u64_stats_update_begin(&sq->stats.syncp);
> -       sq->stats.bytes +=3D bytes;
> -       sq->stats.packets +=3D packets;
> +       sq->stats.bytes +=3D stats.bytes;
> +       sq->stats.packets +=3D stats.packets;
>         u64_stats_update_end(&sq->stats.syncp);
>  }
>
> @@ -915,15 +921,12 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>                             int n, struct xdp_frame **frames, u32 flags)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> +       struct virtnet_sq_stats stats =3D {};
>         struct receive_queue *rq =3D vi->rq;
>         struct bpf_prog *xdp_prog;
>         struct send_queue *sq;
> -       unsigned int len;
> -       int packets =3D 0;
> -       int bytes =3D 0;
>         int nxmit =3D 0;
>         int kicks =3D 0;
> -       void *ptr;
>         int ret;
>         int i;
>
> @@ -942,20 +945,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>         }
>
>         /* Free up any pending old buffers before queueing new ones. */
> -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> -               if (likely(is_xdp_frame(ptr))) {
> -                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> -
> -                       bytes +=3D xdp_get_frame_len(frame);
> -                       xdp_return_frame(frame);
> -               } else {
> -                       struct sk_buff *skb =3D ptr;
> -
> -                       bytes +=3D skb->len;
> -                       napi_consume_skb(skb, false);
> -               }
> -               packets++;
> -       }
> +       __free_old_xmit(sq, false, &stats);
>
>         for (i =3D 0; i < n; i++) {
>                 struct xdp_frame *xdpf =3D frames[i];
> @@ -975,8 +965,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>         }
>  out:
>         u64_stats_update_begin(&sq->stats.syncp);
> -       sq->stats.bytes +=3D bytes;
> -       sq->stats.packets +=3D packets;
> +       sq->stats.bytes +=3D stats.bytes;
> +       sq->stats.packets +=3D stats.packets;
>         sq->stats.xdp_tx +=3D n;
>         sq->stats.xdp_tx_drops +=3D n - nxmit;
>         sq->stats.kicks +=3D kicks;
> --
> 2.32.0.3.g01195cf9f
>


