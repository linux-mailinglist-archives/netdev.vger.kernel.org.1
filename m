Return-Path: <netdev+bounces-40354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7837C6E1B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 14:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD801C20B85
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 12:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B77262B9;
	Thu, 12 Oct 2023 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nenCB33T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A978D25104
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:29:57 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC66B7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 05:29:55 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-4542d7e9bcfso395171137.3
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697113795; x=1697718595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fX1x/CHaM+ecCKo8lG2GN9F0sIOI/FXt41JYpkpOTc=;
        b=nenCB33T+d8D4Yb40ykZ3WBunS39dZ0e0MQ9q1H7AeNoFji6kNEjh/wNtafkz6ANh0
         3nRxNK3IBc3+UCkbaPExJOr8SIzQxXyOePSSPqqK/6hI38lcBxGsz/ptCHnICmLCV2on
         kq1yDNdBwKPEpWYvlHgXiU8z50cHeNNihhyVbn7oTg2mGmkiD/zFwa2sV9PgTQGQOsoj
         SzVo/r8fyQt9Aa7QpykYxlVes+v+eFb+dSUM13QmLREuNOR8CRaHTCXmsFw/sSFeq+W7
         6s2sq3VFYJPwc4kUbgCIc/AHorxpnGYh8UTbI6f6r21RGhVupuEle4Jzxi8q6BHTGPXv
         mH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697113795; x=1697718595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fX1x/CHaM+ecCKo8lG2GN9F0sIOI/FXt41JYpkpOTc=;
        b=QyqHLPPT1XdaV4aMScOyEuBCSJyLSidYsl4zGNSbJKH5i5TtECk9H7OngPyG/iT4GG
         KU34rXDYTxbiMnEevMqqiIKZryxg75SbnD5w3odnefn1kHvYVsLPDzl/IwMXsK707PJZ
         onHd/c9UnPGieDn8K7wfZj9+bEpgp/uj2vFPRoFgdsV3reiKaThJabm2POHV24jUYAKv
         kYQh4cxqvMu9RMitcU3UVUh9xgVYM8uQbyRlKawj86mZfe57DlraJD6s9MqsgAdmjgMG
         p4+574MFn9Tlio4QsMJTynMFiFoVg3e42ErjADdh+OCH4UYAlgmuMWXf7MTE8gW3z17C
         VSTA==
X-Gm-Message-State: AOJu0YygN1Vgbb5ipfbhm4tfIUeznot72e1G/KohYma+4fXnoK52XyGH
	QNwXokjhiQAOw8m111T445FNNgxp/Au/R60xKqftTgTW
X-Google-Smtp-Source: AGHT+IFCiJO5JrbAU84BolhCK+HNtwLCi+dd99DZknc/sKmCKHzJ2koPYd3ItZVEbCDNmWB8jU+s0gmk9nrNEnwoEYc=
X-Received: by 2002:a67:fe55:0:b0:452:9988:5cbd with SMTP id
 m21-20020a67fe55000000b0045299885cbdmr19335308vsr.5.1697113794528; Thu, 12
 Oct 2023 05:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011140126.800508-1-willemdebruijn.kernel@gmail.com> <CACGkMEuq3srKZWYsVQutfHOuJAyHDz4xCJWG3o6hs+W_HhZ2jQ@mail.gmail.com>
In-Reply-To: <CACGkMEuq3srKZWYsVQutfHOuJAyHDz4xCJWG3o6hs+W_HhZ2jQ@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 12 Oct 2023 08:29:17 -0400
Message-ID: <CAF=yD-Lat+ooErKN6GxOX6Q2oOHBvjCfty5w=N6C+076zSZ6zw@mail.gmail.com>
Subject: Re: [PATCH net] net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew@daynix.com, 
	Willem de Bruijn <willemb@google.com>, syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com, 
	syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 4:00=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Oct 11, 2023 at 10:01=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > From: Willem de Bruijn <willemb@google.com>
> >
> > Syzbot reported two new paths to hit an internal WARNING using the
> > new virtio gso type VIRTIO_NET_HDR_GSO_UDP_L4.
> >
> >     RIP: 0010:skb_checksum_help+0x4a2/0x600 net/core/dev.c:3260
> >     skb len=3D64521 gso_size=3D344
> > and
> >
> >     RIP: 0010:skb_warn_bad_offload+0x118/0x240 net/core/dev.c:3262
> >
> > Older virtio types have historically had loose restrictions, leading
> > to many entirely impractical fuzzer generated packets causing
> > problems deep in the kernel stack. Ideally, we would have had strict
> > validation for all types from the start.
> >
> > New virtio types can have tighter validation. Limit UDP GSO packets
> > inserted via virtio to the same limits imposed by the UDP_SEGMENT
> > socket interface:
> >
> > 1. must use checksum offload
> > 2. checksum offload matches UDP header
> > 3. no more segments than UDP_MAX_SEGMENTS
> > 4. UDP GSO does not take modifier flags, notably SKB_GSO_TCP_ECN
> >
> > Fixes: 860b7f27b8f7 ("linux/virtio_net.h: Support USO offload in vnet h=
eader.")
> > Reported-by: syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/0000000000005039270605eb0b7f@goo=
gle.com/
> > Reported-by: syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/0000000000005426680605eb0b9f@goo=
gle.com/
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > ---
> >  include/linux/virtio_net.h | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 7b4dd69555e49..27cc1d4643219 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -3,8 +3,8 @@
> >  #define _LINUX_VIRTIO_NET_H
> >
> >  #include <linux/if_vlan.h>
> > +#include <linux/udp.h>
> >  #include <uapi/linux/tcp.h>
> > -#include <uapi/linux/udp.h>
> >  #include <uapi/linux/virtio_net.h>
> >
> >  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gs=
o_type)
> > @@ -151,9 +151,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_=
buff *skb,
> >                 unsigned int nh_off =3D p_off;
> >                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> >
> > -               /* UFO may not include transport header in gso_size. */
> > -               if (gso_type & SKB_GSO_UDP)
> > +               switch (gso_type & ~SKB_GSO_TCP_ECN) {
> > +               case SKB_GSO_UDP:
> > +                       /* UFO may not include transport header in gso_=
size. */
> >                         nh_off -=3D thlen;
> > +                       break;
> > +               case SKB_GSO_UDP_L4:
> > +                       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM)=
)
> > +                               return -EINVAL;
> > +                       if (skb->csum_offset !=3D offsetof(struct udphd=
r, check))
> > +                               return -EINVAL;
> > +                       if (skb->len - p_off > gso_size * UDP_MAX_SEGME=
NTS)
> > +                               return -EINVAL;
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> But a question comes into my mind: whether the udp max segments should
> be part of the virtio ABI or not.

Implicitly it is part of the ABI, but so are other sensible
limitations, such as MAX_SKB_FRAGS. The limit was chosen high enough
to be unlikely to be a barrier to normal segmentation operations.

