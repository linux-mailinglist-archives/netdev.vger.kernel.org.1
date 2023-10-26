Return-Path: <netdev+bounces-44588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6526D7D8BD4
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 00:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AFB81C20E7F
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8B72D792;
	Thu, 26 Oct 2023 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltSS0b8O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588908BFD
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 22:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0EFEC433C8;
	Thu, 26 Oct 2023 22:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698360626;
	bh=Zy6E/Q+H/X4NEFmVkmaU5sDSLwMcCrTBPG8UA9Z56SA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ltSS0b8OUBWJWGGCafuNFvnu/DsT/hpkrV0Q9pd9+6gqnIOppUomQysr3EJZjkzrX
	 DN/o/Ft937+AlDTjC00qRoP3Nb6RcVSW8Cg92lBKeE74y7NfQEstTbh4EY1UdZm517
	 d2Y7hYAgTpVfQ3AAxnyKSIC63JWoJl+0+LXnN8C0kHfohj7rVtetGWenldURKd7xOC
	 coLa2U29MQHxYSbdRkV7yHBzemtWlQOsmIXZcBdxVjpdAb7/Fc63o46G+XsWVAhZ6p
	 aMRMVoGZeTpeTmPfLAeUHdX1yKE/olO9TORSGuGqmMQEU6HE43ZendWhVW6bqV0AAx
	 mJECl08JoBMcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A39EFE11F52;
	Thu, 26 Oct 2023 22:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: fix uninit value use
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169836062666.25008.3760960827662370668.git-patchwork-notify@kernel.org>
Date: Thu, 26 Oct 2023 22:50:26 +0000
References: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20231025145050.36114-1-przemyslaw.kitszel@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 linux-kernel@vger.kernel.org, leon@kernel.org, tariqt@nvidia.com,
 danieller@nvidia.com, idosch@nvidia.com, petrm@nvidia.com, moshe@nvidia.com,
 eranbe@nvidia.com, ayal@mellanox.com, horms@kernel.org,
 dan.carpenter@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 16:50:50 +0200 you wrote:
> Avoid use of uninitialized state variable.
> 
> In case of mlx5e_tx_reporter_build_diagnose_output_sq_common() it's better
> to still collect other data than bail out entirely.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/netdev/8bd30131-c9f2-4075-a575-7fa2793a1760@moroto.mountain
> Fixes: d17f98bf7cc9 ("net/mlx5: devlink health: use retained error fmsg API")
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5: fix uninit value use
    https://git.kernel.org/netdev/net-next/c/5af8d8ce6434

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



