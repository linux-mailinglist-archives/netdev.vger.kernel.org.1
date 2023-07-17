Return-Path: <netdev+bounces-18303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A787565FC
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C7A281175
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7D1BA45;
	Mon, 17 Jul 2023 14:13:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E624C98
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:13:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D28E4F
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689603197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANSyAPnff5C7vSRtQKvQBbhuDGPCvLivNLzIIYPnWqI=;
	b=IevjspzbxUsiVpBBkKymSb4aotBPixX3tnGB12j8aCeMYAQ86m49O9pemkj6oWqsMyXejw
	6SeUFa02uRnk9LaMTTCz4mdNfdbHYw72L6EDR2+3gvAVxeERvlu7TpyjIC1rfhTgqPIB2P
	K2nNdyjyrozA5YOYbPZkXqT23fkQ/ls=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-Kk3AkK7mPDSMWk3WuXUr7Q-1; Mon, 17 Jul 2023 10:13:16 -0400
X-MC-Unique: Kk3AkK7mPDSMWk3WuXUr7Q-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7672918d8a4so107333485a.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689603195; x=1692195195;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANSyAPnff5C7vSRtQKvQBbhuDGPCvLivNLzIIYPnWqI=;
        b=BTv4tg5PK+JAVqUqmtGgk0wQQ4ewHcrlcbmFtv2XXz2cGDX4/TWqXNw+vOESmjwbEB
         WnDZoV8HgAuhjTIXJaBTy6hs8jgKPvi8ntOcdR35kZyEOC2ZH5h0hYiOGf2UtusC9868
         8gM0jkST0giL2mwfmqbxbcjrNUR69GKy1tAiiOkm4vokpXhwnXrLx//YZO+V3BSFXiDd
         16ey6fWa/wL+dqZm0dcNRfMgp9NK3ANIU3YKvmYe1XuTKFfgm2uPS4r4PiKYvkxYTvkn
         dp5i6sWeT0JUK3oTyJKLP80mb8Cw9lgY8Bb7t0DCSP6BooNJZrWwMayhKdynhCpCIMTi
         XcSA==
X-Gm-Message-State: ABy/qLZZCpues451bHYgb6+VM2HtZ/8hers1Edk8kTjqM3aXM0GtxKT2
	kd2PLl0/jns+uRiAYmALGZ2qljFc7d1puZsoGvn4BfBp13U5NaASb2Njwc12pliARnPIa3D9YUQ
	RfroAcXMh7zXOM8778Y02Yzul
X-Received: by 2002:a05:6214:5013:b0:62d:fdc4:1e8b with SMTP id jo19-20020a056214501300b0062dfdc41e8bmr9110286qvb.2.1689603195330;
        Mon, 17 Jul 2023 07:13:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGO+jadGH85ztTNrtSZZnV1tk9wok/ap7snw1zUjLF+ba+Tfh5T/+hNwiRfEqs0SU6f0ioLww==
X-Received: by 2002:a05:6214:5013:b0:62d:fdc4:1e8b with SMTP id jo19-20020a056214501300b0062dfdc41e8bmr9110272qvb.2.1689603195102;
        Mon, 17 Jul 2023 07:13:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id pi1-20020a05620a378100b0076639dfca8dsm6118089qkn.80.2023.07.17.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:13:14 -0700 (PDT)
Message-ID: <c835b29be1c86d765e9691b1f9772577fa3f560c.camel@redhat.com>
Subject: Re: [PATCH net-next] udp: introduce and use indirect call wrapper
 for data ready()
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, David Ahern
 <dsahern@kernel.org>
Date: Mon, 17 Jul 2023 16:13:11 +0200
In-Reply-To: <64b545c1316d2_1e11c1294e3@willemb.c.googlers.com.notmuch>
References: 
	<8834aadd89c1ebcbad32f591ea4d29c9f2684497.1689587539.git.pabeni@redhat.com>
	 <64b545c1316d2_1e11c1294e3@willemb.c.googlers.com.notmuch>
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

On Mon, 2023-07-17 at 09:44 -0400, Willem de Bruijn wrote:
> Paolo Abeni wrote:
> > In most cases UDP sockets use the default data ready callback.
> > This patch Introduces and uses a specific indirect call wrapper for
> > such callback to avoid an indirect call in fastpath.
> >=20
> > The above gives small but measurable performance gain under UDP flood.
>=20
> Interesting. I recently wrote a patch to add indirect call wrappers
> around getfrag (ip_generic_getfrag), expecting that to improve  UDP
> senders. Since it's an indirect call on each send call. Not sent,
> because I did not see measurable gains, at least with a udp_rr bench.
>=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Note that this helper could be used for TCP, too. I did not send such
> > patch right away because in my tests the perf delta there is below the
> > noise level even in RR scenarios and the patch would be a little more
> > invasive - there are more sk_data_ready() invocation places.
> > ---
> >  include/net/sock.h | 4 ++++
> >  net/ipv4/udp.c     | 2 +-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 2eb916d1ff64..1b26dbecdcca 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2947,6 +2947,10 @@ static inline bool sk_dev_equal_l3scope(struct s=
ock *sk, int dif)
> >  }
> > =20
> >  void sock_def_readable(struct sock *sk);
> > +static inline void sk_data_ready(struct sock *sk)
> > +{
> > +	INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
> > +}
> >=20
>=20
> Why introduce a static inline in the header for this?
>=20
> To reuse it in other protocols later?

I originally thought about re-using it even for TCP, but showed no gain
there. I think/hope there could be other users, and I found the code
nicer this way ;)

Cheers,

Paolo


