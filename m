Return-Path: <netdev+bounces-292954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHnzFtf/GGpApggAu9opvQ
	(envelope-from <netdev+bounces-292954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:54:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB35FC887
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 263B8302E0C4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA3A369D4C;
	Fri, 29 May 2026 02:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fECajmFV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35E369992;
	Fri, 29 May 2026 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780023252; cv=none; b=cIo2sVsQqO3+CUAxJ4Lmyf6b3G3OZpkw92XbHsAeJJaYGqqwfuE6WZ6ePXyt0LymJJm/9YQYcVgSmomSw09u4eKb2ZAZNlJUJqtXVVAME86uYhJvfS9LkkolyiOZ4OACuEuptzdHekaT5pGE7LjXILNE/mnGCcFUfBYGYyNO63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780023252; c=relaxed/simple;
	bh=DeOayvENaGrZlpQp8+AzlAVpvswt44mcc9ie9Yegn6I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=b0wLjzoVtebRPUxB1Y7fMIu1cG38tVsTYt6f3WJpymb9PohV3wRVHAR2tJqRuqxLtgEbP5cL/ku2lh2zOTKSNFs3a4Xs1kGWQL7xxGcLqqupzQaIfcWlPCYQ5DdefWhqIR717ApBxatuQL+mtYsLmZPWpoXvs0puwAMgW0klt7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fECajmFV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7581F000E9;
	Fri, 29 May 2026 02:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780023251;
	bh=+G/ejdU0UmBeIP2M+V+mZ4oV1UILZmdBxeVb98LEE5w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fECajmFV22ElVtFNMpfb3OihvaNXb8wKb8Wj98fkfwzPVcYLZLB1CUmB2cRUnJf9E
	 AkMfCvoucx66/UMue518PfleBPdTW8pl5xsDbpzN0XgtFpap+cqSBgW+mlPDrJWcO9
	 VUE/pmi4UBbBc5PLLZrPylKFCgx6tNwegTx8+mqtK4QoPnrsS+OqGmb0ByNIMN9s0o
	 3TnkJ73QgdI6EU0wSxOPc6cTObr0VcBTFMdLL1eDb039PCNVWmuGorHDAovJZ4If+Q
	 1EZESSS03urWTY1fs17ZkPhk6ND1QrwT9RwBn+WIyzoMsCKpaqXpA70P34EDFA0vQR
	 fwWLzE5+JBITw==
Content-Type: multipart/mixed; boundary="===============0959023594176265244=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d9a11e226fc44fc78ecd22d856c392a58cac1c53ce994b48d24610834070dbf5@mail.kernel.org>
In-Reply-To: <20260529014936.2811085-6-ameryhung@gmail.com>
References: <20260529014936.2811085-6-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v6 05/13] bpf: Refactor object relationship tracking and fix dynptr UAF bug
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 29 May 2026 02:54:10 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292954-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: C5BB35FC887
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============0959023594176265244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -8907,26 +8878,83 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int ref_ob

[ ... ]

> +/* Release id and objects derived from it iteratively in a DFS manner */
> +static int release_reference(struct bpf_verifier_env *env, int id)
> +{

[ ... ]

> +	while ((id = idstack_pop(idstack))) {
> +		/*
> +		 * Child references are inaccessible after parent is released,
> +		 * any child references that exist at this point are a leak.
> +		 */
> +		for (i = 0; i < vstate->acquired_refs; i++) {
> +			if (vstate->refs[i].type != REF_TYPE_PTR)
> +				continue;
> +			if (vstate->refs[i].parent_id != id)
> +				continue;
> +			verbose(env, "Leaking reference id=%d alloc_insn=%d. Release it first.\n",
> +				vstate->refs[i].id, vstate->refs[i].insn_idx);
> +			return -EINVAL;
> +		}

Should this path invalidate the dangling child references and continue
rather than returning -EINVAL immediately?

Eduard Zingerman raised this in the v5 discussion:

  Thinking some more about it, the mere presence of dangling objects
  with the same lifetime is not an error.  The error would happen if
  such objects are accessed.  Should the verifier invalidate such
  dangling objects instead of signaling an error immediately?

The current code returns -EINVAL as soon as it finds a child reference whose
parent_id still points at the released parent.  Would invalidating those
child references instead of rejecting allow programs that never access the
dangling objects to verify?

Reference: https://lore.kernel.org/bpf/02e6bb8e8b5e9e21e5b5f81adb9f440d556c83ed.camel@gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26613892466
--===============0959023594176265244==--

