Return-Path: <netdev+bounces-292456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N+sLKBkF2qLDggAu9opvQ
	(envelope-from <netdev+bounces-292456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:39:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 147815EA718
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 467A730477F9
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E0538F232;
	Wed, 27 May 2026 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPQojiSA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4028389453
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779917976; cv=pass; b=ffm0wCQ1Qib25AGcDwvdie9KbV4DLw9vChjvIu8UwXFNMCg3rE0YoZRNS5WfZPaO0uJ0jH48aKPPFvHkZCyjnlHGjk4AMs4zLQ/jofZuNl/SnzRfh6Awuj8nrjN+VMwSShmu0Mfw2Co23rLEQxILI5+9JX+FqbH0Sj6ZCxrcjQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779917976; c=relaxed/simple;
	bh=Azl2N1qDX28IMFT3anmcWnp4A6VApp9TiA9migTR4bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lglFyENahdY3ouvug+7vjua6HDQwh3Malyvtx7dPlXz2UiCNZWCzNm/NzM1u2xIRDIphci7Dcz4X8tQAw+iJkB0NHNXAV8DquCi2QX2xzsjEKRatl/KJTTinoLZOuJ93UVbfp3YwCPoFVDoYH+72eweNL2w74yY1OeMnns52s+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPQojiSA; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-135e88b8e55so6640803c88.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779917973; cv=none;
        d=google.com; s=arc-20240605;
        b=CBxjZAgWix6JsVSJuMV/FmHA5jy6dZiuw04GnkSD1rOUDuYFO1wHL2awgBnBkj9LdM
         27B7E6vf9lSG/DfCeydPlFRrVKeIHJ4diX6T2hsj85XfGQP+1pUggbzTDVk1OsV1wXW0
         /rWLzb2JnR4ETWRslVCvgjX1tyU50tmHk8Mq6LfEkeI8ctvnme/ofRcXl0XCJJVpt/R4
         J79LJ77usOFUUNnjhimjE2KOioyJJC0Vkly1wXtmKx0YoLEDBCMENT6HeAHUj4gCpTsf
         77LdKfAoOmDr/98ttfpH60mZT/o/Ee8QXqMDSKVZivysMIVh3DjTAJt47bK9uhpONxIv
         3qeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jsWR6kFTZIW/F9UtjVVCYshPAK5/7mRvni26PxYshbs=;
        fh=IddE0T0+7SYYhFAVno48q4srJ4wBBtE0ioVzFAwS8fc=;
        b=e0PXFR3zEoUtxVNML4jKp0cYgs7cH2EouNz24EG4vxg5tdH964Bqo2B4QGgyNxZ/8j
         0BsyA9SBFu2whwWznu1sAeDQaVa/WQ5PumdPotK2hszU9NW/FOCD0DKLt8oYrwlE+G/7
         AB720fEs01D2xbded9AGjv19sxnLekXS/nDvyMK3IZFplI0p45DMKwEkqhFtceOfkct/
         nLKxgykGsSJicqYDV/4IWfNzL3aewyjDjNwaFtCCeVTuIVi9orIF2UWzWa3m7aqBEnIi
         YcLE2Tx08ngBIXqx1BX1tSvNUysS96YpHq8Gojy9RMRsMoUkD0MNVQByQoinTsPmmtY5
         9dpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779917973; x=1780522773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsWR6kFTZIW/F9UtjVVCYshPAK5/7mRvni26PxYshbs=;
        b=vPQojiSA7p0TZHjl6cQ3se2J3VYhu/NfzatXHTvTjPX5Qv5sh3mYnY+Mgdsh52g4iE
         YED3A1khsiatCMe6oEnB7god8lFTqd/CNVN2oNYY438BDAJRs/UorLffhTLD9bqvkZSr
         i+U5hEFyhlzQEm1UuFWBt0ERdXtx6qWZSzxETXvsCFIBFfNhVZ0J+NkWVQgq7/abwJxv
         mqGNNrU/U3j8gmfFOSTQ/Z8v4ogfEPIA2exF+fL+GIKg1QOF1OpwoZ+3yOvN9JVb3bgt
         2iJydvO4SaEco4hbq2GiAYGba6VtKKpahP1qKbbJUxvHfwuPcxF/ZMuYq4jNJq+Q7dnA
         KJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779917973; x=1780522773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jsWR6kFTZIW/F9UtjVVCYshPAK5/7mRvni26PxYshbs=;
        b=SJyJH/ivRnV4hHW3BIw1CS3y9SR6Ihc9f8hOc9PTsblc3P/jItzkHw7g9NHnlx49iw
         /0gvyuxmFfQyMZDtAiy7O27DprpCsMRUEUL8gAtgrqmmyLU/b8x05fwf5X8q1mqQw4Vp
         da1wmz5R1x9EGf0v6Hw5di9ZJjyzf2gAATJi17OBJNtT6d6thlFJ+FMJ84gRFl319Gsc
         +wyhpJNEczgt5hUbp7dlacv/fNPdtp6ZBjLynFI/NgJCE14xV4M4xOe32oVsPzOdEGMt
         6GaJy0Bgy+xwjc9td+koFcwOEvgTuX472nUJr4KCeEThTYWHyA6Nv+hqFL11yltWS4ed
         kelA==
X-Forwarded-Encrypted: i=1; AFNElJ95HTn9vm0iK80uWkAvf/g5Bjn6/3SIgfQDaSOeflJRsrnGR2kojGFy6Plj8wH8eAmhPMHqMdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuM5qZ2oVftWhSVOdDvtVWTQB/VPqdFcECShocDOn+4G8DTN2
	Q2uY4XT04XRkkS9wC68bVc+keyRR/ScKivp3782jzKmDXcsVnPqKlkq790cRIJnCzP5DqCmioLJ
	h61lJ0KKo22jBU6W9Jj044OIMvAo2DbghjmCC4dEu
X-Gm-Gg: Acq92OFaPc+/gC7kAqAcZ90VBtXatgn58bJNocgUOkPrFoNFD4pN7FtLbFMXsGOcVl1
	lrysjhHR0/YWk3ORC0NBX7L011nmRDzuiVY9sybmygBVG8OT8VdhyVBdlPmQSANnOFSRI5tpqnr
	PpXiM++LiQjbDdcNh511RsaJ+CaGdGQShasQU/CkLwA+QzHuViKp36VEfupeBEPP7Hdocz0LMGC
	JfL/GW4+E5nLNlD/ICTZIoH8J5fmERVa+s7rNNe3Rw8JeP9livz/jkHBDrkxA6IH5rv2lqzNd1+
	agS0PHltADbnv4xHuXuYGIrDWEHN1Pi5byB8HiFnu1N/0p74L8npsAb3W8QUoHacUCfMVEuZuiV
	j+ppEWyhPcTgbKOb4DbXhWq+aNeMwcpzSc2JMc+eQiK8KM+zzTeBcheEhPA2H
X-Received: by 2002:a05:7022:68a3:b0:130:9b78:b18d with SMTP id
 a92af1059eb24-1365fc62681mr9035515c88.34.1779917972029; Wed, 27 May 2026
 14:39:32 -0700 (PDT)
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
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 May 2026 14:39:20 -0700
X-Gm-Features: AVHnY4LZ1ZekIy85DRxvpz6p_60yQs1GhUjCCtYFD08nRjEQ4pr1PZ0F3sLp3G8
Message-ID: <CAAVpQUCUV=N0dEi8H51Y0oZytnohkJT1=B6zT3gxEKvb_5bukg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/11] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVQ_CB.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292456-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bpf_sock_ops.data:url]
X-Rspamd-Queue-Id: 147815EA718
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:47=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
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

I remember the tech debt was mentioned when I implemented
BPF SYN proxy in SOCK_OPS too.

>
> >
> > Could you show me what to do next? Thanks in advance. It sounds like
> > the tx side of bpf timestamping should be adjusted accordingly?
>
> imo, the bpf_tcp_ops can land first. and then add net timestamping
> ops (existing tx and the new rx) in bpf_sock_ops.

Sounds good to me.  I'll rebase TCP AutoLOWAT feature on top
of the struct_ops series.

