Return-Path: <netdev+bounces-56996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7B4811850
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0937DB2121B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1358534D;
	Wed, 13 Dec 2023 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3VbIYLV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA38B9
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:50:06 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so14831a12.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702482605; x=1703087405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK5AiyloDMi+9ASrKpn3cQfdNDrQYEM0tYKjuMEvWyU=;
        b=J3VbIYLVfX1bvq6hEtRbAOvX+e+tfTuy3uUkK68YSedDB3sJmMnnCy5wAU/tyXPhW5
         Hwr1ih0gUCy6tisYhezfvNM2wmM1UwFbXTZSHChQ2r0iwDtudfEugSTCNZDbuAv4ULJK
         ZLpykAdLZotzyj/fJ8vqWcBvxpOU7e3h6nU5x1TAz/QiSyVQo+0r5ZNGmfGkD7jeAL8d
         5wCuacsSG+6BEjDtiVOZ01XkgJXkEIwUTJtTYyveOUSc/56NoDKjaayMwn81EjeAcCXt
         fgur+2WWcvKbVsSksNmj5rm93Sq/dVDvi9OTmx/BTwOosKuinG8PTWdo6lQ81qQ3GUwQ
         bP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702482605; x=1703087405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK5AiyloDMi+9ASrKpn3cQfdNDrQYEM0tYKjuMEvWyU=;
        b=KHAsWmaEtRo4ijCMArNs3B6K9zluF+yrfZBsNvqZ6/swodAJ/QqaG9f/8+KUzXfq/E
         3Z1e4iW9SVH1mL5SmLx1JNCaiuoDmKjN3xH/HGSMgcqnLb4xnsXjSQ12+bxcPFLJKJJP
         QK4kTSPSTjE1WHcSVMOtpnsH/WqrE2CFVIYDUzpHRAiStgASUXhmKJy1TPbA468XL4qJ
         Rb+mnyxAd8Z2wb/My64m/RQDy9mrvbP5qIqUu0/JwVrRyIiVoknXOp3444mwYz0BA0G2
         /sOnHCVlys4AZB5Lcue27LIYou6uTBHrjz5i0rLttq0Ef+BX7SRM8ubQj+YHXpq0Fggi
         FMSw==
X-Gm-Message-State: AOJu0Yw4YwS7/m+i3rfEBKckCCIjxmDW4q9xS9v92JZ4V9bdzTHZmIOt
	QMvhH9qONVVxUGc3An7QTV5nITxNQU0rjCaFnAwUKw==
X-Google-Smtp-Source: AGHT+IGvYZD5igLED5RS/H4soZBhMPwReNLt7D0CLY/IlYJ9se289bVdzi/qg3VCtKv4vXf6f9TyCI+No3/LlaiJEfc=
X-Received: by 2002:a50:c082:0:b0:54c:9996:7833 with SMTP id
 k2-20020a50c082000000b0054c99967833mr502228edf.7.1702482604482; Wed, 13 Dec
 2023 07:50:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212145550.3872051-1-edumazet@google.com> <CADvbK_fiHwCXQZxOh7poK7gxv2t20D7KwR0Yi1wm7zWqHPN+6Q@mail.gmail.com>
In-Reply-To: <CADvbK_fiHwCXQZxOh7poK7gxv2t20D7KwR0Yi1wm7zWqHPN+6Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Dec 2023 16:49:50 +0100
Message-ID: <CANn89iJdFLHVYBvOMvsw9E-N=AOMKWNi62L5dPOxqECyCpbnuQ@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: support MSG_ERRQUEUE flag in recvmsg()
To: Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 4:19=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Tue, Dec 12, 2023 at 9:55=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > For some reason sctp_poll() generates EPOLLERR if sk->sk_error_queue
> > is not empty but recvmsg() can not drain the error queue yet.
> I'm checking the code but can't see how SCTP may enqueue skbs into
> sk->sk_error_queue. Have you ever seen it happen in any of your cases?
>
> >
> > This is needed to better support timestamping.
> I think SCTP doesn't support timestamping, there's no functions like
> tcp_tx_timestamp()/tcp_gso_tstamp() to enable it.
>
> Or do you mean SO_TXTIME socket option, and then tc-etf may
> enqueue a skb into sk->sk_error_queue if it's enabled?
>

I think this is the goal yes.

Also this prevents developers from using MSG_ERRQUEUE and having
the kernel read the receive queue.

mptcp had a similar issue in the past, Paolo fixed it.

> >
> > I had to export inet_recv_error(), since sctp
> > can be compiled as a module.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Xin Long <lucien.xin@gmail.com>
> > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > ---
> >  net/ipv4/af_inet.c | 1 +
> >  net/sctp/socket.c  | 3 +++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > index fbeacf04dbf3744e5888360e0b74bf6f70ff214f..835f4f9d98d25559fb8965a=
7531c6863448a55c2 100644
> > --- a/net/ipv4/af_inet.c
> > +++ b/net/ipv4/af_inet.c
> > @@ -1633,6 +1633,7 @@ int inet_recv_error(struct sock *sk, struct msghd=
r *msg, int len, int *addr_len)
> >  #endif
> >         return -EINVAL;
> >  }
> > +EXPORT_SYMBOL(inet_recv_error);
> >
> >  int inet_gro_complete(struct sk_buff *skb, int nhoff)
> >  {
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index 7f89e43154c091f6f7a3c995c1ba8abb62a8e767..5fb02bbb4b349ef9ab9c279=
0cccb30fb4c4e897c 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -2099,6 +2099,9 @@ static int sctp_recvmsg(struct sock *sk, struct m=
sghdr *msg, size_t len,
> >         pr_debug("%s: sk:%p, msghdr:%p, len:%zd, flags:0x%x, addr_len:%=
p)\n",
> >                  __func__, sk, msg, len, flags, addr_len);
> >
> > +       if (unlikely(flags & MSG_ERRQUEUE))
> > +               return inet_recv_error(sk, msg, len, addr_len);
> > +
> >         lock_sock(sk);
> >
> >         if (sctp_style(sk, TCP) && !sctp_sstate(sk, ESTABLISHED) &&
> > --
> > 2.43.0.472.g3155946c3a-goog
> >

