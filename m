Return-Path: <netdev+bounces-292900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHtwGWfZGGpDoAgAu9opvQ
	(envelope-from <netdev+bounces-292900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:10:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D52C05FB9C5
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25E28303AF1F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27266FC5;
	Fri, 29 May 2026 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLNClGAz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F917D6;
	Fri, 29 May 2026 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013411; cv=none; b=HD4kUFxXoVbtFqOcINXy1DGFrOjG0jbHfMDD2d+R8GQlW3x3oPKDMjFOazowVL2YQKum+y9mWxz1NEBPTwIaPMX99Dni441vSGy7eCXQwxbZAWniadfb1k11TBoTEMS8ck7WCNZiz74b55FMoUlP5/88Bk0OF7sww/5ItU0mTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013411; c=relaxed/simple;
	bh=YVXNpvTMQ4pHPjqHlES6U6VBq70HuLFkYtQPJJdF4gk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pUNd3Fw6Jiq6MzJQ0vJci0qIEzsRmL8PDNnpE5xhq7reGZoo8BS2I8LxSGDG+2EmPAxkR6JqU3LMMzv+7LptGnYNVcgQviZaTw+8bzZu3Mv0p8AdXYdDRzfwZL/uk1YBMwr1i+wBQsYLA4BNnv3La0xDO1AxpQFwmfhmjrs2NCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLNClGAz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9C51F000E9;
	Fri, 29 May 2026 00:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780013410;
	bh=6dSarYnx7umW7O1HKSVDoVjymXPLhOUzkl9YdCniDlo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hLNClGAzipJ65KiTfZ1OfaBo15neta7zODjZekR8TCVjXnZQHEKY6YiNVTo93d37u
	 MgSpJP9YzZrdl0HJMfE0njgtY0h/kwkFDzn3DKCBMblLEuIxYjsNYXQuSZHS5yGNqO
	 jCpDwrDpm3q1rcye73D0+Vf1AvjAd9eNqztEC54/bMnt72hcD4jmZXFMLKiIKfar7U
	 nBUmWmvSuqLBJM0zVNKQc/65dwix9Vk4Lsz6If3ubZDQIGrLwFDpXpOXvEhkthyWO5
	 0tYkXtMXoG0ud1YObTuNPCyG4A8muKLUsaaZrOCPIHbZ7uM/Edxa5A18LNu8E2IOnQ
	 XSpDWOv6q3Yuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0EB13811979;
	Fri, 29 May 2026 00:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-05-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178001341465.1565998.16734911486872086462.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 00:10:14 +0000
References: <20260528131839.462344-1-luiz.dentz@gmail.com>
In-Reply-To: <20260528131839.462344-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292900-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: D52C05FB9C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 09:18:39 -0400 you wrote:
> The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48e022:
> 
>   Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-28
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-05-28
    https://git.kernel.org/netdev/net/c/2412591cfe66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



