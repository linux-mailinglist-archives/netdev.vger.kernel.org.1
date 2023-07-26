Return-Path: <netdev+bounces-21172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AAA762A39
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 06:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCBC1C210C8
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C883B5384;
	Wed, 26 Jul 2023 04:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA54C9C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 04:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7FC6C433C9;
	Wed, 26 Jul 2023 04:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690345222;
	bh=TxTgEix67oHWYAhn9Vvqv0Tja5Xs3utiTWqPpYiMd0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mdg/g4X89aF7rfgeZ9+JHATbbK61PcMrpZBa3+FPV4FcoSOKdWo6gtnqhEqbAJpu7
	 UKejFYK5PfWKGmdnzlEUuwMxgL1ky7PCXISgmNZZkfbBGlp3Bn/FVWtOn02gCGNRep
	 RpTkl2DXP7zbqJP9xKbtwSAGfQx0iSUmIroDBh9XInfTCH72PL1aPhmF4C0TKqkop0
	 3cz9uP41ifbOhQsSKOEBc8GJguKNjnxmv3lKSjxbfMm2vmN6/N5Ni0og9SJ2RG2eHT
	 JTo183GN1/MlynHE43Fnnq/hpTag4rNdlorA6Wp5kgDEsA0nP4oan0EHK+W+yI5F99
	 Xq8Qfq9M1Easg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8CD3E1F65A;
	Wed, 26 Jul 2023 04:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/12][pull request] ice: switchdev bridge offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169034522268.20909.15658126550504570158.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jul 2023 04:20:22 +0000
References: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, wojciech.drewek@intel.com,
 jiri@resnulli.us, ivecera@redhat.com, simon.horman@corigine.com,
 vladbu@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 24 Jul 2023 09:11:40 -0700 you wrote:
> Wojciech Drewek says:
> 
> Linux bridge provides ability to learn MAC addresses and vlans
> detected on bridge's ports. As a result of this, FDB (forward data base)
> entries are created and they can be offloaded to the HW. By adding
> VF's port representors to the bridge together with the uplink netdev,
> we can learn VF's and link partner's MAC addresses. This is achieved
> by slow/exception-path, where packets that do not match any filters
> (FDB entries in this case) are send to the bridge ports.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/12] ice: Skip adv rules removal upon switchdev release
    https://git.kernel.org/netdev/net-next/c/ee95d4420a2f
  - [net-next,v2,02/12] ice: Prohibit rx mode change in switchdev mode
    https://git.kernel.org/netdev/net-next/c/2571a3fa6251
  - [net-next,v2,03/12] ice: Don't tx before switchdev is fully configured
    https://git.kernel.org/netdev/net-next/c/7aa529a69e92
  - [net-next,v2,04/12] ice: Disable vlan pruning for uplink VSI
    https://git.kernel.org/netdev/net-next/c/6ab1155798c3
  - [net-next,v2,05/12] ice: Unset src prune on uplink VSI
    https://git.kernel.org/netdev/net-next/c/6c0f4441d83b
  - [net-next,v2,06/12] ice: Implement basic eswitch bridge setup
    https://git.kernel.org/netdev/net-next/c/f6e8fb55e5af
  - [net-next,v2,07/12] ice: Switchdev FDB events support
    https://git.kernel.org/netdev/net-next/c/7c945a1a8e5f
  - [net-next,v2,08/12] ice: Add guard rule when creating FDB in switchdev
    https://git.kernel.org/netdev/net-next/c/bccd9bce29e0
  - [net-next,v2,09/12] ice: Add VLAN FDB support in switchdev mode
    https://git.kernel.org/netdev/net-next/c/e9dda2cfab82
  - [net-next,v2,10/12] ice: implement bridge port vlan
    https://git.kernel.org/netdev/net-next/c/2946204b3fa8
  - [net-next,v2,11/12] ice: implement static version of ageing
    https://git.kernel.org/netdev/net-next/c/e42c6e0c902b
  - [net-next,v2,12/12] ice: add tracepoints for the switchdev bridge
    https://git.kernel.org/netdev/net-next/c/d129c2a245bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



