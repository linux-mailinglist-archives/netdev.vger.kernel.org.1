Return-Path: <netdev+bounces-251762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGwgBdpLcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:45:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DCB50894
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 579574C8F25
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775DC3563EE;
	Wed, 21 Jan 2026 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bPH4D2vv"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6932B9B1
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966677; cv=none; b=Qntj+6fUKEZenE5TH8NuJWS6It6lbR+CVVjynQhgMZTUY5g8oH8deGD7XHkw4GjoMWidtUlS7ez4jCvwC1wFSDbdPpUJkxZDvWWOr0VVJldtSG4/sUd4Qj71ms9mBZNIyPW3tdYANFGAjyIw/TrClNXc/C5si6dy5v4j06BX/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966677; c=relaxed/simple;
	bh=8qh5wQNLZU6wwBGWEyVrZK+XA7DMEGWQRHkfgRfg4tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdei5cymlgjUynt70oUdCJwDhehrN7hqEmdeCrgTLejGY5tf0iCGPGl6S9zvu8vlzfrHPT2myJl8FOTsfy525EG3ZVBqUqGpeKvzeq+oC2+BTvwrPIHpbBtwYW2qReF/L/EkZcpuhUZcCgiWgyWhIa5HZvJIHArBZvWwHSFLpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bPH4D2vv; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768966662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7UBdMQNlhca9bxIf9Kpx0U3lgAusXCi9ZhqhkTK7wfA=;
	b=bPH4D2vvIoHO9WcYByhyqkGeWEzCiwvbEEotWGXHy8bGh8I6WHWqEneyPL9hO9exrR69Q/
	1sLHtgbp3IQZeWif3hwnz/ROKss3wjTeA/PGRoow+1XcNdgBN301vftR2LCzLdgB0IuaV3
	Q7MdIHsg0v5uRRqWef/ZBNd3MA592g8=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v6 1/2] bpf,
 x86: inline bpf_get_current_task() for x86_64
Date: Wed, 21 Jan 2026 11:37:28 +0800
Message-ID: <3672461.iIbC2pHGDl@7940hx>
In-Reply-To:
 <CAADnVQ+Om14RF1GvA0vkhKdsCtVGzbacftEZarLJ-LKdYXUZ+g@mail.gmail.com>
References:
 <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <10788751.nUPlyArG6x@7940hx>
 <CAADnVQ+Om14RF1GvA0vkhKdsCtVGzbacftEZarLJ-LKdYXUZ+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-251762-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,iogearbox.net,linux.dev,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,chinatelecom.cn:email]
X-Rspamd-Queue-Id: A8DCB50894
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/1/21 11:10 Alexei Starovoitov <alexei.starovoitov@gmail.com> write:
> On Tue, Jan 20, 2026 at 5:58=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> > On 2026/1/21 09:23 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > > On Mon, Jan 19, 2026 at 11:06=E2=80=AFPM Menglong Dong <menglong8.don=
g@gmail.com> wrote:
> > > >
> > > > Inline bpf_get_current_task() and bpf_get_current_task_btf() for x8=
6_64
> > > > to obtain better performance.
> > > >
> > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > > v5:
> > > > - don't support the !CONFIG_SMP case
> > > >
> > > > v4:
> > > > - handle the !CONFIG_SMP case
> > > >
> > > > v3:
> > > > - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead =
of in
> > > >   x86_64 JIT.
> > > > ---
> > > >  kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 9de0ec0c3ed9..c4e2ffadfb1f 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -17739,6 +17739,10 @@ static bool verifier_inlines_helper_call(s=
truct bpf_verifier_env *env, s32 imm)
> > > >         switch (imm) {
> > > >  #ifdef CONFIG_X86_64
> > > >         case BPF_FUNC_get_smp_processor_id:
> > > > +#ifdef CONFIG_SMP
> > > > +       case BPF_FUNC_get_current_task_btf:
> > > > +       case BPF_FUNC_get_current_task:
> > > > +#endif
> > >
> > > Does this have to be x86-64 specific inlining? With verifier inlining
> > > and per_cpu instruction support it should theoretically work across
> > > all architectures that do support per-cpu instruction, no?
> > >
> > > Eduard pointed out [0] to me for why we have that x86-64 specific
> > > check. But looking at do_misc_fixups(), we have that early
> > > bpf_jit_inlines_helper_call(insn->imm)) check, so if some JIT has more
> > > performant inlining implementation, we will just do that.
> > >
> > > So it seems like we can just drop all that x86-64 specific logic and
> > > claim all three of these functions as inlinable, no?
> > >
> > > And even more. We can drop rather confusing
> > > verifier_inlines_helper_call() that duplicates the decision of which
> > > helpers can be inlined or not, and have:
> >
> > The verifier_inlines_helper_call() is confusing, but I think we can't
> > remove the x86-64 checking. For example, some architecture
> > don't support BPF_FUNC_get_current_task both in
> > bpf_jit_inlines_helper_call() and verifier_inlines_helper_call(), which
> > means it can't be inline.
> >
> > >
> > > if (env->prog->jit_requested && bpf_jit_supports_percpu_insn() {
> > >     switch (insn->imm) {
> > >     case BPF_FUNC_get_smp_processor_id:
> > >         ...
> > >         break;
> > >     case BPF_FUNC_get_current_task_btf:
> > >     case BPF_FUNC_get_current_task_btf:
> > >         ...
> > >         break;
> > >     default:
> > > }
> > >
> > > And the decision about inlining will live in one place.
> > >
> > > Or am I missing some complications?
> >
> > As Alexei said, the implement of "current" is architecture specific,
> > and the per-cpu variable "current_task" only exist on x86_64.
> >
> > >
> > > And with all that, should we mark get_current_task and
> > > get_current_task_btf as __bpf_fastcall?
> >
> > I think it make sense, and the I saw bpf_get_smp_processor_id does
> > such operation:
> >
> > const struct bpf_func_proto bpf_get_smp_processor_id_proto =3D {
> >         [...]
> >         .allow_fastcall =3D true,
> > };
> >
> > PS: I'm a little confused about the fast call. We inline many helper,
> > but it seems that bpf_get_smp_processor_id is the only one that
> > use the "allow_fastcall". Why? I'd better study harder.
>=20
> It's
> static __bpf_fastcall __u32 (* const bpf_get_smp_processor_id)(void) =3D
> (void *) 8;
>=20
> and
> #define __bpf_fastcall __attribute__((bpf_fastcall))

Ah, I see. It seems that the bpf_doc.py does the trick.

>=20
> which makes LLVM use more registers at the callsite (less spill/fill).
>=20
> Looking at the patch again. I think it's fine as-is.
> fastcall can be a follow up.

Okay!

Thanks!
Menglong Dong






