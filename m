Return-Path: <netdev+bounces-277476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKyTJT0h2WlRmggAu9opvQ
	(envelope-from <netdev+bounces-277476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:11:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 341EC3DA288
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBCB0307885B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BCD3DB65F;
	Fri, 10 Apr 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckTOt2PJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFEC3D902B;
	Fri, 10 Apr 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837218; cv=none; b=tvjnP0fmm5WGqIjEaEVEJkZb6zPuYS/gQbFmmz9Dm7EgQtRfrM16F0u8r7+r8TEckFSYGX7FBmg5IJXU1DGumJeyWmIAMaQURQIZF4fuo9cUqqyp8PgJjT6+JqygU3pIyD1eLy6+FyJhajE+lssvYxUiMCBV57ajDmF0+hINeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837218; c=relaxed/simple;
	bh=/VwSLCN3yFd6Y+/ecsaQbeu1Ddy5779aPkmo391iXgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n+ubkAPJ2/QFGZtoCr0bTzTtCx8Fn9AftU7xfDru23mgailSoVcdyAJ3ck89jvMPBYryw27vAndCQG4YTmKynd5Lt1eS6QEU2Hjgfmw/mSAWcIn6KMJrtLttPYtpOPGVz6aviJ75wwhMQa6oZKJ+f/y4QGw4/UTVvz9DQlaT7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckTOt2PJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595EEC19421;
	Fri, 10 Apr 2026 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775837218;
	bh=/VwSLCN3yFd6Y+/ecsaQbeu1Ddy5779aPkmo391iXgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ckTOt2PJsRcUiuEVlCDikXeqkOz31xmKUwOnUn6vm+qyJo4KsMn1/Fz8HoMqlKn/H
	 q3ijNzQzPTJCJxHUJfHZWoPNxUgAYu9y5x4p6PNTB3mwv2qyiDyQoP2wl6+KWI5o/9
	 kstyNjoSbFc21MG1lqnmusMEB9XLJmAap09JOi1orr2vbACM1UTo/hTx9Z5PU2fq0Y
	 JerzpCNsOkmbIaQWuC0HzxPHMkmg6L3jcZ/I3hnlez/witcCiXbSKRE4wIJfNj+II5
	 br553ybC6kIRuJxx1FrSzCZvaBBI9GUdqAJnMGH8maLfsBG1wYMGXSOZHJbuRxso2D
	 5dL2UQeDjMJ/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC6D3809A87;
	Fri, 10 Apr 2026 16:06:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-03-25
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177583719304.2534919.9524134891273382307.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 16:06:33 +0000
References: <20260325194358.618892-1-luiz.dentz@gmail.com>
In-Reply-To: <20260325194358.618892-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277476-lists,netdev=lfdr.de,bluetooth];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 341EC3DA288
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 25 Mar 2026 15:43:58 -0400 you wrote:
> The following changes since commit c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f:
> 
>   net: mana: fix use-after-free in add_adev() error path (2026-03-24 21:07:58 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-25
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-03-25
    https://git.kernel.org/bluetooth/bluetooth-next/c/aa637b2cf303

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



