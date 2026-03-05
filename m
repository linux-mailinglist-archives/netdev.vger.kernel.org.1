Return-Path: <netdev+bounces-264206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBvADlo1qWlH3AAAu9opvQ
	(envelope-from <netdev+bounces-264206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:48:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4FB20CE4F
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54C1D3030125
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 07:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04935320A00;
	Thu,  5 Mar 2026 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGeIP84N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39D800
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696905; cv=pass; b=P41MV15NEFC97uN0pFY7od6K0alsMsSmy+CvbYDOferN+EHDcg7unU8epfl6YlJuh/QcFuJ38qtxSsr4YZwQUSPd7/GPC3664GCflIEKlBiXZdVUSkftdsP/54a5gIFxjrpjPeXE7KFLLHgLWVFxD/rgo/oroi91SwbnurP+BXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696905; c=relaxed/simple;
	bh=k9aARijhl+UpUNTAbtTN6GlGGncJpw4/8U+YwxU7GGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVYn2+7E1q38X7/uvmK1ZeSoCSq6XtiFrY4O4PFE+FiCaD+XldCWp2MzMffOhdxYiM3FZBBwUL/gYAUPPV0rwkBUDT1+cSj1mfpiQPRTSOb8ZO7Hsldk2RrtCRkrv0pm1rglWZSKDunvtV0Svpn7kgzxlPULaqyitg0l5cPZ/hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGeIP84N; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-126ea4b77adso9995864c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 23:48:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772696904; cv=none;
        d=google.com; s=arc-20240605;
        b=JBDbdlYRS09vcO/VN7HSUeD9LpazCag6TiQUn4Vvjvl5zeuOX/eGx97Kp1EvNB2ct4
         KgoIl0Eo2goL1rOBEvQB5uK3+oh2mtWqqUqBzlQ1MZoE2ky+LgLrkI3DuzG7Cq4oqJWx
         giIUj/I3aiZKhPf9QlGpHlP4Fqohj9GUVM0uyPdmQCqp/ASEug2en8oUHEqRuxIv2WZ0
         fUKNEaYvsZ3xdxNAjO7DZtPwLU/frg+qWjKCJbGezs8rYgGW9y4jMiX4miz9krbU4p/g
         Tew+ZeGX9/zxsSO2tWmv5U7sGk+72wYWIUXsuzF0vAMSVFaZOR95jscEBjdOx+DGjvK7
         9rCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9JJY1lPR4ZIJ0bJOtAMSPyTe1J2YXJb3Q8jfZODA7WM=;
        fh=8blK1GktVjzHzwP8ily5AECpf6wMOarBesXsLT/QM5c=;
        b=MOAttKiDvpWmn3gwq0v81PbaIB4GnoQ64mSE88ouLH202J4sKi1+le3mt4jjM+xkD4
         rk9m0lJVQBSjsCebulsj8TGAN0fP1RuIRnOFG4YloPgy7yCLQR51H4PUpDk5IBXyDv9C
         xCGPuVBG8FoXut8BXgunHqeH+N0ZoMBmgMs2GCQNwT1SIK9tKIYqH5EfN9j7aFlatpjg
         dRiGOLgEpexRXSCcBqU/jP46TNFN0YebfwBuz5ssCA8KokVMfCiKTFPZXRyCa4xWGHW/
         /JOwGjutEjC/D+HvcB50asCQNbbzTZjfMSpBQpLoN3Xn39QScsB6fhv0dsoQGThtQ40Z
         pBFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772696904; x=1773301704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JJY1lPR4ZIJ0bJOtAMSPyTe1J2YXJb3Q8jfZODA7WM=;
        b=uGeIP84Ncjd5aF66u6nlTjNdRmqRJ2t+KKHR4dYJETc6C5AzitOoCuAx1wgVtgwPJU
         XxXJ7ePFD3eO2t7d1pazTLFNklyF1B+Y+aakuX9+1RIqiNVSs/wFjHefKxdh86aQQRaW
         Ggx8MuBEsBKrBerKwYlNzZ7IPxnBqfeWRpJLcF4PqDbp/FZ7VugWmAqDGf30IqtCYtKC
         St/aBImwFXZ/nAbBFEY6iNGCE0a3TAKSJ3d/1vR+jNZv8C4ISrUwij6vv479aOK0SIR1
         7QW/C0rgy3nUflbZFc2hpGkySvJLGIlaSKFjNAstqgck7+p26y0HPQpHP4yag79EKOI7
         HXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772696904; x=1773301704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9JJY1lPR4ZIJ0bJOtAMSPyTe1J2YXJb3Q8jfZODA7WM=;
        b=Qqa4U8njCImemCr9qdGQwDuZH2dhFYBq87dRTObq/gEzBcTlA9K8AxVHXq1vJUVKwH
         fmnE0uGUQCSvvT/IfpT3qg36Kq718SYidZRVbL1o5kEx8NOuHU36RQCFG2a9zog33Z2E
         c9XowdMYpc1S1NINRBFkVxxqebv8MgmuQextFnGC+/GsoKTpVcAO32FprS8qAXFkXn+6
         M96U3vl8fbkBwp1sRMe+Wj0V3nI6R755jT55iSYwwLhcVPoC+BgPLf5958j051j6zwkZ
         +NI55UQeIIvx96ucemkA49wLV/G6m046uFKd+5VhyL+icVEuFZ3huHriP4nBwZD3XAmj
         c3EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2Wci5DkCYT4dbwafSfuhyEx58TLqAcIZxll9DRb/KEu9RiQ+PeU3YercfGAQyDxi3222pBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDNI331tpl7+S/LVLMXyKym/rM7F/w0Yg9q+4FjoD8JuUxhmB
	O636Pp1ee+V1HxdICjPvH1w45og8W6sgDdKycjsWW5akM+h7+VjxdFHYUkfPxOCZxFmWazBNuo8
	yuzuByxdKEFfmzdo37OTg9D/PnImuvMsKOu4x/0zr
X-Gm-Gg: ATEYQzzENpg7xKYMJh0MewKNBRidVpafGyVkMGpDB2d6Yppk+nEThcNUpwRTAts1jQt
	RWms4gZj0fZajkDyGpfH21ji1huMUTKiOBgPJQLCglUNUMMM91l0e6y0sL3o4Qti2vtDqESjLm3
	CWc+g3+377wKY8Q1zd4lmxWcHQ2BPN0z2vjtxlsgmNcI7qmC7Pn1SNBsXXnQO3NJtGxUOb0WIbn
	5IBagCOT8yh47OrS3AY6C3d+U9668oxZ5KZUIZpGv9C7Pj2GffpXkxeYSqy3DK+XnSFVzkrbNsX
	dvVULhMo9/XTeCKXhAABfXQvyrVS76E4QBEB1mHYCTDH8dSJ/ZKX4/g4GVBnPtOiDKFe8WeR
X-Received: by 2002:a05:7022:926:b0:122:2f4:b251 with SMTP id
 a92af1059eb24-128b70c82bemr2437835c88.21.1772696903061; Wed, 04 Mar 2026
 23:48:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-7-kuniyu@google.com>
 <r7csevb4yonphmfhfpkj7jpc4yvjkdwrp566zxhueaf6vgjfak@stnfyjkqid6o>
In-Reply-To: <r7csevb4yonphmfhfpkj7jpc4yvjkdwrp566zxhueaf6vgjfak@stnfyjkqid6o>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 23:48:12 -0800
X-Gm-Features: AaiRm51o2epiQ653A5R7b9_VBmqBq3bYa7mnj-Cue-rtJnp1UxPzumDbD-GWMNg
Message-ID: <CAAVpQUAGSzypVhT8V-qjhUfZeEQhXQtS1z+iQC7vrzZCHEr9=A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8B4FB20CE4F
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
	TAGGED_FROM(0.00)[bounces-264206-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,appspotmail.com:email]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 10:37=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> On Sat, Feb 21, 2026 at 11:30:53PM +0800, Kuniyuki Iwashima wrote:
> [...]
> >  </TASK>
> >
> > Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")
> > Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/698f84c6.a70a0220.2c38d7.00cb.GA=
E@google.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v4: Fix deadlock when requeued
> > v2: Fix build failure when CONFIG_INET=3Dn
> > ---
> >  include/net/udp.h |  9 +++++++++
> >  net/core/skmsg.c  | 29 +++++++++++++++++++++++++----
> >  net/ipv4/udp.c    |  9 +++++++++
> >  3 files changed, 43 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/udp.h b/include/net/udp.h
> > index 700dbedcb15f..ae38a4da9388 100644
> > --- a/include/net/udp.h
> > +++ b/include/net/udp.h
> > @@ -455,6 +455,15 @@ struct sock *__udp6_lib_lookup(const struct net *n=
et,
> >                              struct sk_buff *skb);
> >  struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
> >                                __be16 sport, __be16 dport);
> > +
> > +#ifdef CONFIG_INET
> > +void udp_sock_rfree(struct sk_buff *skb);
> > +#else
> > +static inline void udp_sock_rfree(struct sk_buff *skb)
> > +{
> > +}
> > +#endif
> > +
> >  int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
> >
> >  /* UDP uses skb->dev_scratch to cache as much information as possible =
and avoid
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index 96f43e0dbb17..dd9134a45663 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <net/sock.h>
> >  #include <net/tcp.h>
> > +#include <net/udp.h>
> >  #include <net/tls.h>
> >  #include <trace/events/sock.h>
> >
> > @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock *ps=
ock, struct sk_buff *skb,
> >                               u32 off, u32 len, bool take_ref)
> >  {
> >       struct sock *sk =3D psock->sk;
> > +     bool is_udp =3D sk_is_udp(sk);
> >       struct sk_msg *msg;
> >       int err =3D -EAGAIN;
> >
> > @@ -583,13 +585,20 @@ static int sk_psock_skb_ingress(struct sk_psock *=
psock, struct sk_buff *skb,
> >       if (!msg)
> >               goto out;
> >
> > -     if (skb->sk !=3D sk && take_ref) {
> > +     if (is_udp) {
> > +             if (unlikely(skb->destructor =3D=3D udp_sock_rfree))
> > +                     goto enqueue;
> > +
> > +             spin_lock_bh(&sk->sk_receive_queue.lock);
> > +     }
> > +
> > +     if (is_udp || (skb->sk !=3D sk && take_ref)) {
> >               if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > -                     goto free;
> > +                     goto unlock;
> >
> >               if (!sk_rmem_schedule(sk, skb, skb->truesize))
> > -                     goto free;
> > -     } else {
> > +                     goto unlock;
> > +     } else if (skb->sk =3D=3D sk || !take_ref) {
> >               /* This is used in tcp_bpf_recvmsg_parser() to determine =
whether the
> >                * data originates from the socket's own protocol stack. =
No need to
> >                * refcount sk because msg's lifetime is bound to sk via =
the ingress_msg.
> > @@ -604,11 +613,23 @@ static int sk_psock_skb_ingress(struct sk_psock *=
psock, struct sk_buff *skb,
> >        * into user buffers.
> >        */
> >       skb_set_owner_r(skb, sk);
> > +
> > +     if (is_udp) {
> > +             spin_unlock_bh(&sk->sk_receive_queue.lock);
> > +
> > +             skb->destructor =3D udp_sock_rfree;
> > +     }
> > +
> > +enqueue:
> >       err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, take_ref);
> >       if (err < 0)
> >               goto free;
> >  out:
> >       return err;
> > +
> > +unlock:
> > +     if (is_udp)
> > +             spin_unlock_bh(&sk->sk_receive_queue.lock);
> >  free:
> >       kfree(msg);
> >       goto out;
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 422c96fea249..831d26748a90 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -2039,6 +2039,15 @@ struct sk_buff *__skb_recv_udp(struct sock *sk, =
unsigned int flags,
> >  }
> >  EXPORT_SYMBOL(__skb_recv_udp);
> >
> > +void udp_sock_rfree(struct sk_buff *skb)
> > +{
> > +     struct sock *sk =3D skb->sk;
> > +
> > +     spin_lock_bh(&sk->sk_receive_queue.lock);
> > +     sock_rfree(skb);
> > +     spin_unlock_bh(&sk->sk_receive_queue.lock);
> > +}
> > +
> >  int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
> >  {
> >       struct sk_buff *skb;
> > --
> > 2.53.0.371.g1d285c8824-goog
> >
>
> There are too many protocol-specific checks in the generic skmsg code
> here. This should be abstracted out.
>
> Also TCP also has a similar issue with sk_forward_alloc concurrency
> between the backlog charge and recvmsg uncharge paths so the abstraction
> is necessary.
>
> I've put together a simple diff based on your patch for reference.
> I haven't tested it thoroughly, but it at least handles TCP and UDP
> separately through a callback, keeping the generic code clean.

I can follow up on TCP, but TCP needs another fix, which
cannot be factored out.

Some wrong assumptions in your patch:

1) tcp_psock_ingress_charge() uses psock->ingress_lock,
    but it does not protect any tcp_sock fields, especially
    sk->sk_forwad_alloc.

2) TCP memory accounting happens under bh_lock_sock()
    _or_ lock_sock().  sendmsg()/recvmsg() works under
    lock_sock() and TCP fast path puts skb to backlog if
    lock_sock() is held by userspace.  This means even
    a simple bh_lock_sock() in tcp_psock_ingress_charge()
    race with memory accounting happening under lock_sock().

Since sk_psock_skb_ingress() is called from both GFP_KERNEL
and GFP_ATOMIC context, the simplest fix would be to put
lock_sock() in sk_psock_backlog() for TCP, which is ugly though.

