Return-Path: <netdev+bounces-287913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ItLF3alBWppZQIAu9opvQ
	(envelope-from <netdev+bounces-287913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:35:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B9C5406FD
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 922523036EB7
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C01D3859DC;
	Thu, 14 May 2026 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20251104.gappssmtp.com header.i=@malat-biz.20251104.gappssmtp.com header.b="OwlcHGNq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE04A37FF51
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754926; cv=pass; b=nn5QrH+cK4HT2r1hd2O3XzhkbgC/N06lNralTvEowEpi33pYAkASyvlmR2tRPwkerhJYTVQjHXXKUtSSOxt60d21bOWTzBvaVe5Kh2mpd2hLeIdrac5KZYd70M3nLrfD7se+6v8o21VwC5o22ESPUSdVV5CA7yc5vaGD3gduxdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754926; c=relaxed/simple;
	bh=5VZ60u3JAayyEgt5AnKKcO/F2qG6gqEE7NmxrRz8fn8=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXqS66LTzviZetZBwFSpmiIBqlZhnLDC+T1NW4CW5O6xbKewgye0dpzgDSoYqnv7+0RjcMp05ACiEnkX0ZoM6BslvQ+8W4m2lMHJG9qVpDHc7+JLnDd3Kw3WxAwNu7RdQa9gEOzP7mqJxD+M+WgQqRLMmVGrnyw006PQvNANcPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20251104.gappssmtp.com header.i=@malat-biz.20251104.gappssmtp.com header.b=OwlcHGNq; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-95fa7cd1392so758862241.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 03:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778754921; cv=none;
        d=google.com; s=arc-20240605;
        b=kLodSRTh4gyXONmYwNd6oaRcyMLNcrXOQpuaAWZx+harPP3daUQMsJhJLqf4wmPmOo
         x5Dv7YANb4kDK6yEEMz52Uh7sr+786pA/tihJbwMJkRQEpKa/GusPYdGtF7dS4nBkxRB
         hr/+BUhjSOHYV/kW6ciVh0WI8H2rHMsWHF98uPRq/Q6wTWw6OQaCDjgNbAY2mDHp4v8V
         NY9c2WqxoNxeqyHNtTp5aCht5sOTNDu5Kx8dxykx/Eqgl9kKW5Zpg017R6L73xvIIuB9
         yukjy14JxLgS4LZFuPpbtimOvQ0oo/shM9Up0VOFkH626zrkh4DgdipkEbNEknh2cuxQ
         Cb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=dPyh+U6NMeLlVndfBiu/Vj4PiJmRit4vloN/eJ/ylSU=;
        fh=cQtiWioVST8fxGGRryGaTDUxrKzjIlSvmHcC9yidyog=;
        b=d90lakfKfUrB39weW9LlR8v0b0d61W4JA1+qSFbgahwGdZS/qqzqOmmpr6kghGqU0Q
         aBHBLxpL0AI5b/b10XVteqt2KtqD8OXjOAVPZnKQIZokEH0CvWHnf4K6qjNsaTwzieI2
         RSy30BjNtTwdR2tOXMpQ/NP93N0YAWrBQYejGhQW3/rUCLQh1FsTfbSlHn3EhGN2RLbf
         /GMEdkMDzj4kw9UX7Wz7ULAIGLC8Pl02h+HkYMCc0M6oON4Zsa9AljwUIzn6Xn7jwdQY
         /Jv2Owl7qFRvLydXuyfp79mWR1Dxey2R2CJVr/BUp8qvb05YFpmNzACRsDbqxAwAXtWO
         DkJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20251104.gappssmtp.com; s=20251104; t=1778754921; x=1779359721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPyh+U6NMeLlVndfBiu/Vj4PiJmRit4vloN/eJ/ylSU=;
        b=OwlcHGNqERZygiN/fvlakQ2CqhlR82QS7lNEgUDt2iRt3qNU8iGcP0smQoausScXGl
         DDWO6oWgEVLTF5ZJ1ZYYaaEdPtZVa2uyJ29JftM0t/b6VsJaw3wEZodcrdJ+o08GDtzI
         JZVDWcGqjZ+1eE16ies714An1fFoRtVNs/pASTOk6WfSqAqHM4OOUoY5z0zfufI+vd6O
         KjLnKqZdJ66HdhePK5pqqhu21cjJzB7UollX/7RxaKCgrxKUNG6qUz1FlN/TAcXrdJhZ
         mTvo10wbhQwPVzENF7F+LVhWAAcr6RWbIEMJSSc3/+jQEH0Dypn5sJaVfuMUWzlef4r6
         TP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778754921; x=1779359721;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPyh+U6NMeLlVndfBiu/Vj4PiJmRit4vloN/eJ/ylSU=;
        b=gNIactnlR+Lcjqh9RboS6aSrnOjav0gX5PJB0ae06KAnVQn1Zk40qQhhGrgrvapAqe
         csEFHVMbWRGTekRwIy1dYjqKH3g2B110ux7g3ksk4hhWC7F/iMaCluROqc2fkv6rHB9E
         HsxGGGZefPhQH+ai9blIIsQ6lBzN7ycr7OFeE6z4ABfrPwxuoj93SAF1hTWztVwsIDzK
         WjCcMISdVb5D5pI3yn1UXRoj3z/cVIS9xSwuY/OToeDSENvYY3GykQWRrEFCzeARy6K9
         WwNuR8AyrXqYJ/uWylrVor1wSaVqnLMGquf9FZm+iY22xvvCZVo7+7+t2trtUgvwNDQ3
         EuDA==
X-Forwarded-Encrypted: i=1; AFNElJ/9yX9w8FbBA0WfDMM1yaoXW09Wa+dzTREbAIxT3uQELZB0an8zy2Bln4MWXbSjZYsQ7RhCRV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxMfrN9/tpDxkYXTb/KqcDKu/aqUWLymv8Pm22S82KnI0eBX2p
	a7MnDQ3x0rgtobtIVvSc32F5SPdrKrxh9X4EJOiMm9ngY4kXGyYG64cVy1a5XFjWM9sywFO98QP
	NNm0mVrxU0iesX2y+0gtKHW67yLwXA6palKxuIQOerPmNwW+q34I=
X-Gm-Gg: Acq92OEfqoX8t5lif9+g/7vASn7qqb7LjrgJHwO4CXYUcS+m0VkV2DYrJv6VF3EEXvp
	88zf93GZOQuzbHdh4EjxFuDjjtJKBQB1PxORLLxaY9v5cikoolJe32k/SEw2A1rpyRs7bc4DW72
	U5wNYAO00FAuY8nVHIe/25jdOiXXw1Ps44tLnBcymfRKMBBtmGLWYVQoZ5OjSq27T5zxSkBjORn
	wu3X1WROHMWzcoiLF/+R1Bj4O7h43shskG3XASBjA+H0bbJzcU1w0DKqDGLGIgWGauikeQ5D5x5
	MWtMUQ==
X-Received: by 2002:a05:6102:8544:20b0:639:1e8b:ecd9 with SMTP id
 ada2fe7eead31-6391e8beda7mr440037137.20.1778754921535; Thu, 14 May 2026
 03:35:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 May 2026 03:35:20 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 May 2026 03:35:20 -0700
From: Petr Malat <oss@malat.biz>
References: <CANMuvJn15HHBrq8EEbhSfCk-Sn33WEEovRa-yVWF5huTKfoOYA@mail.gmail.com>
 <20260428055851.2204248-1-kuniyu@google.com> <CANMuvJngCeUSEZEkm-xSEEgiA-dVxqyuB4SJikw7ppePNYtm5Q@mail.gmail.com>
 <CAAVpQUCueaur49EhBgHO-NsMV9Oxmu66mRjTqKvnVdHSYXZpgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAVpQUCueaur49EhBgHO-NsMV9Oxmu66mRjTqKvnVdHSYXZpgA@mail.gmail.com>
Date: Thu, 14 May 2026 03:35:20 -0700
X-Gm-Features: AVHnY4JvzFHxd6U4ARSZMFVNRmI6el4OXzYM4vSXb6aYa_L4_VV7TPrvqvC8m-0
Message-ID: <CANMuvJmLD3K8B-Noi=z0HP0H9eBquK8FoRYixJw_386Yhg5itQ@mail.gmail.com>
Subject: Re: [PATCH] net: datagram: Drain queue before reporting EOF or ENOTCONN
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, ebiggers@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C0B9C5406FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[malat-biz.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[malat.biz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287913-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[malat-biz.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oss@malat.biz,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,man7.org:url,malat-biz.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Tue, Apr 28, 2026 at 12:45:12PM -0700, Kuniyuki Iwashima wrote:
> On Mon, Apr 27, 2026 at 11:49???PM Petr Malat <oss@malat.biz> wrote:
> > On Tue, Apr 28, 2026 at 05:58:41AM +0000, Kuniyuki Iwashima wrote:
> > > From: Petr Malat <oss@malat.biz>
> > > Date: Mon, 27 Apr 2026 22:23:33 -0700
> > > > If a packet is queued and RCV_SHUTDOWN flag is set after the function
> > > > __skb_wait_for_more_packets() checked the queue, the function returns
> > > > EOF, which is then propagated by __unix_dgram_recvmsg() and the user
> > > > reads EOF although there is a message or messages still pending.
> > > >
> > > > The function should check if the queue is empty before returning EOF.
> > > > As the same is true for disconnect and it's also reasonable for a pending
> > > > signal, check in a common place before returning from the function.
> > > >
> > > > Signed-off-by: Petr Malat <oss@malat.biz>
> > > > ---
> > > >  net/core/datagram.c | 38 +++++++++++++++++++++-----------------
> > > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/net/core/datagram.c b/net/core/datagram.c
> > > > index c285c6465923..5952950f7233 100644
> > > > --- a/net/core/datagram.c
> > > > +++ b/net/core/datagram.c
> > > > @@ -98,40 +98,44 @@ int __skb_wait_for_more_packets(struct sock *sk,
> > > > struct sk_buff_head *queue,
> > > >     /* Socket errors? */
> > > >     error = sock_error(sk);
> > > >     if (error)
> > > > -           goto out_err;
> > > > +           goto out;
> > > >
> > > >     if (READ_ONCE(queue->prev) != skb)
> > > >             goto out;
> > > >
> > > >     /* Socket shut down? */
> > > > -   if (sk->sk_shutdown & RCV_SHUTDOWN)
> > > > -           goto out_noerr;
> > > > +   if (sk->sk_shutdown & RCV_SHUTDOWN) {
> > > > +           error = 1;
> > > > +           goto check_queue;
> > >
> > > We already have checked the same condition just above, and this
> > > is a matter of timing.
> > Yes, but both a message followed by RCV_SHUTDOWN can arrive after the
> > condition has been checked and in which case returning the message
> > must be prefered.
> >
> >
> > > Even after the duplicated check is evaluated to false, there is
> > > a small chance that the concurrent sendmsg() enqueues a new skb.
> > No, there isn't, because the sendmsg checks the state and the sender
> > gets error in that case. This is done udner a lock, so the situation
> > you described is not possible, see unix_dgram_sendmsg():
>
> Note the function is not AF_UNIX specific and reused by
> a bunch of other protocols as skb_recv_datagram().

I'm well aware of it, they either suffer from the same bug or there
is no functional difference caused by this change.


> >   unix_state_lock(other);
> >   ....
> >   if (other->sk_shutdown & RCV_SHUTDOWN) {
> >      err = -EPIPE;
> >      goto out_unlock;
> >   }
> >
> > > Considering __skb_wait_for_more_packets() is called only when
> > > the queue is empty, it's not worth another round when shutdown()ed.
> > This breaks the interface as POSIX is quite clear here:
> >   If no messages are available to be received and the peer has
> >   performed an orderly shutdown, recv() shall return 0.
>
> Even if we think about only AF_UNIX, once the SEQPACKET peer
> close()s, it triggers sock_error(sk) even though skb was queued before
> __skb_wait_for_more_packets().  It seems "broken" in terms of POSIX,
> but rather the application is too fragile if it's broken by a sudden close()
> by peer.  These are dgram-based sockets.
>
> Except for close() (so not limited to AF_UNIX), if you see the race,
> it means the application is calling shutdown() while recvmsg() is in
> progress, and such an application must be prepared for the race
> that it creates by itself, and that's how it has worked for decades.
>
>
> > In this case messages were available, but 0 was returned. This
> > behavior breaks even the simple example in unix(7), if you run it long
> > enough (https://man7.org/linux/man-pages/man7/unix.7.html).
>
> Example is just an example, even it doesn't use epoll.

So you say that behavior where the sender does
  send(A)
  send(B)
  close()
and receiver gets
  recv() -> A
  recv() -> EOF
  recv() -> B  # Yes, it realy receives a message after EOF
is correct and meets the interface description in manual pages or
the Posix specification.
  P.

