Return-Path: <netdev+bounces-259747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDh9DAefmGnJKAMAu9opvQ
	(envelope-from <netdev+bounces-259747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:51:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C65FB169DE4
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B98AE3053B37
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C613C366042;
	Fri, 20 Feb 2026 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrGzythD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C202BCF43
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609848; cv=pass; b=d+T414QnEdlsJCPt53nwwtlp+dLTiCq8fm+bORyION7kXCwffIqINvnZTSyWvGy4N4Tj18j3x0iV6PniBKLKnfC9P/iBKDvRhUYk2VSkNgCkM6yVGTaGAd/xAQbM4PjDWF40mPIkVQ4p2A1xuzeqkLO2xnlXcqk/RlIsFV8yg5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609848; c=relaxed/simple;
	bh=zbNY7Qy6p+yAvMxGWsPgEuZC3JfRtGQtQzYwmYwkF6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYirIi5bmXL6GDWJWLhF3Y0aP+USVHW2Ru7LOQbB1sGPaCQL8BS2vFsbGC31GzT3Vodie8Dsw0o5cFXQ98Kjv0IvP0evghXWkGW6s/f0o2QEICy74AfKz9ODNF99Qg+jEcrtLfhFJDLPOWI50cDKbJdNiYDctsxgRUjnNs05Ai0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrGzythD; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4359a316d89so2120243f8f.0
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:50:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771609844; cv=none;
        d=google.com; s=arc-20240605;
        b=UEUOhU1TXdoLAQ1pjNea0PnAhHyXFFjuHl29dPypHEMwfl0hvHnlyFWIbenratMi1F
         tMxI50MaBt52AFGDmDJXqiNrdgMfi5iagXWTMdnogqCYUQmttljyosaQVRrSqxnPix4f
         9SwTIaYdC9/lzFKSiDhBmXb1MQIuZ0VCw2yh5M9I4JuaDxjMl03X1mQm76m0rbHOmrLF
         o4yEXKRJohTvoFBUOFbYt64oHOey8/IzQbcoAFsMxfJb+fv9WFWMLxXIvGS1MuIAUGsf
         WGmfPvEZfYuVLYip5XNekGA3GnaXzx8EaJiGHF0opt/YLb2jmxX2RVz94uP+05U0e771
         TIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RO4uLlKzg+agTjcOCUVy5m78c6Cx5Y93TL1UPBWaM7I=;
        fh=iCE9WaO1z31wUcRXpafL6BvE/O2gvXPS9EIizWKHmw0=;
        b=QdXvrzmiD1hb9oq9njPi3HVlPyIU3hSBg0gc77m+eBIMDNq0WteEr0kl0GUT7AmJXy
         T2Rlp3RyzrMkASD8h6Qk7K63aHlC75ZejomQ7Nw5gJbLyvsjE3gbcp5WXbL3CFCUYQyB
         ncJGEey5E/7czuFaC8Wc+emywMbBnoLXC8UiZ1I3Kq7UiffVtE520GwmHm4btnrjuZ+V
         I8tLgMfn8ky6vALNZQP9G0VtNX3HyngjWiNb3VnavbnIIGxe6DlI+oTVc63D7puLymPZ
         kHglMbcWct+rBZICRoKNdWpISPaYOEMBpRwZZ7/RbIwOPuFWjPs+5UOk09myQtSqiLXF
         fCXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771609844; x=1772214644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO4uLlKzg+agTjcOCUVy5m78c6Cx5Y93TL1UPBWaM7I=;
        b=BrGzythDzr68lT8P+X+zv4IULDkav/bhr70YF9wtZlpLwODzP7UpPJDcEt2dpLE/xg
         6fuHGy+gMznnxXFeP2cC6/1rxm5Vjar5WUr0a5naf/DlnadfM6eqeeRKYLeMCrzj+pWM
         S+TgqZASFnVjHXSY9y/MVdLL7FQdMXMM7vxUQLbJTapkEkj6RUwhfVlqGH8Z5i02Dlq3
         lAp24c0AAVpL7xEQaEIcDCdU/vsaFmR2jUd0ypGEmL/0SqjKa/9nGIgX9nPrkjAGnypp
         vX6twv3VebpVLuV1dAS3qj/GRvlfdr1cIAe5jGGbTRJ12aZzN4VTDwqsx7XFDpJpubMl
         2xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609844; x=1772214644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RO4uLlKzg+agTjcOCUVy5m78c6Cx5Y93TL1UPBWaM7I=;
        b=Frd1t3n4iYauuALHxF/hIyEiBMZ+AG2LpBCRyaqhHMrWN5/SJAZNG9xcu7BsHSHbq+
         UlKth8Nb6IXrLmtBiTwXBBKRpe+265TJGQSE+7Q+gJ678K7YJXWM8W63tz9n39lPS1bf
         sw6iOxgtjJ6YpLOl3OX/NjtHiGHIvM7Yr2GpkgzdtFe2hiJSiGQQ3FPmOqW+oIvIOfAk
         aWvwrzPpUBnKe+H+OkOVjCn+HNvsZmMiKf2pFMw7yrfFOH12pa1CRRVdvmOTlMl3ZIA/
         4YVrzfIYdgN8IGzkEQPOBTXo3gBrlZgOJa7UlP24X95fyEMT2agAdFwbI2wETOgPw4u4
         N2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVCLFKBGXhSxsqSmU6hxQQmbYYDtWxGjBgGXRA/RBkYqqVCQxc/8ci6oR8gpWC97Qn3Hmln4cM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcq32hEBfkLWvYcetVflu9akeCAsPgEFT/BqUP2H0dcZnM14YF
	jv9HvQyPlx5cBco73xje5yp/ZHnJB0Z0dYnOVWsGA6VjyUr8GpfJOMg65/7Pyd+HKVeBuQ3yzYk
	NVlHU/Y/HanX3fzaWLackUULnoYG+Jww=
X-Gm-Gg: AZuq6aK9odQ/2B74D2BPwSgB4QzzMaaClMeamfnA0XVZEo/qSycJaqn5j/YWaGSM4mJ
	jyvgya/vwtOwKFLUHGvwCCK45PWaC9gAo87Y2vHgOlCvWcr1zLXqeYejFTgyKdq9zeeIEpSADlJ
	qY3TDATSaMNNiLKqTuPAYDpL7ZbnPOe17cPrbQmOCkKd0fwNoUMRvUbvTPwLOIATT/jNS+K0DVJ
	vpkKsVIC0E+YLT39nQxW2iW0qeSxfkt5ESx9j3oVquarYHxVx8TGn2RpxGmmSihL0GoRfCU4eZd
	c2L4gR08qlSnnc4YeiGXoA+ZSrPDNagDPZWncwMsimED6berFmqRB0f/DHHmmZ+JtE3FVl6CG/U
	P9fvePNCS1Wu5m81LwGoK5eoZqA==
X-Received: by 2002:a05:6000:22c1:b0:437:719d:a74a with SMTP id
 ffacd0b85a97d-4396f1822eemr1349284f8f.58.1771609844263; Fri, 20 Feb 2026
 09:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219142933.13904-1-leon.hwang@linux.dev> <20260219142933.13904-3-leon.hwang@linux.dev>
 <CAADnVQLNmQGKf5S5ZNwHYzScYBhnWFmnzLg=5Xxy4SgYKE3EfQ@mail.gmail.com> <c6c2ffcf-acdf-4bda-ad82-dc4cc1a9260e@linux.dev>
In-Reply-To: <c6c2ffcf-acdf-4bda-ad82-dc4cc1a9260e@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 20 Feb 2026 09:50:33 -0800
X-Gm-Features: AaiRm51uyzLsKizzJvG3f9kn6T1NTHikVXRFmQWXpkFAQIgwLjOzg8dZ0x3Ke_4
Message-ID: <CAADnVQ+iQkvb9-wOchuPrUOneqzx9Rrqto88=R7GUOqih6PhZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs
 support for x86_64
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259747-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[linux.ibm.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,huaweicloud.com,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,fau.de,lists.infradead.org,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,wikipedia.org:url]
X-Rspamd-Queue-Id: C65FB169DE4
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 7:54=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2026/2/20 01:47, Alexei Starovoitov wrote:
> > On Thu, Feb 19, 2026 at 6:30=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> Implement JIT inlining of the 64-bit bitops kfuncs on x86_64.
> >>
> >> bpf_rol64() and bpf_ror64() are always supported via ROL/ROR.
> >>
> >> bpf_ctz64() and bpf_ffs64() are supported when the CPU has
> >> X86_FEATURE_BMI1 (TZCNT).
> >>
> >> bpf_clz64() and bpf_fls64() are supported when the CPU has
> >> X86_FEATURE_ABM (LZCNT).
> >>
> >> bpf_popcnt64() is supported when the CPU has X86_FEATURE_POPCNT.
> >>
> >> bpf_bitrev64() is not inlined as x86_64 has no native bit-reverse
> >> instruction, so it falls back to a regular function call.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  arch/x86/net/bpf_jit_comp.c | 141 +++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 141 insertions(+)
> >>
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index 070ba80e39d7..193e1e2d7aa8 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -19,6 +19,7 @@
> >>  #include <asm/text-patching.h>
> >>  #include <asm/unwind.h>
> >>  #include <asm/cfi.h>
> >> +#include <asm/cpufeatures.h>
> >>
> >>  static bool all_callee_regs_used[4] =3D {true, true, true, true};
> >>
> >> @@ -1604,6 +1605,127 @@ static void emit_priv_frame_ptr(u8 **pprog, vo=
id __percpu *priv_frame_ptr)
> >>         *pprog =3D prog;
> >>  }
> >>
> >> +static bool bpf_inlines_func_call(u8 **pprog, void *func)
> >> +{
> >> +       bool has_popcnt =3D boot_cpu_has(X86_FEATURE_POPCNT);
> >> +       bool has_bmi1 =3D boot_cpu_has(X86_FEATURE_BMI1);
> >> +       bool has_abm =3D boot_cpu_has(X86_FEATURE_ABM);
> >> +       bool inlined =3D true;
> >> +       u8 *prog =3D *pprog;
> >> +
> >> +       /*
> >> +        * x86 Bit manipulation instruction set
> >> +        * https://en.wikipedia.org/wiki/X86_Bit_manipulation_instruct=
ion_set
> >> +        */
> >> +
> >> +       if (func =3D=3D bpf_clz64 && has_abm) {
> >> +               /*
> >> +                * Intel=C2=AE 64 and IA-32 Architectures Software Dev=
eloper's Manual (June 2023)
> >> +                *
> >> +                *   LZCNT - Count the Number of Leading Zero Bits
> >> +                *
> >> +                *     Opcode/Instruction
> >> +                *     F3 REX.W 0F BD /r
> >> +                *     LZCNT r64, r/m64
> >> +                *
> >> +                *     Op/En
> >> +                *     RVM
> >> +                *
> >> +                *     64/32-bit Mode
> >> +                *     V/N.E.
> >> +                *
> >> +                *     CPUID Feature Flag
> >> +                *     LZCNT
> >> +                *
> >> +                *     Description
> >> +                *     Count the number of leading zero bits in r/m64,=
 return
> >> +                *     result in r64.
> >> +                */
> >> +               /* emit: x ? 64 - fls64(x) : 64 */
> >> +               /* lzcnt rax, rdi */
> >> +               EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);
> >
> > Instead of emitting binary in x86 and arm JITs,
> > let's use in kernel disasm to check that all these kfuncs
> > conform to kf_fastcall (don't use unnecessary registers,
> > don't have calls to other functions) and then copy the binary
> > from code and skip the last 'ret' insn.
> > This way we can inline all kinds of kfuncs.
> >
>
> Good idea.
>
> Quick question on =E2=80=9Cin-kernel disasm=E2=80=9D: do you mean adding =
a kernel
> instruction decoder/disassembler to validate a whitelist of kfuncs at
> load time?
>
> I=E2=80=99m trying to understand the intended scope:
>
> * Is the expectation that we add an in-kernel disassembler/validator for
>   a small set of supported instructions and patterns (no calls/jumps,
>   only arg/ret regs touched, etc.)?
> * Or is there already infrastructure you had in mind that we can reuse?
>
> Once I understand that piece, I can rework the series to inline by
> copying validated machine code (minus the final ret), rather than
> emitting raw opcodes in the JITs.
>
> I also noticed you mentioned a similar direction in "bpf/s390: Implement
> get_preempt_count()" [1], so I=E2=80=99ve added Ilya to the thread to dis=
cuss
> this approach further.

You really sound like LLM. Do your homework as a human.

