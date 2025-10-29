Return-Path: <netdev+bounces-233736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BCEC17DDD
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC81892399
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2908F2DC76E;
	Wed, 29 Oct 2025 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd6/MNSn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393F2DC76A
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700846; cv=none; b=uNtMvl+WHaBn8anzzjxmAfQ5tSRkhIWe7SgyqG7/OJfqeBTtt6fdN7uFeG7Xqu+kM6g/V0JpKmko0/yeYYi4st49oBA/ZLWUARZRWK60aTOFiqS0MZnR1Tq713MKeM0Jh97IXXtXwnqz+xOHrG+EZH5f9DP26WDx2LnrAvvZSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700846; c=relaxed/simple;
	bh=xPN5PGgo1lWO9Mh/ric//QDoC+DXjWKDz6RfvoNLiz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lir/rUhBXEvkQBjEg1+lGWhR24UhGlmNAOVbG5336tq4pYnk50a7Br5DDtiE2ItdUx+dLVkXxcKsSn3Y9ABViOGsaWLr7qD+6p7KOLk1CAd7F8RTURDg/r8HwfN3CQ00MAcnRHIeMPXRV9+8Ip94jH4FBs8uEHevmDN7wE324wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd6/MNSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADCEC4CEE7;
	Wed, 29 Oct 2025 01:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700845;
	bh=xPN5PGgo1lWO9Mh/ric//QDoC+DXjWKDz6RfvoNLiz8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gd6/MNSnp6oLPIBufEfIlZlQU3bRdjO4IsBPW8QYxWZZa/Rwjf/mC6TlMAj0DeszS
	 bW9lxjq3YLtYYFpjjYTwt6fVqjM2TyrxrmufRRZ5I9Cpj/AZYDPk5p2p74niJqQNCW
	 SONG/iIID9wUrIMGW6qLqyFswyorE0BFLWZWJ5yn1J2YKnkkd+nht6AMOwWDEb+DZZ
	 3VYTIRg1LQnrZ5yMHI2KhGyvXWzWuY8vN7AHv0OZbjBDt3RucogCqlai5wLctr4tgh
	 MhKxOX9CvsM+Gzh0dErF+a3NYJbt4x3EmqgrcHbu9up84poABsBzAv4WMwgnF2vIUy
	 U61N1lSEuYWtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD539FEB6D;
	Wed, 29 Oct 2025 01:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9][pull request] ice: postpone service task
 disabling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176170082299.2452213.1333414898637582927.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 01:20:22 +0000
References: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com, mschmidt@redhat.com,
 poros@redhat.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 24 Oct 2025 13:47:35 -0700 you wrote:
> Przemek Kitszel says:
> 
> Move service task shutdown to the very end of driver teardown procedure.
> This is needed (or at least beneficial) for all unwinding functions that
> talk to FW/HW via Admin Queue (so, most of top-level functions, like
> ice_deinit_hw()).
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] ice: enforce RTNL assumption of queue NAPI manipulation
    https://git.kernel.org/netdev/net-next/c/c35c178fcdff
  - [net-next,2/9] ice: move service task start out of ice_init_pf()
    https://git.kernel.org/netdev/net-next/c/806c4f32a806
  - [net-next,3/9] ice: move ice_init_interrupt_scheme() prior ice_init_pf()
    https://git.kernel.org/netdev/net-next/c/2fe18288fce6
  - [net-next,4/9] ice: ice_init_pf: destroy mutexes and xarrays on memory alloc failure
    https://git.kernel.org/netdev/net-next/c/71430451f81b
  - [net-next,5/9] ice: move udp_tunnel_nic and misc IRQ setup into ice_init_pf()
    https://git.kernel.org/netdev/net-next/c/e3bf1cdde747
  - [net-next,6/9] ice: move ice_init_pf() out of ice_init_dev()
    https://git.kernel.org/netdev/net-next/c/ef825bdb4605
  - [net-next,7/9] ice: extract ice_init_dev() from ice_init()
    https://git.kernel.org/netdev/net-next/c/c2fb9398f73d
  - [net-next,8/9] ice: move ice_deinit_dev() to the end of deinit paths
    https://git.kernel.org/netdev/net-next/c/8a37f9e2ff40
  - [net-next,9/9] ice: remove duplicate call to ice_deinit_hw() on error paths
    https://git.kernel.org/netdev/net-next/c/1390b8b3d2be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



