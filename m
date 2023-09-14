Return-Path: <netdev+bounces-33954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CAD7A0D40
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 20:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F83B20B78
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 18:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DA1200B8;
	Thu, 14 Sep 2023 18:41:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1E14F6B
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 18:41:33 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D357710AE0
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:41:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ad8bba8125so178729666b.3
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694716891; x=1695321691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0mtUAsNARIEFeEqVcRHspGxeA0qzkFjDLaZzy4D/ic=;
        b=26NgGXQ6cJ6l6aJkIc1oz6jkqJLfHjO1pSxzU+GYHUrSCVLY/oOHT/KRmBZtgkIsbO
         es0cimjrjVWxjbaGn4jPW9KsUpsQJJyTxJ09viaxwINBgkIYvpeqVsuT92i2m+EOealh
         cggjFqUWQtGKqGUTOQYql6bgzcPJfXRB4BwAkZyxxbpA9zExboNzU2AgVwCgK+EYlcKf
         sTlbwFtNDkayQcIw1Lk/vPcmpwcisgqo1n7eelilxmOEFnAW8jqBusRdGJ2dPNPFT1HA
         GMsXtV8ypT0iNcBhDff7V8cy4GrN5XYBAI/bL8eN6Nc4tEOtxSrVtmH6f4cwIqXoccEj
         f5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694716891; x=1695321691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0mtUAsNARIEFeEqVcRHspGxeA0qzkFjDLaZzy4D/ic=;
        b=s0qhaf61aCmSBbMKbXrAIwyxpAhMBT/AajY2W1HSjYDmLpwpPS7XdjwxsFaz7Si8rD
         Q0ioxjWEAGZ5Z6QxOPFStZWRlMM24y5D8Or5MI/fFZ0QlOhtNDCowpoAZ/9HBLVZoCbm
         7o6fVhV67Dpe0Lqh4UFDixwM98dF6vh4/gJpxelyf9fNWqFSjCT9fqca9KWxsad8wU4K
         Mbte3tDhrRtweE7o9YPbBKAacjWOHQOy/u9y/0T7ysCE/FQv/0Z0oI91KOqqBmevhijb
         0O3mAX+HeqcUa1eRHjNWr1/ZkpYKQFMjNZvfE0AdBcXiQXE5eAA8kAhPHYjz5I//Swtb
         VMng==
X-Gm-Message-State: AOJu0Yy8Znxx89XY2DquvuJUI7YS44uYDfs0sMnerxZSHeQMkfQc4MpM
	JrvE1GFgJ9E4QcOMPEeobaHyZkLrLKfC+L5qGwjI9w==
X-Google-Smtp-Source: AGHT+IEOGdG2TKOVewXNH8o6rgEAZXLhwbO77JFUrisysf0TY1wt7r8YsTbcMIQjDQa53FLoS8RSwTiDds+EKaql8JQ=
X-Received: by 2002:a17:906:11a:b0:9a1:e994:3440 with SMTP id
 26-20020a170906011a00b009a1e9943440mr5113113eje.4.1694716891109; Thu, 14 Sep
 2023 11:41:31 -0700 (PDT)
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
 <CAF=yD-Lapvy4J748ge8k5v7gUoynDxJPpXKV8rOdgtAw7=_ErQ@mail.gmail.com> <b6ed0ef1346363f11ddc7bb1c390a5f03f3a6b89.camel@redhat.com>
In-Reply-To: <b6ed0ef1346363f11ddc7bb1c390a5f03f3a6b89.camel@redhat.com>
From: Jordan Rife <jrife@google.com>
Date: Thu, 14 Sep 2023 11:41:19 -0700
Message-ID: <CADKFtnTWU8L4JSL0hME=tMB7xst4ZoCQJgTt1XvtiP7Pn+7Swg@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>, kuba@kernel.org, 
	netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> 1) Swap out calls to sock->ops->connect() with kernel_connect()

This is trivial, as expected. I have a patch ready that swaps out all
occurrences of sock->ops->connect().

> 2) Move the address copy to kernel_sendmsg()
> 3) Swap out calls to sock_sendmsg()/sock->ops->sendmsg() with kernel_send=
msg()

This turns out to be less trivial. kernel_sensmsg() looks to be a
special case of sock_sendmsg() with sock_sendmsg() being the more
generic of the two:

int kernel_sendmsg(struct socket *sock, struct msghdr *msg,
  struct kvec *vec, size_t num, size_t size)
{
  iov_iter_kvec(&msg->msg_iter, ITER_SOURCE, vec, num, size);
  return sock_sendmsg(sock, msg);
}

It populates msg->msg_iter with a kvec whereas most cases I could find
where sock_sendmsg() is used are using a bio_vec. Some examples:

=3D=3Ddrivers/iscsi/iscsi_tcp.c: iscsi_sw_tcp_xmit_segment()=3D=3D
iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, copy);

r =3D sock_sendmsg(sk, &msg);

=3D=3Dfs/ocfs2/cluster: o2net_sendpage()=3D=3D
bvec_set_virt(&bv, virt, size);
iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, size);

while (1) {
msg.msg_flags =3D MSG_DONTWAIT | MSG_SPLICE_PAGES;
mutex_lock(&sc->sc_send_lock);
ret =3D sock_sendmsg(sc->sc_sock, &msg);

=3D=3Dnet/sunrpc/svcsock.c: svc_udp_sendto()=3D=3D
iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
count, 0);
err =3D sock_sendmsg(svsk->sk_sock, &msg);
if (err =3D=3D -ECONNREFUSED) {
/* ICMP error on earlier request. */
iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
count, 0);
err =3D sock_sendmsg(svsk->sk_sock, &msg);
}

Maybe these two types are more interchangeable than I'm thinking, but
it seems like it might be simpler to just do the address copy inside
sock_sendmsg(). Does this revised plan sound reasonable:

1) Swap out calls to sock->ops->connect() with kernel_connect()
2) Move the address copy to sock_sendmsg()

I also noticed that BPF hooks inside bind() can rewrite the bind
address. Should we do something similar for kernel_bind:

1) Add an address copy to kernel_bind()
2) Swap out direct calls to ops->bind() with kernel_bind()

-Jordan

On Thu, Sep 14, 2023 at 1:24=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2023-09-13 at 10:02 -0400, Willem de Bruijn wrote:
> > On Tue, Sep 12, 2023 at 5:09=E2=80=AFPM Jordan Rife <jrife@google.com> =
wrote:
> > >
> > > > If we take this path, it could be a single patch. The subsystem
> > > > maintainers should be CC:ed so that they can (N)ACK it.
> > > >
> > > > But I do not mean to ask to split it up and test each one separatel=
y.
> > > >
> > > > The change from sock->ops->connect to kernel_connect is certainly
> > > > trivial enough that compile testing should suffice.
> > >
> > > Ack. Thanks for clarifying.
> > >
> > > > The only question is whether we should pursue your original patch a=
nd
> > > > accept that this will continue, or one that improves the situation,
> > > > but touches more files and thus has a higher risk of merge conflict=
s.
> > > >
> > > > I'd like to give others some time to chime in. I've given my opinio=
n,
> > > > but it's only one.
> > > >
> > > > I'd like to give others some time to chime in. I've given my opinio=
n,
> > > > but it's only one.
> > >
> > > Sounds good. I'll wait to hear others' opinions on the best path forw=
ard.
> >
> > No other comments so far.
> >
> > My hunch is that a short list of these changes
> >
> > ```
> > @@ -1328,7 +1328,7 @@ static int kernel_bindconnect(struct socket *s,
> > struct sockaddr *laddr,
> >         if (rv < 0)
> >                 return rv;
> >
> > -       rv =3D s->ops->connect(s, raddr, size, flags);
> > +       rv =3D kernel_connect(s, raddr, size, flags);
> > ```
> >
> > is no more invasive than your proposed patch, and gives a more robust o=
utcome.
> >
> > Please take a stab.
>
> I'm sorry for the late feedback. For the records, I agree the cleanest
> fix described above should be attempted first.
>
> Thanks,
>
> Paolo
>

