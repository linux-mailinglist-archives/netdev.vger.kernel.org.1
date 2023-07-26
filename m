Return-Path: <netdev+bounces-21391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805ED7637B5
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B159A1C2124B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BCC2D9;
	Wed, 26 Jul 2023 13:37:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789CAD28
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:37:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EF22689
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690378618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWXs5awLY8UzHFu6yejKew3eLks3/P9TSyf4ogo8JHs=;
	b=FI+/qgydhO29616+/eplUQaPbEQKr9A5aXyVJEdp5AJXXqKjKNH8qXipetStNYG2+eJtib
	FziqmhKcP1n5C0b2nxSP0O1vcD80vIe3S1HB/wPN+Xx/yBhhUwXq2IJMoMLBuUcG8pZMWZ
	f/riqO4lzawQPfRjMxMH4Um6p9ChvMU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-r1gVAY-1OgiyOLbEGVUa3Q-1; Wed, 26 Jul 2023 09:36:57 -0400
X-MC-Unique: r1gVAY-1OgiyOLbEGVUa3Q-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a361b64226so1071881b6e.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690378616; x=1690983416;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dWXs5awLY8UzHFu6yejKew3eLks3/P9TSyf4ogo8JHs=;
        b=bFgJRyyxMO2Qjxe4ZZ8tqP3l9+nxR7NGhW3h8JcWQ6OXQ1GtTZwJbH31I9EVSmZYDI
         LP9egALKQM5vtZaYgxv8wBnCKBJdyY8hRXGl37zeZKF2p9g/QfBtrIYQLvhbRF8CALqd
         gvusuPGYlB0/t1ZV3Rlbuv0brj01Gr5FFX5Z0nQWRbJuTPwIBlPLhI1R/vLcBqFEWZSj
         +vR96IXIMUINkjIobU6jHSaXrzxIDSvJRG05fK5Lqb1fd9P+q8Ji1Sw7leaJNyxN2JS2
         DMNQxqfnKAbGtyd5Z4KQSQw/INjFEcciyDuvUXLYOVGGeTBqmihxaLqWKG1gdRwUxkn/
         FyIg==
X-Gm-Message-State: ABy/qLbt8rOouiDe/x3F97MeVvWzMuSWyiivjdRthT5HCHWiORIQ0nTb
	QKpExOf1DuMaq6/MQi9TZQscImkzRBrR3UAGs6SrNOe9W5P6ZKvKkh+2eN/a/GQlDjWnqQm3W8V
	DOr6tYElScRLE8z9X6SNx5HXS
X-Received: by 2002:a05:6808:1917:b0:39e:86b3:d8ab with SMTP id bf23-20020a056808191700b0039e86b3d8abmr2385235oib.4.1690378616328;
        Wed, 26 Jul 2023 06:36:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHMyMXgGmvRI8opQ0hYPtCsIdnGTPfN/9hGRGoh1dVOw83uSmzP8jjIbe6i59ebwJ8us/M9pQ==
X-Received: by 2002:a05:6808:1917:b0:39e:86b3:d8ab with SMTP id bf23-20020a056808191700b0039e86b3d8abmr2385223oib.4.1690378616094;
        Wed, 26 Jul 2023 06:36:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id jt40-20020a05622aa02800b00403f5b07e27sm4765749qtb.51.2023.07.26.06.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:36:55 -0700 (PDT)
Message-ID: <34c11a9d2b473b7809e9fb9839b1b7b7d721eaa0.camel@redhat.com>
Subject: Re: [PATCH 2/2] Rescan the hash2 list if the hash chains have got
 cross-linked.
From: Paolo Abeni <pabeni@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>, 
 "'willemdebruijn.kernel@gmail.com'" <willemdebruijn.kernel@gmail.com>,
 "'davem@davemloft.net'" <davem@davemloft.net>,  "'dsahern@kernel.org'"
 <dsahern@kernel.org>, 'Eric Dumazet' <edumazet@google.com>,
 "'kuba@kernel.org'" <kuba@kernel.org>, "'netdev@vger.kernel.org'"
 <netdev@vger.kernel.org>
Date: Wed, 26 Jul 2023 15:36:52 +0200
In-Reply-To: <c45337a3d46641dc8c4c66bd49fb55b6@AcuMS.aculab.com>
References: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com>
	 <c45337a3d46641dc8c4c66bd49fb55b6@AcuMS.aculab.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Wed, 2023-07-26 at 12:05 +0000, David Laight wrote:
> udp_lib_rehash() can get called at any time and will move a
> socket to a different hash2 chain.
> This can cause udp4_lib_lookup2() (processing incoming UDP) to
> fail to find a socket and an ICMP port unreachable be sent.
>=20
> Prior to ca065d0cf80fa the lookup used 'hlist_nulls' and checked
> that the 'end if list' marker was on the correct list.
>=20
> Rather than re-instate the 'nulls' list just check that the final
> socket is on the correct list.
>=20
> The cross-linking can definitely happen (see earlier issues with
> it looping forever because gcc cached the list head).
>=20
> Fixes: ca065d0cf80fa ("udp: no longer use SLAB_DESTROY_BY_RCU")
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>  net/ipv4/udp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index ad64d6c4cd99..ed92ba7610b0 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -443,6 +443,7 @@ static struct sock *udp4_lib_lookup2(struct net *net,
>  				     struct sk_buff *skb)
>  {
>  	unsigned int hash2, slot2;
> +	unsigned int hash2_rescan;
>  	struct udp_hslot *hslot2;
>  	struct sock *sk, *result;
>  	int score, badness;
> @@ -451,9 +452,12 @@ static struct sock *udp4_lib_lookup2(struct net *net=
,
>  	slot2 =3D hash2 & udptable->mask;
>  	hslot2 =3D &udptable->hash2[slot2];
> =20
> +rescan:
> +	hash2_rescan =3D hash2;
>  	result =3D NULL;
>  	badness =3D 0;
>  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
> +		hash2_rescan =3D udp_sk(sk)->udp_portaddr_hash;
>  		score =3D compute_score(sk, net, saddr, sport,
>  				      daddr, hnum, dif, sdif);
>  		if (score > badness) {
> @@ -467,6 +471,16 @@ static struct sock *udp4_lib_lookup2(struct net *net=
,
>  			badness =3D score;
>  		}
>  	}
> +
> +	/* udp sockets can get moved to a different hash chain.
> +	 * If the chains have got crossed then rescan.
> +	 */
> +	if ((hash2_rescan & udptable->mask) !=3D slot2) {
> +		/* Ensure hslot2->head is reread */
> +		barrier();

udp_portaddr_for_each_entry_rcu() uses (indirectly)
rcu_dereference_raw() to access the head. That implies a READ_ONCE().
Additional barriers for re-read should not be necessary.

What about IPV6?

Cheers,

Paolo


