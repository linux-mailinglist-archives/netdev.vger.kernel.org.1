Return-Path: <netdev+bounces-35660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3997AA7CC
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 06:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 9EBD31F21DC3
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 04:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3666386;
	Fri, 22 Sep 2023 04:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553BB20FD
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:30:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1016198
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 21:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695357027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUFaHgjxsCSWxW3Zs7AMTx7rbfdV9FlW7vh7gI4YaTs=;
	b=ZDoK2KM5yknJRivXlMTf8dUdJzk4Sq69bW8Y4/c9AaB+oL8I7YWScCY7TajoPA54WpTHEM
	y4CdLeIkoMG/A1Zu9FspqEi7+mTFcopuBHd+AJE/nAY1JTA1UraasNvenofOTXouvOHf5U
	lZeKMkqiZLJ8iZqUwYe4ObrrrbsPhFc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-ks3X7AuFP-WZtxnmHin3LA-1; Fri, 22 Sep 2023 00:30:25 -0400
X-MC-Unique: ks3X7AuFP-WZtxnmHin3LA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c020ca4de0so21269591fa.2
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 21:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695357024; x=1695961824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUFaHgjxsCSWxW3Zs7AMTx7rbfdV9FlW7vh7gI4YaTs=;
        b=CEae/YUmS/txUTJCe8toKSPf9w2Lre8rEr6DtM2K1KOB4rCn3HTHIPpT02aqPD+uYg
         7zBkYEp3st5Ko2gUHMWBnchXFgQIbVeZ7tD6fwxpQfdEk73HO1Tt24RdTl0fZkNocECi
         f2YwV7JE8CqFDZBbV5vDODwnw7Vz5lnC7ce0iz22Ro+XMeeNRfcEtV7PRELPQ2gIBma0
         xBdiGdcjjjFpDxt4xU37aj6wZo3SC7sfTzArUY2E+S/1ofT3EqG6N1QFIWtXuyrOUY5h
         yRCwviweROq/fl8onOYB36IkvUs1vN7qywk5jAKIEs3U9K7LSoDTR/jedJCpgrljZQDU
         PTXw==
X-Gm-Message-State: AOJu0Yw1FwocEdVOKrp7O+56bBegf7uWWmOxzexD5m79rDYoz+oh3Rwl
	/YTDkyicpGIs0J+Kvg55pWvCgt9wVAHCFzRomx5S5WjEH4nr6YbsCGEdy/61VOaANoz2XRbihD7
	PiamDASJcpHP38X+/ZFUUDc//lDETSgXX
X-Received: by 2002:a2e:a0c5:0:b0:2b9:eb9d:cc51 with SMTP id f5-20020a2ea0c5000000b002b9eb9dcc51mr6047232ljm.49.1695357023954;
        Thu, 21 Sep 2023 21:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKbRHum9yQcEIpco8ikNB6ODIPRJCNuE5KXcZo0RlUVCtvIUuzVGjGqrtYZlIC3GLdJ125Hoj4Nnk9ZdNfQQ8=
X-Received: by 2002:a2e:a0c5:0:b0:2b9:eb9d:cc51 with SMTP id
 f5-20020a2ea0c5000000b002b9eb9dcc51mr6047215ljm.49.1695357023591; Thu, 21 Sep
 2023 21:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com> <20230919074915.103110-7-hengqi@linux.alibaba.com>
In-Reply-To: <20230919074915.103110-7-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 12:30:12 +0800
Message-ID: <CACGkMEv1f3QQJ3HbAq=7Q7o9C1Mntcrmz+B+sbvD2dpe6ONq3Q@mail.gmail.com>
Subject: Re: [PATCH net 6/6] virtio-net: a tiny comment update
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 3:49=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Update a comment because virtio-net now supports both
> VIRTIO_NET_F_NOTF_COAL and VIRTIO_NET_F_VQ_NOTF_COAL.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9888218abab4..dd498fa468c0 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3347,7 +3347,7 @@ static int virtnet_send_notf_coal_vq_cmds(struct vi=
rtnet_info *vi,
>  static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>  {
>         /* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
> -        * feature is negotiated.
> +        * or VIRTIO_NET_F_VQ_NOTF_COAL feature is negotiated.
>          */
>         if (ec->rx_coalesce_usecs || ec->tx_coalesce_usecs)
>                 return -EOPNOTSUPP;
> --
> 2.19.1.6.gb485710b
>


