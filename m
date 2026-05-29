Return-Path: <netdev+bounces-292950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCSgG0z9GGoEpggAu9opvQ
	(envelope-from <netdev+bounces-292950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:43:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C125FC72C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A09DB311775E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28199367B75;
	Fri, 29 May 2026 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQG2j3cp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB9366051;
	Fri, 29 May 2026 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022399; cv=none; b=VKk0Y44Dp0mvuDzLi9sltDGIk7t48uCwfrClsdAOGAxbhx7S8JfhbGTHcLwb5WLb/t9v+QM/99QEnkhY5bY30CE/vjFfT9YcMFUOvOvd7i413r9XhzZKluQvt2fOYOdq3LK/vAW5DSIXydjMVvoZZuOEVH7x25ZDYvwxMCr0ca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022399; c=relaxed/simple;
	bh=+dmzY6pmoRScEDfj8mxsxFsCJ1wWIPvlahbfjeIHrns=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kreH3vNyVxfur6wijacwsyCwUCaEhW/JKebkN33CiCRxnq3TQ/cLkY7RxgBB3luOTNUC22ZUDgVoVxxFcc8//5oD2478HU+DdSMpGMmTTqN/cI2pkGE4TS9OS14tEhXPfA359HPh9KHxZkHZwKZWa9h9i7rk6EfKe0t5PampPKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQG2j3cp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888DC1F00A3A;
	Fri, 29 May 2026 02:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780022397;
	bh=7Exu8bkw9sfMSpBDR9+l+XlN7rjIeMecmtaIaQjDW/A=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kQG2j3cpTRnx3G5jBhmwt2vTD29oEINAPvBQlR5xYsj1BZDiA2xw2kPTU87Bf3PSC
	 nJ+9o19G9xt5s5PIKk3YQNCHRo1PYtAWk+c+ZNnQFvM0nNQ72XoXYqyauKQlzLWY9M
	 yBzHO9PMhwPMCwMlaIBcZGM1EHEft8LtEQE7WO0BKWBhBXoAonGzmjV889zPR7NQgr
	 UE61zVwLz/I7PDd/RJcDDoNUokqlAU5f/WtldimpP4XeZ3n39qKALXQflEvb+AIWz8
	 EREjyk20ONL1K3eqYyrZWFEx67QUhgiexWnhrnPB+UzC8jtUZJCXLgugdGRpTKxGIw
	 kd9fk4Vr6obVA==
Content-Type: multipart/mixed; boundary="===============6509139473524102146=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a46f04ea7c2245d83e07f7aae6c71068a0a441788f63f5a58a31cee3ddc2dad8@mail.kernel.org>
In-Reply-To: <20260529014936.2811085-3-ameryhung@gmail.com>
References: <20260529014936.2811085-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v6 02/13] bpf: Unify dynptr handling in the verifier
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 29 May 2026 02:39:57 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com,linux.dev];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-292950-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20]
X-Rspamd-Queue-Id: C2C125FC72C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============6509139473524102146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5cbad3b64130..3a5c226bf1c3 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1438,6 +1438,13 @@ struct bpf_map_desc {
>  	int uid;
>  };
>
> +/* The last initialized dynptr; Populated by process_dynptr_func() */
> +struct bpf_dynptr_desc {
> +	enum bpf_dynptr_type type;
> +	u32 id;
> +	u32 ref_obj_id;
> +};

Mykyta Yatsenko requested inline field comments for the ref_obj_id field
in v2, noting it would help with clarity. While id and ref_obj_id are
documented in struct bpf_reg_state earlier in the file, should inline
comments be added here for consistency?

The CI bot also flagged this in v3 and v4, and it remains unaddressed in
the final version.

> +
>  struct bpf_kfunc_call_arg_meta {
>  	/* In parameters */
>  	struct btf *btf;
> @@ -1478,16 +1485,12 @@ struct bpf_kfunc_call_arg_meta {
>  	struct {
>  		struct btf_field *field;
>  	} arg_rbtree_root;
> -	struct {
> -		enum bpf_dynptr_type type;
> -		u32 id;
> -		u32 ref_obj_id;
> -	} initialized_dynptr;
>  	struct {
>  		u8 spi;
>  		u8 frameno;
>  	} iter;
>  	struct bpf_map_desc map;
> +	struct bpf_dynptr_desc dynptr;
>  	u64 mem_size;
>  };

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26613892466
--===============6509139473524102146==--

