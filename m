Return-Path: <netdev+bounces-284918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBnRI5df+2kuaQMAu9opvQ
	(envelope-from <netdev+bounces-284918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:34:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3D24DD526
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 497BD30DE6FF
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789C4921AB;
	Wed,  6 May 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEAER9s2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E0481223;
	Wed,  6 May 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081249; cv=none; b=LZaXjXyAAHr1bVNDAmgvJc6yysZUspUtb6hb9scS6GtJRheNtSnLrD/EGbalAu9t8TqORM+HA/tsvifvHgJB4nO/CwwU/T+47GyvIGv/Kwp1OMoQuPeRizSwOlfnkvkLxNDIsAWJXIIEyyi09VI5yqDkbgguzjKxh698rXG+c2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081249; c=relaxed/simple;
	bh=4o1vc/tI3ToTqqw3EtZY5izd/wf6wGjREZKQ7NTcqEU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=V5/AEiQKtKXCwXlViweBf7OrluEsBMhbj/fTq8LzRV5wYoh4rp0Vewp5TtMYsyrOpHR6z1m+9bk37RN5s2rsdU5IMRBl8Sf5sI0DLoi3K/9ltNFJk9UqWbtu7iGRIMln2XIDMt/Kp9faeSrj7iEwP3py2UttMz5ojgOhoTClKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEAER9s2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3A6C2BCB0;
	Wed,  6 May 2026 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778081249;
	bh=4o1vc/tI3ToTqqw3EtZY5izd/wf6wGjREZKQ7NTcqEU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=WEAER9s2TupmJaptyvBF45+0oNL0ypb+Box0TgdUAZGcqe8Bo/wHzPHgPjPOpbJC0
	 DC+4RIraNo2KmaYnijavUPMNF4xJGEG6DbYjxEo/pk96OE1d4LnXTWuM/KWyRx0acf
	 9Ee0w9+exKJQGEnnDZ8Mk7HWBOU9lulIZIa6jjCjrxcZAC30mEXJ1B5M+YlZixMkV6
	 xbW8iT8dRjnYOQEaaJe4nTmwEiWKioJrnlmxwdQijglKEc6Vm0jH6I5eaRSpYCa4Rs
	 s4QMqXPYAcsaITa1K3jKc+um4BIvh1SH0Xe3g8DLtJN0qs0Ton5JHy3Wqs8cNV2t29
	 vtQxoR+6NYgZQ==
Content-Type: multipart/mixed; boundary="===============3238717845687022136=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <755de35ed30756cc0f8c3f1dae3cf6d6b82be6f066353b8421d38f9605f64ff1@mail.kernel.org>
In-Reply-To: <20260506142709.2298255-6-ameryhung@gmail.com>
References: <20260506142709.2298255-6-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 05/12] bpf: Refactor object relationship tracking and fix dynptr UAF bug
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  6 May 2026 15:27:29 +0000 (UTC)
X-Rspamd-Queue-Id: EB3D24DD526
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-284918-lists,netdev=lfdr.de,bpf-ci];
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
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

--===============3238717845687022136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index f330e9cf297e..51d5f5dd6e5b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -1381,6 +1394,7 @@ struct bpf_dynptr_desc {
>  	enum bpf_dynptr_type type;
>  	u32 id;
>  	u32 ref_obj_id;
> +	u32 parent_id;
>  };

Eduard Zingerman raised a suggestion in v3 about adding documentation
comments to struct bpf_dynptr_desc. The structure still lacks comments
explaining when the id, ref_obj_id, and parent_id fields are populated.
Would it help readers to document when these fields are set?

>
>  struct bpf_kfunc_call_arg_meta {
> @@ -1392,6 +1406,7 @@ struct bpf_kfunc_call_arg_meta {
>  	const char *func_name;
>  	/* Out parameters */
>  	u32 ref_obj_id;
> +	u32 id;
>  	u8 release_regno;
>  	bool r0_rdonly;
>  	u32 ret_btf_id;

Eduard Zingerman suggested in v3 adding a comment for the new id field
in struct bpf_kfunc_call_arg_meta. The field remains undocumented. Would
a comment clarifying its purpose improve code readability?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25442456702
--===============3238717845687022136==--

