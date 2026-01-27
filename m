Return-Path: <netdev+bounces-253706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULmcCbdIeGnipAEAu9opvQ
	(envelope-from <netdev+bounces-253706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:10:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7550E8FF6E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AC73300EA98
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D3F30E82B;
	Tue, 27 Jan 2026 05:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kspykyUQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C4E1DDF3;
	Tue, 27 Jan 2026 05:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769490612; cv=none; b=MNfvbtaTBF0QbzvvcFUvUpzJ5NpCSLLqnERjBZwzznScjZrj1bkG6xrYPR0y28yKWBsBcLgUxPhTJqh6VRLXitbllRRXONN2TEYCf5T+w1eHNWSIPC1H4hkuKDMx59btqhY4wCUFjVHlk9uwStpRvX1GRxvA36Cjf4SfFBFez90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769490612; c=relaxed/simple;
	bh=ps4ZfLizf07VPmuUav8B2725lQqzqEfx6b63uKz6/YE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Axozrm+1a6kM+PvMunZ7jgLAvqH8/nD+Bw4ISw1KU7N6pPoRD1pqkK4ElB14UhxdCo5qRZjkKhv+e9X3chgkLCTl54nJyaK6tLmUd+adVjwlABPByRuRbap+3oaYACsi3P5aHV8KOKZ8+RbLEYj+AE+45YirzR0QFuM0Yp5fSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kspykyUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF24AC116C6;
	Tue, 27 Jan 2026 05:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769490611;
	bh=ps4ZfLizf07VPmuUav8B2725lQqzqEfx6b63uKz6/YE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kspykyUQGmFIbP8rxnUCAQLM1vcADgTvaUULVYeXF5BcCSu3hDtXGTXKWu8ePR61z
	 SLfkt8r33u/nAfL/7oGDodKlCWBwaUJkgjLpq2BcK03tsh1InrxzhMXfDrYmpfw6WL
	 oqovVMACsYW3lzf8tpoLMnq1ZascZeQq3l4+TChS9zxyCgzzp18p0/EOl12y9GKgAV
	 Z1PhNNzUKj+0hHg5KAdZpV5slE5BecFZ2gT7a5/pdPHs7TxUOsrOL71QkzL42n3VoD
	 PqDtm7bExs6ri7HIUnBAdhMsXFFw84DnsW1GWU2wsz9rls/DIUtaCw31tFvaZCN9YS
	 6ads8+NYcivRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB2E380A961;
	Tue, 27 Jan 2026 05:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netdevsim: use u64_stats_t with u64_stats_sync
 properly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176949060611.690573.14637014528283356342.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 05:10:06 +0000
References: <20260123211101.2929547-1-mmyangfl@gmail.com>
In-Reply-To: <20260123211101.2929547-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253706-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7550E8FF6E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Jan 2026 05:10:55 +0800 you wrote:
> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. Convert to u64_stats_t to ensure atomic
> operations.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/netdevsim/netdevsim.h |  8 ++++----
>  drivers/net/netdevsim/psp.c       | 18 ++++++++++--------
>  2 files changed, 14 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [net-next] netdevsim: use u64_stats_t with u64_stats_sync properly
    https://git.kernel.org/netdev/net-next/c/5c05b3dbccb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



