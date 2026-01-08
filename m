Return-Path: <netdev+bounces-248256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DEED05F85
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 21:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC115303C9B5
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 20:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7B92FCBE5;
	Thu,  8 Jan 2026 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBeo4wED"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABAD284684
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902611; cv=none; b=Xz/n9LLfTCBR3/EOwq9gdQxFUSwvLKt9cVU14geK8WqlfC+H3pYUQELKl+WVzO8TwTZVhG8T72Coua20ZiF0h3Ay6ogYDMUhNddJ5pbMFK0OZVk/EMkahdwIViEgMkEY9xNRHQYeS4aITEyJEdOkDO/fcQTZWco3ZB6GpkjNJBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902611; c=relaxed/simple;
	bh=op1grXH4aQsI+Utv8k1YUMT1BBbhzcBfPen/VbhADrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r9gqxKKOVBUNRupWurne3hejv1VdDOk9Z3MVq00485Pl4OwLFEXvjqkgL5W7yrYjaLyysZtCa/KrvISN6edtzsOBWNiqona/YDfZ9v1acF5Ye6/5o6a/RkQ0pJrCSh6kiG+WWSCDzsKfxx+xUjnY/B2rl2910dMUNJ/SNwuUn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBeo4wED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9C3C116C6;
	Thu,  8 Jan 2026 20:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767902610;
	bh=op1grXH4aQsI+Utv8k1YUMT1BBbhzcBfPen/VbhADrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jBeo4wEDDM1UbT1bVAg2A9f5JsIvcMJG2UD38DnHJxwJOBUUKrjaRnFxgVrI+n1Vi
	 jm+wGTtm5vhqxOgUgB1j4H+p7HgWcRp72JSgJZgcLEIBzEcd+70WSo0Q77mXo+xOSX
	 xAOpxlXTRzpcQmniTUFqJ/Yzu2ux9rqKXPY4SE6o8HbMLvkx3ukXjloNw3Jcek3vKd
	 PhyrQw51mxWAuqZrw11KHxKmAx6dWWAYnvHef/YWCUjLpIiPcv2bXo4urnNVyZSm7R
	 WgLpzUgbdYI+y9z5DGYFRonQsjqWWL7oz1OeQk4eOUOOdrrYsK+jfRxPzOxwK7X76S
	 sSiwRAv6+6UYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78FA83AA9429;
	Thu,  8 Jan 2026 20:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add docs and selftest to the TLS file
 list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176790240734.3785418.10026517813889689793.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 20:00:07 +0000
References: <20260106200706.1596250-1-kuba@kernel.org>
In-Reply-To: <20260106200706.1596250-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 john.fastabend@gmail.com, sd@queasysnail.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Jan 2026 12:07:06 -0800 you wrote:
> The TLS MAINTAINERS entry does not seem to cover the selftest
> or docs. Add those. While at it remove the unnecessary wildcard
> from net/tls/, there are no subdirectories anyway so this change
> has no impact today.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add docs and selftest to the TLS file list
    https://git.kernel.org/netdev/net/c/56d0aea041f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



