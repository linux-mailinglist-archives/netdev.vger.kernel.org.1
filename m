Return-Path: <netdev+bounces-261235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MgLEe0HoGl/fQQAu9opvQ
	(envelope-from <netdev+bounces-261235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:44:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 944C01A2C85
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D4B530AD48E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C23395252;
	Thu, 26 Feb 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3ifEhTv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2939446D;
	Thu, 26 Feb 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095278; cv=none; b=cdjKxECk+1L9LsSyFjDW59er/vcPSk841+iNlZp3ms4B58sfCyN5EEFgcJsgzAAzyWMWXvIu/gEHGbcpIPwG0Omz+uzI/rMPXmoP1Io78KviZa79+/SoA3oxa7VoJO0zHeImvPq9gIy+AiGKPhXCtMjttWegoicWSVa9AgFBxyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095278; c=relaxed/simple;
	bh=kiR7FCHXtf812rJJzmbWd2klQTsmdQZuOWMjeWWVNOw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ame92TlTgCeVUiGciIIRf/o9ucE7qqSvte0cXE/fIcJBSxVXdM4BFWLLiy5Plk/KflyAUrSGfVWJi2um0xBHlusu5HDLX7ZQs3l5hhaSKsqFDTRgEASz0GmXbCd+HuMI4Mw87stqSkQ29AiXAZgT0ZpNTp3drVsihl7ZGt4oNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3ifEhTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EB2C19422;
	Thu, 26 Feb 2026 08:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772095278;
	bh=kiR7FCHXtf812rJJzmbWd2klQTsmdQZuOWMjeWWVNOw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=W3ifEhTvEPDvURXLjJxR+16d66NJgm5q451vPEUUCFlisIvtIbXp5T7gTOjNgcybq
	 Amv/p1rWh4xN2zezcwmN6O4TKxnnFxKosBYXUL9qxkCmx21JqJFBqEYdthJ9KkO4+2
	 E38EUGKp+Skyow7pRG0iQ3fzefcCOPtqATMkqtZ/rsJmxuRcYsKwHI/zYKVkp4DVOV
	 PjlNN2sWVHBvxkZF3FBdmyNZP4NRUJkvlr1kfdgfJDgILLBIfgE0CYz5poZ1Vtf5E2
	 Dtoffd667N8B8bL8F+Xrj4TIAlPbu5BkuKkOEIAepyTo/8tmGv9oouT2crAF1sXhRx
	 pVKhkyv07Xk0g==
Content-Type: multipart/mixed; boundary="===============5987427679039999653=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9923d7a71f5623f84db40fa20cf3fb4e8625fc5f2661c4584dfa9237c2d98bcb@mail.kernel.org>
In-Reply-To: <20260226080003.524935-7-idosch@nvidia.com>
References: <20260226080003.524935-7-idosch@nvidia.com>
Subject: Re: [RFC PATCH bpf-next 6/9] bpf: fib_lookup: Honor oif in IPv6 output route lookups
From: bot+bpf-ci@kernel.org
To: idosch@nvidia.com,netdev@vger.kernel.org,bpf@vger.kernel.org
Cc: davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,edumazet@google.com,dsahern@gmail.com,petrm@nvidia.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,idosch@nvidia.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 26 Feb 2026 08:41:16 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com,iogearbox.net,linux.dev,fomichev.me,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-261235-lists,netdev=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 944C01A2C85
X-Rspamd-Action: no action

--===============5987427679039999653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 0d5d5a17acb2..e92552b139b1 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6255,6 +6255,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>  	if (flags & BPF_FIB_LOOKUP_OUTPUT) {
>  		fl6.flowi6_iif = 1;
>  		oif = fl6.flowi6_oif = params->ifindex;
> +		strict = RT6_LOOKUP_F_IFACE;
>  	} else {

The fix itself looks correct. Since this addresses a bug that has been
present since the original bpf_fib_lookup helper was introduced, should
this carry a Fixes tag?

Fixes: 87f5fc7e48dd ("bpf: Provide helper to do forwarding lookups in kernel FIB table")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22433453774

AI-authorship-score: low
AI-authorship-explanation: Precise one-line kernel networking fix by a known kernel maintainer with deep routing subsystem expertise, characteristic of experienced human developers.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Missing Fixes tag for a bug present since the original bpf_fib_lookup helper introduction; the code fix itself is correct.

--===============5987427679039999653==--

