Return-Path: <netdev+bounces-30197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC5B78655F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 04:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613261C20D8A
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB06417F6;
	Thu, 24 Aug 2023 02:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22DBA927
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08A02C433C7;
	Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692844224;
	bh=Mf+4HSNHW/8gsTF1eN2rjY4M1HRlYwTnQWlDdie2JGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V/62bohpS8lwCRaM3fFoUrGfq15QHvYc7sn0l2AYKaRub1hZ9hbOTA+TwRaG4cZ63
	 JzXVFvRjObYLkDweIWe61EE2kNAKafRI1jkZ2VHH3z/QpKF6QbV6n6KTNo1ySLCCY9
	 ESrDZOBgawp03E+IZwClUhlHNCljeXFeuIdOUsAbh/uYFDRY5sln6FbyDcNDBnuaTa
	 e1WLyjedHeZqAIvqOP7Ah+iZF207keYQtveYogppJTSHiWmeq00TJ7C7MYAZCQ65uN
	 lPPAiXSn/ittrdnNjgXpD46Ea9Ybsz9I3kpYOBanEtmi4Lp9sF5E2Y/Un9dzIjrYBn
	 ezJrlcS1fpOsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1F15C395C5;
	Thu, 24 Aug 2023 02:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net/mlx5e: Use PTR_ERR_OR_ZERO() to simplify
 code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169284422392.2546.14098414271711051915.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 02:30:23 +0000
References: <20230822021455.205101-1-liaoyu15@huawei.com>
In-Reply-To: <20230822021455.205101-1-liaoyu15@huawei.com>
To: Yu Liao <liaoyu15@huawei.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, liwei391@huawei.com, davem@davemloft.net,
 maciej.fijalkowski@intel.com, michal.simek@amd.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Aug 2023 10:14:54 +0800 you wrote:
> Use the standard error pointer macro to shorten the code and simplify.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_fs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next,1/2] net/mlx5e: Use PTR_ERR_OR_ZERO() to simplify code
    (no matching commit)
  - [net-next,2/2] net: dm9051: Use PTR_ERR_OR_ZERO() to simplify code
    https://git.kernel.org/netdev/net-next/c/664c84c26d7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



