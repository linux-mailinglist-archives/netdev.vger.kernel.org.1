Return-Path: <netdev+bounces-256023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCOWIygkgWnCEQMAu9opvQ
	(envelope-from <netdev+bounces-256023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 23:24:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E26B9D21F3
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 23:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1962B30488DB
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 22:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49EB34AAF6;
	Mon,  2 Feb 2026 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLSuJgoR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911AB3491F5;
	Mon,  2 Feb 2026 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071004; cv=none; b=SSBw8UJfsF+o6DmRoXsBIQVlAKH7IAtHppGzDTr0a/Z/LB+HYymgsgVijU2uIMjZdNA6b61fiFr3b9NiL79SmYV1gI6L2iTdc+bLzp6SIhNZpbj2AK5u2GQ+8htVvynI3/DMT/XAorT4dlwTPmYdWx3l5O/SFJNDG57tl3+Kv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071004; c=relaxed/simple;
	bh=sVWqdi+yrlNKA+/UuuSXR+8HNQT3jJBVuhRz4e3hmcI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cLh2FIu2WRyWdQwy524STV0xZx4BxFhpdLZcHBIf/JLK/+Y6Chz1weiosYMwcHeuJeMvdvCRj6gF71im1mo9e5Z7+FB7eV30s85q5dpeJTcaMJGqWvX7vR2N2mylaJQ0HFD4omm+froQu+GtLAeQjjX7oeGATUWi/8eARooUrwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLSuJgoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6A5C116C6;
	Mon,  2 Feb 2026 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770071004;
	bh=sVWqdi+yrlNKA+/UuuSXR+8HNQT3jJBVuhRz4e3hmcI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=kLSuJgoR1bj/7JfU31N+6c121tyRPhyJ+TDmXkJ4Vc4fyUw3S7cNytiBZQN/urdYC
	 i5J2dspQRFfP8BrZnYWRiamaWSv8mBFsX2RPuIyWerfsmliqzJk43c8iCrp/RJCe7z
	 s3OtXg6y2vA1XNAh4vAA4fhKl2nZ4znAAzDhIgEn0o3RSCBEmSMOcFWaFF9/305MnG
	 stNijBya+4ynZtfOgqGNEeFHclKreWpsB4OmzFyMDMobxhBLr7LJJqSV1fg5UIx10N
	 tUmLbUsBknZkpFtTMuiWoG1eS665GQ7TZw6q8g99oaMSd0y7GR/bnYgpx9SomSclPZ
	 WQOmfHk3iaZ8g==
Content-Type: multipart/mixed; boundary="===============4839135281015461172=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <77f6c7cf5ed980f733fad13caf87baddedae6c1bbaa8e55db00a81828638dec3@mail.kernel.org>
In-Reply-To: <20260202214817.2853236-1-ameryhung@gmail.com>
References: <20260202214817.2853236-1-ameryhung@gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/4] bpf: Fix and refactor object relationship tracking
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Feb 2026 22:23:23 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256023-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
X-Rspamd-Queue-Id: E26B9D21F3
X-Rspamd-Action: no action

--===============4839135281015461172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6b62b6d571..a357e03051 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10481,22 +10464,43 @@ static int release_reference_nomark(...)
>  *
>  * This is the release function corresponding to acquire_reference(). Idempotent.
>  */
> -static int release_reference(struct bpf_verifier_env *env, int ref_obj_id)
> +static int release_reference(struct bpf_verifier_env *env, int ref_obj_id, bool acquired_ref)
>  {
>  	struct bpf_verifier_state *vstate = env->cur_state;
>  	struct bpf_func_state *state;
>  	struct bpf_reg_state *reg;
> -	int err;
> +	int err, spi;
>
> -	err = release_reference_nomark(vstate, ref_obj_id);
> -	if (err)
> -		return err;
> +	if (acquired_ref) {
> +		err = release_reference_nomark(vstate, ref_obj_id);
> +		if (err)
> +			return err;
> +	}
>
>  	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -		if (reg->ref_obj_id == ref_obj_id)
> +		if (reg->ref_obj_id == ref_obj_id) {
>  			mark_reg_invalid(env, reg);
> +			if (reg->id && reg->id != ref_obj_id) {
> +				err = release_reference(env, reg->id, false);
> +				if (err)
> +					return err;
> +			}
> +		}
>  	}));
>
> +	bpf_for_each_spilled_reg(spi, state, reg, (1 << STACK_DYNPTR)) {
> +		if (!reg || !reg->dynptr.first_slot)
> +			continue;
> +		if (reg->ref_obj_id == ref_obj_id) {
> +			__unmark_stack_slots_dynptr(env, state, spi);
> +			if (reg->id && reg->id != ref_obj_id) {
> +				err = release_reference(env, reg->id, false);
> +				if (err)
> +					return err;
> +			}
> +		}
> +	}

Does this loop only scan dynptrs in the current frame?

The bpf_for_each_reg_in_vstate macro sets 'state' to each frame in sequence:

    for (___i = 0; ___i <= ___vstate->curframe; ___i++) {
        __state = ___vstate->frame[___i];
        ...
    }

After the macro completes, 'state' holds the last assigned value, which is
vstate->frame[vstate->curframe] - only the top frame.

The subsequent bpf_for_each_spilled_reg loop uses this 'state' variable,
so it only scans STACK_DYNPTR slots in the top frame. Dynptrs residing in
caller frames (frames 0 through curframe-1) would not be found.

When a BPF program creates a dynptr in frame 0 and then calls a subprog
(frame 1) that releases the parent object, the dynptr in frame 0 would not
be invalidated. The selftest bpf_qdisc_fail__invalid_dynptr_cross_frame.c
appears to test this exact scenario.

Should the bpf_for_each_spilled_reg loop be wrapped in a loop over all
frames, similar to how bpf_for_each_reg_in_vstate_mask handles it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21608154622

AI-authorship-score: low
AI-authorship-explanation: The commit demonstrates deep domain expertise with detailed ASCII diagrams, uses standard kernel conventions, and the bug is a typical human oversight from misunderstanding macro variable scoping.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: The dynptr invalidation loop only scans the top frame, potentially missing dynptrs in caller frames when parent objects are released, which could lead to use-after-free in the BPF verifier.

--===============4839135281015461172==--

