Return-Path: <netdev+bounces-299666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hs9OAsKNMGp+UQUAu9opvQ
	(envelope-from <netdev+bounces-299666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:41:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5921368AA02
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:41:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="BKqJ9c/2";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299666-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299666-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB162307DF9E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191BE345725;
	Mon, 15 Jun 2026 23:40:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF42340403;
	Mon, 15 Jun 2026 23:40:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566833; cv=none; b=u00W/CG1GO9uCfWK8JwTpWtdMHcMVyWrUg50i8tFGELbJlMHvr1oZXJ8enfxqCUWCs+R/J3BnBK47nulEW+SKGZdGtPZE3mUEG61GGe17crhhVyzmOmLWIzuuR/uI2lMx9kA8N3CzoqrYaTcXosah+5Nitfr2RgBBDZ+eXL9kCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566833; c=relaxed/simple;
	bh=QdYGS+1gLW6kM+a+J7pjLRMNG7V653bD9q6hsT+UwTI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LGrUHLpqQ8mqtBhSaTKbBVR+IygqrCKMcnT9/Sse5wzXcvFgGWa6+oqfwTndg6+Iky15KtoDBV6TTt9GNFB7md8FAKzAWHEFBYYwPqvMzOmcDWm/jr86zfa8nZEESkcNc1jC8ayG20FNu+xQi9OopzMmVKAbsFk2c2RL2ugTh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKqJ9c/2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABE21F00A3D;
	Mon, 15 Jun 2026 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566831;
	bh=3bwzDDWjuMcDBe0LdROJFjXNIA8+HW4+PRiOoJLnH14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BKqJ9c/2Ugj7I+8FYqhVrXfe16R+zBQJVA9SDtQ9JwUBlTkG25GI/x1zntf/MNnHO
	 yGXKu6szzHpw+zSLiwKfNnuYYNieq1d/h3hWxVWdrke8XXO8OaOwqAI8rkcT8sJgB2
	 +IKIP5xS2BEuFWDX5STeD30QuPFd5J9e3MbY0/nD5AquQbOspu44WsFsg6FYDuJMl2
	 3wMzFgNgJeOQfp6VMthySSMqL3qqSFJ2cpAHPsZ/BWXp0u+NWAWi5VMef8uPYuI4xW
	 rvzfJR44gUqmth+ayfzyTFALI8I8qXMq3UL7WuCRFpyR4+M5AtWzX0S0CvRXjpfBNd
	 KQnHxjQXYU60Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08FB3839A08;
	Mon, 15 Jun 2026 23:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v14 0/2] tcp: rehash onto different local ECMP
 path
 on retransmit timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156682638.339383.5955465321121394941.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 23:40:26 +0000
References: <20260615042158.1600746-1-ntspring@meta.com>
In-Reply-To: <20260615042158.1600746-1-ntspring@meta.com>
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev,
 daniel@iogearbox.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299666-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:ntspring@meta.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dsahern@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:daniel@iogearbox.net,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5921368AA02

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jun 2026 21:21:56 -0700 you wrote:
> Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO,
> PLB, and spurious-retransmission events, but the new hash is not
> propagated into the IPv6 ECMP path selection.  The cached
> route is reused and fib6_select_path() is never re-invoked, so
> the connection uses the same local ECMP decision.
> 
> This series adds the two missing pieces:
> 
> [...]

Here is the summary with links:
  - [v14,1/2] tcp: rehash onto different local ECMP path on retransmit timeout
    https://git.kernel.org/netdev/net-next/c/658eb696544c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



