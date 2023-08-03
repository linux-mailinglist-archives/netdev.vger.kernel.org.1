Return-Path: <netdev+bounces-23841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D936076DD88
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 03:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92142281E26
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 01:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45E1FB7;
	Thu,  3 Aug 2023 01:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30657F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60CA0C433CA;
	Thu,  3 Aug 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691027421;
	bh=s4+goPnQYy54ExZONvL3F0zvTeO0T3b+y0rRyS9MrUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CUNKl874eCjaYgIQRcpxA/KNK97nI7H5iqhyIoqBjRpyZaWdcvDJo4lQKzBJGshxz
	 jgZ81YNOQYKrNmhgLg0XtYn5tyvEx9GGNqx/F6VtfdkGPv4rhcsk9p4CQ1wh9++E6f
	 13dOQQJC+AzCqNL67SqNU/sihrdaODYWs9FMTq14H23biFUzKLpBmpbD5da6KYM4pD
	 jt+P4kGGEOsD3L4CpOYqa72QFznpddSbwVJxulqwFNhM9ybJj7+Fop5dpzrkUBirIL
	 xZCKbcfzyEmeR2Ib9Lkh/m118wjWjbxkhCVEM64XqEjfYwAM91JXWwBZYiwXmH5xl2
	 0tNdE1Wyyts1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 435A9E270D2;
	Thu,  3 Aug 2023 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mlx5 IPsec fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169102742127.3352.6090408254573105846.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 01:50:21 +0000
References: <cover.1690803944.git.leonro@nvidia.com>
In-Reply-To: <cover.1690803944.git.leonro@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: kuba@kernel.org, leonro@nvidia.com, steffen.klassert@secunet.com,
 edumazet@google.com, jianbol@nvidia.com, paulb@nvidia.com, raeds@nvidia.com,
 netdev@vger.kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
 davem@davemloft.net, simon.horman@corigine.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 14:58:39 +0300 you wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> The following patches are combination of Jianbo's work on IPsec eswitch mode
> together with our internal review toward addition of TCP protocol selectors
> support to IPSec packet offload.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net/mlx5: fs_core: Make find_closest_ft more generic
    https://git.kernel.org/netdev/net/c/618d28a535a0
  - [net,2/3] net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS fs_prio
    https://git.kernel.org/netdev/net/c/c635ca45a7a2
  - [net,3/3] net/mlx5e: Set proper IPsec source port in L4 selector
    https://git.kernel.org/netdev/net/c/62da08331f1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



