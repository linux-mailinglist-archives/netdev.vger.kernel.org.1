Return-Path: <netdev+bounces-219752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C01B42DC7
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC8B1BC29C7
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E9831E0EF;
	Thu,  4 Sep 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR45WRJM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4031354F
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944007; cv=none; b=REqc2F0HDA6/GLqWap8Lc9xGVN+qkpQPZ6OXKWQZk7LgWnd0h01/WWiP0TO2aQoeWdKRepw9P+7B1xVgCsCvPx/epZX2b8q26kXm1vJJaSybcQ7279lrwuEPQ7VWBDGwaOGY1KNWVJLEDW53cr0hrXTtegzv1ao9EcYBzlpm8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944007; c=relaxed/simple;
	bh=jDBosg6fZtbn+DWrJJvmGpHYYPJCN7PmkmwqBMP8oHM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j0c5fZEgIgtkLF02M8fPY3m6MqndH+prCSrqduJ9QdSuNq+xB6DUH426XrT+BMH3LiesGDmYF0f/0NoQI2Dja1jf5gD+6tSmmrBH8/JqXjyH+V+sWd4l86Wgxh+F6yLZ84oWtWmwD1OYqWPgyhX+FE2cZ1Sok0e9IjTcbIup+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR45WRJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD174C4CEE7;
	Thu,  4 Sep 2025 00:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756944006;
	bh=jDBosg6fZtbn+DWrJJvmGpHYYPJCN7PmkmwqBMP8oHM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TR45WRJMog/Gpbt+LtoYztrw46jGtSv9fPyJ3HXjImuu4jdtr+vLdZ7vyxqh1DLz6
	 fg5hEtiixw3YB+D6Ns9JQO5dJ4SNC+5fCR7re1nZDFusJFuP43/+5uivS+9XZ5e/mO
	 DgDYkFAp/G39C78HiBYEU+uutD0i6piHL9RtciAkMn2/ctqrkCrgVlvVcT/vBnu0ws
	 y2ROi3eZCeI7Wwhmvi3DPfxeNGL7kj3TajrZmTg3Jt7W3apZEUCyTjmy/7KB/M4VsW
	 ewxBPj4Qa0p2k7LvUYgUJCSeQL9ZD8/Gvf/HFIpOwiKMNX6AQDuiTNAr1OGb5iYsUL
	 iYJtzyvxLiz3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD4383C259;
	Thu,  4 Sep 2025 00:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phylink: move PHY interrupt request to non-fail
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694401174.1242165.9921011991543778872.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 00:00:11 +0000
References: <E1ut35k-00000001UEl-0iq6@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1ut35k-00000001UEl-0iq6@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 01 Sep 2025 12:52:56 +0100 you wrote:
> The blamed commit added code which could return an error after we
> requested the PHY interrupt. When we return an error, the caller
> will call phy_detach() which fails to free the interrupt.
> 
> Rearrange the code such that failing operations happen before the
> interrupt is requested, thereby allowing phy_detach() to be used.
> 
> [...]

Here is the summary with links:
  - [net] net: phylink: move PHY interrupt request to non-fail path
    https://git.kernel.org/netdev/net/c/3bc32fd9db47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



