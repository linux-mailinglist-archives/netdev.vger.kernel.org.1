Return-Path: <netdev+bounces-260589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNqnGjnUnWk0SQQAu9opvQ
	(envelope-from <netdev+bounces-260589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:39:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E431B189E29
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4913931B5916
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6F93A8FEE;
	Tue, 24 Feb 2026 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4rLs0cs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93793A8FE1;
	Tue, 24 Feb 2026 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950957; cv=none; b=P5ZKS4yqzf6jUYSM6IuGZZr5YmJHEJVvGIuobE1A4ojTld6l8D8Ljx73niyqx9e/4AmCJ0XmglXf8dh5V5QkPBr9wm809PKsZnYHPH07GlyfjZM5ALZBQpKvkaAlMBZGwDHfc+QpsbtwDu102VIn4CM9u6mWUM6wZZldrZZGdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950957; c=relaxed/simple;
	bh=kSBTLlMV6zLNU1mablt3JM4TXckztaxwmFihI53ir5c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LqIMNtMryN+6Z65gMIWhBI7O6ZQEhMyC+iqxLewJ9+tXAdaXZIOyuYvCFl+NizJR5i8UYfROC8FaRiVsNZ3m1r6Ldt2I6gBWqsOQhnQUNAoesgPzxDMLhivfC+Tmt4vBP3AZLPNbW9TYCpX9alIY+LLylnKwJdHmQ/ZsZwSJCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4rLs0cs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78998C116D0;
	Tue, 24 Feb 2026 16:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771950957;
	bh=kSBTLlMV6zLNU1mablt3JM4TXckztaxwmFihI53ir5c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=i4rLs0csiXnuR3pQFC5fXouZ1CReKzLw6IUjP808CNpyIwZrwZXI5OqP88MimOpEd
	 Q9a2zmzCsapZ81C9RdbcHl7iyDs+brduReKHn8O66+VoRTH124+ssuxz9x2bKFPHjg
	 c+HcMbS9wnRS3FvW0QdPCwi6M7vXJw9BPjDc25RukpZmZZdBsdON2JeEP8IcGmSBl0
	 MKyYGoP3m+EdHpEppMi8aB/3aWdhZnahQjYGTOjkRvyGnE62HpjZEg39QijS3K/Jm+
	 V0sSHKSeCt9z+ovrJaB7MibHy0CIHOrAOeKmaS0Wq3K45QtHkFTr12tlQ+jmYMXj0f
	 aqDeNjEVH7ZsQ==
Content-Type: multipart/mixed; boundary="===============1231585818442456678=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eee0df40aa8e7d4bba027682244ea59e86105b677510525f2ddd8b87b88f194e@mail.kernel.org>
In-Reply-To: <20260224154024.12504-4-leon.hwang@linux.dev>
References: <20260224154024.12504-4-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 3/8] bpf: Disallow !call_get_func_ip progs tail-calling call_get_func_ip progs
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,yangfeng@kylinos.cn,leon.hwang@linux.dev,menglong8.dong@gmail.com,puranjay@kernel.org,bjorn@kernel.org,pulehui@huawei.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Feb 2026 16:35:55 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260589-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,vger.kernel.org,fb.com,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E431B189E29
X-Rspamd-Action: no action

--===============1231585818442456678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -2418,6 +2419,9 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>  		      map->owner->sleepable == fp->sleepable;
>  		if (ret && (!map->owner->kprobe_write_ctx && aux->kprobe_write_ctx))
>  			ret = false;
> +		if (ret && (!map->owner->call_get_func_ip && fp->call_get_func_ip &&
> +			    prog_type == BPF_PROG_TYPE_TRACING))
> +			ret = false;

This check catches the case where owner->call_get_func_ip is 0 and
the new program has call_get_func_ip set. However, does the reverse
ordering also need to be handled?

Consider:

  1. Program H (call_get_func_ip=1) is added to the prog_array first
     and becomes the owner with owner->call_get_func_ip=1.

  2. Program M (call_get_func_ip=0) is loaded and references this
     prog_array for tail calls. bpf_check_tail_call() calls
     __bpf_prog_map_compatible(PA, M), and the check evaluates:

       (!owner->call_get_func_ip && fp->call_get_func_ip)
       (!1 && 0) = false

     so M passes the compatibility check.

  3. M is attached to a trampoline where no program needs func_ip,
     so ip_arg is false and func_ip is not pushed on the stack.

  4. M tail-calls H. H calls bpf_get_func_ip(), which reads from
     the expected stack offset, but that slot was never written by
     the trampoline, so it returns stale stack data.

Would it be safer to reject any mismatch on call_get_func_ip for
tracing programs, regardless of which program was added first?
Something like:

  if (ret && (map->owner->call_get_func_ip != fp->call_get_func_ip) &&
      prog_type == BPF_PROG_TYPE_TRACING)
          ret = false;

>  		if (ret &&
>  		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
>  		    map->owner->expected_attach_type != fp->expected_attach_type)
>  			ret = false;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22358832658

AI-authorship-score: medium
AI-authorship-explanation: Selftests in the series carry Assisted-by Codex tags, and the kernel code change is formulaic pattern replication across all commits, consistent with AI-assisted development.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: One-directional compatibility check allows a non-call_get_func_ip tail-caller to bypass the check when the call_get_func_ip program is added to the prog_array first, potentially causing bpf_get_func_ip to return stale stack data.

--===============1231585818442456678==--

