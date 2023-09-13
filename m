Return-Path: <netdev+bounces-33657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C3E79F0DD
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 20:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4972814AA
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B51200BF;
	Wed, 13 Sep 2023 18:04:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF5E200BA
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 18:04:48 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5BA19AF
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:04:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-501bd164fbfso126608e87.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694628286; x=1695233086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNsgE5MDTbRQ5HIO/G/tH1SLpYyQIm/4XdiBisvcDVg=;
        b=rPqwWUHeK9VLVzqIU0nB++ocKrOzWdVPTahtNabWHSX5ZfdiHCeB8ptai/okg+t4gi
         8fKrex0Dl9k+RsbMBDpYJrnUMyJDOGXOrCmMgnNLsLsh2PJ/8OAR/RGpRtHeZZRlxm5x
         NM7oaKRk1EeY2XiEdN2iaZusAOrz6iBVYnbKBZcamKP5QhsQo39rl0ylig8eyrK8TZ4V
         C5Gm+Cpt3pZ3iJMEQZa/im4mlj6DE5JcE+fHt2WFcTZeaKuZacsSCkWSoSBLFrhuHWUx
         fWXzLuVLfL7JW9i9uz35iTjqUaTpipVaRTtN7rfbakFlVXBcJLShABWg86X4EuCQR6y7
         wPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694628286; x=1695233086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNsgE5MDTbRQ5HIO/G/tH1SLpYyQIm/4XdiBisvcDVg=;
        b=XFjhJ6unK0LOJ3xlLF6e2ahKpwUN8HAsCDWsVmC9/RdDvHp1DeGdBxBOFDhpmpy/C1
         gy4Ckti6vofQrs4NXLZ+gQl6VWT5fO8zsqDRuw6YR/YtwyuZuJfU352kvIo55ADmsThX
         DThZM4hK0SkG3Ku77YeWuk8mKVA5l+kcDPsfeznnSZhpWV6GG8LoNoFNB6lGik+PIjh5
         iypkwp+jgQ2p8yuqc3Kvvg6Ukngw6nDvgZ+Q1Xu1Fp+P2wHAMfkR9HQE9iJGLKsypmEI
         g1MIlZTP1mUoTY5tFe4aWqy6MkNpP70uPC2NfStqGreMQ5HKJEOWouwKOpFeqG9aih73
         jUDQ==
X-Gm-Message-State: AOJu0YwtsyvId7093bw+7Vcx5pTVGTZjnmygS1TKiBAYr5nKdrhs31bj
	NFMZ4tDcG2tpI8jY7vNHMyOSnzFZcpkqEm5kqAHllA==
X-Google-Smtp-Source: AGHT+IFkkEmySG5asgqEgvgZoofccFn96biiUHkRg+A6EwCjxx9cN2qIufD7u0GWLmpT29SxQW0dtd/DLMM/OIsZlSg=
X-Received: by 2002:a05:6512:21b1:b0:500:a08e:2fd3 with SMTP id
 c17-20020a05651221b100b00500a08e2fd3mr2175478lft.21.1694628285777; Wed, 13
 Sep 2023 11:04:45 -0700 (PDT)
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
 <CADKFtnTzqLw4F2m9+7BxZZW_QKm_QiduMb6to9mU1WAvbo9MWQ@mail.gmail.com> <CAF=yD-Lapvy4J748ge8k5v7gUoynDxJPpXKV8rOdgtAw7=_ErQ@mail.gmail.com>
In-Reply-To: <CAF=yD-Lapvy4J748ge8k5v7gUoynDxJPpXKV8rOdgtAw7=_ErQ@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Wed, 13 Sep 2023 11:04:34 -0700
Message-ID: <CADKFtnRyqOiek24U0ePb1MFqM1oXnYWb4FEPr-=EjswmQFr=_A@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please take a stab.

To clarify, the plan is to:

1) Swap out calls to sock->ops->connect() with kernel_connect()
2) Move the address copy to kernel_sendmsg()
3) Swap out calls to sock_sendmsg()/sock->ops->sendmsg() with kernel_sendms=
g()

> If it proves at all non-trivial, e.g., in the conversion of arguments
> between kernel_sendmsg and sock_sendmsg/sock->ops->sendmsg, then let's
> submit your original patch. And I will do the conversion in net-next
> instead.

I'll give it a try and see how trivial the changes are.

-Jordan

On Wed, Sep 13, 2023 at 7:03=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Tue, Sep 12, 2023 at 5:09=E2=80=AFPM Jordan Rife <jrife@google.com> wr=
ote:
> >
> > > If we take this path, it could be a single patch. The subsystem
> > > maintainers should be CC:ed so that they can (N)ACK it.
> > >
> > > But I do not mean to ask to split it up and test each one separately.
> > >
> > > The change from sock->ops->connect to kernel_connect is certainly
> > > trivial enough that compile testing should suffice.
> >
> > Ack. Thanks for clarifying.
> >
> > > The only question is whether we should pursue your original patch and
> > > accept that this will continue, or one that improves the situation,
> > > but touches more files and thus has a higher risk of merge conflicts.
> > >
> > > I'd like to give others some time to chime in. I've given my opinion,
> > > but it's only one.
> > >
> > > I'd like to give others some time to chime in. I've given my opinion,
> > > but it's only one.
> >
> > Sounds good. I'll wait to hear others' opinions on the best path forwar=
d.
>
> No other comments so far.
>
> My hunch is that a short list of these changes
>
> ```
> @@ -1328,7 +1328,7 @@ static int kernel_bindconnect(struct socket *s,
> struct sockaddr *laddr,
>         if (rv < 0)
>                 return rv;
>
> -       rv =3D s->ops->connect(s, raddr, size, flags);
> +       rv =3D kernel_connect(s, raddr, size, flags);
> ```
>
> is no more invasive than your proposed patch, and gives a more robust out=
come.
>
> Please take a stab.
>
> If it proves at all non-trivial, e.g., in the conversion of arguments
> between kernel_sendmsg and sock_sendmsg/sock->ops->sendmsg, then let's
> submit your original patch. And I will do the conversion in net-next
> instead.

