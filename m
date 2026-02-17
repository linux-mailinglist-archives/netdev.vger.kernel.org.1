Return-Path: <netdev+bounces-259170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sISBEirwlGmOJAIAu9opvQ
	(envelope-from <netdev+bounces-259170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:48:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A141519D2
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 958B030125CB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F93528D8D1;
	Tue, 17 Feb 2026 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYh+zUQ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC20260580;
	Tue, 17 Feb 2026 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368481; cv=none; b=ITFCNUEbk5AO11oeQU538RP2qIa6UmhC+Gow6ZYp51Sz7Z4P4ctt0+jxoK0D7x2o8HS+pOZdrzAmPJb1c6Gyd/AeaeA1Ot9QVDjcFCknyZZS2xKRHite6mzT1ghtySzozv/rWvbDx3P6pXajQY832r0xVlzDLLzQNmZR2bm1qeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368481; c=relaxed/simple;
	bh=/TSbYnClUOGqOMdBA09jRDl19YeOcTbGhgJNn2/YoNM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Q/U+Jtv5Gghg8uLB5zvJHLvoC321aHkZDI/8iPZuRFohNGAqeLFmvJQygdBC9/haWrJcWibOCwHvf8kwZ3MIv8j8pxuB+Ww8rjKi8zEzTfEU/BXQjGlKAPCmc7G4drrwfV4UYiunzvbDSuNsDgMVRx7JzgSqwE6RW0k/tNUDLBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYh+zUQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE400C4CEF7;
	Tue, 17 Feb 2026 22:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771368480;
	bh=/TSbYnClUOGqOMdBA09jRDl19YeOcTbGhgJNn2/YoNM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gYh+zUQ8kvdOkk1BIxp/8pKWCkdX754d7//jzfPyWIvVBpXNMknJ9GfEJw48Te8d2
	 e1QmAzpZchsQ4+Mer+SbFq2tp/su7+A9s9T0qs7vor8bc1rMhmBCNOyesNzvhWSxac
	 9e/9AQ2Ic0Ofngz/UDrQjWwXc7FjIXJAyWxQyCPYXrXFzrM5EoKL6e78e08NMRGaqg
	 KVd79OXeE0FLrzvcKwIKG+NC8mfNZafjGASIoWbcdaRqmhh9sNuKU6c6cLx9tSKMsx
	 Ms1MUuepWjuVjPzwbr9w+qozkKd2Rx0TGW28BbNCclG72T2RsvhzCYUCA9HOP2B79K
	 pe4tQuTYdT/Lw==
Content-Type: multipart/mixed; boundary="===============8598547615559900769=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c0aa6a42eb9fa557fc375b858d91dbadd74bbd6534be1b32fc9e0d05e540ee63@mail.kernel.org>
In-Reply-To: <20260217221357.18215-3-slava.imameev@crowdstrike.com>
References: <20260217221357.18215-3-slava.imameev@crowdstrike.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add trampolines multi-level pointer params test coverage
From: bot+bpf-ci@kernel.org
To: slava.imameev@crowdstrike.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-open-source@crowdstrike.com,slava.imameev@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 17 Feb 2026 22:47:59 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259170-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com,iogearbox.net,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9A141519D2
X-Rspamd-Action: no action

--===============8598547615559900769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 178c4738e63b..19c82ae9bfe6 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c

[ ... ]

> +static void *create_bad_kaddr(void)
> +{
> +	/*
> +	 * Try to get an address that passes kernel range checks but causes
> +	 * a page fault handler invocation if accessed from a BPF program.
> +	 */
> +#if defined(CONFIG_ARCH_HAS_SET_MEMORY) && defined(CONFIG_X86)

The first branch requires both CONFIG_ARCH_HAS_SET_MEMORY and
CONFIG_X86.  The second branch requires CONFIG_ARCH_HAS_SET_DIRECT_MAP.

PowerPC selects ARCH_HAS_SET_MEMORY (arch/powerpc/Kconfig) but not
ARCH_HAS_SET_DIRECT_MAP, so neither branch compiles in and the function
always returns NULL on that architecture.

> +	void *addr = vmalloc(PAGE_SIZE);
> +
> +	if (!addr)
> +		return NULL;
> +	/* Make it non-present - any access will fault */
> +	if (set_memory_np((unsigned long)addr, 1)) {
> +		vfree(addr);
> +		return NULL;
> +	}
> +	return addr;
> +#elif defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)

[ ... ]

> +#endif
> +	return NULL;
> +}

[ ... ]

> +static void free_bad_kaddr(void *addr)
> +{
> +	if (!addr)
> +		return;
> +
> +	/*
> +	 * Free an invalid test address created by get_invalid_address().
> +	 * Restores the page to present state before freeing.
> +	 */

The comment references get_invalid_address() but the function that
creates the address is create_bad_kaddr().

> +#if defined(CONFIG_ARCH_HAS_SET_MEMORY) && defined(CONFIG_X86)

[ ... ]

> +#endif
> +}

[ ... ]

> +		} else if (!strcmp(attach_name, "bpf_fentry_test13_pptr")) {
> +			kaddr = create_bad_kaddr();
> +			WARN_ON(!kaddr);

Since create_bad_kaddr() returns NULL on PowerPC (which supports BPF
trampolines via HAVE_DYNAMIC_FTRACE_WITH_ARGS), would this WARN_ON fire
every time the bpf_fentry_test13_pptr test runs on that architecture?

> +			CONSUME(bpf_fentry_test13_pptr(kaddr));
> +			CONSUME(bpf_fentry_test13_pptr((void **)19));
> +			CONSUME(bpf_fentry_test13_pptr(ERR_PTR(-ENOMEM)));
> +			break;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22118172993

AI-authorship-score: low
AI-authorship-explanation: Stale comment referencing a renamed function and an architecture coverage gap with WARN_ON are characteristic of human-authored code that underwent refactoring.
issues-found: 2
issue-severity-score: medium
issue-severity-explanation: WARN_ON(!kaddr) fires unconditionally on PowerPC where create_bad_kaddr() always returns NULL, producing kernel warnings on every test run and potential panics with panic_on_warn.

--===============8598547615559900769==--

