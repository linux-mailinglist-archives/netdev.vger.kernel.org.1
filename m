Return-Path: <netdev+bounces-23565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBFF76C846
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F12A281CF0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72E6566C;
	Wed,  2 Aug 2023 08:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75D53B9
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1363C433CB;
	Wed,  2 Aug 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690964423;
	bh=vquJa5VCSNKg3vb8dpO0WCFrl2Ixvo/kdr51owrTK0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PSI2YWPFzxEc4m039DgxZxYw5+mUxY0w/cOLUoz8XNvc5mv0eMOMCYr63TxhoTU5W
	 AwoUap51Z2bROj1ovlfBIS8Mg6KmLhzEPgmXGSGjf82XyH4DkzWdxzZ9B95CgwIUhv
	 ZgTBF4UiJxD3f2ciw35cZdGWp7EZvJegNnT1stLAvcjg3U8QQ3xEDx+JO567B/rXEt
	 mr4qTzwnQW1QChzDLgP5zsZxjhSgdLBRE7e6EPGI7G1t/NNgAfhnLQOdEITOrBlXz1
	 uLSmDLGtAlO76QfQ3ftDPqVmgvga+qmEkiXLPblJl/bVX5rmXs8cQsvcoXWN5IBzLT
	 ln9/s1ytUPfpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7711E96ABD;
	Wed,  2 Aug 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] selftests: New selftests for
 out-of-order-operations patches in mlxsw
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169096442287.23876.3228332853923657209.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 08:20:22 +0000
References: <cover.1690815746.git.petrm@nvidia.com>
In-Reply-To: <cover.1690815746.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 danieller@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 31 Jul 2023 17:47:14 +0200 you wrote:
> In the past, the mlxsw driver made the assumption that the user applies
> configuration in a bottom-up manner. Thus netdevices needed to be added to
> the bridge before IP addresses were configured on that bridge or SVI added
> on top of it, because whatever happened before a netdevice was mlxsw upper
> was generally ignored by mlxsw. Recently, several patch series were pushed
> to introduce the bookkeeping and replays necessary to offload the full
> state, not just the immediate configuration step.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] selftests: router_bridge: Add remastering tests
    https://git.kernel.org/netdev/net-next/c/eb1388553ef4
  - [net-next,2/8] selftests: router_bridge_1d: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/0a06e0c1af97
  - [net-next,3/8] selftests: router_bridge_vlan_upper: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/49e15dec8b90
  - [net-next,4/8] selftests: router_bridge_lag: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/3f0c4e70a9ef
  - [net-next,5/8] selftests: router_bridge_1d_lag: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/24e84656e432
  - [net-next,6/8] selftests: mlxsw: rif_lag: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/4308967d98c3
  - [net-next,7/8] selftests: mlxsw: rif_lag_vlan: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/6b3f46837c32
  - [net-next,8/8] selftests: mlxsw: rif_bridge: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/67d5ffb9ed51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



