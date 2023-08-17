Return-Path: <netdev+bounces-28578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B760B77FE42
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C4128208E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A718037;
	Thu, 17 Aug 2023 19:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811A14AA6
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DA8AC433D9;
	Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692298825;
	bh=NOGzQVdiuOP2JeKaoeNUBm96kFMTeQnSGerVUOwoo1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OKrFrs67CHaCYVQmbA9Zq0lJTUZEtucL0/uhZoHS95//JQgiQAcxNFlkvgm8xrYsk
	 dIV6isqywF/cqNyMQ2wAOlfDmpi9MVpog4+fMzk1OO3VgBpdQUQtu7zpgekCPkHPNt
	 Kf6O35ZrTOuz0PXoene9f+j6hTbxJGltz/bUw/EPxZN4is3ty8xeaGGzUNe+AgsItF
	 xrRbXyUnp+d5g+ZRcjnXYV+CXMK/nuxOfjQtPD1lp/YoOIhkow6TX2LuqGytxvrHJo
	 DQU04ZFEkFF+hTshI+QOviIXzICxYE5YVOiFudBsTI/lBF9/8FvcgRlwI+HLXrH+B4
	 gzMTD1Zu11/Ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FAC1E26D3B;
	Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net 1/2] net/mlx5e: XDP, Fix fifo overrun on XDP_REDIRECT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169229882525.13479.8981109425890919572.git-patchwork-notify@kernel.org>
Date: Thu, 17 Aug 2023 19:00:25 +0000
References: <20230816204108.53819-2-saeed@kernel.org>
In-Reply-To: <20230816204108.53819-2-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, dtatulea@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Saeed Mahameed <saeedm@nvidia.com>:

On Wed, 16 Aug 2023 13:41:07 -0700 you wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> Before this fix, running high rate traffic through XDP_REDIRECT
> with multibuf could overrun the fifo used to release the
> xdp frames after tx completion. This resulted in corrupted data
> being consumed on the free side.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/mlx5e: XDP, Fix fifo overrun on XDP_REDIRECT
    https://git.kernel.org/netdev/net/c/34a79876d9f7
  - [net,2/2] net/mlx5: Fix mlx5_cmd_update_root_ft() error flow
    https://git.kernel.org/netdev/net/c/0fd23db0cc74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



