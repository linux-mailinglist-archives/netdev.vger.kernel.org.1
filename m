Return-Path: <netdev+bounces-15951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D211F74A8E4
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 04:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D1228161B
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 02:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388C423C5;
	Fri,  7 Jul 2023 02:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757F186F
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 02:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1A14C4339A;
	Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688696424;
	bh=FiCo+LFcSX3ry79b0ImrXqaJqd1ZDdnicdFxuVHaWkM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OmJTWZJ4Ju7kToDCFHTG5iKE3b2JwZ1aNc7wUouAIVJ4Buo8uVQsfhnZa041D+gA1
	 3CJyo0LX8L0URm/yBNhhx+3LSPylQWEj2qF8+5jBKfuRaooL7dsNA0f76ooqx1lUcj
	 2azSNygVublua7ovGTr/e4mmexwrZ8i8ftpFYCCsQrEJGjENveNQp54kJI/O58RGK7
	 mKlzbXiP/DtD43rflEodRRmYNyAvWBlKnpr4HNq1RXKULxSGP1L1y6HAEUK3uOT3/1
	 M1t5hwDEVcUhLRT3CwbnFpPZDNPriWSFZ/K9hvlzGnj/Bsd9UIDXuV7kFXuZfiefyQ
	 AmlS2wxQzPpKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75FC6C74001;
	Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates
 2023-07-05 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168869642448.27656.10942850248924342809.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jul 2023 02:20:24 +0000
References: <20230705201346.49370-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230705201346.49370-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  5 Jul 2023 13:13:44 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Sridhar fixes incorrect comparison of max Tx rate limit to occur against
> each TC value rather than the aggregate. He also resolves an issue with
> the wrong VSI being used when setting max Tx rate when TCs are enabled.
> 
> The following are changes since commit c451410ca7e3d8eeb31d141fc20c200e21754ba4:
>   Merge branch 'mptcp-fixes'
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE
> 
> [...]

Here is the summary with links:
  - [net,1/2] ice: Fix max_rate check while configuring TX rate limits
    https://git.kernel.org/netdev/net/c/5f16da6ee6ac
  - [net,2/2] ice: Fix tx queue rate limit when TCs are configured
    https://git.kernel.org/netdev/net/c/479cdfe388a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



