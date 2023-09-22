Return-Path: <netdev+bounces-35655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AEE7AA7BC
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 06:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 20FF11F21D75
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 04:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98E080D;
	Fri, 22 Sep 2023 04:27:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2678517E2
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:27:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF85A18F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 21:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695356819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EaqgmQfjWf4RSP054NnjKIxOwf3P8mlQqF+5e289Wk=;
	b=C/uVg1YNlo8rYzyTvMQIfwNoUiiPVUWG10O3YN2is5QtCIOunFuYqswXkmi9HPaclg61YH
	8e5sGMXbq+YdDls1u/+uyNHiWX4FA0DzvFT9567MiKItYm2bV5+snOlnoePbIDimVj0005
	WmvLVsggzbq/AqKLFj00Sf526dhIGS0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-ABUpvCNSOLKz9ToF9Wg5Qg-1; Fri, 22 Sep 2023 00:26:57 -0400
X-MC-Unique: ABUpvCNSOLKz9ToF9Wg5Qg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c0082e04eeso20976761fa.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 21:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695356816; x=1695961616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EaqgmQfjWf4RSP054NnjKIxOwf3P8mlQqF+5e289Wk=;
        b=QKlr+iuQ6czH/Rpn+becJgq5J31ogTY0UvmfQJXxnD3HvtVbOY1/T1Qat2/WYTsDbt
         JNmXN7ZWUmYOKygxtSnUoBHxWdiNBWWSUg9gZVfLCiOo+yVTKf13oi/u/ru5QQZysSki
         I83Z+HdeYHXcztndC959EThCxHgViKFhqftD+fXKeIf1jhN3hOsLkYQuKC9x+V4fMf96
         GhGCAXKxXbax4Ki2gOvqiWWh3kppyrULdTPGkzSUq4jMu7jWGir0mZEpmECIgZBc33Hl
         bYSv/y2ra652gLkoYpfzHKjuwtH103EP1IzKURD485CyyrSCGkt3YT8pQyqXI1BFx/UG
         gdxQ==
X-Gm-Message-State: AOJu0Ywy3Cc0tRXKgLJd2dRO8D32tuWwHT2phz9vXj873OzpzpjFpT6D
	3KycVfC/nkKgQZiuFa0GM2/PxTYjZJEeJu6kELAakZJzb3InN3Q+hT0yQMyUDqmdhDT8YrGYadu
	5x9I3sjdgOpZl5lPjQE9CkoNlmxEm9Uqn
X-Received: by 2002:a2e:90d5:0:b0:2bf:ff17:811b with SMTP id o21-20020a2e90d5000000b002bfff17811bmr6233302ljg.3.1695356816406;
        Thu, 21 Sep 2023 21:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6kt7xDg+aB1I6QHkKIhyfLUbsI0g/0L7rhAHVvAsPsk/167eY/3mb1NulDto656tDuHLO1oTrs2ZNOV+f0Oc=
X-Received: by 2002:a2e:90d5:0:b0:2bf:ff17:811b with SMTP id
 o21-20020a2e90d5000000b002bfff17811bmr6233295ljg.3.1695356816098; Thu, 21 Sep
 2023 21:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com> <20230919074915.103110-4-hengqi@linux.alibaba.com>
In-Reply-To: <20230919074915.103110-4-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 12:26:45 +0800
Message-ID: <CACGkMEumtfsqmB5F+c9t+6mSkEN_UB8iS9ztTg+NfYm56mQuvg@mail.gmail.com>
Subject: Re: [PATCH net 3/6] virtio-net: consistently save parameters for per-queue
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 3:49=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> When using .set_coalesce interface to set all queue coalescing
> parameters, we need to update both per-queue and global save values.
>
> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce co=
mmand")
> Cc: Gavin Li <gavinl@nvidia.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 80d35a864790..ce60162d380a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3233,6 +3233,7 @@ static int virtnet_send_notf_coal_cmds(struct virtn=
et_info *vi,
>                                        struct ethtool_coalesce *ec)
>  {
>         struct scatterlist sgs_tx, sgs_rx;
> +       int i;
>
>         vi->ctrl->coal_tx.tx_usecs =3D cpu_to_le32(ec->tx_coalesce_usecs)=
;
>         vi->ctrl->coal_tx.tx_max_packets =3D cpu_to_le32(ec->tx_max_coale=
sced_frames);
> @@ -3246,6 +3247,10 @@ static int virtnet_send_notf_coal_cmds(struct virt=
net_info *vi,
>         /* Save parameters */
>         vi->intr_coal_tx.max_usecs =3D ec->tx_coalesce_usecs;
>         vi->intr_coal_tx.max_packets =3D ec->tx_max_coalesced_frames;
> +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +               vi->sq[i].intr_coal.max_usecs =3D ec->tx_coalesce_usecs;
> +               vi->sq[i].intr_coal.max_packets =3D ec->tx_max_coalesced_=
frames;
> +       }
>
>         vi->ctrl->coal_rx.rx_usecs =3D cpu_to_le32(ec->rx_coalesce_usecs)=
;
>         vi->ctrl->coal_rx.rx_max_packets =3D cpu_to_le32(ec->rx_max_coale=
sced_frames);
> @@ -3259,6 +3264,10 @@ static int virtnet_send_notf_coal_cmds(struct virt=
net_info *vi,
>         /* Save parameters */
>         vi->intr_coal_rx.max_usecs =3D ec->rx_coalesce_usecs;
>         vi->intr_coal_rx.max_packets =3D ec->rx_max_coalesced_frames;
> +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +               vi->rq[i].intr_coal.max_usecs =3D ec->rx_coalesce_usecs;
> +               vi->rq[i].intr_coal.max_packets =3D ec->rx_max_coalesced_=
frames;
> +       }
>
>         return 0;
>  }
> --
> 2.19.1.6.gb485710b
>


