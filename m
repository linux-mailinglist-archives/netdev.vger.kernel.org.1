Return-Path: <netdev+bounces-291928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAHDBZ4LFmrYhAcAu9opvQ
	(envelope-from <netdev+bounces-291928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:07:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BF35DC995
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40C87302DF50
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DBA3C1411;
	Tue, 26 May 2026 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6ZIWRmM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E9F3A6B9A
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829654; cv=pass; b=KPM+m42UvjKWPod1r9xXulKVNjOn6VR2g0d5WvJLvve75elDsLr8rwwKAni8hq7g2nyhlvfHIh4tlt1Vk+hWR6EV400mcY3NpjJImyCIMx3AU9rOg3+vW6l3dcIqFWBCuvzJuP1AU9Qtxk9X4Z8QSkEJcqSEVOe3Bp+PDxd7DUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829654; c=relaxed/simple;
	bh=XqF3j13cxi/d9CWy5HLYmYXPbEh0BqsKm5gpvCmGXeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4XGef9EdUda6bcSAFO2D/Bq13bnsjgvzCCKTz+4vKv2g9gaFwkQWpqCrqGDc3crg9u9py/6swDqeTOEq5ju9xTQ96/4ABA8mOCsbcm6tltWO2zIptNjz5LjKYWbwnJXfPLycal+OHJprp5mHxMQED7SYqiliaPDUHXR/UrfSek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6ZIWRmM; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1363fe80fe8so5470717c88.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779829651; cv=none;
        d=google.com; s=arc-20240605;
        b=e8gy5Q14uTRMElI6a+iLOCa3nHREsdU0WiicCDbf3G1auo4GRH1Z4L7ECkm0yH3O+e
         +c4/gX7mqx2+BZPrZq03tOhEZWTxE7plCR9R8FYuL42iZucwCg8lfLrVDZvwumBwSHg6
         3fDfnyn3ziu5I7Ja8OnswQh8tJTBmUtAn5LlGy0/28EEAmpyWlDn8E2X+6cI7JMwxjxe
         hV1i1yFRwcDbEaKAcwxrsyaXhI0z6bYSbD4BYYSJdC8jMzwjzeTqzJIXG4VZhmH01vVQ
         9t7dHO17MgTNXeYFQdZS2OewH2vmvV/Z/8TFjusHuHMB6/JwvnTDWQnlxKkDEk7iusd2
         C6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FuG/OCefuxvzv1MSr9xGrIiR1NYDCf8b3OUyrtpmtVc=;
        fh=AfaAXe4CnWMgWe+1od88Fnt87lwSDm6iNKUZYy53MyA=;
        b=aehws1bopsAAZUA5D9xX31vP2WuFI/MVr/4lTcsLytj+evJr/4sY862lUwXgS83YJm
         JGHG6Sr3NVjwx/J0QHm0o4ytU+gZNvwmrqu83xFRGBKMBCqOFegOROHtfYw/m4bLgxtk
         rOTOw1Ky1DBG+hXExzKOkeAzd5e4uJjQjKtD/3Xe+ZpYxwezjEOg7Gqfk+6ove2oNzTj
         efXUzutOSdOaIt1tFsCLyS+RdyM++COrA0nG94id1ozjIp71Kq9anarDjkujBsCci/bN
         XS9dUfYDQtLbzkVRupAI1xpLnb6622rGh2m/FNUHMi1MYxqWocsoe48aLErfHcCc2T1P
         +7HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779829651; x=1780434451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuG/OCefuxvzv1MSr9xGrIiR1NYDCf8b3OUyrtpmtVc=;
        b=W6ZIWRmMhs7Q0zcLhSKbx0SViCSZEe2H4fp42duJaVm0T4KcRdbgWipLCvJex4CpFv
         G6T7uJAp5GiukeZC2E/b4Eaayc6r/+dO2UoArnO6eDLPWizDTy/IvD+LTY7AjDiC9yOQ
         qoVogXuBnNW+mRuzSHDbjAP+Dmw+K/M3E3twPfrRj/WHGioBC28aIYIxwUKkkeQbK3PM
         w4EdarYOpSM/UmiXEiaTNRIY1dX91kXZQh+VialBBhMXBmWAJ0N9ByjlCqhH3p2UEB5k
         RLEmDiPaR2pJfHdgwZPffld6W6mjYa1e4VaQP8Dqc71gc75cZEgp85gfIOtXr6wuSk/s
         Nh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779829651; x=1780434451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FuG/OCefuxvzv1MSr9xGrIiR1NYDCf8b3OUyrtpmtVc=;
        b=IMjj2BKnoAAew5dGX1jVFC/zSgAAtep8fpPaEh0HLEzzSsyi891uEqYAeqfXW7e5K3
         nMDXEzkqohCzCcpMEYH/vGbWG+pIt+he8fA4o3D4C0jjPzSednE/KzOqiSPgdMZ26kqI
         F2RfThq4+ahLkZ/bgPzg+zxnsmhPjFWukH0VYTtV5P2+XLMwIA9M6D2220+rsX542B+1
         RaR5xsu2W7aB1PnnHvtKdcs8H2/HBE3uDmPn9X7JGkEP81e3GaYN6kpCZEWx2ee+onLv
         3R0eAtEyTa1poGaENjN39tyJFMa8yGJnTocOjqWMOWRhXo4zUDcEK9t3ZuWvCgT52dcs
         In/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/lwKJEsUG1dNRVPDZDcCgTG/Hjvx4D18i5VBkR4e5/mLt8cyY7KS4roV/kMtAkUDa7jSfXZYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqkZ7EZQb7wD9ZL0eMu9CYHaxlUhHUL86LmJ2EO5OB1pK4SQD
	h2Ji342a+h3PjF47ItVkO0smDhLee/8QNrJ/a1fqa0vV09+jrH0XVCcg0E1OmvK5iWdyrrO7scM
	3EvG5tTyLzy3wzKEgGDlBIHA9QqJNqnzIS7KGFmbc
X-Gm-Gg: Acq92OHZcPLnZoOChr/8QNL7x7Oll9k7F2fi42kO9XZLkHcd4IShKq7c8FkPlaKd2Xy
	5vMG8eH9HpccqzSRqLoE/CXpIzMVIjZBOSGwZ15GHxqw8LiEMkZOAXAZcQYwL9sgCmSHVWCj2fy
	+gT14jEqeiZlBLEQJyK1JHh8Hal+Nkrh7oxJMZbxP8Z1c2DYbZ5TMehic+RbTqTrqgxViETLm4L
	pG07iXsviWdNeaNTeebmLEAFsHqt5XQ4sv07G+H+RIYuz6n+q9LzWr+F4MZdowvhuHP8eeJOEn/
	8cqvGq66jRZlk+iDj2k02HBVj03+Do04wUAz39EKHOiiSC5lky4Ayb/uMnlrACdnlpvptv59ejz
	6KXCmwdZYqnMVUVTvglo1E5Hz5qU8OgJX7Jh5iEeMBJfGwWMpCJLxSAjueAp+
X-Received: by 2002:a05:7022:b9e:b0:12d:ca32:5a7 with SMTP id
 a92af1059eb24-1365f81907cmr6430290c88.10.1779829650600; Tue, 26 May 2026
 14:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com> <20260523083001.2911931-11-kuniyu@google.com>
 <202652620435.m7WK.martin.lau@linux.dev>
In-Reply-To: <202652620435.m7WK.martin.lau@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 May 2026 14:07:19 -0700
X-Gm-Features: AVHnY4LBglR5_PGxMxSrpIx4L85PylgzLxFNRSg3vNN7axUqqTCkyPBE673xDRU
Message-ID: <CAAVpQUCd_eDq2nVz=um3T3iR5x7dSX1Rpi1YVTF0T5j16ok95g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/11] bpf: tcp: Add SOCK_OPS rcvlowat hook.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291928-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bpf_sock_ops.data:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A8BF35DC995
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 1:47=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Sat, May 23, 2026 at 08:29:39AM +0000, Kuniyuki Iwashima wrote:
> > Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVQ_CB.
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
> > The placement of tcp_bpf_rcvlowat() in tcp_ofo_queue() and
> > tcp_fastopen_add_skb() is chosen to provide the same snapshot
> > with tcp_queue_rcv().
> >
> > For example, if tcp_bpf_rcvlowat() were called before updating
> > TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
> > need to implement an unlikely if branch to strip SYN.
> >
> > In addition, TCP stack can queue overlapping skb into recvq.
> > Once rcv_nxt is updated with a new skb, BPF prog cannot infer
> > the previous one from skb->len.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v2: Add explanation of tcp_bpf_rcvlowat() placement.
> > ---
> >  include/net/tcp.h       | 12 ++++++++++++
> >  net/ipv4/tcp.c          |  2 ++
> >  net/ipv4/tcp_fastopen.c |  2 ++
> >  net/ipv4/tcp_input.c    | 10 ++++++++++
> >  4 files changed, 26 insertions(+)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index bc95d8e7b62e..a409f2ea710f 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2889,12 +2889,24 @@ static inline void bpf_skops_init_skb(struct bp=
f_sock_ops_kern *skops,
> >       skops->skb =3D skb;
> >       skops->skb_data_end =3D skb->data + end_offset;
> >  }
> > +
> > +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> > +
> > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *s=
kb)
> > +{
> > +     if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG)=
)
> > +             bpf_skops_rcvlowat(sk, skb);
> > +}
> >  #else
> >  static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
> >                                     struct sk_buff *skb,
> >                                     unsigned int end_offset)
> >  {
> >  }
> > +
> > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *s=
kb)
> > +{
> > +}
> >  #endif
> >
> >  /* Call BPF_SOCK_OPS program that returns an int. If the return value
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 3afeb69a547a..f7e32891bb4e 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copi=
ed)
> >               tcp_mstamp_refresh(tp);
> >               tcp_send_ack(sk);
> >       }
> > +
> > +     tcp_bpf_rcvlowat(sk, NULL);
>
> hmm... so NULL is a way for the bpf prog to tell where it is called?

Yes.  The selftest fetches bpf_cast_to_kern_ctx(ops)->skb first to
check it since we need to access skb->cb anyway to read
TCP_SKB_CB()->{seq,end_seq} for non-NULL case.


>
> With skb NULL, what does the bpf prog usually do?

In that case, the prog reads tp->copied_seq and some sequence
numbers from sk local storage and calls kfunc to adjust sk->sk_rcvlowat.

