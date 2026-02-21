Return-Path: <netdev+bounces-259823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PFxB/momWnQVwMAu9opvQ
	(envelope-from <netdev+bounces-259823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 13:45:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D2D16CD7C
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 13:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EC22301456C
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EABB665;
	Sat, 21 Feb 2026 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v4UNHe7m"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958563EBF14;
	Sat, 21 Feb 2026 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771677941; cv=none; b=uczrqbeE+13IugLTbB3OdyrijMPy0KqZG9SegtN5fss3Oor7MJNKl3txGT15TzibXRzg8VnHBOhowRVKRT9ClfX5ii4ImhyojHinVnfU+N2AIjCqIt+tUAqhwnNLUtKGvFr+DyyF9I73iq+8XsnVbwBMv5iaRrUh1yGdhdzxNpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771677941; c=relaxed/simple;
	bh=WsTXGR95QMDQIDKcSeiKcsv6uqyY7BgPMQj5G+jyeaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aT78N1lk8q+u62ogeKhjTmU75ZIKrp6bmMvuGRe+mJFDDIxLSlBQR+KnuuCx1reYQdtv5TJi4oxDKa3mbsnCCgpk7cVu1bHLh6jPJDFxyAhDswjUICcKVyNGhHyu+Z/kgJSmCTSD/sz+pUnZPiFOvzo750VIpHL8L7Q5j61FL4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v4UNHe7m; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4c40705a-4e6a-47ea-b420-223318d1ad09@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771677937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2QdP2BW6MkJBcHCw2LF48pz76iAYyIKzOB0N/QTayGk=;
	b=v4UNHe7m4wdtR3fobdkJjSqgSGryknFDYRYiIcR+EwhlwvBbD04oPPTQGpQcyWU9kpWSBg
	7FP0Rr7fd7aZeoLk4Lzu/PlKTlntsNzlpAhsfeaLFUZLR5Sk5qzm65hbYBeS5qCM54TRmx
	9Ar15FvoTW2zcEgHfzbJU+8H81Xot8k=
Date: Sat, 21 Feb 2026 20:45:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs
 support for x86_64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, Peilin Ye <yepeilin@google.com>,
 Luis Gerhorst <luis.gerhorst@fau.de>, Viktor Malik <vmalik@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com
References: <20260219142933.13904-1-leon.hwang@linux.dev>
 <20260219142933.13904-3-leon.hwang@linux.dev>
 <CAADnVQLNmQGKf5S5ZNwHYzScYBhnWFmnzLg=5Xxy4SgYKE3EfQ@mail.gmail.com>
 <c6c2ffcf-acdf-4bda-ad82-dc4cc1a9260e@linux.dev>
 <CAADnVQ+iQkvb9-wOchuPrUOneqzx9Rrqto88=R7GUOqih6PhZQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQ+iQkvb9-wOchuPrUOneqzx9Rrqto88=R7GUOqih6PhZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259823-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,huaweicloud.com,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,fau.de,lists.infradead.org,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 60D2D16CD7C
X-Rspamd-Action: no action



On 2026/2/21 01:50, Alexei Starovoitov wrote:
> On Fri, Feb 20, 2026 at 7:54 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 2026/2/20 01:47, Alexei Starovoitov wrote:
>>> On Thu, Feb 19, 2026 at 6:30 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>> Implement JIT inlining of the 64-bit bitops kfuncs on x86_64.
>>>>
>>>> bpf_rol64() and bpf_ror64() are always supported via ROL/ROR.
>>>>
>>>> bpf_ctz64() and bpf_ffs64() are supported when the CPU has
>>>> X86_FEATURE_BMI1 (TZCNT).
>>>>
>>>> bpf_clz64() and bpf_fls64() are supported when the CPU has
>>>> X86_FEATURE_ABM (LZCNT).
>>>>
>>>> bpf_popcnt64() is supported when the CPU has X86_FEATURE_POPCNT.
>>>>
>>>> bpf_bitrev64() is not inlined as x86_64 has no native bit-reverse
>>>> instruction, so it falls back to a regular function call.
>>>>
>>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>>> ---
>>>>  arch/x86/net/bpf_jit_comp.c | 141 ++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 141 insertions(+)
>>>>
>>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>>> index 070ba80e39d7..193e1e2d7aa8 100644
>>>> --- a/arch/x86/net/bpf_jit_comp.c
>>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>>> @@ -19,6 +19,7 @@
>>>>  #include <asm/text-patching.h>
>>>>  #include <asm/unwind.h>
>>>>  #include <asm/cfi.h>
>>>> +#include <asm/cpufeatures.h>
>>>>
>>>>  static bool all_callee_regs_used[4] = {true, true, true, true};
>>>>
>>>> @@ -1604,6 +1605,127 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
>>>>         *pprog = prog;
>>>>  }
>>>>
>>>> +static bool bpf_inlines_func_call(u8 **pprog, void *func)
>>>> +{
>>>> +       bool has_popcnt = boot_cpu_has(X86_FEATURE_POPCNT);
>>>> +       bool has_bmi1 = boot_cpu_has(X86_FEATURE_BMI1);
>>>> +       bool has_abm = boot_cpu_has(X86_FEATURE_ABM);
>>>> +       bool inlined = true;
>>>> +       u8 *prog = *pprog;
>>>> +
>>>> +       /*
>>>> +        * x86 Bit manipulation instruction set
>>>> +        * https://en.wikipedia.org/wiki/X86_Bit_manipulation_instruction_set
>>>> +        */
>>>> +
>>>> +       if (func == bpf_clz64 && has_abm) {
>>>> +               /*
>>>> +                * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
>>>> +                *
>>>> +                *   LZCNT - Count the Number of Leading Zero Bits
>>>> +                *
>>>> +                *     Opcode/Instruction
>>>> +                *     F3 REX.W 0F BD /r
>>>> +                *     LZCNT r64, r/m64
>>>> +                *
>>>> +                *     Op/En
>>>> +                *     RVM
>>>> +                *
>>>> +                *     64/32-bit Mode
>>>> +                *     V/N.E.
>>>> +                *
>>>> +                *     CPUID Feature Flag
>>>> +                *     LZCNT
>>>> +                *
>>>> +                *     Description
>>>> +                *     Count the number of leading zero bits in r/m64, return
>>>> +                *     result in r64.
>>>> +                */
>>>> +               /* emit: x ? 64 - fls64(x) : 64 */
>>>> +               /* lzcnt rax, rdi */
>>>> +               EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);
>>>
>>> Instead of emitting binary in x86 and arm JITs,
>>> let's use in kernel disasm to check that all these kfuncs
>>> conform to kf_fastcall (don't use unnecessary registers,
>>> don't have calls to other functions) and then copy the binary
>>> from code and skip the last 'ret' insn.
>>> This way we can inline all kinds of kfuncs.
>>>
>>
>> Good idea.
>>
>> Quick question on “in-kernel disasm”: do you mean adding a kernel
>> instruction decoder/disassembler to validate a whitelist of kfuncs at
>> load time?
>>
>> I’m trying to understand the intended scope:
>>
>> * Is the expectation that we add an in-kernel disassembler/validator for
>>   a small set of supported instructions and patterns (no calls/jumps,
>>   only arg/ret regs touched, etc.)?
>> * Or is there already infrastructure you had in mind that we can reuse?
>>
>> Once I understand that piece, I can rework the series to inline by
>> copying validated machine code (minus the final ret), rather than
>> emitting raw opcodes in the JITs.
>>
>> I also noticed you mentioned a similar direction in "bpf/s390: Implement
>> get_preempt_count()" [1], so I’ve added Ilya to the thread to discuss
>> this approach further.
> 
> You really sound like LLM. Do your homework as a human.

Got it.

I polished my draft using ChatGPT, which would leave LLM smell in my reply.

Here's my original draft:

Good idea. But I concern about the "in kernel disasm". Do you mean we
will build a disassembler for whitelist kfuncs at starting?

I noticed you've mentioned the same direction in "bpf/s390: Implement
get_preempt_count()" [1]. So, I added Ilya here to discuss this direction.

[1]
https://lore.kernel.org/bpf/CAADnVQKSMCohZy_HZwzNpFfTSnVu7rfxgmHEDgT9s28XxcDS5g@mail.gmail.com/

Thanks,
Leon



