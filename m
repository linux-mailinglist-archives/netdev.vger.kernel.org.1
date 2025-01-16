Return-Path: <netdev+bounces-158740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6772AA131C3
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B36807A1098
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 03:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE85674D;
	Thu, 16 Jan 2025 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufl0O4uB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA84A01
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736998222; cv=none; b=d8vp/0NwL7xkwqrYeieghgiU2qbwdDcsM2qUCFo8xaxIzsskehlODcvxy8KvsQrrd1ysIevUSNirvFFIIYyXZx52XHHsILwRhNyPQT79Fkh0ubUDx3gMb4gOhMyCo5DkaBeTWyKOo1Rp0nJ8vuqA73gwv6MqVOfHdohagbnIoSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736998222; c=relaxed/simple;
	bh=rn+YU2oewC8w3uMZZNQXxpiwzO+2pOp3niNY0ZOExvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I8NsIqutOVamVmI8oiEcfvBzRQmfxdMa3mkb2RVOOx4qxfJ9dDIC3y15mpZrrLctoPQspPmgZfbsT6zfujlTKHZDd3GO9Zi5jx+psGT0QFGOedBBMIT9KwpX/fg8Y5x6Hv8eiNWeAOoayXpNxjVa3qiMI3OPK+1C7QRcWwQPtlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufl0O4uB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E199C4CED1;
	Thu, 16 Jan 2025 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736998222;
	bh=rn+YU2oewC8w3uMZZNQXxpiwzO+2pOp3niNY0ZOExvA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ufl0O4uBto6gtlBbSOeXG4PGOSlJvBnikMJTvQhXjbJ/UojmQx1en2AHzbI6Vfg73
	 T95DFD/jh9EtGQYSKFgmlE7Q0YLgPLsHxJaK9pLbv1XvUVK2eSbh3zLvJs6SAZhqrc
	 WnJi5dcbMbAnTQDIFI4vg7Q4ixZ6xINh9Lvl2N5AcgHBvqtQMiurR6NPvuFj3YQRXD
	 fTYzhefLMTsE0i69zt1E4043kE2zdeP+qnJVESm2/2ymA/LUB7uonCFCUkyTDssL8G
	 D+oSlgyP6P8+ifxw5I0wyHx2/MfbRBy4lKcOE0lzZ98+mqoZILLVLjdR/B9LdUwxeo
	 i8y5U555Z+cHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB7380AA5F;
	Thu, 16 Jan 2025 03:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/5] net: reduce RTNL pressure in
 unregister_netdevice()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173699824504.995574.8048482828230619557.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jan 2025 03:30:45 +0000
References: <20250114205531.967841-1-edumazet@google.com>
In-Reply-To: <20250114205531.967841-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jan 2025 20:55:26 +0000 you wrote:
> One major source of RTNL contention resides in unregister_netdevice()
> 
> Due to RCU protection of various network structures, and
> unregister_netdevice() being a synchronous function,
> it is calling potentially slow functions while holding RTNL.
> 
> I think we can release RTNL in two points, so that three
> slow functions are called while RTNL can be used
> by other threads.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/5] net: expedite synchronize_net() for cleanup_net()
    https://git.kernel.org/netdev/net-next/c/0734d7c3d93c
  - [v3,net-next,2/5] net: no longer assume RTNL is held in flush_all_backlogs()
    https://git.kernel.org/netdev/net-next/c/8a2b61e9e879
  - [v3,net-next,3/5] net: no longer hold RTNL while calling flush_all_backlogs()
    https://git.kernel.org/netdev/net-next/c/cfa579f66656
  - [v3,net-next,4/5] net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 1)
    https://git.kernel.org/netdev/net-next/c/ae646f1a0bb9
  - [v3,net-next,5/5] net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 2)
    https://git.kernel.org/netdev/net-next/c/83419b61d187

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



