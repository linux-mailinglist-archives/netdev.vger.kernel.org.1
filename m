Return-Path: <netdev+bounces-33988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF97A123E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 02:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6085E1C20B05
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 00:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F94360;
	Fri, 15 Sep 2023 00:17:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA17E
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 00:17:35 +0000 (UTC)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88BB2102
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 17:17:34 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44d3666c6cfso830073137.3
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694737054; x=1695341854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQta8i7cVCPHIRjcaWw7a9MHqG3GlROhsQ+uYpuUJkI=;
        b=f6sx30iUoUI1KmxDCTtn+cG3MinRzeNQTuDPBphsZ1s8fnpOLbXkEsJsLTi3HpW/E2
         NjstSm55iUIxDq1T9lFqmjCqbq+QwXdJ0KfXCWfekW2wmc7jitzY1VtDTJjCKbDY8do8
         TYSTe1fUE7AMwBBfgcDCacwW9BESA9xKt9YWbujPyQBHjKdGgYZZL0nOB2c9vbSViFDh
         mjE9pL1jUwJrTy/+7MvkXorkTjhMkmglcw1eMEqNXH4WtilgHrXkbomQ0Pt5G3kBfbad
         JvgmqAsCaiPhADdxX9WWxoP3VKzbFyrzu+fp5ki2B1cSdYvhmIt0DRjFnMmVUp76G9Ck
         sbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694737054; x=1695341854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQta8i7cVCPHIRjcaWw7a9MHqG3GlROhsQ+uYpuUJkI=;
        b=b0Ym4WpHIe8eCmLpKKqzrQqVFXOtljNPa5pdgELYNhO1VYL5OIYi6vDcCUcLxcfkHc
         iqTcW57a9DbPW17rvER4Bn56UikiUjkejH9upc6OzhQA+as7rT5tg0cVUCahZrx7G1Lc
         LWtnNRxTHlNZN07zfczu2Jds+qu3bDLCvvoewdas+WCsc3m2vdnuNcC7gkdQZnDdAYxm
         z8BP1AxnF5wt7n9a9FqICq9h3HTBPx3SN0hQjBynZR8pkW3SaGgh0QFdz9z6QWp3dpjH
         sdBYxVRtVulKkSjLKXR79uyCKZ850wLhGCKGexM/pWpI0iqJEqwOHSpgA+NAeSrZ9COK
         Pk1w==
X-Gm-Message-State: AOJu0Yy4omH5E2la8C2k8EjB1U+mpmTAAMjUqEreqP6u4YygjOe+27gY
	K4A+iKM6Bu7NTekR1QyO1h+ax2jbVTVgnzOzG4g=
X-Google-Smtp-Source: AGHT+IELeOrfPp0j9CQJjoolTGTfLxo3+Ap/hHvAuhLpfha8PGoCgWnljiwfMfJVveCOIcq2iwk3ZRraYk8w7RbJMow=
X-Received: by 2002:a67:fd42:0:b0:44d:4a41:8945 with SMTP id
 g2-20020a67fd42000000b0044d4a418945mr251841vsr.8.1694737053846; Thu, 14 Sep
 2023 17:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912013332.2048422-1-jrife@google.com> <65006891779ed_25e754294b8@willemb.c.googlers.com.notmuch>
 <1ca3ca8a-6185-bc55-de74-53991ffc6f91@iogearbox.net> <CADKFtnTOD2+7B5tH8YMHEnxubiG+Cs+t8EhTft+q51YwxjW9xw@mail.gmail.com>
 <CAF=yD-KKGYhKjxio9om1rz7pPe1uiRgODuXWvoLqrGrRbtWNkA@mail.gmail.com>
 <CADKFtnSgBZcpYBYRwr6WgnS6j9xH+U0W7bxSqt9ge5aumu4QQg@mail.gmail.com>
 <CAF=yD-JW+Gs+EeJk2jknU6ZL0prjRO41Q3EpVTOTpTD8sEOh6A@mail.gmail.com>
 <CADKFtnTzqLw4F2m9+7BxZZW_QKm_QiduMb6to9mU1WAvbo9MWQ@mail.gmail.com>
 <CAF=yD-Lapvy4J748ge8k5v7gUoynDxJPpXKV8rOdgtAw7=_ErQ@mail.gmail.com>
 <b6ed0ef1346363f11ddc7bb1c390a5f03f3a6b89.camel@redhat.com> <CADKFtnTWU8L4JSL0hME=tMB7xst4ZoCQJgTt1XvtiP7Pn+7Swg@mail.gmail.com>
In-Reply-To: <CADKFtnTWU8L4JSL0hME=tMB7xst4ZoCQJgTt1XvtiP7Pn+7Swg@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 14 Sep 2023 20:16:56 -0400
Message-ID: <CAF=yD-KRbSeTugZ-tQKrY0BuchJeNjr5c=KZ=4QTr-zk9zWbHQ@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
To: Jordan Rife <jrife@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, netdev@vger.kernel.org, 
	dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 2:41=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> > 1) Swap out calls to sock->ops->connect() with kernel_connect()
>
> This is trivial, as expected. I have a patch ready that swaps out all
> occurrences of sock->ops->connect().
>
> > 2) Move the address copy to kernel_sendmsg()
> > 3) Swap out calls to sock_sendmsg()/sock->ops->sendmsg() with kernel_se=
ndmsg()
>
> This turns out to be less trivial. kernel_sensmsg() looks to be a
> special case of sock_sendmsg() with sock_sendmsg() being the more
> generic of the two:
>
> int kernel_sendmsg(struct socket *sock, struct msghdr *msg,
>   struct kvec *vec, size_t num, size_t size)
> {
>   iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size);
>   return sock_sendmsg(sock, msg);
> }
>
> It populates msg->msg_iter with a kvec whereas most cases I could find
> where sock_sendmsg() is used are using a bio_vec. Some examples:
>
> =3D=3Ddrivers/iscsi/iscsi_tcp.c: iscsi_sw_tcp_xmit_segment()=3D=3D
> iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, copy);
>
> r =3D sock_sendmsg(sk, &msg);
>
> =3D=3Dfs/ocfs2/cluster: o2net_sendpage()=3D=3D
> bvec_set_virt(&bv, virt, size);
> iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, size);
>
> while (1) {
> msg.msg_flags =3D MSG_DONTWAIT | MSG_SPLICE_PAGES;
> mutex_lock(&sc->sc_send_lock);
> ret =3D sock_sendmsg(sc->sc_sock, &msg);
>
> =3D=3Dnet/sunrpc/svcsock.c: svc_udp_sendto()=3D=3D
> iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> count, 0);
> err =3D sock_sendmsg(svsk->sk_sock, &msg);
> if (err =3D=3D -ECONNREFUSED) {
> /* ICMP error on earlier request. */
> iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
> count, 0);
> err =3D sock_sendmsg(svsk->sk_sock, &msg);
> }
>
> Maybe these two types are more interchangeable than I'm thinking, but
> it seems like it might be simpler to just do the address copy inside
> sock_sendmsg(). Does this revised plan sound reasonable:
>
> 1) Swap out calls to sock->ops->connect() with kernel_connect()
> 2) Move the address copy to sock_sendmsg()

That also covers normal user code that is already protected.

How about a __kernel_sendmsg that follows the sock_sendmsg API and is
a thin wrapper exactly for in-kernel callers.

> I also noticed that BPF hooks inside bind() can rewrite the bind
> address. Should we do something similar for kernel_bind:
>
> 1) Add an address copy to kernel_bind()
> 2) Swap out direct calls to ops->bind() with kernel_bind()

Good catch. Sounds like it.

At that point it might be worth splitting into three patches.

> -Jordan
>
> On Thu, Sep 14, 2023 at 1:24=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On Wed, 2023-09-13 at 10:02 -0400, Willem de Bruijn wrote:
> > > On Tue, Sep 12, 2023 at 5:09=E2=80=AFPM Jordan Rife <jrife@google.com=
> wrote:
> > > >
> > > > > If we take this path, it could be a single patch. The subsystem
> > > > > maintainers should be CC:ed so that they can (N)ACK it.
> > > > >
> > > > > But I do not mean to ask to split it up and test each one separat=
ely.
> > > > >
> > > > > The change from sock->ops->connect to kernel_connect is certainly
> > > > > trivial enough that compile testing should suffice.
> > > >
> > > > Ack. Thanks for clarifying.
> > > >
> > > > > The only question is whether we should pursue your original patch=
 and
> > > > > accept that this will continue, or one that improves the situatio=
n,
> > > > > but touches more files and thus has a higher risk of merge confli=
cts.
> > > > >
> > > > > I'd like to give others some time to chime in. I've given my opin=
ion,
> > > > > but it's only one.
> > > > >
> > > > > I'd like to give others some time to chime in. I've given my opin=
ion,
> > > > > but it's only one.
> > > >
> > > > Sounds good. I'll wait to hear others' opinions on the best path fo=
rward.
> > >
> > > No other comments so far.
> > >
> > > My hunch is that a short list of these changes
> > >
> > > ```
> > > @@ -1328,7 +1328,7 @@ static int kernel_bindconnect(struct socket *s,
> > > struct sockaddr *laddr,
> > >         if (rv < 0)
> > >                 return rv;
> > >
> > > -       rv =3D s->ops->connect(s, raddr, size, flags);
> > > +       rv =3D kernel_connect(s, raddr, size, flags);
> > > ```
> > >
> > > is no more invasive than your proposed patch, and gives a more robust=
 outcome.
> > >
> > > Please take a stab.
> >
> > I'm sorry for the late feedback. For the records, I agree the cleanest
> > fix described above should be attempted first.
> >
> > Thanks,
> >
> > Paolo
> >

