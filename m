Return-Path: <netdev+bounces-198855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEB2ADE0C1
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F4717851F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4DD1A2C0B;
	Wed, 18 Jun 2025 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfqVV9Qk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9D1A257D
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210844; cv=none; b=W0Nxc68Y/8gGozl3/BBcB6EtM9emKs1WzpcTTdreNs285435DTVNvfSB9OdaBXDJy9LQ/iKGe7SqJ8Fsseq39mn8VIhZ0iY3F88j6sFc/Ck0NBOATwIYptvxDMWdA2E2teymS9OpJpbcnAxVcaZMuT0rmrhDiorIwyFt5IhQM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210844; c=relaxed/simple;
	bh=t41Fj3F1m2eth8O6DUdE38buJ4uioOavkJNwo+vPmJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LsVPG7H5dPvp5/QwQwJF8RpygvKKe46cZsdFI7hI0CBONvXd3334jUzfBkzC53qr6+O+8u4S3ZXKbqBinRR7xnPuZS+FmzxJbaNuMI8wCLePk4A4hryKG+xN7OnsBzPk7AIRu8d3QjoFnRYyUZB/j7LeJaF3Hb0+URPUpFskUsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfqVV9Qk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD63C4CEE3;
	Wed, 18 Jun 2025 01:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750210844;
	bh=t41Fj3F1m2eth8O6DUdE38buJ4uioOavkJNwo+vPmJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tfqVV9QkOEToA4i07Wx3eI6DzCsJDAIPuzX6aSjYL3QBNK/Ibn3KNbdCSDgbv6ljJ
	 HPUemsMbl5snz59NVR484LH/8pjy68WpxqGegmTjAh9ERGQab/q7e1FxHFz5MOeNhF
	 B/A51QCBTldnkXZSMaFm6nx62rMkOu7xKmZFBCy1ZKvMWzOQbbC8z1abKFzDk4K2bM
	 c9bug9b1IrOTggOzTU3Wwtk7WBztiIPTVX8/JQ8Hdj+38YhRfrCMGLjI/o7zNWByE8
	 CyffSDYirtg51p8qifgor+MvXwwVoStxiZmIkWkP1pkw4Zu7WH5mHEvywGX3i/BG8n
	 3Vsc5xdAo6xHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE8738111DD;
	Wed, 18 Jun 2025 01:41:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/15] ipmr,
 ip6mr: Allow MC-routing locally-generated MC packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175021087241.3761578.9440566211529797488.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 01:41:12 +0000
References: <cover.1750113335.git.petrm@nvidia.com>
In-Reply-To: <cover.1750113335.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@gmail.com, netdev@vger.kernel.org,
 horms@kernel.org, razor@blackwall.org, idosch@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 00:44:08 +0200 you wrote:
> Multicast routing is today handled in the input path. Locally generated MC
> packets don't hit the IPMR code. Thus if a VXLAN remote address is
> multicast, the driver needs to set an OIF during route lookup. In practice
> that means that MC routing configuration needs to be kept in sync with the
> VXLAN FDB and MDB. Ideally, the VXLAN packets would be routed by the MC
> routing code instead.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/15] net: ipv4: Add a flags argument to iptunnel_xmit(), udp_tunnel_xmit_skb()
    https://git.kernel.org/netdev/net-next/c/e3411e326fa4
  - [net-next,v3,02/15] net: ipv4: ipmr: ipmr_queue_xmit(): Drop local variable `dev'
    https://git.kernel.org/netdev/net-next/c/3b7bc938e0ad
  - [net-next,v3,03/15] net: ipv4: ipmr: Split ipmr_queue_xmit() in two
    https://git.kernel.org/netdev/net-next/c/b2e653bcff0f
  - [net-next,v3,04/15] net: ipv4: Add ip_mr_output()
    https://git.kernel.org/netdev/net-next/c/35bec72a24ac
  - [net-next,v3,05/15] net: ipv6: Make udp_tunnel6_xmit_skb() void
    https://git.kernel.org/netdev/net-next/c/6a7d88ca15f7
  - [net-next,v3,06/15] net: ipv6: Add a flags argument to ip6tunnel_xmit(), udp_tunnel6_xmit_skb()
    https://git.kernel.org/netdev/net-next/c/f78c75d84fe8
  - [net-next,v3,07/15] net: ipv6: ip6mr: Fix in/out netdev to pass to the FORWARD chain
    https://git.kernel.org/netdev/net-next/c/3365afd3abda
  - [net-next,v3,08/15] net: ipv6: ip6mr: Make ip6mr_forward2() void
    https://git.kernel.org/netdev/net-next/c/094f39d5e84d
  - [net-next,v3,09/15] net: ipv6: ip6mr: Split ip6mr_forward2() in two
    https://git.kernel.org/netdev/net-next/c/1b02f4475d29
  - [net-next,v3,10/15] net: ipv6: Add ip6_mr_output()
    https://git.kernel.org/netdev/net-next/c/96e8f5a9fe2d
  - [net-next,v3,11/15] vxlan: Support MC routing in the underlay
    https://git.kernel.org/netdev/net-next/c/f8337efa4ff5
  - [net-next,v3,12/15] selftests: forwarding: lib: Move smcrouted helpers here
    https://git.kernel.org/netdev/net-next/c/2a719b7bacc7
  - [net-next,v3,13/15] selftests: net: lib: Add ip_link_has_flag()
    https://git.kernel.org/netdev/net-next/c/4baa1d3a5080
  - [net-next,v3,14/15] selftests: forwarding: adf_mcd_start(): Allow configuring custom interfaces
    https://git.kernel.org/netdev/net-next/c/237f84a6d24a
  - [net-next,v3,15/15] selftests: forwarding: Add a test for verifying VXLAN MC underlay
    https://git.kernel.org/netdev/net-next/c/e3180379e2df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



