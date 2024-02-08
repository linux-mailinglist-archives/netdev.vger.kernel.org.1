Return-Path: <netdev+bounces-70070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B84AB84D806
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473A81F22AB7
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1583A1CFA8;
	Thu,  8 Feb 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/IGb7ZH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32841CD25
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707361231; cv=none; b=RbWocckOHhu8MVHXgmsj39gNFRF6XQWaKiR93rL6gpdmDuB/SvyLcFxacFtEDpufh1+V8A2HTdoTLgZvbcG2LGnEoqIRIvRcDJc32Az3z8cEjLLWLFCyIA0QF1gqPwrJY0QRwn2VQO4mLiJuDciGZuvHY8hRveFdszPN/XbayrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707361231; c=relaxed/simple;
	bh=2H8s4tiAdGf5Br7jsD/rhqzzB/l+97EC8tZuSoby/hQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sbr3sZ2UuN29PDUl0Q3MVN6nrJNcFBj4tVZ4JGxAIMNsviN7nme4TXtjYGUXrIKl81lmoGYWOBnsozzeRiSln9c1mBUO+2IZZf5K0c7dDG7u8BP0mWoxV8AqgPsCICj5hjcCQemeupkYC4JXtunrXo6sMxWtU0WC46WKBi0Y3Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/IGb7ZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A44FC43390;
	Thu,  8 Feb 2024 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707361230;
	bh=2H8s4tiAdGf5Br7jsD/rhqzzB/l+97EC8tZuSoby/hQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m/IGb7ZHW+Cl0ZCq0bzWT1Kf6TF60DO72Ls5yDTyMRmcT1hjwXORSfJX2malKoCaw
	 MsATPFAlQAPUzbwGB1Ve+YMM7dqo6B8uIvpjiR+VM2v1D7DyHiWPDowm4SdCWPPXKH
	 TKY4CIItt8BxRg3q6arv2FAvJl4a+ENwMaLHnboeWDs7idRAA15dzJIkCVnS5eZy3s
	 q/RT6iau7kLvb5qs5RXcbiNPrSmEkmm6x4gq0voUbp4zxSVS2mafZ8khygYjGTt08a
	 3FuLAhX35MXRIsY5/cdDykD0nh4QrMiw6NtQ8guFJ0BuaQv98QyWFkmMUXZF6BRn5M
	 Oa6K5vo+sRIUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5279FD8C96F;
	Thu,  8 Feb 2024 03:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next V4 01/15] xfrm: generalize xdo_dev_state_update_curlft to
 allow statistics update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170736123033.21845.6120628380850293061.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 03:00:30 +0000
References: <20240206005527.1353368-2-saeed@kernel.org>
In-Reply-To: <20240206005527.1353368-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com,
 steffen.klassert@secunet.com

Hello:

This series was applied to netdev/net-next.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Mon,  5 Feb 2024 16:55:13 -0800 you wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> In order to allow drivers to fill all statistics, change the name
> of xdo_dev_state_update_curlft to be xdo_dev_state_update_stats.
> 
> Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,V4,01/15] xfrm: generalize xdo_dev_state_update_curlft to allow statistics update
    https://git.kernel.org/netdev/net-next/c/fd2bc4195d51
  - [net-next,V4,02/15] xfrm: get global statistics from the offloaded device
    https://git.kernel.org/netdev/net-next/c/f9f221c98fd8
  - [net-next,V4,03/15] net/mlx5e: Connect mlx5 IPsec statistics with XFRM core
    https://git.kernel.org/netdev/net-next/c/6fb7f9408779
  - [net-next,V4,04/15] net/mlx5e: Delete obsolete IPsec code
    https://git.kernel.org/netdev/net-next/c/77bed87f7620
  - [net-next,V4,05/15] Documentation: Fix counter name of mlx5 vnic reporter
    https://git.kernel.org/netdev/net-next/c/21e16fa5dc6c
  - [net-next,V4,06/15] net/mlx5: Rename mlx5_sf_dev_remove
    https://git.kernel.org/netdev/net-next/c/8d7db0abafb8
  - [net-next,V4,07/15] net/mlx5: remove fw_fatal reporter dump option for non PF
    https://git.kernel.org/netdev/net-next/c/daa6a6eb8f88
  - [net-next,V4,08/15] net/mlx5: remove fw reporter dump option for non PF
    https://git.kernel.org/netdev/net-next/c/17aa2d79b7e5
  - [net-next,V4,09/15] net/mlx5: SF, Stop waiting for FW as teardown was called
    https://git.kernel.org/netdev/net-next/c/137cef6d5556
  - [net-next,V4,10/15] net/mlx5: Return specific error code for timeout on wait_fw_init
    https://git.kernel.org/netdev/net-next/c/bcad0e531231
  - [net-next,V4,11/15] net/mlx5: Remove initial segmentation duplicate definitions
    https://git.kernel.org/netdev/net-next/c/91a72ada6605
  - [net-next,V4,12/15] net/mlx5: Change missing SyncE capability print to debug
    https://git.kernel.org/netdev/net-next/c/507472ed0e37
  - [net-next,V4,13/15] net/mlx5: DR, Change SWS usage to debug fs seq_file interface
    https://git.kernel.org/netdev/net-next/c/917d1e799ddf
  - [net-next,V4,14/15] net/mlx5e: XSK, Exclude tailroom from non-linear SKBs memory calculations
    https://git.kernel.org/netdev/net-next/c/fb3bfdfcd106
  - [net-next,V4,15/15] net/mlx5e: XDP, Exclude headroom and tailroom from memory calculations
    https://git.kernel.org/netdev/net-next/c/a90f55916f15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



