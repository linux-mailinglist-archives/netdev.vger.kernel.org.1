Return-Path: <netdev+bounces-257014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Bf3Hs5IhGk/2QMAu9opvQ
	(envelope-from <netdev+bounces-257014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:37:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68592EF79C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B72B93006159
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF9735CBA2;
	Thu,  5 Feb 2026 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlJgbUL3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856B2D3A7B;
	Thu,  5 Feb 2026 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277067; cv=none; b=dyGgWbVV6dEoOFuM4Nz6IqtLUwkQhXT8NkiFob3ZSYNh5K2XVraTSgGcNlWJ3l6ydKMWYJXydr55vZ/Fw0al+fz7AVf0yr38C3rf3z5yPb9RvSKUk7ZorW50G8zxBx2obG+SEXDI65fZlU59kIaH79WO/ZwLOBfT8YHm4VKAPSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277067; c=relaxed/simple;
	bh=CE5fzYSVtgDjYwAFiPW2gaGP75Rtf9V/A5Iez3Su084=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=J17N8/S623VslvO9Qkd1Gp6Sj+RogUrIue5ZvI97zIUroIJzZou5r0o9LJS7pOQvgdpZlCqaLEOKcY46DvpVNmL5BxcYg/cc0kmENZrdzwTIoZj0cEtn9U6+BFLjS9rBiYOEcNsMnYxivYM8M4h9xkHgBIbpXmmP9RWAJr+czyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlJgbUL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079E6C4CEF7;
	Thu,  5 Feb 2026 07:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770277067;
	bh=CE5fzYSVtgDjYwAFiPW2gaGP75Rtf9V/A5Iez3Su084=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=WlJgbUL3mJMNIcD9xWJzmCJW0/ayejXl8dbeFmguv9tFkHuLLutaKnrxedDk209cY
	 TF9HEdhN9nviZd0Ntos2Z2jRM4blC+4e1y6/4vXmRhBS1UUgd+SLPWGKntrCIyEwUI
	 OXpqu1yOjOEL27V47o+5LmQlBZihMLs0Vd3Dzc8/ASlwoIQrtAMExcG0ThHRFTNKc/
	 CPaVJQgq/SkhGdN5qJ21ChdxLcBF4E+MOXAo94V8CHS3ZoU64ywzCAlflN5/eKioOu
	 996dOoL5KInEsAim0I4twNLpdHuFwqwsQmZa4CoRyOnHjlkz8B5/Fn3T4I6xZobDuW
	 wrhqs55/8ouAA==
Content-Type: multipart/mixed; boundary="===============7136153090428322020=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10c877995f2396fe97b8dcf36a3f8a196a7367e412e2f7de6bee497f135082ee@mail.kernel.org>
In-Reply-To: <20260205070208.186382-3-ameryhung@gmail.com>
References: <20260205070208.186382-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v6 02/17] bpf: Convert bpf_selem_unlink_map to failable
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  5 Feb 2026 07:37:47 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-257014-lists,netdev=lfdr.de,bpf-ci];
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
X-Rspamd-Queue-Id: 68592EF79C
X-Rspamd-Action: no action

--===============7136153090428322020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 91b28f4e3..5f7869078 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c

[ ... ]

> @@ -347,25 +342,28 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
>  	hlist_add_head_rcu(&selem->snode, &local_storage->list);
>  }
>
> -static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
> +/* Only called in common paths */
> +static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
>  {

The comment says "Only called in common paths", but bpf_selem_unlink_map()
is also called from bpf_local_storage_destroy() which the commit message
explicitly identifies as NOT a common path:

    bpf_local_storage_destroy()
        bpf_selem_unlink_map(selem);   <-- not a "common path"

The commit message states: "Remove the selem_linked_to_map_lockless() check
as an selem in the common paths (not bpf_local_storage_map_free() or
bpf_local_storage_destroy())..."

Should this comment be removed or rephrased? I note that later in the series
(commit 6327eea8e) bpf_local_storage_destroy() is rewritten to no longer call
bpf_selem_unlink_map() directly, making the comment accurate at that point.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21702523104

AI-authorship-score: low
AI-authorship-explanation: The commit demonstrates deep kernel subsystem knowledge, proper coding conventions, and detailed understanding of locking requirements typical of experienced kernel developers.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Minor documentation issue where a comment incorrectly describes the function's callers; the code itself is functionally correct and the comment becomes accurate later in the patch series.

--===============7136153090428322020==--

