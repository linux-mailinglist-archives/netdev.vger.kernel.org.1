Return-Path: <netdev+bounces-85386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1262389A8EC
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 07:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D764EB214DF
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 05:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE3818EA5;
	Sat,  6 Apr 2024 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpuZ2Nbo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B62914
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712379628; cv=none; b=bOavMa0B+wwhnvWa0yRZTJqzfiiKLYBn+zD1lowv0d0XZ8GqLM0S/eweLaPco99gdfC4Csg/UVJmlm9KIRfcrRHxhajPfMYl+nNjbOGp4ZbLwYLnMgrhJnYwC+jJ4ECEFK04FPkbWvoOyzYSGB43O6njvEl8up15ad+0LPz1Vw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712379628; c=relaxed/simple;
	bh=i/C0Fu1UvkDcDkBuEhE8/ynsvM/jpvfRklw4UBlycpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qrj8Icoy8zl2waPswRJMfy5poODJ0oQogNuDxi/3CiIhjLqwyKvuk9W2YWQZ4M5zVzH3XUsesnWx9izGhyMN4FGcwiIuj3gAUmXo+2HEatpVCu8QmQTbv2u1OxioC+KvuVAx+RXumJz08/tgxdYm++RxB0Y2kvFwVdYOI9hEWwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpuZ2Nbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0F47C43390;
	Sat,  6 Apr 2024 05:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712379627;
	bh=i/C0Fu1UvkDcDkBuEhE8/ynsvM/jpvfRklw4UBlycpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MpuZ2NboCzZNZ3/b/s5lkxs7iUm0CuKOa9TMMKC8155/A58QVsdeFO1P6NvOEDliE
	 E0bEpBfwKrprnL50w+eEbT53dsQRPyuz7awl/y9CX5rToRKZfTt0X4/XgSoaJAyh/1
	 IA3nAsXMFZuSFEycr0Jcp+ChCx1rHBSz6i9FZMyf02z1/ol7TUhT+U4I8rLcv05fX6
	 fzr7SIPyo+ImccCAYa+vZ3Q6/IATs8GG6fkzkkIEUKSpRMxL5eRCo3ehOfyS1UO68n
	 bx1ClwdkGwSe2VctrGRmz2gy43nOZ7PhMrRpKUBI3AGXwr7nDoWx82Cpnq5UObG7OR
	 2rQ+ebXf3Fi2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1BF5D84BAC;
	Sat,  6 Apr 2024 05:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mlx5e rc2 misc patches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171237962779.21613.17790072941997954165.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 05:00:27 +0000
References: <20240404173357.123307-1-tariqt@nvidia.com>
In-Reply-To: <20240404173357.123307-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 4 Apr 2024 20:33:52 +0300 you wrote:
> Hi,
> 
> This patchset includes small features and a cleanup for the mlx5e driver.
> 
> Patches 1-2 by Cosmin implements FEC settings for 100G/lane modes.
> 
> Patch 3-4 by Carolina adds generic rep-port ethtool stats group and implements
> an mlx5e counter that exposes RX packet drops of VFs/SFs on their representor.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net/mlx5e: Extract checking of FEC support for a link mode
    https://git.kernel.org/netdev/net-next/c/d4383ce15f5b
  - [net-next,2/5] net/mlx5e: Support FEC settings for 100G/lane modes
    https://git.kernel.org/netdev/net-next/c/4aafb8ab2a62
  - [net-next,3/5] ethtool: add interface to read representor Rx statistics
    (no matching commit)
  - [net-next,4/5] net/mlx5e: Expose the VF/SF RX drop counter on the representor
    (no matching commit)
  - [net-next,5/5] net/mlx5e: Un-expose functions in en.h
    https://git.kernel.org/netdev/net-next/c/958f56e48385

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



