Return-Path: <netdev+bounces-281735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Iv1KbR98GlSUAEAu9opvQ
	(envelope-from <netdev+bounces-281735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:28:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06996481669
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D707F30BDD8B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB8D3D47A8;
	Tue, 28 Apr 2026 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EisHBqti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687693D5640
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366132; cv=pass; b=GVRsWLzWh3ZJZ+X1d1TPHJ0Dal7LITtW7k4Gln4s5xhZI44szcVy+U/MJ5aKNx4YWF3vGh7MXL5NE3qSDEz6dRp/4csRgcVbSknxxW/pgI5Q3hbntD576TFkQ1k6s/6XDf0APcFT+tIIuYCRO4r9Nv1he8pMsK105PVHNGoCVn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366132; c=relaxed/simple;
	bh=VRhMM2LGR+wIBMllyIF0J2z7j69YdN1/kz978pPyVKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARxerzQd+v9FY77R1XhDjCLvKpTuWXXG3LCXfYbGYRpBsuG/4Poea2M27onOBasjdx4tVBmcH1dBMCtc1a+o+VxKQDzwIhUmrCHZ+Y8cK3Fm0nx0YrY3UHgOGeV4uMM27CaGhRJoUzFNa6atE8vCQtJcpx291TwThuM+HN0mvQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EisHBqti; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65318dafbcbso11164992d50.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 01:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777366130; cv=none;
        d=google.com; s=arc-20240605;
        b=UiYQuxFoYscEBYVHmuwD04WmhdA4tXXJ9I6qB2APpE7gCBS40jzHTHR7kYMg+LGj3w
         hcf++hr3msJqQQXmpGRiMadmBGX7BRcBfehERqD+j30QFbNHXUtDIpafyTD1adCETvVW
         MNFCnrvdaXfPwl31wbdQOqC6Fa1MCGoyU9cqxwoVhMEwg6UpQ9ni04uB1+Kgr5tgKY+a
         DnmFTbZSJzC9kkhVLkFb9i41cxcF8NKMPvdbUzLMOlc7G1+E1h3E+UwFQRUMQ5JoRg9/
         DfThSSrMu7tpc+DyvdwyvA3FnBG/QqFTrTjp/StrHs6NCtAQHh2nM7IQJy3g+9kbrHBp
         nGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yydI7GK+fwc+1faQWgSoXDXU6AtCkvTHBDTfaZII9+Y=;
        fh=cvY+/dADeLTreY5+ANpXUGWhPYH8IreGEMTi/ucf9cM=;
        b=WwYV274AwpYx8GQNQIcUgCxiW2dUfQFYI7YtwDfmAK55sUGjZVK5ER0jPZuqcKgyoh
         6Q4QwhMW1yeGjuZ8BaZBaWY6FClxqzEpIu1KFtHiffbuHww798W9cpTU/jytJ4jr9ehl
         h90aXabbYG1l7NmV26Y4U7F4yE+nIvCxmJNBE7BZJS/7mYFNO0cje3kpjSp3hiw5+8+Q
         bapR8mfx5nhhST1/ik6/zjI8NbXUTAqkuasVIwZ2+V15ROV0II/WuL/rQqrAdMKKfTHY
         PVVg7NnnyaLXAiw8BL4968TdezS7JgGyllYwCfA+yfVvbx3+ozEQy4VJXCT20vYmEf+m
         ntwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777366130; x=1777970930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yydI7GK+fwc+1faQWgSoXDXU6AtCkvTHBDTfaZII9+Y=;
        b=EisHBqtiUP2L2QxMSz+v1L701SRx7HBlqQdrBWtR2lsOXgNMQuhnpMUPDHRPciOcjP
         +KgxKrdsLp9CodMqanGI5V4fbOuVeRX7LoTrYyku44h/I4jJ3JeHJN2eMyJwbOihcR7V
         gGGMoK98sIhWDAu3/fYAXT11X96igapNyBB066dhacCgghnOimhGB05cxrPBNYN4uu8L
         b5/ZeIT8M0uP4DAmFYU1ykPiTCQ1sAAeetne1dsAOystTRZPbWqJb+VvUvjhNKw4CQto
         bEL91a4PTPszGtddD1aYEGcQI7SVsCIzdGgvIplDd6POoSKzB53wTLKGkFdhWrdprDfn
         eDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366130; x=1777970930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yydI7GK+fwc+1faQWgSoXDXU6AtCkvTHBDTfaZII9+Y=;
        b=NfJ6ohgGTo+54bIQmbm8Il3BXqT7115b/DdgBxoB3KQFQ7cdNFrXkeJuWKCDvIOl3i
         P+qdG+paEc73cKZJ7c2fHFdg8pOt4LmK46dTwR21kewTRuT7NiNp1QFowXAX3EFP87NB
         acgL+M3giDSWrLdqGKYRUEWByL7mEg36wfQ2ZXGqtGQP5s+0QNKSTKNB+9bpu5/JjHPd
         a7qQMUC/Z0l+bXitoz1OyqiNkLgidQtWUVGDYpe1+KPkpOZciEQyHa3EbaiyNl6hCT4z
         5IHy4mlIagJFOW0eEH7hZfX/NKmUEPKWdVSYUK/udI71Shw5XQV2w0/8jYKbmTK6+5c9
         nA8g==
X-Forwarded-Encrypted: i=1; AFNElJ8lXOvdejJopbPgIBQ8bWtTD3Ny3MEBt264rUCFwIi6YtzY90wpFRyqorJ0aCiF8bumxWopbps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4NJZ17y3eYgWVrW23gWMJ9efkDJ7sn4PV36Ze/pWpZsW0/gXT
	iVEpEtq9fCaZPk6Dd4PAruho0nKn7uEoR+Z0mxA5A/ITC129oNXA1glC6s94borDtt4y7Mv+qVc
	qTnrzSwKCZSI/IblOmItDKK54cklbsAE=
X-Gm-Gg: AeBDiet5Xml4MtFydp9xCnvJEQzvX5sWxWx72uTVcS7XDrEK5mu0BgOtbm1p8zDwKBm
	aD4bapf53Zg7wecN7Oxe02fM3YnInLw5EUW6W67uSArxUwOAbiVlWzQT6Zg7VUffz9In8yFbZ5V
	ZR+owHUkX7iEY6GOSTvfP/RaSu1uqAW0xuGbUsOf7eVcnkVrhr67L3m3Y4N4gfXwX2MPs1Ezd54
	EFN0tTIgxOHvfSg22VdbNL8tpBNLPZlT1O77Ft/9DYDBjV/UjTT5uc3Zi0V5ZOM0AQtjEnN7FsC
	ax99uk68yv9WCKaUqTXsDoKFOuz11BO30yLDS17T5AYY6TkJUAsoowxHvp3uXuJqJsrbyE06OWa
	PPG0JRPs=
X-Received: by 2002:a05:690c:4c0e:b0:799:2b4c:1d49 with SMTP id
 00721157ae682-7bcf57a5595mr17832867b3.36.1777366130392; Tue, 28 Apr 2026
 01:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422021533.16987-1-kartikey406@gmail.com> <20260428005433.716529-1-kuba@kernel.org>
In-Reply-To: <20260428005433.716529-1-kuba@kernel.org>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 28 Apr 2026 14:18:38 +0530
X-Gm-Features: AVHnY4IwPJM-SFew3sU50bXQrF4f-kdcps_-GGc0o6SUtE4ZPnCcQBD7bJhfeNo
Message-ID: <CADhLXY5=1nb49jiZozZThSFj3nDj+COon4r2GET4y_6jZLeH4g@mail.gmail.com>
Subject: Re: [PATCH] net: phonet: fix BUG_ON() in pn_socket_autobind()
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, 
	syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	courmisch@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 06996481669
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281735-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,syzkaller.appspotmail.com,kernel.org,google.com,davemloft.net,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,706f5eb79044e686c794];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,mail.gmail.com:mid,syzkaller.appspot.com:url]

On Tue, Apr 28, 2026 at 6:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> net: phonet: fix BUG_ON() in pn_socket_autobind()
>
> This commit fixes a kernel crash in pn_socket_autobind() by checking
> the socket's bound state directly before calling pn_socket_bind(),
> eliminating ambiguous -EINVAL interpretation.
>
> Closes: https://syzkaller.appspot.com/bug?extid=3D706f5eb79044e686c794
>
> > pn_socket_autobind() calls pn_socket_bind() and treats
> > -EINVAL as a signal that the socket was already bound,
> > then uses BUG_ON() to verify it:
> >
> >     if (err !=3D -EINVAL)
> >         return err;
> >     BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
> >
> > However, pn_socket_bind() returns -EINVAL in multiple
> > cases:
> >
> >   1. address length too short
>
> The commit message lists "address length too short" as a cause of the
> BUG_ON crash, but is this accurate?
>
> Looking at pn_socket_autobind(), it always passes
> len=3Dsizeof(struct sockaddr_pn) to pn_socket_bind():
>
>     err =3D pn_socket_bind(sock, (struct sockaddr_unsized *)&sa,
>                          sizeof(struct sockaddr_pn));
>
> While pn_socket_bind() does have this check:
>
>     if (len < sizeof(struct sockaddr_pn))
>         return -EINVAL;
>
> This case cannot be triggered through pn_socket_autobind() since it
> always passes the correct length. The BUG_ON is only reachable through
> pn_socket_autobind(), so listing this as a cause seems misleading.
>
> Should the commit message be updated to remove case 1, or clarify that
> it's describing pn_socket_bind() in general rather than paths that can
> trigger the BUG_ON?
>
> >   2. socket not in TCP_CLOSE state
>
> Can case 2 (socket not in TCP_CLOSE state) actually trigger the BUG_ON
> crash with sobject still zero?
>
> The combined check in pn_socket_bind() is:
>
>     if (sk->sk_state !=3D TCP_CLOSE || pn_port(pn->sobject)) {
>         err =3D -EINVAL;
>         goto out;
>     }
>
> For the BUG_ON to fire, we need sk_state !=3D TCP_CLOSE while sobject
> remains zero (unbound). Looking at phonet state transitions:
>
> - pn_socket_connect() binds the socket before changing state
> - pn_socket_listen() binds the socket before changing state
> - pep_sock_accept() creates sockets with state=3DTCP_SYN_RECV but also
>   sets sobject
> - pep_ioctl(SIOCPNENABLEPIPE) checks sobject before changing state
>
> Is there a code path that changes sk_state to non-TCP_CLOSE without
> first binding the socket? The syzbot crash is real, but the mechanism
> described couldn't be verified. Could this involve a race condition or
> a different code path?
>
> >   3. socket already bound  <- only intended case
> >
> > When -EINVAL comes from cases 1 or 2, sobject is still
> > zero (never assigned), causing BUG_ON to fire and crash
> > the kernel.
>
> Given the issues with cases 1 and 2 above, is the explanation of the
> crash mechanism accurate? Case 1 cannot happen from pn_socket_autobind(),
> and case 2's ability to leave sobject at zero while triggering -EINVAL
> could not be verified.
>
> The syzbot crash is confirmed (RIP at pn_socket_autobind
> net/phonet/socket.c:213 via pn_socket_sendmsg), but could the commit
> message more accurately describe how the crash actually occurs?
>
> > diff --git a/net/phonet/socket.c b/net/phonet/socket.c
> > index c4af26357144..5a55e7d14e85 100644
> > --- a/net/phonet/socket.c
> > +++ b/net/phonet/socket.c
> > @@ -204,14 +204,14 @@ static int pn_socket_autobind(struct socket *sock=
)
> >       struct sockaddr_pn sa;
> >       int err;
> >
> > +     if (pn_port(pn_sk(sock->sk)->sobject))
> > +             return 0; /* socket was already bound */
> > +
> >       memset(&sa, 0, sizeof(sa));
> >       sa.spn_family =3D AF_PHONET;
> >       err =3D pn_socket_bind(sock, (struct sockaddr_unsized *)&sa,
> >                            sizeof(struct sockaddr_pn));
> > -     if (err !=3D -EINVAL)
> > -             return err;
> > -     BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
> > -     return 0; /* socket was already bound */
> > +     return err;
> >  }
>
> The fix itself is correct and removes the dangerous BUG_ON(). However,
> the pn_port(sobject) check is performed without holding any lock. Could
> a concurrent pn_socket_bind() race with this check? This is likely
> benign since pn_socket_bind() re-checks under lock_sock(), but is this
> the intended behavior?
> --
> pw-bot: cr



Hi Jakub,

Thank you for the detailed review!

You are correct on all three points. Let me address
each one:

1. Case 1 ("address length too short") is indeed
   impossible from pn_socket_autobind() since it
   always passes sizeof(struct sockaddr_pn). I will
   remove this from the commit message in v2.

2. Regarding case 2 (sk_state !=3D TCP_CLOSE with
   sobject =3D=3D 0), I verified this using the syzbot
   C reproducer. The exact path is:

     r0 =3D socket$kcm(AF_KCM, SOCK_SEQPACKET, 0)
     listen(r0, ...)
       =E2=86=92 sk_state =3D TCP_LISTEN, sobject =3D 0

     r3 =3D accept4(r0, ...)
       =E2=86=92 creates NEW socket r3
       =E2=86=92 sk_state =3D TCP_SYN_RECV  (not TCP_CLOSE!)
       =E2=86=92 sobject  =3D 0             (never bound!)

     sendmsg(r3)
       =E2=86=92 pn_socket_autobind(r3)
       =E2=86=92 pn_socket_bind() sees sk_state !=3D TCP_CLOSE
         while sobject is still 0
       =E2=86=92 returns -EINVAL
       =E2=86=92 BUG_ON fires!

   sobject is only set in two places:
     a. successful pn_socket_bind() =E2=86=92 get_port() assigns port
     b. pep_sock_accept()           =E2=86=92 copied from request

   Since r3 comes from accept4() on a KCM socket
   (not a PEP phonet socket), pep_sock_accept() is
   never called and sobject stays zero. So sk_state
   !=3D TCP_CLOSE and sobject =3D=3D 0 can indeed be true
   simultaneously.

3. Regarding the missing lock: the check:

     if (pn_port(pn_sk(sock->sk)->sobject))
             return 0;

   is performed without lock_sock(). A concurrent
   pn_socket_bind() could race with this read.
   However since pn_socket_bind() re-checks
   pn_port(sobject) under lock_sock(), any racing
   bind would be caught there. So the race is
   benign. I can add a comment clarifying this
   if desired.

I will send a v2 with an updated commit message
reflecting the above.

Thanks,
Deepanshu Kartikey

