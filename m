Return-Path: <netdev+bounces-211121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 559E3B16A60
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 04:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A62B18C6AC5
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 02:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8492A23771C;
	Thu, 31 Jul 2025 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP3N9pZx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5948C23716B;
	Thu, 31 Jul 2025 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753928394; cv=none; b=G3pXDJ6AmeFghK/Wm3DWH05/zmqv1PdKV99sWyIy5DuBjsQSq+gQUzmsa8vqxF9NgKATx2+Nm4aSc65YE/XPUTuuRr9melPR7qTWgzp5Kyq9KMjzPy5vbEzdxzKN1djB+f+5vvHJgO6Ke1faBLYQd3C/OYoioaR+HDRnOKcJoL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753928394; c=relaxed/simple;
	bh=rKXAi/iYEhenqcrAxGqXvVJVF6wSFQSHqOQ9ox6Y6+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GfFVC82JBppAQoB89exBQ1tIZrk73WjS41jvG6t8CqQYHN0npulx6m1xGIDKmc1JSTFxbnHogLAS9hKhj2dSZdAGU7etWP2YOf29bGTbt60gJBvqdxuGX7b0wOeTV9qL6E+T/G6QdEDgMkZskjqIEMCV/HL2/0MfoDpHfSUDQ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RP3N9pZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE206C4CEE7;
	Thu, 31 Jul 2025 02:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753928393;
	bh=rKXAi/iYEhenqcrAxGqXvVJVF6wSFQSHqOQ9ox6Y6+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RP3N9pZxc2GoNOIXV6FKrDzqOJdesCPgqGSbJiW50we2G3N9bWaJG9+ffjWJFo/5f
	 Fdk3kk0aE8QxXmJhkobXv5kIU0/MVcNQtghPo/jZdikqu1V16r9zlFT2czgrbzmaiA
	 QV2zfzEzz1y6h9mU4zW+Q0Yr+xLH+Zc1/Wmm8ims86uFHrp2sZ8/NJc4OZDV469gQ7
	 Zt9yWTVh9FetmzObASmeBfRg8wcRPSgTM7fwmoKDBHuxr1jTxD+DBvGxu6Xk9BogBh
	 B1Abs7Zh0vFKeBOqAIfaxub5/vGw4/AHOwr9+p0nMai9Daw8dz+nbYVWHooYBOeCHx
	 ThE0CchfpVTyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD79383BF5F;
	Thu, 31 Jul 2025 02:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net resubmit] net: phy: smsc: add proper reset flags for
 LAN8710A
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175392840975.2582155.17577246322097658956.git-patchwork-notify@kernel.org>
Date: Thu, 31 Jul 2025 02:20:09 +0000
References: <20250728152916.46249-2-csokas.bence@prolan.hu>
In-Reply-To: <20250728152916.46249-2-csokas.bence@prolan.hu>
To: =?utf-8?b?QmVuY2UgQ3PDs2vDoXMgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 buday.csaba@prolan.hu, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Jul 2025 17:29:16 +0200 you wrote:
> From: Buday Csaba <buday.csaba@prolan.hu>
> 
> According to the LAN8710A datasheet (Rev. B, section 3.8.5.1), a hardware
> reset is required after power-on, and the reference clock (REF_CLK) must be
> established before asserting reset.
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> Cc: Csókás Bence <csokas.bence@prolan.hu>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net,resubmit] net: phy: smsc: add proper reset flags for LAN8710A
    https://git.kernel.org/netdev/net/c/57ec5a8735dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



