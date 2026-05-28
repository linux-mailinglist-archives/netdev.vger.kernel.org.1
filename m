Return-Path: <netdev+bounces-292482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O1CO+qHF2oCIQgAu9opvQ
	(envelope-from <netdev+bounces-292482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:10:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE705EB2A6
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3002304E42F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4252836F;
	Thu, 28 May 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv181+Pj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE3DDCD;
	Thu, 28 May 2026 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927008; cv=none; b=qpRzUjHvIcdTBR2jvGECqnpaVxpfNcrlbDgEVzr5l8NKfL1j+PYHsW8CO/qn3G3pn63oOUyBKOJ33AUxIZAoVR+mE3CX99cGKqLVEJ3A1hiaUV6QlRAk+0CYjGWzVSsAG2Sd8+a3r7xlu/PP2UR/fD3I5SJxaHyLMgnWCE10Msg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927008; c=relaxed/simple;
	bh=PefNJ4hkmQ2TbseJysbOgyHXdl9+enheB80Bj5xMDUg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XfRnUUL3Y4yH0ld1m6qm7muiVtohzIPBH4ZSVXf9aOffN7sCi9wTW/MF6RfSa8HKGg1gpVByppGbmHucY4HzAubtGTO6GW03IERYsn6G9AkbyWMQ4e90rLkVOC5O2ZHTfcyn4/xIfzp8YE663vIrLl//SNqqMHCg5y6GDreEIsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv181+Pj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AC51F000E9;
	Thu, 28 May 2026 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779927006;
	bh=xD7oYb7DgDb+apONV5pQaciABA1qNuxjDBqgB423VQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Dv181+PjSElyQAApUI0ZNRkmJ69tkxSxeBs6gpLRaZRFABnf+o1FHm/0IXZg9nyHn
	 HISVXOxAYpufxA/3QDz9cZ+VKCYH8ki9B5bWE/FJ0mFSV1uJmdnYgIvG+UncNSdIDk
	 Rr+O5dTOm8Jny2BqE1hCdfwrz4J5Dqr8yMdnJMkqoNJ+d3a7likDegUvxDL4dOU0We
	 L485USEcGjHwBNwCEu8WrBZWqWI55fkZPSjKY02tPdhPmxCs/dZWKpB0l5RROAOOH6
	 wR3sj/2g5kGrIYtrpQxoZ+/3GHguV4Yv+HBnoSmZx9VAPoPEungA1ItN0kymcDhJRP
	 EepqKg+pQlV/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A50380CFDE;
	Thu, 28 May 2026 00:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: mcast: annotate data-races around
 mca_users
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177992701164.690389.11147762277523425287.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 00:10:11 +0000
References: <20260524022456.20689-1-sigefriedhyy@gmail.com>
In-Reply-To: <20260524022456.20689-1-sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: jiayuan.chen@linux.dev, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-292482-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6AE705EB2A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 24 May 2026 11:24:56 +0900 you wrote:
> /proc/net/igmp6 walks IPv6 multicast memberships under RCU and prints
> mca_users without holding idev->mc_lock, while multicast join and leave
> paths update the field while holding idev->mc_lock. Annotate this
> intentional lockless snapshot with READ_ONCE() and the matching writers
> with WRITE_ONCE().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: mcast: annotate data-races around mca_users
    https://git.kernel.org/netdev/net-next/c/56ed77ff6022

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



