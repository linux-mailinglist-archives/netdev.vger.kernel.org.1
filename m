Return-Path: <netdev+bounces-249186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA10BD155B3
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 523C2302C9CE
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C8341079;
	Mon, 12 Jan 2026 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svj3EGCP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA1340DAB;
	Mon, 12 Jan 2026 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251665; cv=none; b=U6wJPUXtgeIn4OVHE3MxDOHK0Qj4JJZkGDUshYzdILapdxDu2tuNrfy2k2Ef0QBLbwSR0JX9XI6hxdx8dVxesmM0RJ9T+eH6PZHl0IAWwyfDldbog8tlf4vxMTSxD7OOqRBZ7ggf9+NhbDcSulAZw7t61oY96Uu77GbGfPQF3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251665; c=relaxed/simple;
	bh=k7U6XE4P8/KYbGOb2zFtfsApeLHHAiP3CuB5iFN4w6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FqmclX2zaEo3wIIJBb9oX6TG0jbM8BJcPfjs2hW1PyKi4G592c7S1ukh37f36/IkmOOFhPcwjipwh6lgOV4mTnnR7ECcmjcLYO3c3nJjm0UlMrqzvffX4LDhlS4Isxrf4XGweIj9q2YKGA/cMlSKWpruowrCGgvTjd9bDMdtWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svj3EGCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2174BC19422;
	Mon, 12 Jan 2026 21:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251665;
	bh=k7U6XE4P8/KYbGOb2zFtfsApeLHHAiP3CuB5iFN4w6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Svj3EGCPDfuNEYP0Cybqqnx6ZvkmXYU/JQFPzf6nZJ4DOZco7xBEus9la0f3rCnRO
	 d4rJDvXi+sF8ShlnjiruBhGG74w/p91auQAuj5N8wqoxlOY1NncKOXfoqstP6KIK7f
	 VH/t1IGxvxg/u0SYBFyQgg21BRqJY+e2b+uGRHQPfz7Dip6NsKU2/R6XGa0lcdDIeN
	 pLA2dk3QXNHIqY7UYS4L+YcvgZMq5MlA0eEV4E57a6os6ARotNH3wu10dZ8zeiDF4P
	 6zm4xmJUP6ZVS7KTbihNBuZ37A/nRD753erH9fbL64u+t/VLiyGTYt+P8FjIXKJ3eF
	 7dBIOLmEKJOlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BAF7380CFD5;
	Mon, 12 Jan 2026 20:57:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: convert to use
 .get_rx_ring_count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825145877.1092878.14865875892594291102.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:57:38 +0000
References: <20260108-gxring_stmicro-v2-1-3dcadc8ed29b@debian.org>
In-Reply-To: <20260108-gxring_stmicro-v2-1-3dcadc8ed29b@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 08 Jan 2026 03:43:00 -0800 you wrote:
> Convert the stmmac driver to use the new .get_rx_ring_count
> ethtool operation instead of implementing .get_rxnfc for handling
> ETHTOOL_GRXRINGS command.
> 
> Since stmmac_get_rxnfc() only handled ETHTOOL_GRXRINGS (returning
> -EOPNOTSUPP for all other commands), remove it entirely and replace
> it with the simpler stmmac_get_rx_ring_count() callback.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: convert to use .get_rx_ring_count
    https://git.kernel.org/netdev/net-next/c/959728f9931e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



