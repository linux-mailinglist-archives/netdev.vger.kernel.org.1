Return-Path: <netdev+bounces-18816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D7A758BAD
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 05:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45481C20F1A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32717D1;
	Wed, 19 Jul 2023 03:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4998817C4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 03:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD18EC433C8;
	Wed, 19 Jul 2023 03:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689735621;
	bh=Jc8J6596JL5uXfaos7nTdsDTvI3lPZpCd5XkggmjOr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XaSgPFR21X3Mg+F5DWJszMNkm2+Qepeoc4mVWKDw6jP6Og0XJw6RKcSz3aCl/GMO2
	 qXEKQyGDn9iExLw2DLXU1SsrBUXsF1Rn9xFyctNzx6HQz/1leRLbvmjPiVhsjP8yS+
	 e49EUFomnJMzyhgPXAz7Go2e9v5uygzIbXsLlk7EDEuZ941TKPVAxtPvOShnCQHdp9
	 6ddeTAZrWjo4RdBdhTCGyuYn8S59D1twq3kJjZriVdC+637LQ4oS8uWtvYQc9Vvo4X
	 8tV9P36tKU+V2cYhXEtcnthsh/2Ml0OsdcQHX5YIDFp8mJmQUnYyg5On9u/Jawto6T
	 LyMYH/NRwR84Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 850FCE22AE5;
	Wed, 19 Jul 2023 03:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2023-07-17 (iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168973562154.16333.5416367534125461810.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 03:00:21 +0000
References: <20230717175205.3217774-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230717175205.3217774-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 17 Jul 2023 10:51:57 -0700 you wrote:
> This series contains updates to iavf driver only.
> 
> Ding Hui fixes use-after-free issue by calling netif_napi_del() for all
> allocated q_vectors. He also resolves out-of-bounds issue by not
> updating to new values when timeout is encountered.
> 
> Marcin and Ahmed change the way resets are handled so that the callback
> operating under the RTNL lock will wait for the reset to finish, the
> rtnl_lock sensitive functions in reset flow will schedule the netdev update
> for later in order to remove circular dependency with the critical lock.
> 
> [...]

Here is the summary with links:
  - [net,1/8] iavf: Fix use-after-free in free_netdev
    https://git.kernel.org/netdev/net/c/5f4fa1672d98
  - [net,2/8] iavf: Fix out-of-bounds when setting channels on remove
    https://git.kernel.org/netdev/net/c/7c4bced3caa7
  - [net,3/8] iavf: use internal state to free traffic IRQs
    https://git.kernel.org/netdev/net/c/a77ed5c5b768
  - [net,4/8] iavf: Wait for reset in callbacks which trigger it
    https://git.kernel.org/netdev/net/c/c2ed2403f12c
  - [net,5/8] Revert "iavf: Detach device during reset task"
    https://git.kernel.org/netdev/net/c/d2806d960e83
  - [net,6/8] Revert "iavf: Do not restart Tx queues after reset task failure"
    https://git.kernel.org/netdev/net/c/d916d273041b
  - [net,7/8] iavf: fix a deadlock caused by rtnl and driver's lock circular dependencies
    https://git.kernel.org/netdev/net/c/d1639a17319b
  - [net,8/8] iavf: fix reset task race with iavf_remove()
    https://git.kernel.org/netdev/net/c/c34743daca0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



