Return-Path: <netdev+bounces-259950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELjHAVMZnGmq/gMAu9opvQ
	(envelope-from <netdev+bounces-259950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:09:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A490E1738B6
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE4EA3044B9F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B435A34E746;
	Mon, 23 Feb 2026 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni6DRbZW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C8191F91;
	Mon, 23 Feb 2026 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837568; cv=none; b=EI3GWT21j/pXed7uwXrmBxVZd6s93L+SuDeumgh7qBJVuFWEpt5WYg75IkrlPwZ2c1gMWThz6t4Gy5vkiZL3f7iHv+ni1tQJTdwzShdV8Y9HVe19nVYs76vg10ndDqBRcFSaLoxcm9ieeZANdBjzwVvDYhL1VG7mBZr0jabQKUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837568; c=relaxed/simple;
	bh=xOsTC6p+MZdRupfWd0cYah+vrpOiRsAEOKfEuNIROxU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ei7qAoDawgDH9yWhSanYupkPud7zQF7Qrzscs+0bqNQlxIyvY/5CGTTs7jpY7Hked40m6BlNJT48pNeKwSJQI6q0i92wNeEFj8to2NdFWP9AdOjWhMxhxf8wCW+Iz1vw7pm8LWfnZo7rTvh+CmEFt+MEqraG4ZzYDvAj7B9kajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni6DRbZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F331BC116C6;
	Mon, 23 Feb 2026 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771837568;
	bh=xOsTC6p+MZdRupfWd0cYah+vrpOiRsAEOKfEuNIROxU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Ni6DRbZWw7O3Ajema5W/7c2V5ft+xDgZ0hJBVWtbIzUJilt//KGkSvW/u8VVGQVGf
	 GNio2KsiE7wJMZSM3rY+lz2R/a03E4nv3lsutoGVLnKojzHTZV1h306fzn7Eomw/3j
	 FLdn2qJqtJv87dx/mX3fgFuO6vhUXwbkVz9kfROF15v5V1yMaT/MtBuSBlAeJTQzc4
	 M+Er6YUw1eXf7H/ADh3IZMzE6kO4i+6Q0K35r+MCimkpqRGtwOq0kq8lfhV93b1RrC
	 KA4hgy2goD61sLjaOszePy+K3QFwITmor7cqgRweWep4cMm672PtwGgRQFYBSBUEie
	 Rague4aOPHaIw==
Content-Type: multipart/mixed; boundary="===============2711244271401940436=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <692c1f3c4b95e9b8a2bbaf333f4618f1ca1c3cc36fc8b0246b094cd67ed62dbd@mail.kernel.org>
In-Reply-To: <20260223083120.23776-2-slava.imameev@crowdstrike.com>
References: <20260223083120.23776-2-slava.imameev@crowdstrike.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support multi-level pointer params via SCALAR_VALUE for trampolines
From: bot+bpf-ci@kernel.org
To: slava.imameev@crowdstrike.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-open-source@crowdstrike.com,slava.imameev@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 23 Feb 2026 09:06:05 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com,iogearbox.net,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-259950-lists,netdev=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A490E1738B6
X-Rspamd-Action: no action

--===============2711244271401940436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7708958e3fb8..ebb1b0c3f993 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -6905,8 +6920,11 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  	/*
>  	 * If it's a pointer to void, it's the same as scalar from the verifier
>  	 * safety POV. Either way, no futher pointer walking is allowed.
> +	 * Multilevel pointers (e.g., int**, struct foo**, char***) of any type
> +	 * are treated as scalars because the verifier lacks the context to infer
> +	 * the size of their target memory regions.
>  	 */
> -	if (is_void_or_int_ptr(btf, t))
> +	if (is_void_or_int_ptr(btf, t) || is_multilevel_ptr(btf, t))
>  		return true;

In the v2 review thread, Alexei Starovoitov wrote:

  "I'm less certain about 'char **'. If we make it scalar too
   it will be harder to make it a pointer to nul terminated
   string later.

   So I would do 'void **' -> scalar for now only."

https://lore.kernel.org/bpf/CAADnVQ+xwC+J1hZcHPEUjBoKcUKmnucG4AFQ-kkDmqx+C-GcoA@mail.gmail.com/

The comment says "of any type" and is_multilevel_ptr() matches all
multi-level pointers (int**, struct foo**, char***), which is broader
than the requested scope. Was the decision to treat all multi-level
pointer types as scalar discussed with Alexei after the v2 feedback?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22298698870

AI-authorship-score: low
AI-authorship-explanation: Code exhibits human-authored characteristics including idiomatic kernel C patterns, iterative revision based on reviewer feedback across three versions, and deep domain knowledge of BPF verifier internals.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Unaddressed maintainer feedback about limiting scope to void** pointers only; the broader approach is functionally safe but contradicts the requested design direction.

--===============2711244271401940436==--

