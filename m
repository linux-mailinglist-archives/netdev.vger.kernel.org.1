Return-Path: <netdev+bounces-21714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079CD764566
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 07:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23F22820D1
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 05:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2D9538B;
	Thu, 27 Jul 2023 05:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B805253
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DD98C43395;
	Thu, 27 Jul 2023 05:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690435221;
	bh=dqWE7kL20TM0ajSkADbtWBdNsFCoPOpsIVvBxz80qaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZWm4nA0yKSaa/mrbdXqmvI1T+nTKrj0Tihv6EQSoAnwAX9yBjMcv8cOOyr3cqOIWW
	 c+syc6ZYWYXbWw642iAhbsMBe3icrPpw6Ujr3Xlh4lKV0sZBCDGjvfUA5f2CH7hKF+
	 guVK5pHfaC0Q8+n1FGnKQBvxA01oxTUg9/g0rjtIXzZdxWRFPGU2Pwz4wi9JO09Nlb
	 vP0asVVwx3WPmzRtTNJzRlLmp/qu3nlztD67uKCmI2aI9HTsXhWUQ7IKGR5iut33tq
	 bBcEZOXV0gd4yEMRKMp+swHfnN1iFUdLw4AIb96K0XTLNN1dHO69ty6mOCNKInv9Ym
	 rlpgjhQgajzYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75951C595D0;
	Thu, 27 Jul 2023 05:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx4: clean up a type issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169043522147.2558.18006094227407431264.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jul 2023 05:20:21 +0000
References: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>
In-Reply-To: <52d0814a-7287-4160-94b5-ac7939ac61c6@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 08:39:47 +0300 you wrote:
> These functions returns type bool, not pointers, so return false instead
> of NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Not a bug.  Targetting net-next.
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx4: clean up a type issue
    https://git.kernel.org/netdev/net-next/c/bc758ade6145

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



