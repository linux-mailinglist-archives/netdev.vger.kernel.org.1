Return-Path: <netdev+bounces-246791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EEDCF12F6
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61E1D300C2BE
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C152D5926;
	Sun,  4 Jan 2026 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/mFAmnU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF6D2797B5;
	Sun,  4 Jan 2026 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767551163; cv=none; b=lTUNldVvtnYHUrhLN5k6NITumHJb3I4fqnNPnYXIEA6bSEAjvF56+SkDXOZM65piffeMbhRAUXXh9hM/BjlwOI4LZJurkVsnQrgLTgJPSZEOc088mkoJX35W0wSa1Zbn8Is1QiNOpqAkyV4/6ltFvUaqVOXhq28aZIL4pYlUn5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767551163; c=relaxed/simple;
	bh=clhBWUoYeZWEDAFPY3adO7NhzlQ58GU2nLISINnoLAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rRjAwaWox0YbPkWcq0NSZ+6iyT8XAvmClCe2+Q7LNX/2H0bANdA3IPXPAciaKHO/+8lsfohFba37mNw3VjdOSX/kEKzH9BFKNiCccN7gdNSspQ8xf2fs1CetYNx/J5zvu2Erz3LMIoTRsUDw4pMvy2fHOibVZsBOQq7qZiu0zu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/mFAmnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6948BC4CEF7;
	Sun,  4 Jan 2026 18:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767551161;
	bh=clhBWUoYeZWEDAFPY3adO7NhzlQ58GU2nLISINnoLAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h/mFAmnUlB3ZKObDG165cFDz5+zZR39PryuuYkRn4kBImU8AnmuYCeB6axlA3VVRg
	 QNLmaGNItOX7pCsJZAfkxFIsep9KAqKrOhe4YUQv1bELQFKG2fOoNbLG59NwPC+BfL
	 vW1/UQgeLNVqamvBm7i5a6rl2uP8rTKsSUamHMumcZgI1gFcyRmcDv2iKbBdbQdf3Q
	 33NnXvZh33PI8ipszlAwY8pkJK1iOnZzFgMrTi9r5JBMvGo+ZEjkR6CqnHWzjuiXI6
	 FCWr6o4NNKSz6bxd63q5RzIZ3HuSv3Bc7fXSb6UMg4Aq6Y5mExEA5G7SbZn3+YqwRk
	 wfXJuejMNKDOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789E5380AA4F;
	Sun,  4 Jan 2026 18:22:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: mxl-86110: Add power management and soft
 reset support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755096036.142863.1452181499477671976.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 18:22:40 +0000
References: <20251223120940.407195-1-stefano.r@variscite.com>
In-Reply-To: <20251223120940.407195-1-stefano.r@variscite.com>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stefano.r@variscite.com, lxu@maxlinear.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Dec 2025 13:09:39 +0100 you wrote:
> From: Stefano Radaelli <stefano.r@variscite.com>
> 
> Implement soft_reset, suspend, and resume callbacks using
> genphy_soft_reset(), genphy_suspend(), and genphy_resume()
> to fix PHY initialization and power management issues.
> 
> The soft_reset callback is needed to properly recover the PHY after an
> ifconfig down/up cycle. Without it, the PHY can remain in power-down
> state, causing MDIO register access failures during config_init().
> The soft reset ensures the PHY is operational before configuration.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: mxl-86110: Add power management and soft reset support
    https://git.kernel.org/netdev/net/c/62f7edd59964

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



