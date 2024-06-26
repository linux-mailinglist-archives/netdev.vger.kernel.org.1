Return-Path: <netdev+bounces-106713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9DB917560
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4791E1C21861
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1587492;
	Wed, 26 Jun 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbzM/VUi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1242428FA;
	Wed, 26 Jun 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719363633; cv=none; b=m2PzjMVB92/V6cxApFGHOEvlx5Y1t+2TYKQePteIlR5Mz2VrWDF9U9ZWqr+9JCfM9nEopHvOynsy7/+4G4F3jJuFVfO4HVsUeFX9Wmw6+bWxYMrXa0cEDj5xOhhz6CQ66uk3Fh6lZwxJUEswqVOzSDMUsib1e7OSw2AjDgRcECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719363633; c=relaxed/simple;
	bh=hdgniYt3+54JkbIsj7pvD/P/4LuDUv7FqTd6GRkEshU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=drHloulGnoO5MT1cnhkaQ8EdHgaurldsL/jQ1I2sOfn9Xuysd/enOhMV53pzjYO08tH7Rze/tuEdVr0twKIXUvZPljKl6vTC0sVgE4X45ibf/n+8mLyFzKTpBfwS5WTVE/cBQ4yLTHrgKVY0AJ76Axjtk98MVIyQp0zCTE4hRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbzM/VUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AC80C4AF07;
	Wed, 26 Jun 2024 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719363632;
	bh=hdgniYt3+54JkbIsj7pvD/P/4LuDUv7FqTd6GRkEshU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SbzM/VUiLXMOGJ9F2+N0jRLkkQTW0Ii4WgFtG3Y5K8HV4PyyObwPtxDZKZ5vn17aS
	 YNBbN19qPL4+Pc2wC80eq2jx9RaP9t48pZzXStjiE2LKwV+qz3u2g8AWooCqlb0b7t
	 pe344kZ9/+/CP1UenZ/XxH0/HYGrqHuVrLz9rJSNS6lPd/F2JmInv7Ix9oOI6uySwG
	 5ThLc3ioO3uCnINGuG+98+J5u630MRu39Ufng9JI35xUeyxBThulmOYISghKL+MWQc
	 f0gAasPnQM0+M3msOMhOdZxM4rkqWIvdHnkfDAYWYf+GbFF7/YeFHtg1Pgkeufx+HV
	 3CmK/RQutXmaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84EA6DE8DF3;
	Wed, 26 Jun 2024 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] gve: Add flow steering support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171936363254.31895.5945372004965375509.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 01:00:32 +0000
References: <20240625001232.1476315-1-ziweixiao@google.com>
In-Reply-To: <20240625001232.1476315-1-ziweixiao@google.com>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 hramamurthy@google.com, rushilg@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jun 2024 00:12:26 +0000 you wrote:
> To support flow steering in GVE driver, there are two adminq changes
> need to be made in advance.
> 
> The first one is adding adminq mutex lock, which is to allow the
> incoming flow steering operations to be able to temporarily drop the
> rtnl_lock to reduce the latency for registering flow rules among
> several NICs at the same time. This could be achieved by the future
> changes to reduce the drivers' dependencies on the rtnl lock for
> particular ethtool ops.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] gve: Add adminq mutex lock
    https://git.kernel.org/netdev/net-next/c/1108566ca509
  - [net-next,v3,2/5] gve: Add adminq extended command
    https://git.kernel.org/netdev/net-next/c/fcfe6318dbac
  - [net-next,v3,3/5] gve: Add flow steering device option
    https://git.kernel.org/netdev/net-next/c/3519c00557e0
  - [net-next,v3,4/5] gve: Add flow steering adminq commands
    https://git.kernel.org/netdev/net-next/c/57718b60df9b
  - [net-next,v3,5/5] gve: Add flow steering ethtool support
    https://git.kernel.org/netdev/net-next/c/6f3bc487565d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



