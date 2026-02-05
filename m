Return-Path: <netdev+bounces-257015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEG4H9ZIhGk/2QMAu9opvQ
	(envelope-from <netdev+bounces-257015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:37:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D291EF7AD
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE0AE301BEEB
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B99F35CB68;
	Thu,  5 Feb 2026 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpeQX7wD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694272D3A7B;
	Thu,  5 Feb 2026 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277069; cv=none; b=dtd9LKXKXQ6AcX9l0Q8IHRjeMuGbl94iTGiNElWwMxVjtQc5fEFeHJIAiPrcV2SnlH290cdK+L/imRFmXgDwxl8cm5Kv9lSfpIrSk4xS7oLfmSvpS/n+mCS2dzgDTTGk2Dx7dm813wvM++vicoAVBIkOq5mzs9/hPXJ5eN68YVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277069; c=relaxed/simple;
	bh=xV7ysuJfaIQreXbtOV5LppnFTHwOvf69KdG4BRKbLqU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=APanMJe2DXyzErnvKC9SMd1QKes1fiUEGPAfaRTNgmxirHe3EufJLNvZG3BfMrvC4r7QBtGbSDJZr4BFc1h9ndoxmBR7fNGM4jWH8I3LMrvDBz7pYpcRwRSwGdMYhFh8t+8Ur8B/Buie3+NYUci5KVxmMqzZpfvjNBaDXXQoe0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpeQX7wD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD03FC4CEF7;
	Thu,  5 Feb 2026 07:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770277069;
	bh=xV7ysuJfaIQreXbtOV5LppnFTHwOvf69KdG4BRKbLqU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=RpeQX7wDGva991q4f6GqgPL6pd65ZzsKV6Lu/WgXV9vbyb39P0McEW0B8vJixbwD3
	 nZbNrRHCPokCZead27XK0+LTGNzh0QmMANMyPvBLHtdTEPQjLcdsiL+azRVQNNIUyL
	 X/9v76pgc1oEs27c78f63CgHBSOb9KlMwC+DiqKtN36VWtrS2PY48HqYBOdWFyxhoY
	 P1+zwr9EFMVobfqMEGXCP7XA7F/2KZ/eJ09MyrXRwd4kuwX0OUOMGO3W3L5hx4SO+X
	 xmnSG5DGrA01tZwEC2Y3pRPv1Mipu8VADCE7LNzXv1Z0fWvjKiHJgfMKrviICfkArM
	 gTPM3JHwggHeg==
Content-Type: multipart/mixed; boundary="===============0664483294996957525=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fafea50899e36d26ea6900b7187bf994795f96db8b6de497c8bb12bdcca71521@mail.kernel.org>
In-Reply-To: <20260205070208.186382-6-ameryhung@gmail.com>
References: <20260205070208.186382-6-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v6 05/17] bpf: Change local_storage->lock and b->lock to rqspinlock
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  5 Feb 2026 07:37:48 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257015-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D291EF7AD
X-Rspamd-Action: no action

--===============0664483294996957525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 5dcdf8e52..b33ef5fb5 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c

[ ... ]

> @@ -700,7 +724,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
>  	 * when unlinking elem from the local_storage->list and
>  	 * the map's bucket->list.
>  	 */
> -	raw_spin_lock_irqsave(&local_storage->lock, flags);
> +	raw_res_spin_lock_irqsave(&local_storage->lock, flags);

The commit message says the return value is ignored here "for now", with a
later patch allowing unlinking even when failing to acquire locks.

However, if raw_res_spin_lock_irqsave() fails (returning -EDEADLK or
-ETIMEDOUT), the code continues and then calls
raw_res_spin_unlock_irqrestore() at the end of the function:

> @@ -715,7 +739,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
>  		free_storage = bpf_selem_unlink_storage_nolock(
>  			local_storage, selem, &free_selem_list);
>  	}
> -	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> +	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);

When raw_res_spin_lock_irqsave() fails, it decrements the per-CPU
rqspinlock_held_locks.cnt in release_held_lock_entry(). Later,
raw_res_spin_unlock_irqrestore() calls res_spin_unlock() which:

1. Writes 0 to lock->locked via smp_store_release(), potentially corrupting
   a lock held by another CPU
2. Decrements rqspinlock_held_locks.cnt again, causing an underflow
3. Calls preempt_enable() without a matching preempt_disable()

This is fixed by commit 6327eea8e ("bpf: Switch to bpf_selem_unlink_nofail
in bpf_local_storage_{map_free, destroy}") which rewrites this function to
use bpf_selem_unlink_nofail() that properly handles lock failures.

Should the unlock be made conditional on successful lock acquisition in
this patch, or is the brief window of potential corruption considered
acceptable given the fix follows shortly in the series?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21702523104

AI-authorship-score: low
AI-authorship-explanation: The commit follows standard kernel conventions with appropriate technical detail and no signs of AI-generated content; the changes are mechanical type conversions consistent with human-authored kernel patches.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Lock imbalance in bpf_local_storage_destroy() can cause per-CPU counter underflow and lock corruption if rqspinlock acquisition fails, though the issue is fixed in a later commit in the same series.

--===============0664483294996957525==--

