Return-Path: <netdev+bounces-40574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B29B7C7B29
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 03:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13917281634
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397A781C;
	Fri, 13 Oct 2023 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNtnfJT8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3533B80A
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 01:30:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B205E3
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 18:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697160652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfT/FMpmZ/HEkzk47zbmE1dRPG8D6i4lQxrROMeYVjI=;
	b=iNtnfJT8sbPF1V06ZNXEMNkznyEOsh1yLUhB+CrZAxyLNzDH/JETBik0eWs2dySBGSXEQl
	Eomc+X/s/z/5AD9rWDcPRs12x2paIK6ld85Q7TG7PmhMtt9+TQDN//BEaCArVUPdrtFn7u
	Gv7a+8Da8dx26YgEJKgB/gWOHby2xdI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-55wkyuSdOCujEXx5MhklwA-1; Thu, 12 Oct 2023 21:30:50 -0400
X-MC-Unique: 55wkyuSdOCujEXx5MhklwA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c5098fe88bso202931fa.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 18:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697160649; x=1697765449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfT/FMpmZ/HEkzk47zbmE1dRPG8D6i4lQxrROMeYVjI=;
        b=oFrQV6G7m4Fec5gELzfAZFIjzmiwyQOMQ2xraDLr0BRkxUsu7N9r1D3+eKI5flCLRC
         OFh/WXd7ri6PlQb0gIdPUbt7m0KMsaxwoiObhf0zhcVCljVvHgKLKl1enw7oZSVbEqv9
         QpiMbR2P/9NFwMoH9peNx0aaWCprEMRLv9hbM9gYuyuqGUBVEwznNUQgcRn8LtxMIR77
         FG9rNRbI3gS+HxrTWNJ/sJHR331VoR+uNsVMR7LcuuaKU/3E8W09eJ6TTMB1pE5jh+nH
         fdv9tuNR/kTgwFaooZ72aAEygBq7OP6AdqzK1YNOpGd0CNCVUZeW+QmtCZPjAVHCvRwQ
         q+Lg==
X-Gm-Message-State: AOJu0YwkiYjzsFDov6jvgkZiDR6usSBpV/WwkHAYzdOQEbYqGQGCIO+C
	pGzlVZp5GbwrMZM1pgSbMBSp8dYdX5Wdrw/7+N6n4cSl55YJzFYdKLproUb9cwL4F0b5s7oOtzO
	8WSAGYx9cNQ/fCcPUEy23He/lloNi4jER
X-Received: by 2002:a19:e048:0:b0:507:973f:a7dd with SMTP id g8-20020a19e048000000b00507973fa7ddmr1345596lfj.26.1697160649474;
        Thu, 12 Oct 2023 18:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGil6WIwuVox0loXAF6qXa0cJJPEIiUE7ED3rA6zAvOlqnfy4LWVwLY2ZFTSaKEhUbH1DK71bWwUO/YboOjYVA=
X-Received: by 2002:a19:e048:0:b0:507:973f:a7dd with SMTP id
 g8-20020a19e048000000b00507973fa7ddmr1345589lfj.26.1697160649165; Thu, 12 Oct
 2023 18:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011140126.800508-1-willemdebruijn.kernel@gmail.com>
 <CACGkMEuq3srKZWYsVQutfHOuJAyHDz4xCJWG3o6hs+W_HhZ2jQ@mail.gmail.com> <CAF=yD-Lat+ooErKN6GxOX6Q2oOHBvjCfty5w=N6C+076zSZ6zw@mail.gmail.com>
In-Reply-To: <CAF=yD-Lat+ooErKN6GxOX6Q2oOHBvjCfty5w=N6C+076zSZ6zw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Oct 2023 09:30:37 +0800
Message-ID: <CACGkMEtTqJ9NWTE=V9QUh57b59Y7VzNU-4E2wjUpROpWy5nanw@mail.gmail.com>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 8:29=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Oct 12, 2023 at 4:00=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Oct 11, 2023 at 10:01=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > Syzbot reported two new paths to hit an internal WARNING using the
> > > new virtio gso type VIRTIO_NET_HDR_GSO_UDP_L4.
> > >
> > >     RIP: 0010:skb_checksum_help+0x4a2/0x600 net/core/dev.c:3260
> > >     skb len=3D64521 gso_size=3D344
> > > and
> > >
> > >     RIP: 0010:skb_warn_bad_offload+0x118/0x240 net/core/dev.c:3262
> > >
> > > Older virtio types have historically had loose restrictions, leading
> > > to many entirely impractical fuzzer generated packets causing
> > > problems deep in the kernel stack. Ideally, we would have had strict
> > > validation for all types from the start.
> > >
> > > New virtio types can have tighter validation. Limit UDP GSO packets
> > > inserted via virtio to the same limits imposed by the UDP_SEGMENT
> > > socket interface:
> > >
> > > 1. must use checksum offload
> > > 2. checksum offload matches UDP header
> > > 3. no more segments than UDP_MAX_SEGMENTS
> > > 4. UDP GSO does not take modifier flags, notably SKB_GSO_TCP_ECN
> > >
> > > Fixes: 860b7f27b8f7 ("linux/virtio_net.h: Support USO offload in vnet=
 header.")
> > > Reported-by: syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/netdev/0000000000005039270605eb0b7f@g=
oogle.com/
> > > Reported-by: syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/netdev/0000000000005426680605eb0b9f@g=
oogle.com/
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > ---
> > >  include/linux/virtio_net.h | 19 ++++++++++++++++---
> > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > index 7b4dd69555e49..27cc1d4643219 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -3,8 +3,8 @@
> > >  #define _LINUX_VIRTIO_NET_H
> > >
> > >  #include <linux/if_vlan.h>
> > > +#include <linux/udp.h>
> > >  #include <uapi/linux/tcp.h>
> > > -#include <uapi/linux/udp.h>
> > >  #include <uapi/linux/virtio_net.h>
> > >
> > >  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 =
gso_type)
> > > @@ -151,9 +151,22 @@ static inline int virtio_net_hdr_to_skb(struct s=
k_buff *skb,
> > >                 unsigned int nh_off =3D p_off;
> > >                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > >
> > > -               /* UFO may not include transport header in gso_size. =
*/
> > > -               if (gso_type & SKB_GSO_UDP)
> > > +               switch (gso_type & ~SKB_GSO_TCP_ECN) {
> > > +               case SKB_GSO_UDP:
> > > +                       /* UFO may not include transport header in gs=
o_size. */
> > >                         nh_off -=3D thlen;
> > > +                       break;
> > > +               case SKB_GSO_UDP_L4:
> > > +                       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSU=
M))
> > > +                               return -EINVAL;
> > > +                       if (skb->csum_offset !=3D offsetof(struct udp=
hdr, check))
> > > +                               return -EINVAL;
> > > +                       if (skb->len - p_off > gso_size * UDP_MAX_SEG=
MENTS)
> > > +                               return -EINVAL;
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > But a question comes into my mind: whether the udp max segments should
> > be part of the virtio ABI or not.
>
> Implicitly it is part of the ABI, but so are other sensible
> limitations, such as MAX_SKB_FRAGS.

There's no easy to detect things like MAX_SKB_FRAGS or anything I miss
here? For example, guests can send a packet with s/g more than
MAX_SKB_FRAGS, TUN can arrange the skb allocation to make sure it
doesn't exceed the limitation. This is not the case for
UDP_MAX_SEGMENTS.

Thanks

> The limit was chosen high enough
> to be unlikely to be a barrier to normal segmentation operations.
>


