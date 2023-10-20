Return-Path: <netdev+bounces-42897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35027D08D0
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D551C20F43
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 06:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD48CA57;
	Fri, 20 Oct 2023 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BP2lxZ7T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619C1C8D5
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 06:52:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9A01A3
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697784729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10cbfzEVk27kgN03LPBPjZemOEg2DlC+TkYfvJQWsAc=;
	b=BP2lxZ7TiykJYmaQPBqpDwLtzoz3M4H6M95tk8jHIa97+JgP+c3+ZH40Q0EzTLeV5sVbmo
	IepaYygZIcZTY+pjh5QBY+HWJNvea4GhyigMoe5f3Zy7E/axrTzJCnBlF5WrmNmpVDlDYe
	7TnTEl9AU/4EkWkFnHgX9PGKNADqpBc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-anOUzvCnOCyS0hVFUXZyIg-1; Fri, 20 Oct 2023 02:52:07 -0400
X-MC-Unique: anOUzvCnOCyS0hVFUXZyIg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507b92b4346so453010e87.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 23:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784726; x=1698389526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10cbfzEVk27kgN03LPBPjZemOEg2DlC+TkYfvJQWsAc=;
        b=X5c7qLIiqK1MCSO4rmmB43wg6NsH8s13WZOG+6kuBHbsVy9hBUz6zqRy8yB84Ovu7w
         gW04Hx7KFuW4EF8wQMk0zkWB7yYP4y0e6Q6LugkpGGI0QbXV7a3LGffMfjgr3xdtyLGZ
         IwEZ28dFA1vJdHKJnkUQ/oz4fPZAgqkIVUTXesukeRq23nlGLVCGYrD2any/kkRl+cvO
         QKLa/nbANlYp5+tR6/nqta6rLLX8TLxsmpcVi81XUTuRRtRckD8UhYiSi5JxtVm+2pRa
         liAqF/lEkNTBZ5/jBrWZVOfSy6H802bpyV4bTj/YACl3TTBsLjyjNQW5ORu9K3ES43vx
         ETng==
X-Gm-Message-State: AOJu0Yynfosfu4FiwIzMleRfgO5f2UG/4VBm43nBLTs42eb62+hVg2/Y
	hM0x2Ou1mBz/tZnbs9ve+ZauNCDF+q87IRlOf7MjrcTfXbf6Apqa/696knE8xVO+5KlFGeLuT9e
	Nyfl7Cvx291pza6dt/ZTHSqMArTRB47I1
X-Received: by 2002:a05:6512:214d:b0:507:99fe:3237 with SMTP id s13-20020a056512214d00b0050799fe3237mr541293lfr.41.1697784725943;
        Thu, 19 Oct 2023 23:52:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqzELhpEx22FYwYPhyfWTswvFv2Oj8GyZnrYRmy1SO1OL2VvOAVbm8+PFPWb4VQn5j6eQ7znrwUmrAEcGMPA8=
X-Received: by 2002:a05:6512:214d:b0:507:99fe:3237 with SMTP id
 s13-20020a056512214d00b0050799fe3237mr541278lfr.41.1697784725636; Thu, 19 Oct
 2023 23:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:51:54 +0800
Message-ID: <CACGkMEv7pCQ9mnqBwbGWaoFHJZO06Q=SCPvihDbSb+7cEfD0ag@mail.gmail.com>
Subject: Re: [PATCH net-next v1 10/19] virtio_net: xsk: prevent disable tx napi
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
> Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
> we must stop tx napi from being disabled.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  drivers/net/virtio/main.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 38733a782f12..b320770e5f4e 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -3203,7 +3203,7 @@ static int virtnet_set_coalesce(struct net_device *=
dev,
>                                 struct netlink_ext_ack *extack)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> -       int ret, queue_number, napi_weight;
> +       int ret, queue_number, napi_weight, i;
>         bool update_napi =3D false;
>
>         /* Can't change NAPI weight if the link is up */
> @@ -3232,6 +3232,14 @@ static int virtnet_set_coalesce(struct net_device =
*dev,
>                 return ret;
>
>         if (update_napi) {
> +               /* xsk xmit depends on the tx napi. So if xsk is active,
> +                * prevent modifications to tx napi.
> +                */
> +               for (i =3D queue_number; i < vi->max_queue_pairs; i++) {
> +                       if (rtnl_dereference(vi->sq[i].xsk.pool))
> +                               return -EBUSY;
> +               }
> +
>                 for (; queue_number < vi->max_queue_pairs; queue_number++=
)
>                         vi->sq[queue_number].napi.weight =3D napi_weight;
>         }
> --
> 2.32.0.3.g01195cf9f
>


