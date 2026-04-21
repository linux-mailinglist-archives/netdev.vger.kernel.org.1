Return-Path: <netdev+bounces-280272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO72HJ8A6GlJEAIAu9opvQ
	(envelope-from <netdev+bounces-280272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:56:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD844055F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C6A230FFFE0
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6293B3A7597;
	Tue, 21 Apr 2026 22:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU24hZQn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403303A7580;
	Tue, 21 Apr 2026 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811944; cv=none; b=UUfpdnBC7QdELhB9231Kq96hseHsXHnebdty+WLoFtB206N+t5mrHOsTjS0BTRQBrYPt/Z/Cp35vLgR10aIwe1IQL58elQCtd853Tuy99UgnMUjd1MBKSsFoN4zA9ZF9lMCJ/oYxN29vYXHOo0vAOEmanld+9VlIxnguoSLNKCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811944; c=relaxed/simple;
	bh=ZGmej5pdVLGzwTKJ/MVuh7ABN9ypk9m9cO3XcT8o8JQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VYRFBuCe4WE5MnUM5RSpkq98TOOcefxFNrLXnvqodTnkkkf+s4xGkNQ6PDutGk6rggkQNrW0fTa5Jrs9Cvyi65f7z2j7MAV1Wybh++WgPJnTPw1Rc87etGtfR3rehiaFg+kzEfDAsqPYbbDEudTW614SWi7Bb3kihtiC6p6PeqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU24hZQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7962CC2BCB0;
	Tue, 21 Apr 2026 22:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776811943;
	bh=ZGmej5pdVLGzwTKJ/MVuh7ABN9ypk9m9cO3XcT8o8JQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XU24hZQnLc6rsRksZO80llGgpTP9BneMkLU/AznW3bcD4TNWRGBo2fzpdzLgVfSEw
	 E+53QNycyvmnQWcRAx+TZdMXK0zIP6iCvBen8rOAa7XKaS0WK7kW4a8ZwFFxdUW6mr
	 6nU8dsgjJNuxathi8EjRWxNLssVZPXOqu5FQR9697JE64NNo2m8LuA07NJV4CGpvo4
	 L0aERE8PtAPk1SUIgTBk8QTslH7LrL0vRPdExuLTzYk6G48g2qgPk5DZqOqeIBETIb
	 pRIIoiMEp+kx63GEAiIsyJSpUZ9XypEAaTcvhndJ+UOIIbeiETmqI22sQOpVJrivav
	 AQqsdjuLoN4PA==
Content-Type: multipart/mixed; boundary="===============0354082449293124802=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <682487c0e8bd32678ad92c5e94f18dd78e45d7b3132e11bc5c1a4d4285a05369@mail.kernel.org>
In-Reply-To: <20260421221016.2967924-2-ameryhung@gmail.com>
References: <20260421221016.2967924-2-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Unify dynptr handling in the verifier
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Apr 2026 22:52:23 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-280272-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8DD844055F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============0354082449293124802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b148f816f25b..dc0cff59246d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1319,6 +1319,12 @@ struct bpf_map_desc {
>  	int uid;
>  };
>
> +struct bpf_dynptr_desc {
> +	enum bpf_dynptr_type type;
> +	u32 id;
> +	u32 ref_obj_id;
> +};
> +

This isn't a bug, but as noted by Mykyta Yatsenko in v2 review, the new struct
bpf_dynptr_desc could benefit from a comment explaining what the ref_obj_id
field is for.

While you mentioned in your response that comments for id, ref_obj_id, and
parent_id will be added in a later refactor patch (#6) since these fields
apply to all objects tracked by the verifier, the struct currently lacks this
inline documentation. Could this documentation be added now to help readers
understand the field's purpose?

Reference: https://lore.kernel.org/bpf/87ikb2tkta.fsf@gmail.com/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24749741787
--===============0354082449293124802==--

