Return-Path: <netdev+bounces-12838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9FE73914D
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 23:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFF31C20F8A
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324181C774;
	Wed, 21 Jun 2023 21:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F81D2AA
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 21:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23ECCC433CD;
	Wed, 21 Jun 2023 21:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687381826;
	bh=FF1vtoivooIrfFyY+ITTMmuHb3mJjaQ5x/a7hLvYFco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mik/7cyTq/KXD0Bl4BWVcifeA4qOi+uPmkiJRgy/+hmszMiqXGUlBIYq4hBX4VzJa
	 +J6FwINcgm7FlU9NYs7SoN6lC5lnkS+1GlUL4ywdEO0riJTdjgfeF6UtgTj8EzkDi3
	 okhjRtWYTlD6BUOQ2G58296830jBB+FNIWWqyFVDTmFOUgNmoLGEkucghzbcFUgVzM
	 px+K56LNvbP7FnHgClOEEZWlnpThJvZ/BHiOX6F2cC7HyzuZTQ1yxM3+P+i1YjrcSq
	 ToWyxnEltJiJdiOE/GKOGj+uKBLVho62aBfe33jVDhCwKuamYBNquJx+J55IFAEiT6
	 MYvzgMjZv5lzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F065FC395FF;
	Wed, 21 Jun 2023 21:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/16] selftests: Preparations for
 out-of-order-operations patches in mlxsw
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168738182597.695.7755172151141679906.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 21:10:25 +0000
References: <cover.1687265905.git.petrm@nvidia.com>
In-Reply-To: <cover.1687265905.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 danieller@nvidia.com, amcohen@nvidia.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jun 2023 15:55:46 +0200 you wrote:
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
  - [net-next,01/16] selftests: forwarding: q_in_vni: Disable IPv6 autogen on bridges
    https://git.kernel.org/netdev/net-next/c/8c3736ce595b
  - [net-next,02/16] selftests: forwarding: dual_vxlan_bridge: Disable IPv6 autogen on bridges
    https://git.kernel.org/netdev/net-next/c/c801533304ca
  - [net-next,03/16] selftests: forwarding: skbedit_priority: Disable IPv6 autogen on a bridge
    https://git.kernel.org/netdev/net-next/c/d7442b7d288e
  - [net-next,04/16] selftests: forwarding: pedit_dsfield: Disable IPv6 autogen on a bridge
    https://git.kernel.org/netdev/net-next/c/f61018dc3e21
  - [net-next,05/16] selftests: forwarding: mirror_gre_*: Disable IPv6 autogen on bridges
    https://git.kernel.org/netdev/net-next/c/92c3bb5393db
  - [net-next,06/16] selftests: forwarding: mirror_gre_*: Use port MAC for bridge address
    https://git.kernel.org/netdev/net-next/c/8fd32576e650
  - [net-next,07/16] selftests: forwarding: router_bridge: Use port MAC for bridge address
    https://git.kernel.org/netdev/net-next/c/5e71bf50c2e2
  - [net-next,08/16] selftests: mlxsw: q_in_q_veto: Disable IPv6 autogen on bridges
    https://git.kernel.org/netdev/net-next/c/8cfdd300a5e9
  - [net-next,09/16] selftests: mlxsw: extack: Disable IPv6 autogen on bridges
    https://git.kernel.org/netdev/net-next/c/a758dc469a9c
  - [net-next,10/16] selftests: mlxsw: mirror_gre_scale: Disable IPv6 autogen on a bridge
    https://git.kernel.org/netdev/net-next/c/32b3a7bf8570
  - [net-next,11/16] selftests: mlxsw: qos_dscp_bridge: Disable IPv6 autogen on a bridge
    https://git.kernel.org/netdev/net-next/c/6349f9bbbfb2
  - [net-next,12/16] selftests: mlxsw: qos_ets_strict: Disable IPv6 autogen on bridges
    https://git.kernel.org/netdev/net-next/c/ec7023e6745e
  - [net-next,13/16] selftests: mlxsw: qos_mc_aware: Disable IPv6 autogen on bridges
    https://git.kernel.org/netdev/net-next/c/ea2d5f757e91
  - [net-next,14/16] selftests: mlxsw: spectrum: q_in_vni_veto: Disable IPv6 autogen on a bridge
    https://git.kernel.org/netdev/net-next/c/08035d8e354d
  - [net-next,15/16] selftests: mlxsw: vxlan: Disable IPv6 autogen on bridges
    https://git.kernel.org/netdev/net-next/c/5541577521cc
  - [net-next,16/16] selftests: mlxsw: one_armed_router: Use port MAC for bridge address
    https://git.kernel.org/netdev/net-next/c/664bc72dd200

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



