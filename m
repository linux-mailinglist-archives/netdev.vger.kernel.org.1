Return-Path: <netdev+bounces-291936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DfbFPsVFmq7hQcAu9opvQ
	(envelope-from <netdev+bounces-291936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:51:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B18D25DCE47
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A06F3026593
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F263BC668;
	Tue, 26 May 2026 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMslIW7Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF13B4E83
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832285; cv=pass; b=UKjZ5RBRc1bKbJMl0LFgcWDj+fC2uN06/hWryd1RMaJ02x6Wb7q6ifCpNC9sPrSqhfM3tNP2hmio1wgOk4QWisVQX7gczq9LVGWsAlUuQ1DYYq4aqAn666/iarDLAcDcoZVFmqCKwGbuKJp6IEkAxGRNCw6GR3oZqWCat0PqYTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832285; c=relaxed/simple;
	bh=AoeM8g6x9IYVveJxQcTNP3LqVXcO3jwkZgfHAxvHIsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQADrcznQtnubK4+qlOcktMe8JTzmvtP/cw9Bf6GZaYRwOR3BV0t14zMEHPiS0WksILBDaP7PIfwLcV//Sc7ObeM2jsvzt0zxcp7hwP0amN5S+kAozot1HdJ9ifG/K4HDJn7108wVi3k1qrUurOGQ18MsYU7wVF/zUIdH8gw0jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMslIW7Z; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-136b46c3540so3422262c88.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779832283; cv=none;
        d=google.com; s=arc-20240605;
        b=EKut/pOKL/GlUXtSC9f28SNZljBP9eBuPXyM0TQFnN81fVJloPfTY4Ylnkj6xbc646
         4/XJuVO+MrTiPPEFXR3qiQyV82m1+TreMbxRjzSACVFxXczXBlSBvfTa095WV3fM13Qu
         5dhD/n76T+4e/9L2zDKvJJpn/V5Kk7DYszzHmAteGeqbfc8YXguWD3CvtumNzAmV38Gq
         ++y2vMswvWLHB2m5sT1ZhO7a30gSxrGA5JhKUEnJ3EuYYz7YQHIR2Zi8I8aN7Rc0gUbq
         tCSMZAqSvo2fNInkynvd9/OlzeUe3YyAwliRm38Bkg2I0Sp1IYW9V1f3Y/GDTCj1y2P4
         FsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lQqGVBd+cocCt/UgJ7d/2rWN5gR8Q6QOgQJb5mSWO2g=;
        fh=kMlyffOMfomQrdVJkJB3pqFaYq14G9rLQqvYByHAmeQ=;
        b=CqzgrKivyM3Vjt6FNFTFQQ3GyVvIzJfgiUJWgEgN2KmguzQyCw8axz0AD9TtXBcyjG
         X1Mg6K4YCT/5ax39jADL1L6jh1U7oEENHX6x21w7EKXHVIQHuLuOi25nDmRi8MNu/JkU
         wL0G6Imx6MtrlzHSs+mwG0uwpDGRuwVL4qzzOKQ4vf2o7+9x+jJsvtK4Oj8E9WgiJUww
         V3ytfU73/d1hLnIO7y1gBWIXrcgbxhDR+wkJRxIQpExavGf6EaK+BK9+6VQ6J/Kr/7ai
         EIpNtKXuuwAFor8B5zHOq1rKLGskApYBDL6RPZCMR6j6H67YkjCh8Oo5pKXHS6JIFf9e
         wbDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779832283; x=1780437083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQqGVBd+cocCt/UgJ7d/2rWN5gR8Q6QOgQJb5mSWO2g=;
        b=bMslIW7ZZJj2nSeKaadqXJ21FpiidiBHbzcB4uN/zIutrYKYJfyasqi1VO0MuF50hA
         zg2BvIVI6dnym0WixNMalMBHgiQmvBjaOdgsDehv8z/aBbNBne8nV48DsN0fdSs3gXJu
         lx7vCtgOEA/hdFKf5TDWg8A73aff3GDTZKZohhanRmVr2l+uUQbw9oTqiwXJf3dilTlH
         VGPEvp+ecavySCh8c0VDkhdJ1DO/G2F0rlFGwMYZIWxGOWXM76NwBFLHLobkx1JYpTKv
         vsVmJTKoq7gTNbBIwWfkb3peDRfZCiKmmL1yzjUkpDDO6kfa7tD2+cigI0QEds8jW0Zp
         Khjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779832283; x=1780437083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQqGVBd+cocCt/UgJ7d/2rWN5gR8Q6QOgQJb5mSWO2g=;
        b=SADSG2zjGYSmcwxtRFeM+bPzrtOibwP+8544ljqbbIrBRhxLU2jYAFaRARfjxFIc1i
         SIA8mZOPMNP+ApXmx7W8ShUQ5TKd2IOAzdre7cSKRaHocslVgye+MviUkq4Rkg3KGLyK
         bqacqeUafYbK/tnZY7Ng6c5ARTkAxctsFVKsAxojskTPYsy59dOldduynL2G1pmiHQ+E
         vlCid4LsVY6IeA2wbIxDIoC0rphgfsN0XMo0flHqdWcjufiEKVXqKmo8zeNKML6832VO
         WEC/uMAoxL2Nw8gL9dJbC2K1RasGOO78kDVlm/V8ZekOREziiX3Bu4mpOPG+FTLPQ6yG
         LWzA==
X-Forwarded-Encrypted: i=1; AFNElJ/pdJTf4vCPClbhFpA6ZSJwcb5jM9i7XoEx88hLntZgl0jOq+z30I0MVW6ovLdVaLg7I2wQmqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSgXEH5MrzihjuX0dgs82KmtCj7ZcfWdodgkpxrbvQ+in0Cn7
	P4cquS76CC6oNQfi1mhDDk9DZeVVQgQVn3Ndz2kysPyjYQf+7xoy0uKQW6qiX9SK5QZAeudabjZ
	vHd30frMpQ1sQBC0S0yqowtEvQ28MTCTF5SfqI4Xr
X-Gm-Gg: Acq92OFGgVsQUSCOvhgnia01bPL6FdRD1bu0kHtWkTmD9uLxgtXpEmEqXrFQbl96IwH
	aYI3xl/7pVlCakbSVpzulRzWnE+OS52PkZrhyhGq337KLKxrTm4wSFa2NIf5YRN1v5AW2owKyyh
	5JaZ91uh9i1hMqQlUIt8pnTYTgJCRMZzFWV+wFoBBC7iitEGjyHVS10jMGRrySgZPG94URZKZof
	QMxlHLF4IW4QCGSV112oHTsWzGbJD/OwE0yJ8A5s4ColMyGCdXVLoS3EnPwr9DRC9XV0ZTIXqEa
	Pm9lmuKeUZx8kCnJ09tclEOcY3Y0Wdla8MwIR4U1Oa0n9pSPP2fhbSplUDJUrwDcbRs9YG52RyW
	Aut8CphTPHyUy84OQ/RGhS8tFCHD9aL8F33xDPcifLcmgdXYZLNOyo+RxZvhQohpsfgoc8Hk=
X-Received: by 2002:a05:7022:1a81:b0:132:6877:eea with SMTP id
 a92af1059eb24-1365f819092mr7112298c88.12.1779832282746; Tue, 26 May 2026
 14:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com> <20260523083001.2911931-11-kuniyu@google.com>
 <202652620435.m7WK.martin.lau@linux.dev> <CAAVpQUCd_eDq2nVz=um3T3iR5x7dSX1Rpi1YVTF0T5j16ok95g@mail.gmail.com>
 <CAMB2axO6PeJOLWCfyGp2pq+2t8D8evEb07HgEyyw8qHG5TFGxA@mail.gmail.com>
In-Reply-To: <CAMB2axO6PeJOLWCfyGp2pq+2t8D8evEb07HgEyyw8qHG5TFGxA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 May 2026 14:51:11 -0700
X-Gm-Features: AVHnY4J3Rs6sv4H8De29931zUN6J9wyMHkX5s4zEmvSh1A9Ll-gZnC3sgGqG_jM
Message-ID: <CAAVpQUCSWkMd-_FBqHe6sO1gEmuyS3twv65Rb45wc6-4PsYUEg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/11] bpf: tcp: Add SOCK_OPS rcvlowat hook.
To: Amery Hung <ameryhung@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291936-lists,netdev=lfdr.de];
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
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,bpf_sock_ops.data:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: B18D25DCE47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 2:38=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
>  a
>
> On Tue, May 26, 2026 at 2:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > On Tue, May 26, 2026 at 1:47=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On Sat, May 23, 2026 at 08:29:39AM +0000, Kuniyuki Iwashima wrote:
> > > > Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVQ_CB.
> > > >
> > > > Let's invoke the BPF SOCK_OPS prog when
> > > >
> > > >   1. TCP stack enqueues skb to sk->sk_receive_queue
> > > >      -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb(=
)
> > > >
> > > >   2. TCP recvmsg() completes
> > > >      -> __tcp_cleanup_rbuf()
>
> Not sure if this is just me, but having to differentiating call sites
> by checking if skb =3D=3D NULL seems a bit less ideal (feels a bit
> arbitrary and may be restrictive to extend in the future)

I think Martin shares the feeling :)

I chose the way for two reasons: 1) bpf_skops_established()
already accepts null skb (for unlikely TCP_REPAIR_ON), and
2) adding another op just for the case seems redundant (it adds
more conditionals in the fast path, kfunc) while bpf prog is capable
of distinguishing a null skb.


>
> If new sockops is going to be built on top of bpf_tcp_ops, it would be
> more obvious as different call sites will be different struct_ops op.
> Although arguably tcp_queue_rcv(), tcp_ofo_queue(), and
> tcp_fastopen_add_skb() may share the same struct_ops op.

Yes, this sounds fascinating.

>
> > > >
> > > > This will allow the BPF prog to parse each skb and dynamically
> > > > adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
> > > > until sufficient data (e.g., a full RPC frame) is available
> > > > in the receive queue.
> > > >
> > > > Note that the direct access to bpf_sock_ops.data is intentionally
> > > > disabled by passing 0 as end_offset.
> > > >
> > > > Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
> > > > with bpf_sock_ops because payload is not in the linear area
> > > > with TCP header/data split on and skb may contain a RPC
> > > > descriptor in skb frag.  This also simplifies the BPF prog.
> > > >
> > > > The placement of tcp_bpf_rcvlowat() in tcp_ofo_queue() and
> > > > tcp_fastopen_add_skb() is chosen to provide the same snapshot
> > > > with tcp_queue_rcv().
> > > >
> > > > For example, if tcp_bpf_rcvlowat() were called before updating
> > > > TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
> > > > need to implement an unlikely if branch to strip SYN.
> > > >
> > > > In addition, TCP stack can queue overlapping skb into recvq.
> > > > Once rcv_nxt is updated with a new skb, BPF prog cannot infer
> > > > the previous one from skb->len.
> > > >
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > ---
> > > > v2: Add explanation of tcp_bpf_rcvlowat() placement.
> > > > ---
> > > >  include/net/tcp.h       | 12 ++++++++++++
> > > >  net/ipv4/tcp.c          |  2 ++
> > > >  net/ipv4/tcp_fastopen.c |  2 ++
> > > >  net/ipv4/tcp_input.c    | 10 ++++++++++
> > > >  4 files changed, 26 insertions(+)
> > > >
> > > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > > index bc95d8e7b62e..a409f2ea710f 100644
> > > > --- a/include/net/tcp.h
> > > > +++ b/include/net/tcp.h
> > > > @@ -2889,12 +2889,24 @@ static inline void bpf_skops_init_skb(struc=
t bpf_sock_ops_kern *skops,
> > > >       skops->skb =3D skb;
> > > >       skops->skb_data_end =3D skb->data + end_offset;
> > > >  }
> > > > +
> > > > +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> > > > +
> > > > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buf=
f *skb)
> > > > +{
> > > > +     if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_F=
LAG))
> > > > +             bpf_skops_rcvlowat(sk, skb);
> > > > +}
> > > >  #else
> > > >  static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *sk=
ops,
> > > >                                     struct sk_buff *skb,
> > > >                                     unsigned int end_offset)
> > > >  {
> > > >  }
> > > > +
> > > > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buf=
f *skb)
> > > > +{
> > > > +}
> > > >  #endif
> > > >
> > > >  /* Call BPF_SOCK_OPS program that returns an int. If the return va=
lue
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index 3afeb69a547a..f7e32891bb4e 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int =
copied)
> > > >               tcp_mstamp_refresh(tp);
> > > >               tcp_send_ack(sk);
> > > >       }
> > > > +
> > > > +     tcp_bpf_rcvlowat(sk, NULL);
> > >
> > > hmm... so NULL is a way for the bpf prog to tell where it is called?
> >
> > Yes.  The selftest fetches bpf_cast_to_kern_ctx(ops)->skb first to
> > check it since we need to access skb->cb anyway to read
> > TCP_SKB_CB()->{seq,end_seq} for non-NULL case.
> >
> >
> > >
> > > With skb NULL, what does the bpf prog usually do?
> >
> > In that case, the prog reads tp->copied_seq and some sequence
> > numbers from sk local storage and calls kfunc to adjust sk->sk_rcvlowat=
.
> >

