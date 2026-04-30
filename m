Return-Path: <netdev+bounces-282914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCRtAbV482mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:43:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0F54A506C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98ED73035828
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A33D36308F;
	Thu, 30 Apr 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg4hrGft"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA292346E60
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563658; cv=none; b=lQ4BqFIPwEmocDKXWOO0kvXqnypPWCyS4slZjpahM7WVnUlZYYWM/Ts08WfqB36MyTZbGTGPrxx13p0lgu4WDJXgQROmmff8Jlw4DqBGHh0eW0/8Z4cq7rGTuh2m7UNj5IUfunD0BgVRZ9FJP1472OVEC415l9JYS5jKAlewhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563658; c=relaxed/simple;
	bh=wEUhlz+OS5n6DRK+dOVeP47D78YjgqTAAQu8saLWVL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CfNOLtl0BjWPoUAQjGXpZlhG79yDzur7f6xqIJeYgUOG7fs1NAE6+CRmUI9M9K8J4Bd8dWyWMVT+YH6PnTLBDfGwhxzEthP2rGHoWDriONZaUNPCjMxdPcT5NtZPsrv6AC9boR2YUS7udctsJarWwHn2rJ3m+iicbv/aVD0zc6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg4hrGft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A964CC2BCC6;
	Thu, 30 Apr 2026 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777563657;
	bh=wEUhlz+OS5n6DRK+dOVeP47D78YjgqTAAQu8saLWVL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xg4hrGft4QYOESRYfpGw72fmTaaUrG7KGE6QFeE/mCm/iOh7+uJ2F1duZvOlA942q
	 jkYNFZRNc5CgoENbVQocQPbA65g64mIYZEz8PPgq2mHWDH5wDXCDlAzIXHd1/GvMOc
	 qrDeiZZglQqWHnZDHdotlSlqyB5YVLkvkujxsHiYZneRFqzQNILjDGZLKSOobqDEHT
	 BwtPkNZ8JK2G/2HrrRC8rAFYsDLY57RfQdq1U+SO/a9rLkAIvp1/NOM3QrVS4+bGSS
	 ly++4NTMG979pt5mLvpw3pqbcbnxxX2hzjNXj4uFXMoeWsDz6nGTs+vg02lcrbqfgx
	 uYFHf0heKhnxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD27380AA5D;
	Thu, 30 Apr 2026 15:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] bash-completion: devlink: Fix dev
 completion
 trailing colon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177756361204.3063728.4978153431256884243.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 15:40:12 +0000
References: <20260426115139.712959-1-danieller@nvidia.com>
In-Reply-To: <20260426115139.712959-1-danieller@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, dsahern@kernel.org
X-Rspamd-Queue-Id: 8D0F54A506C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-282914-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sun, 26 Apr 2026 14:51:39 +0300 you wrote:
> Cited commit extended 'devlink dev show' to print the instance index when
> the kernel provides DEVLINK_ATTR_INDEX, printing the device handle followed
> by a colon and the index. The completion code was using the raw text output
> as a word list, causing the device handle to be offered with a trailing
> colon, e.g. "pci/0000:01:00.0:" instead of "pci/0000:01:00.0".
> 
> Switch to JSON output and extract device names using jq, consistent
> with how port completion already works, to reliably get only the device
> handle names regardless of what additional attributes are printed.
> 
> [...]

Here is the summary with links:
  - [iproute2-next] bash-completion: devlink: Fix dev completion trailing colon
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=03b33c7550e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



