Return-Path: <netdev+bounces-94711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C4D8C04F4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 21:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 979F3B21814
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E686C130A72;
	Wed,  8 May 2024 19:26:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6D6A347;
	Wed,  8 May 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196403; cv=none; b=d2VRTf70A412uwg3ZzxI5SttLHIj4qwXNklLRqgAhPUhgcT+FuH5ORCEoJJc5jfStDKYUY+hOj98lxR5NcsLCwXlvzMLQDCVr5V/w9YWsfJJsELTQuk6GMeqr3mo6W25eDihtdGB5s9+r4kKgWSd7IkwwMTz/5Mbjs/ZLhiFrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196403; c=relaxed/simple;
	bh=LI8Wdu73HyhVGuk88SpDGd85xS3prBe90k0sDqhmi58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+kLA7PCBKjx9EI2TnimI2jdI9ciVtYMUbYJJOML1xdaoFoYfAwP2lTNPyogPbMWBM7XzfXXvK+TJAelITr9F2Yw+1OkYkoeA8l/Eo+DGeLERUdV2ztdB8mlhN2y+bG9zLyb5lF4eNbQTeAr6lBES1nAHp+eIEsDxxhR9fCh3pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a5f81af4so21293466b.3;
        Wed, 08 May 2024 12:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196400; x=1715801200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTeXUpbLMFzYH91bk5qDIYWQEdbPmjkqMnqa4yD1axU=;
        b=ATTZJGZwhbDUd3K0tkEyNwiwJy/hUDEYhaw4786fx3MIZEUsQpGxtvJpmu12d4IA3b
         /1lw/Cv+aan4JBIW7w1Lxd7n4GytECRblB3knVhsqacDHGaNwWuGpvjgjI4C/s7P69aJ
         4A6e7tAz/lNFuOjLt7THZRGuMAIucS3jjWmHwjReLM1x0xHfDeZEagBg4hap05BOfzAS
         YI62eXRtsqym5Jf5CdzQa/1BGtk2eS3rL3Gl7j+wpA2MnIxOZJcbDX/MGCTp4d5RUoX9
         5dsWutMTl6SfhJJTVq5WmY9uQ9jJ25xKkc0Geh9SKLKyW/cVXC7MBm4D8+BRHGW4sH+I
         KKsw==
X-Forwarded-Encrypted: i=1; AJvYcCUQqNjnKQPxAMm6NpIZML6sIPYXh2VqIWmcZns0NsqYArBBlYZeEKEkHeKaMqvKRBicoUQ/Wqq4s1z/xzvMVbzVvHlz9lhm3IWzgeUDjuI4e1GGqyaAgWexqsZAy5x99TTKUFBG
X-Gm-Message-State: AOJu0YxcG+xv4WoQ8Q+MecBcvPVlw1XC+hkZKASRki1inEuby4P6gBWy
	XOufLaPJ7gdRIsx3BI6J/PLjMHe1+3+ezsnWClRJM4Ay3I2W6KYQ
X-Google-Smtp-Source: AGHT+IHRH2OoDlddyXF11c7orEKW9KmOdG0KQem72KOTc91vxrgmylRU28l18cjWdplcQ8Q12lF7eQ==
X-Received: by 2002:a17:907:2084:b0:a59:be21:3575 with SMTP id a640c23a62f3a-a59fb9d95aamr228765466b.51.1715196400170;
        Wed, 08 May 2024 12:26:40 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id b18-20020a170906039200b00a59d9e71778sm3482960eja.111.2024.05.08.12.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:26:39 -0700 (PDT)
Date: Wed, 8 May 2024 12:26:37 -0700
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexander@mihalicyn.com, daan.j.demeyer@gmail.com, davem@davemloft.net,
	dhowells@redhat.com, edumazet@google.com, horms@kernel.org,
	john.fastabend@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, paulmck@kernel.org
Subject: Re: [PATCH net-next] af_unix: Fix data races in
 unix_release_sock/unix_stream_sendmsg
Message-ID: <ZjvR7YAxTmsX68Hl@gmail.com>
References: <20240508111749.2386649-1-leitao@debian.org>
 <20240508173324.53565-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508173324.53565-1-kuniyu@amazon.com>

On Wed, May 08, 2024 at 10:33:24AM -0700, Kuniyuki Iwashima wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Wed,  8 May 2024 04:17:45 -0700
> > A data-race condition has been identified in af_unix. In one data path,
> > the write function unix_release_sock() atomically writes to
> > sk->sk_shutdown using WRITE_ONCE. However, on the reader side,
> > unix_stream_sendmsg() does not read it atomically. Consequently, this
> > issue is causing the following KCSAN splat to occur:
> > 
> > 	BUG: KCSAN: data-race in unix_release_sock / unix_stream_sendmsg
> > 
> > 	write (marked) to 0xffff88867256ddbb of 1 bytes by task 7270 on cpu 28:
> > 	unix_release_sock (net/unix/af_unix.c:640)
> > 	unix_release (net/unix/af_unix.c:1050)
> > 	sock_close (net/socket.c:659 net/socket.c:1421)
> > 	__fput (fs/file_table.c:422)
> > 	__fput_sync (fs/file_table.c:508)
> > 	__se_sys_close (fs/open.c:1559 fs/open.c:1541)
> > 	__x64_sys_close (fs/open.c:1541)
> > 	x64_sys_call (arch/x86/entry/syscall_64.c:33)
> > 	do_syscall_64 (arch/x86/entry/common.c:?)
> > 	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> > 
> > 	read to 0xffff88867256ddbb of 1 bytes by task 989 on cpu 14:
> > 	unix_stream_sendmsg (net/unix/af_unix.c:2273)
> > 	__sock_sendmsg (net/socket.c:730 net/socket.c:745)
> > 	____sys_sendmsg (net/socket.c:2584)
> > 	__sys_sendmmsg (net/socket.c:2638 net/socket.c:2724)
> > 	__x64_sys_sendmmsg (net/socket.c:2753 net/socket.c:2750 net/socket.c:2750)
> > 	x64_sys_call (arch/x86/entry/syscall_64.c:33)
> > 	do_syscall_64 (arch/x86/entry/common.c:?)
> > 	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> > 
> > 	value changed: 0x01 -> 0x03
> > 
> > The line numbers are related to commit dd5a440a31fa ("Linux 6.9-rc7").
> > 
> > Commit e1d09c2c2f57 ("af_unix: Fix data races around sk->sk_shutdown.")
> > addressed a comparable issue in the past regarding sk->sk_shutdown.
> > However, it overlooked resolving this particular data path.
> > 
> > To prevent potential race conditions in the future, all read accesses to
> > sk->sk_shutdown in af_unix need be marked with READ_ONCE().
> 
> Let's not add READ_ONCE() if not needed.  Othwewise, someone reading
> the code would assess wrongly that the value could be updated locklessly
> elsewhere.
> 
> You can find all writers of sk->sk_shutdown do that update under
> unix_state_lock().
> 
> 
> > Although
> > there are additional reads in other->sk_shutdown without atomic reads,
> > I'm excluding them as I'm uncertain about their potential parallel
> > execution.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  net/unix/af_unix.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 9a6ad5974dff..74795e6d13c6 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2270,7 +2270,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> >  			goto out_err;
> >  	}
> >  
> > -	if (sk->sk_shutdown & SEND_SHUTDOWN)
> > +	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
> >  		goto pipe_err;
> >  
> >  	while (sent < len) {
> > @@ -2446,7 +2446,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
> >  		unix_state_lock(sk);
> >  		/* Signal EOF on disconnected non-blocking SEQPACKET socket. */
> >  		if (sk->sk_type == SOCK_SEQPACKET && err == -EAGAIN &&
> > -		    (sk->sk_shutdown & RCV_SHUTDOWN))
> > +		    (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN))
> 
> Here we locked unix_state_lock() just before accessing sk_shutdown,
> so no need for READ_ONCE().
> 
> 
> >  			err = 0;
> >  		unix_state_unlock(sk);
> >  		goto out;
> > @@ -2566,7 +2566,7 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
> >  		if (tail != last ||
> >  		    (tail && tail->len != last_len) ||
> >  		    sk->sk_err ||
> > -		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
> > +		    (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN) ||
> >  		    signal_pending(current) ||
> >  		    !timeo)
> >  			break;
> 
> Same here,
> 
> 
> > @@ -2764,7 +2764,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
> >  			err = sock_error(sk);
> >  			if (err)
> >  				goto unlock;
> > -			if (sk->sk_shutdown & RCV_SHUTDOWN)
> > +			if (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN)
> >  				goto unlock;
> >  
> >  			unix_state_unlock(sk);
> 
> and here.
> 
> Could you update the changelog and repost v2 for unix_stream_sendmsg()
> targetting net tree with this Fixes tag ?

Sure. I will keep the READ_ONCE only in unix_stream_sendmsg() then.

Thanks for the review!

