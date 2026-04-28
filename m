Return-Path: <netdev+bounces-281675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL+aOq1Z8GlQSAEAu9opvQ
	(envelope-from <netdev+bounces-281675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:54:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F1D47E4D8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17F41304047F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 06:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6BE35BDA4;
	Tue, 28 Apr 2026 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20251104.gappssmtp.com header.i=@malat-biz.20251104.gappssmtp.com header.b="a3zgV6qS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124034D4CE
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358972; cv=pass; b=PsNu2TEUr2/8NOtUPVVwfoVefb2IzT9MabSbXYPZzdumdWBJ2E/lRIiba5DOY2s47pt63BIfP8lGITisVwRvdAQQsr2ocEOQN2GH9Mdp+R7iqhfpCyCshLpw0C544/m5VWqnKZ1zTWN9rhSVLybaIRSvAhZHqm3/oPIT2Md5ZTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358972; c=relaxed/simple;
	bh=jeSg5Ab4TzoFOotcWl9HEqThRWRw9G51pvndq9Z+C6s=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rv3EqnToc/BwiRAypJRmDLOGNJW3cqF+yjGH50ZGinqr4dFQrFf5MSO3ttXXVTwQf0508SIFiFHiwSKDwD7t+GypC35I9ZjNWUHzg2niUeYfNpvOfY8p3v9FTEvQBNsVm+wjyPttgERgjgw2cpUzPhUmtNNJsvifSLJi/XGyc0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20251104.gappssmtp.com header.i=@malat-biz.20251104.gappssmtp.com header.b=a3zgV6qS; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94b07fddecbso6777241241.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 23:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777358970; cv=none;
        d=google.com; s=arc-20240605;
        b=gShEvIqn24baHGSYysKVUkPqAhhlMwNQ7Bpbeperzcp1Un4k7fvnnZFckWfW5/0A5b
         tJ71nLYPJdDZVSZBJRw6Lb1bZTk8t11e04BEIcVZCBLEjQlZcDS5SmmDrkZLb/tnEZCv
         lIwFCziBx1lO7C7ofWQdz6CAfLfnWKJjdfWOSkJE1qipvjQAujJ9CFMNEWV1e1cineG/
         rwCYHxUrSYERFWwOzBHaqNxN7z8z/AyNSQLCrbtZKzL3ZE55X5zqKDTZHKGa6233Ex62
         bgNZZUPTp5TcFQcpuKjJaESDQkWydUogbeWN1JVmbynIJqM3Btrt57c4LyeEdW41xiPK
         eFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=WsEnsIhUF6SmtnXrExeavz1mb3em4xsXcfdKGTWOgOA=;
        fh=gGq7rplNLwykkEppRzAEDDEU7l5AesQxuSMpratpGEw=;
        b=Q4vxcR9HBrVu98HZCZkI3R1kthIFHDmDLjef8G6QL66G3RziA2RLe6OafWPuHFv+X1
         o2hxMcyi7yD8ok7NINDV95FD2yBvcmfdNimu+2kLlAPZHq6DIMsneaU4bpU/kvgptJ2c
         VelETapqELkVJUjZqlE+YdFuJ1kpHDbWLuDw3LWiQ2qJ31QA9nLPxBZAMCNcqjtahnfx
         ogBJvFyiFEt3f0m24HZF8x3YhDlSFffyijgqpYS48g+7i9WWfQcfK9QrMhU/8SW+P990
         vhopPmBBJHYZMe/81NtggMPznOHXuIfFUtjyLaB2NnWxM+AtEQnvj3Z1Z6dtBD377GFW
         t4sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20251104.gappssmtp.com; s=20251104; t=1777358970; x=1777963770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WsEnsIhUF6SmtnXrExeavz1mb3em4xsXcfdKGTWOgOA=;
        b=a3zgV6qSjt5KzdJ5xYLTtrceLWGPCQU16qfdLX5AxqPoAUNDB1wAhFui/jk6+EH5xg
         heQ6KgqPsB5pWLiwbpPe7WNdOz/HrtNZ2LO+CMUydw5/D6ZBvzH4d8AT/6mL5p1f14TQ
         XU0kd2kgcO5jogMuVChvOT8cjCTrJmEs3fuDBjAb+CRTGplGoVHt9Gvat7/PtwjQ/8Xf
         JJVxnqwhngWhyQroZRPSV6bFiiCLeuqV5ifueaF7bBQfpw5Mhe+RyqaF7c+VxAxRr9pG
         NyEFy+gu/nttejont8/cRMFMqODGatMPapG7XgBrt0UeWX+VuyXzSUGUTavN2aVraT71
         orkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777358970; x=1777963770;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsEnsIhUF6SmtnXrExeavz1mb3em4xsXcfdKGTWOgOA=;
        b=KAa6aoQn4+qeTDhpOFBxo+6cuwPxApLZyHCAxSbiFMLnbRFGQedHeA9p633rLJpcm6
         saL/TY+ZEw+1ojOJr5ALrGy2h6UmseutJ48r7KXRR6B+swPPLgA4m5+sOoQ0LRva4IWy
         AHg1uIYqSYoRI0Md0+EVfb73Uv/45OZhIaE3lLzJWuqMvhUU+GVxrJ1vlkqkLuraL5BY
         j0Kv3S+5Lv8nWJZAfMrVaSmzsvrhYdemDz7SrT7ENyWvU8FGR1PhwXNMIpg1BpjySiJy
         XYjJPss3tCGXdUwWOSoaUwLJIXaUtd4iHmU4qDaRrMvrnfxxKKhBU+dyClcpkOA+QWtz
         Mguw==
X-Forwarded-Encrypted: i=1; AFNElJ+S5C9J1DDZH6sTchlzXRA91Ahl0Ofn6Gub4bezqTS8tA9At+OSdeQW7+J8szlWONkKCm/NqtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzom5jWqzizhkSvzll++d+7c3Z3eK1msaLZVTitUoQEjrvGHa4+
	cRX+1IUt7awFZlHhPRo4AaC98IZia+M6REtYSsRA8bdMtMSaisW+gGYStAvs7z6ymZHVk5o1nBG
	fRk/UEvkI6eSoCiBTMFbrYGl/lrxa+mOg6cOiIyX67va6cT9NrXxaRg==
X-Gm-Gg: AeBDiesChzwgHbrAAs581h57Idg0o+ZXE4Y/W55bLgOijaoBgtXzRR27aJMhEewwiut
	VRUlYJ+6sbi95mSwxTXshsgRIFW4vZbIJGyhNKQklcO++2jeUwnGCh4wcVMU3G1RqSIu1TWqpcZ
	hiaYkmqGk4iTBGQnfX+J+lg5Un/cp3Vnmanpdhnj9Dqd+Eo9pk0bbKYcum6IkL7HOqnm0jlk/Q7
	02pSkBQLI2XQSeBKtf0dRhAf60K+s0tknMobWKKLEjQOFow+7SanCQ+ZCS1+D3sW8P2pgzZxiuk
	64/Hz2K5TXkRt6jxZw==
X-Received: by 2002:a05:6102:3f05:b0:605:17b8:16dc with SMTP id
 ada2fe7eead31-6280afc8fa9mr569463137.20.1777358969768; Mon, 27 Apr 2026
 23:49:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 23:49:28 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 23:49:28 -0700
From: Petr Malat <oss@malat.biz>
References: <CANMuvJn15HHBrq8EEbhSfCk-Sn33WEEovRa-yVWF5huTKfoOYA@mail.gmail.com>
 <20260428055851.2204248-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260428055851.2204248-1-kuniyu@google.com>
Date: Mon, 27 Apr 2026 23:49:28 -0700
X-Gm-Features: AVHnY4IhA3jz1xVLjt0xkSIZ8si2PZss4CI5Quk2lppaIICOR_EQZuc-RFuOEhI
Message-ID: <CANMuvJngCeUSEZEkm-xSEEgiA-dVxqyuB4SJikw7ppePNYtm5Q@mail.gmail.com>
Subject: Re: [PATCH] net: datagram: Drain queue before reporting EOF or ENOTCONN
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, ebiggers@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 49F1D47E4D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[malat-biz.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[malat.biz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281675-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[malat-biz.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oss@malat.biz,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,malat.biz:email,mail.gmail.com:mid,malat-biz.20251104.gappssmtp.com:dkim,man7.org:url]

On Tue, Apr 28, 2026 at 05:58:41AM +0000, Kuniyuki Iwashima wrote:
> From: Petr Malat <oss@malat.biz>
> Date: Mon, 27 Apr 2026 22:23:33 -0700
> > If a packet is queued and RCV_SHUTDOWN flag is set after the function
> > __skb_wait_for_more_packets() checked the queue, the function returns
> > EOF, which is then propagated by __unix_dgram_recvmsg() and the user
> > reads EOF although there is a message or messages still pending.
> >
> > The function should check if the queue is empty before returning EOF.
> > As the same is true for disconnect and it's also reasonable for a pending
> > signal, check in a common place before returning from the function.
> >
> > Signed-off-by: Petr Malat <oss@malat.biz>
> > ---
> >  net/core/datagram.c | 38 +++++++++++++++++++++-----------------
> >  1 file changed, 21 insertions(+), 17 deletions(-)
> >
> > diff --git a/net/core/datagram.c b/net/core/datagram.c
> > index c285c6465923..5952950f7233 100644
> > --- a/net/core/datagram.c
> > +++ b/net/core/datagram.c
> > @@ -98,40 +98,44 @@ int __skb_wait_for_more_packets(struct sock *sk,
> > struct sk_buff_head *queue,
> >  	/* Socket errors? */
> >  	error = sock_error(sk);
> >  	if (error)
> > -		goto out_err;
> > +		goto out;
> >
> >  	if (READ_ONCE(queue->prev) != skb)
> >  		goto out;
> >
> >  	/* Socket shut down? */
> > -	if (sk->sk_shutdown & RCV_SHUTDOWN)
> > -		goto out_noerr;
> > +	if (sk->sk_shutdown & RCV_SHUTDOWN) {
> > +		error = 1;
> > +		goto check_queue;
>
> We already have checked the same condition just above, and this
> is a matter of timing.
Yes, but both a message followed by RCV_SHUTDOWN can arrive after the
condition has been checked and in which case returning the message
must be prefered.


> Even after the duplicated check is evaluated to false, there is
> a small chance that the concurrent sendmsg() enqueues a new skb.
No, there isn't, because the sendmsg checks the state and the sender
gets error in that case. This is done udner a lock, so the situation
you described is not possible, see unix_dgram_sendmsg():
  unix_state_lock(other);
  ....
  if (other->sk_shutdown & RCV_SHUTDOWN) {
     err = -EPIPE;
     goto out_unlock;
  }

> Considering __skb_wait_for_more_packets() is called only when
> the queue is empty, it's not worth another round when shutdown()ed.
This breaks the interface as POSIX is quite clear here:
  If no messages are available to be received and the peer has
  performed an orderly shutdown, recv() shall return 0.
In this case messages were available, but 0 was returned. This
behavior breaks even the simple example in unix(7), if you run it long
enough (https://man7.org/linux/man-pages/man7/unix.7.html).

> > +	}
> >
> >  	/* Sequenced packets can come disconnected.
> >  	 * If so we report the problem
> >  	 */
> > -	error = -ENOTCONN;
> >  	if (connection_based(sk) &&
> > -	    !(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_LISTEN))
> > -		goto out_err;
> > +	    !(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_LISTEN)) {
> > +		error = -ENOTCONN;
>
> Also, the queue is always empty if SOCK_SEQPACKET sk is at TCP_CLOSE.
In my opinion this is not true if UDS reconnects, see the code
at unix_dgram_connect(), section "If it was connected, reconnect.",
where it sets TCP_CLOSE without checking the queue is empty. I haven't
checked other cases as it's enough to have one to justify the change.

Also, it makes the whole function simpler and one doesn't have to
review all callers or be afraid a future change could break it.

>
>
> > +		goto check_queue;
> > +	}
> >
> >  	/* handle signals */
> > -	if (signal_pending(current))
> > -		goto interrupted;
> > +	if (signal_pending(current)) {
> > +		error = sock_intr_errno(*timeo_p);
> > +		goto check_queue;
>
> and we don't want to delay signal if it arrived first.
 - We already do it anyway, if a signal followed by a message is
   delivered before the initial queue check, the message handling gets
   prefered.
 - The signal is handled the same way, the only difference is the
   user gets the message instead EINTR afterwards if he had a
   nonrestartable handler set up. If the signal leads to the process,
   termination, the syscal never returns. So, there is no delay.

Regards,
  Petr

