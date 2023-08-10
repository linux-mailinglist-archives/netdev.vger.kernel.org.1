Return-Path: <netdev+bounces-26222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB93377733C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016321C2147D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8500F1C9E1;
	Thu, 10 Aug 2023 08:44:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD5186C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:44:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66C326BC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691657083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/XARBHUNfpKRSnWZ8phWlFKnQY1ySWvTtddZ5XFgCw=;
	b=OdSdQNzitieHEo33fEg795CBxCbdtjB7Y/ydqSbue13s0jGqQs6WYr7NqTdxTBJDaFnzsr
	kX6D1tOEjsElD7WqTGCqxa+6BDngFEQ+9dY2i6+X3J4+ZOfaWz1Nq230BMscs2I6mZN0YJ
	2EVCylIrCEmrsNs8aPmxuaiFtRZhhkE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-eB40v3TxNLyGXdPeL4ChFA-1; Thu, 10 Aug 2023 04:44:42 -0400
X-MC-Unique: eB40v3TxNLyGXdPeL4ChFA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-56942442eb0so10211927b3.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657082; x=1692261882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/XARBHUNfpKRSnWZ8phWlFKnQY1ySWvTtddZ5XFgCw=;
        b=V/tzxOGN/xnZTUMTJO8KJvSdvYI8BnYd9PomN9DLgUmzG1UZJMGIZ6Gcbr29S+0QYs
         pczplaEX3Fl/IkpbVZXxiE3SFImw5WMiEf1WT5GIDAdxQKL6JYp4L/rQosKbEpaKVg3g
         dj2B/eR999Cyayd5vgyV3AgWqbgKtsqeL7U2YnC3K1p4Si0FjNGFCIOm49Ida0HgawKx
         yBGey3YmMjnlCayTUMSWAYjvSLsLc/lmXKFUtz0FjFvf6KMuGxVhlG3KKgybkQnkNoxy
         6TsWjOV4xhCzJMzOAP5f33rg5hJJI6s6C4b0pOf9YHcJlvn4pDBk463jVn47htqSQik4
         jxiw==
X-Gm-Message-State: AOJu0YxLzI+QhUm4HSqTfkoqMe2NwfCygjcF0agf2FBWRixaCknVYGVR
	8aNws2D/htKQdIggTeSmeVLTLKvmjDf6JvyVr2v0aCdyp/FnylJ8OWCLFWo8bvHk6yEyJnASACg
	cZBXfHVQ46HlWRcdFpMspfzb4qLgbvhBq
X-Received: by 2002:a25:b92:0:b0:d0f:ea4b:1dff with SMTP id 140-20020a250b92000000b00d0fea4b1dffmr1867125ybl.8.1691657082034;
        Thu, 10 Aug 2023 01:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFBo1aUNEaXKYTWOZ5RTaEuRyB2I1Ji4x6yJ0+dGDKLhUKju4Y+wKNw1oJ/Oc5Qi2Wd8yycuFnak4XyYefkPU=
X-Received: by 2002:a25:b92:0:b0:d0f:ea4b:1dff with SMTP id
 140-20020a250b92000000b00d0fea4b1dffmr1867118ybl.8.1691657081820; Thu, 10 Aug
 2023 01:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810031557.135557-1-yin31149@gmail.com>
In-Reply-To: <20230810031557.135557-1-yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 10 Aug 2023 10:44:05 +0200
Message-ID: <CAJaqyWcex+R_=umJoR2a-FNPmV+cZDKSoLzx1RnM4KzZDCoCAg@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG
 case
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	18801353760@163.com, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 5:16=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Kernel uses `struct virtio_net_ctrl_rss` to save command-specific-data
> for both the VIRTIO_NET_CTRL_MQ_HASH_CONFIG and
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG commands.
>
> According to the VirtIO standard, "Field reserved MUST contain zeroes.
> It is defined to make the structure to match the layout of
> virtio_net_rss_config structure, defined in 5.1.6.5.7.".
>
> Yet for the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command case, the `max_tx_vq`
> field in struct virtio_net_ctrl_rss, which corresponds to the
> `reserved` field in struct virtio_net_hash_config, is not zeroed,
> thereby violating the VirtIO standard.
>
> This patch solves this problem by zeroing this field in
> virtnet_init_default_rss().
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>
> TestStep
> =3D=3D=3D=3D=3D=3D=3D=3D
> 1. Boot QEMU with one virtio-net-pci net device with `mq` and `hash`
> feature on, command line like:
>       -netdev tap,vhost=3Doff,...
>       -device virtio-net-pci,mq=3Don,hash=3Don,...
>
> 2. Trigger VIRTIO_NET_CTRL_MQ_HASH_CONFIG command in guest, command
> line like:
>         ethtool -K eth0 rxhash on
>
> Without this patch, in virtnet_commit_rss_command(), we can see the
> `max_tx_vq` field is 1 in gdb like below:
>
>         pwndbg> p vi->ctrl->rss
>         $1 =3D {
>           hash_types =3D 63,
>           indirection_table_mask =3D 0,
>           unclassified_queue =3D 0,
>           indirection_table =3D {0 <repeats 128 times>},
>           max_tx_vq =3D 1,
>           hash_key_length =3D 40 '(',
>           ...
>         }
>
> With this patch, in virtnet_commit_rss_command(), we can see the
> `max_tx_vq` field is 0 in gdb like below:
>
>         pwndbg> p vi->ctrl->rss
>         $1 =3D {
>           hash_types =3D 63,
>           indirection_table_mask =3D 0,
>           unclassified_queue =3D 0,
>           indirection_table =3D {0 <repeats 128 times>},
>           max_tx_vq =3D 0,
>           hash_key_length =3D 40 '(',
>           ...
>         }
>
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1270c8d23463..8db38634ae82 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2761,7 +2761,7 @@ static void virtnet_init_default_rss(struct virtnet=
_info *vi)
>                 vi->ctrl->rss.indirection_table[i] =3D indir_val;
>         }
>
> -       vi->ctrl->rss.max_tx_vq =3D vi->curr_queue_pairs;
> +       vi->ctrl->rss.max_tx_vq =3D vi->has_rss ? vi->curr_queue_pairs : =
0;
>         vi->ctrl->rss.hash_key_length =3D vi->rss_key_size;
>
>         netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
> --
> 2.34.1
>


