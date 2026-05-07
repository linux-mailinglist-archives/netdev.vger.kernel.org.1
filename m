Return-Path: <netdev+bounces-285535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULuyKE4V/Wn+XQAAu9opvQ
	(envelope-from <netdev+bounces-285535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:42:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204F4EFDFB
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17081300DA51
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DC538F232;
	Thu,  7 May 2026 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1fKR+KA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B31340281
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778193738; cv=pass; b=nBnnEjkpp1v7x0dlymytMbNDJ/c1HiA3yYcvbDfKFTK2PjLlhx5Bu1ixNuwtRQXvZ2n9ZRapa3fmqUist3cWpSrVMszdVDqOCOJCATUyxkT+bsBbGIRO+p8lv1PguTmtAJXoL2NtBfY9lYFMinlBqK09T2xvziB5DrjCxc7eZkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778193738; c=relaxed/simple;
	bh=zj0EPkfkiO+sT3xDGh+CauR2qu+xNA60GPJ74ciA7hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6Pzz0k5SDFr5OWP6VTFf9hyLLVxKT1VG2Oe/PamrZ7JakAh0uT3EzS1v/BbL9BxuxY6S1hUo4Q2rLu5VPCffy11QZdt0DGAHRjq4LHGdgbFnZyNbUsN3NJMNmbhEVNjqNqkagP3KnfEn5BbzNkxqUhpBLgAHp7ZwWbOsNN58CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1fKR+KA; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c45281a06so2531393c88.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778193736; cv=none;
        d=google.com; s=arc-20240605;
        b=llatdgmraTiO38SF55Y5XLquanN4I8IbdXGXuC/nZoA4J2x3g8avdDjZSW+/9r6Gna
         dkEsrZQEmBEsT4KYttJkOO3awXCpWM92zn0rCKYwS81mPc/SssMo5NHKPIOhpX2NJAlW
         ZYsCEP8/0TP6a7ea/zYQx0fiUJTcyd60VB3xFjpJLqKwi/YalOCEyOq6PxQoQ4SslsRc
         8nGPDFboSpVZ/VnLtJfKFaDFZ7dWNOOKwsXfFh4M8i4eAU3U2HBvPK9bMSTYeevjs4wX
         LKBGSedw4bNTfemKXUCIETqlln4tNTS+otZd3VG0YroEkyPG0KHfNAmKhoViOwLOjlW3
         yK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NM3zpqpiPsJbaZPU06qMBy8NToD1MN4CXyLGnRlYyNw=;
        fh=9JWA41k2/DpZJuPWdCsL8+oAQkVFEq0oLDi5oYhTa9Q=;
        b=K+nuwc0SXgAQUdYhAD/TJs/l49KZnOKWtPEv8u/hou2aopprqjCZFz+UW3XN2PglAR
         wS3B20RptsFSiLq8dm3JYNPva0X/JtJ6uRnAWufGbWC8ZKP6SnkJWivpx4U/ipDtupEA
         2NXHJ2PEWiGnx5qW0h9PBU4EIlIlt55EvWX3QN7xPKOEJT8V5zEvN7s0YfSLAHN4QaO3
         qyb/rGN+bi7ZsskmADrr3zZsDS6hdPMiPgAY2IYY7zp/O4YDGp3mszrBE4M11XDvXwph
         +vqE6ZFbfogyBoM3ctZip/NCNTw28idyF5iHaSZxX4A1K8HPjOfGVruBknNaVR3eGF8z
         O84A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778193736; x=1778798536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NM3zpqpiPsJbaZPU06qMBy8NToD1MN4CXyLGnRlYyNw=;
        b=r1fKR+KAheSlMUu1k/+83zw77wFl2S9aFpW8BawwSIklXt6LjsQvUv5nyCCCQsUwBr
         LjjSQKoosnOj7JC3gUzIHZSudP1zgvqs5QSwq198SBE1NHiSLwG7q/euCFNxbjVUb0HL
         5MnwsOPu4QWZYSn+8GhR/XjVhLCmgHTWrRispIppyBNf+9iEfJcvM+SkeUgf2nn1F0/g
         zXGm6QWMEKON9762WojccCmEJUko6mD1g4Odm7IPiuNekBW+r1cXYpxydowVriHQ+IhY
         RvyAeKvagsdtOIX4ZyruT65+a8vS8i5Ht01D4HDAD3s1MLXiTqM38O3NO5OqZVuav/N6
         +hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778193736; x=1778798536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NM3zpqpiPsJbaZPU06qMBy8NToD1MN4CXyLGnRlYyNw=;
        b=ZOViMr+IH5OQ1CE6QGjm2iZolfhOiWNY5PAe4l2fi9d9RQGDRdS+LEr3yWzj/L4ooN
         YCmO8U8nUpCkcOFKdGVLOruOKjRitjNPKzjJke3NyAcnNWb4fXYUDsbxCwF5uGmvHs8J
         /FrREApJ4aL7w9z1P5cdwMwkAk/LRL4SbWvJkaPbok+em2g/BYpYb7XypI7XXWreMclL
         0sas+CYz2pjpZ214h0PMVYKh/aTYACItM0/7jce6h9UdifLqijddbqzjGqK9+rg9WCo6
         Xajh0SXKTC81njQNG2em+nudlkNGP4AEFukH3zbbEeZeTMoaEstfbtfl4FnNQfMYYe6m
         0r+A==
X-Forwarded-Encrypted: i=1; AFNElJ+v2o6sHW5vGnCKyBApDkCnPLnLyV9ogBUQmgc7/rIeUgivW+whtAWKZ/0GeNgg6INt9cPB8N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCrfvCls6PIdY+gc+DzHA8RFcqMUZwE380SfldFbpUGJwxEbN
	i8S5qXqfSVqWR0yo1gbTLVq/vYX6W0FCk2dusPPXmUozNfhCxiT+0YoAZ8MBHIVnSuq4Pm/EmN1
	R032F6eqPtWvFG5uYz1azwxOkBFEtFn8wpKE0a0xl
X-Gm-Gg: AeBDiesmixW2wXuHwLy90fSInbcPVm5nm9kNdp4CApRbWUUxNS1sj3FVWRuezm+lsDZ
	BZ0r2cPvFaiFOmZSsr9DUQnGqzlXTI/xcdyflJtJt8yws02MgwlW0SrgE1sz2yzY/G0wXa5Djhu
	En/eqGFn7Mf0G6C8cjXPeR/22Ir4kYQ8kUNI4rhs4s/Nl5IILEXj61o72lKKF0mFvTU9WQjo+dd
	caCCB00FltwcII/umQkxANr4rkIU+uX4Zb/uZHv9+qqOaXHbXeuYbNjz2elRWlIcz91f4Q62Zgz
	FudEzkiVPm+i2mi1VQGwd40ZssSSjwVirfycsc3zUKLw3oXq52Nw3/yAqrHlbzB5xo3UEq1VtGs
	V9HV2mkUxzyMTjX4p201vau8jRa9PDuA=
X-Received: by 2002:a05:7022:625:b0:128:d715:b717 with SMTP id
 a92af1059eb24-131852d534fmr4881151c88.13.1778193735806; Thu, 07 May 2026
 15:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506172830.2237574-1-kuniyu@google.com> <CANn89iJawd-gi4qoCZLA_mB6c-gLaqF5dirALS-ZSsFWpEB6Qw@mail.gmail.com>
In-Reply-To: <CANn89iJawd-gi4qoCZLA_mB6c-gLaqF5dirALS-ZSsFWpEB6Qw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 7 May 2026 15:42:04 -0700
X-Gm-Features: AVHnY4K4XUhXayC3iPy5g79xZnQw0nq-fwvwOocKKR7QauXHDN6uICShAhrmwqw
Message-ID: <CAAVpQUBzz7hO3ugTeEsAb5XeLP95aGsViAbA4GCx+6a74CcH+Q@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Fix out-of-bounds access for twsk in tcp_ao_established_key().
To: Eric Dumazet <edumazet@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3204F4EFDFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285535-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 4:23=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, May 6, 2026 at 10:28=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > lockdep_sock_is_held() was added in tcp_ao_established_key()
> > by the cited commit.
> >
> > It can be called from tcp_v[46]_timewait_ack() with twsk.
> >
> > Since it does not have sk->sk_lock, the lockdep annotation
> > results in out-of-bound access.
> >
> >   $ pahole -C tcp_timewait_sock vmlinux | grep size
> >         /* size: 288, cachelines: 5, members: 8 */
> >   $ pahole -C sock vmlinux | grep sk_lock
> >         socket_lock_t              sk_lock;              /*   440   192=
 */
> >
> > Let's not use lockdep_sock_is_held() for TCP_TIME_WAIT.
> >
> > Fixes: 6b2d11e2d8fc ("net/tcp: Add missing lockdep annotations for TCP-=
AO hlist traversals")
> > Reported-by: Damiano Melotti <melotti@google.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/ipv4/tcp_ao.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> > index a97cdf3e6af4..e2720233e36b 100644
> > --- a/net/ipv4/tcp_ao.c
> > +++ b/net/ipv4/tcp_ao.c
> > @@ -116,7 +116,9 @@ struct tcp_ao_key *tcp_ao_established_key(const str=
uct sock *sk,
> >  {
> >         struct tcp_ao_key *key;
> >
> > -       hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_=
held(sk)) {
> > +       hlist_for_each_entry_rcu(key, &ao->head, node,
> > +                                sk->sk_state =3D=3D TCP_TIME_WAIT ||
> > +                                lockdep_sock_is_held(sk)) {
> >                 if ((sndid >=3D 0 && key->sndid !=3D sndid) ||
> >                     (rcvid >=3D 0 && key->rcvid !=3D rcvid))
> >                         continue;
>
> I wonder if a better fix would be to change __list_check_rcu() evaluation=
 order.
>
> Otherwise, this would mean that a TIME_WAIT socket would evade RCU
> LOCKDEP checks.

Ah exactly,

>
> If a fix in tcp_ao.c is te way to go, I would suggest the opposite of
> what you did.

will change that way.

Thanks !

>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index a97cdf3e6af4cf1ee1cd8c6361944536056543e6..0a4b38b315fed40899901ea5f=
66fbdffd776df38
> 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -116,7 +116,8 @@ struct tcp_ao_key *tcp_ao_established_key(const
> struct sock *sk,
>  {
>         struct tcp_ao_key *key;
>
> -       hlist_for_each_entry_rcu(key, &ao->head, node,
> lockdep_sock_is_held(sk)) {
> +       hlist_for_each_entry_rcu(key, &ao->head, node,
> +                                sk_fullsock(sk) && lockdep_sock_is_held(=
sk)) {
>                 if ((sndid >=3D 0 && key->sndid !=3D sndid) ||
>                     (rcvid >=3D 0 && key->rcvid !=3D rcvid))
>                         continue;

