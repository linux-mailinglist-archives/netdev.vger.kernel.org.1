Return-Path: <netdev+bounces-59963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F1381CE82
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 19:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4633A1C2228E
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB3B24B20;
	Fri, 22 Dec 2023 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVoVyeMb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD852E822
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dbbc637df7so1055087a34.2
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 10:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703270061; x=1703874861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxNrboTNlNPG4tEs8nXf2sCjsXOevEdJHnwE94X0wkw=;
        b=mVoVyeMbpQjzKb3sGPTyFaKEWRni+VugkvpVyIqCZfWruAgGGYgi5em+qvywG4cRZi
         Ox2KFTTJg3PuIs/thSmHKSsUvLmkSMww/KlRCJwVT60cJ0+YZ+nbIV+wBw7BZx5kqVch
         3yTVboTZvukKwyd3gPlQYBekEfZmTosxJ6L/bhmqw8v0P8/jF8DKV6HO91u2If6GPVvf
         Uju16rP3Fo4THrUshOPUq400/+tQFoD7rPtk/X2NhOLFCcQYGzh8tU8h+Q6a3bnBdleC
         Vball5pXMmtVwE948vmywKImwpD/eMBP1GtUj8UVLjbPOJPCxqFiolLkHxkWqXrbw4Sq
         8J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703270061; x=1703874861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxNrboTNlNPG4tEs8nXf2sCjsXOevEdJHnwE94X0wkw=;
        b=QRYrGPX6lrJmGgrmKuuTWQ4+VeP78rUYlNKd4JxY0n5uYZ0DGBAzZ/XKPESbtKBGR2
         IufXyGk4gRoZUyx5cVaAgC4VZ1CpCqSlO0FfhN8U4PqFo5lpgIMrRPjqnjUaGWmSkbyJ
         4b6RuQJGQH1d+glkzQuAqdCbdahGL3B7yw97oX7f/AS4BZYJ4RPKWD3jlEkY5UatIAfF
         WjFJfkZgPu4voEOU4/FxPpPdH3li2mIWt8feoxauNomY5DAIx56uF1oYnhZ7K1/4y+I6
         q7KY4cUDosQ+NTXUzNpbFIfnLXnHpnacIagcw7BZr5I/DyTJSulMkINmg0MZrbsSEcsg
         CLUw==
X-Gm-Message-State: AOJu0YyNeQ1HqUjBYeaJtMRFUWBFnW7Io1TU0YD0Ie43nA8ixpxvMrhB
	K0cWGru1Cm/RcSPq0gWqhDOFhALymeczdlsxHWM=
X-Google-Smtp-Source: AGHT+IFwdoEruNd4rizWMBhHFASQ9AcJgQA8RDNMcsR0iX04g5D8a+oEwSqFVjJnVfIg8ieQk/1BPj3kn/x3AkbqtcM=
X-Received: by 2002:a9d:75c2:0:b0:6d9:ebaf:a5fa with SMTP id
 c2-20020a9d75c2000000b006d9ebafa5famr1611039otl.54.1703270060738; Fri, 22 Dec
 2023 10:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219170017.73902-1-edumazet@google.com> <CADvbK_e+J2nut4Q5NE3oAdUqEDXAFZrecs4zY+CrLE9ob8AtZg@mail.gmail.com>
 <CANn89iJjAPmuT3ynBcoADkTs3e4V3=AY9=D+WDHMntQZ+typUA@mail.gmail.com>
In-Reply-To: <CANn89iJjAPmuT3ynBcoADkTs3e4V3=AY9=D+WDHMntQZ+typUA@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 22 Dec 2023 13:34:09 -0500
Message-ID: <CADvbK_c5UJsufA2WwXRrw-X7wf-RQLnpPOV3YcbGBCeiAur65Q@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: fix busy polling
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jacob Moroni <jmoroni@google.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:05=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Dec 22, 2023 at 5:08=E2=80=AFPM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
> > On Tue, Dec 19, 2023 at 12:00=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > Busy polling while holding the socket lock makes litle sense,
> > > because incoming packets wont reach our receive queue.
> > >
> > > Fixes: 8465a5fcd1ce ("sctp: add support for busy polling to sctp prot=
ocol")
> > > Reported-by: Jacob Moroni <jmoroni@google.com>
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > Cc: Xin Long <lucien.xin@gmail.com>
> > > ---
> > >  net/sctp/socket.c | 10 ++++------
> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > > index 5fb02bbb4b349ef9ab9c2790cccb30fb4c4e897c..6b9fcdb0952a0fe599ae5=
d1d1cc6fa9557a3a3bc 100644
> > > --- a/net/sctp/socket.c
> > > +++ b/net/sctp/socket.c
> > > @@ -2102,6 +2102,10 @@ static int sctp_recvmsg(struct sock *sk, struc=
t msghdr *msg, size_t len,
> > >         if (unlikely(flags & MSG_ERRQUEUE))
> > >                 return inet_recv_error(sk, msg, len, addr_len);
> > >
> > > +       if (sk_can_busy_loop(sk) &&
> > > +           skb_queue_empty_lockless(&sk->sk_receive_queue))
> > > +               sk_busy_loop(sk, flags & MSG_DONTWAIT);
> > > +
> > Here is no any sk_state check, if the SCTP socket(TCP type) has been
> > already closed by peer, will sctp_recvmsg() block here?
>
> Busy polling is only polling the NIC queue, hoping to feed this socket
> for incoming packets.
OK, will it block if there's no incoming packets on the NIC queue?

If yes, when sysctl net.core.busy_read=3D1, my concern is:

     client                server
     -------------------------------
                           listen()
     connect()
                           accept()
     close()
                           recvmsg() <----

recvmsg() is supposed to return right away as the connection is
already close(). With this patch, will recvmsg() be able to do
that if no more incoming packets in the NIC after close()?

Thanks.

>
> Using more than a lockless read of sk->sk_receive_queue is not really nec=
essary,
> and racy anyway.
>
> Eliezer Tamir added a check against sk_state for no good reason in
> TCP, my plan is to remove it.
>
> There are other states where it still makes sense to allow busy polling.
>
>
> >
> > Maybe here it needs a `!(sk->sk_shutdown & RCV_SHUTDOWN)` check,
> > which is set when it's closed by the peer.
>
> See above. Keep this as simple as possible...
>
>
> >
> > Thanks
> >
> > >         lock_sock(sk);
> > >
> > >         if (sctp_style(sk, TCP) && !sctp_sstate(sk, ESTABLISHED) &&
> > > @@ -9046,12 +9050,6 @@ struct sk_buff *sctp_skb_recv_datagram(struct =
sock *sk, int flags, int *err)
> > >                 if (sk->sk_shutdown & RCV_SHUTDOWN)
> > >                         break;
> > >
> > > -               if (sk_can_busy_loop(sk)) {
> > > -                       sk_busy_loop(sk, flags & MSG_DONTWAIT);
> > > -
> > > -                       if (!skb_queue_empty_lockless(&sk->sk_receive=
_queue))
> > > -                               continue;
> > > -               }
> > >
> > >                 /* User doesn't want to wait.  */
> > >                 error =3D -EAGAIN;
> > > --
> > > 2.43.0.472.g3155946c3a-goog
> > >

