Return-Path: <netdev+bounces-34497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636907A465A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 11:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFE8281D9D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DF11C2AC;
	Mon, 18 Sep 2023 09:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E14EAEA
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CE47C433C7;
	Mon, 18 Sep 2023 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695030621;
	bh=dy6EberQqWflr07e+yrLHm+oYTDGFkZhFRgjZqyoxYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r6o+igkBa3Gecwv1COWgx0H/7OnyGox1DGNT2ZPMcLjrWvttfIZPcLSm9tCQEZj3H
	 M9LqyP5zpUkZAGFG1dOAxzcloJDJbkLoE23I/YnNBPVg/tpwZAdusNjc0PL3zRrDZl
	 +VXmoP5aR5PBjN1Z9mOEm21Z32neu1KdYWkRj/Qs3mdpWFEqEN47lYyohv0TLc16xL
	 0v9kS0Kzyahh2CiGgEStVsgGlC/j6y8zv7rt29HP4DfwxLIoqb21WioccNSj5/Vehg
	 0GOE1Ra4hWyJOC3zj7YgXwMWVCKjp4FdMubpNlzHnNmRd3UWdMPJurpO8uT2krrCsV
	 PhcGcIcV+HUcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55B73E11F41;
	Mon, 18 Sep 2023 09:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] tsnep: Fixes based on napi.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169503062134.29748.544325724683850777.git-patchwork-notify@kernel.org>
Date: Mon, 18 Sep 2023 09:50:21 +0000
References: <20230915210126.74997-1-gerhard@engleder-embedded.com>
In-Reply-To: <20230915210126.74997-1-gerhard@engleder-embedded.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 23:01:23 +0200 you wrote:
> Based on the documentation networking/napi.rst some fixes have been
> done. tsnep driver should be in line with this new documentation after
> these fixes.
> 
> Gerhard Engleder (3):
>   tsnep: Fix NAPI scheduling
>   tsnep: Fix ethtool channels
>   tsnep: Fix NAPI polling with budget 0
> 
> [...]

Here is the summary with links:
  - [net,1/3] tsnep: Fix NAPI scheduling
    https://git.kernel.org/netdev/net/c/ea852c17f538
  - [net,2/3] tsnep: Fix ethtool channels
    https://git.kernel.org/netdev/net/c/a7f991953d73
  - [net,3/3] tsnep: Fix NAPI polling with budget 0
    https://git.kernel.org/netdev/net/c/46589db3817b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



