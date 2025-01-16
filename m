Return-Path: <netdev+bounces-158871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A2BA139D3
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800C0188A761
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215271DE3B6;
	Thu, 16 Jan 2025 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6TZTHUU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD71D90DB
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030010; cv=none; b=EHxvcVTTtjfQIv0mg78ruwJXETI4EXZHUG0G34p5b6cV410uIInE1pBc5suwJi5OC8rhj0WBallmfdlzhvxgtuAg5HEeVdpwQ4g6KljQMAn+BT9vRUBZ3REan9OenQzl2jUS3Q+Mbc0WpUzwoL+ZB5LFflu2whrb2jgvpicEdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030010; c=relaxed/simple;
	bh=vEHcH5hMv7+GTka/6aWJvdVrZaMiqNOJfCMXWScQdKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HXD48rGTN2dp3F7Bze4JW9eSS2cKILo5Y5eCwpm36pcR5qh0dh0zTD06LM1UYmXVrnRrvY8LBUVD5t/IjtYKY2wCt8j1t7QTFDKFrSu31xnZ9gqxhPO49zwQYRo2XkKHcdOE/zWYBN3s/9ysFJcadNot3IstI9yNQKt3fxlQgqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6TZTHUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC1AC4CED6;
	Thu, 16 Jan 2025 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737030009;
	bh=vEHcH5hMv7+GTka/6aWJvdVrZaMiqNOJfCMXWScQdKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t6TZTHUUWuPt4OU+tvdG0xWmze/GovvcCjPr1kVIFhoqjdM/OPqGaguNT+wA7N/fx
	 bHvnMIU09ZMOnHUPhYWX6N4Fx7Gnd2wlFkYYFJu1JFmPyAPPD7owgSFuwG6fsJ39Em
	 XdFLQgOezmWFl4jHsiNPggflE4tsqNHEKmAk/NmWXPjbdnIbnlB2uQNCL03ZJfRzkp
	 lyYgfEdrVIbiLnsGUu2CryA0H3tRTDtqhkctOzWe2y4dFZdPQKU1CPxQvrjfy6MZzP
	 r1QdKz8wY9Wq2LtLqzWUTBBTMZvnkO8Acq1RI9/543pEs3IyR2ovRS4jfqZfmTvhAa
	 1gJxkujnZKkvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9C380AA62;
	Thu, 16 Jan 2025 12:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2 0/7] mlx5 misc fixes 2025-01-15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173703003250.1435910.14293771528539253491.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jan 2025 12:20:32 +0000
References: <20250115113910.1990174-1-tariqt@nvidia.com>
In-Reply-To: <20250115113910.1990174-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, mbloch@nvidia.com,
 moshe@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 15 Jan 2025 13:39:03 +0200 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 core and
> Eth drivers.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,V2,1/7] net/mlx5: Fix RDMA TX steering prio
    https://git.kernel.org/netdev/net/c/c08d3e62b2e7
  - [net,V2,2/7] net/mlx5: Fix a lockdep warning as part of the write combining test
    https://git.kernel.org/netdev/net/c/1b10a519a457
  - [net,V2,3/7] net/mlx5: SF, Fix add port error handling
    https://git.kernel.org/netdev/net/c/2011a2a18ef0
  - [net,V2,4/7] net/mlx5: Clear port select structure when fail to create
    https://git.kernel.org/netdev/net/c/5641e82cb55b
  - [net,V2,5/7] net/mlx5e: Fix inversion dependency warning while enabling IPsec tunnel
    https://git.kernel.org/netdev/net/c/2c3688090f8a
  - [net,V2,6/7] net/mlx5e: Rely on reqid in IPsec tunnel mode
    https://git.kernel.org/netdev/net/c/25f23524dfa2
  - [net,V2,7/7] net/mlx5e: Always start IPsec sequence number from 1
    https://git.kernel.org/netdev/net/c/7f95b0247764

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



