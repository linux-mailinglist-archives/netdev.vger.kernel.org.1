Return-Path: <netdev+bounces-259506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EMPIw0vl2kcvgIAu9opvQ
	(envelope-from <netdev+bounces-259506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:41:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15038160441
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5AF53077E77
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A86F347BB9;
	Thu, 19 Feb 2026 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dbRrhdJj"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50F33F394
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515447; cv=none; b=NXoZWThht2b7tNg7KbMgdsYtlQVYoQKJLFD6bbabuCGahB2rKg6QJYBkrD5uV+xx9tbPWHjFq7aiQRhyzph0UE4zuhQPtFFDOuPk+r4UUEABL649C1yimEqJ9yViGezwtDN/yJaJB626MoLkx5N9buGfYRHXwMBL7uCsXJ7fL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515447; c=relaxed/simple;
	bh=ixhP+oBrva5ygcp2hjhyaCOAT/lLVs3Df/zIr2l4nqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsmFaJQwn/hynLxFPJ05fRdzn1iLsoTBidSooSVGVrXTmKZM/H5EXO6DNQ8lLjGTQSAqcnAAM0Rm3wDMuKdeTlfJuXi14Hx6N3v66u6pzmZKCMjQeAxpVkGrt8ItLKPWwH9AoDDDowF9YsrCkUHScck1sHE8azsqvhy9hGRdJ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dbRrhdJj; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <10911cdf-d951-41a6-82c1-1c0ecd47c5f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771515433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dar0RQt4M278UggC4OmngN9+vjxlsvXau8VM1wIA7Uc=;
	b=dbRrhdJj1yu9EW96WbowLTZvrGwoJeZ7bRWKOGHU/itw/cjdE7WOq4Ghc+D/CbDuq+msoC
	c83WPqh3xLBfArsVfWotrWTNWoRHXy/uOQoj6nTQRkxVU2JEhLwB4JYXtwA4p7lW3W2PKx
	HWJM5Y+mUQOy0MQlOl7geSIZqE/ws/U=
Date: Thu, 19 Feb 2026 23:36:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/6] bpf, arm64: Add 64-bit bitops kfuncs
 support
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, Peilin Ye <yepeilin@google.com>,
 Luis Gerhorst <luis.gerhorst@fau.de>, Viktor Malik <vmalik@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260219142933.13904-1-leon.hwang@linux.dev>
 <20260219142933.13904-4-leon.hwang@linux.dev> <m2342woiw9.fsf@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <m2342woiw9.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259506-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,huaweicloud.com,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,fau.de,lists.infradead.org,vger.kernel.org,fb.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15038160441
X-Rspamd-Action: no action



On 2026/2/19 23:25, Puranjay Mohan wrote:
> Leon Hwang <leon.hwang@linux.dev> writes:
> 
>> Implement JIT inlining of the 64-bit bitops kfuncs on arm64.
>>
>> bpf_clz64(), bpf_ffs64(), bpf_fls64(), and bpf_bitrev64() are always
>> inlined using mandatory ARMv8 CLZ/RBIT instructions. bpf_ctz64() is
>> inlined via RBIT + CLZ, or via the native CTZ instruction when
>> FEAT_CSSC is available. bpf_rol64() and bpf_ror64() are always inlined
>> via RORV.
>>
>> bpf_popcnt64() is not inlined as the native population count instruction
>> requires NEON/SIMD registers, which should not be touched from BPF
>> programs. It therefore falls back to a regular function call.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  arch/arm64/net/bpf_jit_comp.c | 123 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 123 insertions(+)
>>
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> index 7a530ea4f5ae..f03f732063d9 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -1192,6 +1192,127 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>  	return 0;
>>  }
>>  
>> +static inline u32 a64_clz64(u8 rd, u8 rn)
>> +{
>> +	/*
>> +	 * Arm Architecture Reference Manual for A-profile architecture
>> +	 * (Document number: ARM DDI 0487)
>> +	 *
>> +	 *   A64 Base Instruction Descriptions
>> +	 *   C6.2 Alphabetical list of A64 base instructions
>> +	 *
>> +	 *   C6.2.91 CLZ
>> +	 *
>> +	 *     Count leading zeros
>> +	 *
>> +	 *     This instruction counts the number of consecutive binary zero bits,
>> +	 *     starting from the most significant bit in the source register,
>> +	 *     and places the count in the destination register.
>> +	 */
>> +	/* CLZ Xd, Xn */
>> +	return 0xdac01000 | (rn << 5) | rd;
>> +}
>> +
>> +static inline u32 a64_ctz64(u8 rd, u8 rn)
>> +{
>> +	/*
>> +	 * Arm Architecture Reference Manual for A-profile architecture
>> +	 * (Document number: ARM DDI 0487)
>> +	 *
>> +	 *   A64 Base Instruction Descriptions
>> +	 *   C6.2 Alphabetical list of A64 base instructions
>> +	 *
>> +	 *   C6.2.144 CTZ
>> +	 *
>> +	 *     Count trailing zeros
>> +	 *
>> +	 *     This instruction counts the number of consecutive binary zero bits,
>> +	 *     starting from the least significant bit in the source register,
>> +	 *     and places the count in the destination register.
>> +	 *
>> +	 *     This instruction requires FEAT_CSSC.
>> +	 */
>> +	/* CTZ Xd, Xn */
>> +	return 0xdac01800 | (rn << 5) | rd;
>> +}
>> +
>> +static inline u32 a64_rbit64(u8 rd, u8 rn)
>> +{
>> +	/*
>> +	 * Arm Architecture Reference Manual for A-profile architecture
>> +	 * (Document number: ARM DDI 0487)
>> +	 *
>> +	 *   A64 Base Instruction Descriptions
>> +	 *   C6.2 Alphabetical list of A64 base instructions
>> +	 *
>> +	 *   C6.2.320 RBIT
>> +	 *
>> +	 *     Reverse bits
>> +	 *
>> +	 *     This instruction reverses the bit order in a register.
>> +	 */
>> +	/* RBIT Xd, Xn */
>> +	return 0xdac00000 | (rn << 5) | rd;
>> +}
> 
> I don't think adding the above three functions is the best to JIT these
> intructions, do it like the other data1 and data2 instructions and add
> them to the generic framework like the following patch(untested) does:
> > -- >8 --
> 
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index 18c7811774d3..b2696af0b817 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -221,6 +221,9 @@ enum aarch64_insn_data1_type {
>  	AARCH64_INSN_DATA1_REVERSE_16,
>  	AARCH64_INSN_DATA1_REVERSE_32,
>  	AARCH64_INSN_DATA1_REVERSE_64,
> +	AARCH64_INSN_DATA1_RBIT,
> +	AARCH64_INSN_DATA1_CLZ,
> +	AARCH64_INSN_DATA1_CTZ,
>  };
> 
>  enum aarch64_insn_data2_type {
> @@ -389,6 +392,9 @@ __AARCH64_INSN_FUNCS(rorv,	0x7FE0FC00, 0x1AC02C00)
>  __AARCH64_INSN_FUNCS(rev16,	0x7FFFFC00, 0x5AC00400)
>  __AARCH64_INSN_FUNCS(rev32,	0x7FFFFC00, 0x5AC00800)
>  __AARCH64_INSN_FUNCS(rev64,	0x7FFFFC00, 0x5AC00C00)
> +__AARCH64_INSN_FUNCS(rbit,	0x7FFFFC00, 0x5AC00000)
> +__AARCH64_INSN_FUNCS(clz,	0x7FFFFC00, 0x5AC01000)
> +__AARCH64_INSN_FUNCS(ctz,	0x7FFFFC00, 0x5AC01800)
>  __AARCH64_INSN_FUNCS(and,	0x7F200000, 0x0A000000)
>  __AARCH64_INSN_FUNCS(bic,	0x7F200000, 0x0A200000)
>  __AARCH64_INSN_FUNCS(orr,	0x7F200000, 0x2A000000)
> diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
> index 4e298baddc2e..2229ab596cda 100644
> --- a/arch/arm64/lib/insn.c
> +++ b/arch/arm64/lib/insn.c
> @@ -1008,6 +1008,15 @@ u32 aarch64_insn_gen_data1(enum aarch64_insn_register dst,
>  		}
>  		insn = aarch64_insn_get_rev64_value();
>  		break;
> +	case AARCH64_INSN_DATA1_CLZ:
> +		insn = aarch64_insn_get_clz_value();
> +		break;
> +	case AARCH64_INSN_DATA1_RBIT:
> +		insn = aarch64_insn_get_rbit_value();
> +		break;
> +	case AARCH64_INSN_DATA1_CTZ:
> +		insn = aarch64_insn_get_ctz_value();
> +		break;
>  	default:
>  		pr_err("%s: unknown data1 encoding %d\n", __func__, type);
>  		return AARCH64_BREAK_FAULT;
> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index bbea4f36f9f2..af806c39dadb 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h
> @@ -248,6 +248,12 @@
>  #define A64_REV16(sf, Rd, Rn) A64_DATA1(sf, Rd, Rn, REVERSE_16)
>  #define A64_REV32(sf, Rd, Rn) A64_DATA1(sf, Rd, Rn, REVERSE_32)
>  #define A64_REV64(Rd, Rn)     A64_DATA1(1, Rd, Rn, REVERSE_64)
> +/* Rd = RBIT(Rn) */
> +#define A64_RBIT(sf, Rd, Rn) A64_DATA1(sf, Rd, Rn, RBIT)
> +/* Rd = CLZ(Rn) */
> +#define A64_CLZ(sf, Rd, Rn) A64_DATA1(sf, Rd, Rn, CLZ)
> +/* Rd = CTZ(Rn) */
> +#define A64_CTZ(sf, Rd, Rn) A64_DATA1(sf, Rd, Rn, CTZ)
> 
>  /* Data-processing (2 source) */
>  /* Rd = Rn OP Rm */
> 
> -- 8< --
> 
> Thanks,
> Puranjay

Ack.

I'll do it in the next revision.

Thanks,
Leon


