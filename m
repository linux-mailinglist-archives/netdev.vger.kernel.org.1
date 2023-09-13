Return-Path: <netdev+bounces-33664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB8379F1C4
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 21:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621B72815A3
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 19:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7423DAD5A;
	Wed, 13 Sep 2023 19:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B8929CA
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 19:10:52 +0000 (UTC)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985C01999
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 12:10:51 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-450f8f1368cso109084137.1
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694632250; x=1695237050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGqF0140SIub6Cel6XdM2WxNot7TAxb5d7q16wQV9j4=;
        b=gTiCprZ3taRknNcgrlUffS3iZR2neCFNiLnDzCQ/ERNDLiYT/kVFeSX0RFGDJ8zG2H
         O5sdoZnYWgMyCcJOyMD4nZAM0MpiEGyA6BDDwTsndyZ1tk9KE3heVyA4cORikiA1oNom
         ckh/EiKRvcYC3RfpmzmQiirpWq7itqzSaVZPHEajhVKbJZfrv5kvA40BmnOvcbcGbwtI
         98b88TYFg88IMx4zV+3TfHgrLgavf7WiKBx2mRfTvNEYkfXh2pROd2NFgfRnm5vD+LJi
         n6lPcxF+RSN4i1m7NHpjNd1HhY5KtnevJNaZfHJP+CeOrhbBC4DulumNt9jfhGUutfHo
         rzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694632250; x=1695237050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGqF0140SIub6Cel6XdM2WxNot7TAxb5d7q16wQV9j4=;
        b=FTr1TE7CvM+YRXXNksPCiSLY7PsE4MjkM8sWEdNasMC7b91B5WHK4lTSyvSuPovwm7
         icDtn3MLxAfCgKsEdH0rBDY+wqGNGQqajh3H0M7W88E9VznaOuID2vvPBBPkaHui8aps
         vIMVtOn6AuHXzyeE9cSjBR35BmxFPSfbs+wJhUvgjJcEwoRJ7zpHeMXYFUNpPDoBqT/s
         3KFBMaXEWHPd+ofU/hh1QRU2pjraMmDv0mRp45KvGJ7DfstqtKbKFGPcY3vP/rKtnofF
         /som5dDOZqdhc92OGgYBIhtyRl74k6vPwQHm2U0XltD/BeT3BFqShO3fTTbKT+D33UPD
         fmpg==
X-Gm-Message-State: AOJu0Yyg67Zv2h0Gf+/iUFG+N9zzty0bvieYiw6eoRNXLpbuGgpAUynd
	hC2+TlNyOVEnQorYAd57iX2QCM+pQcAfnvWVXHnni/s5
X-Google-Smtp-Source: AGHT+IHwQbkfyfqQNJYzJX0QIlrW3BSfJ9TKghyVLBN09OWKfmEKr6c3Q4gIKptztc5pIr+G39QGYjanOnbRKjFNthc=
X-Received: by 2002:a67:f8c9:0:b0:44d:6320:b713 with SMTP id
 c9-20020a67f8c9000000b0044d6320b713mr3189606vsp.0.1694632250524; Wed, 13 Sep
 2023 12:10:50 -0700 (PDT)
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
 <CAF=yD-Lapvy4J748ge8k5v7gUoynDxJPpXKV8rOdgtAw7=_ErQ@mail.gmail.com> <CADKFtnRyqOiek24U0ePb1MFqM1oXnYWb4FEPr-=EjswmQFr=_A@mail.gmail.com>
In-Reply-To: <CADKFtnRyqOiek24U0ePb1MFqM1oXnYWb4FEPr-=EjswmQFr=_A@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 13 Sep 2023 15:10:13 -0400
Message-ID: <CAF=yD-LUE+dt=vGWS1eLQz_OOigHB4crBYPh1NkX=ZJMd24gDQ@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
To: Jordan Rife <jrife@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 2:04=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> > Please take a stab.
>
> To clarify, the plan is to:
>
> 1) Swap out calls to sock->ops->connect() with kernel_connect()
> 2) Move the address copy to kernel_sendmsg()
> 3) Swap out calls to sock_sendmsg()/sock->ops->sendmsg() with kernel_send=
msg()

Exactly.

> > If it proves at all non-trivial, e.g., in the conversion of arguments
> > between kernel_sendmsg and sock_sendmsg/sock->ops->sendmsg, then let's
> > submit your original patch. And I will do the conversion in net-next
> > instead.
>
> I'll give it a try and see how trivial the changes are.

Thanks!

> -Jordan
>
> On Wed, Sep 13, 2023 at 7:03=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
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
> >
> > If it proves at all non-trivial, e.g., in the conversion of arguments
> > between kernel_sendmsg and sock_sendmsg/sock->ops->sendmsg, then let's
> > submit your original patch. And I will do the conversion in net-next
> > instead.

