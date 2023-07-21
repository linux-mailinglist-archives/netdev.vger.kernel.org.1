Return-Path: <netdev+bounces-19753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA7275C0E6
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 10:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8550C2821A4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 08:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAEB14F60;
	Fri, 21 Jul 2023 08:10:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186B3D84
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 322BEC433C8;
	Fri, 21 Jul 2023 08:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689927027;
	bh=avPFUNEVLFSj0cHNmDVlwIb59Q3Iy0pyos4wLzwDhx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mA5//XFeHZTzFuNXPMtXVJdmBec58Y8gQdUjdDS4QadBAAvjM2xvlak/2GcYXRIoV
	 bkm7B11FfIdsKWvCw/IXknMquIIPOMW7IDNA4KOdhXAMSQjFNtxe4kt/Xf5dPAiWOO
	 d5XRaeVYZVBz9F5iBvDLVuwGC5nEZxWgi6Rj4hWZWH7P6bwKR63NlgUEc2WhH13Kh7
	 OQMCwjqAT1VETn3nlIxpxUet7krsiBL5cd7lUqsYiSHdhSaA4BFD4MhHo8N+lGovV6
	 8FWWMRfytE4Ue8sa436L3OGCL4GYxGCexiXhRQGl5Yov02B7g21e8y3aXAYwukp7zz
	 xq8IugiB2EciQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18B61E21EF5;
	Fri, 21 Jul 2023 08:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/17] mlxsw: Permit enslavement to netdevices with
 uppers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168992702709.18964.17425993748953523147.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jul 2023 08:10:27 +0000
References: <cover.1689763088.git.petrm@nvidia.com>
In-Reply-To: <cover.1689763088.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 danieller@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 19 Jul 2023 13:01:15 +0200 you wrote:
> The mlxsw driver currently makes the assumption that the user applies
> configuration in a bottom-up manner. Thus netdevices need to be added to
> the bridge before IP addresses are configured on that bridge or SVI added
> on top of it. Enslaving a netdevice to another netdevice that already has
> uppers is in fact forbidden by mlxsw for this reason. Despite this safety,
> it is rather easy to get into situations where the offloaded configuration
> is just plain wrong.
> 
> [...]

Here is the summary with links:
  - [net-next,01/17] net: bridge: br_switchdev: Tolerate -EOPNOTSUPP when replaying MDB
    https://git.kernel.org/netdev/net-next/c/989280d6ea70
  - [net-next,02/17] net: switchdev: Add a helper to replay objects on a bridge port
    https://git.kernel.org/netdev/net-next/c/f2e2857b3522
  - [net-next,03/17] selftests: mlxsw: rtnetlink: Drop obsolete tests
    https://git.kernel.org/netdev/net-next/c/d7eb1f175153
  - [net-next,04/17] mlxsw: spectrum_router: Allow address handlers to run on bridge ports
    https://git.kernel.org/netdev/net-next/c/6bbc9ca6a3a7
  - [net-next,05/17] mlxsw: spectrum_router: Extract a helper to schedule neighbour work
    https://git.kernel.org/netdev/net-next/c/96c3e45c0130
  - [net-next,06/17] mlxsw: spectrum: Split a helper out of mlxsw_sp_netdevice_event()
    https://git.kernel.org/netdev/net-next/c/721717fafdc4
  - [net-next,07/17] mlxsw: spectrum: Allow event handlers to check unowned bridges
    https://git.kernel.org/netdev/net-next/c/40b7b4236c1f
  - [net-next,08/17] mlxsw: spectrum: Add a replay_deslavement argument to event handlers
    https://git.kernel.org/netdev/net-next/c/1c47e65b8c0b
  - [net-next,09/17] mlxsw: spectrum: On port enslavement to a LAG, join upper's bridges
    https://git.kernel.org/netdev/net-next/c/987c7782f062
  - [net-next,10/17] mlxsw: spectrum_switchdev: Replay switchdev objects on port join
    https://git.kernel.org/netdev/net-next/c/ec4643ca3d98
  - [net-next,11/17] mlxsw: spectrum_router: Join RIFs of LAG upper VLANs
    https://git.kernel.org/netdev/net-next/c/ef59713c26b1
  - [net-next,12/17] mlxsw: spectrum_router: Offload ethernet nexthops when RIF is made
    https://git.kernel.org/netdev/net-next/c/cfc01a92eaff
  - [net-next,13/17] mlxsw: spectrum_router: Replay MACVLANs when RIF is made
    https://git.kernel.org/netdev/net-next/c/49c3a615d382
  - [net-next,14/17] mlxsw: spectrum_router: Replay neighbours when RIF is made
    https://git.kernel.org/netdev/net-next/c/8fdb09a7674c
  - [net-next,15/17] mlxsw: spectrum_router: Replay IP NETDEV_UP on device enslavement
    https://git.kernel.org/netdev/net-next/c/31618b22f2c4
  - [net-next,16/17] mlxsw: spectrum_router: Replay IP NETDEV_UP on device deslavement
    https://git.kernel.org/netdev/net-next/c/4560cf408eca
  - [net-next,17/17] mlxsw: spectrum: Permit enslavement to netdevices with uppers
    https://git.kernel.org/netdev/net-next/c/2c5ffe8d7226

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



