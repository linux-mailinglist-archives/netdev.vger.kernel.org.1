Return-Path: <netdev+bounces-29831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDA4784DDE
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F26B1C20C01
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F42E7E2;
	Wed, 23 Aug 2023 00:36:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFCA10E3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:36:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2615CF9
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692750988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2IL+cZp/0HHCpa5Ko71FJgAGVSdljaI2sGgMww+L4A=;
	b=FBbzeja4mHHuACvtrAFC0m++jEZELNkq5mnNY3HVYk97ujEFlpXpYK4gH0opszR6cDm6qU
	l65RbkHHXqPrZHVDK3zKgl0x9w/kR6pR2KS2YmbRf8baimVQprQZAlpHgtMZLakUL/qM4N
	EEqXBOXekCc7CmK58eq+hDlnmzIvz6A=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-TwCC2YDqNESpl5iSmxKHJw-1; Tue, 22 Aug 2023 20:36:27 -0400
X-MC-Unique: TwCC2YDqNESpl5iSmxKHJw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9d0b3a572so56664151fa.1
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692750985; x=1693355785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2IL+cZp/0HHCpa5Ko71FJgAGVSdljaI2sGgMww+L4A=;
        b=HMjKJZZ8yyQLfp/ivkW3uNoiaQZN7NjWN8WaR/zmo87SIkyorLmhydA7dvZcMlbU+r
         jGI5nk3gPvSOXJQR8wylGv8QD3VaT8+5VFi9Z5C4b3i569YcM/CQRv7fQgn/QkPO3NOh
         kmS5xKL+lcy8cIlN0iBfsNRFY9TLMEXS7lMS6I2xcMAt9FsJzIWYVWBj0vefR2uGVvHW
         mWUZYHDc1Ap+BW6sRq0FKzaerqj7O0gjV9wi0laZJl+gAz4SIliYRsDQpjLKe36x+1Ea
         Tyds7hQqWIsZKcR4Wx3B007n7NZEFwKAjO1JPBzmYZwP6VbJIEo/thB1zMfhEzowt/mt
         wElQ==
X-Gm-Message-State: AOJu0Yx2Sk5tOiC3CSglWaDbEACkAPuhNWLJZ+a8/ew4/qahCNgEZM27
	BQ+G8mbvF0rSwcmEcaAUEyA08eqK+fbL0LxCSAv3JKyVA5XGi/x2lKmav5Wvrz3hV8CJpW5gkSz
	04WKAPA/DOp27bBONr8v0oo2fzkpTsvwg
X-Received: by 2002:a2e:3607:0:b0:2b6:de52:357 with SMTP id d7-20020a2e3607000000b002b6de520357mr8028174lja.40.1692750985670;
        Tue, 22 Aug 2023 17:36:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEFPDsk5hA0Fn4R6rUDIO6eqwFcn1qxMxURYoc60s0yH3huA1vp9eXuhPoq72Mx9oKSgrLLDu1lRa2xVe/Epk=
X-Received: by 2002:a2e:3607:0:b0:2b6:de52:357 with SMTP id
 d7-20020a2e3607000000b002b6de520357mr8028163lja.40.1692750985367; Tue, 22 Aug
 2023 17:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821142713.5062-1-feliu@nvidia.com>
In-Reply-To: <20230821142713.5062-1-feliu@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Aug 2023 08:36:14 +0800
Message-ID: <CACGkMEvbYCf-TsV+VtNT6iUiHM7s+MOnJ5UZz8yyw2MSifVT5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
To: Feng Liu <feliu@nvidia.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Simon Horman <horms@kernel.org>, Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 10:27=E2=80=AFPM Feng Liu <feliu@nvidia.com> wrote:
>
> The virtio_net driver currently deals with different versions and types
> of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
> virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
> on multiple type casts to convert memory between different structures,
> potentially leading to bugs when there are changes in these structures.
>
> Introduces the "struct skb_vnet_common_hdr" as a unifying header
> structure using a union. With this approach, various virtio net header
> structures can be converted by accessing different members of this
> structure, thus eliminating the need for type casting and reducing the
> risk of potential bugs.
>
> For example following code:
> static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>                 struct receive_queue *rq,
>                 struct page *page, unsigned int offset,
>                 unsigned int len, unsigned int truesize,
>                 unsigned int headroom)
> {
> [...]
>         struct virtio_net_hdr_mrg_rxbuf *hdr;
> [...]
>         hdr_len =3D vi->hdr_len;
> [...]
> ok:
>         hdr =3D skb_vnet_hdr(skb);
>         memcpy(hdr, hdr_p, hdr_len);
> [...]
> }
>
> When VIRTIO_NET_F_HASH_REPORT feature is enabled, hdr_len =3D 20
> But the sizeof(*hdr) is 12,
> memcpy(hdr, hdr_p, hdr_len); will copy 20 bytes to the hdr,
> which make a potential risk of bug. And this risk can be avoided by
> introducing struct skb_vnet_common_hdr.
>
> Change log
> v1->v2
> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> feedback from Simon Horman <horms@kernel.org>
> 1. change to use net-next tree.
> 2. move skb_vnet_common_hdr inside kernel file instead of the UAPI header=
.
>
> v2->v3
> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> 1. fix typo in commit message.
> 2. add original struct virtio_net_hdr into union
> 3. remove virtio_net_hdr_mrg_rxbuf variable in receive_buf;
>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e9f4cfe941f..8c74bc8cfe68 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -303,6 +303,14 @@ struct padded_vnet_hdr {
>         char padding[12];
>  };
>
> +struct virtio_net_common_hdr {
> +       union {
> +               struct virtio_net_hdr hdr;
> +               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> +               struct virtio_net_hdr_v1_hash hash_v1_hdr;
> +       };
> +};
> +
>  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>
> @@ -344,9 +352,10 @@ static int rxq2vq(int rxq)
>         return rxq * 2;
>  }
>
> -static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_bu=
ff *skb)
> +static inline struct virtio_net_common_hdr *
> +skb_vnet_common_hdr(struct sk_buff *skb)
>  {
> -       return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
> +       return (struct virtio_net_common_hdr *)skb->cb;
>  }
>
>  /*
> @@ -469,7 +478,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>                                    unsigned int headroom)
>  {
>         struct sk_buff *skb;
> -       struct virtio_net_hdr_mrg_rxbuf *hdr;
> +       struct virtio_net_common_hdr *hdr;
>         unsigned int copy, hdr_len, hdr_padded_len;
>         struct page *page_to_free =3D NULL;
>         int tailroom, shinfo_size;
> @@ -554,7 +563,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>                 give_pages(rq, page);
>
>  ok:
> -       hdr =3D skb_vnet_hdr(skb);
> +       hdr =3D skb_vnet_common_hdr(skb);
>         memcpy(hdr, hdr_p, hdr_len);
>         if (page_to_free)
>                 put_page(page_to_free);
> @@ -966,7 +975,7 @@ static struct sk_buff *receive_small_build_skb(struct=
 virtnet_info *vi,
>                 return NULL;
>
>         buf +=3D header_offset;
> -       memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> +       memcpy(skb_vnet_common_hdr(skb), buf, vi->hdr_len);
>
>         return skb;
>  }
> @@ -1577,7 +1586,7 @@ static void receive_buf(struct virtnet_info *vi, st=
ruct receive_queue *rq,
>  {
>         struct net_device *dev =3D vi->dev;
>         struct sk_buff *skb;
> -       struct virtio_net_hdr_mrg_rxbuf *hdr;
> +       struct virtio_net_common_hdr *hdr;
>
>         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>                 pr_debug("%s: short packet %i\n", dev->name, len);
> @@ -1597,9 +1606,9 @@ static void receive_buf(struct virtnet_info *vi, st=
ruct receive_queue *rq,
>         if (unlikely(!skb))
>                 return;
>
> -       hdr =3D skb_vnet_hdr(skb);
> +       hdr =3D skb_vnet_common_hdr(skb);
>         if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> -               virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash =
*)hdr, skb);
> +               virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
>
>         if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>                 skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> @@ -2105,7 +2114,7 @@ static int xmit_skb(struct send_queue *sq, struct s=
k_buff *skb)
>         if (can_push)
>                 hdr =3D (struct virtio_net_hdr_mrg_rxbuf *)(skb->data - h=
dr_len);
>         else
> -               hdr =3D skb_vnet_hdr(skb);
> +               hdr =3D &skb_vnet_common_hdr(skb)->mrg_hdr;
>
>         if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
>                                     virtio_is_little_endian(vi->vdev), fa=
lse,
> --
> 2.37.1 (Apple Git-137.1)
>


