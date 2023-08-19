Return-Path: <netdev+bounces-29019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8B078169C
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B9D281DA8
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2280EA4D;
	Sat, 19 Aug 2023 02:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898487E4
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0768DC433CA;
	Sat, 19 Aug 2023 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692411628;
	bh=ta0MTCo6hBdqQKA8MQVLqiV5X1Rss3bcAnjWmw069w4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XA8WM027Cf8WydYzppJuZPuQGrPaggPiGvx/4kbY+tV5QXTtQtXwN46O/t1FIWR0S
	 AFIxVWT7fb2MxmZcRAmo9dGewP9jB+9pRJbatnIn5P7Z5+Gfggi3mC768g4qxQ1dCM
	 M6q9SUNxvN2DJM7JbJRrkWa6emgmK5foA9y+UVAPPVp24Rr8Ke+K+RashKO/nNbuDl
	 Ty6AizghQD5YDuxD60htkQ4MdZ+bJdityASlRroqf1Q/1D8/yq3pJ0cG1LKPxlYPP/
	 LzkDC8I4m5tvg5AMQHdtMNuLr5+1mzFEpFe3h1jepy2Nk0IU7nEViHyVDTZJVld2Sd
	 ft6y6Euk6g4jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2176E26D34;
	Sat, 19 Aug 2023 02:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/15][pull request] Intel Wired LAN Driver
 Updates 2023-08-17 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169241162792.7451.6568488293960382600.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 02:20:27 +0000
References: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 17 Aug 2023 14:22:24 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Jan removes unused functions and refactors code to make, possible,
> functions static.
> 
> Jake rearranges some functions to be logically grouped.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/15] ice: remove unused methods
    https://git.kernel.org/netdev/net-next/c/74e7940e0d21
  - [net-next,v2,02/15] ice: refactor ice_ddp to make functions static
    https://git.kernel.org/netdev/net-next/c/708b352fc693
  - [net-next,v2,03/15] ice: refactor ice_lib to make functions static
    https://git.kernel.org/netdev/net-next/c/45f5478c039c
  - [net-next,v2,04/15] ice: refactor ice_vf_lib to make functions static
    https://git.kernel.org/netdev/net-next/c/cc9c60c9edfe
  - [net-next,v2,05/15] ice: Utilize assign_bit() helper
    https://git.kernel.org/netdev/net-next/c/54e852da0715
  - [net-next,v2,06/15] ice: refactor ice_sched to make functions static
    https://git.kernel.org/netdev/net-next/c/9762f8fa832c
  - [net-next,v2,07/15] ice: refactor ice_ptp_hw to make functions static
    https://git.kernel.org/netdev/net-next/c/cae48047052f
  - [net-next,v2,08/15] ice: refactor ice_vsi_is_vlan_pruning_ena
    https://git.kernel.org/netdev/net-next/c/e528e5b23755
  - [net-next,v2,09/15] ice: move E810T functions to before device agnostic ones
    https://git.kernel.org/netdev/net-next/c/403e48539b16
  - [net-next,v2,10/15] ice: Remove redundant VSI configuration in eswitch setup
    https://git.kernel.org/netdev/net-next/c/467a17eea5c3
  - [net-next,v2,11/15] ice: use list_for_each_entry() helper
    https://git.kernel.org/netdev/net-next/c/1533b7743d35
  - [net-next,v2,12/15] ice: drop two params from ice_aq_alloc_free_res()
    https://git.kernel.org/netdev/net-next/c/52da2fb2693a
  - [net-next,v2,13/15] ice: ice_aq_check_events: fix off-by-one check when filling buffer
    https://git.kernel.org/netdev/net-next/c/e1e8a142c433
  - [net-next,v2,14/15] ice: embed &ice_rq_event_info event into struct ice_aq_task
    https://git.kernel.org/netdev/net-next/c/b214b98a7fc4
  - [net-next,v2,15/15] ice: split ice_aq_wait_for_event() func into two
    https://git.kernel.org/netdev/net-next/c/fb9840c4ec13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



