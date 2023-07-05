Return-Path: <netdev+bounces-15493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD8274803B
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 10:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7AA280EA0
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA8B46B2;
	Wed,  5 Jul 2023 08:57:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0720F4
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 08:57:17 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B4D10B
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 01:57:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4036bd4fff1so432241cf.0
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 01:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688547436; x=1691139436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp1JaNROGMiqtrVvfAjF4PZ66CSABEdn31I8mZwqrho=;
        b=0/UYE2VFtuAvPsGHbA2+W55CWcL8wiNe2mbSU2jGBWsCI9sdtbNI0Ugp3iyUAcPdNh
         ELTnPpVFkPPD3UVSX5srHdwbwMTwR/kknXGkEN2R8F8h6Fj6B+hB31rvrruUw2+F1tuX
         aUiBqo6TIJQQ+5OxW+esCmNSzL8yMRNlpm80CN0UB2vYbXKESImWS7xEoYUh7V5H0hEE
         qKYAicmjgPsjMsbmrTaa7xLj0atP1FrssReq5x4K/rYfMVwTPuJMQh5qiLWKkER3DrFW
         QiGUrM120AzuNQ0rsubII2gcNWBK82eTYoCi/d1JyonBZOTj+6xtmaZz9IHE9k2kVo7d
         UBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688547436; x=1691139436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bp1JaNROGMiqtrVvfAjF4PZ66CSABEdn31I8mZwqrho=;
        b=LVz9/B0/C4oNWdjKqt1i1iz5bir1gJfiWhhb6lNjqRIPVqmxvCXfF9IbCrIDDOVxcB
         1IlHlHhtwbWILamW1j5O5XwLKYXILB0uqmhWkYdHbf+tHWRtzYZd3RK+2H7dx9m1TldJ
         ppnjudNUPl9ZLjOrXHwTsA2AR1MiVFXwW2LXy8GX4QozxxX12fi85QNcMS1m3wjx9ehc
         G+Jt1MIO5KeLLB+WWMREbvz9ok2S8Wm7i5lKVFPMJsv+6hP2Jijg9tsyh+BhjhM9++ZZ
         yaDVGlYOMGouhH/WEN1kjZ6kMSyRyvbaGiowoBSwQ7Mj7yclL1iIDEMfIdnFwgKpbM3j
         QMiQ==
X-Gm-Message-State: ABy/qLY+Uy/xN1DRCygfuFc53JU93lFnpxIaihsT+Ne9y1Z6CgI/tFCF
	dwCQFBqnxTI0HnfVA9mSmebI4baFw5IpKb5wFJcQQg==
X-Google-Smtp-Source: APBJJlEvBAggtMJYJHiAcNjne3FO7iYpJqHzZwaaiuA9yStfaaKc0l+ZHe5d5gbmJ4SX/DJc0LA0sv34Mqyqz/fnsF4=
X-Received: by 2002:ac8:7f16:0:b0:3ef:302c:319e with SMTP id
 f22-20020ac87f16000000b003ef302c319emr92207qtk.8.1688547435734; Wed, 05 Jul
 2023 01:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630153759.3349299-1-maze@google.com> <ZKNtndEkrzhtmqkF@gondor.apana.org.au>
In-Reply-To: <ZKNtndEkrzhtmqkF@gondor.apana.org.au>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 5 Jul 2023 10:57:04 +0200
Message-ID: <CANP3RGfFn30C90M01D+-B7VN9GL5sK8LuiAbP=dJURSHt4WTPw@mail.gmail.com>
Subject: Re: [PATCH] xfrm: Silence warnings triggerable by bad packets
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Benedict Wong <benedictwong@google.com>, Lorenzo Colitti <lorenzo@google.com>, 
	Yan Yan <evitayan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 4, 2023 at 2:54=E2=80=AFAM Herbert Xu <herbert@gondor.apana.org=
.au> wrote:
>
> On Fri, Jun 30, 2023 at 08:37:58AM -0700, Maciej =C5=BBenczykowski wrote:
> > Steffan, this isn't of course a patch meant for inclusion, instead just=
 a WARN_ON hit report.
> > The patch is simply what prints the following extra info:
> >
> > xfrm_prepare_input: XFRM_MODE_SKB_CB(skb)->protocol: 17
> > xfrm_inner_mode_encap_remove: x->props.mode: 1 XFRM_MODE_SKB_SB(skb)->p=
rotocol:17
> >
> > (note: XFRM_MODE_TUNNEL=3D1 IPPROTO_UDP=3D17)
>
> Thanks for the report.  This patch should fix the warnings:
>
> ---8<---
> After the elimination of inner modes, a couple of warnings that
> were previously unreachable can now be triggered by malformed
> inbound packets.
>
> Fix this by:
>
> 1. Moving the setting of skb->protocol into the decap functions.
> 2. Returning -EINVAL when unexpected protocol is seen.
>
> Reported-by: Maciej =C5=BBenczykowski<maze@google.com>
> Fixes: 5f24f41e8ea6 ("xfrm: Remove inner/outer modes from input path")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 815b38080401..d5ee96789d4b 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -180,6 +180,8 @@ static int xfrm4_remove_beet_encap(struct xfrm_state =
*x, struct sk_buff *skb)
>         int optlen =3D 0;
>         int err =3D -EINVAL;
>
> +       skb->protocol =3D htons(ETH_P_IP);
> +
>         if (unlikely(XFRM_MODE_SKB_CB(skb)->protocol =3D=3D IPPROTO_BEETP=
H)) {
>                 struct ip_beet_phdr *ph;
>                 int phlen;
> @@ -232,6 +234,8 @@ static int xfrm4_remove_tunnel_encap(struct xfrm_stat=
e *x, struct sk_buff *skb)
>  {
>         int err =3D -EINVAL;
>
> +       skb->protocol =3D htons(ETH_P_IP);
> +
>         if (!pskb_may_pull(skb, sizeof(struct iphdr)))
>                 goto out;
>
> @@ -267,6 +271,8 @@ static int xfrm6_remove_tunnel_encap(struct xfrm_stat=
e *x, struct sk_buff *skb)
>  {
>         int err =3D -EINVAL;
>
> +       skb->protocol =3D htons(ETH_P_IPV6);
> +
>         if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
>                 goto out;
>
> @@ -296,6 +302,8 @@ static int xfrm6_remove_beet_encap(struct xfrm_state =
*x, struct sk_buff *skb)
>         int size =3D sizeof(struct ipv6hdr);
>         int err;
>
> +       skb->protocol =3D htons(ETH_P_IPV6);
> +
>         err =3D skb_cow_head(skb, size + skb->mac_len);
>         if (err)
>                 goto out;
> @@ -346,6 +354,7 @@ xfrm_inner_mode_encap_remove(struct xfrm_state *x,
>                         return xfrm6_remove_tunnel_encap(x, skb);
>                 break;
>                 }
> +               return -EINVAL;
>         }
>
>         WARN_ON_ONCE(1);
> @@ -366,19 +375,6 @@ static int xfrm_prepare_input(struct xfrm_state *x, =
struct sk_buff *skb)
>                 return -EAFNOSUPPORT;
>         }
>
> -       switch (XFRM_MODE_SKB_CB(skb)->protocol) {
> -       case IPPROTO_IPIP:
> -       case IPPROTO_BEETPH:
> -               skb->protocol =3D htons(ETH_P_IP);
> -               break;
> -       case IPPROTO_IPV6:
> -               skb->protocol =3D htons(ETH_P_IPV6);
> -               break;
> -       default:
> -               WARN_ON_ONCE(1);
> -               break;
> -       }
> -
>         return xfrm_inner_mode_encap_remove(x, skb);
>  }

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

