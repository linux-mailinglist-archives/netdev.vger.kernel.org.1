Return-Path: <netdev+bounces-33341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B5E79D76C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 19:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A1A1C20F5F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F4A6101;
	Tue, 12 Sep 2023 17:20:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914B33E9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 17:20:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2AA710E9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694539199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdZtLR/rtDwKCcKmX7gVLNlETVcyoG7spOjKpnygfrY=;
	b=S5LBKAD9r+tVsghJxBcGZMd+2N4/DjyL4K7UMFvFWB8D3hrirKw1ieET/iojwncr1xeg5K
	1OjGUmv74WH2qzw4wh/6cvBIKW+NmaZfAE/YurL3waNyfZnpPFRf6qC62b9CRGuyqEX1Q2
	+9iCCn71pxG2uDMFibA7x4AmNYVYDJ4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-R3d24kwrNhaAhVOePM7_-w-1; Tue, 12 Sep 2023 13:19:58 -0400
X-MC-Unique: R3d24kwrNhaAhVOePM7_-w-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bcc0c073ffso10278981fa.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694539196; x=1695143996;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdZtLR/rtDwKCcKmX7gVLNlETVcyoG7spOjKpnygfrY=;
        b=UETfVU2qoMp0YlNfVhIxBjlyimZQ2MOZRPeI9K27aZr9MqCFC9nHsK5VwY08BWqAhn
         7NI7DaUvx1FCL5DrXBh6v8q1oYGCh0x1zOFuxHNZf6raalFLffgeTkATy/Id+kBN0d2o
         LQpPPUFohezqQpW2aTNhnQIwYcYx1h2qA6C2bjcZhkZq+anLQbnOeulxDfrGoybLpiiA
         wVSeUeGsAaCDvWY1ySq1eNmZEm8LOtyVHKkbPNCaGXMj1h0q5lOrkhBDLkGLbPzi2hUW
         kCs7eXLVrKVeXIMVFZHhSIDjhmGg/Mw1Z9AgjMeHjwTU++WLcvPhT8n6GdFTuIWBZ8pe
         cLDw==
X-Gm-Message-State: AOJu0YziT8lg6iOgw72bD2AgGYeIEM7DRlKELB+OR8NNKvW5qx2tSho0
	WLOJFObcFvH1t39VKbgLwpkm0WNBtS5HrZsBZSbkISr5EYIPxo85KMH1klegZK3gszYr5keh0Wl
	PUQ/1/BsRgC9g8XSI
X-Received: by 2002:a2e:8e2c:0:b0:2b6:a882:129c with SMTP id r12-20020a2e8e2c000000b002b6a882129cmr368385ljk.0.1694539196604;
        Tue, 12 Sep 2023 10:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYvAl8mkZSw+rnYnJ4h7+lp0LlwxrSNRmZEMF+AASojS3Iw1KmBdBhxOPisFdFkbbvN24S+A==
X-Received: by 2002:a2e:8e2c:0:b0:2b6:a882:129c with SMTP id r12-20020a2e8e2c000000b002b6a882129cmr368375ljk.0.1694539196239;
        Tue, 12 Sep 2023 10:19:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906044a00b0099d0a8ccb5fsm7161877eja.152.2023.09.12.10.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:19:55 -0700 (PDT)
Message-ID: <84f94417e79f3c4006441a1dc6e4b6f3c669a088.camel@redhat.com>
Subject: Re: [PATCH net-next 3/4] net: call prot->release_cb() when
 processing backlog
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  netdev@vger.kernel.org, Soheil Hassas Yeganeh
 <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, Yuchung Cheng
 <ycheng@google.com>,  eric.dumazet@gmail.com
Date: Tue, 12 Sep 2023 19:19:54 +0200
In-Reply-To: <CANn89iJs8u9HK2AYGcdxny8oC3jWGP6H-fNhm81Xcy19dUn9SA@mail.gmail.com>
References: <20230911170531.828100-1-edumazet@google.com>
	 <20230911170531.828100-4-edumazet@google.com>
	 <1d9d20d9e41b351114f4e09f2d394c4fa8f03403.camel@redhat.com>
	 <CANn89iJs8u9HK2AYGcdxny8oC3jWGP6H-fNhm81Xcy19dUn9SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-09-12 at 19:01 +0200, Eric Dumazet wrote:
> On Tue, Sep 12, 2023 at 6:59=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > On Mon, 2023-09-11 at 17:05 +0000, Eric Dumazet wrote:
> > > __sk_flush_backlog() / sk_flush_backlog() are used
> > > when TCP recvmsg()/sendmsg() process large chunks,
> > > to not let packets in the backlog too long.
> > >=20
> > > It makes sense to call tcp_release_cb() to also
> > > process actions held in sk->sk_tsq_flags for smoother
> > > scheduling.
> > >=20
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/core/sock.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 21610e3845a5042f7c648ccb3e0d90126df20a0b..bb89b88bc1e8a042c4ee4=
0b3c8345dc58cb1b369 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -3001,6 +3001,9 @@ void __sk_flush_backlog(struct sock *sk)
> > >  {
> > >       spin_lock_bh(&sk->sk_lock.slock);
> > >       __release_sock(sk);
> > > +
> > > +     if (sk->sk_prot->release_cb)
> > > +             sk->sk_prot->release_cb(sk);
> >=20
> > Out of sheer curiosity, I'm wondering if adding an
> > indirect_call_wrapper here could make any difference?
> >=20
> > I guess not much, and in any case it could be a follow-up.
> >=20
>=20
> I think it would make sense, particularly from release_sock()
>=20
> We have such a change in our kernel, for some reason its author never
> upstreamed it :/

Can be a follow-up, no need to resend the whole series, I'm applying it
now! The pw backlog is already scaring as is, I prefer the path with
less patches flying ;)

Cheers,

Paolo


