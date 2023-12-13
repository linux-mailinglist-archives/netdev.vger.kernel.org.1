Return-Path: <netdev+bounces-57064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3464811F43
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 20:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952FB280F1D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 19:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B068296;
	Wed, 13 Dec 2023 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxyUmjIU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E023DB7
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 11:46:16 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5b383b4184fso66290417b3.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 11:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702496776; x=1703101576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGKsejQjpWmJW+OpQJ3P7LbQVBAalczbUazFt3ddnlQ=;
        b=DxyUmjIUEE7OY6RDSQReTqVdqOoet0VtSgUeEqyeckw1jtdCcJFhMkuraKZ4frBYh8
         pD2vYwkGEL7d2fFDVKBVQy4if3dqUZCx1IuZESQk8B7hrKTvuRw3g9yDpKDvwroeEFOl
         k04KCTUvKVjpCEVAjuZNuXRfEG8qac3wkBH5kNkHSmVgWVUsUEogmtrSUoz06qCSX0/4
         7XfY61YTXzXdfnt5mTeZcaYssyvCnuSMdYr6+oE8xEZ0UE/hv+TXn0gMakrqgqD+SGhb
         17nxuBwMxBHYT9f6nvtk6hQycg3qtZfSDkAv5vPPA2i+qu08KMwUObOipeAvK2Ne4/MV
         3mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496776; x=1703101576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGKsejQjpWmJW+OpQJ3P7LbQVBAalczbUazFt3ddnlQ=;
        b=Kg0Q9d8GJQ/OF0ZlfjTBrC60F6fjqcmVRrXzO3UqgSaWPFFNf0rKBObTQQfEsUo6VM
         6hoX7eHbJgCo9sWxM8sOJNZCeDeRiXfVURaoEk8wFCICzdn27COWyhrCIu7HKY6Wd+VW
         YWrCF66BVEFrDUKGR4KVV8ySdXzMLJmS4Fv/F0zxDDZaNoZYrK0WI1NlrLP3qnvdh1mK
         ZlncYqen494IBO0p6LXt21nF/MfLZ3Uwp3ctgKyZzxIGHydZYtQVtVdu1cJxQpV9HoOf
         qfY/SyLfYW8UYUh4doWWLwZ84DpOdySJXlSBir1R7P2vmWf1vjk2Mz7Q+/9hluFCBu25
         55Dw==
X-Gm-Message-State: AOJu0YwTuRcq+cY4VZKe9h0ux4b0K+kimood90NaKpaW9t1/1UmmkbLC
	0bPUK2uh8d3E9di3txmU6EJv/ui/6govW3+IlbM=
X-Google-Smtp-Source: AGHT+IEMipKZK4qkmhkUtJukL5nLFICYEMH9VYg4kQEj3AXoVaalD/iaxx2eJpYu3iVw+rP2qYH0o4oewO/rxvI3JLg=
X-Received: by 2002:a0d:d68c:0:b0:5e3:4b6e:2d8 with SMTP id
 y134-20020a0dd68c000000b005e34b6e02d8mr437479ywd.5.1702496776032; Wed, 13 Dec
 2023 11:46:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212145550.3872051-1-edumazet@google.com> <CADvbK_fiHwCXQZxOh7poK7gxv2t20D7KwR0Yi1wm7zWqHPN+6Q@mail.gmail.com>
 <CANn89iJdFLHVYBvOMvsw9E-N=AOMKWNi62L5dPOxqECyCpbnuQ@mail.gmail.com>
In-Reply-To: <CANn89iJdFLHVYBvOMvsw9E-N=AOMKWNi62L5dPOxqECyCpbnuQ@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 13 Dec 2023 14:46:04 -0500
Message-ID: <CADvbK_ftVhUKqbDTyL6RHp3BU9GZpLZbY4Z+r5iV1meCvAa_QQ@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: support MSG_ERRQUEUE flag in recvmsg()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:50=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Dec 13, 2023 at 4:19=E2=80=AFPM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
> > On Tue, Dec 12, 2023 at 9:55=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > For some reason sctp_poll() generates EPOLLERR if sk->sk_error_queue
> > > is not empty but recvmsg() can not drain the error queue yet.
> > I'm checking the code but can't see how SCTP may enqueue skbs into
> > sk->sk_error_queue. Have you ever seen it happen in any of your cases?
> >
> > >
> > > This is needed to better support timestamping.
> > I think SCTP doesn't support timestamping, there's no functions like
> > tcp_tx_timestamp()/tcp_gso_tstamp() to enable it.
> >
> > Or do you mean SO_TXTIME socket option, and then tc-etf may
> > enqueue a skb into sk->sk_error_queue if it's enabled?
> >
>
> I think this is the goal yes.
>
> Also this prevents developers from using MSG_ERRQUEUE and having
> the kernel read the receive queue.
>
> mptcp had a similar issue in the past, Paolo fixed it.
>
> > >
> > > I had to export inet_recv_error(), since sctp
> > > can be compiled as a module.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Xin Long <lucien.xin@gmail.com>
> > > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > Cc: Willem de Bruijn <willemb@google.com>
> > > ---
> > >  net/ipv4/af_inet.c | 1 +
> > >  net/sctp/socket.c  | 3 +++
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > > index fbeacf04dbf3744e5888360e0b74bf6f70ff214f..835f4f9d98d25559fb896=
5a7531c6863448a55c2 100644
> > > --- a/net/ipv4/af_inet.c
> > > +++ b/net/ipv4/af_inet.c
> > > @@ -1633,6 +1633,7 @@ int inet_recv_error(struct sock *sk, struct msg=
hdr *msg, int len, int *addr_len)
> > >  #endif
> > >         return -EINVAL;
> > >  }
> > > +EXPORT_SYMBOL(inet_recv_error);
> > >
> > >  int inet_gro_complete(struct sk_buff *skb, int nhoff)
> > >  {
> > > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > > index 7f89e43154c091f6f7a3c995c1ba8abb62a8e767..5fb02bbb4b349ef9ab9c2=
790cccb30fb4c4e897c 100644
> > > --- a/net/sctp/socket.c
> > > +++ b/net/sctp/socket.c
> > > @@ -2099,6 +2099,9 @@ static int sctp_recvmsg(struct sock *sk, struct=
 msghdr *msg, size_t len,
> > >         pr_debug("%s: sk:%p, msghdr:%p, len:%zd, flags:0x%x, addr_len=
:%p)\n",
> > >                  __func__, sk, msg, len, flags, addr_len);
> > >
> > > +       if (unlikely(flags & MSG_ERRQUEUE))
> > > +               return inet_recv_error(sk, msg, len, addr_len);
> > > +
> > >         lock_sock(sk);
> > >
> > >         if (sctp_style(sk, TCP) && !sctp_sstate(sk, ESTABLISHED) &&
> > > --
> > > 2.43.0.472.g3155946c3a-goog
> > >
Acked-by: Xin Long <lucien.xin@gmail.com>

