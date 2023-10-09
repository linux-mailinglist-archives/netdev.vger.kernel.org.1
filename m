Return-Path: <netdev+bounces-38956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B337BD42B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8351C208C1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 07:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682FDFBF9;
	Mon,  9 Oct 2023 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZQwOMnT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6647C13D
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:19:15 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C4E94
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 00:19:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so11738a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696835952; x=1697440752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G4lnIm/L/2jfjUpl8BGvD5ApP4hc/7MaXZs13qmiX4=;
        b=wZQwOMnT3SVMeaeyCon8U4P6CWLcCmxgvIYd/DazndX/EgQFSfV9uOTikaOSOEhHGM
         +BgxW7oorkWQR/ocPjEMwqQwpIrj8sDyTT/vLXiOHnaQgQUyfelrz6KxTmtiL5oO9O0r
         h43YIPeBTvyb8qHoiyKz9n/qqKy5IGlHb1IzKhmnr7KYy6s980EHL0M03GrJfCaRE7px
         JQ+18sD+Lj/60Cue5LnRJOXaFJnZQgngF/QymwS33cVlOJAePn8Vj8gMgosQO6ydK8wE
         OsRcp5OkrWyGBaJcQ0MuLt41XSKe3B41ev35y+tDFZBfjp19UqkOotAf2rb+PgjPuDE6
         rasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696835952; x=1697440752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G4lnIm/L/2jfjUpl8BGvD5ApP4hc/7MaXZs13qmiX4=;
        b=Ff4f9mam+cuEJbCiITA9DY/+gKgSLBnXh+27dyTVuiYtT+sUYalSVj4yhrRLlTb+Tk
         4iQdgeUMqi7N6dN8o+YhB4515p4innr2XcjrxK27bsPtjPRnM6CzuyYhVD+YkugVDINC
         SogKwwvHwQzTTne8z6PbBP+jWqErFEl38WfsW4attG/p/eXJt3ukwn1FWZLQOYY3evBZ
         L9yVFHTrL4OQ2EvTDZjZx+Xlmd1f/5f0ohOKE3wZqYAlEvNBpHLWBhe2E3l5jySCA0kS
         Nj5KRBq+eWwl1puSK8C0fppXG6MfFetk19jEup2c13bECQpnBkJqKGBuufE+1SAp7/K/
         WHgg==
X-Gm-Message-State: AOJu0YzKDVs4hX7O2vmJwC/TvG6GuIwbBulTaZmKWy2J7UJ2x0JDKUmy
	pzS72oY5/DMlU9keezu7bV8pLcaokJlAT/A4cXD3kw==
X-Google-Smtp-Source: AGHT+IE+jq9PyYLsYHpsrvCUuH0lJPTbZB/gGk8VPqkFRBMyIAGs6DNDsRIAtLDoPdM/SUAadTJzmjrpa3ookyfrHnU=
X-Received: by 2002:a50:cd5c:0:b0:538:47bb:3e88 with SMTP id
 d28-20020a50cd5c000000b0053847bb3e88mr350456edj.6.1696835952079; Mon, 09 Oct
 2023 00:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007105019.GA20662@breakpoint.cc> <20231009021108.3203928-1-guodongtai@kylinos.cn>
In-Reply-To: <20231009021108.3203928-1-guodongtai@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Oct 2023 09:18:58 +0200
Message-ID: <CANn89i+OL_kPwmHEW-KBGdd-prAGC3NaQG4MNq4ZEvWpw7Q-7A@mail.gmail.com>
Subject: Re: [PATCH v2] tcp: cleanup secure_{tcp, tcpv6}_ts_off
To: George Guo <guodongtai@kylinos.cn>
Cc: fw@strlen.de, davem@davemloft.net, dongtai.guo@linux.dev, 
	dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 5:12=E2=80=AFAM George Guo <guodongtai@kylinos.cn> w=
rote:
>
> Correct secure_tcp_ts_off and secure_tcpv6_ts_off call parameter order
>

I do not think this patch is correct.

We have to exchange saddr/daddr from an incoming packet in order to compute
a hash if the function expects saddr to be the local host address, and
daddr being the remote peer address.

For instance, tcp_v4_connect() uses :

WRITE_ONCE(tp->tsoffset,
                          secure_tcp_ts_off(net, inet->inet_saddr,
                                                        inet->inet_daddr));

While when receiving a packet from the other peer, it correctly swaps
saddr/daddr

tcp_v4_init_ts_off(const struct net *net, const struct sk_buff *skb)
{
 return secure_tcp_ts_off(net, ip_hdr(skb)->daddr, ip_hdr(skb)->saddr);
}


> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  net/ipv4/syncookies.c | 4 ++--
>  net/ipv4/tcp_ipv4.c   | 2 +-
>  net/ipv6/syncookies.c | 4 ++--
>  net/ipv6/tcp_ipv6.c   | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index dc478a0574cb..537f368a0b66 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -360,8 +360,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>
>         if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
>                 tsoff =3D secure_tcp_ts_off(sock_net(sk),
> -                                         ip_hdr(skb)->daddr,
> -                                         ip_hdr(skb)->saddr);
> +                                         ip_hdr(skb)->saddr,
> +                                         ip_hdr(skb)->daddr);
>                 tcp_opt.rcv_tsecr -=3D tsoff;
>         }
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a441740616d7..54717d261693 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -104,7 +104,7 @@ static u32 tcp_v4_init_seq(const struct sk_buff *skb)
>
>  static u32 tcp_v4_init_ts_off(const struct net *net, const struct sk_buf=
f *skb)
>  {
> -       return secure_tcp_ts_off(net, ip_hdr(skb)->daddr, ip_hdr(skb)->sa=
ddr);
> +       return secure_tcp_ts_off(net, ip_hdr(skb)->saddr, ip_hdr(skb)->da=
ddr);
>  }
>
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index 5014aa663452..9af484a4d518 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -162,8 +162,8 @@ struct sock *cookie_v6_check(struct sock *sk, struct =
sk_buff *skb)
>
>         if (tcp_opt.saw_tstamp && tcp_opt.rcv_tsecr) {
>                 tsoff =3D secure_tcpv6_ts_off(sock_net(sk),
> -                                           ipv6_hdr(skb)->daddr.s6_addr3=
2,
> -                                           ipv6_hdr(skb)->saddr.s6_addr3=
2);
> +                                           ipv6_hdr(skb)->saddr.s6_addr3=
2,
> +                                           ipv6_hdr(skb)->daddr.s6_addr3=
2);
>                 tcp_opt.rcv_tsecr -=3D tsoff;
>         }
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index bfe7d19ff4fd..7e2f924725c6 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -119,8 +119,8 @@ static u32 tcp_v6_init_seq(const struct sk_buff *skb)
>
>  static u32 tcp_v6_init_ts_off(const struct net *net, const struct sk_buf=
f *skb)
>  {
> -       return secure_tcpv6_ts_off(net, ipv6_hdr(skb)->daddr.s6_addr32,
> -                                  ipv6_hdr(skb)->saddr.s6_addr32);
> +       return secure_tcpv6_ts_off(net, ipv6_hdr(skb)->saddr.s6_addr32,
> +                                  ipv6_hdr(skb)->daddr.s6_addr32);
>  }
>
>  static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr *uaddr,
> --
> 2.34.1
>

