Return-Path: <netdev+bounces-238811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF0C5FD9F
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8B1D524127
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEEA1D63F3;
	Sat, 15 Nov 2025 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks1CfEmV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110831A5B84;
	Sat, 15 Nov 2025 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172144; cv=none; b=jMXgZpqw8yIQAUSbKlJc4QcDhgBj8950eFiEvdp6yw+GhyF/iPNMHsFeYJMF0S8LEGMVApcOAD9cfgsBZV8crvVd/DotPHAc3sStyx+Am6hqkXtN0sKMxFvD0Hj0YSwyuMVsXbhZKhQcTmNanqScqajgyRA2no0GwYikDR9kbZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172144; c=relaxed/simple;
	bh=LpNKHfYbBqQRdZtuWZzBmhgYh6G0sh9ZyVXoNd1wtLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V8XKCkes2ONo4Vcs3t5+3p987mx/moDKzx3Ry8UbvW5m8i7JdC+aW/6oCsxO7Som9mA30890zqUTmEycs0uKOZuFRRbnQIW6BlkfrKcSn4DLbBVlyihuDBIbpux281I4aI/+h15mGOinne8AkY3Sfm7dtQy+8zb8FDlgWUfL4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks1CfEmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EA4C4CEF1;
	Sat, 15 Nov 2025 02:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763172143;
	bh=LpNKHfYbBqQRdZtuWZzBmhgYh6G0sh9ZyVXoNd1wtLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ks1CfEmVMsxzAr193A3bIu+o9AIGoYEQZG+yU1hq36GogM/ncu/8XoN0e6QIwTXST
	 dhlRwp1SSO/nf6Au4kBIs5YqAJIyNmV3WHotMHqCXz/lQYQpfZO7bqEiI2z82aCaJE
	 YdtVnS5jyODtzb999GfjRg28P66f+OS/wNuvfZw2NwXUJ2KIz5y7W67CrHoj3ThZJO
	 RMPmBicZHTn0yNvrlRtffSLQZTp0F0cHm3I6+vmWmY6k7t4ar7IK3vdQoqrGl28ZZa
	 Tg/O+Jh5FYeb+WJUcVqJjmeGIblRBotIabaAryy1UVsBp5sYVL+t/Z86k/TIs+HmdV
	 1qyYlhRCGlTzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D273A78A62;
	Sat, 15 Nov 2025 02:01:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: hellcreek: fix missing error handling in
 LED
 registration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317211199.1905277.16734072781178756805.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 02:01:51 +0000
References: <20251113135745.92375-1-Pavel.Zhigulin@kaspersky.com>
In-Reply-To: <20251113135745.92375-1-Pavel.Zhigulin@kaspersky.com>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: kurt@linutronix.de, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 16:57:44 +0300 you wrote:
> The LED setup routine registered both led_sync_good
> and led_is_gm devices without checking the return
> values of led_classdev_register(). If either registration
> failed, the function continued silently, leaving the
> driver in a partially-initialized state and leaking
> a registered LED classdev.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: hellcreek: fix missing error handling in LED registration
    https://git.kernel.org/netdev/net/c/e6751b0b19a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



