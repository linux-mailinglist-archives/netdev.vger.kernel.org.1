Return-Path: <netdev+bounces-42504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9377CF007
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 08:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6BF1C20A5E
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 06:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12C611B;
	Thu, 19 Oct 2023 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G55PzN9t"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3763CF
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:18:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2059B6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697696337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5lP2IEwe8+p9/Axdm9QTLhS4D+SLbQCbPDvFOSM2PI=;
	b=G55PzN9t4LYzOxWNNkRhz68ei47ab4w+f+ame3HTqZWE9a9V41Quwv2aDHF7zka3Zs4lNC
	hBN4IfUu1CSd94ps/tNvgStwe7iPk5zqwJ/VN5tbKfR/2vgrk3vJG/w97nuNGHZMI8YX39
	E+gvaC30LkyP1Y/EEd5ixQrqkOsmcJI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Jg47FuCaPWa2Ax4hX0S1lQ-1; Thu, 19 Oct 2023 02:18:49 -0400
X-MC-Unique: Jg47FuCaPWa2Ax4hX0S1lQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507b0270b7fso4329494e87.3
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697696328; x=1698301128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5lP2IEwe8+p9/Axdm9QTLhS4D+SLbQCbPDvFOSM2PI=;
        b=Aqv8MdEI1llbd6q/mAv+d0Ax5pRaeqFhg2/wAspHkabgtCaMnUDA2ElCnc7Xn8vR2r
         9teFea1ud5ZXK7oi1+nb9wTqlFWD2I1NWjGf9Y4ExxIRKR7aSPSgPtj+q8EnTj2kHWSL
         crI1BWNCfUlDQERSz/MRtgYmk8fug1nmrzDbnV+UrcZGlazfKZD5G9qjPHZ0LrBM2Jq2
         G9/RYS+KOtXPNvUbt8k9o5nk/D11UVDT29GD4EfDdQt4BPicWDoFzXV5ALpMvIwZTpEM
         jSvbbUDzDbkwf1TP9l+72dl3K3SGBjNtjHC81dM+aRH+y5Vt5N6oP+OFtj28d9LiXuCo
         R73g==
X-Gm-Message-State: AOJu0YynBSWTE/EK6LrbM554rnkIryCIjqEA9ZQQy4/E1hy9nvDmyqgc
	cjA8NQYg7w3EsHjRPiBp6y21qvMg1TUvBweP2/L81D4mhjAM/g4Vj89e6HR3d7rfyY2+x/dzcEX
	1FBJmo4waSthkxVey7mJpOZD6uPuvyOn7
X-Received: by 2002:a05:6512:3e06:b0:507:9d71:2a77 with SMTP id i6-20020a0565123e0600b005079d712a77mr873085lfv.17.1697696328563;
        Wed, 18 Oct 2023 23:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKm6rGJgW6Z7BA1cTpUTUR/6KwfiGtTMHbrw0rOATMiEWNT9mWMqGW2Jy0QbHUI+LlwOQs/pr5t1Vl/fEWNyY=
X-Received: by 2002:a05:6512:3e06:b0:507:9d71:2a77 with SMTP id
 i6-20020a0565123e0600b005079d712a77mr873065lfv.17.1697696328225; Wed, 18 Oct
 2023 23:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 14:18:37 +0800
Message-ID: <CACGkMEvMzp3zW5OXicemuC-GetrfMdGdscY_ZY5xY_pO8eYZvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 07/19] virtio_net: separate virtnet_tx_resize()
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
> This patch separates two sub-functions from virtnet_tx_resize():
>
> * virtnet_tx_pause
> * virtnet_tx_resume
>
> Then the subsequent virtnet_tx_reset() can share these two functions.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio/main.c       | 35 +++++++++++++++++++++++++++------
>  drivers/net/virtio/virtio_net.h |  2 ++
>  2 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index e6b262341619..8da84ea9bcbe 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -2156,12 +2156,11 @@ static int virtnet_rx_resize(struct virtnet_info =
*vi,
>         return err;
>  }
>
> -static int virtnet_tx_resize(struct virtnet_info *vi,
> -                            struct virtnet_sq *sq, u32 ring_num)
> +void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq)
>  {
>         bool running =3D netif_running(vi->dev);
>         struct netdev_queue *txq;
> -       int err, qindex;
> +       int qindex;
>
>         qindex =3D sq - vi->sq;
>
> @@ -2182,10 +2181,17 @@ static int virtnet_tx_resize(struct virtnet_info =
*vi,
>         netif_stop_subqueue(vi->dev, qindex);
>
>         __netif_tx_unlock_bh(txq);
> +}
>
> -       err =3D virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused=
_buf);
> -       if (err)
> -               netdev_err(vi->dev, "resize tx fail: tx queue index: %d e=
rr: %d\n", qindex, err);
> +void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq)
> +{
> +       bool running =3D netif_running(vi->dev);
> +       struct netdev_queue *txq;
> +       int qindex;
> +
> +       qindex =3D sq - vi->sq;
> +
> +       txq =3D netdev_get_tx_queue(vi->dev, qindex);
>
>         __netif_tx_lock_bh(txq);
>         sq->reset =3D false;
> @@ -2194,6 +2200,23 @@ static int virtnet_tx_resize(struct virtnet_info *=
vi,
>
>         if (running)
>                 virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
> +}
> +
> +static int virtnet_tx_resize(struct virtnet_info *vi, struct virtnet_sq =
*sq,
> +                            u32 ring_num)
> +{
> +       int qindex, err;
> +
> +       qindex =3D sq - vi->sq;
> +
> +       virtnet_tx_pause(vi, sq);
> +
> +       err =3D virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused=
_buf);
> +       if (err)
> +               netdev_err(vi->dev, "resize tx fail: tx queue index: %d e=
rr: %d\n", qindex, err);
> +
> +       virtnet_tx_resume(vi, sq);
> +
>         return err;
>  }
>
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index 70eea23adba6..2f930af35364 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -256,4 +256,6 @@ static inline bool virtnet_is_xdp_raw_buffer_queue(st=
ruct virtnet_info *vi, int
>
>  void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
>  void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
> +void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
> +void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
>  #endif
> --
> 2.32.0.3.g01195cf9f
>


