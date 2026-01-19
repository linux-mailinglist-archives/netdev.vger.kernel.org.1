Return-Path: <netdev+bounces-251225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7965D3B56B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCB8B301D320
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C56531A54E;
	Mon, 19 Jan 2026 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aArkZcxb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C22C11F0;
	Mon, 19 Jan 2026 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846816; cv=none; b=BKLCDMOaJJwORXMxea4dKeCsWXX0EYM8AHcvnHREiwUaEkMj8lJtsuQ12ZCJYz9pVc1XovXPJCpLAwDLBNl+f34LUddM4NjZQxcsHvYI2BAC0G3CWwRJ5Wkfnkt/5UO00OquJmGKbJapIj0gbl9wEvqjlP878CBNxbD0SoPZiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846816; c=relaxed/simple;
	bh=IiA6fpt9sS6XEZzDCR7dYFKgTG2n75DyD0GjRxVt89E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LbGZi2wLtatNg4T4A7L2Wq8pojWty8osN2AMHzX1zTqYCMq3tK1e7fKM0L/x5GD+VuaHepNfbDahVBE/nwyrYQqvCxb9kwMSE/kjRHxLxQXF/A8MbnuZG/9zrOSN/I+hxCNvOUG/fGJcGo0JcQBpyul3sg/8nVdHE63j+BNDgTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aArkZcxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A92EC116C6;
	Mon, 19 Jan 2026 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768846816;
	bh=IiA6fpt9sS6XEZzDCR7dYFKgTG2n75DyD0GjRxVt89E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aArkZcxbHSsEnLeu4d9RaBlGtrORuAfuOf5tLuPx8hkzBA/iTN8bjkzlFlT+lH/1J
	 iCuaIWWuXMnpccsWW7G7oExlbhjtj+2Gkfbebm6eKM0kQ6aUoUHzmxqkc4dh3g6Vmw
	 QGDWrfRa7aAGDtRpUaH9QfemkukHWGlpP8y1YqbZN4zyAIn428A6BwCyaartevof0y
	 ljMXWSpM7d4CmaWpUDajuVLCnEkwTtOhnkKHa/F9pRLvXViNxWGVM52+O0aGuXT2JD
	 F5ITkL+KJVK6khT1JTG6BMuJD8Ovx0kHnu6wM4O37vyzBRaeE0TKqEnVTGXoK3OTmC
	 CPkxGEKiYS0Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7C0A63806905;
	Mon, 19 Jan 2026 18:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] dsa: mxl-gsw1xx: Support R(G)MII slew
 rate
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176884681403.87873.4349909262577129629.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 18:20:14 +0000
References: <20260114104509.618984-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20260114104509.618984-1-alexander.sverdlin@siemens.com>
To: A. Sverdlin <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, hauke@hauke-m.de, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@makrotopia.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jan 2026 11:45:02 +0100 you wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Maxlinear GSW1xx switches offer slew rate configuration bits for R(G)MII
> interface. The default state of the configuration bits is "normal", while
> "slow" can be used to reduce the radiated emissions. Add the support for
> the latter option into the driver as well as the new DT bindings.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] dt-bindings: net: dsa: lantiq,gswip: add MaxLinear R(G)MII slew rate
    https://git.kernel.org/netdev/net-next/c/4cc265663da5
  - [net-next,v5,2/2] net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration
    https://git.kernel.org/netdev/net-next/c/dbf24ab58fec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



