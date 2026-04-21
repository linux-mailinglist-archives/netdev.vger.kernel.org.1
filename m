Return-Path: <netdev+bounces-280271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBCXJOD/52lJEAIAu9opvQ
	(envelope-from <netdev+bounces-280271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:53:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 370514404BB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD59B307AB98
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AD63A6F0E;
	Tue, 21 Apr 2026 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUaRoA7n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B019C54E;
	Tue, 21 Apr 2026 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811942; cv=none; b=ZyfzdOj0BYOxITijxBSoa9NqYQYTRANKlh42+yG9QfrrwNxOXri+ILaBex8jnSDjdafepU+WWGEncnXnhiIq88w4cTg69vUkXxHs55YFqCw6k6zFGtlv0N8dyygzBDwfVv5c6WXtxYYU4cxjB4rfCeSwPUppJI5+b197q+bL6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811942; c=relaxed/simple;
	bh=f46TmGYCdgfDXqGRjBtqWGQpq0iU/ba6YvkdM5SdfYU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=clbQPvmgJjVKvnXiFX9oQpjLmL1sWT9NnqXvc0ihrebzLWF5CZXJN5vNBfeweRaWZYLJQMqYfK6HwJde859EhidQD6OJ16lRudYSQOxUR0d36npOMcN5OV1IeLfGp42QYiKk1ZoCeCn2k8LpRoKR9GeHhR5fqoTXTyYRqe5Gots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUaRoA7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA079C2BCC6;
	Tue, 21 Apr 2026 22:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776811942;
	bh=f46TmGYCdgfDXqGRjBtqWGQpq0iU/ba6YvkdM5SdfYU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tUaRoA7nEzWzZYg9DDl/NkbhWINTehmuKN/AUupHo5uuDiADu5ucx2xzLUrYaF8EQ
	 /1hzEtmO4YH6zn0rxeAdEqGkRDJHkYpTwtfTOt6/21Vt3sFaQ+kHh6AXFmc/2mKWZI
	 6tC2T2CTqs+Ldl0dT68kpaCnk2UccbnZAFbDcVlusYpFSjTv4Wy8ixQJavSsWSJ4o9
	 5yfhpE+T6mqDnDyZB99JFAlW5F8XN8T7BGoD5H7wK7fFYH8Ge7kyl6XfwUd/900Q7f
	 eLiqfR+RH5d4m3eQA5tVRREQ9/bg8fmv/4Ke1LQTqrcNG4QEFTeXFKYIjL9kzR5W4I
	 qy9Xm17ZhdQvA==
Content-Type: multipart/mixed; boundary="===============1910070603281241147=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d5679e6f2b458bb8771f83e6985247befd68fbab894a0d2a09797f0ec3a90efe@mail.kernel.org>
In-Reply-To: <20260421221016.2967924-4-ameryhung@gmail.com>
References: <20260421221016.2967924-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] bpf: Preserve reg->id of pointer objects after null-check
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Apr 2026 22:52:21 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-280271-lists,netdev=lfdr.de,bpf-ci];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 370514404BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============1910070603281241147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 93003a2a96b0..0313b7d5f6c9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15886,15 +15886,10 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
>
>  		mark_ptr_not_null_reg(reg);
>
> -		if (!reg_may_point_to_spin_lock(reg)) {
> -			/* For not-NULL ptr, reg->ref_obj_id will be reset
> -			 * in release_reference().
> -			 *
> -			 * reg->id is still used by spin_lock ptr. Other
> -			 * than spin_lock ptr type, reg->id can be reset.
> -			 */
> -			reg->id = 0;
> -		}
> +		/*
> +		 * reg->id is preserved for object relationship tracking
> +		 * and spin_lock lock state tracking
> +		 */

How does preserving reg->id interact with reg_is_init_pkt_pointer()?

In v2 review, Alexei Starovoitov raised this concern: "That pointer has
to have id == 0". Eduard Zingerman responded that dropping the id == 0
check should be fine, but this change was not made in v3.

The function reg_is_init_pkt_pointer() still checks reg->id == 0:

    return reg->type == which &&
           reg->id == 0 &&
           reg->off == 0 &&

With this patch, if a PTR_TO_PACKET register goes through null-checking
in mark_ptr_or_null_reg(), it will now preserve its reg->id instead of
resetting it to 0. Would this cause reg_is_init_pkt_pointer() to
incorrectly return false for init packet pointers?

Reference: https://lore.kernel.org/bpf/CAADnVQLCKi_QL1FeybW+6MH6FAOAoRJyW06UvtX3my3yNSH5eQ@mail.gmail.com/

>  	}
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24749741787
--===============1910070603281241147==--

