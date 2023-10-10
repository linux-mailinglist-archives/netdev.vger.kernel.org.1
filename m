Return-Path: <netdev+bounces-39627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEEA7C02DD
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19204281B45
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E20B38DDF;
	Tue, 10 Oct 2023 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym0Y3nKG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B2171C1
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 17:41:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91EA94
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696959669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yv35QJZetS2K7uo9ft/T0V3hanLhfr2MmPiIw/JxWXE=;
	b=Ym0Y3nKG04C92jBniJQq6F11fu1yjZpdSd5rd3QK3Cb6K/jVUCyligbiYl705QXjvgfenr
	Uw+dS8gmNlfJ7zwsO8lKSkiFerW9pgkSJT4hkwywwHZAM8mFzO7Gh+U8mT4j1zQkdzoCBM
	BzrwHJVh6g79PzL1WtAcbAWCQoCh5RY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-fIhev-U7N46CVlHLsL9_7Q-1; Tue, 10 Oct 2023 13:41:02 -0400
X-MC-Unique: fIhev-U7N46CVlHLsL9_7Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-53479f2bfb7so908636a12.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696959661; x=1697564461;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yv35QJZetS2K7uo9ft/T0V3hanLhfr2MmPiIw/JxWXE=;
        b=I0iaqhQ4daTqgRk+YbecNqpwg8nquMfAaPs07Cabd3CKhsZICXDFAXFnXN5jE4vwVs
         wZXxaLXHfi4Bg9jqbs9UnwHEHKXHKw7bOg7usyzlyAcqq4nbE1DzExwn4kPeKHyTpCFe
         ZIdQvMbSw+F3uo/njqfOh4nGtA5QzwZdSkzmr2XLNbH55cjgQrcJaP/8h4y6L0CQO7DJ
         XK5HL86m0oEDrHg4jEppsXkjBPGThphknnYT7TDKuCkjrw6iAgFn2Mjqdhfgpsftk/7B
         Z7nthaixQT3/WCUa8vXJBQORj6Xgfl2s9xZR4ee+qK116ZvTGOWSgZU6nIh7OJl6Sw+7
         MtMg==
X-Gm-Message-State: AOJu0YzhbrQV82gldHAysfti/4HUeaiNuxBGO72x1y0Mjc+bWYHc/eJK
	YEOrCcsG5uupahQdFhgs/gg8OtxmWu77HwSQahEzMTK81dCgY8iBeHhZTJiyA3Ksgc5Sptw4PdY
	9whVZeuhEdc+9dP9Qr3/241Jl
X-Received: by 2002:a17:906:20da:b0:9ad:e1e2:3595 with SMTP id c26-20020a17090620da00b009ade1e23595mr14846679ejc.7.1696959661251;
        Tue, 10 Oct 2023 10:41:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3JDCHMsapRZEz0siGbGB9Rn9s1ONofLSNYtQxI6ShAdrhZuPLiX0Hp6kOVCRCquQqM3e29A==
X-Received: by 2002:a17:906:20da:b0:9ad:e1e2:3595 with SMTP id c26-20020a17090620da00b009ade1e23595mr14846671ejc.7.1696959660938;
        Tue, 10 Oct 2023 10:41:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id l9-20020a170906230900b009928b4e3b9fsm8739316eja.114.2023.10.10.10.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 10:41:00 -0700 (PDT)
Message-ID: <6ad14b4726342f2a37e0f8e95e3d681c6659242b.camel@redhat.com>
Subject: Re: [PATCH net] tcp: allow again tcp_disconnect() when threads are
 waiting
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, David
 Ahern <dsahern@kernel.org>,  mptcp@lists.linux.dev, Boris Pismenny
 <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Date: Tue, 10 Oct 2023 19:40:59 +0200
In-Reply-To: <cdb77e7ecec83398ff7d92f7aeb20e0158146a28.camel@redhat.com>
References:
	  <1d0e4528ab057a246fd8c60b91cffd34f277b957.1696848602.git.pabeni@redhat.com>
	 <CANn89iKOZ89xhAsgXyygENOfRzXPhbFn4_PNdA3LUL0a5EYktA@mail.gmail.com>
	 <cdb77e7ecec83398ff7d92f7aeb20e0158146a28.camel@redhat.com>
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

On Tue, 2023-10-10 at 18:45 +0200, Paolo Abeni wrote:
> > On Tue, 2023-10-10 at 18:21 +0200, Eric Dumazet wrote:
> > [...]
> >=20
> > > > > > @@ -3092,6 +3092,7 @@ int tcp_disconnect(struct sock *sk, int f=
lags)
> > > > > >                 sk->sk_frag.offset =3D 0;
> > > > > >         }
> > > > > >         sk_error_report(sk);
> > > > > > +       sk->sk_disconnects++;
> > > >=20
> > > > Should we perform this generically, from the caller ?
> >=20
> > Ok, I'll do that in v2.

I have to touch both calls site in __inet_stream_connect(), and the
patch will still touch both mptcp and tcp disconnect - reverting the
bits from 4faeee0cf8a5. The patch will not be smaller, but the
resulting fix will centralized in single place. I guess it's still
worthy.

Cheers,

Paolo


