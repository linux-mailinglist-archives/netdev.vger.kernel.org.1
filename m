Return-Path: <netdev+bounces-277630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DOUMASb2WkTrQgAu9opvQ
	(envelope-from <netdev+bounces-277630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:51:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DF23DDC43
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0A17300A64C
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF40B238C1B;
	Sat, 11 Apr 2026 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUngIO7F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE4740DFA1;
	Sat, 11 Apr 2026 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775868669; cv=none; b=Pqc8sEq97bxJcgWxXhQB62+dwta6gmSiZRyQuTm6JqDaRuanPLvXs7qmZAEjD/I9oimS59qm0U9zp8Xzr7EAFkE4cA5ktGBm1n7DUfoTVxPE9mBFOIbAaPhrBO8ukHIga++RAXOKm48HCKg1pbjVKBVBf8r4X6u3yvzntlYFlM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775868669; c=relaxed/simple;
	bh=vMNo/MofsUxEpMei2dJlX/3PBD4XqVvyrCAUDeEIyYM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ojT4ZaC4SbP8q7B5m27hDp2dkhCEDahJuZVPq8xYMCp8fgCYNjjjGDTeDEr5XWWv/C0evSX2lq7clNRixVWV8zLwEcKkHgyQ16AfhjujMCx7yZwD+UsRY6kwyyuz9MQI09wE8aA/23U0x/BFWpVl365vC0rvUPFGdgIRW4Dpk+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUngIO7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D713BC19421;
	Sat, 11 Apr 2026 00:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775868669;
	bh=vMNo/MofsUxEpMei2dJlX/3PBD4XqVvyrCAUDeEIyYM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=aUngIO7Fhim5CnF5C84c0z/tqOgq76B06GQA/lP1I1zb/0Jip7VFb1pb+pWJgj8Pe
	 1q2xwQT0LWLJg+g7ZXj1TM0Sx/H1Y1pnDoy2HfniuV2mGQR6PqVkVQciAvGiHNy8uE
	 u9ZWQotKfFPb9ZAChelbb6OPtDhp5jcTmnur/FP3d9Y4Scsu1kzAbUtEjTs5K3IUfJ
	 7HyWcj4ONxCk3lr+nIIbAKTqLDmim5wJCfi4Zw+oH+d6cT9GMWJcv8urCp7OCyPk/v
	 3/Q+sjM4QmBxclcewxczZpGZ2DD/2mS2AtU8jpl3U/V/3YKbsdAJiUou2+NCtDuus/
	 azmjSrRfZTvuw==
Content-Type: multipart/mixed; boundary="===============2983978709261763309=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9f7e217d9a5184bfcf0bd1112a9075c0f3633266e8eb1026cd1c651a0754edb2@mail.kernel.org>
In-Reply-To: <20260411001711.3418264-4-ameryhung@gmail.com>
References: <20260411001711.3418264-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] bpf: Remove gfp_flags plumbing from bpf_local_storage_update()
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 11 Apr 2026 00:51:08 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277630-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: C7DF23DDC43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============2983978709261763309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index dced54e9265f..9e4f5c45c974 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -188,7 +188,7 @@ int bpf_selem_link_map(struct bpf_local_storage_map *smap,
>
>  struct bpf_local_storage_elem *
>  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
> -		bool swap_uptrs, gfp_t gfp_flags);
> +		bool swap_uptrs);

[ ... ]

> @@ -196,12 +196,11 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
>  int
>  bpf_local_storage_alloc(void *owner,
>  			struct bpf_local_storage_map *smap,
> -			struct bpf_local_storage_elem *first_selem,
> -			gfp_t gfp_flags);
> +			struct bpf_local_storage_elem *first_selem);

bpf_selem_alloc() now takes 4 arguments and bpf_local_storage_alloc()
takes 3, but bpf_sk_storage_clone_elem() and bpf_sk_storage_clone()
in net/core/bpf_sk_storage.c were not updated:

net/core/bpf_sk_storage.c:bpf_sk_storage_clone_elem() {
    copy_selem = bpf_selem_alloc(smap, newsk, NULL, false, GFP_ATOMIC);
}

net/core/bpf_sk_storage.c:bpf_sk_storage_clone() {
    ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
}

Won't this break the build?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24270284504
--===============2983978709261763309==--

