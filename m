Return-Path: <netdev+bounces-33335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077C679D70A
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 19:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF65A281EB3
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4474424;
	Tue, 12 Sep 2023 17:01:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F41840
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 17:01:58 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780C71729
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:01:58 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-415155b2796so8981cf.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694538117; x=1695142917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+BLQpC1kpXGgGUJlaY8OdGNuhPZs1gCwTeTvnwzs9Y=;
        b=ot7SaOYXlAI3y5ghWG0w8aZoaA2C3otlTdQxr3OiKLiZ4yoy2rRKjEFsg3kZRUkFv/
         Bv5w1p3v+WzLgdUMgxE4v/kjE1BeoTzTdaGmRR7zmWZd/6c/sa92QhQJUHVALbA068/M
         /ACDZr3m2ZstBya4YLQIIgKOnL/9kRLV8h7LJsNhc2XeXUAVdEjYlORzC+2bC14wHaJI
         4NpgpRPuDkd6LGHUcjwKHdxjRukVRPI9LGuogM574CMq9EGDtRACxDdj2gmKgNvoSvaf
         sb9BsOW/vs2+4f3lET8kjHfCy0HUtNgvGYyYarUMEOzBfZgMMOmcGfItQnfBrpVR4KcS
         udpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538117; x=1695142917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+BLQpC1kpXGgGUJlaY8OdGNuhPZs1gCwTeTvnwzs9Y=;
        b=poOXE76rNSAgn/Zs40fGOe6IGVs1Kjz901ic7Oq9m3je5/gpRm705sRgRwmQKPsBuW
         27S0haE9n7YJ0HI7n2Aj5fzoKb+wq8isOHoSuFNaLj6runo3yeDTNa412vfDmRnWoelz
         JjWRU9Pmu6pzcIx2eNiKOBIsISXCNZBFZNudVTjGsfVJs29jOy5189Xuuu9+SoeA9XBk
         6AJaCOFrZGFFBtIJyBbrwnvLrH7jzhfHQrVJXEMeLDOKOroCnklcy4bNQT9OPzknJ1kK
         +Eh27O4SfOgKc6Mf+XKUobQ/gY/7ACNl6iBwezSxnmt/qMuilEHDK8o8rG/M2n3AciCN
         tBKw==
X-Gm-Message-State: AOJu0Yw/qU0VkIm52THhrbUMKIJJnCqYej+TWwE/Lw3MY+bbneyS0ZNl
	Xjn9ytlOjziOwC8bRvVAk6V3tG+U2n7ncZexi0/24g==
X-Google-Smtp-Source: AGHT+IFSuIdIredxGcsLbiSkNCToB64oATteosR+Fbl8o9rWkSviNReXuaWTw3b6Jv3pFW5GoCGBfb47CFL75OdPZUg=
X-Received: by 2002:a05:622a:15d1:b0:410:88dc:21b with SMTP id
 d17-20020a05622a15d100b0041088dc021bmr330278qty.26.1694538117384; Tue, 12 Sep
 2023 10:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230911170531.828100-1-edumazet@google.com> <20230911170531.828100-4-edumazet@google.com>
 <1d9d20d9e41b351114f4e09f2d394c4fa8f03403.camel@redhat.com>
In-Reply-To: <1d9d20d9e41b351114f4e09f2d394c4fa8f03403.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 12 Sep 2023 19:01:46 +0200
Message-ID: <CANn89iJs8u9HK2AYGcdxny8oC3jWGP6H-fNhm81Xcy19dUn9SA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] net: call prot->release_cb() when processing backlog
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 6:59=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2023-09-11 at 17:05 +0000, Eric Dumazet wrote:
> > __sk_flush_backlog() / sk_flush_backlog() are used
> > when TCP recvmsg()/sendmsg() process large chunks,
> > to not let packets in the backlog too long.
> >
> > It makes sense to call tcp_release_cb() to also
> > process actions held in sk->sk_tsq_flags for smoother
> > scheduling.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/core/sock.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 21610e3845a5042f7c648ccb3e0d90126df20a0b..bb89b88bc1e8a042c4ee40b=
3c8345dc58cb1b369 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -3001,6 +3001,9 @@ void __sk_flush_backlog(struct sock *sk)
> >  {
> >       spin_lock_bh(&sk->sk_lock.slock);
> >       __release_sock(sk);
> > +
> > +     if (sk->sk_prot->release_cb)
> > +             sk->sk_prot->release_cb(sk);
>
> Out of sheer curiosity, I'm wondering if adding an
> indirect_call_wrapper here could make any difference?
>
> I guess not much, and in any case it could be a follow-up.
>

I think it would make sense, particularly from release_sock()

We have such a change in our kernel, for some reason its author never
upstreamed it :/

