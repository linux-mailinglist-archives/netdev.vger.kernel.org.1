Return-Path: <netdev+bounces-252681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOXHGrUtc2mTswAAu9opvQ
	(envelope-from <netdev+bounces-252681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:13:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C877246E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 643F03093A56
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DFE33C53D;
	Fri, 23 Jan 2026 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr3e5Ugp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86A2BF3CC;
	Fri, 23 Jan 2026 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155665; cv=none; b=OfwB/n7ykKQB32FNo3WBDwAXIS/BmtAcXTkPfWruYsJ3IUOcylDuaADOXc3fjnft1AqjgBfg0r1hygnBNWoBWWoQHISwzo24VjNCniasKf1m9oYhj4BWoXCxQpqogjkMKx5KWlKxlReUDigugHM/+ER++eo3NGy9rHkwEfW7+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155665; c=relaxed/simple;
	bh=k7g1p9yupZb5enxeeR9GXHy8LchCGIBd3BbeE6l67Ts=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FeyCHyshf/WEo7gYo3St6v07DFvEobIRWgWkJgmnpeZFX6VpznZ2OM/43MZxwXidMxGD0wl9OwWH7LuWvzSQIyKvVyrzfavV06/WHx8pJRfTMGSJw7GTMgGAUBdGne3lJwIyry/ZTDLYp7+YKWmWBamEXBKyHbBupWeEzV+9nlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr3e5Ugp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA47C4CEF1;
	Fri, 23 Jan 2026 08:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769155664;
	bh=k7g1p9yupZb5enxeeR9GXHy8LchCGIBd3BbeE6l67Ts=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Mr3e5UgplRLfo5Bd/+KVkV1vdkRCh811m3QgVzFT+XrHWwksKt6Zn6ZmjeBpIokfS
	 5kBNHHk/7GrpQKKimj0AmoFKBM+0Is2wQgiIewjZvamlz5zqdvGiAdTvyPYquXHPnC
	 6VfngtrihZyZMZMTDe79uG/V0g93CLmky6B3OlLE6PoUxhk/EOVde+e3cYyo+cYpYL
	 uFehAILhC9CGdp6ESu7JYCOpvkqcSRyncxdicB4FYQGXey/zrpBKk9P1T+mg7CyIKz
	 ae32EN2A5ljb20CAQ73CDeRaH/8Bq9tflBQsqfWxSX4XcZs7DNSHeJ8gzyEAztertY
	 hqDwRL1j9+Ffw==
Content-Type: multipart/mixed; boundary="===============2440790346531555476=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ccb153dc349dfbbced71546e26de91c4e8094a0c515c3e2a9336dfa1a2f0a607@mail.kernel.org>
In-Reply-To: <20260123073532.238985-5-dongml2@chinatelecom.cn>
References: <20260123073532.238985-5-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v11 04/12] bpf: support fsession for bpf_session_is_return
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,dsahern@kernel.org,tglx@linutronix.de,mingo@redhat.com,jiang.biao@linux.dev,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 23 Jan 2026 08:07:44 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252681-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[iogearbox.net,linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: C0C877246E
X-Rspamd-Action: no action

--===============2440790346531555476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 41228b0add52..29eecd79352e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1229,6 +1229,8 @@ enum {
>  #endif
>  };
>
> +#define BPF_TRAMP_IS_RETURN_SHIFT	63
> +
>  struct bpf_tramp_links {

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 19fd16697262..2ae8f29b854f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23011,6 +23011,19 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
>  		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>  		*cnt = 1;
> +	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
> +		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
> +		/*
> +		 * inline the bpf_session_is_return() for fsession:
> +		 *   bool bpf_session_is_return(void *ctx)
> +		 *   {
> +		 *       return (((u64 *)ctx)[-1] >> BPF_TRAMP_IS_RETURN_SHIFT) & 1;
> +		 *   }
> +		 */
> +		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_IS_RETURN_SHIFT);
> +		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
> +		*cnt = 3;
> +	}

The inline implementation reads bit 63 of ctx[-1] to check the is_return
flag. However, looking at the x86 trampoline code in
arch/x86/net/bpf_jit_comp.c, the trampoline only stores nr_regs in ctx[-1]:

    emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
    emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);

The is_return flag (bit 63) is never set by the current trampoline code.
This means bpf_session_is_return() will always return 0 for fsession
programs, even when executing at the return point.

I see this is fixed later in the series by commit ba766b26e776 ("bpf,x86:
add fsession support for x86_64") which adds:

    func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
    if (bpf_fsession_cnt(tlinks))
        emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);

Should this commit be squashed with the x86 trampoline changes to ensure
the feature works correctly at each point in the series?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21278745581

--===============2440790346531555476==--

