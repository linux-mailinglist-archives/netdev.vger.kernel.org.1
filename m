Return-Path: <netdev+bounces-282602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEA9JIm88mlbtwEAu9opvQ
	(envelope-from <netdev+bounces-282602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:20:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 877FA49C44D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4143330055F1
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FDD230264;
	Thu, 30 Apr 2026 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB0NPV1i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D719E839
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777515650; cv=none; b=fFfKnCxgDxyf39smDGGYwWffDdtLTrlojSMNKBBflulx67qO1o4bUskCtINA/GdkLOOU59tiTOI43fxHn5VBsmhGW0zmxzfq3K/Y41N8mjJJmYsENoKRE0osIB2xHPFGvO5g5yqmr0I5D5xmPHogMlPQXtEVRSYBMau1xrmKDQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777515650; c=relaxed/simple;
	bh=fG4XzM+0j98ZmVdL/YHx441Q1L3c+7EFVTxjeKP48CY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p1F9CdfEXQ8uaXMffYsruBVKjR1+GUtqFQdPl22xDFubwhlN1VwHBrgJ8eqHxqX9YDPlY3AHMTq9YXnx1iU9uo5bW8IK54uSCV9ufqDG7kBXDzudCFpnQwpGcsFyAc91h6GgxFv/6lnAG/xcIPpKTjB1/frBuaVxKIcAUuv4PvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB0NPV1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B94C19425;
	Thu, 30 Apr 2026 02:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777515650;
	bh=fG4XzM+0j98ZmVdL/YHx441Q1L3c+7EFVTxjeKP48CY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kB0NPV1i4qWKwBur+nruR/1r+N+TmLOO6E469g7sVGC199cqD94XwcRxWuOvxvRZD
	 zTa3pOSrGCjk9mEg0syLpkNGAlbe7BWjnvdU3fmWdHMHemLPgQvWSP1iXYLEhh2OOx
	 xtLT1s/6+JjqRxVlagLyjtvMb9TsXpZXoezOk+bO9zLhLBK4y8352j5+vkJFP97z5Z
	 rC09WqF/QalYz5HzamWYjP1NfmlLS7WdX4lqMcXPvOgXV8IL0PzhpHJYXjFU2nFAxA
	 TKKP7XoxUrfahsLfTDZaV7UmbI6tvq3yvzwY1S3upcckVUDT1q/lGuWwKOWkfuhp6I
	 HO5C7bJ2BAtIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0783809A33;
	Thu, 30 Apr 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: add tcp_mstamp_refresh_inline()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177751560530.2266943.4878155187628228607.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 02:20:05 +0000
References: <20260429010809.784315-1-edumazet@google.com>
In-Reply-To: <20260429010809.784315-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 877FA49C44D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-282602-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 01:08:09 +0000 you wrote:
> We want to inline tcp_mstamp_refresh() in fast path only:
> 
> - tcp_rcv_established()
> - tcp_write_xmit()
> 
> Add tcp_mstamp_refresh_inline() for this purpose.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: add tcp_mstamp_refresh_inline()
    https://git.kernel.org/netdev/net-next/c/28df22acc275

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



