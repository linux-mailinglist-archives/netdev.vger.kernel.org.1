Return-Path: <netdev+bounces-32887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975DA79AAA2
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 19:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76551C208EB
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D92156DA;
	Mon, 11 Sep 2023 17:51:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F54AD2E
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 17:51:58 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85D4DD
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:51:56 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-414c54b2551so30091cf.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694454716; x=1695059516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io3nU9GStXzgRr1J9waIjua4Y93wGn4A9rj4kTh/azA=;
        b=qJLV0oe5int+6bG9GDLkGCK6WbiVzypNtkeuQEwGigd8+GUVw+bjIRdirL+1jgGBQd
         +jkzmq/s7ajp0X3647VPMbVlTmMF2MMzy+op/paxdiwpWzp4gBSCB4EyZ91oIoH7WH8u
         4rkXALkjcphZ+n4UrqMkKZ1rgt1uTNnOb17ChcP0TC+4VKpzSsQFkxDuZYIdu08K81gq
         o7gPhtihJzpQ6HnS7PnxtAR+btAhA9E18817JxJJtur2XUxTvo5FfXjgQvmwSv0JUtDD
         xF/CSj7fcD6D6CPLmIuPgGbmivJHD9tscnQiz9Q2W1EYO+g3SsrPFVND8YSdq6z5AMPb
         A/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694454716; x=1695059516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=io3nU9GStXzgRr1J9waIjua4Y93wGn4A9rj4kTh/azA=;
        b=pEWf7TXNaNCVtV0XByeygZjgi/JZorci/41P5EZmA12BPWHppVwohkIwG3Sh9uriXy
         2xqDyoTfSe7S9XW+h1HCYtLg1yfABgaRun18DZTi/kg4tnsRUGiQ6AePLXkskpyTmcI7
         O/0Blryon22VlbLpIz5Mv+xwLHqIeUBEkeoTJMopwpzEtjGcZ9mWjBQ2pLf835fJvuJ7
         jRgiGzMkdqvmW3ECwm6Pe+gPF3gMGwHQOno7LFBb4HmCdE4q0G0efdMkZIjS/8z8Ul/L
         YfQyNIR19iH3bi753ro/b007m4b5YKicr/WsFxrMfiTQYnCS7npFeUvXu5CtN76aVUS0
         XYGw==
X-Gm-Message-State: AOJu0Yws/xIOfSJDI611nSrGoRhtKo+6/sv7hH5osayBubjnW2aKh9bq
	JA0YCk/MHtczTjbowZJmDQMbCLHp5Yo8Kd+5OxJIZA==
X-Google-Smtp-Source: AGHT+IGDTKbXZBL8wOdO+8QFT+vrS1bTArKQwrzxmgf96UWoh7diz+AL3XOeqBRbBkfSPgSRxO7BRng/DYgoEDjowic=
X-Received: by 2002:a05:622a:181b:b0:3f2:2c89:f1ef with SMTP id
 t27-20020a05622a181b00b003f22c89f1efmr12898qtc.5.1694454715705; Mon, 11 Sep
 2023 10:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911165106.39384-1-kuniyu@amazon.com> <20230911165106.39384-3-kuniyu@amazon.com>
In-Reply-To: <20230911165106.39384-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 Sep 2023 19:51:44 +0200
Message-ID: <CANn89iLGDTb0FFL7=+e9zXz156+RZk0dSJXatgFmMx0vakOAAQ@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/5] tcp: Fix bind() regression for v4-mapped-v6
 non-wildcard address.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
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

On Mon, Sep 11, 2023 at 6:52=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Since bhash2 was introduced, the example below does now work as expected.
> These two bind() should conflict, but the 2nd bind() now succeeds.
>
>   from socket import *
>
>   s1 =3D socket(AF_INET6, SOCK_STREAM)
>   s1.bind(('::ffff:127.0.0.1', 0))
>
>   s2 =3D socket(AF_INET, SOCK_STREAM)
>   s2.bind(('127.0.0.1', s1.getsockname()[1]))
>
> During the 2nd bind() in inet_csk_get_port(), inet_bind2_bucket_find()
> fails to find the 1st socket's tb2, so inet_bind2_bucket_create() allocat=
es
> a new tb2 for the 2nd socket.  Then, we call inet_csk_bind_conflict() tha=
t
> checks conflicts in the new tb2 by inet_bhash2_conflict().  However, the
> new tb2 does not include the 1st socket, thus the bind() finally succeeds=
.
>
> In this case, inet_bind2_bucket_match() must check if AF_INET6 tb2 has
> the conflicting v4-mapped-v6 address so that inet_bind2_bucket_find()
> returns the 1st socket's tb2.
>
> Note that if we bind two sockets to 127.0.0.1 and then ::FFFF:127.0.0.1,
> the 2nd bind() fails properly for the same reason mentinoed in the previo=
us
> commit.
>
> Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address"=
)
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/inet_hashtables.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 0a9b20eb81c4..54505100c914 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -816,8 +816,15 @@ static bool inet_bind2_bucket_match(const struct ine=
t_bind2_bucket *tb,
>                                     int l3mdev, const struct sock *sk)
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
> -       if (sk->sk_family !=3D tb->family)
> +       if (sk->sk_family !=3D tb->family) {
> +               if (sk->sk_family =3D=3D AF_INET)
> +                       return net_eq(ib2_net(tb), net) && tb->port =3D=
=3D port &&
> +                               tb->l3mdev =3D=3D l3mdev &&
> +                               ipv6_addr_v4mapped(&tb->v6_rcv_saddr) &&
> +                               tb->v6_rcv_saddr.s6_addr32[3] =3D=3D sk->=
sk_rcv_saddr;
> +
>                 return false;
> +       }
>
>         if (sk->sk_family =3D=3D AF_INET6)
>                 return net_eq(ib2_net(tb), net) && tb->port =3D=3D port &=
&
> --

Could we first factorize all these "net_eq(ib2_net(tb), net) &&
tb->port =3D=3D port" checks ?

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 7876b7d703cb5647086c45ca547c4caadc00c091..6240c802ed772272028e6e65bf9=
0f345dd2d1619
100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -832,24 +832,24 @@ static bool inet_bind2_bucket_match(const struct
inet_bind2_bucket *tb,
 bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket
*tb, const struct net *net,
                                      unsigned short port, int l3mdev,
const struct sock *sk)
 {
+       if (!net_eq(ib2_net(tb), net) || tb->port !=3D port)
+               return false;
+
 #if IS_ENABLED(CONFIG_IPV6)
        if (sk->sk_family !=3D tb->family) {
                if (sk->sk_family =3D=3D AF_INET)
-                       return net_eq(ib2_net(tb), net) && tb->port =3D=3D =
port &&
-                               tb->l3mdev =3D=3D l3mdev &&
+                       return  tb->l3mdev =3D=3D l3mdev &&
                                ipv6_addr_any(&tb->v6_rcv_saddr);

                return false;
        }

        if (sk->sk_family =3D=3D AF_INET6)
-               return net_eq(ib2_net(tb), net) && tb->port =3D=3D port &&
-                       tb->l3mdev =3D=3D l3mdev &&
+               return  tb->l3mdev =3D=3D l3mdev &&
                        ipv6_addr_any(&tb->v6_rcv_saddr);
        else
 #endif
-               return net_eq(ib2_net(tb), net) && tb->port =3D=3D port &&
-                       tb->l3mdev =3D=3D l3mdev && tb->rcv_saddr =3D=3D 0;
+               return tb->l3mdev =3D=3D l3mdev && tb->rcv_saddr =3D=3D 0;
 }

 /* The socket's bhash2 hashbucket spinlock must be held when this is calle=
d */

