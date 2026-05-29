Return-Path: <netdev+bounces-292952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJO9II38GGoEpggAu9opvQ
	(envelope-from <netdev+bounces-292952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:40:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B6F5FC708
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCFBB300621C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F400367B7B;
	Fri, 29 May 2026 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx/sfiyy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE68367B75;
	Fri, 29 May 2026 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022402; cv=none; b=Xj20bICcYte4983N2zvw04N0CAQzbhPFMb51Cs/WvJ8NMfswD0APFcyCVYuttAm98wL7zb5QncqSSSCBtLhkEONTURnhhuemOizOcDiZGwnTUYb1sqkfi8el2h89Aqpvb43oWXKVwgrkQQ3zb0uB3exz0fVmytC9VRjpzf8szvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022402; c=relaxed/simple;
	bh=8LEk0v0HACXEhU3MY4KL/dva2clfr6Fj3/JhAJyuFfk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HN8zN5KQfbtHM9GbmaS+Ay6J5UF2L+872jgQAyOEuQABEjuOmH5zkdke9hPLq1VHHJ4KBfHm6cEnNgKrj3gObJjF5mACC1tHItAL5g5706tE8JUZVMPaPM+nQ3CfXPhl4emNUuN3IAyCwFRq8cE1pxGx7uyicO6izFbdS2BjxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx/sfiyy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C411F000E9;
	Fri, 29 May 2026 02:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780022400;
	bh=0ofPRN5jaHlvKYILC10N9ihpmmHQmWpmY4u24WxAcNE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mx/sfiyyeSARZceYqTUWalvsvZ39CauxtklBBytY6kZ4GmdXjdFBkkiPT3/9FfY25
	 PAjo0QO9m5/GJF5CoS4BYF+38hJIKaY4j+RG4JhGiqcjNYzVfSlOu3AKZJtA+LyBOC
	 ULztXF5hgBFQmCRRTYLPWx7b0svxFwEor2eUrjo5lGPtJDRqnUUvBxfYtkFejhSdF0
	 YRE4epzcDjN34rg45r1/MEP2XEr7/lzjd4SMv8SepaNoectQxGRsFuWOD80s3xzb2K
	 9CQHxM8NnVsLiJT72ubYNLdq6krFhzCIgdzzybeL5g2VFIkPK5HoTTFAFQLG7gmC7Y
	 B2/3hjPAFXleg==
Content-Type: multipart/mixed; boundary="===============0439834184810809479=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1b51b4c0718274dd2bb2df706459fc1581e6f99d6fe59db6a87b13bf7c805844@mail.kernel.org>
In-Reply-To: <20260529014936.2811085-8-ameryhung@gmail.com>
References: <20260529014936.2811085-8-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v6 07/13] bpf: Unify referenced object tracking in verifier
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 29 May 2026 02:40:00 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-292952-lists,netdev=lfdr.de,bpf-ci];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20]
X-Rspamd-Queue-Id: 87B6F5FC708
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============0439834184810809479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 75b287d8d92f..b0521ba7787a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1424,6 +1424,18 @@ struct bpf_dynptr_desc {
>  	u32 parent_id;
>  };
>
> +/*
> + * The last seen rereferenced object; Updated by update_ref_obj() when a register refers to a
> + * referenced object. Used when the helper or kfunc is releasing a referenced object, casting
> + * a referenced object, returning allocated memory derived from referenced object or creating
> + * a dynptr with a referenced object as parent.
> + */

This isn't a bug, but there's a typo in the comment: 'rereferenced'
should read 'referenced'.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3db0f1db475a..1a49e5194bb4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -231,9 +231,28 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
>  			     (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
>  }
>
> +static void update_ref_obj(struct ref_obj_desc *ref_obj, struct bpf_reg_state *reg)
> +{
> +	ref_obj->id = reg->id;
> +	ref_obj->parent_id = reg->parent_id;
> +	ref_obj->cnt++;
> +}
> +
> +static int validate_ref_obj(struct bpf_verifier_env *env, struct ref_obj_desc *ref_obj)
> +{
> +	if (ref_obj->cnt > 1) {
> +		verifier_bug(env, "function expects only one referenced object but got %d\n",
> +			     ref_obj->cnt);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}

A review comment in lore raised a concern that verifier_bug() should
not be used for user-triggered errors. Since ref_obj->cnt is determined
by the number of referenced arguments provided by the BPF program, a
user could intentionally trigger this warning by passing multiple
referenced objects.

Since verifier_bug() expands to BPF_WARN_ONCE(), triggering a warning
via user-controlled input could be problematic if panic_on_warn is
enabled.

Would it be safer to gracefully reject the program using verbose() and
returning -EINVAL, similar to how it is handled for release kfuncs
earlier in this patch?

Link: https://lore.kernel.org/bpf/20260506224833.71FC4C2BCB0@smtp.kernel.org/

[ ... ]

> @@ -8226,15 +8232,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  		meta->release_regno = regno;
>  	}
>
> -	if (reg_is_referenced(env, reg) && base_type(arg_type) != ARG_KPTR_XCHG_DEST) {
> -		if (meta->id) {
> -			verbose(env, "more than one arg with referenced id R%d %u %u",
> -				regno, reg->id,
> -				meta->id);
> -			return -EACCES;
> -		}
> -		meta->id = reg->id;
> -	}
> +	if (reg_is_referenced(env, reg))
> +		update_ref_obj(&meta->ref_obj, reg);

Does removing the ARG_KPTR_XCHG_DEST guard introduce a regression for
bpf_kptr_xchg?

Looking at bpf_kptr_xchg's signature:

void *bpf_kptr_xchg(void *dst, void *ptr__in_or_null)

The dst argument (ARG_KPTR_XCHG_DEST) can be a field of a referenced
allocated object. For example, consider bpf_kptr_xchg(&obj->kptr_field,
NULL) where obj is a referenced object (id=X from bpf_obj_new).

Argument processing order in check_helper_call is arg0 (dst, R1) then
arg1 (ptr, R2):
 - dst (R1): reg_is_referenced true (id=X) -> update_ref_obj sets
   meta.ref_obj.id = X
 - ptr (R2): NULL -> reg_is_referenced false -> no update;
   arg_type_is_release sets release_regno = R2

Final meta.ref_obj.id = X.

In check_helper_call's release block, the code then executes:

} else if (func_id == BPF_FUNC_kptr_xchg && meta.ref_obj.id) {
	u32 id = meta.ref_obj.id;
	...
	err = release_reference_nomark(env->cur_state, id);
	...
	bpf_for_each_reg_in_vstate(...) {
		if (reg->id == id)
			mark_reg_invalid(env, reg);
	}
}

This releases obj's reference (id X) and invalidates all registers
holding obj, even though obj is still live and was never meant to be
released.

Under the old code, the ARG_KPTR_XCHG_DEST exclusion prevented this, so
meta.id stayed 0. The release path then fell through to the
bpf_register_is_null(&regs[meta.release_regno]) check (R2 is NULL) and
returned 0 - the correct behavior.

The retained comment on the kptr_xchg release path is now incorrect:

> @@ -10407,17 +10407,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> -		} else if (meta.id) {
> -			err = release_reference(env, meta.id);
> +		} else if (meta.ref_obj.id) {
> +			err = release_reference(env, meta.ref_obj.id);
>  		} else if (bpf_register_is_null(&regs[meta.release_regno])) {
> -			/* meta.id can only be 0 if register that is meant to be
> +			/* meta.ref_obj.id can only be 0 if register that is meant to be
>  			 * released is NULL, which must be > R0.
>  			 */

The comment states meta.ref_obj.id can only be 0 if the release
register is NULL, but with the ARG_KPTR_XCHG_DEST guard removed,
ref_obj.id can be taken from the dst argument (R1) which is a different
register than the release register (R2). So ref_obj.id can be non-zero
while the release register (R2) is NULL.

This appears to corrupt reference-tracking state for valid BPF programs
that clear a kptr field on a still-held allocated object. A later
bpf_obj_drop(obj) would be incorrectly rejected since the reference was
already consumed.

This is corrected by commit 99727f36d6be ("bpf: Unify release handling
for helpers and kfuncs") later in this series, which rewrites the
release path to operate on the actual release register and
short-circuits if that register is NULL.

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26613892466
--===============0439834184810809479==--

