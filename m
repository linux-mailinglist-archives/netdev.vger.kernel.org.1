Return-Path: <netdev+bounces-46704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1417E5F95
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 22:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14DB1C20BD4
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 21:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E24374CB;
	Wed,  8 Nov 2023 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEvman0/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547C37175
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 21:01:58 +0000 (UTC)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05046EA
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 13:01:58 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-49e15724283so65158e0c.1
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 13:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699477317; x=1700082117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiM3LuIXvGAfyi5F2iKLHCbu8z2UXm9Y3n0WdD8YYls=;
        b=iEvman0/+xNNaWzcTrEIPGESxg8S1nvfJ8yeCpLC6nbcYDeTm9njjy0MqzHh4tHK6z
         Zj35srWFG+ySwmPPigPB/7FFlnhT0/8a+ttuVtxI0IySLmNEkT3UnsAjdTvH1pIWnfhu
         KgLlML+wLdtwn3ZKzcM67psjuSrtvd6+aKKvmdSVuE1B1d4CipkhaCCV/nN14a2pGFgM
         qT9m5sIuahfl3IHfaWmNQGVf/e6cs7djQ78hxbN37V9cAbzr/zRl4kI5SeuNsMzZNZgb
         0/S6gcO/SIuAR5CpyLpsfSHYppwpXAZqh2bdtKXMMtqTaxcVczF7xNByFhVeyksLw8ga
         CMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699477317; x=1700082117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiM3LuIXvGAfyi5F2iKLHCbu8z2UXm9Y3n0WdD8YYls=;
        b=UxBHtWW3l6KUuFRvGW2HwZ2wD5AB6LB29S7+cCeYkhYVWk4rBn8kHLbniojy9KnmSZ
         8UUGtbYKgKFVivFzHP+us4BbT5Zq1vPTq8Qt+K1/xrfzSb7dAwBAQ3hlBZJ8V9wG+TGu
         PYVpw4IKcaca55JCms17FgdIrR7rAgJJSU1bZL1K9q1kvs9GJbNOhhtj6RgJJLeAQqTe
         ew5I4H6BQJ3V+WCL9zTnFgwwZDfc6O8HUZY2M80xSn7A6ZaHXfwmsEahv+M8aped6b9q
         AU2nDmDb+qq+91lneaLdt9PX9eKcOWsuWhV2M/ySlGLgnPz/A0137lQC9veKu50YWsRd
         yp1w==
X-Gm-Message-State: AOJu0Yz3moEa5GozQVECPLtHGelJ18v8KXoSuhkYbIZetta7tAHLK2kk
	Zdjx67piIAeyjfAazNzyRUZMK7m5mnmkb90FDRbXNA==
X-Google-Smtp-Source: AGHT+IFHfzUhQpGjZnmcMNbQNIB2J8SGGa2wGFeJ44qee8aLxODhFc/oVAoMTNdAcDtYar9T2m54xyl1lLZ16eD87rg=
X-Received: by 2002:a1f:9cc7:0:b0:49a:88a9:cac6 with SMTP id
 f190-20020a1f9cc7000000b0049a88a9cac6mr2980720vke.11.1699477316866; Wed, 08
 Nov 2023 13:01:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108202819.1932920-1-sdf@google.com> <CANn89iJnX6sm1UHbU6TKzoWJJyNLGjpN_amb8bkmgnLk8Qj_gQ@mail.gmail.com>
In-Reply-To: <CANn89iJnX6sm1UHbU6TKzoWJJyNLGjpN_amb8bkmgnLk8Qj_gQ@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Wed, 8 Nov 2023 13:01:44 -0800
Message-ID: <CAKH8qBvFTHQ9FOX8_ta7M2aq8ExZnoefLp+nOygE3m1z+433Ew@mail.gmail.com>
Subject: Re: [PATCH net] net: set SOCK_RCU_FREE before inserting socket into hashtable
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 12:58=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Nov 8, 2023 at 9:28=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >
> > We've started to see the following kernel traces:
> >
> >  WARNING: CPU: 83 PID: 0 at net/core/filter.c:6641 sk_lookup+0x1bd/0x1d=
0
> >
> >  Call Trace:
> >   <IRQ>
> >   __bpf_skc_lookup+0x10d/0x120
> >   bpf_sk_lookup+0x48/0xd0
> >   bpf_sk_lookup_tcp+0x19/0x20
> >   bpf_prog_<redacted>+0x37c/0x16a3
> >   cls_bpf_classify+0x205/0x2e0
> >   tcf_classify+0x92/0x160
> >   __netif_receive_skb_core+0xe52/0xf10
> >   __netif_receive_skb_list_core+0x96/0x2b0
> >   napi_complete_done+0x7b5/0xb70
> >   <redacted>_poll+0x94/0xb0
> >   net_rx_action+0x163/0x1d70
> >   __do_softirq+0xdc/0x32e
> >   asm_call_irq_on_stack+0x12/0x20
> >   </IRQ>
> >   do_softirq_own_stack+0x36/0x50
> >   do_softirq+0x44/0x70
> >
> > I'm not 100% what is causing them. It might be some kernel change or
> > new code path in the bpf program. But looking at the code,
> > I'm assuming the issue has been there for a while.
> >
> > __inet_hash can race with lockless (rcu) readers on the other cpus:
> >
> >   __inet_hash
> >     __sk_nulls_add_node_rcu
> >     <- (bpf triggers here)
> >     sock_set_flag(SOCK_RCU_FREE)
> >
> > Let's move the SOCK_RCU_FREE part up a bit, before we are inserting
> > the socket into hashtables. Note, that the race is really harmless;
> > the bpf callers are handling this situation (where listener socket
> > doesn't have SOCK_RCU_FREE set) correctly, so the only
> > annoyance is a WARN_ONCE (so not 100% sure whether it should
> > wait until net-next instead).
> >
> > For the fixes tag, I'm using the original commit which added the flag.
>
> When this commit added the flag, precise location of the
> sock_set_flag(sk, SOCK_RCU_FREE)
> did not matter, because the thread calling __inet_hash() owns a reference=
 on sk.
>
> SOCK_RCU_FREE was tested only at dismantle time.
>
> Back then BPF was not able yet to perform lookups, and double check if
> SOCK_RCU_FREE
> was set or not.
>
> Checking SOCK_RCU_FREE _after_ the lookup to infer if a refcount has
> been taken came
> with commit 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
>
> I think we can be more precise and help future debugging, in case more pr=
oblems
> need investigations.
>
> Can you augment the changelog and use a different Fixes: tag ?
>
> With that,
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Sure, thank you for the timeline! Will resend shortly with the updated
changelog.

> >
> > Fixes: 3b24d854cb35 ("tcp/dccp: do not touch listener sk_refcnt under s=
ynflood")
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  net/ipv4/inet_hashtables.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index 598c1b114d2c..a532f749e477 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -751,12 +751,12 @@ int __inet_hash(struct sock *sk, struct sock *osk=
)
> >                 if (err)
> >                         goto unlock;
> >         }
> > +       sock_set_flag(sk, SOCK_RCU_FREE);
> >         if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
> >                 sk->sk_family =3D=3D AF_INET6)
> >                 __sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
> >         else
> >                 __sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
> > -       sock_set_flag(sk, SOCK_RCU_FREE);
> >         sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> >  unlock:
> >         spin_unlock(&ilb2->lock);
> > --
> > 2.42.0.869.gea05f2083d-goog
> >

