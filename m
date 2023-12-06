Return-Path: <netdev+bounces-54374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6264A806CCD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD9E2819CD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468D30661;
	Wed,  6 Dec 2023 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKCVbjSn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0710A4
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:57:09 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so9984a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 02:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701860228; x=1702465028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzdUf4RM/Wx6idZfnPKuMR2zY1+EIoR42KUynHZ9RqM=;
        b=bKCVbjSn6gFdF0XR7ssz3rlLNNUZ3mt2g6NqgHmfx75l9wWb9jjgDSJ8/WvIcJliPt
         V08K+fUE3gtxw3QQDMFZQkKdL64FUrcLPYBht2Hb8FdpqFJDwqxbLZqjBVwHERSQkVdx
         6J+CPqopku/e/3Xn3InTTCoJSFvN0LAYRYofPC6USxI1NfryeKi2P65bLQJiTbY5zMe4
         fD71NLju77xCoa/rYT7tnhxGFj1rVoTvtST3K1uIzjDKie/RysPP3qorcBzNkvSZjbhq
         NFrTP0SOu5rKcyL/LxYTp0lJd9CiWQXHiSaaaYPErgJc4JS8sxQodExnwTUyBEjzPTEv
         rreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860228; x=1702465028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzdUf4RM/Wx6idZfnPKuMR2zY1+EIoR42KUynHZ9RqM=;
        b=JtByFWw+7uQA6K2kCUPKDuB9tEoxu4gMoa8hCkZh+4lGu7aqZERNBy85Kl4YfDbcAn
         945Qh8XikS2yLAjXQUGP51D6YcpV5Q7Pt9p77Y4kAqFsQCm/AsPKl9GWSCsji0TnihuG
         xCeLYvBi4HFPY4QX3b+32HEDTomyVlwjcHMx/i3F3rTaXfIQpC7f5KEVkpFeiS5HZoOe
         LfDLNB6NarMVtYgLvJEfW+5s8jnXzwxO/PluD/Pthj/jAI5p5YFWI0+xZBdkgCcZSy5n
         ZkUtnjAKWzNve7wMUYTdMnMeHSOcsOUpZ3Hdhc1gBGUCCxBOlQ84CzoJT/ynQYOTSguE
         kfhQ==
X-Gm-Message-State: AOJu0YxEeFaG5oIp32fAvO34q0NPlA2/a8oQrAYakAqp1PzoCSpM3ujW
	rHGS9o59+XyJZQq3leDSpyeCbXLUJpP5FaNIJvoXVQ==
X-Google-Smtp-Source: AGHT+IHG02AV1ZHEOBMffNoAhPhPdOKKQ+DJspsYX5CpklYuC5PAZV15ZTQ1Ea6pAft3Hn+Y8lp9T5/TrfnMLHTgD3g=
X-Received: by 2002:a50:baae:0:b0:545:279:d075 with SMTP id
 x43-20020a50baae000000b005450279d075mr55715ede.1.1701860227726; Wed, 06 Dec
 2023 02:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206041332.GA5721@ubuntu> <CANn89i+uXB__Bx7HAJt1Dg-P-cWyQUQk1SshE0jHjcTdODS9_w@mail.gmail.com>
 <20231206105251.GA7219@ubuntu>
In-Reply-To: <20231206105251.GA7219@ubuntu>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Dec 2023 11:56:53 +0100
Message-ID: <CANn89i+MuoTwc2A_BfKYcvrJ1vECJ+EVUtYiHLVfO_AFcg7Big@mail.gmail.com>
Subject: Re: [PATCH v2] net/rose: Fix Use-After-Free in rose_ioctl
To: Hyunwoo Kim <v4bel@theori.io>
Cc: ralf@linux-mips.org, imv4bel@gmail.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, linux-hams@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 11:52=E2=80=AFAM Hyunwoo Kim <v4bel@theori.io> wrote=
:
>
> Dear,
>
> On Wed, Dec 06, 2023 at 11:33:15AM +0100, Eric Dumazet wrote:
> > On Wed, Dec 6, 2023 at 5:13=E2=80=AFAM Hyunwoo Kim <v4bel@theori.io> wr=
ote:
> > >
> > > Because rose_ioctl() accesses sk->sk_receive_queue
> > > without holding a sk->sk_receive_queue.lock, it can
> > > cause a race with rose_accept().
> > > A use-after-free for skb occurs with the following flow.
> > > ```
> > > rose_ioctl() -> skb_peek()
> > > rose_accept() -> skb_dequeue() -> kfree_skb()
> > > ```
> > > Add sk->sk_receive_queue.lock to rose_ioctl() to fix this issue.
> > >
> >
> > Please add a Fixes: tag
> >
> > > Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> > > ---
> > > v1 -> v2: Use sk->sk_receive_queue.lock instead of lock_sock.
> > > ---
> > >  net/rose/af_rose.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
> > > index 0cc5a4e19900..841c238de222 100644
> > > --- a/net/rose/af_rose.c
> > > +++ b/net/rose/af_rose.c
> > > @@ -1316,8 +1316,10 @@ static int rose_ioctl(struct socket *sock, uns=
igned int cmd, unsigned long arg)
> > >                 struct sk_buff *skb;
> > >                 long amount =3D 0L;
> > >                 /* These two are safe on a single CPU system as only =
user tasks fiddle here */
> > > +               spin_lock(&sk->sk_receive_queue.lock);
> >
> > You need interrupt safety here.
> >
> > sk_receive_queue can be fed from interrupt, that would potentially dead=
lock.
>
> I want to change spin_lock to spin_lock_irqsave, is this okay?


Either spin_lock_irq() or spin_lock_irqsave() will work.

>
>
> Regards,
> Hyunwoo Kim
>
> >
> > >                 if ((skb =3D skb_peek(&sk->sk_receive_queue)) !=3D NU=
LL)
> > >                         amount =3D skb->len;
> > > +               spin_unlock(&sk->sk_receive_queue.lock);
> > >                 return put_user(amount, (unsigned int __user *) argp)=
;
> > >         }
> > >
> > > --
> > > 2.25.1
> > >

