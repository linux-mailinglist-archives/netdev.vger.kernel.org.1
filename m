Return-Path: <netdev+bounces-270967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB/rLt9gwmmecAQAu9opvQ
	(envelope-from <netdev+bounces-270967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:01:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F44A306162
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17A273020A68
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6633CEBBC;
	Tue, 24 Mar 2026 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL445Hk+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED236403A;
	Tue, 24 Mar 2026 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346421; cv=none; b=L+By/zau0f2BRtCtme9KI3ismE2X4h6LBtnvxuGS7jd9vckKZAMJF3wyI1eGkkIAoEYWpWQNFuepX2pblSQEDKQ81p2O/WqkRz6wYoblPlR27cyWYhlJBLxS4MFB4S9hLTfIsxmjj2ggx52TXLU+r/bbfxGRHL01AbqfZU7SxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346421; c=relaxed/simple;
	bh=FF10bgnAr1bNVCYr6sT9/rorDBSazK3xDECdUnJhef8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qi5mlHG7oHPE7Kc1eop6jkRnUQMX2v7dH6zVKfuXPttRyk2/rBFbAjgsGWQwG7xQhYSS+9VvWA6ES4qkKIWuewBnwZmpWzpSlOCDxmScySutIu/AzV4zviXq6GLAI/DUTZM+2EB7cnYCkRWGwFcPj81GTz/zmd4+HX+6AyRqeHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL445Hk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42231C19424;
	Tue, 24 Mar 2026 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774346421;
	bh=FF10bgnAr1bNVCYr6sT9/rorDBSazK3xDECdUnJhef8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WL445Hk+7okv1+DebKCQuzhCdlzYixyKJm6GtX8Hf6wjtqLFR0Jz++ny33TgFr16y
	 jaZenvyI+icq6iHfvd+Rpnjqvhk1683SMeHAuzcwvc/X4On09+XW5t5l8zjAHwUPfO
	 vLl6uGb+IR2IhZ2ja2tm7UmkzSvZjzXrzVtwovGToiYMm2BrWf45GlXQBgzGqlgDG0
	 ErQ59/5qkpdt2cqDcRJ4vgLH+z+YesaZF+SNnvHx0W3CvyYtEU+keX+UhhmHF0Sm09
	 /G5puybyWO1aQy81euw+2/cGlOpxfs963vryzZRb6/2J2lDiQjBY9QrQa0KoIvcQKx
	 4K0IsMrfIfPfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEFB3808200;
	Tue, 24 Mar 2026 10:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/3]  amd-xgbe: TX resilience improvements for
 link-down handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177434640929.598311.7913943645048175777.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 10:00:09 +0000
References: <20260319163251.1808611-1-Raju.Rangoju@amd.com>
In-Reply-To: <20260319163251.1808611-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270967-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[pabeni.redhat.com:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F44A306162
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Mar 2026 22:02:48 +0530 you wrote:
> This series enhances the AMD 10GbE driver's TX queue handling during
> link-down events to improve resilience, prevent resource leaks, and
> enable fast failover in link aggregation configurations.
> 
> The three patches form a complete link-down handling solution:
> 
> 1. Patch 1: Fast detection (know quickly when link goes down)
> 2. Patch 2: Quick response (stop TX immediately, skip waits)
> 3. Patch 3: Clean recovery (reclaim abandoned resources)
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/3] amd-xgbe: add adaptive link status polling
    https://git.kernel.org/netdev/net-next/c/31b2d4e00260
  - [v3,net-next,2/3] amd-xgbe: optimize TX shutdown on link-down
    https://git.kernel.org/netdev/net-next/c/0898849ad971
  - [v3,net-next,3/3] amd-xgbe: add TX descriptor cleanup for link-down
    https://git.kernel.org/netdev/net-next/c/b7fb3677840d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



