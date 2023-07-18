Return-Path: <netdev+bounces-18558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AEB7579FF
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 13:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB211C20856
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F64C159;
	Tue, 18 Jul 2023 11:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79CAC2C9
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41094C433C9;
	Tue, 18 Jul 2023 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689678020;
	bh=zk6wGeCmBBtqjYRH6LibtcGecRu1EdaX12Oxs17P5t4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TK4P2HVkqVeWWNcLN4k5fAbfEnaatB7Jsh7ZX2R03n4wGHtCxOsVyBFezJIzkdi7C
	 bg5M7BXpZq8Dqw4fe7Vhb9he4soo+LaHtIM67pjbY9WjzZ53Ub5/fwdnNHkSk7WU/e
	 mcepxFl9jxRBEV2xDR0Hcm9B3XfUC3GzEx48n3qU5WDMGrNYzvb9rgp1d/XH7vD0Fk
	 p3tl4bxuLiFkSUoqZ8Gkq6PD1NHa7t7UO46Bo+IjMawiFbzmwV/ceiGdxScevBvuUP
	 WUSbzhEERlWboJ2skgOL552Ps3tLwjsLYYuh7PKSWuWUbHDH4bdweWo2/rfl605JDx
	 i/aQ9XyPrp19Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 275D3E22AE6;
	Tue, 18 Jul 2023 11:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vrf: Fix lockdep splat in output path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168967802015.16226.4900475528031109696.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jul 2023 11:00:20 +0000
References: <20230715153605.4068066-1-idosch@nvidia.com>
In-Reply-To: <20230715153605.4068066-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 naresh.kamboju@linaro.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 15 Jul 2023 18:36:05 +0300 you wrote:
> Cited commit converted the neighbour code to use the standard RCU
> variant instead of the RCU-bh variant, but the VRF code still uses
> rcu_read_lock_bh() / rcu_read_unlock_bh() around the neighbour lookup
> code in its IPv4 and IPv6 output paths, resulting in lockdep splats
> [1][2]. Can be reproduced using [3].
> 
> Fix by switching to rcu_read_lock() / rcu_read_unlock().
> 
> [...]

Here is the summary with links:
  - [net] vrf: Fix lockdep splat in output path
    https://git.kernel.org/netdev/net/c/2033ab90380d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



