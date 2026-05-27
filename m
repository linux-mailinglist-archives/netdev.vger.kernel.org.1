Return-Path: <netdev+bounces-292087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 89gqNbdsFmo5mQcAu9opvQ
	(envelope-from <netdev+bounces-292087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 06:01:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C5B5DF177
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 06:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FC033002D32
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55111B6D08;
	Wed, 27 May 2026 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEdxz/mx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1399A19CCF7
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 04:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779854514; cv=pass; b=hHidPbzVbd8dPmFnUZh5BduXFeeNlNcit6DyWTyM9YoMy+x4kLWTovhummOOjL3cfI9PpK7QnypUjlcUDTjid6op8FPwWp2lPSanmmPtEiAj5vfnjjga00Y2/BOINs7/jMWh/x8FKcW1nylkc3wehh6tqlnv97+3hsHDL7LGxTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779854514; c=relaxed/simple;
	bh=4QpgHXVbN+YlLlqUxKA2uaSXHp8ldeTq2bJ54Oi+jmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6KYmGgMseS8fFlIDzhAgP8WkZQ8iHjUwJBbe7QdbQ6CKWYpqAdzgMFYR2d6n4JcB2CAgxt0AAl2gEAyRoTpfxU6jl+ozbgVBp3azuosGTZFzJPtzCW1XM7QyzVkATFJIEokOy/kTNh2O4CKYx7r6KHGTW4/iAOmLHX6rSbOjW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEdxz/mx; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a877510541so12233565e87.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 21:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779854511; cv=none;
        d=google.com; s=arc-20240605;
        b=MK48u41Gn05czYMrWkRafNgKBdHajyLPkMlaHkfmcHnu/FBmnjT+Xvv1HOmOaSEAS7
         aL9OOvT1+tL3cvdPYwpqiRVxbIcHtYNdtLqY1N5Wj1hiL5ClUe7wJC+wrAwkJ+1ApUUF
         LBtFpsqtUbPq3nOQTVLYLtneSldaYEqJua+IjFGo9EYS9ApkyfXjBcGjqWDO/trRn+EQ
         AEhuq3EtXr3PkTXBM5t0KM04DZaxO+xP80phzJck5fjiakWFD2e3g8SU3Bnr/PqXNGar
         smpaDkM6Q99LtWUY5l7Etg64ZCI7j0KDFkv7aZgat+Id5pfOA4cq0WmNzK2x1LF6dbTJ
         J+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D3KdDxpMvJMlAAelKvqKgr0Zj1bFYekBYi5v2OpeYXs=;
        fh=1YnQaeQc4nkRrh3gQtq7DRQA/9EP/pEwBXM2HLdumcw=;
        b=PdnUqopz+f0wIfVhwt8zp1PGCBQ9RTyWoNx5b5pjGhYspMDhS4TC5Q5e28fTKnH9JL
         q4Fd1mzxCj1A7ZDSBb/SLhwd6jAkqBwPgrYqBu7U/Yh/aPh1+hZ4SD9XeMKeDr+hfed/
         hK28eOE5SyscbhNKRlwbPA33u2mUlqcNj/6f8vYSV01xywvlkDbpsL311WQ1mBVge7Pf
         7GNU/kWg6DQFloD0FM4jVabPqeFdOdLmXFXGCVsQCanxwTVJg+Kq0CX3Sdd3DmPkzcTM
         ZpVnbdoSfaZH/hfhFxjZNYxPQE1vmoDTwUl13k+1ziaM0UcIlQrEZ2DNT2pNGsr7fzLQ
         mVZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779854511; x=1780459311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3KdDxpMvJMlAAelKvqKgr0Zj1bFYekBYi5v2OpeYXs=;
        b=fEdxz/mxpSA/wiQBSFZ/fm0sa3lro91VG2UpHlkBEh1nsZfIAb8hvlsQ3Rtc40cdGd
         aGbcYIEdTDSBZ3x2k2Igmg9BweVZAItlmZRaj8JBa2l0YQfIQT4OetiDCaOcL0XiW1fp
         C328Bp9X2OKtrwRP/ovPQ2gNVpgvsDUcJ9r7/Qdv3HbldRDXSXrL4DMs5a0OZnHw5sBb
         phXQS4WDj1dAgXlNpop5MX6ETuvfIiBANzVzQ++Mo7GUowXHM70euyHWujzvrAAXUe1P
         ZKAbrMqPSBrznJHMMo+PYR3p+4UGPIXMOIPiWW5ya3JRTBUnNvsOfIv9YKE9FOfVO+6N
         o+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779854511; x=1780459311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D3KdDxpMvJMlAAelKvqKgr0Zj1bFYekBYi5v2OpeYXs=;
        b=VTjS61PlCjz9zpFtV4TU8TtAI9navz5GcVq8m6j5PoHcnZmcXiAY8vt5hDETPmDJ9E
         s6hgteSF2iR8nqruMiC9lzZWZ+DVa5VmzNRo7+2MVVtZhAxXf7f8k23bwdcrgp2sceOB
         b5nQZjg8cPxkS/y1/bAO6nvDl9tTvzQ2IdSFr5HkwYska1BoizJS6RRRh15w1RZ/3R3H
         MCD0DgWuD0r6Y3DqdZOeHPYmW73xXQAfxQANzsOv3Kve9a4oZwrMnwF7je2d8zAfqocH
         z5GwwcWzgNgklwHUM2AAfwEiAtC2bcj5Cqc2uXcjfcYMZQjQW399eZvLBmltMm6PoV0Z
         9m2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9DBe8YH+QJrullcHuKwydJ+gnmo9J4qKkU1YUvAg+sb873jpcJ93BtuEATkB+BCxow65JHHEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9/AWpzg7CDzD9AKmmvsyQ/3W0N3SSiNys4qCEfIfeAbq1cxu
	Xhoetwu+8z8Wo2kSKtw0RPAzwxf883zmEJXQezOxG/bBK9igXXLmW4i0vjQk1mx241LWFztNCOq
	n/+BAQd9pPFZu2QU3vfvMbgHVQ0HNNaQ=
X-Gm-Gg: Acq92OEZYeTvHE2T/00NY4+Sw9F8PoA0aqYC7Regj8olvq3Zk3w5IlQSbqx0WwPLVgU
	lXpYc2wFiawomFXSM+yW/Ci2dr4eW16IyyVVVv38E8zXhrWohQBoEjiH8TaIr9IroRuT0izTmhD
	QQLzAVxE2MwcmniCfnd6hoJy2C93tclnlUChe4bFZsITmFAt/oVZ4SvxbjWriw87D4d1g9b8sKO
	Jz4LrEMxztQLhRO3xHpXXz5o6bYJstaqnOADZIhj/3oZ3s3JQNOGVH+/RiTTrq+pXCF879GQJJk
	gqWrMolBSTU62CMDBVluuIRpZROJoGfRtCUXgHRi
X-Received: by 2002:a05:6512:1321:b0:5a8:7f30:609f with SMTP id
 2adb3069b0e04-5aa3238b3edmr6014469e87.10.1779854511016; Tue, 26 May 2026
 21:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com> <20260523083001.2911931-4-kuniyu@google.com>
 <202652620632.prOx.martin.lau@linux.dev> <CAAVpQUA0UNhR8AWfd0WC-krYJeXb0ebNs-V4u9kgweyNw_XHtg@mail.gmail.com>
 <2026526214538.Vhly.martin.lau@linux.dev>
In-Reply-To: <2026526214538.Vhly.martin.lau@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 27 May 2026 12:01:11 +0800
X-Gm-Features: AVHnY4IIPj8CP60xoKKyIQ-8-neW2ZVeWVv7jpX1r8wB2gVpMncSHhpDEym1CNM
Message-ID: <CAL+tcoCSU9KFZsV33LE2R89iUzb5b3Xm+h6QObs5GOuRYR3sMQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292087-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[google.com,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,berkeley.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A6C5B5DF177
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 6:19=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Tue, May 26, 2026 at 02:21:56PM -0700, Kuniyuki Iwashima wrote:
> > On Tue, May 26, 2026 at 1:34=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On Sat, May 23, 2026 at 08:29:32AM +0000, Kuniyuki Iwashima wrote:
> > > > When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> > > > prog can be called with BPF_SOCK_OPS_RCVQ_CB.
> > > >
> > > > In this hook, we want to parse the RPC descriptor in the skb
> > > > and adjust sk->sk_rcvlowat based on the RPC frame size.
> > > >
> > > > However, we cannot access payload via bpf_sock_ops.data on
> > > > modern NICs with TCP header/data split on as the payload is
> > > > not placed in the linear area.
> > > >
> > > > Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
> > > >
> > > > Three notes:
> > > >
> > > >   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
> > > >       invoked from recvmsg().
> > > >
> > > >   2) Access to bpf_sock_ops.data will be disabled by passing
> > > >       0 end_offset to bpf_skops_init_skb().
> > > >
> > > >   3) ____bpf_skb_load_bytes() is called directly instead of
> > > >      __bpf_skb_load_bytes() to allow compilers to inline it
> > > >      instead of generating a tail-call.
> > >
> > > Some observations below.
> > >
> > > >
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > ---
> > > > v2: Explain why using ____ version instead of __
> > > > ---
> > > >  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 34 insertions(+)
> > > >
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index 4a50fe2cd863..fa8a7c7d86eb 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -7760,6 +7760,38 @@ static const struct bpf_func_proto bpf_sk_as=
sign_proto =3D {
> > > >       .arg3_type      =3D ARG_ANYTHING,
> > > >  };
> > > >
> > > > +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *=
, bpf_sock,
> > > > +        u32, offset, void *, to, u32, len)
> > > > +{
> > > > +     int err;
> > > > +
> > > > +     if (bpf_sock->op !=3D BPF_SOCK_OPS_RCVQ_CB) {
> > >
> > > bpf_dynptr_from_skb() and bpf_dynptr_slice() kfunc could also be cons=
idered.
> > > One less bpf_sock->op check in filter.c to maintain and could also av=
oid
> > > a data copy. There is a bpf_cast_to_kern_ctx() to get to a trusted
> > > skops_kern pointer but this will need changes in verifier.c to get to
> > > skops_kern->skb (e.g. in type_is_trusted_or_null) and this is the tra=
deoff.
> >
> > Maybe a dumb question, but does it add extra cost (extra dynptr
> > function call?) if data overlaps two frags, or can dynptr handle it
> > seamlessly with a single bpf_dynptr_slice() ?
>
> Right, there is an extra bpf_dynptr_from_skb(). I don't think we have
> benchmarked it.
>
> If I read it correctly, unlike bpf_xdp_pointer, the skb_header_pointer
> will still copy even if the data is in one frag. It works well if the dat=
a
> is in the headlen and the worst case is to copy, which is the same as
> load_bytes.
>
> It is a readonly use case. Maybe the bpf prog can directly read the frag.
> Regardless, it is useful to have a kfunc/helper to read it.
>
> >
> > In our case, the data copy is ~16 bytes, so the cost will not be
> > a big problem I think.
> >
> >
> > >
> > > If this new rcvq callback is added to the 'bpf_tcp_ops' proposal [1],
> > > all this will go away. 'struct sk_buff *skb' can be directly passed t=
o an
> > > ops of the 'bpf_tcp_ops'. Supporting '*skb' in a struct_ops has alrea=
dy
> > > been done in the bpf_qdisc.
> > >
> > > [1]: https://lore.kernel.org/bpf/20260519215841.2984970-11-martin.lau=
@linux.dev/
> >
> > Oh I missed the series, the struct_ops conversion looks nice !
> > Since this work isn't urgent, I can wait for your series if mine
> > churns it.
> >
> > Jason's series is adding a new op, and I guess this can be
> > integrated too ?
> > https://lore.kernel.org/bpf/20260521135244.40869-5-kerneljasonxing@gmai=
l.com/
>
> imo, a new sock_ops cb should be added as an ops in struct_ops. For examp=
le,
> in patch 4 of that series, bpf_skops_rx_timestamping assigns u64 to 'u32
> args[4]', which is adding tech debt to the current sock_ops interface.
> For the timestamping case, it could be a separate ops for the
> 'struct sock' instead of 'struct tcp_sock' because it should
> at least work for both TCP and UDP.

Sorry, I don't get it. What is the tech debt in this? And
bpf_skops_rx_timestamping() only outputs the timestamps, which has
nothing to do with either 'sock' or 'tcp_sock'.

Could you show me what to do next? Thanks in advance. It sounds like
the tx side of bpf timestamping should be adjusted accordingly?

Thanks,
Jason

