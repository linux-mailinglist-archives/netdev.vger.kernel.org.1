Return-Path: <netdev+bounces-264927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL3tEIVHq2lcbwEAu9opvQ
	(envelope-from <netdev+bounces-264927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:30:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96303227F1D
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 793C83095245
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550AB330644;
	Fri,  6 Mar 2026 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dat5h0UZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322721FC7FB
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832610; cv=none; b=rK62PzcQ6ylGSwnT6G6836+drKcom9W/LvrLG1GR7wVU0llvPVZdZ3I3GjjfmZceYEsbm08cOd/4T/7Il8e5LHLB5G0kUeASZUDX8cgU4wAHdoTcW9WhROFNFati85OTkbKmWl1iPSY34rKcVHgxKnYZZzvw3O5FJmVC9XSeXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832610; c=relaxed/simple;
	bh=hdMsp9VFnsDfR1ssvxu2AzMpKoKVquhpS66CAGqHefg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n7WtRwFmAOdqju1LPr+x0VnkSntwz2h5X3mh4qbaa1LXMgrhkNz/LvNKdhKpBd0fwaah6AcVX8f18hb3QTWoULrgxTnrlRKx/uEgv1rC1UAHshxKkK9x1cpmlWGhSt/GYLuZOSsiptQnF0Tg86Y/n0BdnxRLie72g3EQ4TIMS30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dat5h0UZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF10BC4CEF7;
	Fri,  6 Mar 2026 21:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772832609;
	bh=hdMsp9VFnsDfR1ssvxu2AzMpKoKVquhpS66CAGqHefg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dat5h0UZUw8yj9AtdJQBCi+OxVVXemGf+aXntq/sD/x61Pr12/Vflu8tGlbcVJm1w
	 B1Zx8bOfkVZ6PDlLpIZZeOMcogEH1xFurxMBmlacFqZr+lCTjD3nf6GuDQmr3hJzuH
	 5TF1JmjdMsCgMQgNUgEq+sqIHM6LaIOQxcnqs8uHM8NATefXnBa6Q6aWyxEavhDxSH
	 qn32dbzU1su1zsqU737BWsVrKvAUxgHM17YKMW4tLiH5eK3w7OpQ+LLweTrYR+qU5R
	 34hP1a9UmfJSwkwW0ciniU8Z4rgliBJDihG0mLWsJUBNsJYrM/YvtHIEzee7EceAF+
	 fu6rZSHz88Otg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE023808200;
	Fri,  6 Mar 2026 21:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] Revert "net: phy: improve mdiobus_stats_acct"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177283260879.58743.835628635631184161.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 21:30:08 +0000
References: <c3a1aba9-3fae-4c4b-bcb1-fb620fb7a309@gmail.com>
In-Reply-To: <c3a1aba9-3fae-4c4b-bcb1-fb620fb7a309@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 m.szyprowski@samsung.com, netdev@vger.kernel.org
X-Rspamd-Queue-Id: 96303227F1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264927-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Mar 2026 18:42:04 +0100 you wrote:
> This reverts commit 1afccc5a201ec7c9023370958bae1312369b64da.
> 
> As reported by Marek the change causes a warning on non-PREEMPT_RT
> 32 bit systems.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] Revert "net: phy: improve mdiobus_stats_acct"
    https://git.kernel.org/netdev/net-next/c/1a9940317c1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



