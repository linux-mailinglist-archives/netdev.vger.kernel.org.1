Return-Path: <netdev+bounces-17391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599C875168F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA3C1C21027
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E42080A;
	Thu, 13 Jul 2023 02:57:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1310D7C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:57:29 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6531210A
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:57:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso438150e87.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689217041; x=1691809041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcUmUBG+buBnUUKxuWUBu0zne1uUM8qt3ZmnplNd4A0=;
        b=Y9DJJuADk71eDXSadrloLIiCwbXwFq8kNypgpNrRju8dSohFo5Q2QT0ycfwAVeEi6Z
         EsZpLzUm6hqJ3/+RD3KCEle4WDsUwsdzmXQ95Zpqf7WAf2Fck6khwamv5FB8iOzUdV0+
         NQoDR0YmxBLKUJD360IuxaXZVju52JtbKkRPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689217041; x=1691809041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcUmUBG+buBnUUKxuWUBu0zne1uUM8qt3ZmnplNd4A0=;
        b=MUqT8OIvAGSoc6FiujHA0C7xVyz52945lI2+ei8BW+ed+/uTw7jf91pjEMpusu0lPr
         WOCmtPGo23E+jLiXhEbwKj3b3PHqfwxUUfMuN2iYE0NIS4/b7xCM8IsbdzhSS4j1tZOz
         gzRkha3I0MGdm8EA4xMRp5SFFoPWV+qFvqqCVXDo4Ew0k9UZ0tfseX2jIi5HpsWOYR9v
         cBfqGD4kIFFGRvhokiQHo+HK1igzIxR0bY13XJfutbzN2JKzmhnSlAeuKOY7gCZAmYjh
         tcv+YSpeTtc6WY9Q21IGy7qvBp+SnXXWcLAqqSiPTs3aICPmSAEfO44LPx7sCTO6d/Is
         UamA==
X-Gm-Message-State: ABy/qLZTYPdjyZ7o6LTog0Tfd82mbXdUGBjf9anb97FmfMqlACpDM/tx
	MUZzWCf7URONCnnEkAAVvx7Cm3ZXtW7NJSJJ8qBPdg==
X-Google-Smtp-Source: APBJJlE+O7SBAT8v1uNDMsel9LXU+DtkEW7eASpe1Wa9Bu9QxDrdmQ7vy+KRfijZhAcIeSitIctrjmWQkiP4MSaT9wE=
X-Received: by 2002:a05:6512:2315:b0:4f8:5cde:a44f with SMTP id
 o21-20020a056512231500b004f85cdea44fmr127793lfu.10.1689217040774; Wed, 12 Jul
 2023 19:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZK9ZiNMsJX8+1F3N@debian.debian> <CAF=yD-Lb2k02TLaCQHwFSG=eQrWCnvqHVaWuK2viGqiCdwAxwg@mail.gmail.com>
In-Reply-To: <CAF=yD-Lb2k02TLaCQHwFSG=eQrWCnvqHVaWuK2viGqiCdwAxwg@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 12 Jul 2023 21:57:09 -0500
Message-ID: <CAO3-PboOR43DM=dYQH+12_5QZuNySFwvd3GfKmDz_FN6U7UH_w@mail.gmail.com>
Subject: Re: [PATCH net] gso: fix GSO_DODGY bit handling for related protocols
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, kernel-team@cloudflare.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Andrew Melnychenko <andrew@daynix.com>, 
	Jason Wang <jasowang@redhat.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 9:02=E2=80=AFPM Willem de Bruijn
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
It's my OCD of wanting to avoid a cover letter for two patches...
Let's address just this UDP issue then this time. The removal of DODGY
is in fact more suitable as RFC for small improvements.

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
if we move the dodgy handling into __udp_gso_segment then it does not
need to move below this line.

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
>
Good call, that's indeed better. Thanks

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



--=20

Yan

