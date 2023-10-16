Return-Path: <netdev+bounces-41507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4247CB281
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B20C1C2094A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6D5339A7;
	Mon, 16 Oct 2023 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Fxh3OEPp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667F31A70
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:27:21 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D07BE8
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:27:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so8144893a12.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697480837; x=1698085637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kb9SubRaEoUIylL4DNY5Xv/ATtzdMT7B3T3lbsOCFSw=;
        b=Fxh3OEPpVrhXN/xHJQ6g07KTtmFfijds/o6sb6nz/xErJWTBQ26ILQE7zBfs7SK9zV
         /VFvha3f9h6fLbWHC7eXcIm9m0YbA3NseM6tKfb+2H1zjio5aBkCom6TbwzBOvdRPTuk
         ST/xrK2i+fiNk9DSi+MEU+Unvxr8V9pUqrzxLvIxjO2Ktr5dtxUaizw8roKgCWghVjq9
         YwGcH0sXO2QjGLxcTEpXTknx2ikwV5yux1PbGc9LhExfu9zS9VU/RyGFr8D9myVtrEMb
         Q19hb8aNM37zIQT6Av4cSSZlU6yZyMkDbWOB18bu6vNHCZwCEKtNg4WjHC18Pktb8x29
         CErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480837; x=1698085637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kb9SubRaEoUIylL4DNY5Xv/ATtzdMT7B3T3lbsOCFSw=;
        b=f8W8bUNwSlJON/RbXX96c4XvauM0D3InxbfLgdqJ1jLCo9T82jucZe+T7UsXVEYU+W
         q0hmpaAeOQHjYXnubBwek60tNsM9lPXKljk5v39pZTxGz9dpq7nGdfbiMjaZb38Ni0U+
         lpWgEQhWlP5c39my5fTXyeOpTsMxJ0jJ/Ar3f2HzpCgizWfyATJASuKtK6XbsHI9JonD
         H/Mjtbnly4aVs9tGEXaj3jZefZkbPn/7rxf7b/58aPKFKj7WAZnAbcbPOzT6uymaGet1
         rDhh9kCrlcY/D6LPIJqK1NGDscZjwicKS2Knj9xk96gQckaZf09JdYPBKc1izpfja1py
         2x+w==
X-Gm-Message-State: AOJu0YwQe5nFVnMeeU3qps1k8PjRSdmxYH+s8c3QphB2ShY4wglxD6jF
	AQY/lSbC3p/4omC74qUvDxxN6y/pRC8XF+coSdMzidSIqMj+XoJltRmxxw==
X-Google-Smtp-Source: AGHT+IEQdYe/xZgPwgaTIyxFlobq2ZBO2NiSQKBCo2frWb0kJdJPZWrx8DCkc8xcZgoUSinrqhgQ9BPCNACc81tkAuo=
X-Received: by 2002:a05:6402:51d4:b0:53d:eca8:8775 with SMTP id
 r20-20020a05640251d400b0053deca88775mr34017edd.26.1697480837407; Mon, 16 Oct
 2023 11:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZS1/qtr0dZJ35VII@debian.debian>
In-Reply-To: <ZS1/qtr0dZJ35VII@debian.debian>
From: Yan Zhai <yan@cloudflare.com>
Date: Mon, 16 Oct 2023 13:27:06 -0500
Message-ID: <CAO3-PboE=a_Z03bo10nmgdm3aHstxA_t4rtpAGekFzQAM+JOyA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] ipv6: avoid atomic fragment on GSO packets
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 1:23=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> GSO packets can contain a trailing segment that is smaller than
> gso_size. When examining the dst MTU for such packet, if its gso_size is
> too large, then all segments would be fragmented. However, there is a
> good chance the trailing segment has smaller actual size than both
> gso_size as well as the MTU, which leads to an "atomic fragment". It is
> considered harmful in RFC-8021. An Existing report from APNIC also shows
> that atomic fragments are more likely to be dropped even it is
> equivalent to a no-op [1].
>
> Refactor __ip6_finish_output code to separate GSO and non-GSO packet
> processing. It mirrors __ip_finish_output logic now. Add an extra check
> in GSO handling to avoid atomic fragments. Lastly, drop dst_allfrag
> check, which is no longer true since commit 9d289715eb5c ("ipv6: stop
> sending PTB packets for MTU < 1280").
>
> Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]
> Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 proc=
essing")
> Suggested-by: Florian Westphal <fw@strlen.de>
> Reported-by: David Wragg <dwragg@cloudflare.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
Forgot to add v1 thread:
https://lore.kernel.org/lkml/20231002171146.GB9274@breakpoint.cc/. It
was wrongly implemented though without considering max_frag_size for
non-GSO packets though, so not really useful in fact.

>  net/ipv6/ip6_output.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index a471c7e91761..1de6f3c11655 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -162,7 +162,14 @@ ip6_finish_output_gso_slowpath_drop(struct net *net,=
 struct sock *sk,
>                 int err;
>
>                 skb_mark_not_on_list(segs);
> -               err =3D ip6_fragment(net, sk, segs, ip6_finish_output2);
> +               /* Last gso segment might be smaller than actual MTU. Add=
ing
> +                * a fragment header to it would produce an "atomic fragm=
ent",
> +                * which is considered harmful (RFC-8021)
> +                */
> +               err =3D segs->len > mtu ?
> +                       ip6_fragment(net, sk, segs, ip6_finish_output2) :
> +                       ip6_finish_output2(net, sk, segs);
> +
>                 if (err && ret =3D=3D 0)
>                         ret =3D err;
>         }
> @@ -170,10 +177,19 @@ ip6_finish_output_gso_slowpath_drop(struct net *net=
, struct sock *sk,
>         return ret;
>  }
>
> +static int ip6_finish_output_gso(struct net *net, struct sock *sk,
> +                                struct sk_buff *skb, unsigned int mtu)
> +{
> +       if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
> +           !skb_gso_validate_network_len(skb, mtu))
> +               return ip6_finish_output_gso_slowpath_drop(net, sk, skb, =
mtu);
> +
> +       return ip6_finish_output2(net, sk, skb);
> +}
> +
>  static int __ip6_finish_output(struct net *net, struct sock *sk, struct =
sk_buff *skb)
>  {
>         unsigned int mtu;
> -
>  #if defined(CONFIG_NETFILTER) && defined(CONFIG_XFRM)
>         /* Policy lookup after SNAT yielded a new policy */
>         if (skb_dst(skb)->xfrm) {
> @@ -183,17 +199,14 @@ static int __ip6_finish_output(struct net *net, str=
uct sock *sk, struct sk_buff
>  #endif
>
>         mtu =3D ip6_skb_dst_mtu(skb);
> -       if (skb_is_gso(skb) &&
> -           !(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
> -           !skb_gso_validate_network_len(skb, mtu))
> -               return ip6_finish_output_gso_slowpath_drop(net, sk, skb, =
mtu);
> +       if (skb_is_gso(skb))
> +               return ip6_finish_output_gso(net, sk, skb, mtu);
>
> -       if ((skb->len > mtu && !skb_is_gso(skb)) ||
> -           dst_allfrag(skb_dst(skb)) ||
> +       if (skb->len > mtu ||
>             (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max=
_size))
>                 return ip6_fragment(net, sk, skb, ip6_finish_output2);
> -       else
> -               return ip6_finish_output2(net, sk, skb);
> +
> +       return ip6_finish_output2(net, sk, skb);
>  }
>
>  static int ip6_finish_output(struct net *net, struct sock *sk, struct sk=
_buff *skb)
> --
> 2.30.2
>

