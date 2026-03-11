Return-Path: <netdev+bounces-266435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OQaEN/asGmHnwIAu9opvQ
	(envelope-from <netdev+bounces-266435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:00:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A10E925B3A6
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB364303433E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069C8346777;
	Wed, 11 Mar 2026 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5pSz2cI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D843633F5B3;
	Wed, 11 Mar 2026 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198029; cv=none; b=fPQKpY4aM13KtUs2MOjVdGTUHWPd/h1rZr3d9sJPKbMjqELsIABT3kIBXIM7VnLVEy6F/QcooaBTcmorneLOH9nQJlvm+912/jKXNq7ljC/jkwqI2mSxcedlfzb1Ks7NJ4zKNZFo02LQa4sEbjO4QcjVc2pYKjRRp2aMv9zEZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198029; c=relaxed/simple;
	bh=YjBu3ccKblFlbxjxX63EOOWdru0qv/4ykvXO+fdeiLc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IazX2CikorO8HHLk8yP7OxpN6ZKWvTSc/TgSX1L0RucRFdRwf8WvMKlSmiRnvC5rvxuELcZypjzBJbyhUA4Qo/TzGuTmy/wnwD1djc+blM+Av2af/1F44cv3FmL9tgB7tUHg1uvPAZZ99XagyKGcmoF76ld4NWQJ0fLJzh6Ba2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5pSz2cI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB9BC19423;
	Wed, 11 Mar 2026 03:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773198029;
	bh=YjBu3ccKblFlbxjxX63EOOWdru0qv/4ykvXO+fdeiLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F5pSz2cIAGLhcvRiab04DTuWMm/yF0utfmGHRBwtj7fA3THI0b8xg1qq34s5xt0Uy
	 FYwR+y6O2Yo4DF4kHBmDjQeslmfV4Z1qqdQQEYxjLX724ZyV5CWgRK1JA9B8eQPJ/u
	 bvouA3ptxGYr0KnOw0lf+A8Q/MOEQDca9NLnIyNi/oJGb2lUnGu2KazpScjJ690E0C
	 2VlFaq1Cv8S1PXjMEWnaPn4BSQ9dbRY0T8YCKCymlVxUgjXbuBUjm9ZEK+LkLQV4rt
	 wD8fgTcKTlmWFBOe0cS7fvrChwLjhIiXgzzSCmKGjR3d3vZZlO854/O5SGK7waaeVA
	 vSorgYVLIE+Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE8A3808200;
	Wed, 11 Mar 2026 03:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] amd-xgbe: Improve power management for
 S0i3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319802579.3019253.7007480805177156476.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 03:00:25 +0000
References: <20260308092851.1510214-1-Raju.Rangoju@amd.com>
In-Reply-To: <20260308092851.1510214-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
X-Rspamd-Queue-Id: A10E925B3A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266435-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 8 Mar 2026 14:58:49 +0530 you wrote:
> Improve the amd-xgbe power management handling to allow AMD platforms to
> reach the deepest suspend state (S0i3) when modern standby is used.
> 
> The first patch cleans up the xgbe_powerdown() and xgbe_powerup()
> helpers by removing an unused caller distinction and aligning the
> ordering of operations with xgbe_stop().
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] amd-xgbe: Simplify powerdown/powerup paths
    https://git.kernel.org/netdev/net-next/c/fe81629217e0
  - [net-next,v2,2/2] amd-xgbe: add PCI power management for S0i3 support
    https://git.kernel.org/netdev/net-next/c/7644e76956ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



