Return-Path: <netdev+bounces-264159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P5jNuvxqGnFzQAAu9opvQ
	(envelope-from <netdev+bounces-264159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:00:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAEF20A621
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 04:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4514F305BF7D
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 03:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B2C274FEB;
	Thu,  5 Mar 2026 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiiHWq29"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96490274B5C;
	Thu,  5 Mar 2026 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679619; cv=none; b=qUuC3cLRPfT5G2T/AHHMCdS2Ur9J512gckI/bApGjzyCgy6DSZQ1NL5doju0l1XXYJuxlKOtymY/vmQUlbhY+xGz0l7J90WN6M3lcLAwD80L5JqOzviSlu9topzFyMMahcOtLqyNKLi2UHGX1rryVIMra3k3DgD6adCtPsdM6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679619; c=relaxed/simple;
	bh=JVQKYMdfJA02hlgSDIe1GxjMmQ8PHcdpmXSoyehQcEg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c3tUjG8+l2z5AAMaQ97zxUacdtFMj3hAUkCQIsiWaTgGNxEQx1WE7NNsm4787/+aYY8IjjSSs64dRpiyJzrf7pL+6LQNiQFRBRqUgJncST+fWyI30smjxQBhyw1yZpTIaPErW4CWO78xE/vV8vobbFGHuHhSBYoVF5APTIkD6RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiiHWq29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0FCC2BCAF;
	Thu,  5 Mar 2026 03:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772679619;
	bh=JVQKYMdfJA02hlgSDIe1GxjMmQ8PHcdpmXSoyehQcEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NiiHWq29qw7AUSByTtd3njDovZAFuZXbzLU+TQLU1Q4mzC6AzA9s/1Eot7Hd+q7i/
	 3JxKjjC8s+jBPbkp2vjSJFQbYjbMzADpv9NLyQTYphgtPZpYnRY3Q9zUqJf+TiDYSE
	 HNAFmMZGoL1/QN3OFAgYXpOBQHHKlcxlR8zVg574vH0It+7lS35pOHh4uP8jTa3nRP
	 0idc5CBJl0yGR6EFwrUcuk3x6GFs8w0bDCuNiO85Nc/eN67qaNN0P9Crm3G+E73LCG
	 MlGzYdj2UNiF6wQBo0JIvsis48XI8RPXMOcAKIYbaW4lfjVeIMuizfHLYSa3fDYsic
	 fH8W980YgHC0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E843808200;
	Thu,  5 Mar 2026 03:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: rss: Fix error calculation
 in
 test_hitless_key_update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267961954.2494418.16923312919895108395.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 03:00:19 +0000
References: <20260303202258.1595661-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260303202258.1595661-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 willemb@google.com, gal@nvidia.com, noren@nvidia.com,
 pavan.chebbi@broadcom.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: 4BAEF20A621
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264159-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Mar 2026 12:22:58 -0800 you wrote:
> This test verifies there are no errors when a devices RSS key is updated
> while traffic is flowing. The current check is a no-op since the last
> sample was subtracted from itself.
> 
> Fixes: 933048fec4dd ("selftests: drv-net: rss_ctx: test flow rehashing without impacting traffic")
> Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: rss: Fix error calculation in test_hitless_key_update
    https://git.kernel.org/netdev/net-next/c/f85db97bc5d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



