Return-Path: <netdev+bounces-123806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EEB96690E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6833C1C23692
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697AF1BCA03;
	Fri, 30 Aug 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoHkIgda"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11C3DBB6;
	Fri, 30 Aug 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043229; cv=none; b=tsyK8EoeVQ9kXSCwY1IcQqt0T34FQi5kD4z4QOiLNFfrrq3BUE3ZmF+8ILbZ1JlRo2egkpxgf3sUmlL8KEUcfDvsMIU12qL9pu8ywecrf70sE+Rhz7LXPdL+/5hQ6Fg1xunSKrjmanROYwOGE+2Oz72KkIH83BFGWuUSpLJp+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043229; c=relaxed/simple;
	bh=2/Lde77M57/uft20yZsYU2AJIk+qjlCHEXdgpvBhzNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HT+2tJdH3oHFlz7R6GrHnj1VdeZPfy9yImH+s6X15PEgn0Mn7ot21H0VZRBeOMUwJqK032Uzy13XDm73NxHimgjVzGUuhlSwR1x/bXtl+ZpiEWAzW97QkQ0o+ancisHgjjOZ6nJrj7DJp64kCd5ISuGNmmQdaWsjUJ2e3L7ctTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoHkIgda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1FBC4CEC8;
	Fri, 30 Aug 2024 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725043228;
	bh=2/Lde77M57/uft20yZsYU2AJIk+qjlCHEXdgpvBhzNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EoHkIgdaKe7W/x+CVN0adQ9gxGvdBS5uTNtwD9iTSAwhmSWNBqgxECr2RCKvhGOhy
	 lK5LObzbw8RTjmIj+2FRReto4s2C9sd+AjL42cfanuumofffErYsce5+lFVC3NSB4d
	 713FYVQEcKsIL0H0H33bzgVgiaC1+8WcK4baFqlYuf+wfP0EFFmSit1olyVgWtxLrl
	 R9nWhzDdZq9n3IXkw+ycaI6Pubgm/4rUpopnW6BGA3gdR+ZSyUl1UmzIUvTwGRUoKy
	 wcwpBnGg/h0MMjD0pP9JbbKBamvGKcJDtF9dyO90L2z0mXknQt1HrBA6SYfapv636J
	 fVZEy1e3OfaAg==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 73D4A3809A82;
	Fri, 30 Aug 2024 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Documentation: Add missing fields to net_cachelines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172504323046.2682525.188474389406773601.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 18:40:30 +0000
References: <20240829155742.366584-1-jdamato@fastly.com>
In-Reply-To: <20240829155742.366584-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, edumazet@google.com,
 kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Aug 2024 15:57:42 +0000 you wrote:
> Two fields, page_pools and *irq_moder, were added to struct net_device
> in commit 083772c9f972 ("net: page_pool: record pools per netdev") and
> commit f750dfe825b9 ("ethtool: provide customized dim profile
> management"), respectively.
> 
> Add both to the net_cachelines documentation, as well.
> 
> [...]

Here is the summary with links:
  - [net-next] Documentation: Add missing fields to net_cachelines
    https://git.kernel.org/netdev/net-next/c/6af91e3d2cfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



