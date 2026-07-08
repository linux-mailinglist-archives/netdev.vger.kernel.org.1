Return-Path: <netdev+bounces-305802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UG1bC8FHTmpZKAIAu9opvQ
	(envelope-from <netdev+bounces-305802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:51:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E5972674E
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:51:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RYvZP12y;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305802-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305802-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A8433010277
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF6F42A159;
	Wed,  8 Jul 2026 12:50:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947F33403F1
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:50:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515031; cv=none; b=n9v0m+6v4k3xWvwm1RmUPBgDoJWVAuYFHcoPTUoLw7/lwu7QFUH0UZOXnnJdYHgl19K0j+Cl4pBr699IYWoivtwTfrReSbY0x9qcs/dVMV7Jw+FnWX02DxMAA2P/IlWkNlH5lIbDwhuRirkvJg12jrXtKmhgEERIzEtDQKEUBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515031; c=relaxed/simple;
	bh=dkMtuhc9Xrbnd+v5E+gMTCqeYWh8egGekVhm1gf4rA8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B3crS8iFuW4WDkQhPvGsDOnM2Z9Dj6fXnXv3AaqUrzm+w/jeux6Cz4HqrQQyUojFsJ1EMmMUj56yFxLrgKKUfs7e6XfH7LKce7M2juwVwSkya9blZkd/+TAqnBH8RTAtYj+qC7QwJwbaJ6+i1bKKsKZXyHI7azE1XhV+hX95l6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYvZP12y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFD71F000E9;
	Wed,  8 Jul 2026 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783515030;
	bh=4ItEn/Ro7108dB74ZXSJd+dcfahUyGFvE4mN6jco6xQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RYvZP12yl12UjsH+qs9zoooIfVwAXpha2Kq1N+DfC8EpVnof/G2UloiA0mLEgf2V9
	 oJ5q2UWoP7rIjDQg49cmyBCoZciW2ESlLdX73mk9rQ3g2iGEKBhfVTJ7L6ejHvetrA
	 wpRq6ApqBCMkLHj19bxwpDoYJ6yrva+OB9j7LOTPhR/4pcPxmeVbXKLwE6CXqhu5SU
	 4Gy8V0Dn98EoEb1bIuUwJ3zQSzK2KMNxkYrh18I0KpN9suRnl3QJyfacriXa5zOHkY
	 6jBWdmlIUwuwAHGg9n7Upe3LPYPpxD9ChXcN4idb5RCRJvOkgWYU4w0/8CWOZWQ/Jk
	 d7u7fn2f6GnQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C8B392704E;
	Wed,  8 Jul 2026 12:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/3] ipv4/ipv6: Fix UAF and memory leak in IGMP/MLD
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178351500964.2486281.17497875860770814057.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 12:50:09 +0000
References: <20260705181756.963063-1-edumazet@google.com>
In-Reply-To: <20260705181756.963063-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, idosch@nvidia.com, dsahern@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305802-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,nvidia.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82E5972674E

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  5 Jul 2026 18:17:53 +0000 you wrote:
> This series addresses two potential UAF vulnerabilities
> and memory leaks in the IPv4 IGMP and IPv6 MLD subsystems.
> 
> The first two patches fix a UAF where the packet receive path races with
> device teardown. If the device refcount has already hit 0 (but the memory
> is still held by RCU), incoming IGMP/MLD packets trying to schedule delayed
> work or timers would call refcount_inc() on the 0 refcount, triggering a
> warning and eventually leading to a UAF when the work runs after the device
> has been freed. This is fixed by introducing safe hold helpers using
> refcount_inc_not_zero(). In MLD, we also ensure we only enqueue the skb
> if we successfully acquired the device reference, to avoid leaking skbs
> when the device is being destroyed.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/3] ipv4: igmp: Fix potential UAF in igmp_gq_start_timer()
    https://git.kernel.org/netdev/net/c/7b19c0f81ed1
  - [v2,net,2/3] ipv6: mcast: Fix potential UAF in MLD delayed work
    https://git.kernel.org/netdev/net/c/9b26518b6896
  - [v2,net,3/3] ipv4: igmp: Fix potential memory leaks in igmp_mod_timer() and igmp_stop_timer()
    https://git.kernel.org/netdev/net/c/3546deaa0c30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



