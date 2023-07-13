Return-Path: <netdev+bounces-17445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32863751993
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5491A1C212AA
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815C610E;
	Thu, 13 Jul 2023 07:13:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F8806
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:13:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F103526A2
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689232310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rbQFF4yS3GMxwkk3pn6/zA31jQ3tbZhDFGj76ueuJQ=;
	b=Z9KNQeDeAj9EzQhjBZY7aVFUEfk/8tK61AZfgFxBeTxbQbL1MD35H7GHBUdjZYtcyR1cEK
	OoU0SVidy3N+uA4KeCTmFLz1JMR/vPDWj+s9+OeRVQ9TbMfLtDVYeCX/gdSLjtP1G9p1q0
	AKDvCFcNX8Y+usJpVismbiv5+TWGuvA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-jyvhHIVMOOmxYHFMZxxb7w-1; Thu, 13 Jul 2023 03:11:49 -0400
X-MC-Unique: jyvhHIVMOOmxYHFMZxxb7w-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40234d83032so787251cf.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689232308; x=1689837108;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rbQFF4yS3GMxwkk3pn6/zA31jQ3tbZhDFGj76ueuJQ=;
        b=aAmCi1mFgHbw2gdHop35oAXMyG7/+q0HBfkUEGzdqEsEXS5r5nP4BcWVT37JxeVCOw
         4QDNXj15efkgKC5HSNS4Xo+vORZl3wz3KpqpbNqdYqbyUtzVDJXaVFvjpBc9MPU1gfIn
         4o0t766FxFbC7fRdBmXKxdGOtA1NNXlOHZupsMDiIzMOG/iTX6v929F9jqR6cFhkAHTU
         fdLJZ6x3Cszl7NcpbSdVlYW5uHAhHiOxwILbHokkZwMa6wQOS55caS4j2J3Z/A8Kga8l
         e0LumRJxKOF8BITTDPYbAlAJHI35oiwxA23OBu3QnTDw3FBp+2Ea/CoogjaA4S9sOxr5
         c0cQ==
X-Gm-Message-State: ABy/qLY5WI5uyi+rTN0e8Pp4dpu7aOBNFkgK9N2n8AmJvMrDCSiD+7Mu
	C8mfH78PMc4apsNvofcxKYgo8qZkhytW+di91ByU0hZPAWqhctOZ9/WVyaUecUplaAs7brvZYPW
	6piQE7ndXzJTVT7RD
X-Received: by 2002:a05:622a:453:b0:3ff:2a6b:5a76 with SMTP id o19-20020a05622a045300b003ff2a6b5a76mr1023104qtx.5.1689232308747;
        Thu, 13 Jul 2023 00:11:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlErYDj2t9Gqn1bkKhZr8rKPzq+adKKENgLpBmad1q5vqdriwgXadx8H4HdDp5pMraZmaEQwbQ==
X-Received: by 2002:a05:622a:453:b0:3ff:2a6b:5a76 with SMTP id o19-20020a05622a045300b003ff2a6b5a76mr1023080qtx.5.1689232308424;
        Thu, 13 Jul 2023 00:11:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id c7-20020ae9e207000000b00767cfb1e859sm2693833qkc.47.2023.07.13.00.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 00:11:48 -0700 (PDT)
Message-ID: <31b64f509a9b4b8badf8925dddff4269ad572d39.camel@redhat.com>
Subject: Re: [PATCH net] gso: fix GSO_DODGY bit handling for related
 protocols
From: Paolo Abeni <pabeni@redhat.com>
To: Yan Zhai <yan@cloudflare.com>, Jason Wang <jasowang@redhat.com>
Cc: "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, 
 kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>,  Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Herbert Xu
 <herbert@gondor.apana.org.au>,  Andrew Melnychenko <andrew@daynix.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,  open list
 <linux-kernel@vger.kernel.org>, "open list:SCTP PROTOCOL"
 <linux-sctp@vger.kernel.org>
Date: Thu, 13 Jul 2023 09:11:44 +0200
In-Reply-To: <CAO3-PboQ1WL4wu+znnrF4kEdNnx42xPNJ_+Oc88bEejW2J-A+Q@mail.gmail.com>
References: <ZK9ZiNMsJX8+1F3N@debian.debian>
	 <CACGkMEsy+dFK+BnTg_9K59VX-PzHW_fpwY3SRpUxg-MRyD5HWA@mail.gmail.com>
	 <CAO3-PboQ1WL4wu+znnrF4kEdNnx42xPNJ_+Oc88bEejW2J-A+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-12 at 21:58 -0500, Yan Zhai wrote:
> On Wed, Jul 12, 2023 at 9:11=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >=20
> > On Thu, Jul 13, 2023 at 9:55=E2=80=AFAM Yan Zhai <yan@cloudflare.com> w=
rote:
> > >=20
> > > SKB_GSO_DODGY bit indicates a GSO packet comes from an untrusted sour=
ce.
> > > The canonical way is to recompute the gso_segs to avoid device driver
> > > issues. Afterwards, the DODGY bit can be removed to avoid re-check at=
 the
> > > egress of later devices, e.g. packets can egress to a vlan device bac=
ked
> > > by a real NIC.
> > >=20
> > > Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> > > packets.") checks DODGY bit for UDP, but for packets that can be fed
> > > directly to the device after gso_segs reset, it actually falls throug=
h
> > > to fragmentation [1].
> > >=20
> > > Commit 90017accff61 ("sctp: Add GSO support") and commit 3820c3f3e417
> > > ("[TCP]: Reset gso_segs if packet is dodgy") both didn't remove the D=
ODGY
> > > bit after recomputing gso_segs.
> >=20
> > If we try to fix two issues, we'd better use separate patches.
> >=20
> > >=20
> > > This change fixes the GSO_UDP_L4 handling case, and remove the DODGY =
bit
> > > at other places.
> > >=20
> > > Fixes: 90017accff61 ("sctp: Add GSO support")
> > > Fixes: 3820c3f3e417 ("[TCP]: Reset gso_segs if packet is dodgy")
> > > Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 pa=
ckets.")
> > > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > >=20
> > > ---
> > > [1]:
> > > https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaD=
o28KzYDg+A@mail.gmail.com/
> > >=20
> > > ---
> > >  net/ipv4/tcp_offload.c |  1 +
> > >  net/ipv4/udp_offload.c | 19 +++++++++++++++----
> > >  net/ipv6/udp_offload.c | 19 +++++++++++++++----
> > >  net/sctp/offload.c     |  2 ++
> > >  4 files changed, 33 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > > index 8311c38267b5..f9b93708c22e 100644
> > > --- a/net/ipv4/tcp_offload.c
> > > +++ b/net/ipv4/tcp_offload.c
> > > @@ -87,6 +87,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb=
,
> > >                 /* Packet is from an untrusted source, reset gso_segs=
. */
> > >=20
> > >                 skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(skb->len, =
mss);
> > > +               skb_shinfo(skb)->gso_type &=3D ~SKB_GSO_DODGY;
> > >=20
> > >                 segs =3D NULL;
> > >                 goto out;
> > > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > > index 75aa4de5b731..bd29cf19bb6b 100644
> > > --- a/net/ipv4/udp_offload.c
> > > +++ b/net/ipv4/udp_offload.c
> > > @@ -388,11 +388,22 @@ static struct sk_buff *udp4_ufo_fragment(struct=
 sk_buff *skb,
> > >         if (!pskb_may_pull(skb, sizeof(struct udphdr)))
> > >                 goto out;
> > >=20
> > > -       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> > > -           !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
> > > -               return __udp_gso_segment(skb, features, false);
> > > -
> > >         mss =3D skb_shinfo(skb)->gso_size;
> > > +
> > > +       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> > > +               if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
> > > +                       /* Packet is from an untrusted source, reset =
actual gso_segs */
> > > +                       skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(sk=
b->len - sizeof(*uh),
> > > +                                                                mss)=
;
> > > +                       skb_shinfo(skb)->gso_type &=3D ~SKB_GSO_DODGY=
;
> > > +
> > > +                       segs =3D NULL;
> > > +                       goto out;
> > > +               } else {
> > > +                       return __udp_gso_segment(skb, features, false=
);
> >=20
> > I think it's better and cleaner to move those changes in
> > __udp_gso_segment() as Willem suggests.
> >=20
> > > +               }
> > > +       }
> > > +
> > >         if (unlikely(skb->len <=3D mss))
> > >                 goto out;
> > >=20
> > > diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> > > index ad3b8726873e..6857d9f7bd06 100644
> > > --- a/net/ipv6/udp_offload.c
> > > +++ b/net/ipv6/udp_offload.c
> > > @@ -43,11 +43,22 @@ static struct sk_buff *udp6_ufo_fragment(struct s=
k_buff *skb,
> > >                 if (!pskb_may_pull(skb, sizeof(struct udphdr)))
> > >                         goto out;
> > >=20
> > > -               if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> > > -                   !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
> > > -                       return __udp_gso_segment(skb, features, true)=
;
> > > -
> > >                 mss =3D skb_shinfo(skb)->gso_size;
> > > +
> > > +               if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> > > +                       if (skb_gso_ok(skb, features | NETIF_F_GSO_RO=
BUST)) {
> > > +                               /* Packet is from an untrusted source=
, reset actual gso_segs */
> > > +                               skb_shinfo(skb)->gso_segs =3D DIV_ROU=
ND_UP(skb->len - sizeof(*uh),
> > > +                                                                    =
    mss);
> > > +                               skb_shinfo(skb)->gso_type &=3D ~SKB_G=
SO_DODGY;
> >=20
> > Any reason you want to remove the DODGY here? Is this an optimization?
> > We will lose the chance to recognize/validate it elsewhere.
> >=20
> It is intended as a small optimization. And this is in fact the piece
> I am not fully confident about: after validating the gso_segs at a
> trusted location (i.e. assuming the kernel is the trusted computing
> base), do we need to validate it somewhere else? For example, in our
> scenario, we have a tun/tap device in a net namespace, so the packet
> going out will enter from the tap, get forwarded through an veth, and
> then a vlan backed by a real ethernet interface. If the bit is carried
> over, then at each egress of these devices, we need to enter the GSO
> code, which feels pretty redundant as long as the packet does not
> leave kernel space. WDYT?

As an optimization, I think it should land on a different (net-next)
patch. Additionally I think it should be possible to get a greater gain
adding the  ROBUST feature to virtual devices (but I'm not sure if
syzkaller will be able to use that in nasty ways).

Cheers,

Paolo


