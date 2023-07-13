Return-Path: <netdev+bounces-17364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D67F75160F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9A7280F8C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39E5643;
	Thu, 13 Jul 2023 02:11:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C907C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:11:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2A61FFD
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689214316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oXxsxWg+t7sVZM4iHHNTkDMQqCr5a0vdCkiTjkwKBn4=;
	b=DscGZJnc82RKtYG1xkTFHHBHFybzU1WnEj7bSFYrt2gZN2z8Vf2ySICe/s+6NlH2mCJwDX
	PC0dpMtZffnlhyGfGAWRr0lJ1HUiK1HsXiI2eoy1ZgxmqZdTyG73SwQhw2UnmHiNNutE8y
	JOfDVeUq0WFwmScIpcRkGifHoG95LMA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-lzsF5Du9NtOP_OnaiagxPw-1; Wed, 12 Jul 2023 22:11:55 -0400
X-MC-Unique: lzsF5Du9NtOP_OnaiagxPw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635d9e482f1so1890296d6.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689214315; x=1691806315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXxsxWg+t7sVZM4iHHNTkDMQqCr5a0vdCkiTjkwKBn4=;
        b=AtKhDppV4KEKJKsNhoQcX4LHbNZU0W2GsdoVb98F6mvGcmWfRpYF8c8c9JxUREuBre
         gtcCHznY5dPo3MPbCr1CPHJTlN9qjEXxjjBBoGdQ7jjYbXOi/elabni7BhhsGZRHpuM+
         T8MEbriQbVtahZDvbCNifjodcJoHtAAGJtz7Ygoq+ROV2OGNfas7s03ZCqeKxks99adT
         Ho099ywOGb2K5pD+tacIpORiWYT7WXWcPlWDROleZL5844Fz9qdTGDqRUzE2WQSCLJXB
         4RjB5RtuMbNK3GT0H2d6GxFil+x9VqTImePJ08SoF8YcOx59MziCb0+1hN9Sj4c7DWbb
         LmKg==
X-Gm-Message-State: ABy/qLYMB75t4qz2Oa+K1jVMAkUvXm9/HBUG2G4yvOep+AYowhlAPmGQ
	VmN5DS2JOzyHWM+x5RhRK0RcnP4wCo1yuI33xl2ra4KAKpVCJyTDRa3tUt3O9YlbBJmEqNKScFi
	nSsFeDJ4wALN71KfVDp0nWbZhaTxx95Wl
X-Received: by 2002:a0c:cb0c:0:b0:635:e6e0:6814 with SMTP id o12-20020a0ccb0c000000b00635e6e06814mr208272qvk.49.1689214315004;
        Wed, 12 Jul 2023 19:11:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF3q6TcQipag9khNJOPJfQCl9sA8/TRMLm3HD8OjXdTfPL40sDazEi9s0TrA316CiBZdY0c7zSznbWDoQygjpw=
X-Received: by 2002:a0c:cb0c:0:b0:635:e6e0:6814 with SMTP id
 o12-20020a0ccb0c000000b00635e6e06814mr208257qvk.49.1689214314752; Wed, 12 Jul
 2023 19:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZK9ZiNMsJX8+1F3N@debian.debian> <CAF=yD-Lb2k02TLaCQHwFSG=eQrWCnvqHVaWuK2viGqiCdwAxwg@mail.gmail.com>
In-Reply-To: <CAF=yD-Lb2k02TLaCQHwFSG=eQrWCnvqHVaWuK2viGqiCdwAxwg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jul 2023 10:11:43 +0800
Message-ID: <CACGkMEvDmYrxUo5BkAT-HF=UY6RkHVPQpWb-rjpN8aZYAF0zbA@mail.gmail.com>
Subject: Re: [PATCH net] gso: fix GSO_DODGY bit handling for related protocols
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Yan Zhai <yan@cloudflare.com>, 
	"open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, kernel-team@cloudflare.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Andrew Melnychenko <andrew@daynix.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 10:02=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Wed, Jul 12, 2023 at 9:55=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wro=
te:
> >
> > SKB_GSO_DODGY bit indicates a GSO packet comes from an untrusted source=
.
> > The canonical way is to recompute the gso_segs to avoid device driver
> > issues. Afterwards, the DODGY bit can be removed to avoid re-check at t=
he
> > egress of later devices, e.g. packets can egress to a vlan device backe=
d
> > by a real NIC.
> >
> > Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> > packets.") checks DODGY bit for UDP, but for packets that can be fed
> > directly to the device after gso_segs reset, it actually falls through
> > to fragmentation [1].
> >
> > Commit 90017accff61 ("sctp: Add GSO support") and commit 3820c3f3e417
> > ("[TCP]: Reset gso_segs if packet is dodgy") both didn't remove the DOD=
GY
> > bit after recomputing gso_segs.
> >
> > This change fixes the GSO_UDP_L4 handling case, and remove the DODGY bi=
t
> > at other places.
>
> These two things should not be conflated.
>
> Only the USO fix is strictly needed to fix the reported issue.
>
> > Fixes: 90017accff61 ("sctp: Add GSO support")
> > Fixes: 3820c3f3e417 ("[TCP]: Reset gso_segs if packet is dodgy")
> > Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 pack=
ets.")
>
> Link: https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2W=
aDo28KzYDg+A@mail.gmail.com/
>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> >
> > ---
> > [1]:
> > https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo2=
8KzYDg+A@mail.gmail.com/
> >
> > ---
> >  net/ipv4/tcp_offload.c |  1 +
> >  net/ipv4/udp_offload.c | 19 +++++++++++++++----
> >  net/ipv6/udp_offload.c | 19 +++++++++++++++----
> >  net/sctp/offload.c     |  2 ++
> >  4 files changed, 33 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > index 8311c38267b5..f9b93708c22e 100644
> > --- a/net/ipv4/tcp_offload.c
> > +++ b/net/ipv4/tcp_offload.c
> > @@ -87,6 +87,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
> >                 /* Packet is from an untrusted source, reset gso_segs. =
*/
> >
> >                 skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(skb->len, ms=
s);
> > +               skb_shinfo(skb)->gso_type &=3D ~SKB_GSO_DODGY;
> >
> >                 segs =3D NULL;
> >                 goto out;
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index 75aa4de5b731..bd29cf19bb6b 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > @@ -388,11 +388,22 @@ static struct sk_buff *udp4_ufo_fragment(struct s=
k_buff *skb,
> >         if (!pskb_may_pull(skb, sizeof(struct udphdr)))
> >                 goto out;
> >
> > -       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> > -           !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
> > -               return __udp_gso_segment(skb, features, false);
> > -
> >         mss =3D skb_shinfo(skb)->gso_size;
>
> Why move the block below this line?
>
> > +
> > +       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> > +               if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
> > +                       /* Packet is from an untrusted source, reset ac=
tual gso_segs */
> > +                       skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(skb-=
>len - sizeof(*uh),
> > +                                                                mss);
> > +                       skb_shinfo(skb)->gso_type &=3D ~SKB_GSO_DODGY;
> > +
> > +                       segs =3D NULL;
> > +                       goto out;
> > +               } else {
> > +                       return __udp_gso_segment(skb, features, false);
> > +               }
> > +       }
> > +
>
> The validation should take place inside __udp_gso_segment.
>
> Revert the previous patch to always enter that function for USO packets:
>
>        if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
>                 return __udp_gso_segment(skb, features, false);
>
> And in that function decide to return NULL after validation.

+1

Thanks

>
>
> >         if (unlikely(skb->len <=3D mss))
> >                 goto out;
> >
> > diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> > index ad3b8726873e..6857d9f7bd06 100644
> > --- a/net/ipv6/udp_offload.c
> > +++ b/net/ipv6/udp_offload.c
> > @@ -43,11 +43,22 @@ static struct sk_buff *udp6_ufo_fragment(struct sk_=
buff *skb,
> >                 if (!pskb_may_pull(skb, sizeof(struct udphdr)))
> >                         goto out;
> >
> > -               if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> > -                   !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
> > -                       return __udp_gso_segment(skb, features, true);
> > -
> >                 mss =3D skb_shinfo(skb)->gso_size;
> > +
> > +               if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> > +                       if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBU=
ST)) {
> > +                               /* Packet is from an untrusted source, =
reset actual gso_segs */
> > +                               skb_shinfo(skb)->gso_segs =3D DIV_ROUND=
_UP(skb->len - sizeof(*uh),
> > +                                                                      =
  mss);
> > +                               skb_shinfo(skb)->gso_type &=3D ~SKB_GSO=
_DODGY;
> > +
> > +                               segs =3D NULL;
> > +                               goto out;
> > +                       } else {
> > +                               return __udp_gso_segment(skb, features,=
 true);
> > +                       }
> > +               }
> > +
> >                 if (unlikely(skb->len <=3D mss))
> >                         goto out;
> >
> > diff --git a/net/sctp/offload.c b/net/sctp/offload.c
> > index 502095173d88..3d2b44db0d42 100644
> > --- a/net/sctp/offload.c
> > +++ b/net/sctp/offload.c
> > @@ -65,6 +65,8 @@ static struct sk_buff *sctp_gso_segment(struct sk_buf=
f *skb,
> >                 skb_walk_frags(skb, frag_iter)
> >                         pinfo->gso_segs++;
> >
> > +               pinfo->gso_type &=3D ~SKB_GSO_DODGY;
> > +
> >                 segs =3D NULL;
> >                 goto out;
> >         }
> > --
> > 2.30.2
> >
>


