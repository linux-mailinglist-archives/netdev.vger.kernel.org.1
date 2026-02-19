Return-Path: <netdev+bounces-259543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMhHKBtNl2m2wQIAu9opvQ
	(envelope-from <netdev+bounces-259543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:49:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA9F16166B
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FE10304046A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732633A6FB;
	Thu, 19 Feb 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft6jMZGO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E8350A1A
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771523292; cv=pass; b=USvVkx2GqS+pmWV6t1L2NvMkY0hYB3nTrZLPJMfNLPR8h2+MY3X3XsG5YzRcn3LAdZVqhofz15uo4yPqrqe8XUJwGAwE9xBuNdEzJwdbPfZcIAlBh49TEDaWeji2CBAc+M/ffCNJPAg7m2trs9/XHCQTUa+6BMu+68YFcDUOd/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771523292; c=relaxed/simple;
	bh=60uAjxQjjAvkmuwXuk/0K+9B6lmy2ELyGpJMetuRYD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/jo4/36UhpQ9e1Py9uN4OSx9wxgt2ju40B9rClwT61Xl1u2ML5t8BYylvex1magynBxpjAG1M9GRDnCQuTfAyrE5ZUFkwQdu2KSfxN9RobkRYU5IxpypcpM/LEW+SC5k+yKLbDG27Jy0gWSXfKLMvyXMNeFSBdz1yKqWNLGI0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft6jMZGO; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4327790c4e9so822542f8f.2
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:48:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771523289; cv=none;
        d=google.com; s=arc-20240605;
        b=FBuMdiQkMtBZer7g6I2VI1zA9/0LFHJAsDRcM1ldRoEFbU+pE0iPxnQCIR62MfM5f6
         S/v3cSYV5o9mJlIPZqmoV03e9748JHWCe84GAq+KhAi13fbXwUQWX4aBsAtyV4rQ7pBZ
         B5ZRvQ8R/DJ/rIk+B92Mm4xfJGLgP3hXSG9/gXCtU4IuBXYeQLUI6h7d2gLAmR1a3VaN
         k1PHKxUVAX+vIOuX64eXPI++vAyMxxz2py6vMB/pDfFJFJ/Wos0EW8l36SKnCFySFVi0
         cjhVgmVuK5PS9Z6kEf9j2vjAW9P/MLgDJqShoKUHxhEigKXUnBtAPWYqEM+5pFICsZm0
         WUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qbNsSPMZwv1/3WEUw4zg9sK7Xs2yLlNrYKE6jqFxkMY=;
        fh=15ph1Sg0QTt4T34y83rh9EIxPsYSCsxiAsT6LZ3CvPY=;
        b=YZj33Yb7LvvtpoPH/M5NPYvChwHSdpNAMCc6Hek7abcskRgvurtsIb/exmq9Fl8sJ7
         19M65sIAx/iNDMJuLCQTcPC2swmoeGwjYeySRjDKqa9N4SQqVvPBuj3XuKJn/BZ9GmTz
         30eFqxkQCrw9smYaEWeKcwss8CiWuZ3jzmHgZ/+5xfP1Ye44+RVjhG3qKtoW7TjsHccC
         D1bLDmePGUmPNAAL2pl1s8jWQu6McJRgb/QTe5xIuv/yqsPOsnO8lAG2ZLF9esONVoFI
         A4/hTWIjGRLi43uD8zd4H5nw8BqkDDcn4mNHb/99YdZmwnUL7jPzDS6f7zXG2SDrElSQ
         bS7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771523289; x=1772128089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbNsSPMZwv1/3WEUw4zg9sK7Xs2yLlNrYKE6jqFxkMY=;
        b=Ft6jMZGODzFMdNEkpgZzgREMuTADdBm53rxG96Q4S6LfKagXduBx6j8gBBkH4P+Vfv
         vavvNpvdK9bSO/fAQS322QgbIxWySJ6YN4ZFNpnUaSdRPxnVbkgw8YLF57/NWjUzFbww
         PN7kY9czZmd0nkuUF5E4umYYPt91q3u02J0pXCz2SsX8Egr+770ulgD5XFUOOgdAGm0J
         q9x2YYbBR7Kk5zAqW9oO/mvi7/+1VKfsNB/EdhYoIuq5E2s2qAiJbNPfoYH1L6ZVnL5i
         cFqejaAN/bf6UmNE3/0DHnze9ooc/Vdg8n4bYTQgoZQRzFt5XJCGGVh7MA1P89D0ghxI
         L6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771523289; x=1772128089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qbNsSPMZwv1/3WEUw4zg9sK7Xs2yLlNrYKE6jqFxkMY=;
        b=EYW00RgiEzTePvJNOIOiuaGhCogLtsewXXbUfgZpv7xIgke5B2FhDyPLUPF8GT99Z9
         RxML1TD3F1ubUtlGxizqZjQgMcLGgB5TbDWSroe0uT/hMtStlVgzyIaq5tAuiwX5eWlM
         j1QyRE8yusR7l4M65oibU106sQLfTlikHf5dbA5gsllbvQgKPWeYSzphfnsKybGZP+gv
         kLkk+CPr6wsl0sXhjb0/Xyxk2zLuG6fglzyZCA6JyWTjQz2Bn6PItISi8f0IRYuEwBuW
         +/ATPOO01yh4pp3iEWgSaXq4OhJU3JwpJLjuHrFzs5cfWePrzxqIzELwOiHe29LKKZ8a
         VLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+fVkEeMbzA0tPPlX2tU0Y+Lo8fEB1fZkS4Y0YFR/b956uiqJcgk5bLMeJgU8xwV4tpljPSP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdEX01SPuQij7stIbEPl/UKayLFDgZTcJAUcJj/z3Yp9KM1fYx
	RqhHLKKSa+W5ShweWNNCilpE8Fq6FZ7SjNpmQdMq8/LM+T4XBWpjzfY/FdK8Qq5arkS1RbkQsav
	SPYLMbZzSWnYHy67SgaZ4ox7iJT9+Las=
X-Gm-Gg: AZuq6aKR+hjcJOAFT6ueuuUJv9To13RdoT+GUutpW6HYqcetcdXEmHio1dMEYx2nndY
	1GrbjQSK3a7Xha5SFBXR2PmmkRPJzVB0Eqmr0GxDlDr+E+YQRzaSauMKeHSt6YXi/2Z+UahH9vg
	h8VBf4Gs7oKzau0D9b3MI8P+768q8fNVtC9a2gqroBQXmja6ENU2lF+U7IkM9vP7OASUawnr6gq
	sLqsN5WE9ZhH2jpQkSgAoqP6Sk3tQrLTbf+DiX4qowsIl/UURH7tmnAL6sBl1RE+/o8pj8z2ELC
	oIndBQZeD7b+N3hmD/BsqooBes0gpMnFFaVq8jbrAeLg4OGHuqy+SYHGX2syBfOQCPzde6vaAl2
	sImIOGTZESNxb05LSnXk=
X-Received: by 2002:a5d:588d:0:b0:436:369f:39fa with SMTP id
 ffacd0b85a97d-43796af9ed9mr39572765f8f.44.1771523288626; Thu, 19 Feb 2026
 09:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219142933.13904-1-leon.hwang@linux.dev> <20260219142933.13904-3-leon.hwang@linux.dev>
In-Reply-To: <20260219142933.13904-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Feb 2026 09:47:55 -0800
X-Gm-Features: AaiRm51ncUqJvIXG5s9TUaGOjPI7tmxDZZwdTCvAAoEMmGM4win76dnirbBawFI
Message-ID: <CAADnVQLNmQGKf5S5ZNwHYzScYBhnWFmnzLg=5Xxy4SgYKE3EfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs
 support for x86_64
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Peilin Ye <yepeilin@google.com>, 
	Luis Gerhorst <luis.gerhorst@fau.de>, Viktor Malik <vmalik@redhat.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259543-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,huaweicloud.com,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,fau.de,lists.infradead.org,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,wikipedia.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 0DA9F16166B
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 6:30=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Implement JIT inlining of the 64-bit bitops kfuncs on x86_64.
>
> bpf_rol64() and bpf_ror64() are always supported via ROL/ROR.
>
> bpf_ctz64() and bpf_ffs64() are supported when the CPU has
> X86_FEATURE_BMI1 (TZCNT).
>
> bpf_clz64() and bpf_fls64() are supported when the CPU has
> X86_FEATURE_ABM (LZCNT).
>
> bpf_popcnt64() is supported when the CPU has X86_FEATURE_POPCNT.
>
> bpf_bitrev64() is not inlined as x86_64 has no native bit-reverse
> instruction, so it falls back to a regular function call.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 141 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 070ba80e39d7..193e1e2d7aa8 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -19,6 +19,7 @@
>  #include <asm/text-patching.h>
>  #include <asm/unwind.h>
>  #include <asm/cfi.h>
> +#include <asm/cpufeatures.h>
>
>  static bool all_callee_regs_used[4] =3D {true, true, true, true};
>
> @@ -1604,6 +1605,127 @@ static void emit_priv_frame_ptr(u8 **pprog, void =
__percpu *priv_frame_ptr)
>         *pprog =3D prog;
>  }
>
> +static bool bpf_inlines_func_call(u8 **pprog, void *func)
> +{
> +       bool has_popcnt =3D boot_cpu_has(X86_FEATURE_POPCNT);
> +       bool has_bmi1 =3D boot_cpu_has(X86_FEATURE_BMI1);
> +       bool has_abm =3D boot_cpu_has(X86_FEATURE_ABM);
> +       bool inlined =3D true;
> +       u8 *prog =3D *pprog;
> +
> +       /*
> +        * x86 Bit manipulation instruction set
> +        * https://en.wikipedia.org/wiki/X86_Bit_manipulation_instruction=
_set
> +        */
> +
> +       if (func =3D=3D bpf_clz64 && has_abm) {
> +               /*
> +                * Intel=C2=AE 64 and IA-32 Architectures Software Develo=
per's Manual (June 2023)
> +                *
> +                *   LZCNT - Count the Number of Leading Zero Bits
> +                *
> +                *     Opcode/Instruction
> +                *     F3 REX.W 0F BD /r
> +                *     LZCNT r64, r/m64
> +                *
> +                *     Op/En
> +                *     RVM
> +                *
> +                *     64/32-bit Mode
> +                *     V/N.E.
> +                *
> +                *     CPUID Feature Flag
> +                *     LZCNT
> +                *
> +                *     Description
> +                *     Count the number of leading zero bits in r/m64, re=
turn
> +                *     result in r64.
> +                */
> +               /* emit: x ? 64 - fls64(x) : 64 */
> +               /* lzcnt rax, rdi */
> +               EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);

Instead of emitting binary in x86 and arm JITs,
let's use in kernel disasm to check that all these kfuncs
conform to kf_fastcall (don't use unnecessary registers,
don't have calls to other functions) and then copy the binary
from code and skip the last 'ret' insn.
This way we can inline all kinds of kfuncs.

pw-bot: cr

