Return-Path: <netdev+bounces-44085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0F27D608E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 05:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0051C20D08
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D0B5252;
	Wed, 25 Oct 2023 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeO5RFXm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F1079CD
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 03:36:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7642290
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698204959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xfDLb1C5fG+3hvae1lcC3XUNoWIDZjI8HvveldeQhUI=;
	b=AeO5RFXmqEXagrh8ApT76wBXbHcmk8rnUSX5Rue2z+HMHUM6bh0xDX7Cqzu7j8vaHZhkzy
	sqpKx6hyiA1BXfpwlGb/YJyKKpp1wbYC5lhLOtTLqs1POnnOorSWrdhhKcMjkn8czPFZxS
	eVZvhR5f+1PXgegwwF+oEdUvT/S0b0o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-zo9wnKgPPK6nkZmGhJkR7w-1; Tue, 24 Oct 2023 23:35:57 -0400
X-MC-Unique: zo9wnKgPPK6nkZmGhJkR7w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507c5327cabso227884e87.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698204955; x=1698809755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfDLb1C5fG+3hvae1lcC3XUNoWIDZjI8HvveldeQhUI=;
        b=jxbbbQBybMiQvX8S2KHzH6iXdO23SV5LnTgmXQfsoZOvwat2yjEW22i4aLlrA2B0+U
         u+IGqxAh1eOEiM26UQxqvTBTMS9b6O6rX/dnuJPjHh09BkwZBLwm8Ubep57TPN1W1tnc
         xp/Vwrn0blfuL4IZ5/e88J8qPJ2sSbyndLdVA7zXhyh+xfckfemBRfu3Yx1ZoUzYHK5S
         +5ZRddCP802KOpXNqUBrYRhYZRs1OGsWhOHLLhIIAt7TgJoWYqS1tN23HSr0AMkpkvq/
         K4+aLg9DgipWb3UWBv8mhyk+RjERltf3Nlckzap7Fy+zna/D80p1T/TopEgdk7ifVLit
         timA==
X-Gm-Message-State: AOJu0YyZQVFmp8IycVVTrjnotKUaNNGxxoGe/xBsY2EHes3YrOZUQC68
	RktD/Cp9E/1ZIcnVXpxvEukTprC2iPz6TxFD2F/hVUa9Al1zE+UjSXr9xGZGVQz/9Yb073sZTTL
	7GcKR+mJvmQTbU5o2meD5iD/vu8nnj7cM
X-Received: by 2002:a05:6512:3e14:b0:507:9c72:3ace with SMTP id i20-20020a0565123e1400b005079c723acemr6015130lfv.26.1698204955592;
        Tue, 24 Oct 2023 20:35:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeHtwk890NQeEoItJvcNRHX2Ml0qXCOmSqFUCIUrPgkJHFPDqdG2NJa8DayWvoA5ZFM/qWvP6c0YG2Q898ATQ=
X-Received: by 2002:a05:6512:3e14:b0:507:9c72:3ace with SMTP id
 i20-20020a0565123e1400b005079c723acemr6015114lfv.26.1698204955289; Tue, 24
 Oct 2023 20:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697093455.git.hengqi@linux.alibaba.com> <ef5d159875745040e406473bd5c03e9875742ff5.1697093455.git.hengqi@linux.alibaba.com>
In-Reply-To: <ef5d159875745040e406473bd5c03e9875742ff5.1697093455.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Oct 2023 11:35:43 +0800
Message-ID: <CACGkMEuX+kJ8G2CitnACVgx_OSsdbtedD+dvXJ_REFdwzx56Vg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] virtio-net: support tx netdim
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Liu, Yujie" <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 3:44=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Similar to rx netdim, this patch supports adaptive tx
> coalescing moderation for the virtio-net.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 143 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 119 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6ad2890a7909..1c680cb09d48 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -154,6 +154,15 @@ struct send_queue {
>
>         struct virtnet_sq_stats stats;
>
> +       /* The number of tx notifications */
> +       u16 calls;
> +
> +       /* Is dynamic interrupt moderation enabled? */
> +       bool dim_enabled;
> +
> +       /* Dynamic Interrupt Moderation */
> +       struct dim dim;
> +
>         struct virtnet_interrupt_coalesce intr_coal;
>
>         struct napi_struct napi;
> @@ -317,8 +326,9 @@ struct virtnet_info {
>         u8 duplex;
>         u32 speed;
>
> -       /* Is rx dynamic interrupt moderation enabled? */
> +       /* Is dynamic interrupt moderation enabled? */
>         bool rx_dim_enabled;
> +       bool tx_dim_enabled;
>
>         /* Interrupt coalescing settings */
>         struct virtnet_interrupt_coalesce intr_coal_tx;
> @@ -464,19 +474,40 @@ static bool virtqueue_napi_complete(struct napi_str=
uct *napi,
>         return false;
>  }
>
> +static void virtnet_tx_dim_work(struct work_struct *work);
> +
> +static void virtnet_tx_dim_update(struct virtnet_info *vi, struct send_q=
ueue *sq)
> +{
> +       struct virtnet_sq_stats *stats =3D &sq->stats;
> +       struct dim_sample cur_sample =3D {};
> +
> +       u64_stats_update_begin(&sq->stats.syncp);
> +       dim_update_sample(sq->calls, stats->packets,
> +                         stats->bytes, &cur_sample);
> +       u64_stats_update_end(&sq->stats.syncp);
> +
> +       net_dim(&sq->dim, cur_sample);
> +}
> +
>  static void skb_xmit_done(struct virtqueue *vq)
>  {
>         struct virtnet_info *vi =3D vq->vdev->priv;
> -       struct napi_struct *napi =3D &vi->sq[vq2txq(vq)].napi;
> +       struct send_queue *sq =3D &vi->sq[vq2txq(vq)];
> +       struct napi_struct *napi =3D &sq->napi;
> +
> +       sq->calls++;

I wonder what's the impact of this counters for netdim. As we have a
mode of orphan skb in xmit.

We need to test to see.

Thanks


