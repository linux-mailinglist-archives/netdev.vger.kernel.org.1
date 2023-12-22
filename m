Return-Path: <netdev+bounces-59946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDBD81CD76
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE921C21209
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFEA286B5;
	Fri, 22 Dec 2023 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gg4GBzNz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38F2554E
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso13400a12.1
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 09:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703264713; x=1703869513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suT3rRgCdZ72g5cYYKn0C20yE9EAeFYJlJ8TGpajvHU=;
        b=Gg4GBzNzBm12efBFQIsZh5+eHzc2buvpmKSk15OBOy6NPzsLWXTfPJG2cFxoN21Oq0
         oTDmVRfzfYZ/0uLCcV/mtxwD3OTiyDDN/dkk77WxjnA3GWHzj1wyHwPO9J8Xu8Mh1g9u
         UEM18noP3vW+gbceNPFj0yD1nKdQ+o3tKQTay8bp1tOJvVMJ8ZY2JhIl4TzXuCAbJDje
         S9deQ9rcfFjz63pt5cRMGQBJIBesk4+fE3d2M9pn6caQ/CUIK/zO+CZu8RoQ/e83RqHs
         gki3DtKCHUbTQAqC3TjJfdanf28UiodCwqQuBRo8RFkZNCcTUfuxo/ww0cz313vC/gXL
         UHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703264713; x=1703869513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suT3rRgCdZ72g5cYYKn0C20yE9EAeFYJlJ8TGpajvHU=;
        b=RmTNjU840qLPaiIcLfbu6KSwpK6PDdPd72xywuz9VLWwBbN0wkUhsXRsIUL5hyul4W
         DNqNNUJmTepODvtMUOF3KXdAjOxvjiwdzoO4vfxcu+FXh4A+AxtyQyAivg5mFXgiDdKU
         iNyglulRx4Ot34SID2Xlj1qoboJ0Q94/rw3gariRAKDbKKlvbZwiquXEo2M5m6+S9gWC
         SyaicKhKKUIV+EQp46NjbeiKeqX/EoguXiN9uB1bUzmDYpdQ+SxTtMcbodLf6r3w3HfJ
         27z4CbMA+IvuW2SIr9cXiQ+Vo46tsM2iE8KVg0mGv4gPv5ROiesVGNTkr/YxjslZbY/0
         fr9A==
X-Gm-Message-State: AOJu0YzplVeZw033LQZ2kasQFkGSKBDj6vN1VikqRaBjY9NxlC2ksIZV
	LgBbOhWdPctzonBpZUit9DMP997IYCrg8s/5vkMs5uZl+HkF
X-Google-Smtp-Source: AGHT+IGVZYTZt8K/6qsHfHXTAIqzF7GU9bRgBpioItOpJDdxHMExq54P4yO7KE1C3x5MnavFyTRv0sGeMt20TpodsoA=
X-Received: by 2002:a50:9310:0:b0:553:773b:b7b2 with SMTP id
 m16-20020a509310000000b00553773bb7b2mr150640eda.6.1703264713356; Fri, 22 Dec
 2023 09:05:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219170017.73902-1-edumazet@google.com> <CADvbK_e+J2nut4Q5NE3oAdUqEDXAFZrecs4zY+CrLE9ob8AtZg@mail.gmail.com>
In-Reply-To: <CADvbK_e+J2nut4Q5NE3oAdUqEDXAFZrecs4zY+CrLE9ob8AtZg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Dec 2023 18:05:02 +0100
Message-ID: <CANn89iJjAPmuT3ynBcoADkTs3e4V3=AY9=D+WDHMntQZ+typUA@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: fix busy polling
To: Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Jacob Moroni <jmoroni@google.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 5:08=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Tue, Dec 19, 2023 at 12:00=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > Busy polling while holding the socket lock makes litle sense,
> > because incoming packets wont reach our receive queue.
> >
> > Fixes: 8465a5fcd1ce ("sctp: add support for busy polling to sctp protoc=
ol")
> > Reported-by: Jacob Moroni <jmoroni@google.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > Cc: Xin Long <lucien.xin@gmail.com>
> > ---
> >  net/sctp/socket.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index 5fb02bbb4b349ef9ab9c2790cccb30fb4c4e897c..6b9fcdb0952a0fe599ae5d1=
d1cc6fa9557a3a3bc 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -2102,6 +2102,10 @@ static int sctp_recvmsg(struct sock *sk, struct =
msghdr *msg, size_t len,
> >         if (unlikely(flags & MSG_ERRQUEUE))
> >                 return inet_recv_error(sk, msg, len, addr_len);
> >
> > +       if (sk_can_busy_loop(sk) &&
> > +           skb_queue_empty_lockless(&sk->sk_receive_queue))
> > +               sk_busy_loop(sk, flags & MSG_DONTWAIT);
> > +
> Here is no any sk_state check, if the SCTP socket(TCP type) has been
> already closed by peer, will sctp_recvmsg() block here?

Busy polling is only polling the NIC queue, hoping to feed this socket
for incoming packets.

Using more than a lockless read of sk->sk_receive_queue is not really neces=
sary,
and racy anyway.

Eliezer Tamir added a check against sk_state for no good reason in
TCP, my plan is to remove it.

There are other states where it still makes sense to allow busy polling.


>
> Maybe here it needs a `!(sk->sk_shutdown & RCV_SHUTDOWN)` check,
> which is set when it's closed by the peer.

See above. Keep this as simple as possible...


>
> Thanks
>
> >         lock_sock(sk);
> >
> >         if (sctp_style(sk, TCP) && !sctp_sstate(sk, ESTABLISHED) &&
> > @@ -9046,12 +9050,6 @@ struct sk_buff *sctp_skb_recv_datagram(struct so=
ck *sk, int flags, int *err)
> >                 if (sk->sk_shutdown & RCV_SHUTDOWN)
> >                         break;
> >
> > -               if (sk_can_busy_loop(sk)) {
> > -                       sk_busy_loop(sk, flags & MSG_DONTWAIT);
> > -
> > -                       if (!skb_queue_empty_lockless(&sk->sk_receive_q=
ueue))
> > -                               continue;
> > -               }
> >
> >                 /* User doesn't want to wait.  */
> >                 error =3D -EAGAIN;
> > --
> > 2.43.0.472.g3155946c3a-goog
> >

