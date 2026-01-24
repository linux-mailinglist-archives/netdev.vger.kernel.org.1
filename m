Return-Path: <netdev+bounces-253028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ItZLHpidGmv5AAAu9opvQ
	(envelope-from <netdev+bounces-253028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:11:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1267E7C9B7
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74C6B30143EA
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CC02580DE;
	Sat, 24 Jan 2026 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xbCgd1j6"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84C1E487;
	Sat, 24 Jan 2026 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235044; cv=none; b=ClgAYbmNCJaTByILMJtjXBGLOHyqwXsDvdCpQfpnD6XPbph9WhH7kPIhcs5AzDdPMNEgBZ3n1sOvk8xt79k+dTIxG5rvgqcKHmF/3j2+qOdDY3qqVXfxuOdnbrYKz1FnHBb3xHkzrQMTd7vbH34bIr37AjCC8oFYllzNEb06oRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235044; c=relaxed/simple;
	bh=VNiyQCUp5+ZgV58GUdTSy4dXL7YXciAXAAwf2g2frZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsIBYR/ZCpjXeijBqINz3VDQ702spe6m3MgZV0/TiCVLy2G/YY/FAylvvkPrk3NpgHKn0jsbIIfyMJ7PRyzoJyRc8iABMK4vk8O0+AtRlWB3mFT0sfm0keNz/GUhFgnyhGA2Lu9ndV+sGQAHHEAhRea0w800cSBmlKCyJIbdGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xbCgd1j6; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769235040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTfY4Bf/UEGsU/2t1f75+6Jfk7krneoiYduWh0C81RI=;
	b=xbCgd1j6ZkR/WugoUXxTty9Genimp3CWgvo/EXnmjYOf146pfpyOWbwbC8k+jwQfkrxCKV
	fFgJ/DL2PXaWLZmGot7z9KNT23AvlL6fWwxJpXMdyoIwEB3ECKtFda6HzVb4jt2Xtm/wR1
	Ox4nkmMdSNw8EVR8mFuv1XXQU4pHzE0=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, andrii@kernel.org, bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v12 04/13] bpf: support fsession for
 bpf_session_is_return
Date: Sat, 24 Jan 2026 12:56:37 +0800
Message-ID: <2818250.mvXUDI8C0e@7950hx>
In-Reply-To:
 <5c574509ec91053e049ae7e86a354f13d4cc28ec10b0530c6302598e8662ee88@mail.kernel.org>
References:
 <20260124033119.28682-5-dongml2@chinatelecom.cn>
 <5c574509ec91053e049ae7e86a354f13d4cc28ec10b0530c6302598e8662ee88@mail.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253028-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim]
X-Rspamd-Queue-Id: 1267E7C9B7
X-Rspamd-Action: no action

On 2026/1/24 12:03, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 13f0a2de33b7..f7baeb8278ca 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> > @@ -3341,34 +3349,39 @@ __bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
> >
> >  __bpf_kfunc_end_defs();
> >
> > -BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
> > +BTF_KFUNCS_START(session_kfunc_set_ids)
> >  BTF_ID_FLAGS(func, bpf_session_is_return)
> >  BTF_ID_FLAGS(func, bpf_session_cookie)
> > -BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
> > +BTF_KFUNCS_END(session_kfunc_set_ids)
> >
> > -static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
> > +static int bpf_session_filter(const struct bpf_prog *prog, u32 kfunc_id)
> >  {
> > -	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
> > +	if (!btf_id_set8_contains(&session_kfunc_set_ids, kfunc_id))
> >  		return 0;
> >
> > -	if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
> > +	if (!is_kprobe_session(prog) && !is_uprobe_session(prog) && !is_trace_fsession(prog))
> >  		return -EACCES;
> 
> The filter now allows fsession programs to call both bpf_session_is_return()
> and bpf_session_cookie(). The verifier inline handles bpf_session_is_return()
> for fsession, but what happens when an fsession program calls
> bpf_session_cookie()?
> 
> Looking at bpf_session_cookie() in the same file:
> 
>     __bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
>     {
>         struct bpf_session_run_ctx *session_ctx;
>         session_ctx = container_of(current->bpf_ctx, struct bpf_session_run_ctx, run_ctx);
>         return session_ctx->data;
>     }
> 
> This assumes current->bpf_ctx points to a struct bpf_session_run_ctx, but
> fsession programs use struct bpf_tramp_run_ctx (set up in __bpf_prog_enter*).
> The container_of() will return an incorrect pointer, and session_ctx->data
> will read from the wrong memory location (the saved_run_ctx field of
> bpf_tramp_run_ctx instead of the session cookie).
> 
> Is this intentional to defer bpf_session_cookie() support to a later commit?
> If so, should the filter perhaps only allow bpf_session_is_return() for
> fsession at this point?
> 
> Note: I see that commit b8f4610f8738 ("bpf: support fsession for
> bpf_session_cookie") in the same series adds the verifier inline for
> bpf_session_cookie() with fsession, which would resolve this. However, at
> this commit, calling bpf_session_cookie() from an fsession program would
> produce incorrect results.

As I said before, this patch implement the common part of the fsession.
and we implement the architecture specific code for x86_64 in the later
patch.

> 
> >
> >  	return 0;
> >  }
> 
> [ ... ]
> 
> > +static int __init bpf_trace_kfuncs_init(void)
> >  {
> > -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
> > +	int err = 0;
> > +
> > +	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_session_kfunc_set);
> > +	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_session_kfunc_set);
> > +
> > +	return err;
> >  }
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21308666922
> 





