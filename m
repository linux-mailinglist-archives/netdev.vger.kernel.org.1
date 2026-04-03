Return-Path: <netdev+bounces-274881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPMIMCNNz2kyvAYAu9opvQ
	(envelope-from <netdev+bounces-274881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:16:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F09A3910E7
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBDAD302659D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 05:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC603542CF;
	Fri,  3 Apr 2026 05:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0/0BQvl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FA31F994;
	Fri,  3 Apr 2026 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775193353; cv=none; b=P9vlivd4zG5PZzOjXiQIh0de4uYFJvjOLDbY8l9OdBfyfJDQ43F5e/xwp5KtZgISTKJVTYy22apFfd1RTF8u7xP4JcVOo9I3Vf2tF+0S5uXtkBBEBjCliOjFOYX/EWeYtGnWBV9FdPtUXxxlKtvx//OjIrft+8q1zlUt7CE3B2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775193353; c=relaxed/simple;
	bh=Sswnkko+CAR04IjXTq+jqkrW6/QTDN4rDDu6gHkH/nQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=axVv43mKEpy+wrN5v2pmYeB0+Bl4ELa53LlFQVzE4iNgD0nqDKYcdt9RGvSyVhyQuPF4LU0RVq69hUOXguJQ5J1nItC/A8KZN15IsAtjq3sxW3JjoG3eluMJ17IPOTlrSOABKpBPy2viLIjAA772F+hcJj/tIJ6Fo7LZ27l6ccU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0/0BQvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4DDC19421;
	Fri,  3 Apr 2026 05:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775193353;
	bh=Sswnkko+CAR04IjXTq+jqkrW6/QTDN4rDDu6gHkH/nQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=P0/0BQvlV6xKx+ITyRBIzEtR+hF9tgeVwEuaBnsUSQEVaPQqwoGUbwpNIBlbzYLJs
	 P7842NfwZQcA/B/2S5qaSo4pXvcbvTPmYHWcR/1ha/rnzbUsidl6Jt5HqK4f9mUtTK
	 9334zbehed47fDfLWfI8Klb+OdgHQiSTylVORk8LCvQKfXw2Ykrz8Zjpcy///HG6yL
	 Mz05wl0lk+xli4mSAbiL+Nw40gI9Z1UeWXPsdxTqsMmkVEt88BR/rYV2uQE6H1MDlp
	 lz854fRVGEF9biTZjvZwEwjru8HKypPzFgcl9bFz3XLFLsrqO2+2GImlfk7h5NG5Ks
	 ghnoTjgOxx6Lw==
Content-Type: multipart/mixed; boundary="===============0074582293386729096=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3e5a19c82d5a24696101ee24e1e9141f4fb06d0fc892215b980522d01a1322a8@mail.kernel.org>
In-Reply-To: <20260402160147.215499-1-sun.jian.kdev@gmail.com>
References: <20260402160147.215499-1-sun.jian.kdev@gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb
From: bot+bpf-ci@kernel.org
To: sun.jian.kdev@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org
Cc: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,sun.jian.kdev@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  3 Apr 2026 05:15:53 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-274881-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 6F09A3910E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============0074582293386729096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 4cd6b3ea1815a..2bc04feadfabe 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1137,19 +1137,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>
> 	switch (skb->protocol) {
> 	case htons(ETH_P_IP):
> -		sk->sk_family = AF_INET;
> -		if (sizeof(struct iphdr) <= skb_headlen(skb)) {
> -			sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
> -			sk->sk_daddr = ip_hdr(skb)->daddr;
> +		if (skb_headlen(skb) < sizeof(struct iphdr)) {
> +			ret = -EINVAL;
> +			goto out;
> 		}
> +		sk->sk_family = AF_INET;
> +		sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
> +		sk->sk_daddr = ip_hdr(skb)->daddr;
> 		break;

[ ... ]

This fixes a bug that has existed since fa5cb548ced6 ("bpf: Setup
socket family and addresses in bpf_prog_test_run_skb") which
introduced the sk_family assignment and ip_hdr()/ipv6_hdr() access
without rejecting packets too short to contain L3 headers.

Should this carry a Fixes: tag?  Something like:

Fixes: fa5cb548ced6 ("bpf: Setup socket family and addresses in bpf_prog_test_run_skb")

This was also raised in the v2 review thread:
https://lore.kernel.org/bpf/20260329161751.1914272-1-sun.jian.kdev@gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23910290394
--===============0074582293386729096==--

