Return-Path: <netdev+bounces-291933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LQ+EDoTFmojhQcAu9opvQ
	(envelope-from <netdev+bounces-291933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:40:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996355DCD1F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4922E30477D8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934AF3C3795;
	Tue, 26 May 2026 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoS3fOcT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C43C277C
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831490; cv=pass; b=m/Cj8u0LvM5qnQ4PNIo7B5igCMlyMFgW/si2VBCozkpIFJz+aJeijvNPBkMP+XoHBwAUSUtMHAZRzvegoW/iMnNImC4w/AC36WprpkTlPBceBaX7+BJdtlkX9sedLbNHX5tMAOOSi2Ud98HDcPo2iC2Yag0wVLSfPk8FOdwmWFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831490; c=relaxed/simple;
	bh=gQmyYwdEAcIENiu0zTOso9kcSPefm5PuS5PM74wbhT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cqz2tyFO5PipF3vU/52ZtB6DUx95YsFoRjc/DLxkSdH0OdA2mZGjF2djy4Hki899gU9q4TTDTnkHOeTmGVZe6bj4APHebtQzBd1pwuk7V05nPysWr4EzU6veV7GoBvMKuHTyKdi/+/kJ4fLV+xGuzzHWOX8t9H2SwiLeXcviwk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoS3fOcT; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bd4c61765dso106919287b3.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779831488; cv=none;
        d=google.com; s=arc-20240605;
        b=Goma26d+bJ2RNUxOAa7OBtqYMVv6QOU+Xd2h4mUoPoAhj6w3Mijx2gELoj6+r42Oqt
         UrkpDdiMt+GJVB56sytYiSTr6DR3LKM7T/eSdvhVhErtB4M3tEjXXyt2HzuHEMZTkl96
         o0cXZI+gCO1TBq2DIBiHVRJcjhv1PZh2czyNw2vT/CvLQBG78uBBoF52S4hxKNgZZOeY
         wgbTvK5MJeQ/y8BlWOyhj1UGYKa9+OUutXWvWW8FBDmFZsm7RZAUNgcZK/dIkPjt3JUV
         8U4ondkekkCnqObOG8Uvr7Xu9q5ul8PeyvAqR5vqWpg9IXAuk2M/TtmWYQEW7ysAFbC3
         +MEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=plsnEEQSbhGV7QIIM3FErJsIPshK6pJB+M+smdqUF88=;
        fh=oOfvRorzJsYyteTdh1orqaksi3TYSk0IQLRex0PbGB4=;
        b=UJTVtvQt7KoU662taODUIvkmS25iohrTa8oVT1RG0MojBbxOR68ulsyUSsh4RtYEah
         8bML2mMs59eeoj5Yl3xVcvWriesxzjQXl2Uwrh0eeP2/REhIqNHu71K+hiqo52xy0HQz
         nPcmxJn9CynDxHm8ICWio3quuGZhkK5lq4LG0bLIOVOpRWQTquvtV2Ac+gcoU7N+4RR2
         EyDYr4yHaZKyY2zdgDYsuIj/97RVP/pvue1ht6Mk9yziALh65GVsy7za5UgEAfFmxcSj
         MBUYE+lJAPgFR5veBmgcgDVnnoVhObMyJgx1xQB/O1QUalZqk8LXr6Idf8F7pgeW35Tq
         dQPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779831488; x=1780436288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plsnEEQSbhGV7QIIM3FErJsIPshK6pJB+M+smdqUF88=;
        b=qoS3fOcT+Kilj6RF0WwWg/mV2zmYIvMUS75gdxNAgwP9jMbsInIdpZpRpxxH2t74G+
         n6dRZUAmNvMVZn2lz2E4y8OUeoqqWzGsc6ZRraUm/vbM1NbHG/kIVpCTEi4L1nkFFFW4
         /3pqQr839b86BPuES79FSlwAo45/wAErvqEN3YRXzxpT/viJ+0Rglrkyb3eiZV0XRFqT
         I3y4yB10ePbyM2xRIjeUbqKwv1x3gRvBoknLraUE8Ff3CPpSqdt/1sbIeUh8lv6DABhJ
         bfRvAswBeJ9JZEwYKWtt6W4whxJJ7qxfkvVFymgY96AijisrO9iItcRGZBvXsfdkNi8G
         L+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779831488; x=1780436288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=plsnEEQSbhGV7QIIM3FErJsIPshK6pJB+M+smdqUF88=;
        b=hHQo5D0zbnuwe3tdsguPIgmqZmtWi7Z6xzg5LcxpvHET8U1Cz0oAAyd20m3xV9K2RY
         HQiK8rkHyFl6Pvb5B2c1r0qYeNDFAwbWECoh8sElFDkWF3Z57v1n9dLDL3kZTc5WZ6SN
         LXwS6BF2Kmd+DKJucLzOImbnEAf9i2e/pYfptVoZqEIxf2+Hj1xcaiAjfhivoPtKtj1W
         2lDMswfpeNc74vIzNWEuiS/HjtLHtZvl5Cjya/GTh4tNQQr/jV6vFqnO8gcLzQ9/M2CU
         EUECEvENQf7fELKPHfQCfDwBMUJFZPiM1+97vnCEVNuKRlyp+izkKltmrrT3s5OH44Fs
         GUGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xJfI84nSZsJRebMNCLn7HV6yz5fT8TWBdn3X9hs0Ov1QH/fALboF42XHjCXIhUVuYHNIKLV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmI1yDKnFRShH/fAe06BYtOPADEB2VAFnSCv9562+szhy02nbA
	eb11VYR2hk0U3AXXyuqfhjKR71omHX2Q9LblbtGWKM1ZyRhEaszC8LNh1WF8kQOcCH3IaCrjsVH
	zlKfZ49RM0U8yeufEyP6LsINSvsbMpF8=
X-Gm-Gg: Acq92OHyZ9y1gDgM+Kof2IGF/tAjv2oxtvnI5XOdPuu1Qsy81sBrA8F+0aszu3AGL0K
	C+RITEMT1GT9C3iwAltFtbukVurlVND+V2uyrWoJwFaBIbeg/CZcXJDasprfXL1ePCa8FDDKAhi
	waFpZRo5ZKXICJbGd06sZvWnGRmlZhIdhMXkIXSd9bxSKKFduwaiLAnlMGnpGHerJY9LN+ESejC
	V7w848lo/IeacEunFbWjzSUlNif+AR8WfuisInsy3+VNFYiLPMAJol9pdKepEbjR0GUPRQALQCD
	U/nSL7Jsbcqo6cMB44S+21nLSzjSGwRh2g==
X-Received: by 2002:a05:690c:c9b:b0:7bd:7e01:8d53 with SMTP id
 00721157ae682-7d3346d3757mr218203377b3.19.1779831487577; Tue, 26 May 2026
 14:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com> <20260523083001.2911931-11-kuniyu@google.com>
 <202652620435.m7WK.martin.lau@linux.dev> <CAAVpQUCd_eDq2nVz=um3T3iR5x7dSX1Rpi1YVTF0T5j16ok95g@mail.gmail.com>
In-Reply-To: <CAAVpQUCd_eDq2nVz=um3T3iR5x7dSX1Rpi1YVTF0T5j16ok95g@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 26 May 2026 14:37:54 -0700
X-Gm-Features: AVHnY4Ipdo3k_ItI27qeKZBIuTXC9Hu2bKBcmkqQ2o_TZi6eAv02HLrwRwcDsw8
Message-ID: <CAMB2axO6PeJOLWCfyGp2pq+2t8D8evEb07HgEyyw8qHG5TFGxA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/11] bpf: tcp: Add SOCK_OPS rcvlowat hook.
To: Kuniyuki Iwashima <kuniyu@google.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291933-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bpf_sock_ops.data:url,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 996355DCD1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 a

On Tue, May 26, 2026 at 2:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, May 26, 2026 at 1:47=E2=80=AFPM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On Sat, May 23, 2026 at 08:29:39AM +0000, Kuniyuki Iwashima wrote:
> > > Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVQ_CB.
> > >
> > > Let's invoke the BPF SOCK_OPS prog when
> > >
> > >   1. TCP stack enqueues skb to sk->sk_receive_queue
> > >      -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()
> > >
> > >   2. TCP recvmsg() completes
> > >      -> __tcp_cleanup_rbuf()

Not sure if this is just me, but having to differentiating call sites
by checking if skb =3D=3D NULL seems a bit less ideal (feels a bit
arbitrary and may be restrictive to extend in the future)

If new sockops is going to be built on top of bpf_tcp_ops, it would be
more obvious as different call sites will be different struct_ops op.
Although arguably tcp_queue_rcv(), tcp_ofo_queue(), and
tcp_fastopen_add_skb() may share the same struct_ops op.

> > >
> > > This will allow the BPF prog to parse each skb and dynamically
> > > adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
> > > until sufficient data (e.g., a full RPC frame) is available
> > > in the receive queue.
> > >
> > > Note that the direct access to bpf_sock_ops.data is intentionally
> > > disabled by passing 0 as end_offset.
> > >
> > > Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
> > > with bpf_sock_ops because payload is not in the linear area
> > > with TCP header/data split on and skb may contain a RPC
> > > descriptor in skb frag.  This also simplifies the BPF prog.
> > >
> > > The placement of tcp_bpf_rcvlowat() in tcp_ofo_queue() and
> > > tcp_fastopen_add_skb() is chosen to provide the same snapshot
> > > with tcp_queue_rcv().
> > >
> > > For example, if tcp_bpf_rcvlowat() were called before updating
> > > TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
> > > need to implement an unlikely if branch to strip SYN.
> > >
> > > In addition, TCP stack can queue overlapping skb into recvq.
> > > Once rcv_nxt is updated with a new skb, BPF prog cannot infer
> > > the previous one from skb->len.
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > ---
> > > v2: Add explanation of tcp_bpf_rcvlowat() placement.
> > > ---
> > >  include/net/tcp.h       | 12 ++++++++++++
> > >  net/ipv4/tcp.c          |  2 ++
> > >  net/ipv4/tcp_fastopen.c |  2 ++
> > >  net/ipv4/tcp_input.c    | 10 ++++++++++
> > >  4 files changed, 26 insertions(+)
> > >
> > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > index bc95d8e7b62e..a409f2ea710f 100644
> > > --- a/include/net/tcp.h
> > > +++ b/include/net/tcp.h
> > > @@ -2889,12 +2889,24 @@ static inline void bpf_skops_init_skb(struct =
bpf_sock_ops_kern *skops,
> > >       skops->skb =3D skb;
> > >       skops->skb_data_end =3D skb->data + end_offset;
> > >  }
> > > +
> > > +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> > > +
> > > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff =
*skb)
> > > +{
> > > +     if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLA=
G))
> > > +             bpf_skops_rcvlowat(sk, skb);
> > > +}
> > >  #else
> > >  static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skop=
s,
> > >                                     struct sk_buff *skb,
> > >                                     unsigned int end_offset)
> > >  {
> > >  }
> > > +
> > > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff =
*skb)
> > > +{
> > > +}
> > >  #endif
> > >
> > >  /* Call BPF_SOCK_OPS program that returns an int. If the return valu=
e
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 3afeb69a547a..f7e32891bb4e 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int co=
pied)
> > >               tcp_mstamp_refresh(tp);
> > >               tcp_send_ack(sk);
> > >       }
> > > +
> > > +     tcp_bpf_rcvlowat(sk, NULL);
> >
> > hmm... so NULL is a way for the bpf prog to tell where it is called?
>
> Yes.  The selftest fetches bpf_cast_to_kern_ctx(ops)->skb first to
> check it since we need to access skb->cb anyway to read
> TCP_SKB_CB()->{seq,end_seq} for non-NULL case.
>
>
> >
> > With skb NULL, what does the bpf prog usually do?
>
> In that case, the prog reads tp->copied_seq and some sequence
> numbers from sk local storage and calls kfunc to adjust sk->sk_rcvlowat.
>

