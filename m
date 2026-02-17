Return-Path: <netdev+bounces-259018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEEANMtalGmUDAIAu9opvQ
	(envelope-from <netdev+bounces-259018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:10:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0014BCCB
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3239C3038288
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642AE3382D0;
	Tue, 17 Feb 2026 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYS8QrJM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF1338584;
	Tue, 17 Feb 2026 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330218; cv=none; b=h2hC+vFIKT98WM+vt3jwKwuhqaKTNQnNoVnVlJlvWaZxWpOkzgBPHIUzRHmuqGu4wrMdkVF22w1TlgcYwmkrOgK8nC+wfjZK0Umk9EJRALYv1n63zFlSsySVZsNL7bRjWT98c1GmO+6ELP2KbviYTXswKYLtgGnJzq6FP3jbTyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330218; c=relaxed/simple;
	bh=zO/5AjSr7L57JMW9SFPO8FSwfRar3Pqza5QICyZloRA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mMWErsDp1gcBoylEiLHRSDGzUABFGA8xRoDcAXPWbPDbSmAwYrDSDzxNbltzwIEjbL7MXU9ngrJD3OX7KBrAAd3nhkEgheKZP3Rn9bbzfF6w1Y8/+ARpUs0J04reftQaHujxL1BUyqXE0LpleZfsDsvyEuEaUkO9cJFXImUoNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYS8QrJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F908C4CEF7;
	Tue, 17 Feb 2026 12:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771330218;
	bh=zO/5AjSr7L57JMW9SFPO8FSwfRar3Pqza5QICyZloRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QYS8QrJMH4qUklowNQ2PXAiNXq+SFaW6xJtrLaRJfitRr3nkn0nF0OGYi7IV8lTPF
	 cODceGXCrjNLfHuIzfvZBibM0Xr5ptCnhPYB73W/4QPA6YB4h2jwM1GCxazDooyrHA
	 mgfUGyRX9DRx44hYA4tRgv9/0ZILWjTdhImlByShBjfeqnkfojESfi2ieJGBaFG0/6
	 yAphQlFTr/DkkCSN8qSuy1f9nw8Uy6+gCMG9lInJT38mbWO8yCGHBct/H9crnYD9ZL
	 kMs5V11+Az6v7m5fzkZFTmlLDA1NeUT7xtLXr5RoBsx2De8DQGjs0R8RDK2KgGlC0D
	 6S2B8BGbR4t2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 480E0380AAD0;
	Tue, 17 Feb 2026 12:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: bridge: mcast: fix mdb_n_entries counting
 warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177133020982.47903.3693855101556171993.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 12:10:09 +0000
References: <20260213070031.1400003-1-nikolay@nvidia.com>
In-Reply-To: <20260213070031.1400003-1-nikolay@nvidia.com>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 petrm@nvidia.com, bridge@lists.linux.dev
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259018-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36A0014BCCB
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Feb 2026 09:00:29 +0200 you wrote:
> Hi,
> The first patch fixes a warning in the mdb_n_entries code which was
> reported by syzbot, the second patch adds tests for different ways
> which used to trigger said warning. For more information please check
> the individual commit messages.
> 
> v2: fix 2 typos in the selftest, no changes to the fix
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: bridge: mcast: always update mdb_n_entries for vlan contexts
    https://git.kernel.org/netdev/net/c/8b769e311a86
  - [net,v2,2/2] selftests: forwarding: bridge_mdb_max: add tests for mdb_n_entries warning
    https://git.kernel.org/netdev/net/c/a8470953b4ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



