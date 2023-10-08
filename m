Return-Path: <netdev+bounces-38848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254477BCC42
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 07:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8BD281062
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 05:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784B17F6;
	Sun,  8 Oct 2023 05:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPftFsnC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD7017E2
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 05:20:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AA28F
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 22:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696742456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ltwr1aarUCyx8j6R/ivfe090hDGl0OfKeeWRWPXUe+0=;
	b=RPftFsnC13elnzAP2gRDgaiLkoKkaMLl6Hfa7KbTuYTJAxDzgbCgsSJIif6peak3rTm4DD
	aWfBX69uSBptRoonCIFHjzskIwe8WvjqFEMR0h1yG9eXU3bMweiL4/iQs5Knr7HIe4NAl2
	KtNbruau/RDQ3ApmQfInBGHfJGD1WVQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-FRbL6J-POb-U3MU7J2MlUw-1; Sun, 08 Oct 2023 01:20:55 -0400
X-MC-Unique: FRbL6J-POb-U3MU7J2MlUw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50318e9067eso2995364e87.0
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 22:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696742453; x=1697347253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ltwr1aarUCyx8j6R/ivfe090hDGl0OfKeeWRWPXUe+0=;
        b=SYglkfOEQb0LgHReilvuBLnzDpptrpi0ET/TuhnIuhL1ZAtI5Krf9BqWyAOrq0Jm1U
         J6nEN3E1wKGhQqhJgNFSKhOfeQBVadA6zwVFwBev/bsNoGxIpss+lvl7jvLcCkyE/kik
         5vnXfjBjMro3AFo8XQtHFUibFRdztLn6vlbVvAolrGzWd3KnDzkU1b1aROCYdxVTn+Va
         z3NKWVBQ3x7K+x4Bm6q/sBJWpjDUWP8yuB4iIWErm/ooLqzywECZ+P13XS0lo+beJZ6v
         9OSoQVahXKBEpRoAdpE/kmdXZxMP5SuGLQVf3vLgomVEgCiYxTW+Ex11eQHwgYyqlA58
         ofHA==
X-Gm-Message-State: AOJu0YyvrT11D+JLpzfsIfww/XqKy3bzFMliAcjxrUQf5/zNrd8s9A6+
	JunfVwhiLz6Spf04AfEpoNUcU2+q1qP8ys50h3Nmol1rjyAICOpdZNRHAHlEjMUdkPINZ95DO4Y
	CMWuvH8IRtlF8tQXTsFpaRtz3rrx6TY6R
X-Received: by 2002:a05:6512:239d:b0:503:364d:b93b with SMTP id c29-20020a056512239d00b00503364db93bmr13408060lfv.33.1696742453548;
        Sat, 07 Oct 2023 22:20:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEMBXwSWw9CEVnvt3LAifJ/rGQZAyBpRAM5inTwKLDJaU/7h+HDVhb2P54DBbnfHclbOyr7dbMfbHGvssK/6I=
X-Received: by 2002:a05:6512:239d:b0:503:364d:b93b with SMTP id
 c29-20020a056512239d00b00503364db93bmr13408051lfv.33.1696742453162; Sat, 07
 Oct 2023 22:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1695627660.git.hengqi@linux.alibaba.com> <967eec7b4eaad940222448043c1098559bc484da.1695627660.git.hengqi@linux.alibaba.com>
In-Reply-To: <967eec7b4eaad940222448043c1098559bc484da.1695627660.git.hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 13:20:41 +0800
Message-ID: <CACGkMEt3JOXpH5Mvqw6Xy6L1HfO2MdOKmOTH8AeoH=UV1xhmHA@mail.gmail.com>
Subject: Re: [PATCH net v2 4/6] virtio-net: fix per queue coalescing parameter setting
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Gavin Li <gavinl@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 3:53=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> When the user sets a non-zero coalescing parameter to 0 for a specific
> virtqueue, it does not work as expected, so let's fix this.
>
> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce co=
mmand")
> Reported-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
> Cc: Gavin Li <gavinl@nvidia.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
> v1->v2:
>     1. Remove useless comments.
>
>  drivers/net/virtio_net.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6120dd5343dd..12ec3ae19b60 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3296,27 +3296,23 @@ static int virtnet_send_notf_coal_vq_cmds(struct =
virtnet_info *vi,
>  {
>         int err;
>
> -       if (ec->rx_coalesce_usecs || ec->rx_max_coalesced_frames) {
> -               err =3D virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
> -                                                   ec->rx_coalesce_usecs=
,
> -                                                   ec->rx_max_coalesced_=
frames);
> -               if (err)
> -                       return err;
> -               /* Save parameters */
> -               vi->rq[queue].intr_coal.max_usecs =3D ec->rx_coalesce_use=
cs;
> -               vi->rq[queue].intr_coal.max_packets =3D ec->rx_max_coales=
ced_frames;
> -       }
> +       err =3D virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
> +                                           ec->rx_coalesce_usecs,
> +                                           ec->rx_max_coalesced_frames);
> +       if (err)
> +               return err;
>
> -       if (ec->tx_coalesce_usecs || ec->tx_max_coalesced_frames) {
> -               err =3D virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> -                                                   ec->tx_coalesce_usecs=
,
> -                                                   ec->tx_max_coalesced_=
frames);
> -               if (err)
> -                       return err;
> -               /* Save parameters */
> -               vi->sq[queue].intr_coal.max_usecs =3D ec->tx_coalesce_use=
cs;
> -               vi->sq[queue].intr_coal.max_packets =3D ec->tx_max_coales=
ced_frames;
> -       }
> +       vi->rq[queue].intr_coal.max_usecs =3D ec->rx_coalesce_usecs;
> +       vi->rq[queue].intr_coal.max_packets =3D ec->rx_max_coalesced_fram=
es;
> +
> +       err =3D virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> +                                           ec->tx_coalesce_usecs,
> +                                           ec->tx_max_coalesced_frames);
> +       if (err)
> +               return err;
> +
> +       vi->sq[queue].intr_coal.max_usecs =3D ec->tx_coalesce_usecs;
> +       vi->sq[queue].intr_coal.max_packets =3D ec->tx_max_coalesced_fram=
es;
>
>         return 0;
>  }
> --
> 2.19.1.6.gb485710b
>
>


