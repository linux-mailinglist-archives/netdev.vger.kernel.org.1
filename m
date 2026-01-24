Return-Path: <netdev+bounces-253021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ga4M5hEdGlr4AAAu9opvQ
	(envelope-from <netdev+bounces-253021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 05:03:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BAA7C6F2
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 05:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78B303005989
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1151EDA3C;
	Sat, 24 Jan 2026 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Li/lt6R3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82B325771;
	Sat, 24 Jan 2026 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769227412; cv=none; b=ffgPfiMs3QUJgCOSOrt7auANd/zqx6RThCgNsaQIDzBsVH48IhPEm0mEspmNjBt6klHwtQOy1V29yHeBWvU3MOMHmEEJIuwUDl3Yu0QqbCkKg4+n208EhqxCxg4JnFSS4LmYDQntuRTbzXXH+GqIJSY/AZghrLEu4eHEkoTM+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769227412; c=relaxed/simple;
	bh=FeTY2H9pvOViU1aLCvEZ9/nNOLeo6pWxKfZ/lmKgCYc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PNSOJ9eGrcK+gXp+v6oDWeTXwJQme5SS/ocexyNsMGeNQa6S3n7GN7NNwpkhdS1CcY53ZEw59e67CaJeS1wLS+PsFUrizxak765SaB+znXminze5s+t8KJimf3FI8HnmqPIt4WyqVW8BUAmVCw0oeTj22urY9/KtxHGY+l0at9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li/lt6R3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC00C16AAE;
	Sat, 24 Jan 2026 04:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769227412;
	bh=FeTY2H9pvOViU1aLCvEZ9/nNOLeo6pWxKfZ/lmKgCYc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Li/lt6R3Of4NbDDAwyk1rJXxw3FHEy3yGmIOWoUB/Wu8yLKR56/Vl2ENdhfbdAMKx
	 +20P8zeVlRNZq11FUr9p7R8Xy/7Gz7Srr2FhaJFjzMwrVLj67SwzzroLqA8GwCR3oK
	 sSlA9Z3iC6xgv+22Y+0143FTIAtpTu9tA8v6FldFqdwCdzRqsaTPKJjjhYlNLoA54x
	 dmWujFqI/POtVLFq09BzDHW4TpIcna/wl1N4KZpmt3y6VvFJjcVDVer3306heFayGW
	 WwIaff2x9GWnebB4l/QKBzAUmH+L63KZCXfBmpkKhhvX3UXQ777/pqy7hj4oRX36eM
	 Dwn/HXj+QrRaQ==
Content-Type: multipart/mixed; boundary="===============0761627872793277005=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c574509ec91053e049ae7e86a354f13d4cc28ec10b0530c6302598e8662ee88@mail.kernel.org>
In-Reply-To: <20260124033119.28682-5-dongml2@chinatelecom.cn>
References: <20260124033119.28682-5-dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next v12 04/13] bpf: support fsession for bpf_session_is_return
From: bot+bpf-ci@kernel.org
To: menglong8.dong@gmail.com,andrii@kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,dsahern@kernel.org,tglx@linutronix.de,mingo@redhat.com,jiang.biao@linux.dev,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 24 Jan 2026 04:03:31 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253021-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 72BAA7C6F2
X-Rspamd-Action: no action

--===============0761627872793277005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 13f0a2de33b7..f7baeb8278ca 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> @@ -3341,34 +3349,39 @@ __bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
>
>  __bpf_kfunc_end_defs();
>
> -BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
> +BTF_KFUNCS_START(session_kfunc_set_ids)
>  BTF_ID_FLAGS(func, bpf_session_is_return)
>  BTF_ID_FLAGS(func, bpf_session_cookie)
> -BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
> +BTF_KFUNCS_END(session_kfunc_set_ids)
>
> -static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +static int bpf_session_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  {
> -	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
> +	if (!btf_id_set8_contains(&session_kfunc_set_ids, kfunc_id))
>  		return 0;
>
> -	if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
> +	if (!is_kprobe_session(prog) && !is_uprobe_session(prog) && !is_trace_fsession(prog))
>  		return -EACCES;

The filter now allows fsession programs to call both bpf_session_is_return()
and bpf_session_cookie(). The verifier inline handles bpf_session_is_return()
for fsession, but what happens when an fsession program calls
bpf_session_cookie()?

Looking at bpf_session_cookie() in the same file:

    __bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
    {
        struct bpf_session_run_ctx *session_ctx;
        session_ctx = container_of(current->bpf_ctx, struct bpf_session_run_ctx, run_ctx);
        return session_ctx->data;
    }

This assumes current->bpf_ctx points to a struct bpf_session_run_ctx, but
fsession programs use struct bpf_tramp_run_ctx (set up in __bpf_prog_enter*).
The container_of() will return an incorrect pointer, and session_ctx->data
will read from the wrong memory location (the saved_run_ctx field of
bpf_tramp_run_ctx instead of the session cookie).

Is this intentional to defer bpf_session_cookie() support to a later commit?
If so, should the filter perhaps only allow bpf_session_is_return() for
fsession at this point?

Note: I see that commit b8f4610f8738 ("bpf: support fsession for
bpf_session_cookie") in the same series adds the verifier inline for
bpf_session_cookie() with fsession, which would resolve this. However, at
this commit, calling bpf_session_cookie() from an fsession program would
produce incorrect results.

>
>  	return 0;
>  }

[ ... ]

> +static int __init bpf_trace_kfuncs_init(void)
>  {
> -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
> +	int err = 0;
> +
> +	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_session_kfunc_set);
> +	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_session_kfunc_set);
> +
> +	return err;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21308666922

--===============0761627872793277005==--

