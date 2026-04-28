Return-Path: <netdev+bounces-282060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE73B2AP8WmXcQEAu9opvQ
	(envelope-from <netdev+bounces-282060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:49:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA02B48B59C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 21:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 356B7300A7F0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3AD3A6F08;
	Tue, 28 Apr 2026 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sFdoelWr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD8381B1F
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405527; cv=pass; b=mWcKZLUTViKk5ALmM43dK3P+jOIdli4QUYRppPrW2uLB8ZetLEn7xwaiXaEZU5NVbYiWrzzu+vJ0nMdqTSgxPZ71yeX+Gld69R0t/SoCuQCsjFTcykKGkaaqyddOXdc/BN0G1CI98yvhHMlOkOKX/I6Y3rtD2akWRRe8c6L5sIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405527; c=relaxed/simple;
	bh=niTCSYgXiuK52f4OJc1x6IbOfcZREZ6j2c3HGQ8Hcq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOXUvRs0VEEu06BpOEHU1PltXgg0+Wy4RLV2UId1dm9W/EEL3PkAz9MiS1DO9CYfZ5bQsdL6VeCYeqbqFN2UV7Tusg5tngWYBmFNaTErdYUCQ4zbylwoWEZG2/+TRUsucCv8Ee0GuuKXV0HNYecPuQFjyPSWDvEr/XnbMwBSxFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sFdoelWr; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c726f46baso15177754c88.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 12:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777405525; cv=none;
        d=google.com; s=arc-20240605;
        b=UZJFwuKclKtLz8kA55e+p+DULqV7NSLMO3G9la7oQJ/QquiwO/e8b0EOU/s2jmdRn5
         hSun14KbHH5E5Jta3yFwtZ6RTXifDfyqlbmGBv48ilkTO2XrRJ0UJp9XMYu/x1Twsazt
         uAoU99PMt6S3Du1K1gNj9kfQZFDdEJ5DYubb14xVMp/bC310nzF+96T771b/G3i8C7Bc
         HoBgRCLbHKfkBfCsdGzM1ZSn3ri7fOnJJ8Pxr1w+ln6PfXGkY8oK4NlEnbtunJU29yyB
         GrKAO8qcRSh5SOAfOEVfWfZ/pMyilCZAMYZq9UbZOgytK5hNhPD4XUuzkMzJ73fCsixq
         YBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yyV3MujfaBj/kLXiIUgXJ2Am8aJcc81DIFMhB75KLDk=;
        fh=VQSH2zGr4LOaUWAe0VJ2EN24npfjMiEWHtDf8pNUtQk=;
        b=Gs2RmrBO8l6zUSPBBSFyVoMPFuBAa/3m2dFwsRZ5W+GSB24OPBHZOZXSp/vQk+AXYH
         5UnJ9hUD3TBjeRLiqw3/+IYO465I8F5RNZIGyXJymb7y63GPH0//T8PHQ+rOhFCdvmAR
         c5Nt5vVGbyx0/yvHUevJ+F/JpFCgu1gOkU/PW1NbS/fqqklAu2Zn9mwZBhQApCsGc3Gc
         /HWNnYhVLCiE9iT0fPBm4r/cYrBsWf3ZCnyEZ7VVMkmULOKfd9Nke27rFQur4qEbURpR
         A4hG0wrgODgADPxvNl/RSrIUQxB1gnstIoURLQoM9VyrQ4CIQ4sSMxZe0mpzaLZXkCY4
         +wcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777405525; x=1778010325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyV3MujfaBj/kLXiIUgXJ2Am8aJcc81DIFMhB75KLDk=;
        b=sFdoelWrM+KQaplQf+z1vN+ZBA8iz8JjOxNM/nrpKfZKrlIc+qUohp8BpfBvI7myeQ
         oELTrCcUNgLtzFrJZ0Z0RbcfjQapTgkfZxkHa9Zf4jk5ov2oUJtRlSzpSHroFoFxbOQH
         ccbBZ5E0Bi2ale4mmj4V3L5EDzmvkmr4XrBfK96V7l3rZX91ehnJIFN9T6A33CDDzMJK
         wuXsiaO2QER23vzDSKqsaWKWdqHLpUeOlfIMO3/npregB86DIHbRaDk2wnRttfWAH2cr
         L+8O6ce1a/QVEd5/T5qYRQsTe/zX77gfiBpAYaAXumDSgTdaRSBz9BAtyVSjpDeB2MJG
         dl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777405525; x=1778010325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yyV3MujfaBj/kLXiIUgXJ2Am8aJcc81DIFMhB75KLDk=;
        b=b/OCtZMMzG/Hn+G8i+Rr6Tz9tWXWE4lwSSZkvWN5XeqksV9UIWqSSt8Hr8DwOck1qi
         Eg3aCIel1rg1DGpIlUPt5CiMrL9z1br5jsDWq2r/NsWCFAGrHtcEm7uv3LlrSNjuMe5/
         e7mbZhcaANqSRgOwmBoIvxELW+ziXiRLSqAyJxt7Va4/yOkJ1x1G3BUM5iTZmBnVtlNz
         fb+tuP2dI+djaCenLFdcdrDmyQqf2/lBv8Go2ceJhyrOqykRL9CxaVWTqBk9sbbe2P9/
         w8xWKcN6G5JMDR1zVuVRzyvBVuGfR06+j/nS6+ZXpjiGIiA0ykzHy5BbvH0V9I9XVRYO
         52sw==
X-Forwarded-Encrypted: i=1; AFNElJ+kfyDFoI/X8tzWWjJzCYD8H13fqew33UrUXblUCsAJ4i+PJSF3+HydxMHNYm+U/HiJ6/RUvvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyvHjVVFX8aYMs45feNKvpxaatpZrIPvJgJb4etL2Nb0yskK2c
	xHsD+rVbKgQqEFg8aOdYAsPyYjHChUvzbRD4SzGSg+XE0Bivvr6tFHVybGpuE+BTcygvjhjy72n
	dUGoaaScxSSZLAzjlRZydTC33af1y1DYVbTnpI8rSjZjnjrQuM1v8Z/Qa
X-Gm-Gg: AeBDieu5SBD1WE2d8jAh4ANwLqf/H+B9cc6PEbURakIKYPO1LMmwZU5BWJzi3BUPV1b
	oPRDZ+ie/AZUUTEoycSJaQMj+LJMmk6OdzrVPl9Okdfn4QyZ2EpSqD9NFli93Y6Op51M2eQVXI5
	+pS9us2P81C3LXTeE/wQw/ADCM51s2vTBBWsftFDVP/+Glr5IZFwnEByTdOVjZgRQSwCxGn62P7
	ZkWyq8BYYFenvg98IWEuZMcqmJua/tHYkrbRGZQp4BRYQa/2p8QqLKfNnmx09NUWtQhRvLD4Z5V
	ESEgToearj13l4k3Efj0H+qbttdLCJ8SHCR8GBXPpyDqBkt8jZfsZclOksG9GYpcn6yOUnJUG08
	M+ljlaOjovGndgdAPbGXrwcxDwonJIWECQ2MepbiJNMKad/4xvbPrrqpqtRSuoQNM/vp4EA==
X-Received: by 2002:a05:7022:43a6:b0:12d:b654:8176 with SMTP id
 a92af1059eb24-12ddd943b73mr1893851c88.1.1777405524558; Tue, 28 Apr 2026
 12:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANMuvJn15HHBrq8EEbhSfCk-Sn33WEEovRa-yVWF5huTKfoOYA@mail.gmail.com>
 <20260428055851.2204248-1-kuniyu@google.com> <CANMuvJngCeUSEZEkm-xSEEgiA-dVxqyuB4SJikw7ppePNYtm5Q@mail.gmail.com>
In-Reply-To: <CANMuvJngCeUSEZEkm-xSEEgiA-dVxqyuB4SJikw7ppePNYtm5Q@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Apr 2026 12:45:12 -0700
X-Gm-Features: AVHnY4KqtxnfmP7ASzTNuoAnjvIR_NTHQmk-5YncgKqDCRCIZZYvb7E_i-YEKmU
Message-ID: <CAAVpQUCueaur49EhBgHO-NsMV9Oxmu66mRjTqKvnVdHSYXZpgA@mail.gmail.com>
Subject: Re: [PATCH] net: datagram: Drain queue before reporting EOF or ENOTCONN
To: Petr Malat <oss@malat.biz>
Cc: davem@davemloft.net, ebiggers@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BA02B48B59C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282060-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,man7.org:url,malat.biz:email]

On Mon, Apr 27, 2026 at 11:49=E2=80=AFPM Petr Malat <oss@malat.biz> wrote:
>
> On Tue, Apr 28, 2026 at 05:58:41AM +0000, Kuniyuki Iwashima wrote:
> > From: Petr Malat <oss@malat.biz>
> > Date: Mon, 27 Apr 2026 22:23:33 -0700
> > > If a packet is queued and RCV_SHUTDOWN flag is set after the function
> > > __skb_wait_for_more_packets() checked the queue, the function returns
> > > EOF, which is then propagated by __unix_dgram_recvmsg() and the user
> > > reads EOF although there is a message or messages still pending.
> > >
> > > The function should check if the queue is empty before returning EOF.
> > > As the same is true for disconnect and it's also reasonable for a pen=
ding
> > > signal, check in a common place before returning from the function.
> > >
> > > Signed-off-by: Petr Malat <oss@malat.biz>
> > > ---
> > >  net/core/datagram.c | 38 +++++++++++++++++++++-----------------
> > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/net/core/datagram.c b/net/core/datagram.c
> > > index c285c6465923..5952950f7233 100644
> > > --- a/net/core/datagram.c
> > > +++ b/net/core/datagram.c
> > > @@ -98,40 +98,44 @@ int __skb_wait_for_more_packets(struct sock *sk,
> > > struct sk_buff_head *queue,
> > >     /* Socket errors? */
> > >     error =3D sock_error(sk);
> > >     if (error)
> > > -           goto out_err;
> > > +           goto out;
> > >
> > >     if (READ_ONCE(queue->prev) !=3D skb)
> > >             goto out;
> > >
> > >     /* Socket shut down? */
> > > -   if (sk->sk_shutdown & RCV_SHUTDOWN)
> > > -           goto out_noerr;
> > > +   if (sk->sk_shutdown & RCV_SHUTDOWN) {
> > > +           error =3D 1;
> > > +           goto check_queue;
> >
> > We already have checked the same condition just above, and this
> > is a matter of timing.
> Yes, but both a message followed by RCV_SHUTDOWN can arrive after the
> condition has been checked and in which case returning the message
> must be prefered.
>
>
> > Even after the duplicated check is evaluated to false, there is
> > a small chance that the concurrent sendmsg() enqueues a new skb.
> No, there isn't, because the sendmsg checks the state and the sender
> gets error in that case. This is done udner a lock, so the situation
> you described is not possible, see unix_dgram_sendmsg():

Note the function is not AF_UNIX specific and reused by
a bunch of other protocols as skb_recv_datagram().


>   unix_state_lock(other);
>   ....
>   if (other->sk_shutdown & RCV_SHUTDOWN) {
>      err =3D -EPIPE;
>      goto out_unlock;
>   }
>
> > Considering __skb_wait_for_more_packets() is called only when
> > the queue is empty, it's not worth another round when shutdown()ed.
> This breaks the interface as POSIX is quite clear here:
>   If no messages are available to be received and the peer has
>   performed an orderly shutdown, recv() shall return 0.

Even if we think about only AF_UNIX, once the SEQPACKET peer
close()s, it triggers sock_error(sk) even though skb was queued before
__skb_wait_for_more_packets().  It seems "broken" in terms of POSIX,
but rather the application is too fragile if it's broken by a sudden close(=
)
by peer.  These are dgram-based sockets.

Except for close() (so not limited to AF_UNIX), if you see the race,
it means the application is calling shutdown() while recvmsg() is in
progress, and such an application must be prepared for the race
that it creates by itself, and that's how it has worked for decades.


> In this case messages were available, but 0 was returned. This
> behavior breaks even the simple example in unix(7), if you run it long
> enough (https://man7.org/linux/man-pages/man7/unix.7.html).

Example is just an example, even it doesn't use epoll.

>
> > > +   }
> > >
> > >     /* Sequenced packets can come disconnected.
> > >      * If so we report the problem
> > >      */
> > > -   error =3D -ENOTCONN;
> > >     if (connection_based(sk) &&
> > > -       !(sk->sk_state =3D=3D TCP_ESTABLISHED || sk->sk_state =3D=3D =
TCP_LISTEN))
> > > -           goto out_err;
> > > +       !(sk->sk_state =3D=3D TCP_ESTABLISHED || sk->sk_state =3D=3D =
TCP_LISTEN)) {
> > > +           error =3D -ENOTCONN;
> >
> > Also, the queue is always empty if SOCK_SEQPACKET sk is at TCP_CLOSE.
> In my opinion this is not true if UDS reconnects, see the code

See connection_based() above.


> at unix_dgram_connect(), section "If it was connected, reconnect.",
> where it sets TCP_CLOSE without checking the queue is empty. I haven't
> checked other cases as it's enough to have one to justify the change.
>
> Also, it makes the whole function simpler and one doesn't have to
> review all callers or be afraid a future change could break it.
>
> >
> >
> > > +           goto check_queue;
> > > +   }
> > >
> > >     /* handle signals */
> > > -   if (signal_pending(current))
> > > -           goto interrupted;
> > > +   if (signal_pending(current)) {
> > > +           error =3D sock_intr_errno(*timeo_p);
> > > +           goto check_queue;
> >
> > and we don't want to delay signal if it arrived first.
>  - We already do it anyway, if a signal followed by a message is
>    delivered before the initial queue check, the message handling gets
>    prefered.
>  - The signal is handled the same way, the only difference is the
>    user gets the message instead EINTR afterwards if he had a
>    nonrestartable handler set up. If the signal leads to the process,
>    termination, the syscal never returns. So, there is no delay.
>
> Regards,
>   Petr

