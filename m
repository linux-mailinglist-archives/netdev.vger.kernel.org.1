Return-Path: <netdev+bounces-255384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NOuHiTUfWm9TwIAu9opvQ
	(envelope-from <netdev+bounces-255384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 11:06:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE24C177B
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 11:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29FC430028CB
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 10:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F97C33BBD8;
	Sat, 31 Jan 2026 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ex3Nw9H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B7284B36
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769853978; cv=pass; b=PNOpkxWpAsh6rod+ADPvGY8viitcXYgMWdhbefGCJmT5j1Ho77eTXhTU+75KNf7ypIq5KQH+uld4TcjUUaZFSkC2AimrJWX9oF1K1gn8sFwnJ+7jK7XABbIYhv2dOG4VRV5lSEE+G7bEeuQo01Ijt0qkTsZxABxhy6+pUaFZXXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769853978; c=relaxed/simple;
	bh=Pc0d3JxCI3wTTQGh6vK9dulz0JAnPKrKRwUSwvR0J2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=id2f5xT+Hb1GehFBrC+Y5yuy+YFIF0TKrXvvsS0zn9gY9wxq2vH1kql0YXVhlvML4+gXb7OxRTSPN5l0E5EwegG+JTT68RmPcU6F0OnmxYXOt0sgd00rnE49aIz7PDsYDM5xhUt4a9JmH5zEJhwX/sTQvTPzI8mnweHItBwlr20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ex3Nw9H; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1233c155a42so4940521c88.1
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 02:06:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769853976; cv=none;
        d=google.com; s=arc-20240605;
        b=PdqdVCkzOWWoZbD3iHf7fD4lQmkHE5E6EoLlE3qiTqpjtDsbk8zDYrGQrViYmf6zaG
         aHs6ysk20KYp1yT/Yu8jmV0ZmqlhPaHPArUq6aHS2ylSpswrEPsSxIuDXZRurCfCXczC
         UHT1gF3cFrjqwSy5GVi2KOGZAotWFWEFzv8tot6QKQ7ZIiH/BnSKSFYkM+ogFs7lOL+9
         6KoiuD54PvvV2LNQES7aCLNpEcM1OZ18TEc4HtTMOjXFcAZsqWj6wZDPDBpAPWzo10N4
         G0DZNvq0VIwKX410NrvzSxkr2sN5iM3MP1bwUIbtxRaqqhvgYqjC704BmOpg9GCEd3B8
         vMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cG6KnRCvilHuALoEYGtb5C03He4FtZ6bUBo5OCWCuR8=;
        fh=l9oJM699aQiKARjII1LFXz3Ns8x7cApv1vTLgaAwh8w=;
        b=EopLe5fYheD+pWcLINY2e7aiPw7ihRLA/LLsrAS15BjSShaZjOWy5TM70hs7Ly+9NF
         nWmaA1WJtTSTV/rYqpnOKSWRR2iO0ralpzNnt6rFxW3R1I26k6ZkgWqw1oYwdeKSr/NW
         5oJF8sH3UPzjKEvJIQj//3v3fUGmX3nJ9pnwSVQQqIkrAIga+wYzp10kXMgJRrh8YYED
         Pjz3/WZbwuswtphfQhzK2ZSmALF9abOgmORkDip2KK2QhjEEKMokDK0C14vp8x5sssiw
         1RCvbJmeEcxGBW7ab7y9H1GgNKxQUc7obppzxXTgHiSTC0gzp+tWynqWOEfiYo9eRIcL
         j2yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769853976; x=1770458776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG6KnRCvilHuALoEYGtb5C03He4FtZ6bUBo5OCWCuR8=;
        b=1ex3Nw9HacrNsuoJdsQv17ZmGfZyVLGWtZklvyisqO8vwv/AGrZBHEG9RuCe3+K/ew
         bPVqjR23Ls9/CygxLQoYMtv2cbK9Tz5O61/nGFR2tB/y5C7vsMl333nqXU1epaXkynpC
         9uX4+i8/opzUCxuUfL4MMsxqbwMhAx5ETrWT0kNUbplDdUxRu2426to4BNKV9/7KxaYJ
         QdEiOqBo/GN4SgXu4caHG9RMcgZeAkrPaWP2RBU9nFtqiFCXtFuuxGgLv/UyeXlz4VcS
         Rx2m4T2VYsgkVPOZ8aGRZxOT5RKP9g33Ta2UpFvUplUDzxPRW+swIbT83BXZcZK88dRL
         N0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769853976; x=1770458776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cG6KnRCvilHuALoEYGtb5C03He4FtZ6bUBo5OCWCuR8=;
        b=mLti+05nX7xPElr3jZjZ0IJz5G7qMdd2HzVpDfvYZQfD+8Nyv7yrXmpywlX0UXxZ8d
         fu2rdvMPuDEQEfqhpcxKt2nIN+74DKMM8cESunBlzcOu3CQaAHA7TtCa6o1INoj95NST
         JNtmtZtqbDvwsICin7S6c61ozT/CNBTWzS82bv8/FgRKVJZJaVZlKy5ArYEuZWeE1GDv
         fmCdsPNwytteUS0H3YgPzu/SbpmFVzX6PDcGLb4ET0A9BTzUHEyZg5RLrlCmT4n7zU4e
         Cf7EsVOlizhcVbnBGr4s6JiQYETQIkoV9zLPMFkBCdDPeJqucaeRwMdaSBkRdH7G6Dps
         zp5w==
X-Forwarded-Encrypted: i=1; AJvYcCUol6BDf12bCyLRC7zdhx2EL+CO2bTZMVvB2vcE+NdLv8ts6FTlPwS0dXQqGlfUi+6PHEgKuaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7eheKPlh5pu0UtuiJa5xJVPQG7mAsdIZXGlaAFCny6M48TSi
	kIe/hfMnkR0+amVu9GJCjpjmfgtYNyySCyiQQYtoZRdqVX7ztgOrdnvRSA1xqRBVpr+l0NRqOt5
	V0ZbGhvYXOrkEyPSbefAO5qGLOO50xqPp0dd3uJXD
X-Gm-Gg: AZuq6aLA2ku+tXjSKG7/5R0EhROCZAXM9EbQY4mmdC3TAGUjix/XLCWXVQj0U/10BxB
	Lecy6Gr69wf27ICOYVNzc+e9Ui8m+jqw1zPpccUl/C7B0JWE7H/HiCbLFLv8EDuhgZ/J+BUvqYT
	F/BiU53Ek6IsFhGhOwbeX5ZF6gf6nAJdYSzFrSN2rKy69Z7u13TiuP2zvpNF7w2UzO37qlXDkob
	Oa557AKAIANhL83UEY6K/HuuLqL0GWV+yXdSMHMfSP5VjXzvQ7QIvukXBzTnSnW5tdqb/jM7m4l
	jJ9YFcDZxuxRec6ZjvFI/XbcqQjnqrsB0XKQ+Pyp3Kyr0tLKvMirq8UwOHflZnlKR7GIyf8=
X-Received: by 2002:a05:7022:2219:b0:124:9acd:328e with SMTP id
 a92af1059eb24-125c0fea559mr2360780c88.27.1769853975535; Sat, 31 Jan 2026
 02:06:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-unix-proto-update-null-ptr-deref-v1-1-e1daeb7012fd@rbox.co>
 <3fc5611f-394f-40db-b49d-2f26402e221a@linux.dev> <3362017f-9c3d-46cd-b3ce-cb750b565d5b@rbox.co>
 <612a9446-252f-4b14-8605-ae1af000cc41@linux.dev>
In-Reply-To: <612a9446-252f-4b14-8605-ae1af000cc41@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 31 Jan 2026 02:06:04 -0800
X-Gm-Features: AZwV_QjyWEzfyxP6BtBBqKCt3KcIzPQteQtWxmc1fOCBNvWLMnbiesDuma0K-gA
Message-ID: <CAAVpQUAc3S+Ebx2qp-Pbg9qH-Zc=yHdzVJbchCu++V_4XF3DLg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto update
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Michal Luczaj <mhal@rbox.co>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255384-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[rbox.co,gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EE24C177B
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 1:30=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/30/26 3:00 AM, Michal Luczaj wrote:
> >>> Follow-up to discussion at
> >>> https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.c=
om/.
> >>
> >> It is a long thread to dig. Please summarize the discussion in the
> >> commit message.
> >
> > OK, there we go:
> >
> > The root cause of the null-ptr-deref is that unix_stream_connect() sets
> > sk_state (`WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)`) _before_ it assi=
gns
> > a peer (`unix_peer(sk) =3D newsk`). sk_state =3D=3D TCP_ESTABLISHED mak=
es
> > sock_map_sk_state_allowed() believe that socket is properly set up, whi=
ch
> > would include having a defined peer.
> >
> > In other words, there's a window when you can call
> > unix_stream_bpf_update_proto() on socket which still has unix_peer(sk) =
=3D=3D NULL.
> >
> > My initial idea was to simply move peer assignment _before_ the sk_stat=
e
> > update, but the maintainer wasn't interested in changing the
> > unix_stream_connect() hot path. He suggested taking care of it in the
> > sockmap code.

Yes, we already have a memory barrier for unix_peer(sk) there
(to save sock_hold()/sock_put() in sendmsg(), see 830a1e5c212fb)
and another one just for sk->sk_state is not worth the unlikely
case in sockmap by a buggy user.


> >
> > My understanding is that users are not supposed to put sockets in a soc=
kmap
> > when said socket is only half-way through connect() call. Hence `return
> > -EINVAL` on a missing peer. Now, if users should be allowed to legally =
race
> > connect() vs. sockmap update, then I guess we can wait for connect() to
> > "finalize" e.g. by taking the unix_state_lock(), as discussed below.

If a user hit the issue, the user must have updated sockmap while the
user knows connect() had not returned.  Such a user must prepare
for failures since it could occur before sock_map_sk_state_allowed() too.

This is a subtle timing issue and I don't think the kernel should be
friendly to such buggy users by waiting for connect() etc.


> >
> >>   From looking at this commit message, if the existing lock_sock held =
by
> >> update_elem is not useful for af_unix,
> >
> > Right, the existing lock_sock is not useful. update's lock_sock holds
> > sock::sk_lock, while unix_state_lock() holds unix_sock::lock.
>
> It sounds like lock_sock is the incorrect lock to hold for af_unix. Is
> taking lock_sock in sock_map doing anything useful for af_unix? Should
> sock_map hold the unix_state_lock instead of lock_sock?

If sockmap code does not sleep, unix_state_lock can be used there.


>
> Other than update_elem, do other lock_sock() usages in sock_map have a
> similar issue for af_unix?
>
> >
> >> it is not clear why a new test
> >> "!sk_pair" on top of the existing WRITE_ONCE(sk->sk_state...) is a fix=
.
> >
> > "On top"? Just to make sure we're looking at the same thing: above I wa=
s
> > trying to show two parallel flows with unix_peer() fetch in thread-0 an=
d
> > WRITE_ONCE(sk->sk_state...) and `unix_peer(sk) =3D newsk` in thread-1.
> >
> > It fixes the problem because now update_proto won't call sock_hold(NULL=
).
> >
> >> A minor thing is sock_map_sk_state_allowed doesn't have
> >> READ_ONCE(sk->sk_state) for sk_is_stream_unix also.
> >
> > Ok, I'll add this as a separate patch in v2. Along with the !tcp case o=
f
> > sock_map_redirect_allowed()?
>
> sgtm. thanks.
>
> >
> >> If unix_stream_connect does not hold lock_sock, can unix_state_lock be
> >> used here? lock_sock has already been taken, update_elem should not be
> >> the hot path.
> >
> > Yes, it can be used, it was proposed in the old thread. In fact, critic=
al
> > section can be empty; only used to wait for unix_stream_connect() to
> > release the lock, which would guarantee unix_peer(sk) !=3D NULL by then=
.
> >
> >          if (!psock->sk_pair) {
> > +               unix_state_lock(sk);
> > +               unix_state_unlock(sk);

I don't like this... we had a similar one in recvmsg(MSG_PEEK) path
for GC with a biiiiiig comment, which I removed in 118f457da9ed .


> >                  sk_pair =3D unix_peer(sk);
> >                  sock_hold(sk_pair);
>
> I don't have a strong opinion on waiting or checking NULL. imo, both are
> not easy to understand. One is sk_state had already been checked earlier
> under a lock_sock but still needs to check NULL on unix_peer(). Another
> one is an empty unix_state_[un]lock(). If taking unix_state_lock, may as
> well just use the existing unix_peer_get(sk).

Yes, unix_peer_get() can be safely used there (with extra sock_put()).


> If its return value cannot
> (?) be NULL, WARN_ON_ONCE() instead of having a special empty

I suggested WARN_ON_ONCE() because Michal reproduced it with
mdelay() and I did not think it could occur in real life, but considering
PREEMPT_RT, it could be real.  So, the current form in this patch looks
good to me.


> lock/unlock pattern here. If the correct lock (unix_state_lock) was held
> earlier in update_elem, all these would go away.
>
> Also, it is not immediately clear why a non-NULL unix_peer(sk) is safe
> here. From looking around af_unix.c, is it because the sk refcnt is held
> earlier in update_elem? For unix_stream, unix_peer(sk) will stay valid
> until unix_release_sock(sk). Am I reading it correctly?

unix_stream_connect() holds the peer's refcnt, and once unix_peer(sk)
is set, it and refcnt are not cleared until close()d.  So unix_peer_get() i=
s
a bit redundant for sane users.

