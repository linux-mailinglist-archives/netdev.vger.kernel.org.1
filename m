Return-Path: <netdev+bounces-16042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2E174B21D
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 15:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7E91C20FC2
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645FC8E6;
	Fri,  7 Jul 2023 13:45:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92C933D0
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 13:45:16 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93162118
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 06:44:53 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4036bd4fff1so286251cf.0
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688737493; x=1691329493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMAD3rRxGAPJwgFsPYYUaElPo0zHq1tuXPrG8L429FU=;
        b=JgCvs3CKYDETsPK4T/fy6X9gIXBGRcayLS929Q4OvSducbjYV9maQRW2YPUmdmr+Ve
         4xvS/ntJgdwybTd0w7g9GUekvBe3Bo3L9ALOTpX+cysGifcS/DpR/TI4O8s/ijmPJDma
         qVdxVAegDHhAFQ4uRr9Q5DvnyzHg9+92EVOdW+TrLhmhWJFVq0ZPdwgRpclFVhdMJqJd
         ot9bZ9mceZsyaT11j0de8jKexnDAFs9176qwKIIkSPztk/MuUbNhBo9oMa6JXAOWkKMR
         enLJJQ7JHF9Nr3wdWNZewpsqXo7X/81auPH5GH2QXB0rk/d3001v+JeTvoStwoADTKI4
         WXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737493; x=1691329493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMAD3rRxGAPJwgFsPYYUaElPo0zHq1tuXPrG8L429FU=;
        b=TT6+T5Xaxv7j/1eH8/IkEHS12YN/2F31qFjKo77ayDg2igkAUOnnTvKViAmt2e/dtu
         qo2OW3pCn1MYRcjmIiPQ/H01QsY1eNWt1vnhYxNwj2iCn58IcOL63GQF2AgqR0j7WB1Y
         QLCbcCAUMp5vCZ2kx+iVetsI4QinLGUKIluhD6jTUXTn1C8T0zu+bt6EjP57gf/01FVh
         HmOdwYTPEylGize82rfT9diCLDY6GN2D75eO0f67JZbl1zGZTSmmhEeJkJI5qOMAsNUv
         5odzwHLl6eGiZPFo1b9Oxei5GrKgBW7rXm0FmKohI1RVomfW669PjWnuwHkV5wEw3kYY
         Li8g==
X-Gm-Message-State: ABy/qLb9QnKtWdpUqQtyqETcUNwMy2qXSr3EBemBZ3fFi7pjlknlrFwR
	nJLDHSJ7zJmKt0Se+toCpFYmn/DWPyUi+5vkacFSqg==
X-Google-Smtp-Source: APBJJlG+KbNfFJ2cKFEADSdf6piIFjRq9AvIRzcUgJqcluzdvPf6Zb8obPMhoZfEpYCQZM5i8e1EavaWauaPzxYMGX0=
X-Received: by 2002:a05:622a:1015:b0:3f4:f841:df89 with SMTP id
 d21-20020a05622a101500b003f4f841df89mr149875qte.1.1688737492664; Fri, 07 Jul
 2023 06:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707121650.GA17677@debian> <20230707122627.GA17845@debian>
In-Reply-To: <20230707122627.GA17845@debian>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jul 2023 15:44:41 +0200
Message-ID: <CANn89i+gm=0J3aR_9ikhroQmAvuQ+-dPMH1em9WrmE1o1pfi7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: gro: fix misuse of CB in udp socket lookup
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, dsahern@kernel.org, tom@herbertland.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 2:26=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:
>
> This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
> `udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch th=
e
> device from CB. The fix changes it to fetch the device from `skb->dev`.
> l3mdev case requires special attention since it has a master and a slave
> device.
>
> Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/udp.h      |  2 ++
>  net/ipv4/udp.c         | 21 +++++++++++++++++++--
>  net/ipv4/udp_offload.c |  7 +++++--
>  net/ipv6/udp.c         | 21 +++++++++++++++++++--
>  net/ipv6/udp_offload.c |  7 +++++--
>  5 files changed, 50 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 4d13424f8f72..48af1479882f 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -299,6 +299,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, in=
t optname,
>  int udp_lib_setsockopt(struct sock *sk, int level, int optname,
>                        sockptr_t optval, unsigned int optlen,
>                        int (*push_pending_frames)(struct sock *));
> +void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
>  struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport=
,
>                              __be32 daddr, __be16 dport, int dif);
>  struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr, __be16 spo=
rt,
> @@ -310,6 +311,7 @@ struct sock *udp6_lib_lookup(struct net *net,
>                              const struct in6_addr *saddr, __be16 sport,
>                              const struct in6_addr *daddr, __be16 dport,
>                              int dif);
> +void udp6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
>  struct sock *__udp6_lib_lookup(struct net *net,
>                                const struct in6_addr *saddr, __be16 sport=
,
>                                const struct in6_addr *daddr, __be16 dport=
,
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 42a96b3547c9..0581ab184afd 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -550,15 +550,32 @@ static inline struct sock *__udp4_lib_lookup_skb(st=
ruct sk_buff *skb,
>                                  inet_sdif(skb), udptable, skb);
>  }
>
> +void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
> +{
> +       *iif =3D inet_iif(skb) || skb->dev->ifindex;

This looks wrong. Did you mean

        *iif =3D inet_iif(skb) ?: skb->dev->ifindex;

> +       *sdif =3D 0;
> +
> +#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
> +       if (netif_is_l3_slave(skb->dev)) {
> +               struct net_device *master =3D netdev_master_upper_dev_get=
_rcu(skb->dev);
> +               *sdif =3D *iif;
> +               *iif =3D master ? master->ifindex : 0;
> +       }
> +#endif
> +}
> +
>  struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
>                                  __be16 sport, __be16 dport)
>  {
>         const struct iphdr *iph =3D ip_hdr(skb);
>         struct net *net =3D dev_net(skb->dev);
> +       int iif, sdif;
> +
> +       udp4_get_iif_sdif(skb, &iif, &sdif);
>
>         return __udp4_lib_lookup(net, iph->saddr, sport,
> -                                iph->daddr, dport, inet_iif(skb),
> -                                inet_sdif(skb), net->ipv4.udp_table, NUL=
L);
> +                                iph->daddr, dport, iif,
> +                                sdif, net->ipv4.udp_table, NULL);
>  }
>
>  /* Must be called under rcu_read_lock().
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 75aa4de5b731..70d760b271db 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -603,10 +603,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_b=
uff *skb, __be16 sport,
>  {
>         const struct iphdr *iph =3D skb_gro_network_header(skb);
>         struct net *net =3D dev_net(skb->dev);
> +       int iif, sdif;
> +
> +       udp4_get_iif_sdif(skb, &iif, &sdif);
>
>         return __udp4_lib_lookup(net, iph->saddr, sport,
> -                                iph->daddr, dport, inet_iif(skb),
> -                                inet_sdif(skb), net->ipv4.udp_table, NUL=
L);
> +                                iph->daddr, dport, iif,
> +                                sdif, net->ipv4.udp_table, NULL);
>  }
>
>  INDIRECT_CALLABLE_SCOPE
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 317b01c9bc39..aac9b20d67e4 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -294,15 +294,32 @@ static struct sock *__udp6_lib_lookup_skb(struct sk=
_buff *skb,
>                                  inet6_sdif(skb), udptable, skb);
>  }
>
> +void udp6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
> +{
> +       *iif =3D skb->dev->ifindex;

ipv6_rcv() inits

IP6CB(skb)->iif =3D skb_dst(skb) ?
ip6_dst_idev(skb_dst(skb))->dev->ifindex : dev->ifindex;

You chose to always use skb->dev->ifindex instead ?

You might add a comment why it is okay.

> +       *sdif =3D 0;
> +
> +#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
> +       if (netif_is_l3_slave(skb->dev)) {
> +               struct net_device *master =3D netdev_master_upper_dev_get=
_rcu(skb->dev);
> +               *sdif =3D *iif;
> +               *iif =3D master ? master->ifindex : 0;
> +       }
> +#endif
> +}
> +
>  struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
>                                  __be16 sport, __be16 dport)
>  {
>         const struct ipv6hdr *iph =3D ipv6_hdr(skb);
>         struct net *net =3D dev_net(skb->dev);
> +       int iif, sdif;
> +
> +       udp6_get_iif_sdif(skb, &iif, &sdif);
>
>         return __udp6_lib_lookup(net, &iph->saddr, sport,
> -                                &iph->daddr, dport, inet6_iif(skb),
> -                                inet6_sdif(skb), net->ipv4.udp_table, NU=
LL);
> +                                &iph->daddr, dport, iif,
> +                                sdif, net->ipv4.udp_table, NULL);
>  }
>
>  /* Must be called under rcu_read_lock().
> diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> index ad3b8726873e..88191d79002e 100644
> --- a/net/ipv6/udp_offload.c
> +++ b/net/ipv6/udp_offload.c
> @@ -119,10 +119,13 @@ static struct sock *udp6_gro_lookup_skb(struct sk_b=
uff *skb, __be16 sport,
>  {
>         const struct ipv6hdr *iph =3D skb_gro_network_header(skb);
>         struct net *net =3D dev_net(skb->dev);
> +       int iif, sdif;
> +
> +       udp6_get_iif_sdif(skb, &iif, &sdif);
>
>         return __udp6_lib_lookup(net, &iph->saddr, sport,
> -                                &iph->daddr, dport, inet6_iif(skb),
> -                                inet6_sdif(skb), net->ipv4.udp_table, NU=
LL);
> +                                &iph->daddr, dport, iif,
> +                                sdif, net->ipv4.udp_table, NULL);
>  }
>
>  INDIRECT_CALLABLE_SCOPE
> --
> 2.36.1
>

