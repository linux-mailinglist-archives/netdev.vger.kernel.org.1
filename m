Return-Path: <netdev+bounces-17363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0035C75160E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB871C21116
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164A8641;
	Thu, 13 Jul 2023 02:11:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002237C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:11:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A181FF0
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689214280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/2697O0WOZzNU0fxI4+rorreaPiwgOivv5WesbBePc=;
	b=SKwcxAxvDpLVvSfTI2RVnLlu5L8bQTVVz7ieSJvP0Rsdd2b3UvLH5X0DVufys582LMXuhp
	IQqlTCt481UCeQNm6Nl0ELmScPndkVKFsDMbnEyDbqteT2Ul/KDmYQUGADIDrj9FDvEdvJ
	Dbsav/H5N6wfxly6VF1hz0pkJVRoHH8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-c9xtxm51Mt-SN7bWpcsYSQ-1; Wed, 12 Jul 2023 22:11:19 -0400
X-MC-Unique: c9xtxm51Mt-SN7bWpcsYSQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-635e91cba88so1889976d6.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689214279; x=1691806279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/2697O0WOZzNU0fxI4+rorreaPiwgOivv5WesbBePc=;
        b=WQkAnRT99qtkKmqno+PIkXUBwKWmATdEv/n7z7IZNkM8yRD/KWxJSTJsNHvksnqfR2
         OEmiA0mEN9cYKxouOzX+C1h2TtO9zIZWtA/IvsRamsQ6vioooPVUW7+dxFQWGbNOKF59
         sJTvI+ur+AdsGYMmldQ5qIRuPoYnTv3yvoFBHRu6KAuJ5iwA9D+2ZOxn1IoS90DduGgT
         otEGGnqgNhntz6GE0Nfyoe62QuHCoa/cKI8HNPFwCTN6hOgCNq7hMua25oyGovTLJCc7
         2VIwpjG/Z7nkvvA7QTduEAegTO/7eQx147GU7i0CWXpqAX7K8lL+bT64UsihEdmsEhFu
         UkCg==
X-Gm-Message-State: ABy/qLaFJXX4MVxnrF3/la+ahHrDC5CNJ/5diS9IABOyhoe2DVhZskL2
	do+mjr6HM/AHfTU70/e4bke4pC/pOxOT5wBd1t715T96IjmdGAlcoiT+fVLrTVAcDol5Sd8+I2c
	NX7A499SULPmJdpjmDSkFf0QALACUiPBq
X-Received: by 2002:a0c:b2c9:0:b0:635:db0c:df78 with SMTP id d9-20020a0cb2c9000000b00635db0cdf78mr339600qvf.3.1689214278890;
        Wed, 12 Jul 2023 19:11:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFFeowjryewkXgJ7D2QuOCleXdwxPIj3A3rUqAeCGlEgdxqsT3EnctVnJJQ6ikOCWxW6yVWqvPGurpBACNxwSo=
X-Received: by 2002:a0c:b2c9:0:b0:635:db0c:df78 with SMTP id
 d9-20020a0cb2c9000000b00635db0cdf78mr339582qvf.3.1689214278617; Wed, 12 Jul
 2023 19:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZK9ZiNMsJX8+1F3N@debian.debian>
In-Reply-To: <ZK9ZiNMsJX8+1F3N@debian.debian>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jul 2023 10:11:06 +0800
Message-ID: <CACGkMEsy+dFK+BnTg_9K59VX-PzHW_fpwY3SRpUxg-MRyD5HWA@mail.gmail.com>
Subject: Re: [PATCH net] gso: fix GSO_DODGY bit handling for related protocols
To: Yan Zhai <yan@cloudflare.com>
Cc: "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, kernel-team@cloudflare.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Andrew Melnychenko <andrew@daynix.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 9:55=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> SKB_GSO_DODGY bit indicates a GSO packet comes from an untrusted source.
> The canonical way is to recompute the gso_segs to avoid device driver
> issues. Afterwards, the DODGY bit can be removed to avoid re-check at the
> egress of later devices, e.g. packets can egress to a vlan device backed
> by a real NIC.
>
> Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> packets.") checks DODGY bit for UDP, but for packets that can be fed
> directly to the device after gso_segs reset, it actually falls through
> to fragmentation [1].
>
> Commit 90017accff61 ("sctp: Add GSO support") and commit 3820c3f3e417
> ("[TCP]: Reset gso_segs if packet is dodgy") both didn't remove the DODGY
> bit after recomputing gso_segs.

If we try to fix two issues, we'd better use separate patches.

>
> This change fixes the GSO_UDP_L4 handling case, and remove the DODGY bit
> at other places.
>
> Fixes: 90017accff61 ("sctp: Add GSO support")
> Fixes: 3820c3f3e417 ("[TCP]: Reset gso_segs if packet is dodgy")
> Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packet=
s.")
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
>
> ---
> [1]:
> https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28K=
zYDg+A@mail.gmail.com/
>
> ---
>  net/ipv4/tcp_offload.c |  1 +
>  net/ipv4/udp_offload.c | 19 +++++++++++++++----
>  net/ipv6/udp_offload.c | 19 +++++++++++++++----
>  net/sctp/offload.c     |  2 ++
>  4 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 8311c38267b5..f9b93708c22e 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -87,6 +87,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
>                 /* Packet is from an untrusted source, reset gso_segs. */
>
>                 skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(skb->len, mss)=
;
> +               skb_shinfo(skb)->gso_type &=3D ~SKB_GSO_DODGY;
>
>                 segs =3D NULL;
>                 goto out;
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 75aa4de5b731..bd29cf19bb6b 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -388,11 +388,22 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_=
buff *skb,
>         if (!pskb_may_pull(skb, sizeof(struct udphdr)))
>                 goto out;
>
> -       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> -           !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
> -               return __udp_gso_segment(skb, features, false);
> -
>         mss =3D skb_shinfo(skb)->gso_size;
> +
> +       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> +               if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
> +                       /* Packet is from an untrusted source, reset actu=
al gso_segs */
> +                       skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(skb->l=
en - sizeof(*uh),
> +                                                                mss);
> +                       skb_shinfo(skb)->gso_type &=3D ~SKB_GSO_DODGY;
> +
> +                       segs =3D NULL;
> +                       goto out;
> +               } else {
> +                       return __udp_gso_segment(skb, features, false);

I think it's better and cleaner to move those changes in
__udp_gso_segment() as Willem suggests.

> +               }
> +       }
> +
>         if (unlikely(skb->len <=3D mss))
>                 goto out;
>
> diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> index ad3b8726873e..6857d9f7bd06 100644
> --- a/net/ipv6/udp_offload.c
> +++ b/net/ipv6/udp_offload.c
> @@ -43,11 +43,22 @@ static struct sk_buff *udp6_ufo_fragment(struct sk_bu=
ff *skb,
>                 if (!pskb_may_pull(skb, sizeof(struct udphdr)))
>                         goto out;
>
> -               if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> -                   !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
> -                       return __udp_gso_segment(skb, features, true);
> -
>                 mss =3D skb_shinfo(skb)->gso_size;
> +
> +               if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> +                       if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST=
)) {
> +                               /* Packet is from an untrusted source, re=
set actual gso_segs */
> +                               skb_shinfo(skb)->gso_segs =3D DIV_ROUND_U=
P(skb->len - sizeof(*uh),
> +                                                                        =
mss);
> +                               skb_shinfo(skb)->gso_type &=3D ~SKB_GSO_D=
ODGY;

Any reason you want to remove the DODGY here? Is this an optimization?
We will lose the chance to recognize/validate it elsewhere.

Thanks

> +
> +                               segs =3D NULL;
> +                               goto out;
> +                       } else {
> +                               return __udp_gso_segment(skb, features, t=
rue);
> +                       }
> +               }
> +
>                 if (unlikely(skb->len <=3D mss))
>                         goto out;
>
> diff --git a/net/sctp/offload.c b/net/sctp/offload.c
> index 502095173d88..3d2b44db0d42 100644
> --- a/net/sctp/offload.c
> +++ b/net/sctp/offload.c
> @@ -65,6 +65,8 @@ static struct sk_buff *sctp_gso_segment(struct sk_buff =
*skb,
>                 skb_walk_frags(skb, frag_iter)
>                         pinfo->gso_segs++;
>
> +               pinfo->gso_type &=3D ~SKB_GSO_DODGY;
> +
>                 segs =3D NULL;
>                 goto out;
>         }
> --
> 2.30.2
>


