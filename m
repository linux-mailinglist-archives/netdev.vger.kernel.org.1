Return-Path: <netdev+bounces-271324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIwKA4MNw2lKnwQAu9opvQ
	(envelope-from <netdev+bounces-271324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:17:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE7431D3DF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92367303CE38
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B84A3C65F4;
	Tue, 24 Mar 2026 22:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLYPZkjo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8231F99E;
	Tue, 24 Mar 2026 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390397; cv=none; b=b/eT9dzE5+I86oghNLDrojdpwBTIZRZl9GqmYlGlTsDxtVdo1I83cScPocxB5b6iU8PVf96glfwVvqOYQCBHyg74elOq8+tCqkFPw8wVmHZmRWseZvUuMWijhmCo6M00qLEjgpg20CL+y60OTlDkA/qCW/iEsnIYDZyVmhd/uNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390397; c=relaxed/simple;
	bh=eJI0u7GU1D+LGzKAevVQeNkH32HP3Ejo+OuGGgudv7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjGUmj08rD5e9syer/rTyY5HDsDtJH3hWSzs1FOAl6McQp/t1OQhuF0ffpbvIo4MlEdnJ+SpYaBvzyk/bPl42hch+RsaVv3t8oGrcHyqweDzmWpck1Ts3yegIjGaaSjtRDsOZjxxcBoYVNG+V6XmDJaowt5eF70/OizXtaYPxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLYPZkjo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774390395; x=1805926395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eJI0u7GU1D+LGzKAevVQeNkH32HP3Ejo+OuGGgudv7I=;
  b=OLYPZkjoWPJjqSQafbJUCOK1M5al2vy6Cq4wOKBb8y75ifm59/HNX3Zy
   lUGnWmvocl4UmYw/rNIpfxQpVw3QgoFtlpRq7okee9RAQ+YNpba/UA3Bp
   3MuSaKzbI9vnOvkl1xFMaA8B+GZAJFTA8CyE2FR/AlHohP7NWZoxs8gqd
   NEM2RHI9oYvcgrlUqeB+gGjzREa+X3r5GqkHITNxxMaiWov5pu7zbf6iu
   jVKY69A0qt6KHF3JgW4QCsMtCzDIer6I5bsC9npCiRUiZTE9C6J88uyjt
   sPcNtu8R+inyqz9BiNk6RIibKOefv0AI7d0PNZ8k7Ic4vnrrldZXRSVdk
   Q==;
X-CSE-ConnectionGUID: fTeMfZfaRNqfXHvhJJnxlA==
X-CSE-MsgGUID: IJxJ2JAaQXKAQErzAydegg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75492575"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75492575"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:13:14 -0700
X-CSE-ConnectionGUID: 0fTXYyzEStyq9ED4/4r2bQ==
X-CSE-MsgGUID: zut23cVNTROVq5Rz2nxfPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224444423"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 15:13:14 -0700
Date: Tue, 24 Mar 2026 15:13:08 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Laight <david.laight.linux@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260324221308.7sh6afdy6r6tsf4w@desk>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
 <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
 <20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271324-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 9FE7431D3DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 09:59:30PM +0100, Borislav Petkov wrote:
> On Tue, Mar 24, 2026 at 11:16:51AM -0700, Pawan Gupta wrote:
> > As a mitigation for BHI, clear_bhb_loop() executes branches that overwrites
> > the Branch History Buffer (BHB). On Alder Lake and newer parts this
> > sequence is not sufficient because it doesn't clear enough entries. This
> > was not an issue because these CPUs have a hardware control (BHI_DIS_S)
> > that mitigates BHI in kernel.
> > 
> > BHI variant of VMSCAPE requires isolating branch history between guests and
> > userspace. Note that there is no equivalent hardware control for userspace.
> > To effectively isolate branch history on newer CPUs, clear_bhb_loop()
> > should execute sufficient number of branches to clear a larger BHB.
> > 
> > Dynamically set the loop count of clear_bhb_loop() such that it is
> > effective on newer CPUs too. Use the hardware control enumeration
> > X86_FEATURE_BHI_CTRL to select the appropriate loop count.
> > 
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> >  arch/x86/entry/entry_64.S   | 21 ++++++++++++++++-----
> >  arch/x86/net/bpf_jit_comp.c |  7 -------
> >  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> Ok, pls tell me why this below doesn't work?
> 
> The additional indirection makes even the BHB loop code simpler.
> 
> (I didn't pay too much attention to the labels, 2: is probably weird there).
> 
> ---
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 3a180a36ca0e..95c7ed9afbbe 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1532,11 +1532,13 @@ SYM_CODE_END(rewind_stack_and_make_dead)
>   * Note, callers should use a speculation barrier like LFENCE immediately after
>   * a call to this function to ensure BHB is cleared before indirect branches.
>   */
> -SYM_FUNC_START(clear_bhb_loop)
> +SYM_FUNC_START(__clear_bhb_loop)
>  	ANNOTATE_NOENDBR
>  	push	%rbp
> +	/* BPF caller may require %rax to be preserved */
> +	push	%rax
>  	mov	%rsp, %rbp
> -	movl	$5, %ecx
> +
>  	ANNOTATE_INTRA_FUNCTION_CALL
>  	call	1f
>  	jmp	5f
> @@ -1557,17 +1559,17 @@ SYM_FUNC_START(clear_bhb_loop)
>  	 * but some Clang versions (e.g. 18) don't like this.
>  	 */
>  	.skip 32 - 18, 0xcc
> -2:	movl	$5, %eax
> +2:
>  3:	jmp	4f
>  	nop
> -4:	sub	$1, %eax
> +4:	sub	$1, %rsi

%rsi needs to be loaded again with $inner_loop_count once per every
outer loop iteration. We probably need another register to hold that.

>  	jnz	3b
> -	sub	$1, %ecx
> +	sub	$1, %rdi
>  	jnz	1b
>  .Lret2:	RET
>  5:
> +	pop	%rax
>  	pop	%rbp
>  	RET
> -SYM_FUNC_END(clear_bhb_loop)
> -EXPORT_SYMBOL_FOR_KVM(clear_bhb_loop)
> -STACK_FRAME_NON_STANDARD(clear_bhb_loop)
> +SYM_FUNC_END(__clear_bhb_loop)
> +STACK_FRAME_NON_STANDARD(__clear_bhb_loop)
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 70b377fcbc1c..a9f406941e11 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -390,6 +390,7 @@ extern void write_ibpb(void);
>  
>  #ifdef CONFIG_X86_64
>  extern void clear_bhb_loop(void);
> +extern void __clear_bhb_loop(unsigned int a, unsigned int b);
>  #endif
>  
>  extern void (*x86_return_thunk)(void);
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 83f51cab0b1e..c41b0548cf2a 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -3735,3 +3735,11 @@ void __warn_thunk(void)
>  {
>  	WARN_ONCE(1, "Unpatched return thunk in use. This should not happen!\n");
>  }
> +
> +void clear_bhb_loop(void)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL))
> +		__clear_bhb_loop(12, 7);
> +	else
> +		__clear_bhb_loop(5, 5);
> +}

This is cleaner. A few things to consider are, CLEAR_BRANCH_HISTORY that
calls clear_bhb_loop() would be calling into C code very early during the
kernel entry. The code generated here may vary based on the compiler. Any
indirect branch here would be security risk. This needs to be noinstr so
that it can't be hijacked by probes and ftraces.

At kernel entry, calling into C before mitigations are applied is risky.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 63d6c9fa5e80..e2cceabb23e8 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1614,11 +1614,6 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
>  	u8 *func;
>  
>  	if (cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_LOOP)) {
> -		/* The clearing sequence clobbers eax and ecx. */
> -		EMIT1(0x50); /* push rax */
> -		EMIT1(0x51); /* push rcx */

> -		ip += 2;
> -
>  		func = (u8 *)clear_bhb_loop;

Although call to clear_bhb_loop() will be inserted at the end of the BPF
program before it returns, I am not sure if it is safe to assume that
trashing registers in the path clear_bhb_loop() -> __clear_bhb_loop() is
okay? Especially, when we don't know what code compiler generated for
clear_bhb_loop(). BPF experts would know better?

