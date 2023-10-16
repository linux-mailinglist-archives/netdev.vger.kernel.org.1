Return-Path: <netdev+bounces-41156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6937C9FB9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 08:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 259DAB20C0E
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 06:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351DD134A9;
	Mon, 16 Oct 2023 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YS3OUpGR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81F14F63
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:40:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BFA97
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 23:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697438401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtocz0xnDLCru6Wp/42zrBx6bUeINs4MJNh9rY+1O2E=;
	b=YS3OUpGR3zV+p1k2dKhdFOWhCDn03fzPMY02gldblYV7jANb2SG0JsKwjnUxhFcLjnJH4Q
	eMbNGB7/DO6aZzi2q26kiLY7DK7c4uUr3bEfMgbbGWX/pstx/3J9R3voss6slEPj9dMmZV
	GPgmpYopcX+ES1SsV0G9gTB8EFI0FSQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-qh4-JZ_HOWW4polmFGZIwg-1; Mon, 16 Oct 2023 02:39:55 -0400
X-MC-Unique: qh4-JZ_HOWW4polmFGZIwg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5079fe7cc7cso1752203e87.2
        for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 23:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697438394; x=1698043194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtocz0xnDLCru6Wp/42zrBx6bUeINs4MJNh9rY+1O2E=;
        b=AdwF9fkjnoQXADH1zRt8JPzIamFyX3y+n5igv9tJ9S1wFh1oivspoD8sCVn4eCvd9I
         0p9QxwItnKekoQRROX5In/DnbVHT/gDF7axSA4lcqOcZxE0+TXM3dJpuE34EbUZ8wDUS
         1rki0RPGUoOcSnI8p9ovj8a8zPtOwa5mI4wtcRUUxx1MgVIdZ1aU5tthJO+crhwdvEm1
         oQJBvsOV1S0Jx+Yf3vyqoKLelgnMNaSt91xG3Y83I3ZTEXUvF9aH6jXNAo/0Z4LVnE6c
         A9rbFe0hVJMqeEmJs2qlVh+IC8CHkYQ8FarGwjXFbXxP447gHyHwVFWhXf95ivZaeEVH
         ZwkA==
X-Gm-Message-State: AOJu0YwDC0lanTI5XeUDvBxTz9m9qvoxOU4Nhw73yA+I+fWDvPp+53eY
	YzMBwCOvSUr8IAHwVWpnIOzZhnJTAgRTqkIsCWGE7wxmNSuV1X9YR7LcSpPMNMWJoWMnq5FsEUA
	cjAcW1f1Rr5MPyIIt91oDXCC+MeOnfeUW
X-Received: by 2002:a05:6512:ba3:b0:4f9:51ac:41eb with SMTP id b35-20020a0565120ba300b004f951ac41ebmr32026267lfv.16.1697438394143;
        Sun, 15 Oct 2023 23:39:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkFmWsn+fwTv5hGbnQo3vIP90tESyOO8ACPC++s468+R/wFrXd/HLv7Ygdl309Az9IxT3t8fjyChohb5Uqa2g=
X-Received: by 2002:a05:6512:ba3:b0:4f9:51ac:41eb with SMTP id
 b35-20020a0565120ba300b004f951ac41ebmr32026254lfv.16.1697438393713; Sun, 15
 Oct 2023 23:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011140126.800508-1-willemdebruijn.kernel@gmail.com>
 <CACGkMEuq3srKZWYsVQutfHOuJAyHDz4xCJWG3o6hs+W_HhZ2jQ@mail.gmail.com>
 <CAF=yD-Lat+ooErKN6GxOX6Q2oOHBvjCfty5w=N6C+076zSZ6zw@mail.gmail.com>
 <CACGkMEtTqJ9NWTE=V9QUh57b59Y7VzNU-4E2wjUpROpWy5nanw@mail.gmail.com> <CAF=yD-+-0SXnLhnu54rj5fVyTao23-c==nnqn2RxA8p3vK9t2A@mail.gmail.com>
In-Reply-To: <CAF=yD-+-0SXnLhnu54rj5fVyTao23-c==nnqn2RxA8p3vK9t2A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Oct 2023 14:39:42 +0800
Message-ID: <CACGkMEu+eMhNhkY0Aw-ahD_4pGKbDD58aP=KhYV_9KT3odN-Sg@mail.gmail.com>
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

On Fri, Oct 13, 2023 at 7:40=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Oct 12, 2023 at 9:30=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Oct 12, 2023 at 8:29=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > On Thu, Oct 12, 2023 at 4:00=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Oct 11, 2023 at 10:01=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > From: Willem de Bruijn <willemb@google.com>
> > > > >
> > > > > Syzbot reported two new paths to hit an internal WARNING using th=
e
> > > > > new virtio gso type VIRTIO_NET_HDR_GSO_UDP_L4.
> > > > >
> > > > >     RIP: 0010:skb_checksum_help+0x4a2/0x600 net/core/dev.c:3260
> > > > >     skb len=3D64521 gso_size=3D344
> > > > > and
> > > > >
> > > > >     RIP: 0010:skb_warn_bad_offload+0x118/0x240 net/core/dev.c:326=
2
> > > > >
> > > > > Older virtio types have historically had loose restrictions, lead=
ing
> > > > > to many entirely impractical fuzzer generated packets causing
> > > > > problems deep in the kernel stack. Ideally, we would have had str=
ict
> > > > > validation for all types from the start.
> > > > >
> > > > > New virtio types can have tighter validation. Limit UDP GSO packe=
ts
> > > > > inserted via virtio to the same limits imposed by the UDP_SEGMENT
> > > > > socket interface:
> > > > >
> > > > > 1. must use checksum offload
> > > > > 2. checksum offload matches UDP header
> > > > > 3. no more segments than UDP_MAX_SEGMENTS
> > > > > 4. UDP GSO does not take modifier flags, notably SKB_GSO_TCP_ECN
> > > > >
> > > > > Fixes: 860b7f27b8f7 ("linux/virtio_net.h: Support USO offload in =
vnet header.")
> > > > > Reported-by: syzbot+01cdbc31e9c0ae9b33ac@syzkaller.appspotmail.co=
m
> > > > > Closes: https://lore.kernel.org/netdev/0000000000005039270605eb0b=
7f@google.com/
> > > > > Reported-by: syzbot+c99d835ff081ca30f986@syzkaller.appspotmail.co=
m
> > > > > Closes: https://lore.kernel.org/netdev/0000000000005426680605eb0b=
9f@google.com/
> > > > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > ---
> > > > >  include/linux/virtio_net.h | 19 ++++++++++++++++---
> > > > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_ne=
t.h
> > > > > index 7b4dd69555e49..27cc1d4643219 100644
> > > > > --- a/include/linux/virtio_net.h
> > > > > +++ b/include/linux/virtio_net.h
> > > > > @@ -3,8 +3,8 @@
> > > > >  #define _LINUX_VIRTIO_NET_H
> > > > >
> > > > >  #include <linux/if_vlan.h>
> > > > > +#include <linux/udp.h>
> > > > >  #include <uapi/linux/tcp.h>
> > > > > -#include <uapi/linux/udp.h>
> > > > >  #include <uapi/linux/virtio_net.h>
> > > > >
> > > > >  static inline bool virtio_net_hdr_match_proto(__be16 protocol, _=
_u8 gso_type)
> > > > > @@ -151,9 +151,22 @@ static inline int virtio_net_hdr_to_skb(stru=
ct sk_buff *skb,
> > > > >                 unsigned int nh_off =3D p_off;
> > > > >                 struct skb_shared_info *shinfo =3D skb_shinfo(skb=
);
> > > > >
> > > > > -               /* UFO may not include transport header in gso_si=
ze. */
> > > > > -               if (gso_type & SKB_GSO_UDP)
> > > > > +               switch (gso_type & ~SKB_GSO_TCP_ECN) {
> > > > > +               case SKB_GSO_UDP:
> > > > > +                       /* UFO may not include transport header i=
n gso_size. */
> > > > >                         nh_off -=3D thlen;
> > > > > +                       break;
> > > > > +               case SKB_GSO_UDP_L4:
> > > > > +                       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS=
_CSUM))
> > > > > +                               return -EINVAL;
> > > > > +                       if (skb->csum_offset !=3D offsetof(struct=
 udphdr, check))
> > > > > +                               return -EINVAL;
> > > > > +                       if (skb->len - p_off > gso_size * UDP_MAX=
_SEGMENTS)
> > > > > +                               return -EINVAL;
> > > >
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > > But a question comes into my mind: whether the udp max segments sho=
uld
> > > > be part of the virtio ABI or not.
> > >
> > > Implicitly it is part of the ABI, but so are other sensible
> > > limitations, such as MAX_SKB_FRAGS.
> >
> > There's no easy to detect things like MAX_SKB_FRAGS or anything I miss
> > here? For example, guests can send a packet with s/g more than
> > MAX_SKB_FRAGS, TUN can arrange the skb allocation to make sure it
> > doesn't exceed the limitation. This is not the case for
> > UDP_MAX_SEGMENTS.
>
> Perhaps MAX_SKB_FRAGS is not the best example. But there are other
> conditions that are discoverable by validation returning an error when
> outside the bounds of normal operation.
>
> UDP_MAX_SEGMENTS is also not explicitly exposed to UDP_SEGMENT socket
> users, without issues.
>
> If absolutely needed, the boundary can be detected through probing.

See above, probing can only be done during driver probe.

> But it should not be needed as chosen to be well outside normal
> operating range.
>
> A secondary benefit is that future kernels can relax (but not tighten)
> the restriction if needed. The current limit was chosen with the usual
> 64KB / 1500B operating default in mind. If we would extend BIGTCP to
> UDP, the existing limit of 64 might need relaxing (for both virtio and
> sockets simultaneously). Anything ABI is set in stone, best to avoid
> if not strictly necessary.

The main concern is the migration, if we migrate from a Linux
hypervisor to another. Guests notice the difference in the limitation.

Thanks

>


