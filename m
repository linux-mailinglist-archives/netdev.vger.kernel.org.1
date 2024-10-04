Return-Path: <netdev+bounces-132276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDBB99126A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B461F221A7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322C41CACDA;
	Fri,  4 Oct 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh2bMoZi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9F1C3055;
	Fri,  4 Oct 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081629; cv=none; b=pBVBLzEea5fWcxrAfcixSgYHZ2LRQ+e7NmdlhilrpdtmM1zyunCZyn+mJXfQRVs3ar6XFVwd22tdx1Yo04vJFMN8iY/3LumOzs43T5bHk1ROR6G4jrkde3E+sAima5Tpg8sqSafme1I0ZZ+05/PdBQYTungghqZpIWOM4Uk+6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081629; c=relaxed/simple;
	bh=2SV5peRguXD04Q0jTwaxBzq0W754TpYET7R0jefa86k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fjZgsdDaP47p0cmQCkVZygTKLmTsPs0tauIOpyXaDFga7xAEV02LFpYxR0zuiJQ9HrMajizhDYlXzWwK5dFar+oH8VhJdrdqICV8a0tkPzSi6UOCWeRsPHOlUOw6c2tID+2HEGjdQkJn1vpo2UwJhHDXyAZdpJWnJS/HW8wPxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh2bMoZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D22DC4CECD;
	Fri,  4 Oct 2024 22:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728081628;
	bh=2SV5peRguXD04Q0jTwaxBzq0W754TpYET7R0jefa86k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hh2bMoZi+L62CFy9Wll6zYy0kRCcf+ipVE8WWsedhhT77+RxljRpyb8c6Eo4dMcN2
	 WvdHHCNFpVdccnmITzZLtoPlraxdYmeQEnAq7b4j/CplnSMWBjvc8E6CZtjE+/Awt1
	 kqC8ro7G90YzRpTq17Hw389awq6PlFdM9XMpK4j421eBwapuw5nSpFvJNo0vAHKkvx
	 h/UWwHvbzOLDNYokSYYR84DaSNl1XG+dUT9iTftE8VBBn2e+NPioxpP0TWlIxa2BWw
	 LcHUG/hFoqLOZtzHvWmi14ae5ZnJhRtLkA9i6k8ahC7XdDnVPdU4jPo0RrOfGKkWl9
	 OFffinXoua76w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5F39F76FF;
	Fri,  4 Oct 2024 22:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: Fix enabled status mismatch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172808163225.2763206.12562210220343838241.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 22:40:32 +0000
References: <20241002121706.246143-1-kory.maincent@bootlin.com>
In-Reply-To: <20241002121706.246143-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: andrew@lunn.ch, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kyle.swenson@est.tech,
 thomas.petazzoni@bootlin.com, o.rempel@pengutronix.de, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Oct 2024 14:17:05 +0200 you wrote:
> PSE controllers like the TPS23881 can forcefully turn off their
> configuration state. In such cases, the is_enabled() and get_status()
> callbacks will report the PSE as disabled, while admin_state_enabled
> will show it as enabled. This mismatch can lead the user to attempt
> to enable it, but no action is taken as admin_state_enabled remains set.
> 
> The solution is to disable the PSE before enabling it, ensuring the
> actual status matches admin_state_enabled.
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: Fix enabled status mismatch
    https://git.kernel.org/netdev/net/c/dda3529d2e84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



