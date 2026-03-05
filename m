Return-Path: <netdev+bounces-264171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONbsNtj7qGnVzwAAu9opvQ
	(envelope-from <netdev+bounces-264171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:43:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1846020AA5C
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1F68300C007
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 03:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D4B27A133;
	Thu,  5 Mar 2026 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRmVE107"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4921DF27D
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 03:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772682198; cv=pass; b=Uwga53cJaQTZdiJp+FtItbO9LAnEKsFZOrptpDRDSpAW+/GjvYsCaOrNR7obBtZDSmiflEVPuP0WruZTx1ezt5z1vF5Tq5KO1Tkin07cjsNgvjBOh5ASwi1eF3pY84AyNxM/TgKDh9YMOFL3vF1cjcU4+appYv+T+rUQCqWBgSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772682198; c=relaxed/simple;
	bh=ootrVtgPccogVZf5ithD1dZ0iHB8qkN6uJMW91uTino=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODGcGmznUNzrWnoSMnPQXxmtMBuCBnrZojKC72xyeFVD8WoVb/93riUBa1YyX8usu97f4H42Pc3d5nL9w3snZA1p2GiYjjKhMhXbnLWg3XE9gxKWIyjSoaFbTt6cz8qeGNpeYqHjFtK/rT0goKhJ9me1PoP4rx52Z1NdNaCD2YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRmVE107; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12732e6a123so1814908c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 19:43:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772682196; cv=none;
        d=google.com; s=arc-20240605;
        b=E3pj7rHKg3VwHUYfGBP+PBxlLf+sqrYX8V452nHcTIxL5ShglJY7qdCkQdk0osOGkY
         W8XIeXleEY+Ztdm/uAi0336QFxYq6G6gYr0dbm9qRJIkvcfMI8ot8ZZM4zjzwUFbxjeM
         qiyYcf4gs6oTPP0EemdsifhZoWHcq49UFXDST8Tiwq2EQetfbeJcLunESkdjFdoNPMH5
         u+sukuiH0eUG+Q0VtC4lebpsXcgBCVQ8KcmwmbNaoW+EsPmDwxIp0q/3+EUkXK390TVm
         sGQqq+l8qcoPeq4v4PvJnziqvO663Gn39sk9fgiNaSvBE9BD15G0aOcUsvtUWJdooaww
         DZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=laZackGfUZPohc8rpn7q9sGIcb8hpmuUOav/5ISxzRQ=;
        fh=e7/mHBQODT+kO+xqK2mD9awXw2OxcDlemkLy5ZCGuDI=;
        b=bqvWdZWeOCoeDfUYmkoLUbZR0hknkMZXny4ZKWdu/qYd4AAkJZvpB457un6cRK9Pv/
         o0AKLzQKHe0Q+IOTIuM9cShdqpC8NTWJMKam2hEtlBTKnxbKq0mWOpbUvSM7FvqCGvZH
         Yhql0fmKH+J1+dWjhjqu5k0rT3sCHUMwucP/dccXnB7TczmFdG277ZCK6LZAaByfJzmE
         Od+aX/HPCV8zJl8Rv7YWmfFW0G6eEaNNf5bgXBDA/WgQ/ZsQa3JPUty9JNypwnpCyUY0
         RbOXk7IgcDui9nwgFXxAJGra8oWt5ZW1Bsu6QN9mtYA5QU3kNd+LDTmVEgxek9SaQvOQ
         MUXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772682196; x=1773286996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laZackGfUZPohc8rpn7q9sGIcb8hpmuUOav/5ISxzRQ=;
        b=mRmVE107dCyuLGH2mESEAOazzRcz4uvYuqX+lfD0ghIDG9UADSgGgdmQM/eUEoKotD
         gecv2+iQgRXiukDqX9Cusx+MmVnTCItW3vVo32Rjmxk0J4HSUY07zXZ8A9JxeO+eYJbc
         I1KA3zhNi+Tdi+arTWjpbD/6a5ZJL2atrX+gl5CIPtW00N8WpNc0YNXoDyanpR9McASV
         9TEnfNX2f25k2x5c+vxYLnL+6qsH5O5dH/ytrrJsByaIJWsFH7m6AoL5NzqgKzfW/Q23
         OEEJ9Q5i2KUCkuknj2wqyUVofIl2mNj5Zi23Utkd83OYGgMhKrmib+RBXZQA/9pFoj/O
         9lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772682196; x=1773286996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laZackGfUZPohc8rpn7q9sGIcb8hpmuUOav/5ISxzRQ=;
        b=HkC9i24artrSYyGX9xyjurXjklVO+bs0a5OziT5IwSAh9sjINBMFFQZOsNsbfEjCA+
         yl+QGPCYG04ItkUQWS5RcWZFOC4QXZfwpRObE2eCS3kL7SQpUVYuuOLS1frIY1hnmjtm
         bruAPs1er0ZYuVOSPHOySKBJe7aYSgL6tFf6vvnL9qP+uVK+ZwdC0SwJ49ER5Z3SnJ9e
         VSVHEmmQ+zrr873QbHiFMLYH6LODpzN7gCSUsGPQWLJt0wsGcI484Uosx79dciOGaU6j
         bCkf9b+3SzUiBQ1pLg5KEBcFIxpw3Or5gFSfYlvuV0QSZMo2c6Wbn4qwBhX2nI/4iWZE
         f9pA==
X-Forwarded-Encrypted: i=1; AJvYcCUloTB8bvt8x6b4d5q1DIOwse6fMiJKiCsx5t1aMirH7UTJjGqYHAMt5e6De+/z0+7q/RvDvnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlOfidWDVYqPjhJg0FOl4LXvvKZUCbFxbgbb/RyFWlCHxRN2y
	nBfBZVkPVxsyTYO/KE8T9lr8Ogbb+9sSIScHSmOn9WXeLitjEYtbIq9IpWqlhGE4Cmza6Tqp6k4
	aoPq8XllruodKIyEyXvz/wbZrAbTo2lv8E4mDXZfK
X-Gm-Gg: ATEYQzxBnwFsAAWdELAF8nJjJ4lhAjZEXK6I9tW0AFt+YVVka8NjjOJhlowi03rb9bq
	DJ69QISiqG5GaC/DPCSb02V3X3G/Z9PF8NC90E4gxUblwKOYkAsZfqnBrBjey7zddHwtWCocsME
	pY8zGWbw7Z33JuCTksk8zDtlvvlgKr2MIU5YZ2DzhNkkPQkDgFcF6qkIkWor48IQEkPRXT6dRMx
	tKoT5+lhRrPgBnEhoB0Gprq7kx4eNywBMJLJRDmaRbRUhJR8GP6J085ztDdgY62lAMCh3GAv+Eq
	C0LUK4ypXmkr9PvYIoI7e6BFyc9gj4BcGchiz8Irv7lrhWwsJCkn0/8gSRb9h3ThwLZzCcrA
X-Received: by 2002:a05:7022:611:b0:127:3440:e5d5 with SMTP id
 a92af1059eb24-128b70d1277mr2482271c88.21.1772682195309; Wed, 04 Mar 2026
 19:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-3-kuniyu@google.com>
 <fjt7fesjnzwuzeuiouv6rpvoxebounjqv3jlc34tvmzh252zep@hizdvwr2qwe4>
In-Reply-To: <fjt7fesjnzwuzeuiouv6rpvoxebounjqv3jlc34tvmzh252zep@hizdvwr2qwe4>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 19:43:04 -0800
X-Gm-Features: AaiRm50tdKTJcrkl2TV6ugHeYrljxXQn_6A_T7cC2LyOcuGXEOHGEE6Yysg1wcY
Message-ID: <CAAVpQUAJgFtcJGtuMufS9mhaShs7OQDxx7jTGOSbG9wCdeCN7Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1846020AA5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264171-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 5:48=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> On Sat, Feb 21, 2026 at 11:30:49PM +0800, Kuniyuki Iwashima wrote:
> > UDP TX skb->destructor() is sock_wfree(), and UDP only
> > holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().
> >
> > Otherwise, sk->sk_write_space() is read locklessly.
> >
> > Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().
> >
> > Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v3: Use WRITE_ONCE() in udp_bpf_update_proto()
> > v2: Cache sk->sk_write_space in sock_wfree()
> > ---
> >  net/core/skmsg.c   | 2 +-
> >  net/core/sock.c    | 8 ++++++--
> >  net/ipv4/udp_bpf.c | 2 +-
> >  3 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index 75fa94217e1e..3d7eb2f4ac98 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -1297,7 +1297,7 @@ void sk_psock_start_verdict(struct sock *sk, stru=
ct sk_psock *psock)
> >
> >       psock->saved_data_ready =3D sk->sk_data_ready;
> >       WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
> > -     sk->sk_write_space =3D sk_psock_write_space;
> > +     WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
> >  }
>
> I noticed that Patch 1 and 2 were submitted earlier and are on bpf tree.
> Given that Eric's commit (which you reviewed) is now in net.git, these tw=
o patches
> should probably be dropped in the next version, right? Just confirming.

I was thinking git can just handle them well, and even the
patch 2 has a delta in sock_wfree().


>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit=
/?id=3D2ef2b20cf4e04ac8a6ba68493f8780776ff84300
>
> >  void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 693e6d80f501..710f57ff3768 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2673,8 +2673,12 @@ void sock_wfree(struct sk_buff *skb)
> >       int old;
> >
> >       if (!sock_flag(sk, SOCK_USE_WRITE_QUEUE)) {
> > +             void (*sk_write_space)(struct sock *sk);
> > +
> > +             sk_write_space =3D READ_ONCE(sk->sk_write_space);
> > +
> >               if (sock_flag(sk, SOCK_RCU_FREE) &&
> > -                 sk->sk_write_space =3D=3D sock_def_write_space) {
> > +                 sk_write_space =3D=3D sock_def_write_space) {
> >                       rcu_read_lock();
> >                       free =3D __refcount_sub_and_test(len, &sk->sk_wme=
m_alloc,
> >                                                      &old);
> > @@ -2690,7 +2694,7 @@ void sock_wfree(struct sk_buff *skb)
> >                * after sk_write_space() call
> >                */
> >               WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc=
));
> > -             sk->sk_write_space(sk);
> > +             sk_write_space(sk);
> >               len =3D 1;
> >       }
> >       /*
> > diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> > index 91233e37cd97..779a3a03762f 100644
> > --- a/net/ipv4/udp_bpf.c
> > +++ b/net/ipv4/udp_bpf.c
> > @@ -158,7 +158,7 @@ int udp_bpf_update_proto(struct sock *sk, struct sk=
_psock *psock, bool restore)
> >       int family =3D sk->sk_family =3D=3D AF_INET ? UDP_BPF_IPV4 : UDP_=
BPF_IPV6;
> >
> >       if (restore) {
> > -             sk->sk_write_space =3D psock->saved_write_space;
> > +             WRITE_ONCE(sk->sk_write_space, psock->saved_write_space);
> >               sock_replace_proto(sk, psock->sk_proto);
> >               return 0;
> >       }
> > --
> > 2.53.0.371.g1d285c8824-goog
> >

