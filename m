Return-Path: <netdev+bounces-17392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F015751692
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF4C281CF9
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF370A5D;
	Thu, 13 Jul 2023 02:58:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C780A
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:58:39 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE9A1BD4
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:58:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so348386f8f.3
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689217116; x=1691809116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IecoBnL3XyIII1YUKthdlwZVWgMfN+WSwTXEvMXpAAc=;
        b=bLR9ff/iU7Qh+jYE5Hn0f3gU2ARjNAMtUeyivM+ysA2pnw47A422RZCp0PF5iVK3HY
         G8/1qL75M5iMrTsnguDtEph+B5emY4Jkw0NU9RQCPy1XixnI0qlo58yx352pmzdGbshz
         kWEzy2c/1gjGeYvjAvlFu8SVweO8HUAtitkjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689217116; x=1691809116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IecoBnL3XyIII1YUKthdlwZVWgMfN+WSwTXEvMXpAAc=;
        b=WtZBYfepZL9hCZKXjStHDvTMwulZZCZQhuJ0Jyv2citBQzjwSufi78GOvmz/Iqddq8
         jgaZWDCu0RGMuOQPsi+6EVybmmG/aTz2FnPFd5Rv9mNdo4Zv8nMxegnkT02bb6fd/N8j
         mj2mKcd8Ecz+lOY1RtWODLDTQdOJVwIDcNl2Lx1FjblUBTAipRvcoZP+vgWp5K4hXc2N
         4gJbay34Hht8PjnrVyvmvpgHppVdnXZknBYExypZJd9VGi0balZhuD4lyYpSKPOl+BJa
         v/UgD3P3h9ZWi8HMCXIuBnn+nwSdXyEV3UT2UVsw4xaUOi+uOEwOuOxR/mWJw+BfZwIg
         PmoA==
X-Gm-Message-State: ABy/qLajcax4zk9V3CxcwErVb07NfyI4+uDHoCsyUzs5a3QXR8djM0MP
	2LVpOGd1vbclo9mhZ458XfMxTsX3b09vC9vqLnKgWdKYd9ioLpiv9Sph+Q==
X-Google-Smtp-Source: APBJJlGVhS6tKsbr3XIES5awjUbaNGuOx7Qq542j4rQlwD5LnuxNB+cbv0XEii9+a7gRE4k1BZmvKCEvi4y3QQ/+xs0=
X-Received: by 2002:adf:eeca:0:b0:314:183f:7ac0 with SMTP id
 a10-20020adfeeca000000b00314183f7ac0mr204705wrp.43.1689217115974; Wed, 12 Jul
 2023 19:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZK9ZiNMsJX8+1F3N@debian.debian> <CACGkMEsy+dFK+BnTg_9K59VX-PzHW_fpwY3SRpUxg-MRyD5HWA@mail.gmail.com>
In-Reply-To: <CACGkMEsy+dFK+BnTg_9K59VX-PzHW_fpwY3SRpUxg-MRyD5HWA@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 12 Jul 2023 21:58:25 -0500
Message-ID: <CAO3-PboQ1WL4wu+znnrF4kEdNnx42xPNJ_+Oc88bEejW2J-A+Q@mail.gmail.com>
Subject: Re: [PATCH net] gso: fix GSO_DODGY bit handling for related protocols
To: Jason Wang <jasowang@redhat.com>
Cc: "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, kernel-team@cloudflare.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Andrew Melnychenko <andrew@daynix.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 9:11=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jul 13, 2023 at 9:55=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wro=
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
>
> If we try to fix two issues, we'd better use separate patches.
>
> >
> > This change fixes the GSO_UDP_L4 handling case, and remove the DODGY bi=
t
> > at other places.
> >
> > Fixes: 90017accff61 ("sctp: Add GSO support")
> > Fixes: 3820c3f3e417 ("[TCP]: Reset gso_segs if packet is dodgy")
> > Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 pack=
ets.")
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
>
> I think it's better and cleaner to move those changes in
> __udp_gso_segment() as Willem suggests.
>
> > +               }
> > +       }
> > +
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
>
> Any reason you want to remove the DODGY here? Is this an optimization?
> We will lose the chance to recognize/validate it elsewhere.
>
It is intended as a small optimization. And this is in fact the piece
I am not fully confident about: after validating the gso_segs at a
trusted location (i.e. assuming the kernel is the trusted computing
base), do we need to validate it somewhere else? For example, in our
scenario, we have a tun/tap device in a net namespace, so the packet
going out will enter from the tap, get forwarded through an veth, and
then a vlan backed by a real ethernet interface. If the bit is carried
over, then at each egress of these devices, we need to enter the GSO
code, which feels pretty redundant as long as the packet does not
leave kernel space. WDYT?

thanks


> Thanks
>
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


--=20

Yan

