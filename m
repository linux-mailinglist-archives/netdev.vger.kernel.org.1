Return-Path: <netdev+bounces-252686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKI7BFguc2mTswAAu9opvQ
	(envelope-from <netdev+bounces-252686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:16:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9306724F5
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B8BE300752E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25B3330B28;
	Fri, 23 Jan 2026 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vEr63Vax"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E4314A95
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156180; cv=none; b=iQMFD/KjR1PXVOKixXBzsIu5GKXtIg5P1MzctgaNW5Q/H6VSG7mrc+W7+nOQcVyvsreXDY0PFwYtI57UB9nAbUdA4Q6+M2LxlY1b+w8PtACU4x2YPRMksWLgawDgya3BQlTn+9VYKqwrdMPYmThMX0i/yRq+T3JNF6dCSUI4jOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156180; c=relaxed/simple;
	bh=BsTbk9PK/Dho8o57iGK8Ji2OTakuElTTQ+Nej8bohjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFcg55+psPZ547ULkv4TpppOrbQzhXhv/QRDNFWi92ZSXKwDIx7ptM/UL2xw0CXQxVUGRdLnZdxH4M7vFwpoBXjfQF9Wl3w4SIyIIpIQNtkNdzobj8wkwH9GTHnkEK/nlp14QBWYU4OYR4MU6GdCt1J/I37BB5SwdB2hfU5HN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vEr63Vax; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769156166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5/gOBon1dhydrWDZXwZcbC1y+hCYJIaCL2aKChxtag=;
	b=vEr63VaxWe8PUFcQkZqOMUJb88ZZobeFvXZ5re+ha18e8e9XToG54pm+B9mgR7TndTRpnJ
	Z7CVTe8VJw3ADiCjhwMTFmn0grkAqkpjTbh0cwXrBd9nJSv49ToBnt+4fI2m0lDhU4G1WJ
	RifQIWCxdui44PHAXUK/JzfCSAiJUHE=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, andrii@kernel.org, bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v11 04/12] bpf: support fsession for
 bpf_session_is_return
Date: Fri, 23 Jan 2026 16:15:50 +0800
Message-ID: <5071572.31r3eYUQgx@7940hx>
In-Reply-To:
 <ccb153dc349dfbbced71546e26de91c4e8094a0c515c3e2a9336dfa1a2f0a607@mail.kernel.org>
References:
 <20260123073532.238985-5-dongml2@chinatelecom.cn>
 <ccb153dc349dfbbced71546e26de91c4e8094a0c515c3e2a9336dfa1a2f0a607@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252686-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[iogearbox.net,linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.984];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9306724F5
X-Rspamd-Action: no action

On 2026/1/23 16:07 bot+bpf-ci@kernel.org write:
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 41228b0add52..29eecd79352e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1229,6 +1229,8 @@ enum {
> >  #endif
> >  };
> >
> > +#define BPF_TRAMP_IS_RETURN_SHIFT	63
> > +
> >  struct bpf_tramp_links {
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 19fd16697262..2ae8f29b854f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23011,6 +23011,19 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
> >  		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
> >  		*cnt = 1;
> > +	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
> > +		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
> > +		/*
> > +		 * inline the bpf_session_is_return() for fsession:
> > +		 *   bool bpf_session_is_return(void *ctx)
> > +		 *   {
> > +		 *       return (((u64 *)ctx)[-1] >> BPF_TRAMP_IS_RETURN_SHIFT) & 1;
> > +		 *   }
> > +		 */
> > +		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > +		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_IS_RETURN_SHIFT);
> > +		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
> > +		*cnt = 3;
> > +	}
> 
> The inline implementation reads bit 63 of ctx[-1] to check the is_return
> flag. However, looking at the x86 trampoline code in
> arch/x86/net/bpf_jit_comp.c, the trampoline only stores nr_regs in ctx[-1]:
> 
>     emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
>     emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
> 
> The is_return flag (bit 63) is never set by the current trampoline code.
> This means bpf_session_is_return() will always return 0 for fsession
> programs, even when executing at the return point.
> 
> I see this is fixed later in the series by commit ba766b26e776 ("bpf,x86:
> add fsession support for x86_64") which adds:
> 
>     func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
>     if (bpf_fsession_cnt(tlinks))
>         emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
> 
> Should this commit be squashed with the x86 trampoline changes to ensure
> the feature works correctly at each point in the series?

As I said before, this patch implement the common part of the fsession.
and we implement the architecture specific code for x86_64 in the later
patch.

> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21278745581
> 





