Return-Path: <netdev+bounces-292496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFYsIlKSF2oUJggAu9opvQ
	(envelope-from <netdev+bounces-292496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:54:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9BF5EB706
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 776363012C42
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B5719644B;
	Thu, 28 May 2026 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRew8Bns"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8700D220F2D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929412; cv=pass; b=KcXswf/U2rVgq+kjzmT4gSVt/H4vMS4upX5UeFjmyjPpl4zd4X8zxM/XkKxPzk3EWyvpVWSH85nqOEXLXlUdlo8CJnus0/3UFEbeLfEqcP0VgCnHQFAAWFcXGG7VvzWrPzGUZJE68zTZf2ZRzAqzsrWeXH1DNFR82hVwPMaNebE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929412; c=relaxed/simple;
	bh=xYhARfwZEM66RbtIZaWA9wEg+I6VTgAPes922/8IbTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipWKCdwuZkZxR9GYY8oqYuAHhWpSf+iv13iyh6XClw++7VRGLSnvLW8gNYxi2krRhb04z03DMoiN2dhwgDuFL1fKrwNTIRGfrOCfInAZ2ZlcT/aEyZdkaTQDnKyivdDAlZ7wUIhLuGyg6RNiPD58iJOGShle1kg4TObA7ZZP1ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRew8Bns; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a8891febd2so16240257e87.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779929406; cv=none;
        d=google.com; s=arc-20240605;
        b=O7KK8mk55+2OczzMfCpzv2gAwdIOAPqSIZyTZv3hN+7pgLduYpIzHrhLQAa6IfNvYr
         mhK1KV644b7uRYwX3vmEzVdxvuoFWlBWXfc/J9Zkd124Ez0tW9BeuYytiKRgsDf7oNie
         EhI4n69/QhkLuhzyxxBcVdLQBTO01P+HcxTYRkJb1jExgq3JZTSVeC/IUfR20ClEEnMr
         9eMz3tQ4QqQ8tY7qxoK/Bs5hIm1NA2LR/xG1NLawK2HOkFDPMfho40y6bse//xaIeCcn
         SNn/JQHUhkgbjm2GUsZd2MQ76y2MkQ4Hnzl9UQ4Y63xLdDMdpy4q2rIUGy8a3OewzzA7
         VVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+RruAHf3R1iczwm3Zy1aUkt69+/qOGV8X/zp2I0JUps=;
        fh=8yGmGKOUApGFR1E7ZrcB7yuHbxLTS6tMbQEcIzutrVY=;
        b=EEMvZ6DaldEfYkLntfOoniYzr8zJd+jnfB3NGv0J2LfiPlHlSh5HLREK1jdjDShO1Q
         PwSFlvuP0NRKvxkWXaFJ8do4S7kcvSTNHXZXCBLbN9f8jtsXUxp3v2v3nHuHfvckqVWN
         udLuF5fMRdEiFe/n0UWCQ4Gl/q3PX51Z3JMn1MzEYabee81QP/b0Z3FNPR/kKqJ4H2sE
         33M5KuJgnwJItglu0Zd1lfotcIY6hYlE6yDewnPBB4WAAjrW5jC5/gKOCSrurXoNFYM2
         ksy5uHg1R/G5KZW8rGyMdO+fTE9BHbU3AQXgIaiQzVYpcI+VYquDqekTrJ3qvuSjjNtz
         uPBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779929406; x=1780534206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RruAHf3R1iczwm3Zy1aUkt69+/qOGV8X/zp2I0JUps=;
        b=mRew8BnswQhCUpUV1sSdAqFT9+jlSQkkCJckkfRsQBKKHCrJ2+BqbqXR4TImd1+eYG
         IRLNEU9LeQJP/TpcCW+ekXdpe6CsH/I5KYhXkuw0LZd61jrWBXTZV6pE1N7y0gfA9GMI
         0zjZRgEM+nfmW62JpnandErG90whxOTS/fHh/besVXCezeedikWJy2l7F9Rm0Aslk9QV
         YM6gMZj9eJAgOxKA6LM099mphzCeqCUX75aMheE76gaimQiQcUfSptX/RdU6K5opfV75
         KAbVAkDEz3fTn6vla/7WHFc5WWWj0zBbtF6EjM6ZpxkPMIA/UwbuO/lQvF/Ab+kRphPP
         4okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929406; x=1780534206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+RruAHf3R1iczwm3Zy1aUkt69+/qOGV8X/zp2I0JUps=;
        b=aYzMs0dJX8W8ztL0e4R8tifzrafWcQhjfHCeY8FtgSg8h3Vq7HKX0Ut55bj3PxA5x5
         600u+uyhWacmHmHZUOOWOC4LUlKksvvSvVueBqy/y9eVKMlBfJb5BiFG6LoyyG2n0/Lw
         QabJiBiTt1SMCe3tkPxfOj3o4lCIha5cLc1dtXcGxnIZHyomIDkae/ablgRaYU3pNtUd
         J2U4TlnLBJ8Z8kYBztpPo92I0AOXHJ9eJZ1iovQlI31mzJQlRUSukAk1tnThMjmVobHM
         iLY+tVh2FIXXTRo4DwnCacu4+uhyVUSMarTWPvjEexU3OHyyN5Zx+OT4jtZuceLysq94
         KYGw==
X-Forwarded-Encrypted: i=1; AFNElJ8Z3W48uaVSo6EIeSwllo7Gt9yOGXk8hkX1VgOdjMTCQNkJB7KNH/D3Ybv75DPktmn+A1/1no4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm+xrNWwsHuZOA3y7PrrH+4Fb0bO6l1XlLVysLguFcC62MeN1P
	IxjfDQ+S+D7YaJWFFe7HbgznVlwZR0jXoYhCoOEorB9XGmF1iQrtr0pDFxuB1ggRSPFkWKPi+iy
	GHfZuRtyWTyJRUDbB6lMgHks01qO2hdU=
X-Gm-Gg: Acq92OERI3eirEaXdmUNyOkZ9Nao9hl2IakeytsP6/HHWSrAczadX24QSZrTc8u7CjZ
	XqBBluu6y2MVnWZN9M11HjW0LRRIYR6Cth82lprDoyRbXCp7nhenTEWYL/cUQ6nUeyoyGqdnnSQ
	DOwmDi8D7XvQXrGhb2sIN5ub39zwEKGH+2i+RfrJZ8dJy3PVXisA/m7wJeqp7WYM7KWKqza+HqN
	NeLnfFyAo7piB9E5BNvDJrL0iGgauoVKu3/0JmS4U9vDmAyE3+Ve4gLDbJqUDkQumyXNfM1y6Nd
	wc/cIzfWmF72zqYOR5k5iNXcqVbI4BCKgpaEA1VusKNRNp31CQ==
X-Received: by 2002:a05:6512:38c5:b0:5a8:fb56:e322 with SMTP id
 2adb3069b0e04-5aa323cd973mr5362329e87.36.1779929405522; Wed, 27 May 2026
 17:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com> <20260523083001.2911931-4-kuniyu@google.com>
 <202652620632.prOx.martin.lau@linux.dev> <CAAVpQUA0UNhR8AWfd0WC-krYJeXb0ebNs-V4u9kgweyNw_XHtg@mail.gmail.com>
 <2026526214538.Vhly.martin.lau@linux.dev> <CAL+tcoCSU9KFZsV33LE2R89iUzb5b3Xm+h6QObs5GOuRYR3sMQ@mail.gmail.com>
 <2026527192229.olv9.martin.lau@linux.dev>
In-Reply-To: <2026527192229.olv9.martin.lau@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 28 May 2026 08:49:27 +0800
X-Gm-Features: AVHnY4Lm6VOcSFNccR8V2egxgBLwuwM8XRk3VQR9XX6AG1Yyaz6z1iyik6SXvJc
Message-ID: <CAL+tcoChM9j1ehCeNsiFNoEk0t2TPr6ENt+hfif585hYo=mXcw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/11] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVQ_CB.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Alexei Starovoitov <ast@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292496-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[google.com,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,berkeley.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bpf_sock_ops.data:url]
X-Rspamd-Queue-Id: DC9BF5EB706
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 3:47=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Wed, May 27, 2026 at 12:01:11PM +0800, Jason Xing wrote:
> > On Wed, May 27, 2026 at 6:19=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On Tue, May 26, 2026 at 02:21:56PM -0700, Kuniyuki Iwashima wrote:
> > > > On Tue, May 26, 2026 at 1:34=E2=80=AFPM Martin KaFai Lau <martin.la=
u@linux.dev> wrote:
> > > > >
> > > > > On Sat, May 23, 2026 at 08:29:32AM +0000, Kuniyuki Iwashima wrote=
:
> > > > > > When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> > > > > > prog can be called with BPF_SOCK_OPS_RCVQ_CB.
> > > > > >
> > > > > > In this hook, we want to parse the RPC descriptor in the skb
> > > > > > and adjust sk->sk_rcvlowat based on the RPC frame size.
> > > > > >
> > > > > > However, we cannot access payload via bpf_sock_ops.data on
> > > > > > modern NICs with TCP header/data split on as the payload is
> > > > > > not placed in the linear area.
> > > > > >
> > > > > > Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
> > > > > >
> > > > > > Three notes:
> > > > > >
> > > > > >   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
> > > > > >       invoked from recvmsg().
> > > > > >
> > > > > >   2) Access to bpf_sock_ops.data will be disabled by passing
> > > > > >       0 end_offset to bpf_skops_init_skb().
> > > > > >
> > > > > >   3) ____bpf_skb_load_bytes() is called directly instead of
> > > > > >      __bpf_skb_load_bytes() to allow compilers to inline it
> > > > > >      instead of generating a tail-call.
> > > > >
> > > > > Some observations below.
> > > > >
> > > > > >
> > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > ---
> > > > > > v2: Explain why using ____ version instead of __
> > > > > > ---
> > > > > >  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 34 insertions(+)
> > > > > >
> > > > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > > > index 4a50fe2cd863..fa8a7c7d86eb 100644
> > > > > > --- a/net/core/filter.c
> > > > > > +++ b/net/core/filter.c
> > > > > > @@ -7760,6 +7760,38 @@ static const struct bpf_func_proto bpf_s=
k_assign_proto =3D {
> > > > > >       .arg3_type      =3D ARG_ANYTHING,
> > > > > >  };
> > > > > >
> > > > > > +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_ke=
rn *, bpf_sock,
> > > > > > +        u32, offset, void *, to, u32, len)
> > > > > > +{
> > > > > > +     int err;
> > > > > > +
> > > > > > +     if (bpf_sock->op !=3D BPF_SOCK_OPS_RCVQ_CB) {
> > > > >
> > > > > bpf_dynptr_from_skb() and bpf_dynptr_slice() kfunc could also be =
considered.
> > > > > One less bpf_sock->op check in filter.c to maintain and could als=
o avoid
> > > > > a data copy. There is a bpf_cast_to_kern_ctx() to get to a truste=
d
> > > > > skops_kern pointer but this will need changes in verifier.c to ge=
t to
> > > > > skops_kern->skb (e.g. in type_is_trusted_or_null) and this is the=
 tradeoff.
> > > >
> > > > Maybe a dumb question, but does it add extra cost (extra dynptr
> > > > function call?) if data overlaps two frags, or can dynptr handle it
> > > > seamlessly with a single bpf_dynptr_slice() ?
> > >
> > > Right, there is an extra bpf_dynptr_from_skb(). I don't think we have
> > > benchmarked it.
> > >
> > > If I read it correctly, unlike bpf_xdp_pointer, the skb_header_pointe=
r
> > > will still copy even if the data is in one frag. It works well if the=
 data
> > > is in the headlen and the worst case is to copy, which is the same as
> > > load_bytes.
> > >
> > > It is a readonly use case. Maybe the bpf prog can directly read the f=
rag.
> > > Regardless, it is useful to have a kfunc/helper to read it.
> > >
> > > >
> > > > In our case, the data copy is ~16 bytes, so the cost will not be
> > > > a big problem I think.
> > > >
> > > >
> > > > >
> > > > > If this new rcvq callback is added to the 'bpf_tcp_ops' proposal =
[1],
> > > > > all this will go away. 'struct sk_buff *skb' can be directly pass=
ed to an
> > > > > ops of the 'bpf_tcp_ops'. Supporting '*skb' in a struct_ops has a=
lready
> > > > > been done in the bpf_qdisc.
> > > > >
> > > > > [1]: https://lore.kernel.org/bpf/20260519215841.2984970-11-martin=
.lau@linux.dev/
> > > >
> > > > Oh I missed the series, the struct_ops conversion looks nice !
> > > > Since this work isn't urgent, I can wait for your series if mine
> > > > churns it.
> > > >
> > > > Jason's series is adding a new op, and I guess this can be
> > > > integrated too ?
> > > > https://lore.kernel.org/bpf/20260521135244.40869-5-kerneljasonxing@=
gmail.com/
> > >
> > > imo, a new sock_ops cb should be added as an ops in struct_ops. For e=
xample,
> > > in patch 4 of that series, bpf_skops_rx_timestamping assigns u64 to '=
u32
> > > args[4]', which is adding tech debt to the current sock_ops interface=
.
> > > For the timestamping case, it could be a separate ops for the
> > > 'struct sock' instead of 'struct tcp_sock' because it should
> > > at least work for both TCP and UDP.
> >
> > Sorry, I don't get it. What is the tech debt in this? And
> > bpf_skops_rx_timestamping() only outputs the timestamps, which has
> > nothing to do with either 'sock' or 'tcp_sock'.
>
> Did I say the tech debt is in bpf_skops_rx_timestamping?
> I said the tech debt of the bpf_sock_ops[_kern] interface.
> Besides always memzero the whole &sockops, the way that the bpf prog
> needs to get a u64 timestamp from u32 is not thrilling in 2026.
> args[4] is also not reliable when the earlier cgroup bpf prog
> writes to replylong. We had already hit some of these in our rx net
> timestamping discussion a few years ago. I suggest you go back
> and revisit.

Actually I revisited some historical threads and didn't notice
something like this probably because of too much information there.
Anyway, thanks for your information.

>
> >
> > Could you show me what to do next? Thanks in advance. It sounds like
> > the tx side of bpf timestamping should be adjusted accordingly?
>
> imo, the bpf_tcp_ops can land first. and then add net timestamping
> ops (existing tx and the new rx) in bpf_sock_ops.

I'll rework after your series gets landed.

Thanks,
Jason

