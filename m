Return-Path: <netdev+bounces-285965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNadJS9C/mkZogAAu9opvQ
	(envelope-from <netdev+bounces-285965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:06:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E22854FB54A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BCAF302E409
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC4635DA79;
	Fri,  8 May 2026 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srwmsTnK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885031F98F
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270763; cv=pass; b=tncKE0D8EggE/kdF7S+RHBWUJ6eqUW5AxJwvbLrihoDnEHJ3z2svePYRWQha5pw42sxQtdDuvH6eJx/En/NlYb1qLvhUfVH5xcs2uMR/8vdCfhQfClmFlwzNKrUfds6KBz2QiWnRcTljIIJAsN8z7EDjmrnprBbDdeiXi8QrhfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270763; c=relaxed/simple;
	bh=ljYsOJ7jqnNRKK8F1FTelk1JVXCB4hRGIxbFCH/hs4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaEVA8ie2pS4AZFvIPu4PYrIbNUdCmUfXdYrDslljMIjlccB7BzsOjuekgfXzYF0i46GdyoXCmPEYOrMyM5kGJNyhl6zhxBlJPq3mdUhlZdtegvWZ4mt8LShEbYwfH+T8DC0oJfSZlmWeeMZY/ZOT0WVfF3pegi7rjY73BArC08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=srwmsTnK; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12713e56abdso1629210c88.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 13:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778270762; cv=none;
        d=google.com; s=arc-20240605;
        b=C1cMwJ8xvGHeraB1pVOYiaTRn6Y7+Dsak8mV28zwernc/pAa1y8XPJ45HnHOP0fZb/
         yO6+GB1Vr77sEOeK3nO55DqwnhLAJX4Xr8AX2X1NysThDvsmsJyb3Y4PWrCE8GMOAI1S
         SJRY/wBKkZgWgqtpCgKTgiA4eA+sUIz2LJmeF/Y9wzwGnFzreDAPsBPMzg7RB/kQvo+h
         GBtpZUYpy6pgqjqB0J7ER/6chFJuB+un8RrK6MPPIiJkUYJfuLwKcAHZ8YJNTLcbtd2K
         eNlpZIHvC9Djm8lcVNVIG2wwf6GkzeRlh3diqFbrUClK6/6gThuqepnbWYXfyXjfIXRO
         sdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I0JZM/GQp10NFG/z1zCxRMzw+i+x1LWJdYqOb718wvE=;
        fh=/riuT7bmX4R1Pwil5mSwt6Rl/GbrAkU7TJiMG3HhGY8=;
        b=XM6/Rpr70LrqXmD3/hRCI+MXFQTczW2iAYfxQxRKinNSmILPXxBtz/EGBPumozcfvq
         LQ3L0aFvuyD274UThKvSzqLcRO5K4jucHmX++Hn49GzhhffnuhhvRxXHTdfD+klxEXPX
         qm/7njeihEJiwq/Wq/6f/b/HOa4XATm0Ml/YF2LjwFIzqrY8BQwygGUBmra1fZ8OuDmV
         2TFfR3XfYszsf+QNhEUUuhxVHAmHVKxJifojQzfK7Usls/MXf1VGOXFX4D6Ursa3XOtJ
         54mdFNiq8CFRhDM3UcsTVBxtisQlGnFNRfNaKjxA6wjkZbECUeNknj6Kuh3jihidl/ye
         stZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778270762; x=1778875562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0JZM/GQp10NFG/z1zCxRMzw+i+x1LWJdYqOb718wvE=;
        b=srwmsTnKdZrlgUYBV3gw2qeyCBFYZA323zVBIHNAoUmECgynXUr5r4IJ0zlLkMaSHo
         y22XHknJAwdUVlcF3rc02ntPd+4TjS1+KWbSURVKxw6i/idiE/LmQsR3hfz9KAXzHHfx
         pmDf3FtgUgJ9bZCXEMTOI5mZM+qy3Weu5hZQ5MoQuKW3fTI3m/QES1QQEaHzg9eoawy8
         BSKYZdKKMKWuDDAIULmm09tJDwooWRFjfAN8oR8HRoAymv6s6QDp57a9U3HGUCmatQ2q
         L5QS6HbKMwqqdv8Zdp/EaXKAj/0hF/4EPd7eR27erktefKOu2kblED+NsUV68xtGHZER
         LGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778270762; x=1778875562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I0JZM/GQp10NFG/z1zCxRMzw+i+x1LWJdYqOb718wvE=;
        b=HzdIldsiGV/EH/7e32nkMehbvtZ2sCaSmdlkrVDdNrYzHsBfBZmcSK3P99KOhXTDPz
         iR/X0nUYjlwHloQa+YLtW7F+NRGciZ/3OyMFDobUyxYJMw6tFLIMffkH5JYAzEalmNse
         GehvZR/XkQV0qjvOz6YMaXo8jdlD0lpxYROU5nLpZfUYpInL1SWn+14e76YBMZHRRaIp
         tVA6gJp9m1l1+cSNDvNy3ywamF2GeWnMAf+HMPsSoVKBqE/6yhHC0wAoULiJclN6ziVU
         3HizpY4+CvqbdWxc2p8IwxX/JLa2AYcRae/rVGCbBl4b+Z2BWRJgs+SNk3HcHdbptCgH
         PFnw==
X-Forwarded-Encrypted: i=1; AFNElJ+jU7KePTru55QGxJ4TLpUb35jC1S+l3U4ZgLFfuvPtE4lYHCMlx8tLdTroQxoChMhOWTqhaXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHIO2CJrcHDQb1Z9hLMGG024L4KbPcbJBxpOoL7tc8kxxpqGUR
	XPAnCVbvRs236F6krPODHQ+T6Ccqg649L8R6fQ7Y6QfZ1bFiwPJuio5jugmeQEjJ03jc6AmskKn
	QH6Wsq+S8UB32rM+aT7IwPDndd3J7MldatfGCdD77
X-Gm-Gg: AeBDieviNuidWbMtAc/VTZajwpKhIBQ3dOXdm/R9HRKUuv+gEAT6+n4McaVvqJUtarR
	gHi1Uglfwg0we71t5rth08kMxjrxLjB/cOfilnfa66gOrGN69k81pLKNKmTDWvZlGJ0KvdRRudX
	gnPHYaRN1qnOTGY6mqO2U86YnVAh0VUvIf7dofQKZKRrUPyt/C7i+Gcm9J5b9jk/6z8egCEJ01D
	8AgzMgS2N+rMbaKYmQfwW2z40BZtn0bBFZM9wZjF5MZFJ7eXcjOMHfNXbaCo5lZteRJmCJ+Y+qN
	q5GyBz/XGnmc36RRY2umiKucU2ouCIXBETMdtR8+pe+VWSJY8SoOK4557uguAFuWUGyzG6c5TCx
	bpS3GpEnAc+XEaT01I9G6tqvBL88DwNk=
X-Received: by 2002:a05:7022:6628:b0:12c:91ef:6e63 with SMTP id
 a92af1059eb24-1323ab647a9mr3606912c88.7.1778270761051; Fri, 08 May 2026
 13:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com> <20260508073355.3916746-8-kuniyu@google.com>
 <af4AO2-9jwluWuik@devvm7509.cco0.facebook.com>
In-Reply-To: <af4AO2-9jwluWuik@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 13:05:49 -0700
X-Gm-Features: AVHnY4KxyF7PmxKzfFRoR9wPAhtUQEb5E2m1xogbHPUGkBr3Dc2h_5gVeNU3EmI
Message-ID: <CAAVpQUBTbcpf+kNOqXj-2=Qjx86TeZ-sHVGKT-Vwj=GVXz4hEA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 7/8] bpf: tcp: Add SOCK_OPS rcvlowat hook.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E22854FB54A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285965-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 8:28=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> On 05/08, Kuniyuki Iwashima wrote:
> > Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVLOWAT_CB.
> >
> > Let's invoke the BPF SOCK_OPS prog when
> >
> >   1. TCP stack enqueues skb to sk->sk_receive_queue
> >      -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()
> >
> >   2. TCP recvmsg() completes
> >      -> __tcp_cleanup_rbuf()
> >
> > This will allow the BPF prog to parse each skb and dynamically
> > adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
> > until sufficient data (e.g., a full RPC frame) is available
> > in the receive queue.
> >
> > Note that the direct access to bpf_sock_ops.data is intentionally
> > disabled by passing 0 as end_offset.
> >
> > Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
> > with bpf_sock_ops because payload is not in the linear area
> > with TCP header/data split on and skb may contain a RPC
> > descriptor in skb frag.  This also simplifies the BPF prog.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> I was reading the series expecting to find some skb_queue_walk-like
> implementation, but since it's a cgroup hook we obviously don't
> need to do that.. So at this point BPF_SOCK_OPS_RCVLOWAT_CB_FLAG
> is basically a "rx queue skb" hook, right?

If recvmsg() hook w/o skb is not confusing, yes.

> So should we make
> the name more generic? There is really nothing lowat-specific
> here besides your new kfunc to read the payload?

Do you have any suggestions?  BPF_SOCK_OPS_RCVQ ?


>
> > ---
> >  include/net/tcp.h       | 14 ++++++++++++++
> >  net/ipv4/tcp.c          |  2 ++
> >  net/ipv4/tcp_fastopen.c |  2 ++
> >  net/ipv4/tcp_input.c    | 10 ++++++++++
> >  4 files changed, 28 insertions(+)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 4e9e634e276b..003e46c9b500 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -737,6 +737,20 @@ static inline struct request_sock *cookie_bpf_chec=
k(struct net *net, struct sock
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_CGROUP_BPF
> > +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> > +
> > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *s=
kb)
> > +{
> > +     if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVLOWAT_CB_F=
LAG))
> > +             bpf_skops_rcvlowat(sk, skb);
> > +}
> > +#else
> > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *s=
kb)
> > +{
> > +}
> > +#endif
> > +
> >  /* From net/ipv6/syncookies.c */
> >  int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *=
th);
> >  struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 1d9e52fc454f..80144b97a87a 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copi=
ed)
> >               tcp_mstamp_refresh(tp);
> >               tcp_send_ack(sk);
> >       }
> > +
> > +     tcp_bpf_rcvlowat(sk, NULL);
> >  }
> >
> >  void tcp_cleanup_rbuf(struct sock *sk, int copied)
> > diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> > index 471c78be5513..91bf421fc5b6 100644
> > --- a/net/ipv4/tcp_fastopen.c
> > +++ b/net/ipv4/tcp_fastopen.c
> > @@ -281,6 +281,8 @@ void tcp_fastopen_add_skb(struct sock *sk, struct s=
k_buff *skb)
> >       TCP_SKB_CB(skb)->seq++;
> >       TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_SYN;
> >
> > +     tcp_bpf_rcvlowat(sk, skb);
> > +
>
> I'm also not sure about the particular placement of some of these..
> For example here, why do it before updating tp? Why not after?
>
> (and same for tcp_ofo_queue)

Basically, it's to give the same snapshot with tcp_queue_rcv().

For example, if you call tcp_bpf_rcvlowat() before updating
TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF
prog will need to implement an unlikely if branch to strip SYN.

Also, TCP stack can queue overlapping skb into recvq.
Once you update rcv_nxt with a new skb, you cannot infer
the previous one from skb->len.

