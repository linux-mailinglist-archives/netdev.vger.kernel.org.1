Return-Path: <netdev+bounces-251683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFYZMRcrcGniWwAAu9opvQ
	(envelope-from <netdev+bounces-251683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:25:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6A34F10A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D77FC68F998
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7F8304BBD;
	Wed, 21 Jan 2026 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG6Dxcbh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63D2FB998
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958646; cv=pass; b=F5TkAisLFnpqgcpB5GJiKK2frgb0WpNJl9HTWznnW9YVHiPruFXS5TOUleh/dJhg5OmJ2XcnFVPpSv3NMpK5gs1QZnw8PAMhHnoMa5TLKHOjTatSuBp67s9jnwQ7KPyqFbiovMINLJlRE+0Q0QoeZQhIl5LK0/EyGOPwdjFLAnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958646; c=relaxed/simple;
	bh=EIWzZ5jX2cohcG2lxevNFzEcN0fEaLcLGIGxMCA3c5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYvp4vFe/fPL5pkTy57oYRVYhE+4QuzuMoxlT2v8pjtWH/1rjQfEID7tGYxNO6Gi8P3ZRGfmj593iG32ctsf7vgpUS4cqEmhcXBII2orKHHgxeQsDVU9w4m+XgnTtmlumHGfP3TACiNZU/AnMSbKFhGgu5hzUGNs+fHsax998K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG6Dxcbh; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-352f00d0e83so288944a91.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 17:24:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768958644; cv=none;
        d=google.com; s=arc-20240605;
        b=cHc4KClXFts0XcPCj5G2zclbPlH/wLCBhryqBY0zUgOENO/Ux4tZrjsW4mlJruVVUA
         qCwTOOHe8PrjC5l+uBsGRbji1SBk+TlSYOKoBlz6qfqyxBFVsgqBA7l7TRKYB/H7EGTO
         YxG/lcS3mHPkl9xXWNXFlDv2ZpCjbBdUWPp3WnzxPVGof01P0CIbm4UgkrAwZ6YSKTHQ
         ih13uCb2S+RgG+us7bsOykuhgjEbrYa5UmFndpaEZN+YWNtkDe9z76W92BXg6BPX8xAH
         j7AU0cp1ijqsvYfNmb8Xnjn6hzUHCdl069KZ2Mv3DLBkyscg7c5lpd0dtfCTLCWCB5HX
         5QhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UmBrHYTJV6y7h6t7FL2AXk+XsrZAdnAaWIQHj3E6LrQ=;
        fh=FycwbLcT/2gjaTEbddcfIwmN8w5N6B/XGpo822dACdw=;
        b=cEA4Q5HMpqD1AbgPZDfMq8bMZ9FLV5MoL9SBpUGZyEZt+4MFo61D/PRXBQt18xxuxX
         bBP+9dUdHrHW7OP6YTtsb1BJhUoJZiWWFvYzKMOI8VM0OkE/d6mZJVXffyQrR/zgRc/6
         2oNQtCUCAXKcLj59CXBKrCH34TAPZ3z/HNyMcfuNkkv8Uinn6AylDwAAUPmS3bpZS65z
         tO+hd/9cxHuzxojael+29jPB0hYt1hui5AOUI71hzDfnyOrqWdJrfHu0COUjsgT3PymP
         a01kAcYbH/pr8+0O0xAlM7WAes5XQIp5BkrPVv4ar8FAM7x4MFEEe0m20xbGUF4GsfUg
         7D/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768958644; x=1769563444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmBrHYTJV6y7h6t7FL2AXk+XsrZAdnAaWIQHj3E6LrQ=;
        b=OG6DxcbhYTktLo6ucznajK4LFiWJBUqreLVpV4aMqU8f+A/snutBJWMdYSj1gxlYiv
         JkwJR3/XVKHHAdpSn12bBWC9vs+7ngvcCxm7b0EnANe1MUx8L1u1u2PiMttwaInCaXij
         GcU6FGOB2qRaTfr4429VxDEE2Xlmab8BGnZQTIwRI/u1wqCwMNIFR+MpH53vCETWX4wb
         jxNUDoEl8T5iY32q202y3e60noLnAfdwzsZ3wYxzX2iDbvxYo+pit5bZH57IJdADrmrC
         aZxxjbKv7UGTyzdRwkJGesYCkCIb96+qeM0KVGYsXweQyAUHTIqLSxsn9ll5WdaW2Lgx
         RTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768958644; x=1769563444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmBrHYTJV6y7h6t7FL2AXk+XsrZAdnAaWIQHj3E6LrQ=;
        b=EmLm3m5fWhv2dnhDkukXY+MbcaVWzWBS7qm4eF5QhWeD8zNbHmycU4Kdo+Qyvqbu/4
         DMp5KpftZcnFbaJjds2A6GSqS+JJXfudNQze+wuUYSTrnJ5omNlCTluZokUEL4gIyo0o
         +md3ZIeJ0Do2NGPHzcSUarhXavBBGIzjgsOIsTvGUVie/KStzHeqwOJT9+PQ46utOQ06
         dfeZ8Mdxidi87xvyXg2v3SD0WwhXOUPfCurijlmKNLteFpHDvGJgen/7kbOWu5bF+trn
         l4gGXeS3QVNoiNSjENhnnFt8EP9diSYRnFhEaXpWn4gMs3izLVmzpDj6HxgkeVZyaJXD
         RVXg==
X-Forwarded-Encrypted: i=1; AJvYcCUJh37OflcxuiNmihAxvk3LXs33Aq2Z+1iSObHq8hfshavwCbrozz1vs9okTX1j6LnYudEjb1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoAfW/qejQi1N324LdfFuyPs7DQqnKUPxPXcdsu9IXMi0Dtnl
	dp5M4xldn6xW2EL8QvBgVDIgss87TNYFX5Y5yiuPiETF5evLqCkMcxMbidT0xaUIWDZzwLL3NWA
	m43LZMjusxXLdKRZRmUtJ782a1XTVhg1lafdS
X-Gm-Gg: AZuq6aLaDkDaALFShpwEh5AgEatlmNcwazXLr/oVtX2crHnCXuHYETC+re8KLaBztIh
	eiaVeaQ+Nai6x96txQxN1utI3H+1wKvgCZp+iuQH2XScH/BSf4IILIIaEnVJFuEWeUev2T7WoxD
	0M7PUL+rubVM+6ItI/5fKdNKDw8eBQ6OZSROHMWb6gBFs0zXr6YNhy43WCHhMKjuZI4hqQaIzgr
	K+02QA9LmgTtqWMZyOA58TXroKMUhD7/8TkKDq7a0aPJUO67RSoShTxu05PI6abEgQewORsKfPH
	r5yn/hMDLrM=
X-Received: by 2002:a17:90a:d44d:b0:34a:b8fc:f1d1 with SMTP id
 98e67ed59e1d1-352c4047fa0mr3551606a91.24.1768958644182; Tue, 20 Jan 2026
 17:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn> <20260120070555.233486-2-dongml2@chinatelecom.cn>
In-Reply-To: <20260120070555.233486-2-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jan 2026 17:23:51 -0800
X-Gm-Features: AZwV_QgFmLgMGRrdAreJF-3TXb4tPle_8L1zaJFMbiizqknDQChynGxGQ7niugo
Message-ID: <CAEf4BzYjbP4KwuVNT_pgjfXy=+7saEezmp1ck2L5txwtik5WYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task()
 for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-251683-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,iogearbox.net,linux.dev,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 6F6A34F10A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 11:06=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> to obtain better performance.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
> v5:
> - don't support the !CONFIG_SMP case
>
> v4:
> - handle the !CONFIG_SMP case
>
> v3:
> - implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
>   x86_64 JIT.
> ---
>  kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9de0ec0c3ed9..c4e2ffadfb1f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17739,6 +17739,10 @@ static bool verifier_inlines_helper_call(struct =
bpf_verifier_env *env, s32 imm)
>         switch (imm) {
>  #ifdef CONFIG_X86_64
>         case BPF_FUNC_get_smp_processor_id:
> +#ifdef CONFIG_SMP
> +       case BPF_FUNC_get_current_task_btf:
> +       case BPF_FUNC_get_current_task:
> +#endif

Does this have to be x86-64 specific inlining? With verifier inlining
and per_cpu instruction support it should theoretically work across
all architectures that do support per-cpu instruction, no?

Eduard pointed out [0] to me for why we have that x86-64 specific
check. But looking at do_misc_fixups(), we have that early
bpf_jit_inlines_helper_call(insn->imm)) check, so if some JIT has more
performant inlining implementation, we will just do that.

So it seems like we can just drop all that x86-64 specific logic and
claim all three of these functions as inlinable, no?

And even more. We can drop rather confusing
verifier_inlines_helper_call() that duplicates the decision of which
helpers can be inlined or not, and have:

if (env->prog->jit_requested && bpf_jit_supports_percpu_insn() {
    switch (insn->imm) {
    case BPF_FUNC_get_smp_processor_id:
        ...
        break;
    case BPF_FUNC_get_current_task_btf:
    case BPF_FUNC_get_current_task_btf:
        ...
        break;
    default:
}

And the decision about inlining will live in one place.

Or am I missing some complications?

And with all that, should we mark get_current_task and
get_current_task_btf as __bpf_fastcall?


  [0] https://lore.kernel.org/all/20240722233844.1406874-4-eddyz87@gmail.co=
m/

>                 return env->prog->jit_requested && bpf_jit_supports_percp=
u_insn();
>  #endif
>         default:
> @@ -23319,6 +23323,24 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         insn      =3D new_prog->insnsi + i + delta;
>                         goto next_insn;
>                 }
> +
> +               /* Implement bpf_get_current_task() and bpf_get_current_t=
ask_btf() inline. */
> +               if ((insn->imm =3D=3D BPF_FUNC_get_current_task || insn->=
imm =3D=3D BPF_FUNC_get_current_task_btf) &&
> +                   verifier_inlines_helper_call(env, insn->imm)) {
> +                       insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32)(un=
signed long)&current_task);
> +                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, B=
PF_REG_0);
> +                       insn_buf[2] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_0, 0);
> +                       cnt =3D 3;
> +
> +                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta    +=3D cnt - 1;
> +                       env->prog =3D prog =3D new_prog;
> +                       insn      =3D new_prog->insnsi + i + delta;
> +                       goto next_insn;
> +               }
>  #endif
>                 /* Implement bpf_get_func_arg inline. */
>                 if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
> --
> 2.52.0
>

