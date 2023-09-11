Return-Path: <netdev+bounces-32920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7979AB23
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 22:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B0B1C2093F
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6847615AE3;
	Mon, 11 Sep 2023 20:00:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E64156DB
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 20:00:35 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09711B8
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:00:33 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1d598ba1b74so1504288fac.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694462432; x=1695067232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWlA00ytPSwsGlmjgSQ+4BijaQIgSEsNrpcvKStotwg=;
        b=Dc8xIPis6iRLyZgEFyOGGZvPRnqHQuCBZrotsmsw/lJIb9O9ZFfLy+S2FnJS0N2JpU
         ZJL5xq1Fqlj7y+5/7sxZ216QbwQvdt8XMNwvzWczntUx9GW89jT5tRFG6MR207wAmy2j
         bv5myk2+xicyTv5q5mqUrQGSVPdOSrgM6gHg5eo+NxMCYH09/KhGHKW9uba+QcXDqSk4
         g0/ePVmzlFlhx/mNWXQfUlafAo9WkhlJmCA1nZAtFDr5AJgwW2VzI1/rSPJchSKMBMS9
         PXHvVLDs/J6LKI0SVgw5LOTrFh0RrvgNxUM84UolNXNJyCSo/8kh+WDJNwk5sI2HmZ7Q
         W8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462432; x=1695067232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWlA00ytPSwsGlmjgSQ+4BijaQIgSEsNrpcvKStotwg=;
        b=m5aOtoNNNcMfLFgdp12gCn0Blhq5Xv3/GPjo8OrxKDQVqwATwhlTKBu6a2EMCZJGas
         mMrJUmeGTage2RkJHyU2am1ejIVjJ+IaU9FklcVrScfdISaJ4eGK/Kn/DIMIZs8vmRCC
         mrzqpP9xl1E1O8rHbsGm8CBTvW3Rnvv2+luyHbK0TFwpB5uug3GnH6sn8LU6MhuF+csn
         jhycFMkOpY5PWtMlOkJXOYGGdfjEBLy0tJUOALrZEE/r4tmcp7OWsfjdfm9CVlrkADNk
         AMNkdXxERSbBZMmKtpScsYcwI4Cfr3lycrGfqORyD/avD5NSodjIx0qUrkMf0b/xFiXO
         +yYw==
X-Gm-Message-State: AOJu0YzTZ3k3El0uJjlVnXMDEME2tY02uYkFpUBlPpoZbNyPGXgAwotL
	bKdev4QZtRWhg7MY64/O1kDQeD7ka1hoDQAG6qfKUQ==
X-Google-Smtp-Source: AGHT+IHAaUk9VMP0tOf60AGWEp+mcg+Bg3gWPA5d+9D/Azb33N1ZCX2PuKrj8b6+3FhdfuP+8pEJhM2qdaPOvTXFqEo=
X-Received: by 2002:a05:6870:9706:b0:1bb:4c5f:6db0 with SMTP id
 n6-20020a056870970600b001bb4c5f6db0mr14315379oaq.36.1694462430668; Mon, 11
 Sep 2023 13:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911165106.39384-1-kuniyu@amazon.com> <20230911165106.39384-2-kuniyu@amazon.com>
In-Reply-To: <20230911165106.39384-2-kuniyu@amazon.com>
From: Andrei Vagin <avagin@google.com>
Date: Mon, 11 Sep 2023 13:00:19 -0700
Message-ID: <CAEWA0a5t+XfrP6BvWCVg2P8e05Bpu2hd7OpmKnB2NVYLwRmcAg@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/5] tcp: Fix bind() regression for v4-mapped-v6
 wildcard address.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 11, 2023 at 9:52=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Andrei Vagin reported bind() regression with strace logs.
>
> If we bind() a TCPv6 socket to ::FFFF:0.0.0.0 and then bind() a TCPv4
> socket to 127.0.0.1, the 2nd bind() should fail but now succeeds.
>
>   from socket import *
>
>   s1 =3D socket(AF_INET6, SOCK_STREAM)
>   s1.bind(('::ffff:0.0.0.0', 0))
>
>   s2 =3D socket(AF_INET, SOCK_STREAM)
>   s2.bind(('127.0.0.1', s1.getsockname()[1]))
>
> During the 2nd bind(), if tb->family is AF_INET6 and sk->sk_family is
> AF_INET in inet_bind2_bucket_match_addr_any(), we still need to check
> if tb has the v4-mapped-v6 wildcard address.
>
> The example above does not work after commit 5456262d2baa ("net: Fix
> incorrect address comparison when searching for a bind2 bucket"), but
> the blamed change is not the commit.
>
> Before the commit, the leading zeros of ::FFFF:0.0.0.0 were treated
> as 0.0.0.0, and the sequence above worked by chance.  Technically, this
> case has been broken since bhash2 was introduced.
>
> Note that if we bind() two sockets to 127.0.0.1 and then ::FFFF:0.0.0.0,
> the 2nd bind() fails properly because we fall back to using bhash to
> detect conflicts for the v4-mapped-v6 address.

I think we have one more issue here:

socket(AF_INET6, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 3
socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 4
bind(3, {sa_family=3DAF_INET6, sin6_port=3Dhtons(9999),
sin6_flowinfo=3Dhtonl(0), inet_pton(AF_INET6, "::ffff:127.0.0.1",
&sin6_addr), sin6_scope_id=3D0}, 28) =3D 0
bind(4, {sa_family=3DAF_INET, sin_port=3Dhtons(9999),
sin_addr=3Dinet_addr("127.0.0.1")}, 16) =3D 0

I think the second bind has to return EADDRINUSE, doesn't it?

I don't deep dive to this code, but after a quick look, I think we can
do something like this:

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 7876b7d703cb..f7a700d392d0 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -110,8 +110,13 @@ static void inet_bind2_bucket_init(struct
inet_bind2_bucket *tb,
        tb->l3mdev    =3D l3mdev;
        tb->port      =3D port;
 #if IS_ENABLED(CONFIG_IPV6)
-       tb->family    =3D sk->sk_family;
-       if (sk->sk_family =3D=3D AF_INET6)
+
+       if (sk->sk_family =3D=3D AF_INET6 &&
+           ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr))
+               tb->family =3D AF_INET;
+       else
+               tb->family =3D sk->sk_family;
+       if (tb->family =3D=3D AF_INET6)
                tb->v6_rcv_saddr =3D sk->sk_v6_rcv_saddr;
        else
 #endif
@@ -149,10 +154,15 @@ static bool inet_bind2_bucket_addr_match(const
struct inet_bind2_bucket *tb2,
                                         const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-       if (sk->sk_family !=3D tb2->family)
+       unsigned short family =3D sk->sk_family;
+
+       if (ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr))
+               family =3D AF_INET;
+
+       if (family !=3D tb2->family)
                return false;

-       if (sk->sk_family =3D=3D AF_INET6)
+       if (family =3D=3D AF_INET6)
                return ipv6_addr_equal(&tb2->v6_rcv_saddr,
                                       &sk->sk_v6_rcv_saddr);
 #endif
@@ -816,10 +826,15 @@ static bool inet_bind2_bucket_match(const struct
inet_bind2_bucket *tb,
                                    int l3mdev, const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-       if (sk->sk_family !=3D tb->family)
+       unsigned short family =3D sk->sk_family;
+
+       if (ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr))
+               family =3D AF_INET;
+
+       if (family !=3D tb->family)
                return false;

-       if (sk->sk_family =3D=3D AF_INET6)
+       if (family =3D=3D AF_INET6)
                return net_eq(ib2_net(tb), net) && tb->port =3D=3D port &&
                        tb->l3mdev =3D=3D l3mdev &&
                        ipv6_addr_equal(&tb->v6_rcv_saddr,
&sk->sk_v6_rcv_saddr);



>
> Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address"=
)
> Reported-by: Andrei Vagin <avagin@google.com>
> Closes: https://lore.kernel.org/netdev/ZPuYBOFC8zsK6r9T@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/ipv6.h         | 5 +++++
>  net/ipv4/inet_hashtables.c | 3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 0675be0f3fa0..56d8217ea6cf 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -784,6 +784,11 @@ static inline bool ipv6_addr_v4mapped(const struct i=
n6_addr *a)
>                                         cpu_to_be32(0x0000ffff))) =3D=3D =
0UL;
>  }
>
> +static inline bool ipv6_addr_v4mapped_any(const struct in6_addr *a)
> +{
> +       return ipv6_addr_v4mapped(a) && ipv4_is_zeronet(a->s6_addr32[3]);
> +}
> +
>  static inline bool ipv6_addr_v4mapped_loopback(const struct in6_addr *a)
>  {
>         return ipv6_addr_v4mapped(a) && ipv4_is_loopback(a->s6_addr32[3])=
;
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 7876b7d703cb..0a9b20eb81c4 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -837,7 +837,8 @@ bool inet_bind2_bucket_match_addr_any(const struct in=
et_bind2_bucket *tb, const
>                 if (sk->sk_family =3D=3D AF_INET)
>                         return net_eq(ib2_net(tb), net) && tb->port =3D=
=3D port &&
>                                 tb->l3mdev =3D=3D l3mdev &&
> -                               ipv6_addr_any(&tb->v6_rcv_saddr);
> +                               (ipv6_addr_any(&tb->v6_rcv_saddr) ||
> +                                ipv6_addr_v4mapped_any(&tb->v6_rcv_saddr=
));
>
>                 return false;
>         }
> --
> 2.30.2
>

