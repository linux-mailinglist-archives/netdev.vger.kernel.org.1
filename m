Return-Path: <netdev+bounces-285964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEPmFW49/mlmoQAAu9opvQ
	(envelope-from <netdev+bounces-285964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 21:45:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB44FB3B5
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 21:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388B2301F5C5
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 19:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148C2FF67A;
	Fri,  8 May 2026 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6/7/QTl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A723E342
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778269547; cv=pass; b=BUUG5EvMNJizV0mB7JDZrFcR99u0Qe0avgcaGd2r7XV77ufybs5fH6PggDQ1EYPh8Rg1e0BqIsTprKNbqy6fkeyIm3GTnYNlOGfUc8lJkWhQQDTwTJiJFRP7FwAcCd4NarBb4GWfG0COb89nWM1LRdjFH1Y+vOg3HysJo8wdRJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778269547; c=relaxed/simple;
	bh=Ro5DruJiif08OCzynnb3PXbgNRdrYftLXsTIr8OpWUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBezzl7ZkApsgsidPDQAGoztbaLzjFrsz3U85TyIISilCMCgKHn2AexADTM1BzDzEsXoHyTEsXXO+HEsvGge3bI5gqOqGqvbPOa/Cn74tXg4iWxTPpflrJWwdtslH5TAr4SshMtK2X8VIcNLhRT9HXW7GylbVEJTXgWenaOah0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6/7/QTl; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12dfee30612so2170668c88.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 12:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778269545; cv=none;
        d=google.com; s=arc-20240605;
        b=eD7NTEZ9MiNq7U8GX09/h1WnS0SpVGztYq0WeMylRZ0qpCDizu4zmCA8BaaTvlj7lf
         jjWVSTb7TeYzaKgfsMW26sIdAfb918l++Hq+3s3lGbhGTdfShUolPw5kx2hc/H2CFOZB
         dPY1vFXCb+DQFOeyCC9WQ04X9mZ7yPfch0HFz2/+1TxkRfZEBv/Lq6Cunoyhp1d19NqA
         02igv2Ev7LkDPAQz2RRW4PPcPidMrmIz64d85iplfQYGICwWKFvqhN0ziVF/yd+CS34w
         vLNyOuIpowKGLqbIjpu1x/JUXz6lCxde0lwoT/ark2BUJ7gBvSyd3qx0P1mAxnVKTeWc
         WAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pQ8nNqRjbElmBBLWfEelIrZJk1v9aJBHHekjgICQwws=;
        fh=GdWwQOwJod7MLRjm7SwQXXIC0Q6uMlS+xBz62Iim6Aw=;
        b=WremJwH82EfJFeHzhXKs+NOD84yT/Fh2N8VROEPCtIK/x9DHVAYb0zDzHy7jlgvqqc
         UdpVOvXjdG+l0oTtzBEFYfKksR/IIfC4hxxmaKKYiWrNVxvtaEBVEpzAg0MUIBU9lJvo
         rljJeeBYJrCGxYMx3aT7nBOXRZKVEA2GzRcSljQv8e16SixvqsaR6Fx+ODc5qd0HZIWL
         Sy8NGdDfagOcMYN3otfnAYrnSM5ZVHX4YXPWz1OCFmA15+RJ9OcWrGF6nFWO2wbUyYkt
         K75jc5MQCJJWYlM8akP5Xo4iOklxC1xy1RLhF3wQybmiBADeCeyequDpNy0CMBtqx2tx
         GCRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778269545; x=1778874345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ8nNqRjbElmBBLWfEelIrZJk1v9aJBHHekjgICQwws=;
        b=W6/7/QTl20eTqpUxzVMCELqTBcfgT7HQ0ZjxmhselMX5dpcrNAdfLQfRRF75ow2vP4
         XopwpN5p3VfzsjZGgvHVo/wMPCVc5+s2gP1B7YAPjRHsZ2L9DIOp0i406rHfoEVP8X7g
         JbsN3skvhqti3oEqIZP8N4ME9UdgqL5y9CRvV9zlv2qg82FqJOMAVLMoNA5wVvCMxGej
         zgNDCqH4CHG4pSOstdw08cHzFB0Sp06sPYv+THt9VuGr3PAX2naOIulRm9O/+C2ga1Ds
         Sz7OcHKOzlydqglyEdCnhqTP5rb2bV0NAkAck0QXCc2B0OrphESmxpKsrk9cmmVMhlsK
         8yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778269545; x=1778874345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQ8nNqRjbElmBBLWfEelIrZJk1v9aJBHHekjgICQwws=;
        b=tLD+I9f4hJsv1K/6hrkStEArsOScgi1xQ8BapifMK2+z5jPvQRqIgsgls4jwSQj9aR
         Csk8gSoGBw5NPfHPLbh2KftXSmIP9N/2syMaazgxNftxo0m8x6fPM9QdOOAAzqkIh64M
         lvYhzW7WYWbEm49fF6w6p1AVEpHqXLp36Zmsty8jYHsW1Vtdthp6t+jHgDwIwBZxKD/0
         Vyu98l7CYuCqD3HGfiaDpvXSfD4GFOOqNrfVEW31f6xqnFYsuKvF1P04y/Q0OtKl6kil
         GjARxlfM9PmUJ0QFc8oCGnkOcvJd4ytuBF2Z/jCB2c4JsISfynjmnHgTQ3H0Nt7pxVey
         65HQ==
X-Forwarded-Encrypted: i=1; AFNElJ8saTrdsI0vbdMg3Q95mkMI4NW6Yz3IMJVbYGEKg37wKytl4eQQClie95mpRA+N5kMA9QNB+zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSMY8cVksuORHJ2tBAWuKVq7XmQLsc4aLj8bMHEQxA+mn6XMGp
	H6PF++CUhpcTk8CESo8iv2heagfqh7fmC8htqgqT3V3VM7z5SmGvPc1zA73SqK3IrV2+c6O72YY
	uMShPXvHUigf6atRdoy9tFO23NWqGbnHsFHMIjkoc
X-Gm-Gg: AeBDiesaHk3qkFrcWXlyOp/9NHS1Lnor5pU+q7nRnYC3iAE2p1/CF4xBUdVVo30rw4+
	wAzQTTqW+IbkqmA83VeZuNS0qXQR487Bu3ltzfVDKsqSl90Ulll1GoDg34t4+DbgNI97VWP7WLe
	y+8mw4TJCOhxgiHtxoXXgHSJktcGQNSuaKh4leZzR/+qgtUVVSDT9tvQ3ykaecTyqMsuDjd5To5
	jEal4yjejhVAPHv0T6MtMGvgW+csKoMWdT5RmXWyIyb+qYF1N3H37huC4f8Cm+SI3PiHu6PgLxl
	e/qAIr4+CgkKj3vfVesdi+e6Cf5AHQZNyB6lywYuI/oCUnm+YRMB0SxfXW1F5x7vZ3KMHbs4/cZ
	vWb7zHlKoVsgiNV8oJMFgL3E+jf5QmRQ=
X-Received: by 2002:a05:7022:524:b0:128:dedf:f56d with SMTP id
 a92af1059eb24-13271b86623mr1983124c88.24.1778269544864; Fri, 08 May 2026
 12:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com> <20260508073355.3916746-4-kuniyu@google.com>
 <af390TgIj5sDABvi@devvm7509.cco0.facebook.com>
In-Reply-To: <af390TgIj5sDABvi@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 12:45:33 -0700
X-Gm-Features: AVHnY4Kh7jOPMKRUwiQs_V5O1uSsyK3oD8rM5kNPt3C0ykL7Es4h05MSqDt9pN8
Message-ID: <CAAVpQUA_HHEbcRxEVbuxtnyz_5ibvOSxO2wVx16ZQ0kKHQM7NQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/8] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVLOWAT_CB.
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
X-Rspamd-Queue-Id: A1BB44FB3B5
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-285964-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 8:15=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> On 05/08, Kuniyuki Iwashima wrote:
> > When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> > prog can be called with BPF_SOCK_OPS_RCVLOWAT_CB.
> >
> > In this hook, we want to parse the RPC descriptor in the skb
> > and adjust sk->sk_rcvlowat based on the RPC frame size.
> >
> > However, we cannot access payload via bpf_sock_ops.data on
> > modern NICs with TCP header/data split on as the payload is
> > not placed in the linear area.
> >
> > Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVLOWAT_CB.
> >
> > Two notes:
> >
> >   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
> >       invoked from recvmsg().
> >
> >   2) Access to bpf_sock_ops.data will be disabled by passing
> >       0 end_offset to bpf_skops_init_skb().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 5fa9189eb772..94d07a15b2ab 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -7718,6 +7718,38 @@ static const struct bpf_func_proto bpf_sk_assign=
_proto =3D {
> >       .arg3_type      =3D ARG_ANYTHING,
> >  };
> >
> > +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bp=
f_sock,
> > +        u32, offset, void *, to, u32, len)
> > +{
> > +     int err;
> > +
> > +     if (bpf_sock->op !=3D BPF_SOCK_OPS_RCVLOWAT_CB) {
> > +             err =3D -EOPNOTSUPP;
> > +             goto err_clear;
> > +     }
> > +
> > +     if (!bpf_sock->skb) {
> > +             err =3D -EPERM;
> > +             goto err_clear;
> > +     }
> > +
> > +     return ____bpf_skb_load_bytes(bpf_sock->skb, offset, to, len);
>
> nit: wondering whether it's better to use __bpf_skb_load_bytes (which
> wraps BPF_CALL_4's ____bpf_skb_load_bytes) here? Seems a bit less
> magic and used already by dynptr?

I guess dynptr used it because dynptr is in a different file under kernel/.

Users in the same file (sk_reuseport_load_bytes() and
sk_reuseport_load_bytes_relative()) call ____bpf_skb_load_bytes()
directly and clang inlined it there (including __bpf_skb_load_bytes())
while dynptr tail-called __bpf_skb_load_bytes().

I see the point (I had to read BPF_CALL_4() macro for ____), but
____bpf_skb_load_bytes() looks better.

