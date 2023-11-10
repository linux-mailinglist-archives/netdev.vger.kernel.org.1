Return-Path: <netdev+bounces-47045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C717E7AE0
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF531C20CA2
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A20A125DB;
	Fri, 10 Nov 2023 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLlmWqNx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494512B68
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:31:10 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E877124489
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 01:31:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so24096a12.1
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 01:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699608664; x=1700213464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksKC5N5S1VwyLBs8puatXQ5O6wSMGiBfXyqCMNWeYS0=;
        b=GLlmWqNxmYnB2EqluZiCz+8D0g4pXZpw8oYS4Pu0rDkOkG4mLp7P5dywjCL3MKM8pF
         GNkSz/bI+hDLcu9gkjtcRhFDSezB6SoINxEs5bpMs6i/BuhPG7KiV0iRXWRj//SkXL3R
         U7zazpVKD3PYbMXUgXKcH+w9SSKZR6BW5+z3mIMOFeDmSjMf6qqGP/llZIDnV6HZLqrJ
         1lQfsYZdAkOfLs3qG/17zNkep1NQPWneAP150QFMn52QFDW/21AdwIs5ujKRQZaXzqLv
         1LSG/8uO89HG6EQm09Hnb7UEWCuS9EEkeD7C66JxPy/atUuWNtDUi7cWbNPLa8F/cHL5
         XErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699608664; x=1700213464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksKC5N5S1VwyLBs8puatXQ5O6wSMGiBfXyqCMNWeYS0=;
        b=GCp1QCFL5IuNl7eJYjPpU0IYKxpXmRlcmlEYs9yqA4qs+P6c1HARgQKqGxuMe5bJtr
         djmKi1y09a55wuglUIe7s+la2Z3uH0l+CLwa6noNjEHpXXZQpHSpMcc60KeVsWUU1Pog
         uvKQZTelmzlmroHTfTuvfiGLDsVGeoOAoPDHuBEKB48/l8d7/kgC9Hl6OthdgunP2DDU
         uIhGXi/yWN1SSNJqYMuDsnFCSLeEPuiRg/EcEPl0Mev7mM3ip+vNiabY8r6G+aX182Ic
         GHmfMKUGx8eGx08pLm2vw/18AzIJn0TKL6VMnCwuAbC12NjwPMqk8wj5xZk9m7o7HLBo
         zs9g==
X-Gm-Message-State: AOJu0Yy/me9H65NU8BgzVBALndFtj9fPZfUlf6CaGi1McK2VKJk9G6uF
	Ihd3QBvRwBgdUnSUb2EidQpd/D6q4zTVVWWTBNRsLA==
X-Google-Smtp-Source: AGHT+IGcsfjTyKWdpxswyD/khdOvVcyNQpeNRxwBtmA6S2pZzXcxgaiSZg7dqCQNUa8KOrtv0uaK5Oi+Gtl9Nk9nbpA=
X-Received: by 2002:a05:6402:1484:b0:544:466b:3b20 with SMTP id
 e4-20020a056402148400b00544466b3b20mr299720edv.5.1699608663758; Fri, 10 Nov
 2023 01:31:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZU3EZKQ3dyLE6T8z@debian.debian>
In-Reply-To: <ZU3EZKQ3dyLE6T8z@debian.debian>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Nov 2023 10:30:49 +0100
Message-ID: <CANn89iKZYsWGT1weXZ6W7_z28dqJwTZeg+2_Lw+x+6spUHp8Eg@mail.gmail.com>
Subject: Re: [PATCH net-next] packet: add a generic drop reason for receive
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Weongyo Jeong <weongyo.linux@gmail.com>, 
	Ivan Babrou <ivan@cloudflare.com>, David Ahern <dsahern@kernel.org>, 
	Jesper Brouer <jesper@cloudflare.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 6:49=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
> from consume_skb to kfree_skb to improve error handling. However, this
> could bring a lot of noises when we monitor real packet drops in
> kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
> can be freed, not actual packets.
>
> Adding a generic drop reason to allow distinguish these "clone drops".
>
> [1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_5RU-xcxLFU=
K2Zj08A8MrLk9jzg@mail.gmail.com/
> Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  include/net/dropreason-core.h |  6 ++++++
>  net/packet/af_packet.c        | 16 +++++++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index 845dce805de7..6ff543fe8a8b 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -81,6 +81,7 @@
>         FN(IPV6_NDISC_NS_OTHERHOST)     \
>         FN(QUEUE_PURGE)                 \
>         FN(TC_ERROR)                    \
> +       FN(PACKET_SOCK_ERROR)           \
>         FNe(MAX)
>
>  /**
> @@ -348,6 +349,11 @@ enum skb_drop_reason {
>         SKB_DROP_REASON_QUEUE_PURGE,
>         /** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
>         SKB_DROP_REASON_TC_ERROR,
> +       /**
> +        * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket erro=
rs
> +        * after its filter matches an incoming packet.
> +        */
> +       SKB_DROP_REASON_PACKET_SOCK_ERROR,
>         /**
>          * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>          * shouldn't be used as a real 'reason' - only for tracing code g=
en
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a84e00b5904b..94b8a9d8e038 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2128,6 +2128,7 @@ static int packet_rcv(struct sk_buff *skb, struct n=
et_device *dev,
>         int skb_len =3D skb->len;
>         unsigned int snaplen, res;
>         bool is_drop_n_account =3D false;
> +       enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_NOT_SPECIFIE=
D;
>
>         if (skb->pkt_type =3D=3D PACKET_LOOPBACK)
>                 goto drop;
> @@ -2161,6 +2162,10 @@ static int packet_rcv(struct sk_buff *skb, struct =
net_device *dev,
>         res =3D run_filter(skb, sk, snaplen);
>         if (!res)
>                 goto drop_n_restore;
> +
> +       /* skb will only be "consumed" not "dropped" before this */
> +       drop_reason =3D SKB_DROP_REASON_PACKET_SOCK_ERROR;
> +
>         if (snaplen > res)
>                 snaplen =3D res;
>
> @@ -2230,7 +2235,7 @@ static int packet_rcv(struct sk_buff *skb, struct n=
et_device *dev,
>         if (!is_drop_n_account)
>                 consume_skb(skb);
>         else
> -               kfree_skb(skb);
> +               kfree_skb_reason(skb, drop_reason);
>         return 0;


1) Note that net-next is currently closed.

2) Now we have 0e84afe8ebfb ("net: dropreason: add SKB_CONSUMED reason")

it is time we replace the various constructs which do not help readability:

if (something)
     consume_skb(skb);
else
     kfree_skb_reason(skb, drop_reason);

By:

kfree_skb_reason(skb, drop_reason);

(By using drop_reason =3D=3D SKB_CONSUMED when appropriate)

