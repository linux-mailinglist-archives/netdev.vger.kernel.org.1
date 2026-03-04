Return-Path: <netdev+bounces-264036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNtgFPWSqGk3vwAAu9opvQ
	(envelope-from <netdev+bounces-264036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 21:15:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8229207820
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 21:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 884243028ECA
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 20:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D3B374759;
	Wed,  4 Mar 2026 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcY0NlQs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C52371D12
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655306; cv=pass; b=noFynOVqYx7yiPJb90EiMn7RsUXpNYguGWvXQcxzys3/rEblFncDEilikKCrw2AgJQNInlJ96fK0/ewWD7+SGM8vop9e/yinsRLb8W2Pd132WEqbVimHCbpezOW+Og41qZ66uHpoLSNi5mpIpFmq6jNBkNZYwRsyAMa8XbhjIFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655306; c=relaxed/simple;
	bh=abSi4JD2ktlQGTbjB7Yv2uvKpNn8VDJZ/Pv4m6j917E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8BifmEBUecVq3yNF+K2vtEMysZSGOxTF/pBImyTKok9DKxXMc+7xnB/zJGafcXfbF8HMuGe9TC44DR30FPyzWgJ4i6rg733tahD7eRutCjABJEWntDYikKInYgzKp9Lq2IOCjU5dKlAO3AnCCPBcRHtnUODUSRD6kvZlrnel/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcY0NlQs; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-660fb578f8eso1805782a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 12:15:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772655303; cv=none;
        d=google.com; s=arc-20240605;
        b=inzAtRvw0WDWmJ7NggHTSUE83HL/T0GZ7/kmwSeofcYzihWdVLbiMpO3MWwbWLJVj9
         Rsa683BXu0kEjeCeQNT64mm+I1DFHrpIQU8WFLIJMj8ICX6VKS6h+WL0VjIvbustvrgB
         AKSe0pGQISYsURIYny/hh4Z6+K/EN82kzqA0km+bdhqUVzA/g1GgMY4icYalcttRXlbt
         LTXYilzv6kkIPYu1+6wYG4lRSxERHtCvyiMet6ZHZsdFg6adQPy0w7wHxVmmXJq4YwkP
         Z2hN/dtJC2MUJ1e4lDr+sF27i/exv6jN7BkuvmkRGpShcOQfCWPdyWt3JnD8M7BO15u9
         6F/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+GfNQFz0qALmfPoIx3Yqf69fSM+V1guhjH9flo/Vo5g=;
        fh=bOzNckIyFk29e0exGnLIBhkZ+6L3RrsYdSjktYaf/PY=;
        b=PKt3wgJ2Y9nD69KiGzcNhnsz3fiEMeH+xj/8ekSTvwcy2cAOXgBBcXB8eNDhydOtN1
         HSmT+dwXyemO+n8h5ICl+zpoe9Iy5xwjhwuAlFF3WaG1vkWExa+JgeZdO4T0jQrrJdc4
         6tO9DUoZw6H5FryNpg4lt03Dgflz+VJzrXwm3nW+ZflyPxxwoZvnB2rQekSyJ7Tks8Jo
         IQXLCfuFpBt17pFUlJHvS1wDcT0LbI/dOf6ziwhjKxRTeWM5dHno55/a5j+puAeMTVO6
         jgT+oCgBgd3XElMnMZIzoF+j9ODIcz4EKwstiBVZBAXdofFE5paOA0KaYJr8FrWK/WKD
         F81g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772655303; x=1773260103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GfNQFz0qALmfPoIx3Yqf69fSM+V1guhjH9flo/Vo5g=;
        b=qcY0NlQs2xUZVL8y73qJzPI/Ag569wTBnEw0iXx5sfcCVTpnVf03H1L55PHwuTGKUU
         w5A5mQvVh4yoF9L4imchZK3vTxRanXNiWwkeUxpxv3f1lqo+0cjZAOfjSVVvIVrVhNmE
         szaFUbEwmEkqQwr3MlH6bfaVgzLGdpnbbPnRO4wGkQuNQqgxlX3y4yt99A/zNAkBuPb8
         Hus8qEmH4pidXdl9JnIw1OsrDGLnYTWVLFhpPiuJ3Ko5K3QrZzpVxggDWG33EyF7EnSe
         nTOJPf2jFOvPOi1Gb8kAwZ2PGKS95t3PTGZIBbtkweeJj/bIkChTRTZ4XUfbqMBi0sIf
         1Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772655303; x=1773260103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GfNQFz0qALmfPoIx3Yqf69fSM+V1guhjH9flo/Vo5g=;
        b=mpnIvNJyDeRV3S2p1xokqE8bUkw99gcHzD9AegCKV71eodsJtVrSKJP2XgP8j9RHjt
         0J51N9d8f7LqRrED7m1fk3eUdJf42wwxfeHqdXgkNBtt+9uIzUG2j5S6C8/UZqnNGJFy
         FS/4n4Xr+oHQyQlRgLWOvooqyWIX7E9UZqmCl86GtRfYqcIdpqO7rXUGuZ7IUcTPirmK
         EJMDOyUETMJuE9WqREwOGfiCbBrNsjoJY8XtQVpXZJfCaGo8VkCzC9cadO9Jh3SNaPef
         RnOi5EMXtoaaa5bQR6+JQSBkdLavlPi7srhTScSffctZViQswRJVzkLCEX0/A9Dm74l+
         VZEg==
X-Forwarded-Encrypted: i=1; AJvYcCVgxdwQklZHZmdDKJo8csVI8A6EQQkNWiBaw5UBDZzKHZsMuDHoTvs5zeYyJoIlXa9h6eNb7Es=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RB2PW15V++g0hIHQebeoQhwTDJzdYFU50z1z3gZTrFQicDL+
	pz0ceI0FDNGfujHk4YHgLzLf7EabkoZ/TnElhFs1zggGQl0mA4P9WZvpzCQ8Y4K7qTdIr9FC3zf
	LhwgGF/BeJv+qCVbDDq0CSRICO59WA37eJrpZugTx
X-Gm-Gg: ATEYQzyLNs/+j9yTgTwnMpzCn5Kkq0IqB/t00GWM6/gt6jqxME74GNSdbOffyfTI19i
	Kqhk+FJr6eLxL9zKBJGTSwrL7FcOZuIgA2zZKIZkZImKcj3T+WqGqB7mMqch/ovu3pq/gEgm0sv
	CJV9AkHG7OQG+/0f1CtHJxZy7Pjq1EEuudqF8i1K1Oj16b8Gdrf0rLoU2ZAKd+Xsta6Xf4EALwY
	J1VOyJR8JFJIiHzlMHShO0xRl225nnVZjc+yZeHjMRrODHzE61v8mhA4acEHxC6bqBtS4oIAXIS
	Mk63v8+BNr+qS2tOv007slU5nvubnGgVbwORnx4Pqr+gj2PacXvjK0+vQGvo6H/5jZxNOw==
X-Received: by 2002:a05:6402:321d:b0:660:f98d:2288 with SMTP id
 4fb4d7f45d1cf-660f98d255cmr1816058a12.25.1772655303070; Wed, 04 Mar 2026
 12:15:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-7-kuniyu@google.com>
 <88077a77-8b9e-4372-bb39-c7a638cfa3d4@linux.dev>
In-Reply-To: <88077a77-8b9e-4372-bb39-c7a638cfa3d4@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 12:14:48 -0800
X-Gm-Features: AaiRm52T_t6qSTYYdmTx7ZNa4wzm14NqAvvBrpkSAcnYn9Ejazc9osTiZW3oT4o
Message-ID: <CAAVpQUAzGyf03WTEWrphDZMSxjrN6=WOeXmu-HTGWg+c9smvFw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A8229207820
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,linux.dev,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-264036-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 12:04=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/21/26 3:30 PM, Kuniyuki Iwashima wrote:
> > syzbot reported imbalanced sk->sk_forward_alloc [0] and
> > demonstrated that UDP memory accounting by SOCKMAP is broken.
> >
> > The repro put a UDP sk into SOCKMAP and redirected skb to itself,
> > where skb->truesize was 4240.
> >
> > First, udp_rmem_schedule() set sk->sk_forward_alloc to 8192
> > (2 * PAGE_SIZE), and skb->truesize was charged:
> >
> >    sk->sk_forward_alloc =3D 0 + 8192 - 4240;  // =3D> 3952
> >
> > Then, udp_read_skb() dequeued the skb by skb_recv_udp(), which finally
> > calls udp_rmem_release() and _partially_ reclaims sk->sk_forward_alloc
> > because skb->truesize was larger than PAGE_SIZE:
> >
> >    sk->sk_forward_alloc +=3D 4240;  // =3D> 8192 (PAGE_SIZE is reclaima=
ble)
> >    sk->sk_forward_alloc -=3D 4096;  // =3D> 4096
> >
> > Later, sk_psock_skb_ingress_self() called skb_set_owner_r() to
> > charge the skb again, triggering an sk->sk_forward_alloc underflow:
> >
> >    sk->sk_forward_alloc -=3D 4240   // =3D> -144
> >
> > Another problem is that UDP memory accounting is not performed
> > under spin_lock_bh(&sk->sk_receive_queue.lock).
> >
> > skb_set_owner_r() and sock_rfree() are called locklessly and
> > corrupt sk->sk_forward_alloc, leading to the splat.
> >
> > Let's not skip memory accounting for UDP and ensure the proper
> > lock is held.
> >
> > Note that UDP does not need msg->sk assignment, which is for TCP.
> >
> > [0]:
> > WARNING: net/ipv4/af_inet.c:157 at inet_sock_destruct+0x62d/0x740 net/i=
pv4/af_inet.c:157, CPU#0: ksoftirqd/0/15
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMP=
T(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/13/2026
> > RIP: 0010:inet_sock_destruct+0x62d/0x740 net/ipv4/af_inet.c:157
> > Code: 0f 0b 90 e9 58 fe ff ff e8 40 55 b3 f7 90 0f 0b 90 e9 8b fe ff ff=
 e8 32 55 b3 f7 90 0f 0b 90 e9 b1 fe ff ff e8 24 55 b3 f7 90 <0f> 0b 90 e9 =
d7 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 95 fc
> > RSP: 0018:ffffc90000147a48 EFLAGS: 00010246
> > RAX: ffffffff8a1121dc RBX: dffffc0000000000 RCX: ffff88801d2c3d00
> > RDX: 0000000000000100 RSI: 0000000000000f70 RDI: 0000000000000000
> > RBP: 0000000000000f70 R08: ffff888030ce1327 R09: 1ffff1100619c264
> > R10: dffffc0000000000 R11: ffffed100619c265 R12: ffff888030ce1080
> > R13: dffffc0000000000 R14: ffff888030ce130c R15: ffffffff8fa87e00
> > FS:  0000000000000000(0000) GS:ffff8881256f8000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000200000000700 CR3: 000000007200c000 CR4: 00000000003526f0
> > Call Trace:
> >   <TASK>
> >   __sk_destruct+0x85/0x880 net/core/sock.c:2350
> >   rcu_do_batch kernel/rcu/tree.c:2605 [inline]
> >   rcu_core+0xc9e/0x1750 kernel/rcu/tree.c:2857
> >   handle_softirqs+0x22a/0x7c0 kernel/softirq.c:622
> >   run_ksoftirqd+0x36/0x60 kernel/softirq.c:1063
> >   smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
> >   kthread+0x726/0x8b0 kernel/kthread.c:463
> >   ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> >   </TASK>
> >
> > Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")
>
> Cc: Cong Wang, who is the author of the quoted commit and also the
> author of the full UDP support in sockmap.
>
> JakubS and JohnF who are the maintainers of sockmap and skmsg. Please
> take a look also.
>
> Jiayuan Chen, you had submitted patches(/fixes) for sockmap/skmsg. It is
> a good chance to gain review credit.
>
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index 96f43e0dbb17..dd9134a45663 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -7,6 +7,7 @@
> >
> >   #include <net/sock.h>
> >   #include <net/tcp.h>
> > +#include <net/udp.h>
> >   #include <net/tls.h>
> >   #include <trace/events/sock.h>
> >
> > @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock *ps=
ock, struct sk_buff *skb,
> >                               u32 off, u32 len, bool take_ref)
> >   {
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
>
> A quick question. This case happens when the earlier
> sk_psock_skb_ingress_enqueue() failed?

Yes, the skb is charged by skb_set_owner_r() and the lock
is released, so I left skb->destructor as is and avoid extra
locking when sk_psock_skb_ingress_enqueue() fails.

>
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
> >   out:
> >       return err;
> > +
> > +unlock:
> > +     if (is_udp)
> > +             spin_unlock_bh(&sk->sk_receive_queue.lock);
> >   free:
> >       kfree(msg);
> >       goto out;

