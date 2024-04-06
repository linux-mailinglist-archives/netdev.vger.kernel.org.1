Return-Path: <netdev+bounces-85444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E953889AC6F
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 19:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A231E282066
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C829F405FF;
	Sat,  6 Apr 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRkt4oio"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43631CFB9
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712424629; cv=none; b=V6ub8yaer5wAFboKow0wFJIeHqoX4mvpDKyGFQUH/es4zne0xfbrrVQqEAQjPyWLDnWhyjH7aSNaGVNSPBvCiF/6QbkxFxfW3qCotzpGEYY2HQkEw+KAMSBnzIp27Sinv7CRX8kXLf2zkZaIzmqFhnMITdOsr5OOK6MsYS9aFNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712424629; c=relaxed/simple;
	bh=cT+mraSAXOipoSh4YkTGXUAEiNGeI2kn+jy9ph7j8DI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SLrC8P6DZOFP5Ih1ZBlrs9SxyQmiuixanmOzmqQ4X2N8/1wgyEVSBQLj8zHzZBJIbyrM0JL03j612768e/pWqmb1abdZAoER8Ih5R3YT6JNsed+yr69Bu/Egi5fmZAlYutu6/PbYMvMYQTyassT4XU0ts7MG7rsrd24tVNaGlJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRkt4oio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D50BC43394;
	Sat,  6 Apr 2024 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712424629;
	bh=cT+mraSAXOipoSh4YkTGXUAEiNGeI2kn+jy9ph7j8DI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VRkt4oioetwKCaM019qSepCi/2EGhW7N93xTTs7jjbezQgzdS+fPTWKTO2bzmYWuQ
	 /7O4jByeuIcuWbyWI/yyOlrFVqpdH5zlHMhPxs/xd2bC2CL7O1Msk7pxdmGp01TyaS
	 e5G0G3fY9sPywMMdJbTowf0Tg7K5SbIu93tH9aI9DBX5TPp9Wller1VA5QY5vObFV4
	 qqKlAnjVC8/2dVe1h834zlxaSi+kWogOSWA5q62QluU8iD8Rss5oOMi21XGPAx6Vu6
	 ZFvX9g+11a54ejvr3fKa15DLUdotHdGxRkSOej0WpDmzRUNYIB/15bl26rgdGMxkM7
	 pIteXnax3LQ6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3366BD8A107;
	Sat,  6 Apr 2024 17:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: add nlmsg_consume() and use it in devlink
 compat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171242462920.4000.9427417911177896539.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 17:30:29 +0000
References: <20240403202259.1978707-1-kuba@kernel.org>
In-Reply-To: <20240403202259.1978707-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  3 Apr 2024 13:22:59 -0700 you wrote:
> devlink_compat_running_version() sticks out when running
> netdevsim tests and watching dropped skbs. Add nlmsg_consume()
> for cases were we want to free a netlink skb but it is expected,
> rather than a drop. af_netlink code uses consume_skb() directly,
> which is fine, but some may prefer the symmetry of nlmsg_new() /
> nlmsg_consume().
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: add nlmsg_consume() and use it in devlink compat
    https://git.kernel.org/netdev/net-next/c/8e69b3459ca1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



