Return-Path: <netdev+bounces-40270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646467C6757
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 10:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCB61C2109C
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDA171CC;
	Thu, 12 Oct 2023 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqQr+4bY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5A1F934
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 08:00:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C2EB8
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697097644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntZj0I0CR66wYqP9sJo2oNlSDT1d1vRVOrgPNS3hoHQ=;
	b=KqQr+4bYEB65EGrfgBtCnFUj87EYN/ZRfY6omyN7/y0+P2Xb/dRg8BNkOc7vveUMQWl+kr
	3yUTQ68yvWDdq2t8zknTfW2qA1BJCRScJde4N6U1ACUTD8GqnJbFMpe8217S9mTA0tjvEQ
	gpprSEuoyx2QTzDbEkuji/A1ACIPJ6g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-aXD8yegzORWfh9wKSVDFcA-1; Thu, 12 Oct 2023 04:00:42 -0400
X-MC-Unique: aXD8yegzORWfh9wKSVDFcA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-502fff967ccso702118e87.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 01:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697097641; x=1697702441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntZj0I0CR66wYqP9sJo2oNlSDT1d1vRVOrgPNS3hoHQ=;
        b=TY8haFcyLcfagGRcmgXkdxFEaW92q6IpQbzUwrjUEFBwtjYdkABzQ5XGy6PfiYhvWI
         l8WKLVKQ0vdHpA2bukhQaCSaEFJEReN7pwHljQMwQEtsAwgn3cr8IYU0zlVbMj+9DTa9
         ST3ELRS1ECrSFuDVpXhVrHuzwRakl8IyTJCuHXuuMWnk5Z84t/cGV5xpoUz4e9fv8BKv
         1sAmxdffmqniLH6TVKu2EndTmddg0aS0Ga74OI0Zg1P5Jt5elzAe03/V/fhqkf7UWPpm
         GQqNKQq0l9KWZP7M9DG5J5zxQZU9GmhGue/Y1MYIlWnLr6+Eks0X0jXT8BeH2BC62cQO
         nyLw==
X-Gm-Message-State: AOJu0YxfPLeZKSJ3k8Rp11Ovrt/7cV1iOSvI86xRwfgAtzRBxzPF6vlQ
	Y/D5cAvUQlhkKTKoXRKdAUHaAQj1kEesqzDcxFivJogUf+QVeh1+HlobnvCVpct3P2mhPNdp6uS
	M2eiHCKC0HkJ7msY2Eg/mHwZsK/auNr9g
X-Received: by 2002:a05:6512:3d07:b0:4fe:7e7f:1328 with SMTP id d7-20020a0565123d0700b004fe7e7f1328mr26424456lfv.16.1697097640951;
        Thu, 12 Oct 2023 01:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKfwjwW0BFDJ/wmPiezWCBqN9+B2XXEVRw5cRs3P6WmCJC5B0pwPALUiYXgQ/0gCEX1cvTxta4MkkTtUEdvt0=
X-Received: by 2002:a05:6512:3d07:b0:4fe:7e7f:1328 with SMTP id
 d7-20020a0565123d0700b004fe7e7f1328mr26424426lfv.16.1697097640548; Thu, 12
 Oct 2023 01:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011140126.800508-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231011140126.800508-1-willemdebruijn.kernel@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Oct 2023 16:00:29 +0800
Message-ID: <CACGkMEuq3srKZWYsVQutfHOuJAyHDz4xCJWG3o6hs+W_HhZ2jQ@mail.gmail.com>
Subject: Re: [PATCH net] net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew@daynix.com, 
	Willem de Bruijn <willemb@google.com>, syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com, 
	syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 10:01=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> Syzbot reported two new paths to hit an internal WARNING using the
> new virtio gso type VIRTIO_NET_HDR_GSO_UDP_L4.
>
>     RIP: 0010:skb_checksum_help+0x4a2/0x600 net/core/dev.c:3260
>     skb len=3D64521 gso_size=3D344
> and
>
>     RIP: 0010:skb_warn_bad_offload+0x118/0x240 net/core/dev.c:3262
>
> Older virtio types have historically had loose restrictions, leading
> to many entirely impractical fuzzer generated packets causing
> problems deep in the kernel stack. Ideally, we would have had strict
> validation for all types from the start.
>
> New virtio types can have tighter validation. Limit UDP GSO packets
> inserted via virtio to the same limits imposed by the UDP_SEGMENT
> socket interface:
>
> 1. must use checksum offload
> 2. checksum offload matches UDP header
> 3. no more segments than UDP_MAX_SEGMENTS
> 4. UDP GSO does not take modifier flags, notably SKB_GSO_TCP_ECN
>
> Fixes: 860b7f27b8f7 ("linux/virtio_net.h: Support USO offload in vnet hea=
der.")
> Reported-by: syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/0000000000005039270605eb0b7f@googl=
e.com/
> Reported-by: syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/0000000000005426680605eb0b9f@googl=
e.com/
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>  include/linux/virtio_net.h | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 7b4dd69555e49..27cc1d4643219 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -3,8 +3,8 @@
>  #define _LINUX_VIRTIO_NET_H
>
>  #include <linux/if_vlan.h>
> +#include <linux/udp.h>
>  #include <uapi/linux/tcp.h>
> -#include <uapi/linux/udp.h>
>  #include <uapi/linux/virtio_net.h>
>
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_=
type)
> @@ -151,9 +151,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_bu=
ff *skb,
>                 unsigned int nh_off =3D p_off;
>                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
>
> -               /* UFO may not include transport header in gso_size. */
> -               if (gso_type & SKB_GSO_UDP)
> +               switch (gso_type & ~SKB_GSO_TCP_ECN) {
> +               case SKB_GSO_UDP:
> +                       /* UFO may not include transport header in gso_si=
ze. */
>                         nh_off -=3D thlen;
> +                       break;
> +               case SKB_GSO_UDP_L4:
> +                       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> +                               return -EINVAL;
> +                       if (skb->csum_offset !=3D offsetof(struct udphdr,=
 check))
> +                               return -EINVAL;
> +                       if (skb->len - p_off > gso_size * UDP_MAX_SEGMENT=
S)
> +                               return -EINVAL;

Acked-by: Jason Wang <jasowang@redhat.com>

But a question comes into my mind: whether the udp max segments should
be part of the virtio ABI or not.

Otherwise guests may notice subtle differences after migration?

Thanks


> +                       if (gso_type !=3D SKB_GSO_UDP_L4)
> +                               return -EINVAL;
> +                       break;
> +               }
>
>                 /* Kernel has a special handling for GSO_BY_FRAGS. */
>                 if (gso_size =3D=3D GSO_BY_FRAGS)
> --
> 2.42.0.609.gbb76f46606-goog
>


