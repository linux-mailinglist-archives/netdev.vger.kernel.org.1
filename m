Return-Path: <netdev+bounces-253001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBEPMfwcdGkW2QAAu9opvQ
	(envelope-from <netdev+bounces-253001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 02:14:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EE17BE61
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 02:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 303CC3012C5D
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F011DD525;
	Sat, 24 Jan 2026 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pu5/lyfU"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE21D6DA9
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 01:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769217274; cv=none; b=om8nBUPY5iisCEhoMKtYHJmTukCsRzgofyubTZxCbnuVLu1H0X8OuxL1tgFKAwQNQx9oGZtDiJHp6EKXeaA5WfhoH6ppKNb6hXQsMQSe9nWDvt0R2uGMD3gmkCbFKH+l+2Ym+GQxrYWHB6Eli6ER68vx8art1J+Y2EegGgXb3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769217274; c=relaxed/simple;
	bh=HyETEkvqvf7jCARA//SVqhyWiqIJOCwGGJa877OlXEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkcty6TFzx7ejBQxILJNGW6DYau0Qp+L91MpQR/Vq8gzmu7pdelOYx08/cla581TFLCCWBx7kew1WqKCY+BP4hN5Ub2GVhWEeJurTI9pxF9Fdrc0yBLMQVfqml3W9kCp2KRd7etE8g0ZQNJRRFTFUaOIA+0QJRjj7K4kL0Y6BSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pu5/lyfU; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769217260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tnxgEhBEpMM9wd+G9AoWvzIcL/tlu1JmMFjy3xOAlY=;
	b=pu5/lyfUCw4DFEcldFE84c/DldexujxQx0HjJnx3UUClBDDZq+fxTO7fiRFfbwaEEY9amK
	kY/tlVwwUhPwhoUFh+3wE/AknkzZINbyuhgO55WUkEV6SsaA0qAGYM46IIOC44DEZ1mGXf
	gX5MGDQZCWRajQE8bumFk3tuprGyBC0=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: menglong8.dong@gmail.com, andrii@kernel.org, bot+bpf-ci@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v11 02/12] bpf: use the least significant byte for the
 nr_args in trampoline
Date: Sat, 24 Jan 2026 09:14:04 +0800
Message-ID: <2815478.mvXUDI8C0e@7950hx>
In-Reply-To:
 <CAEf4BzabUj0APqROb7ibkEovoXVmxbiHq0kNAPWExpEfRmQwiw@mail.gmail.com>
References:
 <20260123073532.238985-3-dongml2@chinatelecom.cn> <8632406.T7Z3S40VBb@7940hx>
 <CAEf4BzabUj0APqROb7ibkEovoXVmxbiHq0kNAPWExpEfRmQwiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253001-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org,meta.com];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71EE17BE61
X-Rspamd-Action: no action

On 2026/1/24 06:57, Andrii Nakryiko wrote:
> On Fri, Jan 23, 2026 at 1:21=E2=80=AFAM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> > On 2026/1/23 16:29 Menglong Dong <menglong.dong@linux.dev> write:
> > > On 2026/1/23 16:07 bot+bpf-ci@kernel.org write:
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 41bbed6418b5..b3f912ad18ba 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > >
> > > > [ ... ]
> > > >
> > > > > @@ -23779,12 +23781,13 @@ static int do_misc_fixups(struct bpf_ve=
rifier_env *env)
> > > > >                       eatype =3D=3D BPF_MODIFY_RETURN) {
> > > > >                           /* Load nr_args from ctx - 8 */
> > > > >                           insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF=
_REG_0, BPF_REG_1, -8);
> > > > > -                         insn_buf[1] =3D BPF_ALU64_IMM(BPF_LSH, =
BPF_REG_0, 3);
> > > > > +                         insn_buf[1] =3D BPF_ALU64_IMM(BPF_AND, =
BPF_REG_0, 0xFF);
> > > > > +                         insn_buf[2] =3D BPF_ALU64_IMM(BPF_LSH, =
BPF_REG_0, 3);
> > > >
> > > > [ ... ]
> > > >
> > > > > -                         cnt =3D 6;
> > > > > +                         cnt =3D 7;
> > > > >                   } else {
> > > > >                           insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0=
, -EOPNOTSUPP);
> > > > >                           cnt =3D 1;
> > > > >                   }
> > > > >
> > > > >                   new_prog =3D bpf_patch_insn_data(env, i + delta=
, insn_buf, cnt);
> > > >
> > > > [ ... ]
> > > >
> > > > >                   delta    +=3D cnt - 1;
> > > >
> > > > Note that the bpf_get_func_ret block above correctly updates delta =
after
> > > > patching.
> > > >
> > > > > @@ -23808,12 +23811,15 @@ static int do_misc_fixups(struct bpf_ve=
rifier_env *env)
> > > > >
> > > > >                           /* skip 'void *__data' in btf_trace_##n=
ame() and save to reg0 */
> > > > >                           insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0=
, nr_args - 1);
> > > > > +                         cnt =3D 1;
> > > > >                   } else {
> > > > >                           /* Load nr_args from ctx - 8 */
> > > > >                           insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF=
_REG_0, BPF_REG_1, -8);
> > > > > +                         insn_buf[1] =3D BPF_ALU64_IMM(BPF_AND, =
BPF_REG_0, 0xFF);
> > > > > +                         cnt =3D 2;
> > > > >                   }
> > > > >
> > > > > -                 new_prog =3D bpf_patch_insn_data(env, i + delta=
, insn_buf, 1);
> > > > > +                 new_prog =3D bpf_patch_insn_data(env, i + delta=
, insn_buf, cnt);
> > > > >                   if (!new_prog)
> > > > >                           return -ENOMEM;
> > > > >
> > > > >                   env->prog =3D prog =3D new_prog;
> > > > >                   insn      =3D new_prog->insnsi + i + delta;
> > > > >                   goto next_insn;
> > > > >           }
> > > >
> > > > Should there be a "delta +=3D cnt - 1;" before assigning env->prog =
in this
> > > > bpf_get_func_arg_cnt block? When cnt is 2 (non-RAW_TP path), the pr=
ogram
> > > > grows by one instruction, but delta is not updated. This could cause
> > > > subsequent bpf_patch_insn_data() calls to use incorrect offsets.
> > > >
> > > > The bpf_get_func_arg block at the beginning of this patch has:
> > > >
> > > >     delta    +=3D cnt - 1;
> > > >     env->prog =3D prog =3D new_prog;
> > > >
> > > > And the bpf_get_func_ret block similarly has delta updated. But this
> > > > bpf_get_func_arg_cnt block goes directly to env->prog assignment wi=
thout
> > > > updating delta.
> > >
> > > Ah, good point, I think this is a valid problem. The selftests didn't=
 cover
> > > this case, and I think I'd better to use bpf_get_func_arg() and bpf_g=
et_func_ret()
> > > in the exit path of fsession to cover it.
> >
> > Oh, the problem doesn't have much impact. The only impact
> > is that the verifier will check the "r0 &=3D 0xFF" instruction redundan=
tly.
> >
> > I'll see if there is more comment before I send next version.
> >
>=20
> Let's still fix the problem. Just go ahead and resubmit (with the fix
> and improved test).

OK!

>=20
> pw-bot: cr
>=20
>=20
> > Thanks!
> > Menglong Dong
> >
> > >
> > > Will fix it in the next version.
> > >
> > > Thanks!
> > > Menglong Dong
> > >
> > > >
> > > >
> > > > ---
> > > > AI reviewed your patch. Please fix the bug or email reply why it's =
not a bug.
> > > > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude=
/README.md
> > > >
> > > > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/=
21278745581
> > > >
> > >
> > >
> > >
> > >
> > >
> > >
> >
> >
> >
> >
>=20
>=20





