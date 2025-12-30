Return-Path: <netdev+bounces-246293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F7CE8CBF
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 07:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB0AF300F70A
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 06:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EED92E973F;
	Tue, 30 Dec 2025 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VI7ubRs+"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F32701DA
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767076464; cv=none; b=FeEOn9MfEhjPpMQF4hR9QCdSxbgdaXDtWGFz4IXJFPPVZiixARSXbjsrddzW4l/jdR25bTeZZzrIG7ApigSmrZIeOk/2Q3x1eE09VCU24FV83FNy4VEmznes7+ikCeFvZHKyPCIzExcGq0BCPAMFbZGRx1jLW996/QS6dUX/iDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767076464; c=relaxed/simple;
	bh=TKf5w0jut+gvRqj6BQLzeYsFg54V7ELSxqaG5ayiiFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxbblumXM0/T0kE/7Hl7pLJiCQegaeu3oZEW3OrGKVG1vuPWWw76F3ZmN/fSrk2F83sK9+q+PAw+N1+86fdQjblWKM7/x5T7U+F7/YKohfbpRjRt2aW0+Uv6jsuGqLj1ONSOKgnFqf9EzzK/uuAnucvIryWltEH3S3+y49j0GuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VI7ubRs+; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767076449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BX74wYtIpBX9oc/n3E/vw1MH9I5JUevUkmGZqt3oGsA=;
	b=VI7ubRs+kGjndsmCpBipo1hi9ZVFTsRJqpkzIROD9YikIlIFU22v9tV4RiyZRrWqAtjsss
	7LZ19OssnkbYub3YkVtdYeLDnsc4PmBMP++lUgBxAWeacrLiaJev/nsqQPHiHDZyzW4aHU
	5oE3su+ihQlJuN4ZF7HRsVw3od6kV6E=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 jiang.biao@linux.dev, x86@kernel.org, hpa@zytor.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf,
 x86: inline bpf_get_current_task() for x86_64
Date: Tue, 30 Dec 2025 14:33:53 +0800
Message-ID: <6448186.lOV4Wx5bFT@7940hx>
In-Reply-To: <0f0bd124a42723acf87b427cc69356a0e4b1e339.camel@gmail.com>
References:
 <20251225104459.204104-1-dongml2@chinatelecom.cn>
 <0f0bd124a42723acf87b427cc69356a0e4b1e339.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/30 03:58 Eduard Zingerman <eddyz87@gmail.com> write:
> On Thu, 2025-12-25 at 18:44 +0800, Menglong Dong wrote:
> > Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
> > to obtain better performance. The instruction we use here is:
> > 
> >   65 48 8B 04 25 [offset] // mov rax, gs:[offset]
> > 
> > Not sure if there is any side effect here.
> > 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> 
> The change makes sense to me.
> Could you please address the compilation error reported by kernel test robot?

Yeah, I'll send a V2 later.

> Could you please also add a tests case using __jited annotation like
> in verifier_ldsx.c?

OK, sounds nice.

> 
> >  arch/x86/net/bpf_jit_comp.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index b69dc7194e2c..7f38481816f0 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1300,6 +1300,19 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
> >  	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
> >  }
> >  
> > +static void emit_ldx_percpu_r0(u8 **pprog, const void __percpu *ptr)
> > +{
> > +	u8 *prog = *pprog;
> > +
> > +	/* mov rax, gs:[offset] */
> > +	EMIT2(0x65, 0x48);
> > +	EMIT2(0x8B, 0x04);
> > +	EMIT1(0x25);
> > +	EMIT((u32)(unsigned long)ptr, 4);
> > +
> > +	*pprog = prog;
> > +}
> > +
> >  static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
> >  			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
> >  {
> > @@ -2435,6 +2448,15 @@ st:			if (is_imm8(insn->off))
> >  		case BPF_JMP | BPF_CALL: {
> >  			u8 *ip = image + addrs[i - 1];
> >  
> > +			if (insn->src_reg == 0 && (insn->imm == BPF_FUNC_get_current_task ||
> > +						   insn->imm == BPF_FUNC_get_current_task_btf)) {
> > +				if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
> > +					emit_ldx_percpu_r0(&prog, &const_current_task);
> > +				else
> > +					emit_ldx_percpu_r0(&prog, &current_task);
> 
> Nit: arch/x86/include/asm/current.h says that current_task and const_current_task are aliases.
>      In that case, why would we need two branches here?

It's not need here. I were not familiar with the per-cpu variable
before, and didn't realize it.

And it seems that the gs register is only used in the
CONFIG_USE_X86_SEG_SUPPORT case, which is the common case.
So maybe we can support it for this case only. For the
!CONFIG_USE_X86_SEG_SUPPORT case, let me do more analysis to
see if we can support it easily.

Thanks!
Menglong Dong

> 
> > +				break;
> > +			}
> > +
> >  			func = (u8 *) __bpf_call_base + imm32;
> >  			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
> >  				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
> > @@ -4067,3 +4089,14 @@ bool bpf_jit_supports_timed_may_goto(void)
> >  {
> >  	return true;
> >  }
> > +
> > +bool bpf_jit_inlines_helper_call(s32 imm)
> > +{
> > +	switch (imm) {
> > +	case BPF_FUNC_get_current_task:
> > +	case BPF_FUNC_get_current_task_btf:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> 





