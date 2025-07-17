Return-Path: <netdev+bounces-208035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73796B097FB
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F027BAF40
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B37258CE5;
	Thu, 17 Jul 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRO0Kja+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840925229D
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795000; cv=none; b=J+rcm+jD1AyBEhcUdUNYP7st7pB8ha0yQWFxIRa8vYpe7jXY1L/lKv1FyS1/ju3B08UA+CplITVuEwMzeBAfVFY3/xnG8FvkPC+9h7NIYMqva7h/j1YFVgIx5k9+zk9GbYefJVY7mb8JKqK4SMFQ7I/U3UVkkfZgSPYKu/PP8mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795000; c=relaxed/simple;
	bh=nxpuHPSeNKXNrM+uLIL2XgjLqOccIKQdy1wWY8uBppw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zl+JfD7Qj93CA3EVb8iDBz6waWtb1wMwIGx69JONt1SGseltYjJsgGoWESVBt38qo3JeGB/zuLb1DFhB57YFSR1jxhLKhjihhgDKqAv5s3pKibi0sdmkCtKYzeGp8c77fM/ikNZVMlyGbmzN+sjMEpvCL+yLlZVJ6hSoYaXi7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRO0Kja+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C453DC4CEF0;
	Thu, 17 Jul 2025 23:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794999;
	bh=nxpuHPSeNKXNrM+uLIL2XgjLqOccIKQdy1wWY8uBppw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GRO0Kja+C5jPyLaYBksBBSAQtJ3rblAMpZszdvfNwSVnJZpmQMgVmYF2z1/ufCOrl
	 J+PNs3+aP0wEdnq3zB82nZn8QvOoXucgumGQi8mB6Nsaml8matD+GHSyR/lA+03/I0
	 Qyt9uKfHRforzo3IC8SkT4XuX/7VzcHNsthbYS2GB3GrH8YOVh45qAOJCP0PL0hBUt
	 KM50h5LrWhkPekiAjjFq+QWeWhxe1j1NidTW9mEaCnMr9X6t3q9fDefoXk7aUemzpp
	 8nk01DVoV8xzEyINxibDcDZNs+XaD6wuEv5t8pX+oroYdVNyqpgQVWadbDQxyUp0Cc
	 zYtz50ve9E9Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB06C383BA3C;
	Thu, 17 Jul 2025 23:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/11] ethtool: rss: support RSS_SET via
 Netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175279501975.2106430.2106781743672298732.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 23:30:19 +0000
References: <20250716000331.1378807-1-kuba@kernel.org>
In-Reply-To: <20250716000331.1378807-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com,
 gal@nvidia.com, jdamato@fastly.com, andrew@lunn.ch

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 17:03:20 -0700 you wrote:
> Support configuring RSS settings via Netlink.
> Creating and removing contexts remains for the following series.
> 
> v3:
>  - decode xfrm-input as flags not enum
>  - check driver supports get_rxnfc op
> v2: https://lore.kernel.org/20250714222729.743282-1-kuba@kernel.org
>  - commit message changes
>  - make sure driver implements the set_rxfh op
>  - add comment about early return when lacking get
>  - set IFF_RXFH_CONFIGURED even if user sets the table to identical
>    to default
>  - use ethnl_update_binary()
>  - make sure we free indir if key parsing fails
>  - tests: fix existing rxfh_input_xfrm test for string decode
>  - tests: make defer() cleanup more intelligent WRT ordering
> v1: https://lore.kernel.org/20250711015303.3688717-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/11] ethtool: rss: initial RSS_SET (indirection table handling)
    https://git.kernel.org/netdev/net-next/c/c0ae03588bbb
  - [net-next,v3,02/11] selftests: drv-net: rss_api: factor out checking min queue count
    https://git.kernel.org/netdev/net-next/c/1560af51e1ea
  - [net-next,v3,03/11] tools: ynl: support packing binary arrays of scalars
    https://git.kernel.org/netdev/net-next/c/c3e914031039
  - [net-next,v3,04/11] selftests: drv-net: rss_api: test setting indirection table via Netlink
    https://git.kernel.org/netdev/net-next/c/6e7eb93a692c
  - [net-next,v3,05/11] ethtool: rss: support setting hfunc via Netlink
    https://git.kernel.org/netdev/net-next/c/82ae67cbc423
  - [net-next,v3,06/11] ethtool: rss: support setting hkey via Netlink
    https://git.kernel.org/netdev/net-next/c/51798c519a91
  - [net-next,v3,07/11] selftests: drv-net: rss_api: test setting hashing key via Netlink
    https://git.kernel.org/netdev/net-next/c/169b26207a46
  - [net-next,v3,08/11] netlink: specs: define input-xfrm enum in the spec
    https://git.kernel.org/netdev/net-next/c/c1b27f0695d6
  - [net-next,v3,09/11] ethtool: rss: support setting input-xfrm via Netlink
    https://git.kernel.org/netdev/net-next/c/d3e2c7bab124
  - [net-next,v3,10/11] ethtool: rss: support setting flow hashing fields
    https://git.kernel.org/netdev/net-next/c/2f70251112ec
  - [net-next,v3,11/11] selftests: drv-net: rss_api: test input-xfrm and hash fields
    https://git.kernel.org/netdev/net-next/c/00e6c61c5a0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



