Return-Path: <netdev+bounces-263617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNsdBtLbp2kRkQAAu9opvQ
	(envelope-from <netdev+bounces-263617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:14:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E98C1FB703
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 091AC3018E3A
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE36372EE2;
	Wed,  4 Mar 2026 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2Nv6Dth"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6293C2AE8D;
	Wed,  4 Mar 2026 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608460; cv=none; b=GFk+Ol3IeIExfnBu1PEqAm/rIMQP8RLcALvRVhyFwkA842Tm/XbxbFeg+niqGEtajg5nsBJRzG5oFia4XzO9n22gV1XxT4YYX8be+t+I6sDTpknSrybSDfYKgYdJrz9L4RLP7TX1a5PfXEIn3m3zVt+z+yF4mQ4dKutBe2z+CKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608460; c=relaxed/simple;
	bh=cPZJfPbuDa1fkt02QXSIQH0+wvGAsNbNKl/OpOppkw4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F91a3e0PQGEPxriQqJlz1y/IdKxuKO8apN9H7utE27phK1u7/8M6l5L5p8bVkEAOjn7MWaAr4amqDasla730V7ZlTf4ngjqlUeCR9EIYFsfVH19f47+6NewL9/Ck59f5ty1BdTTLFI8DFU/mqOs6PL26mkyTVxUfBl/Jd4XJXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2Nv6Dth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5786DC19423;
	Wed,  4 Mar 2026 07:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772608459;
	bh=cPZJfPbuDa1fkt02QXSIQH0+wvGAsNbNKl/OpOppkw4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=B2Nv6DthxweQOzN4B5mA5GUF94adCUfwqJgJZ0DJyTf5mqabGwVAsWGWLhNy8P6+I
	 g31FjrQWFyZmS3CE8jVMu6ey2jyvfKhlux1CDPpecNyCy3r0a9G6lPO/0giVJM4Mmd
	 v6q2w6opQF5ZuUkP6wK2nleEQJBf/fijKg7vjBWABnvYEPPTExbjSRvYoJd4vEOyNX
	 oimsY1dxixhYpwpb6i80C8IwuDzT0mZcM7FUR/RwLC6TUnRH6+Eyt1mq9enjdwGEr8
	 x2NcNY3sQOxGL9bOapLXLo17/MGKIcp/hdXLj8dLQb7uO6TXuozWMQZKbgBVSUBjjg
	 F8CxB1kl59W8w==
Content-Type: multipart/mixed; boundary="===============8248387453652486925=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <772806bbb78e8d4cfc9525b6122c44496a1c345616a31f0bbb7f8dd12c621844@mail.kernel.org>
In-Reply-To: <20260304063643.14581-4-jiayuan.chen@linux.dev>
References: <20260304063643.14581-4-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v1 3/7] tcp_bpf: refactor recvmsg with read actor abstraction
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org,john.fastabend@gmail.com,jakub@cloudflare.com
Cc: jiayuan.chen@linux.dev,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,kuniyu@google.com,willemb@google.com,dsahern@kernel.org,ncardwell@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,jiapeng.chong@linux.alibaba.com,ihor.solodrai@linux.dev,mhal@rbox.co,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 07:14:19 +0000 (UTC)
X-Rspamd-Queue-Id: 1E98C1FB703
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263617-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.alibaba.com,rbox.co,vger.kernel.org,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,vger.kernel.org,gmail.com,cloudflare.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Action: no action

--===============8248387453652486925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2e26174c9919..6a906bfe3aa4 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c

[ ... ]

> @@ -440,7 +442,8 @@ int __sk_msg_recvmsg(struct sock *sk, ...
>  			if (copy)
> -				copy = copy_page_to_iter(page, sge->offset, copy, iter);
> +				copy = actor(actor_arg, page,
> +					     sge->offset, copy);

The direct copy_page_to_iter() call is now replaced by the actor
callback here, but deeper in the same function the peek-path comment
still references copy_page_to_iter() by name:

net/core/skmsg.c:sk_msg_read_core() {
    ...
		} else {
			/* Lets not optimize peek case if copy_page_to_iter
			 * didn't copy the entire length lets just break.
			 */
			if (copy != sge->length)
				goto out;
    ...
}

Should this comment say "the actor" instead of "copy_page_to_iter"
now that the copy operation is abstracted behind the callback? Once
the splice actor is added later in this series, the reference to
copy_page_to_iter will be inaccurate for that path.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22658462977
--===============8248387453652486925==--

