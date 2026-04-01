Return-Path: <netdev+bounces-273874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFDyKL6PzGnXTwYAu9opvQ
	(envelope-from <netdev+bounces-273874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:23:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B22CB374456
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41CD13047723
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 03:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821E237F8A6;
	Wed,  1 Apr 2026 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlJdeFuG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0F37F75C
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013631; cv=none; b=jdyE7ENJiR2Z6Zd3YhVJC5ZRJnzdTfRotkpCCWzW8tRWofTUt2J3S0X4WboGpCgrPvudLVyBqKvG7mnL7xURaP0n6+vzR4BJyye+5eg7i7p57CJ70p8NddVroIqTQMtbesdgys3UMUQXj+ckX5naP1WmIHvPzA6qaCWgHzDQlwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013631; c=relaxed/simple;
	bh=hgr/BzRUiR0lVKkkvGXlmYSuZvp+TT1XVf6SBRjQ9lI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JaGZpBmlBxAWxoxz9xRcXV6e9ntGHhvaD6TydauYqBqgZlsKryQAWUilRaHgX7hst9PIS5xqR+5jupKKVPjNg0uH9Prko9HYh3i+QUwvhhwBnKekqSASDqIloU0AMQQbSgzIEpadsv6OVhS3RcOzVTzq6uMB0oa6NrK3BV5hVJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlJdeFuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5EFC19423;
	Wed,  1 Apr 2026 03:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775013631;
	bh=hgr/BzRUiR0lVKkkvGXlmYSuZvp+TT1XVf6SBRjQ9lI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OlJdeFuGJcgAOiH3qU64HybTH+1h+WCytbmYpl5RdlmJhW9JwazEWzI1Ek8GU7UFD
	 R7bfRSDKKorn9I16CsAYb9lL/SgZ1QGkmPjFJ6VWOFiu9n/mSKUlqSN0/R7df/8P8W
	 1fuX65+83O/cFLO/N4Z4zWOrMGvR9nSVAQFJ1wd7uYVJ5elR80DX0gb5foibNLeqEB
	 XhOFC0U0s/AcjZ3dqv6TxBtoAaxMpWjRc+UpKMab/CQgDwnb8gVCVdCkC1KFRJlX07
	 2JBXUS2AbPEYwDezW7ed+hXgw0wI4LM7syDyP6qoz/uo4pqnk2E1jTXSxD0WhqvY9Z
	 qg8BTiS3S0hFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F0D3808203;
	Wed,  1 Apr 2026 03:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: vxlan: check ipv6_mod_enabled() on
 neigh_reduce()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501361428.3053582.9292699950868049213.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 03:20:14 +0000
References: <20260330121033.4479-1-fmancera@suse.de>
In-Reply-To: <20260330121033.4479-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, sdf@fomichev.me, petrm@nvidia.com,
 idosch@nvidia.com, razor@blackwall.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273874-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Rspamd-Queue-Id: B22CB374456
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 14:10:33 +0200 you wrote:
> IPv6 must be enabled or otherwise neigh_reduce() might cause a kernel
> panic. This was prevented by a check on in6_dev. Use ipv6_mod_enabled()
> instead as it is cleaner and also consistent with the code at
> route_shortcircuit().
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> 
> [...]

Here is the summary with links:
  - [net-next] net: vxlan: check ipv6_mod_enabled() on neigh_reduce()
    https://git.kernel.org/netdev/net-next/c/58e416e28328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



