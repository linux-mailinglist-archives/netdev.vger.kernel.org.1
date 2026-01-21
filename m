Return-Path: <netdev+bounces-251772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B6HFkhScGlvXQAAu9opvQ
	(envelope-from <netdev+bounces-251772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:12:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C951150E20
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35C7A5082B4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD833B8BA9;
	Wed, 21 Jan 2026 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtpxjZ2S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418603ACA41
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768968752; cv=pass; b=ThyZpypDAzqncsix6CqIKDnPuxx2SMuoxKOepy80QG6XzzLfp/o/lgBf0Y5019FsgPJdnNrQBLfTPDw/qj9LwKq86Wu3E8wkxIJ65S3ObsCpCWdmmUP3XsUuNNerFFY3HsW3unmb3UKC7f+XiaAbrb/b5trHaPKQ+PoiXtKU+oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768968752; c=relaxed/simple;
	bh=aLUt4k6Od5o9LKVcFoFJxVPDxiRTYBnrSQG++OERRVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtqiTe2RqXZsEWJsq6MPiPzySiJnvE2+VLVtWGh0FVeSY3iFB0x62DoE2lP2ZTrntzxSQVDIJ0pnf8ObNjz1iNlmABQUe3waNk3o7iWXDDjgFAMVYOP8nOgGDv9EwsNoxGHxz7gHvEPB5zAIdQjWjvoqhYmMtB2yTzdY1LsmUzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtpxjZ2S; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0ac29fca1so39569095ad.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 20:12:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768968743; cv=none;
        d=google.com; s=arc-20240605;
        b=huUTR3ftD5oqg+JW0edpDmR1Lnad7A8Cm2NAy+u7BAa6nX49V34MgBzvepeVyw+XgZ
         6wdvHwJWgKbGz7sASE0fLuyro3yKpX+aqcPfiJjQMk+M1ZxBJxR9o91gAT0mmzEiQ0ua
         AAad+YmRX78tY4A0uR2IanB2pEfS0S7zcMXdR6aD3JjNQeK4P+nYWKWFcisdVyDUXakl
         Lk1NaB5hNtxow2rLjz/YDH38zlw9txLSYb+dFU6wXqw3Quv6GSmqUmGcajfbc2OMrjcK
         6Yk7/FL/7nZx1dAGYf+IGAWrKdFnIS3mATl6fKP874ryh/1rvI/dv1cRm4gi5jmRftuM
         cXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=toc67hYd9ZEB83MLwiwrRxa2cY0Idu7PjNgfB0rz6Ak=;
        fh=SNA/iw7qOU0r7cmRrstLDp22Nj3WNos39r+fc44J4Do=;
        b=DxPnra7DaEnE7v31GsTAYZzR6NoM0BR8zNX6BzIIwlyMWddXDLbKdPRTsPEPVy/Tu+
         s2NWrPXHA+NgBmSlXRhYFmyqvtTFO4pE0hrzuYG5xsicJ45HL9OZzmI7rdp4kPiSQBcI
         sAvwjWGz7eLE+4Sc85SDGNM38p8Z/eME2eKOOS/Z6GZMsn3eAv0uOiq1T/074XdRJFhl
         3manjULpUR3U2DpCXXFRyY+wQDK+3slFUQrzqG8WYiGgVRcAbgdCAHLtQ6sG9B88Mraj
         dDSHpRnXTeto8tuxEVsSfa5hcxJ6ZikBH7i4dmSNf35OCuB6iMhcq+SVsPtjVK72K6Fk
         W4vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768968743; x=1769573543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toc67hYd9ZEB83MLwiwrRxa2cY0Idu7PjNgfB0rz6Ak=;
        b=VtpxjZ2SWI54h9k6jwfYeMdA61wwTXDb0mDN+GMtYUT3Thh4qyFRtGzbi6J9N6g/tO
         ycN4d1nDMoaKr8aAExMePud4p8G4IeIUCgGpKayquBWb8UoSihDGWu9lhEcjn7x/1jJT
         +s19lJn9Dd8gLcUNRtrrmWJv97zvw6SVv56ogvhXhS72iecPFclcn/4kZG3uj/N3q6ZG
         96SLZH0Ga6W1yc3a6cncBO0eOgs/dHwmTltIscTCZWRLBx4OJNZzFjEqXDJ0w40gdT3K
         2PSQtzCIyiOLh6slblT02ZuIRurHSB3GMiqAd/sNJWUUAX0aP6zyp8IZizrJ+WzPhtKT
         jTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768968743; x=1769573543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=toc67hYd9ZEB83MLwiwrRxa2cY0Idu7PjNgfB0rz6Ak=;
        b=G7R58idLuxFvYMMW+Q6ejNFi0B0WtVGBDwtzrDSgOS9vzBMTfUOahFXYFyfvJhkgCD
         b6F3KPD6Ds8DsNEK7q/cQZ6cJlaoguu6HxzUGEJvOJF7flOtaQ+5nNGLp5sHP2IGMvRD
         hlsX6hnJbywhsMGuDxoJe6xSNsN+++QxvnmmzaXmqU9IUpK2LMAVuGf8DyWVcCgpVYP8
         Tb7QPOtrauZlQ+q3OO0zFElyRz6Jk3QJvMT6szha9SBIaQGmoZ81dOmP3wgEq88BHRhm
         4ubci2aQVjPO4i/dQq1fpEf75rPA75BLq1GgSHaQzbtfH1G7JEIYYFpcxwkwAx57EEgd
         NTLg==
X-Forwarded-Encrypted: i=1; AJvYcCXq94dY/STfYV8QimKwrzKsCRBGZIfNTU9N2BiGWhWnfIqClUETcDX0pW3azZmQMI6IDg/DEnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwgbP0XpQJBGH/9w6zUigd4+/Ghe8hA2i5yT53robCvanw6wXR
	NseY6xHFQX3/lniFxkT2U0K8lOqmXEy5DSu/LKxDlq7LYwXN23gllBiq2bCFZCZpnuE0dqzNATE
	vfcmB+XDBbCTSbtT+0Fj3zfvc41s7nv4=
X-Gm-Gg: AZuq6aJCLkgXhhMvSo/KEu37WgxO2gK0sPYd1aFOhKZmnL+ptso/UcWvN8CRd1BgRlM
	5s/I7imQMCPnZBE8TrgHWm83WRk74KfF2B+afz5WhB4qaq7L9cbX5j9Bbzx8IM8hnEZ98GJGS+8
	+cVpjskAqFlg3mO9BkNenP/kgeNa9jyRdF340V9csxjQyhsduXpKNHEn7NkhtMqhJ4KT3OwyeN8
	MTTBCUNCVppWtKpDvylgh3E3FF7ljR2u4ROIDGQy7591AaV1W4eAIoOfZ9VtjuvmtQ4Rnc=
X-Received: by 2002:a17:903:252:b0:295:b46f:a6c2 with SMTP id
 d9443c01a7336-2a76ad6bfc7mr43451125ad.37.1768968742544; Tue, 20 Jan 2026
 20:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-2-dongml2@chinatelecom.cn> <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
 <10788751.nUPlyArG6x@7940hx> <CAADnVQ+Om14RF1GvA0vkhKdsCtVGzbacftEZarLJ-LKdYXUZ+g@mail.gmail.com>
In-Reply-To: <CAADnVQ+Om14RF1GvA0vkhKdsCtVGzbacftEZarLJ-LKdYXUZ+g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jan 2026 20:12:09 -0800
X-Gm-Features: AZwV_Qgqnnx41U8_yMztkT3t-Y5yNNkkRjDzM2bobYpRIXLJi-SWuKhgpE3nA8c
Message-ID: <CAEf4BzbVGx+0vn6n9T3rpePN7D4Mm54Xzc1spdSjvmrj1mV-0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-251772-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,davemloft.net,iogearbox.net,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: C951150E20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 7:10=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
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
> > > bpf_jit_inlines_helper_call(insn->imm)) check, so if some JIT has mor=
e
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

Ah, ok, that's the complication :)

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
>
> It's
> static __bpf_fastcall __u32 (* const bpf_get_smp_processor_id)(void) =3D
> (void *) 8;
>
> and
> #define __bpf_fastcall __attribute__((bpf_fastcall))
>
> which makes LLVM use more registers at the callsite (less spill/fill).
>
> Looking at the patch again. I think it's fine as-is.
> fastcall can be a follow up.

Yeah, it's fine as is. But it still seems like
verifier_inlines_helper_call() is an unnecessary extra hop we can
remove (even if it has to stay arch-specific).

