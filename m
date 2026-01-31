Return-Path: <netdev+bounces-255364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKjeJW+UfWnQSgIAu9opvQ
	(envelope-from <netdev+bounces-255364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:34:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C6EC0C2F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 269763029E68
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A130D338925;
	Sat, 31 Jan 2026 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUqYTuOP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E723328603;
	Sat, 31 Jan 2026 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769837610; cv=none; b=pKa6EX/VlLi8SiULNm4aZWVKsfFQnByT24ybx8ujkNr9visiv5Dxsl17V/6CyxzBC/kPP1PzmMXphVihWBHOm2doWg0FdW3T8Hi/qnQbfWWb0PaUsNZtGRbwYi/Z3MGlc4OTVOK/lw1SAp0MwLCvvsmyCmI7edUbTO5iMElgRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769837610; c=relaxed/simple;
	bh=PFU930UIFcXyOWAgF4B3Hvdmh0Cy8r7znVOSBdS6k2U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JoUnwC6cVd0k+KsHCpeBi1R90Fp/wMJF+ioucSomSLo+UxusZFimD/dgTgtd5srI1phLTzhjRaKgA+vtAfs6AB/C/HjW3TXuU3t9/WSbbZlCuKTaOZcV6VzPROY/RRxoDxw2S8mfQfU0IkuQXl+LOkkmR37Z3cSfd00sZvjzE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUqYTuOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E174CC4CEF1;
	Sat, 31 Jan 2026 05:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769837610;
	bh=PFU930UIFcXyOWAgF4B3Hvdmh0Cy8r7znVOSBdS6k2U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FUqYTuOPsp5+dxQJQuNPb0wA44VPYQiUIiWoaYkAOGTy0NzxPUngawWsD7Gl6+zjx
	 beExI9OOmBZSBvDhyzJ3xtbQ9atz6cWUD5SXdsi+BNBKdukUIvFahi+gcmoRplh72F
	 F1Ydsxy9JRiSbt1ywaN84sai4L1oWZMXdUwPQsiHzDzhw6nj4ojHk2qO8jPryrfei2
	 tUKg3a24064Bp59b0JQfdyAUBc10CIKeEGHyiaTcoiJ050qEzdUinKVgLTc2v7d6kT
	 fplY9cgizu6L0QjmcQ5TuRSMUcsKWBEpVG91bgIbg4MdGASShn2oRBKqMnyvWAlRD+
	 UYhIZhxs9qLKQ==
Content-Type: multipart/mixed; boundary="===============6390409994789094024=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6497e7de7911a13edaf39f91f47719c418c67ea8918f589b7d08737790181e0b@mail.kernel.org>
In-Reply-To: <20260131050920.2574084-4-ameryhung@gmail.com>
References: <20260131050920.2574084-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 03/16] bpf: Convert bpf_selem_link_map to failable
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 31 Jan 2026 05:33:29 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-255364-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: F1C6EC0C2F
X-Rspamd-Action: no action

--===============6390409994789094024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index de111818f..9da11a531 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -191,7 +191,9 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>  		}
>
>  		if (new_sk_storage) {
> -			bpf_selem_link_map(smap, copy_selem);
> +			ret = bpf_selem_link_map(smap, copy_selem);
> +			if (ret)
> +				goto out;
>  			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
>  		} else {
>  			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);

When bpf_selem_link_map() fails, should there be cleanup similar to the
else branch? At this point copy_selem has been allocated via
bpf_sk_storage_clone_elem() and the map refcount was incremented via
bpf_map_inc_not_zero().

The existing else branch on bpf_local_storage_alloc() failure does:

    bpf_selem_free(copy_selem, true);
    atomic_sub(smap->elem_size, &newsk->sk_omem_alloc);
    bpf_map_put(map);

But the new if branch just does goto out, which only calls
rcu_read_unlock_migrate() before returning.

The comment at out: says "the caller is responsible to call
bpf_sk_storage_free" but copy_selem was never linked to new_sk_storage
(bpf_selem_link_storage_nolock() never ran), so bpf_sk_storage_free()
iterating local_storage->list would not find it.

This would leak copy_selem, the memory accounting, and a map reference
once bpf_selem_link_map() can actually fail (after commit 3636ab200
changes to rqspinlock in this series).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21539340647

AI-authorship-score: low
AI-authorship-explanation: The code follows standard kernel development patterns and the commit message has technical specificity typical of experienced kernel developers.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Memory leak, memory accounting leak, and map reference leak in socket cloning error path when bpf_selem_link_map fails after rqspinlock change.

--===============6390409994789094024==--

