Return-Path: <netdev+bounces-17082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D13975028B
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEFF1C20F53
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82E71F93E;
	Wed, 12 Jul 2023 09:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45733F9
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 718C2C433C8;
	Wed, 12 Jul 2023 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689153021;
	bh=i6qkcO1AzR3mQbzwD6fjPPSgQMz1SQMWv56HhZ+LxNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rzja4VnWot62ARo4MSHHd5QX7VAayTMQEqGZcDwYKXiN2A+rCXU57sB52W/HVTssO
	 xN4tkAmTOELEzhXJh8lBRRQMaQBizagkpDQcS1ZpRd/oUL/neJwKMWIr2eI0YJBWTE
	 /FiqwcG3kKw3igeb9lXxEWvhPShbDL3JT5XksZ5zlnm5kFguHBm8PsLG+3VewhzhuF
	 qij0LeFzMVp8GKb0Par1BHPvfluQblAbxPYY5yX6vfCaH90ooGoJhDSo4gZB41yxKD
	 fQdsUZ7zr9lnLUs3Xr/kH7rWeAW36b/iXcHNgDa9SLPrL6coQf42QmVUzZp+qRzfd4
	 gJJ+dcGjkYLFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A2FDE29F44;
	Wed, 12 Jul 2023 09:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] igc: Fix corner cases for TSN offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168915302135.28970.216256072743721496.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 09:10:21 +0000
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, florian.kauer@linutronix.de,
 kurt@linutronix.de, vinicius.gomes@intel.com,
 muhammad.husaini.zulkifli@intel.com, tee.min.tan@linux.intel.com,
 aravindhan.gunasekaran@intel.com, sasha.neftin@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 10 Jul 2023 09:34:57 -0700 you wrote:
> Florian Kauer says:
> 
> The igc driver supports several different offloading capabilities
> relevant in the TSN context. Recent patches in this area introduced
> regressions for certain corner cases that are fixed in this series.
> 
> Each of the patches (except the first one) addresses a different
> regression that can be separately reproduced. Still, they have
> overlapping code changes so they should not be separately applied.
> 
> [...]

Here is the summary with links:
  - [net,1/6] igc: Rename qbv_enable to taprio_offload_enable
    https://git.kernel.org/netdev/net/c/8046063df887
  - [net,2/6] igc: Do not enable taprio offload for invalid arguments
    https://git.kernel.org/netdev/net/c/82ff5f29b737
  - [net,3/6] igc: Handle already enabled taprio offload for basetime 0
    https://git.kernel.org/netdev/net/c/e5d88c53d03f
  - [net,4/6] igc: No strict mode in pure launchtime/CBS offload
    https://git.kernel.org/netdev/net/c/8b86f10ab64e
  - [net,5/6] igc: Fix launchtime before start of cycle
    https://git.kernel.org/netdev/net/c/c1bca9ac0bcb
  - [net,6/6] igc: Fix inserting of empty frame for launchtime
    https://git.kernel.org/netdev/net/c/0bcc62858d6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



