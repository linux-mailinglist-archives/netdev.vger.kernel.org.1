Return-Path: <netdev+bounces-264243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBEeGRVNqWk14AAAu9opvQ
	(envelope-from <netdev+bounces-264243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:29:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B685520E6A8
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 068CB300DF6F
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F40378830;
	Thu,  5 Mar 2026 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jrn/sVVQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6437883B
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702848; cv=pass; b=S942AciYxKT1zImRAruef38n3YauprQnl0Jfq6qg1DqvV/99EHAjmv17Bjpd50kdETCvcOAOjA9nSj/MQ6PJOSglxU8id3OJT7Fx6Eej+snwMiZX9C3IoCpBEeKkMq6pxP5/Y2jy4ysEDWLQB7O9GOFQt3LQ8GioJ6Ut2m/0yrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702848; c=relaxed/simple;
	bh=lMjYfl+Pmb7NDXCB4+hmAwoURdeJLXQAEFQ0PlMbzDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptrx72ZXUwNX7oKTVulOmghH5lid0hOHpPcirOlVK4NXU9FwVV1qIoI5UilkdnjVlM4ySohn5XsbfaeBv08qtJLPL1h50NjGg8RXLsf3CV9fPVMHO0tiFl3nJVmMYQJyqpCBdj+HbYRRAlen0LOeWfH3MLyqqA5ZXc1mmxIC0fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jrn/sVVQ; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-127380532eeso291929c88.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 01:27:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772702846; cv=none;
        d=google.com; s=arc-20240605;
        b=gB5GOG74u61N/VlRDWOngt9/pQWkYslIIuOTCzJbkvPHo8vHksEnvCjrDs0USwqcVE
         jGGWbctLsO/QE0Oe72WBb6UFVyJGKVwcH5/HmOF1z8NihT1PgVvyXwF0C7n5voqu+wK+
         HfGvC1LFeYy75CAj6Vf/LgCEhNRGhu6I7R2D485n12KUTSu8WrySQ0kVDB1g6jAfNiaO
         n4c1xl6WM3tIILf0asO/VJBBzmTpo2X3EGwBJrGaHAE4X6isz0GHjqSooUfuOsuPDFWd
         q34jh7VC7V25ymk01BfE7OMyjSlXvDrx4Tznk+iQ0LIrP+7cJrhL16CzmQt1wDG5pXq3
         D+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YGl7YGr5hs1Mp3RVhxOnhpc/LsWUXqci1b3NWeyBdTs=;
        fh=1NzD0GPl7PM1t3kuitb9uONyoa4TeEZ4dtDdKXWhTME=;
        b=PTuc4lVDULpjn/NbVyYLmRNjwY1kNRXz7qslt6omw2kcVVisdD+pA6ulZSUucGgZGQ
         Hfx7gJ6/1/vmFov8UOvP0dgun7t5wMbK7YYevGMc8SMgBA68/sYa8SVljnsWGwVtsdhS
         LzZPQ1DrsknT0qh7Z+UthmCJbkZRETgHUewHniRrzlQkXpxp/le2/0uMLHxNb6LHKudE
         6USIPYCABDvRZij5y0mYaL2UZaPdd+Cu8TmKWQShkXXeo4Bv5nyz16FXPYEGbrJDq7Pa
         7a5N4U8hwQ2MQbNK0FFcvLVejsRirWXQUEGxxui7N5zSzrIicQuKsvqI02iveA7cmwbp
         lq1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772702846; x=1773307646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGl7YGr5hs1Mp3RVhxOnhpc/LsWUXqci1b3NWeyBdTs=;
        b=Jrn/sVVQs4MieGopJwRtadojipO3mkCjMRwDvBdMDScqI08y/cITVgvrqS8rKeKyPG
         pEIBpJcvPr8HdCQ4NlX/m+W3mf06CQE5gCDQNmBItSbJbN63xuljNt7aF4dEcD4/8vD7
         8mAxVSHzqBC33HEJB5wYfYoiPerooxy0qlino5Gg2XZ7gx7+J1HJ0NiIqUQboOazaCey
         z2U6UKpJD3XFR+U0VDhgiIgqvsES04fLapbUUxPrRADMscrZzYwzGbCeJqgUv9Giriu8
         XqA0nn9/8mbDKamVjuOLH3Km6ErEZ/usAQCJljY+SeSr2JajgEdDSIi5RiyOq4BhD3Ub
         Gqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772702846; x=1773307646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGl7YGr5hs1Mp3RVhxOnhpc/LsWUXqci1b3NWeyBdTs=;
        b=L3uwPVsrrQauKJWhDbf7J490cdl/w6k2Q/Ue2IiIHG1PuCkFuETuduMVMn9UBQiIVN
         g8FYVA5yPNPaAzFhx0XzK70wGlq7C5vyEgSe58mkToBhW27N+6ZizXM/5HxPt6QZ9Es9
         CQiHtpYJvhjm2TfdZX08rz+2uB+Qdcwv7rR0VbO5hC75aYF7hIIBqB8DenpWL7znNbzi
         P2th+75MTdLCWB4LqDestEaU5+eY+ybvL98/t+0as7cyJPAK7gdNvZIo9ZtvLoV9FTer
         j+661dCCCk2U589cQcI9Y2hOm0iPhMmvvmjb/qDVN+eI6Ki86aLPFr55uZj5Kha1pMRH
         ElVg==
X-Forwarded-Encrypted: i=1; AJvYcCXyDUZtuMpK6yUotSGJ19FRFJgVVuD3GAVJmKDDjkaoPv0fgCdBDQC2m+QP/EaeEr1BDwsCpO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziK3YXe+mVo23KBTmSkFCEyJF7SLVWnwFJ4ov8z32Y4oQ8VT94
	/qBLQeA+Uas/dEuvjAY86rsFthAMLCsRtfJi4BtLMPlvptfQXI+ufl6tHQ3m4Tisx8if8uPmuLV
	LXZqWji1wCbn50HULsHj0xouwtknoZ4aT0hesDha/ZIK95QDjTN03DgCSXec=
X-Gm-Gg: ATEYQzxTWRQ30hct90jRqox+wz1BBLm8LX4apcHPA+70DgqDK+tcuP/L2r27capfH6w
	l5i89dadQxkS+r5AZrw1yaJ8FQguKvWswQJTic6jofj5t2vARxztSCoBYs7LLKFJWoLAsApaV4x
	kEshz/jyqbx1BfD/1LTzjzqKkzwqPywHiwKCHOinK4pFyHGNBUqAvj4jCZWqMpa6yqZM329ixw+
	ZGd8/Tz55ElF3lVoTmSsY6oXhdvpLBKS0AaTeZ+Aa+8ZMebk3QGtEKeZNqw+dumq9wRRlwua4Ps
	rndlEJ7a3UDCbzUku1q6nbYAas38axgXJ1iH7HjO1mcafMLPe92i/2CmIChGN/5gxAxcCk3k
X-Received: by 2002:a05:7022:6899:b0:11b:9386:7ecd with SMTP id
 a92af1059eb24-128b70ef851mr2410546c88.42.1772702845137; Thu, 05 Mar 2026
 01:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-7-kuniyu@google.com>
 <r7csevb4yonphmfhfpkj7jpc4yvjkdwrp566zxhueaf6vgjfak@stnfyjkqid6o>
 <CAAVpQUAGSzypVhT8V-qjhUfZeEQhXQtS1z+iQC7vrzZCHEr9=A@mail.gmail.com> <389162b2e117d8a5675b02286c7bafcc342086b6@linux.dev>
In-Reply-To: <389162b2e117d8a5675b02286c7bafcc342086b6@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 01:27:13 -0800
X-Gm-Features: AaiRm51CIrbURfGzu54QGWbHrTP5af5b7cqQqQoVQE0Fnyut1UlLLTuWdt-6J08
Message-ID: <CAAVpQUBrVzwDN2xc68owHJZP7VoAZQWhwo_xdo5noGZ27qmjpA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B685520E6A8
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
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-264243-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 12:30=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> March 5, 2026 at 15:48, "Kuniyuki Iwashima" <kuniyu@google.com mailto:kun=
iyu@google.com?to=3D%22Kuniyuki%20Iwashima%22%20%3Ckuniyu%40google.com%3E >=
 wrote:
>
>
> >
> > On Wed, Mar 4, 2026 at 10:37 PM Jiayuan Chen <jiayuan.chen@linux.dev> w=
rote:
> >
> > >
> > > On Sat, Feb 21, 2026 at 11:30:53PM +0800, Kuniyuki Iwashima wrote:
> > >  [...]
> > >  </TASK>
> > >
> > >  Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")
> > >  Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
> > >  Closes: https://lore.kernel.org/netdev/698f84c6.a70a0220.2c38d7.00cb=
.GAE@google.com/
> > >  Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > >  ---
> > >  v4: Fix deadlock when requeued
> > >  v2: Fix build failure when CONFIG_INET=3Dn
> > >  ---
> > >  include/net/udp.h | 9 +++++++++
> > >  net/core/skmsg.c | 29 +++++++++++++++++++++++++----
> > >  net/ipv4/udp.c | 9 +++++++++
> > >  3 files changed, 43 insertions(+), 4 deletions(-)
> > >
> > >  diff --git a/include/net/udp.h b/include/net/udp.h
> > >  index 700dbedcb15f..ae38a4da9388 100644
> > >  --- a/include/net/udp.h
> > >  +++ b/include/net/udp.h
> > >  @@ -455,6 +455,15 @@ struct sock *__udp6_lib_lookup(const struct net=
 *net,
> > >  struct sk_buff *skb);
> > >  struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
> > >  __be16 sport, __be16 dport);
> > >  +
> > >  +#ifdef CONFIG_INET
> > >  +void udp_sock_rfree(struct sk_buff *skb);
> > >  +#else
> > >  +static inline void udp_sock_rfree(struct sk_buff *skb)
> > >  +{
> > >  +}
> > >  +#endif
> > >  +
> > >  int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
> > >
> > >  /* UDP uses skb->dev_scratch to cache as much information as possibl=
e and avoid
> > >  diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > >  index 96f43e0dbb17..dd9134a45663 100644
> > >  --- a/net/core/skmsg.c
> > >  +++ b/net/core/skmsg.c
> > >  @@ -7,6 +7,7 @@
> > >
> > >  #include <net/sock.h>
> > >  #include <net/tcp.h>
> > >  +#include <net/udp.h>
> > >  #include <net/tls.h>
> > >  #include <trace/events/sock.h>
> > >
> > >  @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock =
*psock, struct sk_buff *skb,
> > >  u32 off, u32 len, bool take_ref)
> > >  {
> > >  struct sock *sk =3D psock->sk;
> > >  + bool is_udp =3D sk_is_udp(sk);
> > >  struct sk_msg *msg;
> > >  int err =3D -EAGAIN;
> > >
> > >  @@ -583,13 +585,20 @@ static int sk_psock_skb_ingress(struct sk_psoc=
k *psock, struct sk_buff *skb,
> > >  if (!msg)
> > >  goto out;
> > >
> > >  - if (skb->sk !=3D sk && take_ref) {
> > >  + if (is_udp) {
> > >  + if (unlikely(skb->destructor =3D=3D udp_sock_rfree))
> > >  + goto enqueue;
> > >  +
> > >  + spin_lock_bh(&sk->sk_receive_queue.lock);
> > >  + }
> > >  +
> > >  + if (is_udp || (skb->sk !=3D sk && take_ref)) {
> > >  if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > >  - goto free;
> > >  + goto unlock;
> > >
> > >  if (!sk_rmem_schedule(sk, skb, skb->truesize))
> > >  - goto free;
> > >  - } else {
> > >  + goto unlock;
> > >  + } else if (skb->sk =3D=3D sk || !take_ref) {
> > >  /* This is used in tcp_bpf_recvmsg_parser() to determine whether the
> > >  * data originates from the socket's own protocol stack. No need to
> > >  * refcount sk because msg's lifetime is bound to sk via the ingress_=
msg.
> > >  @@ -604,11 +613,23 @@ static int sk_psock_skb_ingress(struct sk_psoc=
k *psock, struct sk_buff *skb,
> > >  * into user buffers.
> > >  */
> > >  skb_set_owner_r(skb, sk);
> > >  +
> > >  + if (is_udp) {
> > >  + spin_unlock_bh(&sk->sk_receive_queue.lock);
> > >  +
> > >  + skb->destructor =3D udp_sock_rfree;
> > >  + }
> > >  +
> > >  +enqueue:
> > >  err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, =
take_ref);
> > >  if (err < 0)
> > >  goto free;
> > >  out:
> > >  return err;
> > >  +
> > >  +unlock:
> > >  + if (is_udp)
> > >  + spin_unlock_bh(&sk->sk_receive_queue.lock);
> > >  free:
> > >  kfree(msg);
> > >  goto out;
> > >  diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > >  index 422c96fea249..831d26748a90 100644
> > >  --- a/net/ipv4/udp.c
> > >  +++ b/net/ipv4/udp.c
> > >  @@ -2039,6 +2039,15 @@ struct sk_buff *__skb_recv_udp(struct sock *s=
k, unsigned int flags,
> > >  }
> > >  EXPORT_SYMBOL(__skb_recv_udp);
> > >
> > >  +void udp_sock_rfree(struct sk_buff *skb)
> > >  +{
> > >  + struct sock *sk =3D skb->sk;
> > >  +
> > >  + spin_lock_bh(&sk->sk_receive_queue.lock);
> > >  + sock_rfree(skb);
> > >  + spin_unlock_bh(&sk->sk_receive_queue.lock);
> > >  +}
> > >  +
> > >  int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
> > >  {
> > >  struct sk_buff *skb;
> > >  --
> > >  2.53.0.371.g1d285c8824-goog
> > >
> > >  There are too many protocol-specific checks in the generic skmsg cod=
e
> > >  here. This should be abstracted out.
> > >
> > >  Also TCP also has a similar issue with sk_forward_alloc concurrency
> > >  between the backlog charge and recvmsg uncharge paths so the abstrac=
tion
> > >  is necessary.
> > >
> > >  I've put together a simple diff based on your patch for reference.
> > >  I haven't tested it thoroughly, but it at least handles TCP and UDP
> > >  separately through a callback, keeping the generic code clean.
> > >
> > I can follow up on TCP, but TCP needs another fix, which
> > cannot be factored out.
> >
> > Some wrong assumptions in your patch:
> >
> > 1) tcp_psock_ingress_charge() uses psock->ingress_lock,
> >  but it does not protect any tcp_sock fields, especially
> >  sk->sk_forwad_alloc.
> >
> > 2) TCP memory accounting happens under bh_lock_sock()
> >  _or_ lock_sock(). sendmsg()/recvmsg() works under
> >  lock_sock() and TCP fast path puts skb to backlog if
> >  lock_sock() is held by userspace. This means even
> >  a simple bh_lock_sock() in tcp_psock_ingress_charge()
> >  race with memory accounting happening under lock_sock().
> >
> > Since sk_psock_skb_ingress() is called from both GFP_KERNEL
> > and GFP_ATOMIC context, the simplest fix would be to put
> > lock_sock() in sk_psock_backlog() for TCP, which is ugly though.
> >
>
> OK, thanks.
>
> Now my only concern is keeping UDP-specific logic
> out of skmsg.c.

We already have TCP-only msg->sk logic there that
you added.  It just does not look like TCP code.

If really needed, we can do such cleanup in bpf-next
for TCP and UDP altogether (probably after another
TCP fix ?).


> We could use a function pointer so that UDP
> implements its own ingress charge in udp_bpf.c, while other
> protocols just use a default no-op or even NULL.

If TCP requires locking outside of the scope, there's
no point adding one more extra layer/complexity just
for UDP.

Even if we go that way, most likely we cannot get rid
of protocol-specific code (UDP/TCP-only hook) and
end up with the indirect call helpers, which will be
expensive than simple if logic.

