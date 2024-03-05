Return-Path: <netdev+bounces-77352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494988715AF
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 07:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052AB282FDF
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CBE7B3E7;
	Tue,  5 Mar 2024 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw7e8ZJ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D994A3398B
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619028; cv=none; b=nSe9HARxCvXUVRoEmeLsSghGF3567wT2eOf8BPlcAo4T6GIhr1/8Ycf/gzlO4Db8BoMjKdhAca2n3/VHYH/beT2QHmzn+xQZmEiW6uYioDFFkZi6LClmYQ4RfKB8Ncrfr656wzkijoYIdDDpPgmctv+XDrydHS/qltjZgIO+fLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619028; c=relaxed/simple;
	bh=NpJ7lqUDMXlt82RCOZmkVu5CuwBYvKBvi3VGlaCRd34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R/Ogidq83hMjkjFbS+tShoyi5SBpZxeMyxx0Unh/23egz6XxkBKFQRSN+bLVYe6bLxeE+y5LorZY7zzsZXvR4X/HT5wI2WHmAFGXc37ylqXq/MLrZhz7dF5ZcRmprv7xg6eptviZdf0EeKuo9nbu2omw2ygsQlf3cU/i+W4Scjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw7e8ZJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72717C43390;
	Tue,  5 Mar 2024 06:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709619028;
	bh=NpJ7lqUDMXlt82RCOZmkVu5CuwBYvKBvi3VGlaCRd34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rw7e8ZJ5ngO2diq2fnmVhrsGVmxMdpdE3l1lN48Olab9+oOiHMJePwip0kDwltcUA
	 Q+v6XLkfjf+jvIuqhzg5DyiJkkvBUL8viFEYiIj1ed+0GlSl3xL1kAHUoFU2BK/1eA
	 m8gCzSgTwt6ckMQKCoNKgKHft6g5hCL00NfzG5gK546sf6P0VrY+3Hrm3fWkZYWYcZ
	 gkpBS9snCcM0mDhF5igyZN1SIEC1VT7W+bK6EDZBZgpBbZQiw3ilECrfa/BdUrT55W
	 xgxBTbFU9TJcFuT84SMOZENrpN4HejPGxERR8kJXS0XIEtQuIl3oSM0e9Uk1HcC4YS
	 aYbMpnNMyQMpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58078D9A4B5;
	Tue,  5 Mar 2024 06:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net V2 1/9] Revert "net/mlx5: Block entering switchdev mode with ns
 inconsistency"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170961902835.11695.2965084070655979020.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 06:10:28 +0000
References: <20240302070318.62997-2-saeed@kernel.org>
In-Reply-To: <20240302070318.62997-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com, gavinl@nvidia.com,
 jiri@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Fri,  1 Mar 2024 23:03:10 -0800 you wrote:
> From: Gavin Li <gavinl@nvidia.com>
> 
> This reverts commit 662404b24a4c4d839839ed25e3097571f5938b9b.
> The revert is required due to the suspicion it is not good for anything
> and cause crash.
> 
> Fixes: 662404b24a4c ("net/mlx5e: Block entering switchdev mode with ns inconsistency")
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net,V2,1/9] Revert "net/mlx5: Block entering switchdev mode with ns inconsistency"
    https://git.kernel.org/netdev/net/c/8deeefb24786
  - [net,V2,2/9] Revert "net/mlx5e: Check the number of elements before walk TC rhashtable"
    https://git.kernel.org/netdev/net/c/b7bbd698c905
  - [net,V2,3/9] net/mlx5: E-switch, Change flow rule destination checking
    https://git.kernel.org/netdev/net/c/85ea2c5c5ef5
  - [net,V2,4/9] net/mlx5: Fix fw reporter diagnose output
    https://git.kernel.org/netdev/net/c/ac8082a3c7a1
  - [net,V2,5/9] net/mlx5: Check capability for fw_reset
    https://git.kernel.org/netdev/net/c/5e6107b499f3
  - [net,V2,6/9] net/mlx5e: Change the warning when ignore_flow_level is not supported
    https://git.kernel.org/netdev/net/c/dd238b702064
  - [net,V2,7/9] net/mlx5e: Fix MACsec state loss upon state update in offload path
    https://git.kernel.org/netdev/net/c/a71f2147b649
  - [net,V2,8/9] net/mlx5e: Use a memory barrier to enforce PTP WQ xmit submission tracking occurs after populating the metadata_map
    https://git.kernel.org/netdev/net/c/b7cf07586c40
  - [net,V2,9/9] net/mlx5e: Switch to using _bh variant of of spinlock API in port timestamping NAPI poll context
    https://git.kernel.org/netdev/net/c/90502d433c0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



