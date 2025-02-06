Return-Path: <netdev+bounces-163457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A9FA2A4CD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836EE1888D87
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D33D226522;
	Thu,  6 Feb 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Be2X97zx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AE2215778
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834810; cv=none; b=b1RR50f+Ehz2BPQP+bJzXREHM9L0aGFU637YWBTxbFz5tKJysRaLCP1sRntcITEcdwFzzEnWRUSAkOp2mrwbQSOp1TYWCE17O1945hSmEH2NXJAfMMtuKyU/BaaMCErsV6bDfdvWW7kAJbpPZt/Tw7exlTuz/wEUpjmkHIxWDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834810; c=relaxed/simple;
	bh=/CmLBwxpr4jbRgV4/EfJQXCiXf9mi2/7b7tboRzVTys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pkmuPqbG8Yv9SNHbfAa6M3EPfb8rXBfJs74yWwU70bQ37QYRdCQo7PGUKPXM6zzV9XhKcVhCV81wLDTS/v9uwAvz5f8aVTG3dQlvZTjSl3arQ0RO7QMXI+dpM0k7TPZojpxnGWNmQMhhcx9SqTWuufdXAXqThcaoJcaKt1bgm/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Be2X97zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCE3C4CEDD;
	Thu,  6 Feb 2025 09:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738834809;
	bh=/CmLBwxpr4jbRgV4/EfJQXCiXf9mi2/7b7tboRzVTys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Be2X97zxGA4GlFfuz9ziAY9oWYyj4pu2HMeZsNUbYpr9ZMiElYBabBlYwL80SH1bP
	 OW+V+hlfqw2mc8eQrQ9EQQOHBuTON++dhHdXg0JVf0WftlTa9pSElyoBRKbS0dIMKO
	 L8iRBrCKDOlZlNaH1zlori9XiSt1fQGl/w1c/zutP+gpbSvJcMKgyEg3ZNkUQY2g7z
	 lxpRGiXB4dogQaSLlWsFyn3r/sfPSPsJTNT4yIua7K343zBg1v8/TNE2aGGuonMco7
	 QBxMNU8wF/S+WU5gmQlXc9Y+xNuA0Z1qPd64h82GyXAGT3uZX5AGbqGy1Fhm4NrIgq
	 Z2aazrnuqgEoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCBB380AAD9;
	Thu,  6 Feb 2025 09:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] Support one PTP device per hardware clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173883483749.1410600.9961897170584318272.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 09:40:37 +0000
References: <20250203213516.227902-1-tariqt@nvidia.com>
In-Reply-To: <20250203213516.227902-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, jianbol@nvidia.com, moshe@nvidia.com,
 leonro@nvidia.com, mbloch@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 3 Feb 2025 23:35:01 +0200 you wrote:
> Hi,
> 
> This series contains two features from Jianbo, followed by simple
> cleanups.
> 
> Patches 1-9 by Jianbo add support for one PTP device per hardware clock,
> described below [1].
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] net/mlx5: Add helper functions for PTP callbacks
    https://git.kernel.org/netdev/net-next/c/e3ad54f5bdb9
  - [net-next,02/15] net/mlx5: Change parameters for PTP internal functions
    https://git.kernel.org/netdev/net-next/c/9f722fb10521
  - [net-next,03/15] net/mlx5: Add init and destruction functions for a single HW clock
    https://git.kernel.org/netdev/net-next/c/ccb717a88b2e
  - [net-next,04/15] net/mlx5: Add API to get mlx5_core_dev from mlx5_clock
    https://git.kernel.org/netdev/net-next/c/355f58f10911
  - [net-next,05/15] net/mlx5: Change clock in mlx5_core_dev to mlx5_clock pointer
    https://git.kernel.org/netdev/net-next/c/f9beaf4fac64
  - [net-next,06/15] net/mlx5: Add devcom component for the clock shared by functions
    https://git.kernel.org/netdev/net-next/c/574998cf3b3f
  - [net-next,07/15] net/mlx5: Move PPS notifier and out_work to clock_state
    https://git.kernel.org/netdev/net-next/c/79faf9d76d66
  - [net-next,08/15] net/mlx5: Support one PTP device per hardware clock
    https://git.kernel.org/netdev/net-next/c/f538ffb7a22d
  - [net-next,09/15] net/mlx5: Generate PPS IN event on new function for shared clock
    https://git.kernel.org/netdev/net-next/c/39c1202fa942
  - [net-next,10/15] ethtool: Add support for 200Gbps per lane link modes
    https://git.kernel.org/netdev/net-next/c/4897f9b7f8bd
  - [net-next,11/15] net/mlx5: Add support for 200Gbps per lane link modes
    https://git.kernel.org/netdev/net-next/c/ee0a4fc396f1
  - [net-next,12/15] net/mlx5e: Support FEC settings for 200G per lane link modes
    https://git.kernel.org/netdev/net-next/c/4e343c11efbb
  - [net-next,13/15] net/mlx5: Remove stray semicolon in LAG port selection table creation
    https://git.kernel.org/netdev/net-next/c/6fa15a20b7c3
  - [net-next,14/15] net/mlx5e: Remove unused mlx5e_tc_flow_action struct
    https://git.kernel.org/netdev/net-next/c/96d64a1ab795
  - [net-next,15/15] net/mlx5e: Avoid WARN_ON when configuring MQPRIO with HTB offload enabled
    https://git.kernel.org/netdev/net-next/c/689805dcc474

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



