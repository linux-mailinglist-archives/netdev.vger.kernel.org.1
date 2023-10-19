Return-Path: <netdev+bounces-42503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BBA7CF004
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 08:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E202281EA1
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 06:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC5120FD;
	Thu, 19 Oct 2023 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmpqQwqA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98063A4
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:18:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA356FE
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697696281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/PuqaXTNUDAuY+PkSea1LqeAPr02g4Cwph0Z+g7436c=;
	b=QmpqQwqAQ0n6ECPavxfRU/wqwqoxTF8xA6RXAzP/Gu9IVU+kwCyo2GRRwRMse003h4EDFW
	t5luJ1hGEs99TxAS8JAB4nLOVbxiJIt3+WEQnfJIDAmgGXgJszGqJXWK3uYX+UvNvutMih
	PetjxcpAadJF2qXun3xzOldWVnTMSJ8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-9c3HnxRxPaivNracARVCWA-1; Thu, 19 Oct 2023 02:17:48 -0400
X-MC-Unique: 9c3HnxRxPaivNracARVCWA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5079fd9754cso5563753e87.0
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697696267; x=1698301067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PuqaXTNUDAuY+PkSea1LqeAPr02g4Cwph0Z+g7436c=;
        b=ufPCj2q8eZvspOHzQToHQ5VbUOptOVNISv3u4OTPg6uC8+pQABYwwt+fYYMjQFYafa
         VW7qZco5W2BLbaxuLSbDBwDndIdVrBC4vb83Cz9p/DUf5qMMQJUPN/s1eT6OYf806Lm7
         PRCJRYqmeiFh0+sKQVo2axoh7Ljklhdqy+R4QRyckF47AOWZiGub/o23zDa07p5IbkMJ
         1wDKs+2z5FvRv9j4g0JsU7RY1itzqkL2VHq99GYeldnLZIDTAw3mJxuA4nXzVaQptUDE
         kyxzNqc9xK22Pw3joY/KlfR6eCn8W/SMQfIvInOjEHDdCx+DwjGEe68oZGN0jHeaBU6M
         rqOQ==
X-Gm-Message-State: AOJu0Yxi9xeQKN8MgyyITMUg8lvtcwcOeitaPnJMzdEKdXyCGkX3HiH6
	Bk+xze7z94jhqYji6KwAc/l37vEonDmTcAVQ2NoViUPhsDC+K/RwRgFsvPlLJSR8sUgK0FzBW2y
	xrKx/XbG59zJ8RFzIH/HSrSatM2c7RpSb
X-Received: by 2002:a19:ee16:0:b0:507:ab62:48a5 with SMTP id g22-20020a19ee16000000b00507ab6248a5mr646487lfb.21.1697696266876;
        Wed, 18 Oct 2023 23:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHByP6mfsSCluk9sCZUGdaOPomDtr6n3wTg6/xe3nrOw8ffMYgY2ZllbvDXPQDB1aq7nf0tgU5oMzZ6tOpqzqk=
X-Received: by 2002:a19:ee16:0:b0:507:ab62:48a5 with SMTP id
 g22-20020a19ee16000000b00507ab6248a5mr646467lfb.21.1697696266555; Wed, 18 Oct
 2023 23:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 14:17:35 +0800
Message-ID: <CACGkMEsMhapWJAjqQAYiJ5LFbSEojK5Z-W2Ncwg=F+u=xsu-bg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 06/19] virtio_net: separate virtnet_rx_resize()
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
> This patch separates two sub-functions from virtnet_rx_resize():
>
> * virtnet_rx_pause
> * virtnet_rx_resume
>
> Then the subsequent reset rx for xsk can share these two functions.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio/main.c       | 29 +++++++++++++++++++++--------
>  drivers/net/virtio/virtio_net.h |  3 +++
>  2 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index ba38b6078e1d..e6b262341619 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -2120,26 +2120,39 @@ static netdev_tx_t start_xmit(struct sk_buff *skb=
, struct net_device *dev)
>         return NETDEV_TX_OK;
>  }
>
> -static int virtnet_rx_resize(struct virtnet_info *vi,
> -                            struct virtnet_rq *rq, u32 ring_num)
> +void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq)
>  {
>         bool running =3D netif_running(vi->dev);
> -       int err, qindex;
> -
> -       qindex =3D rq - vi->rq;
>
>         if (running)
>                 napi_disable(&rq->napi);
> +}
>
> -       err =3D virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused=
_buf);
> -       if (err)
> -               netdev_err(vi->dev, "resize rx fail: rx queue index: %d e=
rr: %d\n", qindex, err);
> +void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq)
> +{
> +       bool running =3D netif_running(vi->dev);
>
>         if (!try_fill_recv(vi, rq, GFP_KERNEL))
>                 schedule_delayed_work(&vi->refill, 0);
>
>         if (running)
>                 virtnet_napi_enable(rq->vq, &rq->napi);
> +}
> +
> +static int virtnet_rx_resize(struct virtnet_info *vi,
> +                            struct virtnet_rq *rq, u32 ring_num)
> +{
> +       int err, qindex;
> +
> +       qindex =3D rq - vi->rq;
> +
> +       virtnet_rx_pause(vi, rq);
> +
> +       err =3D virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused=
_buf);
> +       if (err)
> +               netdev_err(vi->dev, "resize rx fail: rx queue index: %d e=
rr: %d\n", qindex, err);
> +
> +       virtnet_rx_resume(vi, rq);
>         return err;
>  }
>
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index 282504d6639a..70eea23adba6 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -253,4 +253,7 @@ static inline bool virtnet_is_xdp_raw_buffer_queue(st=
ruct virtnet_info *vi, int
>         else
>                 return false;
>  }
> +
> +void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
> +void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
>  #endif
> --
> 2.32.0.3.g01195cf9f
>


