Return-Path: <netdev+bounces-17888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD619753683
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 11:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EAB1C215F3
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A75F9FD;
	Fri, 14 Jul 2023 09:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F20F517
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 09:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58A8BC433C8;
	Fri, 14 Jul 2023 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689327023;
	bh=snaqS0FipUwIYZj9+wphO2vgW3GFTe5UNCgihmJ1y/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k7K8f2GRMnT0cZdUpC/4TTTHppF2a3kFAQNJJC3helfHbL/7qHVj9bREIu2id06+v
	 JXizis8drusRiTvZ4gC+QJs7aJ/kNmwx1tu3ML03NVgKjaWpi7jq7vKosVwtRoCoqI
	 rCS4e9HWnlzN7ZSFXQRD9dQtcePR4txfAtmOPidg5e3uYp8e/Mh+Xs7De2FkUwFJ1b
	 fxgcknayv4SYnMboxkmTb7LWzTtzj6iMs5k9w9c5n86acFc8270BtlN6iUlP15xbii
	 Da2bBvGXdnwN18bVhVKoscD1biJnWhxC804xIXsax/RDUwpHa8oE5192rnxOtWG+lG
	 ZzU57IBbEN29g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44CB4E4508D;
	Fri, 14 Jul 2023 09:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11] mlxsw: Manage RIF across PVID changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932702327.18845.4113705854619029519.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 09:30:23 +0000
References: <cover.1689262695.git.petrm@nvidia.com>
In-Reply-To: <cover.1689262695.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 danieller@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 18:15:23 +0200 you wrote:
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
  - [net-next,01/11] mlxsw: spectrum_switchdev: Pass extack to mlxsw_sp_br_ban_rif_pvid_change()
    https://git.kernel.org/netdev/net-next/c/352be882deda
  - [net-next,02/11] mlxsw: spectrum_router: Pass struct mlxsw_sp_rif_params to fid_get
    https://git.kernel.org/netdev/net-next/c/5ca9f42caf81
  - [net-next,03/11] mlxsw: spectrum_router: Take VID for VLAN FIDs from RIF params
    https://git.kernel.org/netdev/net-next/c/a0944b24d278
  - [net-next,04/11] mlxsw: spectrum_router: Adjust mlxsw_sp_inetaddr_vlan_event() coding style
    https://git.kernel.org/netdev/net-next/c/a24a4d29ff0a
  - [net-next,05/11] mlxsw: spectrum_router: mlxsw_sp_inetaddr_bridge_event: Add an argument
    https://git.kernel.org/netdev/net-next/c/3430f2cf91a4
  - [net-next,06/11] mlxsw: spectrum_switchdev: Manage RIFs on PVID change
    https://git.kernel.org/netdev/net-next/c/a5b52692e693
  - [net-next,07/11] selftests: forwarding: lib: Add ping6_, ping_test_fails()
    https://git.kernel.org/netdev/net-next/c/5f44a7144cc5
  - [net-next,08/11] selftests: router_bridge: Add tests to remove and add PVID
    https://git.kernel.org/netdev/net-next/c/c7203a2981dc
  - [net-next,09/11] selftests: router_bridge_vlan: Add PVID change test
    https://git.kernel.org/netdev/net-next/c/d4172a93b279
  - [net-next,10/11] selftests: router_bridge_vlan_upper_pvid: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/b0307b77265b
  - [net-next,11/11] selftests: router_bridge_pvid_vlan_upper: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/9cbb3da4f4f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



