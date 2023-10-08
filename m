Return-Path: <netdev+bounces-38846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F6E7BCC34
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 06:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CF81C20895
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 04:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8855415C1;
	Sun,  8 Oct 2023 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEELYKyb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB37630
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 04:53:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DC8BD
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 21:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696740814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1HJ6vv1pBVf5AB5L3VKI3WzniTIFfMuA6xvDuFUoaw=;
	b=DEELYKybU53AReOif20uz1K+ysScYr1wjNcziexsadG2INxvmB6wJlaLbCEbUhRAA+j/9T
	1NK++PBcsuSJ2RDmpXDSYjd1TCdwJ1FXjubLp66yaYnB9tRbfU/tXgpZzJygbi/amOV/oc
	8NkjLSc7CyYb0RQEViH0vc5+tTHNj6E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-jgFT4IqJPaa8rCD2a_xWng-1; Sun, 08 Oct 2023 00:53:32 -0400
X-MC-Unique: jgFT4IqJPaa8rCD2a_xWng-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c296e65210so30279381fa.3
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 21:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696740810; x=1697345610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1HJ6vv1pBVf5AB5L3VKI3WzniTIFfMuA6xvDuFUoaw=;
        b=qXjDhM5o3tZoCZg1x/qdBGADxQJR0UQA4EFlnBE67tJzXYKqWGocvOC4j9+K+h4Jzk
         DOvVl//ca80gaSnmPVlNuVRBgNLLPnJvlLauvhnYNeUvvmre3O+5dlyioRZT2DS9sj68
         PXIoEBbovA5tLmTgD2dBRjFYclNfUksDHD8yQNR/K77lFLtG7EMO/JkhNZpKcELkJGgq
         whJm9j5bX/453KmaNWQEEogER3on9ck9SBPnGavJx5uNjTM6zb5xgvRCaCDXsjuJsnHL
         YQ1/f5qnAsRqbRGSYKeu+opvlLSEuRvzB5K5R94DG4K/CQVPC+25tVgOBxoRZB+y3Ozq
         YlEw==
X-Gm-Message-State: AOJu0Yy7bOO+LsS0dYgBEvXIM1Pm3wHw2lSZEHWFSH4oQJTmBndAe3zC
	eOPGo5nmnFthxmhzQZ+i1eG/m/u42CZZkrvcQGTR6C1HQEMsCH5zha45OeLOMf5outwqmSySZUD
	uz+kAb+Ydcrfyqk/882xOAcMNit54+9tlf7t2F1N5zgtFKg==
X-Received: by 2002:a05:6512:2017:b0:503:19bc:efb with SMTP id a23-20020a056512201700b0050319bc0efbmr9800261lfb.29.1696740810524;
        Sat, 07 Oct 2023 21:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhCGfnVmse6ZZuQQWAmYfgT7YAlMeenDBKY01p6eCrBmjMIn7mjAZeYKlmo1VJDR/G2Nc1dmlcz7Aaz3comfo=
X-Received: by 2002:a05:6512:2017:b0:503:19bc:efb with SMTP id
 a23-20020a056512201700b0050319bc0efbmr9800243lfb.29.1696740810133; Sat, 07
 Oct 2023 21:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927055246.121544-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230927055246.121544-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 12:53:19 +0800
Message-ID: <CACGkMEvubQojB-SxFvqV1D1LPiL2PL+oMP1G29t6702JYdVdXQ@mail.gmail.com>
Subject: Re: [PATCH vhost] virtio_net: fix the missing of the dma cpu sync
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 1:53=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Commit 295525e29a5b ("virtio_net: merge dma operations when filling
> mergeable buffers") unmaps the buffer with DMA_ATTR_SKIP_CPU_SYNC when
> the dma->ref is zero. We do that with DMA_ATTR_SKIP_CPU_SYNC, because we
> do not want to do the sync for the entire page_frag. But that misses the
> sync for the current area.
>
> This patch does cpu sync regardless of whether the ref is zero or not.
>
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling merge=
able buffers")
> Reported-by: Michael Roth <michael.roth@amd.com>
> Closes: http://lore.kernel.org/all/20230926130451.axgodaa6tvwqs3ut@amd.co=
m
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 98dc9b49d56b..9ece27dc5144 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -589,16 +589,16 @@ static void virtnet_rq_unmap(struct receive_queue *=
rq, void *buf, u32 len)
>
>         --dma->ref;
>
> -       if (dma->ref) {
> -               if (dma->need_sync && len) {
> -                       offset =3D buf - (head + sizeof(*dma));
> +       if (dma->need_sync && len) {
> +               offset =3D buf - (head + sizeof(*dma));
>
> -                       virtqueue_dma_sync_single_range_for_cpu(rq->vq, d=
ma->addr, offset,
> -                                                               len, DMA_=
FROM_DEVICE);
> -               }
> +               virtqueue_dma_sync_single_range_for_cpu(rq->vq, dma->addr=
,
> +                                                       offset, len,
> +                                                       DMA_FROM_DEVICE);
> +       }
>
> +       if (dma->ref)
>                 return;
> -       }
>
>         virtqueue_dma_unmap_single_attrs(rq->vq, dma->addr, dma->len,
>                                          DMA_FROM_DEVICE, DMA_ATTR_SKIP_C=
PU_SYNC);
> --
> 2.32.0.3.g01195cf9f
>
>


