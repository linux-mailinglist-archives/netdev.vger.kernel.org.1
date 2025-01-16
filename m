Return-Path: <netdev+bounces-158717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC54A130DD
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 02:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF5D1641AD
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 01:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC222868B;
	Thu, 16 Jan 2025 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DElgkymd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0129A1
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736991609; cv=none; b=HSs6AxIK33ihvftPPxSrqhwxPMEOHrzqHaPsVUt+hpJYR1G5ADNPh3uGmi2WmXYI0LDG6920ZpzQbmJwuQ8QEH7wGjdYuJauvCF44HuxRmqMIC7CRew25bY81vrPPqzMTFKDMHSNOjwIPM55ZWzPhvkV8KScogGSMQUOW0dMRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736991609; c=relaxed/simple;
	bh=M0LJrANGNXotU6iod3jySHAhm3Pf9k0t50XFBHUnCcM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sFez57AkK3uDIoZL/W27pzooc93wlko7YjVy3tlmgXACqIJAC66w6lWeJcTdHMA0AyP4EnjZ7X/G7GD0teOVwomlBiWOobheU1E8CDNcr1cDjSL0meWgxx/ocjjqUmjQz0RBhBbGNpVq0dz5o3mZxSlTNO/JGmL128bJNVN/SHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DElgkymd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BD4C4CED1;
	Thu, 16 Jan 2025 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736991608;
	bh=M0LJrANGNXotU6iod3jySHAhm3Pf9k0t50XFBHUnCcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DElgkymdqWTUQLOIy3PL8vVae9+2vOttEDJmVYq6IEtgJst2Fz1f9ZLaVwKcLPaUC
	 MsHHvddG5JgVc6npI5wNd5MEVAVy4jn3FWol/CREMTLJt9aRP/VK0FEy/DrnTZrNtG
	 b+e2z4cqz1ddXnW4cy0dMLnmHxUDgfjJx0e/d9eg1W8V6PIGRE1m4wGbv24xShvYDE
	 9NyVAGiIV8hhGh6gKZjaKa5TSMJC08PcNQ2xkJKLqeJrqPbfJ2CnBaTXT1kSJ7aWka
	 THDaUgcX994NhOxf5OI3BtILlMlAQBakPCu2VZYiLGUS3oWdntDCAqn6u6TYuKu/ME
	 dD7bWjf/bY7jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB224380AA5F;
	Thu, 16 Jan 2025 01:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/13][pull request] Intel Wired LAN Driver
 Updates 2025-01-08 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173699163174.942981.11604439373791717150.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jan 2025 01:40:31 +0000
References: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 14 Jan 2025 16:08:26 -0800 you wrote:
> This series contains updates to ice driver only.
> 
> Przemek reworks implementation so that ice_init_hw() is called before
> ice_adapter initialization. The motivation is to have ability to act
> on the number of PFs in ice_adapter initialization. This is not done
> here but the code is also a bit cleaner.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/13] ice: c827: move wait for FW to ice_init_hw()
    https://git.kernel.org/netdev/net-next/c/c37dd67c4233
  - [net-next,v2,02/13] ice: split ice_init_hw() out from ice_init_dev()
    https://git.kernel.org/netdev/net-next/c/4d3f59bfa2cd
  - [net-next,v2,03/13] ice: minor: rename goto labels from err to unroll
    https://git.kernel.org/netdev/net-next/c/5d5d9c2c0fb9
  - [net-next,v2,04/13] ice: ice_probe: init ice_adapter after HW init
    https://git.kernel.org/netdev/net-next/c/fb59a520bbb1
  - [net-next,v2,05/13] ice: add recipe priority check in search
    https://git.kernel.org/netdev/net-next/c/e81e1d79a974
  - [net-next,v2,06/13] ice: add fw and port health reporters
    https://git.kernel.org/netdev/net-next/c/85d6164ec56d
  - [net-next,v2,07/13] ice: use string choice helpers
    https://git.kernel.org/netdev/net-next/c/4c9f13a65426
  - [net-next,v2,08/13] ice: use read_poll_timeout_atomic in ice_read_phy_tstamp_ll_e810
    https://git.kernel.org/netdev/net-next/c/95aca43b4a82
  - [net-next,v2,09/13] ice: rename TS_LL_READ* macros to REG_LL_PROXY_H_*
    https://git.kernel.org/netdev/net-next/c/5b15b1f144c8
  - [net-next,v2,10/13] ice: add lock to protect low latency interface
    https://git.kernel.org/netdev/net-next/c/50327223a8bb
  - [net-next,v2,11/13] ice: check low latency PHY timer update firmware capability
    https://git.kernel.org/netdev/net-next/c/a5c69d45df27
  - [net-next,v2,12/13] ice: implement low latency PHY timer updates
    https://git.kernel.org/netdev/net-next/c/ef9a64c07294
  - [net-next,v2,13/13] ice: Add in/out PTP pin delays
    https://git.kernel.org/netdev/net-next/c/914639464b76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



