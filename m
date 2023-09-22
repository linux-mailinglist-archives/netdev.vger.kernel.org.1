Return-Path: <netdev+bounces-35656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB17AA7BE
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 06:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id A6B421F21D59
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 04:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F2217E2;
	Fri, 22 Sep 2023 04:28:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052DB80D
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:28:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECB4F1
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 21:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695356883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFy+oyazE1udWqOmaR5BG1aT8fM44g/nbkjOVlFoLS4=;
	b=g549c6S/Hiwh8widRf9y+CyK8NIvsVvLj0pAG7dmQUVs6Js8LWxfidbn18Nl/eaV4ptzJI
	lrP7l2/y62z6Q6AXJ6rKcsHBJQfnSPsnLTQxgwwt4sumstFYMer5wJ33pXfqTxxbuSRWPx
	hUCGfS4FWZMrXMVJTV9l3sUobwrKuKo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-6G096EY9NKKbMLjwodPjHg-1; Fri, 22 Sep 2023 00:28:01 -0400
X-MC-Unique: 6G096EY9NKKbMLjwodPjHg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-503343a850aso2086060e87.3
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 21:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695356880; x=1695961680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFy+oyazE1udWqOmaR5BG1aT8fM44g/nbkjOVlFoLS4=;
        b=JN+9bClD67J7VtafFkGelJpRVfJtVhzppAhOtG6hxv4ZSkLpZyuT/TT4KIOHFfR2Xi
         sfRkH5NWpPhlI1BO7cTmmrYewldXBuSmkmxi85gz1IsbUSUuw57CtKfFfNrh5DHu/tSp
         MH7dV1PFoBUK2CNjWsfQuoZcZf6jl2pLAicwd8SKcsFSecfukw8cdi1V+/Jv6wIKfW6w
         RK2tsd/R7kl2lHsXf03EibTI1OQUFDNz7/1aAOSvUPD2HB3cLyLbe/9n9SZrrwcasyRe
         gKhBKnMLgEYIFyFNDhX+krgsGmDFNPr1ie+oe9J6LTOg6k4CXjZAd6XPJFfKu5S4rD8f
         cfdQ==
X-Gm-Message-State: AOJu0YwZ9XwuvJEo7GEElWraWtOeatDoLHZ94TUOZpIgbRugPTd+QX0M
	5Q1udqOFqqxcjE9S+LxbeFgInReOayFehAfX2XY/FYZO+6t6FCO31j35B8pOeC/SfYZrCI/k6ub
	MrFjbIu86cziOfawqLEGzqfBZon2dw6lS
X-Received: by 2002:ac2:4f07:0:b0:502:fdca:2eaa with SMTP id k7-20020ac24f07000000b00502fdca2eaamr6908587lfr.52.1695356880485;
        Thu, 21 Sep 2023 21:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMZGTc6Dhmz4NaaKOuv0D2j30mb1sTLpGN4K2T2Dk1R2+KZ4K0ldTQZ5KU/VIEQn+mBf/RojxjjD6q5WtGfZc=
X-Received: by 2002:ac2:4f07:0:b0:502:fdca:2eaa with SMTP id
 k7-20020ac24f07000000b00502fdca2eaamr6908579lfr.52.1695356880183; Thu, 21 Sep
 2023 21:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com> <20230919074915.103110-5-hengqi@linux.alibaba.com>
In-Reply-To: <20230919074915.103110-5-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 12:27:49 +0800
Message-ID: <CACGkMEtKTpJ53-XExFa8YKRd0CT1JjVWP_7manyG2Z8WQodu6Q@mail.gmail.com>
Subject: Re: [PATCH net 4/6] virtio-net: fix per queue coalescing parameter setting
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 3:49=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
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
> ---
>  drivers/net/virtio_net.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ce60162d380a..f9a7f6afd099 100644
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
> +       /* Save parameters */

I think code explains itself, so we can remove this.

Others look good.

Thanks

> +       vi->rq[queue].intr_coal.max_usecs =3D ec->rx_coalesce_usecs;
> +       vi->rq[queue].intr_coal.max_packets =3D ec->rx_max_coalesced_fram=
es;
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
> +       err =3D virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> +                                           ec->tx_coalesce_usecs,
> +                                           ec->tx_max_coalesced_frames);
> +       if (err)
> +               return err;
> +       /* Save parameters */
> +       vi->sq[queue].intr_coal.max_usecs =3D ec->tx_coalesce_usecs;
> +       vi->sq[queue].intr_coal.max_packets =3D ec->tx_max_coalesced_fram=
es;
>
>         return 0;
>  }
> --
> 2.19.1.6.gb485710b
>


