Return-Path: <netdev+bounces-289587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH6hBmuyDGrdkwUAu9opvQ
	(envelope-from <netdev+bounces-289587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:56:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 790D7583EF0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B67B300CE60
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCA6376492;
	Tue, 19 May 2026 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFcbDTxt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5766536D9F6;
	Tue, 19 May 2026 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217000; cv=none; b=SGiInOFedSdSIBgY6QQiK2xS/sFxNOTgSGKZf4ZgDoGVkPR6bP05V8j5dEQyww5fWgvz+EumAqG8xj4K3QoPLL/wHZKC+F00ThCfUtdnlmZZuzCx75C5R5yxTlX+cYgHQVpwI+vZLSkf3Y94LJQHS4wBPEn6vJzCCzvGciW0r1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217000; c=relaxed/simple;
	bh=NCM4lXO08icePVSmFLoq9NL1LyqTVbg9gOuO1b1KEqI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WNnsC5LxtF4CqegmufRMwm1Z+kP6D2qd9exc/DF5R48ZOXE2k8O7WjmeB5aExaMbAYIwawxkRVZ4cl50nY1IH2ZdekQ1I6Ai3BC+P0kGgMpO4Sd6WDgANXw90P8ghiQdx3RX6BrMWl2hPgOoCTc1pScLUEDlf5fDB3tGaiAqnrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFcbDTxt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73D91F000E9;
	Tue, 19 May 2026 18:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779216999;
	bh=z2TdViM4b5dhSWgyeon1/G1pXargF1bzNRVAYQPRlKc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OFcbDTxt2APRJn8/ni/dSvMK1PrHoazX9TR/WLJxVOuCbK9u0q0k9y7VTotewDqkc
	 lTjU+L3XnpZw5cpPPfJ6KEd2SvQxTJiPGc3zjq3nCgMsSDWkMLDQrJxi6c/LxskI1o
	 3HBB62V4kOJqRywgSsMGXxEYgWgsFIOVndbwh1XppjNq1Qzn+bZbA70W/MZWPtcc0y
	 HSmuqwxC7A0ygXvf22GCGzyBlP5GDUEQu5l/t5VqTVPvK/89LBUnrF5l16E4nHOkVm
	 v1GPXA3TONCDz+3cy+cPT1ZVnFYTH8ZTaM/QOP5TnMUmAqKVIM2Kl/FGeZAaqyy6Er
	 JCFPmsmp/YXBg==
Content-Type: multipart/mixed; boundary="===============4134676594908535919=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2835fc606f98829230b388fc8c904e7ed52300b2b13e3c9368ec6449d17f5645@mail.kernel.org>
In-Reply-To: <20260519181314.2731658-4-ameryhung@gmail.com>
References: <20260519181314.2731658-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v5 03/14] bpf: Assign reg->id when getting referenced kptr from ctx
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 19 May 2026 18:56:38 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289587-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 790D7583EF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============4134676594908535919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Assign reg->id when getting referenced kptr from ctx
>
> Assign reg->id when getting referenced kptr from read program context
> to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
> referenced skb in qdisc programs using a new field reg->parent_id in
> a later patch.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

During the v3 review on lore, Eduard Zingerman noted that this patch is
mandatory for the series because the .id link is needed to propagate
invalidation triggered by free_skb() to child objects. Specifically, the
test bpf_qdisc_fail__invalid_dynptr_cross_frame.c:invalid_dynptr_cross_frame
fails if the line "regs[value_regno].id = info.ref_obj_id;" is commented
out. This invalidation propagation aspect is not mentioned in the current
commit message.

Reference:
  https://lore.kernel.org/bpf/c84a7beccd4ae527981797a6e5a6af840ba9c312.camel@gmail.com/
  Date: Wed, 22 Apr 2026 15:50:52 -0700
  Reviewer: Eduard Zingerman

Could the commit message be updated to mention the invalidation propagation
requirement?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 564679f70afd..441950b43a4c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6209,8 +6209,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
>  			} else {
>  				mark_reg_known_zero(env, regs,
>  						    value_regno);
> -				if (type_may_be_null(info.reg_type))
> -					regs[value_regno].id = ++env->id_gen;
>  				/* A load of ctx field could have different
>  				 * actual load size with the one encoded in the
>  				 * insn. When the dst is PTR, it is for sure not
> @@ -6220,8 +6218,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
>  				if (base_type(info.reg_type) == PTR_TO_BTF_ID) {
>  					regs[value_regno].btf = info.btf;
>  					regs[value_regno].btf_id = info.btf_id;
> +					regs[value_regno].id = info.ref_obj_id;
>  					regs[value_regno].ref_obj_id = info.ref_obj_id;
>  				}
> +				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
> +					regs[value_regno].id = ++env->id_gen;
>  			}
>  			regs[value_regno].type = info.reg_type;
>  		}

This looks like a bug fix for the id generation logic introduced when
support for may-be-null types was added to the check_ctx_access path. The
issue is that when getting a referenced kptr from program context (PTR_TO_BTF_ID
with ref_obj_id), the code was generating a fresh id for nullable types before
assigning ref_obj_id, causing inconsistency with KF_ACQUIRE kfunc behavior
where reg->id is set to info.ref_obj_id.

Should this include:

  Fixes: 93c230e3f5bd ("bpf: Enforce id generation for all may-be-null register type")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26116680637
--===============4134676594908535919==--

