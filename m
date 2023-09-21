Return-Path: <netdev+bounces-35493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127147A9C49
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD100282C26
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8396219BAA;
	Thu, 21 Sep 2023 17:49:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4CB2943A
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:49:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4440C7E7F0
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695317722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYjLYdC6bYqbx573ucWhNT5xpdkIsrp3gQR4k/ermH0=;
	b=Ty0pOjiGYmhQZyKAZqO0BZHvI3jvCk8t46uxiR8KglhdweX9FhbrMrhH9jFeG2i20Z6QBx
	ouVKeoK1ScOk72E10UQmGjolXd/rUnbEvNcgfGb6RcGdwVDiPOLVF4oLck2/Dg38Z1cdCW
	EeS8YVvm1QbdqxJYuFy2srMY9j4sZCM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-NQmmX4aSMUuWUJT4ySG9zA-1; Thu, 21 Sep 2023 03:04:12 -0400
X-MC-Unique: NQmmX4aSMUuWUJT4ySG9zA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-504319087d9so131446e87.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 00:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695279850; x=1695884650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYjLYdC6bYqbx573ucWhNT5xpdkIsrp3gQR4k/ermH0=;
        b=D9+XxObeGJ9MtXtfGOQifUujDOqoRvndRNi6NAbhJCAJOzdqCQLiVmrU/4HLKGkyVE
         c5DWmv6LlJ7deOevClPHArL54rtZSGUrevHc+MgioHSH8Soxub36mTzKpz4Yajty+I7N
         8HKOFLmU257yM/vINtH9pvGGYnVIqWS8nhCnFFmaHHXoOT+ZRMKJvTwcIVMdU8GdbOb5
         K44XER5si9fYoqyC/z/xOrwCvLWIPiHRDREGAEgJ83DOA9dd0L6qC1W9UvPulbK7M4Xy
         14bud9WPOkoZ7QptC/YFejF+1VUmAD+1J6fZUXiy1T40Pxzqau+S0uKTGbssVmZ3j3Hu
         8eCw==
X-Gm-Message-State: AOJu0YxLfE+GDUCsRG2p2wXnumVj98QuMksp3yFS5dCpTkup7meQrtzl
	7yYXnCX7tNIA5bny1KodQ3PF03pQHPSKJj7RKqRxAJxhAg+tj4B9dw+42eWqg1RNLl+uH00MuXr
	4vHICKgZX2d/Q9y+wzbLj5k5a/nLZAweS/rX7zCzLsoe69Q==
X-Received: by 2002:ac2:5b1d:0:b0:503:258f:fd15 with SMTP id v29-20020ac25b1d000000b00503258ffd15mr4261490lfn.20.1695279850552;
        Thu, 21 Sep 2023 00:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaRL9J24xhrUI+WEGVcfvlAUK7d91sBxB1lJhgep/7cEowKEj+hm9NK/We8OqBiMdsZQry//JoWzITfTumPYg=
X-Received: by 2002:ac2:5b1d:0:b0:503:258f:fd15 with SMTP id
 v29-20020ac25b1d000000b00503258ffd15mr4261463lfn.20.1695279850095; Thu, 21
 Sep 2023 00:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com> <20230919074915.103110-2-hengqi@linux.alibaba.com>
In-Reply-To: <20230919074915.103110-2-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Sep 2023 15:03:58 +0800
Message-ID: <CACGkMEudQDW4xvOqs0Nufx62hB-QFgO+u4DndS24vWmJkML=Mg@mail.gmail.com>
Subject: Re: [PATCH net 1/6] virtio-net: initially change the value of tx-frames
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 3:49=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Background:
> 1. Commit 0c465be183c7 ("virtio_net: ethtool tx napi configuration") uses
>    tx-frames to toggle napi_tx (0 off and 1 on) if notification coalescin=
g
>    is not supported.
> 2. Commit 31c03aef9bc2 ("virtio_net: enable napi_tx by default") enables
>    napi_tx for all txqs by default.
>
> Status:
> When virtio-net supports notification coalescing, after initialization,
> tx-frames is 0 and napi_tx is true.
>
> Problem:
> When the user only wants to set rx coalescing params using
>            ethtool -C eth0 rx-usecs 10, or
>            ethtool -Q eth0 queue_mask 0x1 -C rx-usecs 10,
> these cmds will carry tx-frames as 0, causing the napi_tx switching condi=
tion
> is satisfied. Then the user gets:
>            netlink error: Device or resource busy.
>
> The same happens when trying to set rx-frames, adaptive_rx, adaptive_tx..=
.
>
> Result:

It's probably not the result but how to fix it?

> When notification coalescing feature is negotiated, initially make the
> value of tx-frames to be consistent with napi_tx.
>
> For compatibility with the past, it is still supported to use tx-frames
> to toggle napi_tx.
>
> Reported-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 42 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fe7f314d65c9..fd5bc8d59eda 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4442,13 +4442,6 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>                 dev->xdp_features |=3D NETDEV_XDP_ACT_RX_SG;
>         }
>
> -       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
> -               vi->intr_coal_rx.max_usecs =3D 0;
> -               vi->intr_coal_tx.max_usecs =3D 0;
> -               vi->intr_coal_tx.max_packets =3D 0;
> -               vi->intr_coal_rx.max_packets =3D 0;
> -       }
> -
>         if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
>                 vi->has_rss_hash_report =3D true;
>
> @@ -4523,6 +4516,41 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>         if (err)
>                 goto free;
>
> +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
> +               vi->intr_coal_rx.max_usecs =3D 0;
> +               vi->intr_coal_tx.max_usecs =3D 0;
> +               vi->intr_coal_rx.max_packets =3D 0;
> +
> +               /* Why is this needed?
> +                * If without this setting, consider that when VIRTIO_NET=
_F_NOTF_COAL is
> +                * negotiated and napi_tx is initially true: when the use=
r sets non tx-frames
> +                * parameters, such as the following cmd or others,
> +                *              ethtool -C eth0 rx-usecs 10.
> +                * Then
> +                * 1. ethtool_set_coalesce() first calls virtnet_get_coal=
esce() to get
> +                *    the last parameters except rx-usecs. If tx-frames h=
as never been set before,
> +                *    virtnet_get_coalesce() returns with tx-frames=3D0 i=
n the parameters.
> +                * 2. virtnet_set_coalesce() is then called, according to=
 1:
> +                *    ec->tx_max_coalesced_frames=3D0. Now napi_tx switch=
ing condition is met.
> +                * 3. If the device is up, the user setting fails:
> +                *             "netlink error: Device or resource busy"
> +                * This is not intuitive. Therefore, we keep napi_tx stat=
e consistent with
> +                * tx-frames when VIRTIO_NET_F_NOTF_COAL is negotiated. T=
his behavior is
> +                * compatible with before.
> +                */

Maybe it's sufficient to say it tries to align the behaviour with that
tx NAPI is enabled by default?

Other than these minor issues:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> +               if (vi->sq[0].napi.weight)
> +                       vi->intr_coal_tx.max_packets =3D 1;
> +               else
> +                       vi->intr_coal_tx.max_packets =3D 0;
> +       }
> +
> +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +               /* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
> +               for (i =3D 0; i < vi->max_queue_pairs; i++)
> +                       if (vi->sq[i].napi.weight)
> +                               vi->sq[i].intr_coal.max_packets =3D 1;
> +       }
> +
>  #ifdef CONFIG_SYSFS
>         if (vi->mergeable_rx_bufs)
>                 dev->sysfs_rx_queue_group =3D &virtio_net_mrg_rx_group;
> --
> 2.19.1.6.gb485710b
>


