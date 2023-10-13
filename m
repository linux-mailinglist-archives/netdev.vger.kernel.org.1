Return-Path: <netdev+bounces-40674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E0C7C84AC
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C77CB2096D
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCF213AEA;
	Fri, 13 Oct 2023 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ89Zmg/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07A134DB
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:40:41 +0000 (UTC)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF9BD
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 04:40:38 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49d8dd34f7bso788737e0c.3
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697197237; x=1697802037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkZH5VriCHSQZytBlG8lNBLKlM/ZSYRDGW3tbI1GaD8=;
        b=nJ89Zmg/CjK5r82kYJATtNH52gExbC4iPLeD3iLX6USk01gmd3ttFewEJ4CMNj5tBQ
         4WeiIWUpA+6sxpcOzA38cpMmKCJ0sJwYKExQ65jZW5kqFl9Ci1DaWpGHWtl5KlHmBdSn
         2CanNz7F3qRPbmI95+hEbieycWskS5fsQ7SPNo8zlz/3cur3ewFx7B5eyxtQVLaNkOeQ
         74/W9Eh5n3fqmGoOD9t/qAhErHSvRiPC6E8toHxo4bgvyYjpyYPI/7IMbzd1IakFHAId
         bvUcrMDOOsdv6yytWUk2qA3AIdldrVPcx9RXmuBggMChBzO4HY0yYv/siKZmwtriGUHd
         0vaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197237; x=1697802037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkZH5VriCHSQZytBlG8lNBLKlM/ZSYRDGW3tbI1GaD8=;
        b=CwD4QNza+Hs9hvrCLx8DYl+evJ8z8SPLN4pg9XFxceH6Bh+AoNixgDhiI/M2ZiqFTJ
         v3saMjlRqT+QmDRhOth8ctsK7PDxW3mRJ1yFS6Q5ArxKVEMYVQBNyrSgFA6li7gomsgH
         R7AeYoPcJp0NRcE+2igvYeubzHY2yj6U3ZCi1Gy6s/UKuHAlASajD5KSu1UW0UgzO1Cv
         phsHPHFHwYMPh9kg584FWh+iDx46BtoqTywTOHwJkVRAWTeKfzKNsZ35QPK9md0eEFlz
         +yjrfx0jb+BTRIkiwVO/+LSDPo5UVu2oY1/F29r2tP1wnL9HOgcKkPygyp0BWp3XkyU4
         WcNA==
X-Gm-Message-State: AOJu0YyFYeUURJuGTSOi8sFrIER7mjzZkIP154199JIqM72buu/JHERo
	MkOduzhL9rcrv6Hp96kJH6op3R0KsHLuqDomZm4VM1zA
X-Google-Smtp-Source: AGHT+IFSOGlfElHitt3FRSHFipQhOGXom/uJViCxGNAPtdxe48oybJpu3A8Lgr/wtOkdj8mNYgFIMQygfk80uTlmwVQ=
X-Received: by 2002:a1f:ed02:0:b0:4a0:6fd4:4333 with SMTP id
 l2-20020a1fed02000000b004a06fd44333mr14408079vkh.13.1697197237546; Fri, 13
 Oct 2023 04:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011140126.800508-1-willemdebruijn.kernel@gmail.com>
 <CACGkMEuq3srKZWYsVQutfHOuJAyHDz4xCJWG3o6hs+W_HhZ2jQ@mail.gmail.com>
 <CAF=yD-Lat+ooErKN6GxOX6Q2oOHBvjCfty5w=N6C+076zSZ6zw@mail.gmail.com> <CACGkMEtTqJ9NWTE=V9QUh57b59Y7VzNU-4E2wjUpROpWy5nanw@mail.gmail.com>
In-Reply-To: <CACGkMEtTqJ9NWTE=V9QUh57b59Y7VzNU-4E2wjUpROpWy5nanw@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 13 Oct 2023 07:40:00 -0400
Message-ID: <CAF=yD-+-0SXnLhnu54rj5fVyTao23-c==nnqn2RxA8p3vK9t2A@mail.gmail.com>
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

On Thu, Oct 12, 2023 at 9:30=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Oct 12, 2023 at 8:29=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Thu, Oct 12, 2023 at 4:00=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Oct 11, 2023 at 10:01=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > From: Willem de Bruijn <willemb@google.com>
> > > >
> > > > Syzbot reported two new paths to hit an internal WARNING using the
> > > > new virtio gso type VIRTIO_NET_HDR_GSO_UDP_L4.
> > > >
> > > >     RIP: 0010:skb_checksum_help+0x4a2/0x600 net/core/dev.c:3260
> > > >     skb len=3D64521 gso_size=3D344
> > > > and
> > > >
> > > >     RIP: 0010:skb_warn_bad_offload+0x118/0x240 net/core/dev.c:3262
> > > >
> > > > Older virtio types have historically had loose restrictions, leadin=
g
> > > > to many entirely impractical fuzzer generated packets causing
> > > > problems deep in the kernel stack. Ideally, we would have had stric=
t
> > > > validation for all types from the start.
> > > >
> > > > New virtio types can have tighter validation. Limit UDP GSO packets
> > > > inserted via virtio to the same limits imposed by the UDP_SEGMENT
> > > > socket interface:
> > > >
> > > > 1. must use checksum offload
> > > > 2. checksum offload matches UDP header
> > > > 3. no more segments than UDP_MAX_SEGMENTS
> > > > 4. UDP GSO does not take modifier flags, notably SKB_GSO_TCP_ECN
> > > >
> > > > Fixes: 860b7f27b8f7 ("linux/virtio_net.h: Support USO offload in vn=
et header.")
> > > > Reported-by: syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/netdev/0000000000005039270605eb0b7f=
@google.com/
> > > > Reported-by: syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/netdev/0000000000005426680605eb0b9f=
@google.com/
> > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > ---
> > > >  include/linux/virtio_net.h | 19 ++++++++++++++++---
> > > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.=
h
> > > > index 7b4dd69555e49..27cc1d4643219 100644
> > > > --- a/include/linux/virtio_net.h
> > > > +++ b/include/linux/virtio_net.h
> > > > @@ -3,8 +3,8 @@
> > > >  #define _LINUX_VIRTIO_NET_H
> > > >
> > > >  #include <linux/if_vlan.h>
> > > > +#include <linux/udp.h>
> > > >  #include <uapi/linux/tcp.h>
> > > > -#include <uapi/linux/udp.h>
> > > >  #include <uapi/linux/virtio_net.h>
> > > >
> > > >  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u=
8 gso_type)
> > > > @@ -151,9 +151,22 @@ static inline int virtio_net_hdr_to_skb(struct=
 sk_buff *skb,
> > > >                 unsigned int nh_off =3D p_off;
> > > >                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > > >
> > > > -               /* UFO may not include transport header in gso_size=
. */
> > > > -               if (gso_type & SKB_GSO_UDP)
> > > > +               switch (gso_type & ~SKB_GSO_TCP_ECN) {
> > > > +               case SKB_GSO_UDP:
> > > > +                       /* UFO may not include transport header in =
gso_size. */
> > > >                         nh_off -=3D thlen;
> > > > +                       break;
> > > > +               case SKB_GSO_UDP_L4:
> > > > +                       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_C=
SUM))
> > > > +                               return -EINVAL;
> > > > +                       if (skb->csum_offset !=3D offsetof(struct u=
dphdr, check))
> > > > +                               return -EINVAL;
> > > > +                       if (skb->len - p_off > gso_size * UDP_MAX_S=
EGMENTS)
> > > > +                               return -EINVAL;
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > >
> > > But a question comes into my mind: whether the udp max segments shoul=
d
> > > be part of the virtio ABI or not.
> >
> > Implicitly it is part of the ABI, but so are other sensible
> > limitations, such as MAX_SKB_FRAGS.
>
> There's no easy to detect things like MAX_SKB_FRAGS or anything I miss
> here? For example, guests can send a packet with s/g more than
> MAX_SKB_FRAGS, TUN can arrange the skb allocation to make sure it
> doesn't exceed the limitation. This is not the case for
> UDP_MAX_SEGMENTS.

Perhaps MAX_SKB_FRAGS is not the best example. But there are other
conditions that are discoverable by validation returning an error when
outside the bounds of normal operation.

UDP_MAX_SEGMENTS is also not explicitly exposed to UDP_SEGMENT socket
users, without issues.

If absolutely needed, the boundary can be detected through probing.
But it should not be needed as chosen to be well outside normal
operating range.

A secondary benefit is that future kernels can relax (but not tighten)
the restriction if needed. The current limit was chosen with the usual
64KB / 1500B operating default in mind. If we would extend BIGTCP to
UDP, the existing limit of 64 might need relaxing (for both virtio and
sockets simultaneously). Anything ABI is set in stone, best to avoid
if not strictly necessary.

