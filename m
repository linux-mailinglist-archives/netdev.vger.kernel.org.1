Return-Path: <netdev+bounces-251742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ABYDA1EcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:12:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A63B85044D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E65E6651E9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02994356A3D;
	Wed, 21 Jan 2026 03:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKY78HEW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB509356A01
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768965041; cv=pass; b=XV8k9bB5hH0xJWt6oBICc5W7QzdHNfFw+5PU/qVAy4PuEFJpbZ7lt8L/6YhaodhBu9ae8ZevPw4mXn21YeX9nLGyMgmMAMLK0x1sQ8Q8GZlDeeDgBrMMf/nqWB337UrPe/sbQsjPbqjFWCO22LEPCQFPTpNAKTP3IvZD4OvIja0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768965041; c=relaxed/simple;
	bh=bPgAMyOnYc1aLZP7ijDYYzEhU/LzQVs9bjurTOTDwGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNpwHV8Q2tPOtsVtXXYcH5FneXPWNfnEDpgOyPy4mgMzDWrRUi1HUgPhViOXFCpMr+Uh/dAcpnlpNKOAwLVrDRrAEfRJSzmagQVZsl/xofC1F0+P57ZXgakgnexvndQR8q13iEWMPncbDQocJUqlUczjj3xgvxM65YJw9GkevzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKY78HEW; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so5170290f8f.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:10:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768965038; cv=none;
        d=google.com; s=arc-20240605;
        b=dAu1UTmx3w2zOB3+EYqJQ//K6nF7dnaxjUtIehjms7CYsvdvjt2QxSf/UzttwovgXK
         +8lBz2xex5rPoYC3DqMV1KKQDQTj25TPBv+0ZwzRItILSSpLgz5YECDr/kTHYYLawKzs
         Yi/+rUqQvGrPMvrxYTj6dpU841BgH0uKiVLrG+Chf6GqYp0qcSfMfMYQJrgXZXdw2D3Z
         1Fk0ANUIktlaGuye3HE46w0Xiy54UxNhyuDm8euIWQ1APBPYmpx9BT4K+vgTsRaGHCAX
         Z2gcytlqbOMbbIbJoHhxljvxkK5mAPQcjSDROY9BMqSnSBzRU397KlFtceBdooyA3Lsh
         SqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6viIcJ3JtUIizIwvwmg/ihXKGMLAaRfWxmAiRKn8ywI=;
        fh=6o5BgQ34H52nKtTiBD+c8T2T69zrcMAFdfRGrQsZa+I=;
        b=jPdeWlqtbVpOln/glzU8uo/JqSvi/T5FPflS/T91ka/dzrvz7AjYv1yH+U4TymRyB1
         IHWxXvSLbVEH+JqLg9yzhReW5Fb9fyxJDygwZhWb0C/Sv4E2hHL5RR32X7GUZQaIDeFX
         YZ1npldc9vuleVTzCi1pPrbeI3JpLUbwMEBxqWI55asaB32bX3Ke6QfkzomEhyeIYmeb
         YeO8mvZy6aUPrmRajg0/mCbwIzTofpKpHphGly0pYxfYOgRan+cYY+EQed9qzo7aFZoG
         kuairXRQT9HZYfJYqarsuHrzaLWn3Tm2HJHoo8klzXQ0mywyis9grsE0OP7RaXMZ76NA
         SAEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768965038; x=1769569838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6viIcJ3JtUIizIwvwmg/ihXKGMLAaRfWxmAiRKn8ywI=;
        b=kKY78HEWof4nZv82T7K9I422VIR11mNkKoB6U9jpXOzjV49drTz5lVljkU0jv0EBXj
         oP7NtB3UfEcqQ3a7mlbY7loUiGQntb5GBtLAEhNvun2t8uJWqct1ueXGajDXSNrMSatV
         ++etFGkmGVToQvVS+YQZS17X+SLgfyZTZeqBRDkdVcEKaGC4+vA4OA68yGZ+XxMgeUy1
         wo1QC1bmCuZ77R/uka0J3ZGdrlpY7yxbIfCZLapnyqzLmdIXTAXylNbJ33u3I9NDAUTY
         hBUiCzh+Jxkko7FmifdEkpHnNryyDEBTLUTCEDZm8w3eLn3RrmVSvJINb9HkMn7TTv+N
         suRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768965038; x=1769569838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6viIcJ3JtUIizIwvwmg/ihXKGMLAaRfWxmAiRKn8ywI=;
        b=BlHsqDo9qAZ9NsrP5I2tOc379mt6u150R+yBSg1LsYpBVYjHdK5n8ngxBFRlIXMcpa
         /X3ZFi7mUVNzDMfY3XzXKiD/T8sgkOxFcN7taw3R9QINYp5Ww3aeZKlYV6nAaAwzOHP6
         f0cciTahkmWja4yTTPWT8rJNwMxNKj/mNcQ08xlU+WaR0uqab1FssXCwQhxeom1HOc8p
         Akajx7+gle8barae6Er2m9p9lyhaBX5MCa2RlU19ozU9+/PfugEXPrWcm40A+uLwyRsN
         P7uanN3ucmMOZhx4xAX6XtbawG+l4+ude4jJmDTgyngG2rUXlHf2oeORmpu1+DZaAfcP
         SJWw==
X-Forwarded-Encrypted: i=1; AJvYcCXsEXtQ1iILJwfvOLoXKDcIMZAkKAHxXfGLWntMyshT35FZZOZhRKMVFuGyrCijU/REK9LrBxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsB5J9POWM/NgNlo45mVxfUT1RdB3K1+8TGy8TMSM8SIEiik+
	qzYwHqY28/YD0kM8dSiuz23wCdtBsm71x4EwD5B/+t8tGRqk/AzGkEPGI+UI0oEbOIalEN3DZOO
	hJsL2qez2r9mnEvO7uPTklrVti1/5zIM=
X-Gm-Gg: AZuq6aJGiHAPlW278Zbu7YTKAP+1Mkd8rbQaF5fcfs+atAVpLuEWxOAIFtriH8mjRit
	HB9/m4ZSZRimf/SyC//ZzuspPlkHpySXoc4RE+lPcC4H7qBIl5QvrXI6Ai7es/J2t3Myo408W0G
	jjpiOIOkCkZHopF2Gw55+UWPC6LaMZZuZgi1s0ec8s0IH/pG0TEz1+tcqT5ZSy/AFQUMGfgtbQM
	osUhGoX3PDB+qwBN8mn0+BH/RorDMsp34dq7PguvRynfsZuGBhxmbEtKGaF62RzlRNvFrV8R4eK
	+0lcaOw6f7qrcgMQOXtz2Tk5mcpBTNvZBtWd41swMgq5M35FZLi4g3rZeGCF9yDBWzxlRncpq7u
	+wAej9wyRqOxm4w==
X-Received: by 2002:a05:6000:1a88:b0:431:9b2:61c4 with SMTP id
 ffacd0b85a97d-4356a082ee3mr23323458f8f.45.1768965037875; Tue, 20 Jan 2026
 19:10:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-2-dongml2@chinatelecom.cn> <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
 <10788751.nUPlyArG6x@7940hx>
In-Reply-To: <10788751.nUPlyArG6x@7940hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 19:10:26 -0800
X-Gm-Features: AZwV_Qhhx3HpF9SXXn6IPy25cabE30LoVYJ5d4Cbb3alWWY8lV8NEUpGzJZ7IGk
Message-ID: <CAADnVQ+Om14RF1GvA0vkhKdsCtVGzbacftEZarLJ-LKdYXUZ+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-251742-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,iogearbox.net,linux.dev,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,chinatelecom.cn:email]
X-Rspamd-Queue-Id: A63B85044D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 5:58=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2026/1/21 09:23 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > On Mon, Jan 19, 2026 at 11:06=E2=80=AFPM Menglong Dong <menglong8.dong@=
gmail.com> wrote:
> > >
> > > Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_=
64
> > > to obtain better performance.
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > > v5:
> > > - don't support the !CONFIG_SMP case
> > >
> > > v4:
> > > - handle the !CONFIG_SMP case
> > >
> > > v3:
> > > - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of=
 in
> > >   x86_64 JIT.
> > > ---
> > >  kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 9de0ec0c3ed9..c4e2ffadfb1f 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -17739,6 +17739,10 @@ static bool verifier_inlines_helper_call(str=
uct bpf_verifier_env *env, s32 imm)
> > >         switch (imm) {
> > >  #ifdef CONFIG_X86_64
> > >         case BPF_FUNC_get_smp_processor_id:
> > > +#ifdef CONFIG_SMP
> > > +       case BPF_FUNC_get_current_task_btf:
> > > +       case BPF_FUNC_get_current_task:
> > > +#endif
> >
> > Does this have to be x86-64 specific inlining? With verifier inlining
> > and per_cpu instruction support it should theoretically work across
> > all architectures that do support per-cpu instruction, no?
> >
> > Eduard pointed out [0] to me for why we have that x86-64 specific
> > check. But looking at do_misc_fixups(), we have that early
> > bpf_jit_inlines_helper_call(insn->imm)) check, so if some JIT has more
> > performant inlining implementation, we will just do that.
> >
> > So it seems like we can just drop all that x86-64 specific logic and
> > claim all three of these functions as inlinable, no?
> >
> > And even more. We can drop rather confusing
> > verifier_inlines_helper_call() that duplicates the decision of which
> > helpers can be inlined or not, and have:
>
> The verifier_inlines_helper_call() is confusing, but I think we can't
> remove the x86-64 checking. For example, some architecture
> don't support BPF_FUNC_get_current_task both in
> bpf_jit_inlines_helper_call() and verifier_inlines_helper_call(), which
> means it can't be inline.
>
> >
> > if (env->prog->jit_requested && bpf_jit_supports_percpu_insn() {
> >     switch (insn->imm) {
> >     case BPF_FUNC_get_smp_processor_id:
> >         ...
> >         break;
> >     case BPF_FUNC_get_current_task_btf:
> >     case BPF_FUNC_get_current_task_btf:
> >         ...
> >         break;
> >     default:
> > }
> >
> > And the decision about inlining will live in one place.
> >
> > Or am I missing some complications?
>
> As Alexei said, the implement of "current" is architecture specific,
> and the per-cpu variable "current_task" only exist on x86_64.
>
> >
> > And with all that, should we mark get_current_task and
> > get_current_task_btf as __bpf_fastcall?
>
> I think it make sense, and the I saw bpf_get_smp_processor_id does
> such operation:
>
> const struct bpf_func_proto bpf_get_smp_processor_id_proto =3D {
>         [...]
>         .allow_fastcall =3D true,
> };
>
> PS: I'm a little confused about the fast call. We inline many helper,
> but it seems that bpf_get_smp_processor_id is the only one that
> use the "allow_fastcall". Why? I'd better study harder.

It's
static __bpf_fastcall __u32 (* const bpf_get_smp_processor_id)(void) =3D
(void *) 8;

and
#define __bpf_fastcall __attribute__((bpf_fastcall))

which makes LLVM use more registers at the callsite (less spill/fill).

Looking at the patch again. I think it's fine as-is.
fastcall can be a follow up.

