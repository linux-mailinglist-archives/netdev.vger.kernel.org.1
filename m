Return-Path: <netdev+bounces-257013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HN5EM1IhGk/2QMAu9opvQ
	(envelope-from <netdev+bounces-257013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:37:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D92CEEF795
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D94473006104
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CBE35BDAC;
	Thu,  5 Feb 2026 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvN14OBs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34032D3A7B;
	Thu,  5 Feb 2026 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277066; cv=none; b=ueS7DRW1kZfIAuxW7XG2Te2M9ty7asJmbNotnTlyjt8dFshfNX98eeyA/3Lr4kSyo7orTtyEHyR0MKw+TstkSb2MYCUfp3hfVFNLaqj6GsXLIYqaLZxMBqi5ICdfP5vvyW66iA5AjggLRAbnuhKY4E3O00hdjClJ0RQcxX3ylJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277066; c=relaxed/simple;
	bh=5UjMjLqFV48WjeXWfsLf7rKP+ZFnPy8CXOLRnmY9+D8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HxD63TJ4AVgIE3XS8mXzHuQKT7LleJrdLCo/EcBvTrwvK5EjQImloha/Il6ExdT8iS+gTb1Zo9lF6n2VipHJrqGtGF2SD4WX+ljJH7v6WxSaaTeDcPj0YgGFlIW8hKzndtuXLvHO2mQYxfA2/s0cUYrZOjfPcvqiN1HyhQen/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvN14OBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A95CC4CEF7;
	Thu,  5 Feb 2026 07:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770277065;
	bh=5UjMjLqFV48WjeXWfsLf7rKP+ZFnPy8CXOLRnmY9+D8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mvN14OBsrFCkiazvM8aaRZw7ImwmE2Qcqh4EBlbE8jJaYKqXEZ14dfkGh0E7F7v+a
	 rOKTI5ptOEVcbVsDEihPBInLtgSKQeCN/y/lJL0A0q4bS/2btcCQ8NuX5YHtn4/LAD
	 cD5cJ4+GXwaQ9cvw17rgCSQ70gxS1XjDL4rLe4BdndJICT3bc19QxDneb5vaJR7kia
	 MhoTi2b1M1UQHHRj6KjbGd6mIuHFdnlqpLTQ5I06qBPC/Zd4YbkBjS7jdVQXlYDOWt
	 Ylsq5f+31Ltb2K+mV5JjbhaGJWKtV2UzN1vJHY7hLL3w/Tjpf2ySiXbm9ubFg3We72
	 DhphbPz7AfYpg==
Content-Type: multipart/mixed; boundary="===============8749420910679437655=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <47c4a239503f811cce651c4ff0c57bd0e088befaa30adad912240804eaed2fe0@mail.kernel.org>
In-Reply-To: <20260205070208.186382-14-ameryhung@gmail.com>
References: <20260205070208.186382-14-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v6 13/17] selftests/bpf: Update task_local_storage/recursion test
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  5 Feb 2026 07:37:45 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-257013-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D92CEEF795
X-Rspamd-Action: no action

--===============8749420910679437655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> index 42e822ea3..7bee33797 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> @@ -112,24 +112,24 @@ static void test_recursion(void)
>  	task_ls_recursion__detach(skel);
>
>  	/* Refer to the comment in BPF_PROG(on_update) for
> -	 * the explanation on the value 201 and 100.
> +	 * the explanation on the value 200 and 1.
>  	 */

This comment directs readers to the BPF_PROG(on_update) comments in
progs/task_ls_recursion.c for an explanation of the expected values.

However, the comments in task_ls_recursion.c were not updated and still
describe the old behavior. The second comment in BPF_PROG(on_update) says:

    /* This will still fail because map_b is empty and
     * this BPF_PROG(on_update) has failed to acquire
     * the percpu busy lock => meaning potential
     * deadlock is detected and it will fail to create
     * new storage.
     */

The "percpu busy lock" mentioned here no longer exists after commit
de64e0109 removed the percpu counter. With the new behavior, map_b
creation now succeeds because bpf_trampoline catches the recursion
instead.

Should the comments in task_ls_recursion.c be updated to match the new
behavior, or should this test file comment be changed to reference the
commit message instead?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21702523104

AI-authorship-score: low
AI-authorship-explanation: The commit shows characteristics of human-written kernel code including a hand-crafted ASCII diagram, concise technical language, and minor inconsistencies in capitalization typical of manual editing.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Documentation inconsistency where test file references BPF program comments that were not updated to reflect the new behavior after percpu counter removal.

--===============8749420910679437655==--

