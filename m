Return-Path: <netdev+bounces-37595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDC57B631E
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4D13228160E
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 08:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00977D52B;
	Tue,  3 Oct 2023 08:05:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059C6AC0
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 08:05:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70696A9
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 01:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696320312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkDdYjXTNNFKMEGBDII/R5LRzWzu8IkLDvz16w0SqB0=;
	b=H8Wch3vkGUeJd9jAKzrui2vJv1SeEokD0mcl0aJuhhA+4jkcF6GjyTF6MrPqm2AkyrPHxs
	PuLAy9UQMpQqmVyi/AoCXCdT1s0BV2QGYac3jSNocxBLeFM41/7Kh3llK6KB1Nwa17MY8P
	+OXaYCruf+dXkBmOwAAwX3Sm8loC/AU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-2BH6dxPoOaWoR6R4nqNLdQ-1; Tue, 03 Oct 2023 04:05:01 -0400
X-MC-Unique: 2BH6dxPoOaWoR6R4nqNLdQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-53479f2bfb7so101829a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 01:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696320300; x=1696925100;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkDdYjXTNNFKMEGBDII/R5LRzWzu8IkLDvz16w0SqB0=;
        b=OzJyO9EY5De7QwkYTGO1J08a/XUau05Uw5XGteJmWXLblKf7xM+XaeBJ/V9F+g1CMO
         1xaVqwVcuCpIyamm7guhdM0OqTfmYVF8pwB9AKXcGmoLzT+SuUrEVXhPaVRz4o7ZKo4z
         Vd4t/F0uohLNbaTiiPs2/AlLkaRSIW7trbg6TceiSUsXTim3Rsv8S00kd3HEY0hsluZR
         kBfIke4IAbV6KcIXHKeROCJzQx4pIAvL9k0ZZNpwwqM+uQm++2oWM2ItriJzQwJRIJ8c
         CGE7wx94sHJuP6p/ceYRpnXmk3lI8WTWKZRkLjHh8NUOJFC1BfLQGK2W9c+kk6pSoqZN
         TlqA==
X-Gm-Message-State: AOJu0YxQeXpcOyLGlRT5S6e2W28dHEsQrZoPGovuudddu84ZPdy116Fo
	UYr7gfrI66i1CPJZ3JIwSAj1dsGpSrHCqFBTSAxr6jMR3GmNH50INLH+Hn5nnFvk0pigL65/UQu
	hCQP1pfEkuxkMcxUL
X-Received: by 2002:a17:906:74c1:b0:9a6:5340:c337 with SMTP id z1-20020a17090674c100b009a65340c337mr10438032ejl.2.1696320300298;
        Tue, 03 Oct 2023 01:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1AqezZUgoWGFQb3J+RrAE25FcXwNLROVwfK24RGNkXT3LrxJxGPkOukpFrq4vNjUxVleSRA==
X-Received: by 2002:a17:906:74c1:b0:9a6:5340:c337 with SMTP id z1-20020a17090674c100b009a65340c337mr10438025ejl.2.1696320299931;
        Tue, 03 Oct 2023 01:04:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id lv25-20020a170906bc9900b00988dbbd1f7esm609322ejb.213.2023.10.03.01.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:04:59 -0700 (PDT)
Message-ID: <e6bda1486e3787b6aeac4024d30df97910366028.camel@redhat.com>
Subject: Re: [PATCH net-next 4/4] tcp_metrics: optimize
 tcp_metrics_flush_all()
From: Paolo Abeni <pabeni@redhat.com>
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller"
	 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
  netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 03 Oct 2023 10:04:58 +0200
In-Reply-To: <e7a1d01a-6607-fa6f-33f8-db31a3fb75a8@kernel.org>
References: <20230922220356.3739090-1-edumazet@google.com>
	 <20230922220356.3739090-5-edumazet@google.com>
	 <e7a1d01a-6607-fa6f-33f8-db31a3fb75a8@kernel.org>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 2023-09-23 at 13:07 +0200, David Ahern wrote:
> On 9/22/23 4:03 PM, Eric Dumazet wrote:
> > This is inspired by several syzbot reports where
> > tcp_metrics_flush_all() was seen in the traces.
> >=20
> > We can avoid acquiring tcp_metrics_lock for empty buckets,
> > and we should add one cond_resched() to break potential long loops.
> >=20
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv4/tcp_metrics.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> > index 7aca12c59c18483f42276d01252ed0fac326e5d8..c2a925538542b5d787596b7=
d76705dda86cf48d8 100644
> > --- a/net/ipv4/tcp_metrics.c
> > +++ b/net/ipv4/tcp_metrics.c
> > @@ -898,11 +898,13 @@ static void tcp_metrics_flush_all(struct net *net=
)
> >  	unsigned int row;
> > =20
> >  	for (row =3D 0; row < max_rows; row++, hb++) {
> > -		struct tcp_metrics_block __rcu **pp;
> > +		struct tcp_metrics_block __rcu **pp =3D &hb->chain;
> >  		bool match;
> > =20
> > +		if (!rcu_access_pointer(*pp))
> > +			continue;
> > +
> >  		spin_lock_bh(&tcp_metrics_lock);
> > -		pp =3D &hb->chain;
> >  		for (tm =3D deref_locked(*pp); tm; tm =3D deref_locked(*pp)) {
> >  			match =3D net ? net_eq(tm_net(tm), net) :
> >  				!refcount_read(&tm_net(tm)->ns.count);
> > @@ -914,6 +916,7 @@ static void tcp_metrics_flush_all(struct net *net)
> >  			}
> >  		}
> >  		spin_unlock_bh(&tcp_metrics_lock);
> > +		cond_resched();
>=20
> I have found cond_resched() can occur some unnecessary overhead if
> called too often. Wrap in `if (need_resched)`?

Interesting. I could not find any significant overhead with code
inspection - it should be a matter of 2 conditionals instead of one -
Any idea why?

In any case I think we can follow-up with that if needed - e.g. no
changes required here.

Cheers,

Paolo


