Return-Path: <netdev+bounces-20700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9095B760B44
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961F11C20D5D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0E8F6D;
	Tue, 25 Jul 2023 07:15:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642DC8F63
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:15:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DAB12C
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690269330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWk1QNmGdF3nvk5gdxdbBJcvckgMM8MpVQ7sj6/rxuY=;
	b=fhW7WltycetBR52UPZFfNFNQ8cOcOLHMQJ1xNpvxjpb4UF2hIfqZhN/xwbBbh2/nCE/r1n
	eUUUP1RL7Txyr80AnzuZE+qqsYA+Iw3+eMdhKbaNV6mh4dMS+C8inXXvA2xAeVVGdFFi+8
	XYl1hAX0RYm8sS7mLRU8vGqLRRWfdh0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-7ikqE5vTPo-kI2gk2rwdew-1; Tue, 25 Jul 2023 03:15:29 -0400
X-MC-Unique: 7ikqE5vTPo-kI2gk2rwdew-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3176f5796ecso4379f8f.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690269328; x=1690874128;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KWk1QNmGdF3nvk5gdxdbBJcvckgMM8MpVQ7sj6/rxuY=;
        b=Agjon0GHt3aqoo17kvSo02qqgzV+v9MF9BZrOxlhETTwi2zlz3+MPlmNEklR1ryVMk
         +ESnBA1lP51Jwj5F4xiu5NRd3cBDUq30C5a/fLBrGvrZY5zaWPpF8UqyDISoY9mbcqF7
         6FB7qPmBNqxG4roOqceWP8WNKuXmtW7zknuVHYR6f8L3wyOMpjFKTNzmiFPaKNTHw2ww
         SQQMs+adWHSWcnPs3DFTdpf+u0uMbG8YQXoHFOKrpofHitGv2caSdIyYCGl4jgHsneJS
         KIhK27Pl4DyDs8POHP9RhtZRTKzKO1raJXIz5C1lghod/P259pV3/mSmN1I48Oo3sQ2N
         TgWg==
X-Gm-Message-State: ABy/qLY5xLoSRz9EC6MQC0PDXRXtKsGHjUw4AUlsbHJoB8j1JA7QZFkK
	bx/GOPvB2dnf6P/OD6dx19jhd8mN0zHHGsVnNoASMbTHj+HGyXUvuCAmV/crFOpaD6EIQNgk3nF
	2kUgGfHHjPV6v8EnE
X-Received: by 2002:a5d:5948:0:b0:317:5f08:329f with SMTP id e8-20020a5d5948000000b003175f08329fmr3375762wri.1.1690269328068;
        Tue, 25 Jul 2023 00:15:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG3FJsaKirPS9RCkbt4lNXMtrL1cLC0EIjPJ2Gg0I27op4L4ECGqs0qtSHRxpN+luxQd1WZbA==
X-Received: by 2002:a5d:5948:0:b0:317:5f08:329f with SMTP id e8-20020a5d5948000000b003175f08329fmr3375746wri.1.1690269327693;
        Tue, 25 Jul 2023 00:15:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id t7-20020a5d6a47000000b00313f7b077fesm15305129wrw.59.2023.07.25.00.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:15:27 -0700 (PDT)
Message-ID: <17b4e630c63657249a7268943f8806004de4cdca.camel@redhat.com>
Subject: Re: [PATCH v2 1/1] net: gro: fix misuse of CB in udp socket lookup
From: Paolo Abeni <pabeni@redhat.com>
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, willemdebruijn.kernel@gmail.com, 
	dsahern@kernel.org, tom@herbertland.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gal@nvidia.com
Date: Tue, 25 Jul 2023 09:15:25 +0200
In-Reply-To: <20230720162624.GA16428@debian>
References: <20230720161322.GA16323@debian> <20230720162624.GA16428@debian>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Richard,

On Thu, 2023-07-20 at 18:26 +0200, Richard Gobert wrote:
> This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
> `udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch th=
e
> device from CB. The fix changes it to fetch the device from `skb->dev`.
> l3mdev case requires special attention since it has a master and a slave
> device.
>=20
> Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/udp.h      |  2 ++
>  net/ipv4/udp.c         | 28 ++++++++++++++++++++++++++--
>  net/ipv4/udp_offload.c |  7 +++++--
>  net/ipv6/udp.c         | 29 +++++++++++++++++++++++++++--
>  net/ipv6/udp_offload.c |  7 +++++--
>  5 files changed, 65 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 4d13424f8f72..48af1479882f 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -299,6 +299,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, in=
t optname,
>  int udp_lib_setsockopt(struct sock *sk, int level, int optname,
>  		       sockptr_t optval, unsigned int optlen,
>  		       int (*push_pending_frames)(struct sock *));
> +void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
>  struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport=
,
>  			     __be32 daddr, __be16 dport, int dif);
>  struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr, __be16 spo=
rt,
> @@ -310,6 +311,7 @@ struct sock *udp6_lib_lookup(struct net *net,
>  			     const struct in6_addr *saddr, __be16 sport,
>  			     const struct in6_addr *daddr, __be16 dport,
>  			     int dif);
> +void udp6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
>  struct sock *__udp6_lib_lookup(struct net *net,
>  			       const struct in6_addr *saddr, __be16 sport,
>  			       const struct in6_addr *daddr, __be16 dport,
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 8c3ebd95f5b9..85eb9977db2c 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -550,15 +550,39 @@ static inline struct sock *__udp4_lib_lookup_skb(st=
ruct sk_buff *skb,
>  				 inet_sdif(skb), udptable, skb);
>  }
> =20
> +/* This function is the alternative to 'inet_iif' and 'inet_sdif'
> + * functions in case we can not rely on fields of IPCB.
> + *
> + * The caller must verify skb_valid_dst(skb) is false and skb->dev is in=
itialized.
> + * The caller must hold the RCU read lock.
> + */
> +inline void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *=
sdif)

I think you misread David Ahern's suggestion on v1. The idea would be
to move this function (and udp6_get_iif_sdif) in an header file, as
'static inline'[1]. Additionally there is nothing specific about UDP
here so I would rename them inet{,6}_gro_iif_sdif and place them in
include/net/gro.h.

Otherwise LGTM.

Thanks,

Paolo

[1] the usage of the "inline" keyword is basically allowed only in
header files


