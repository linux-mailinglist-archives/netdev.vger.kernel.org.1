Return-Path: <netdev+bounces-159878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48910A174B9
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 23:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE4D1674A1
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 22:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC51EE7BC;
	Mon, 20 Jan 2025 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWL7p/0Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBF219993D
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737412809; cv=none; b=D28maDqJPK3bJDiDVn2j03V/UqOzlha5+NY05EHpnF+gLg0vxH0u82nu09KJp11RTXu1V5Ip376WO6kf2HJtsQcqrI2ErFJSj/5P7/XfoQxGXp/t0fl1OrdUNZ8bXuX+BkIlEDk4U9DCTSaO4GXMqP+pnRv5LpbRQlk2Lc9AZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737412809; c=relaxed/simple;
	bh=+CNdFyYhjNoGbF2qBqcF8RORhGxHUH55/3lWsG5Z+vM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=snDS9N+pIXaGkB1V6K40jd/hztBMha4JDvkRmhj7v//1LWMMOOnVTEse2s0qM/q0E5v8Oqgm0etk9b7+cLY9xkWsv55L1crUhr73KePOKjjRLMWqBggwyB4pLoRCQh5MvHuGHyg33kIi75sizjJF640LCWiFrhzjYIJ8CYYxCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWL7p/0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D85C4CEDD;
	Mon, 20 Jan 2025 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737412809;
	bh=+CNdFyYhjNoGbF2qBqcF8RORhGxHUH55/3lWsG5Z+vM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GWL7p/0Q9vGOBd3nCuCf/8xALSIfnphxU10Eyp1Ws3sPacOgod9+U/5V1ezqnv1cO
	 oONeKCbF3X6rMZ3IiRCg9w/F/VskDZNMbWVDhZvmbgkGvJ5j4PxO+ztH/AAC2l67a6
	 FXuLcHzRGbMZ/ddQMBFZSKeWFw/oEFOAjwxl1kmAhTa/ZTpnyrOS+Gt5L4hJLAbtNd
	 y0VgG8kZP3UdySATQU5zX+kFHKp9orP3kzIzKw6YkJdLDNZhBgBcQ8xzb7tbOdTZGN
	 2BRrcMtkGXNfhe/dlIamhP9dIWI8WrKZbF95Sn/xl1BlFV1X0HF/7qp01lPFd9WFM6
	 HCIhHSoWxc5Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D31380AA62;
	Mon, 20 Jan 2025 22:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/11] ipv6: Convert RTM_{NEW,DEL}ADDR and more to
 per-netns RTNL.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173741283300.3674019.9563566248542248687.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 22:40:33 +0000
References: <20250115080608.28127-1-kuniyu@amazon.com>
In-Reply-To: <20250115080608.28127-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jan 2025 17:05:57 +0900 you wrote:
> This series converts RTM_NEWADDR/RTM_DELADDR and some more
> RTNL users in addrconf.c to per-netns RTNL.
> 
> 
> Changes:
>   v2:
>     * Reorder patch 7 and 8
>     * Move ifa_flags setup before IFA_CACHEINFO in patch 8
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/11] ipv6: Add __in6_dev_get_rtnl_net().
    https://git.kernel.org/netdev/net-next/c/f7a6082b5e4c
  - [v2,net-next,02/11] ipv6: Convert net.ipv6.conf.${DEV}.XXX sysctl to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/93c839e3edbe
  - [v2,net-next,03/11] ipv6: Hold rtnl_net_lock() in addrconf_verify_work().
    https://git.kernel.org/netdev/net-next/c/6550ba0863f9
  - [v2,net-next,04/11] ipv6: Hold rtnl_net_lock() in addrconf_dad_work().
    https://git.kernel.org/netdev/net-next/c/02cdd78b4e8d
  - [v2,net-next,05/11] ipv6: Hold rtnl_net_lock() in addrconf_init() and addrconf_cleanup().
    https://git.kernel.org/netdev/net-next/c/cdc5c1196ee9
  - [v2,net-next,06/11] ipv6: Convert inet6_ioctl() to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/832128cc4438
  - [v2,net-next,07/11] ipv6: Pass dev to inet6_addr_add().
    https://git.kernel.org/netdev/net-next/c/f7fce98a73df
  - [v2,net-next,08/11] ipv6: Set cfg.ifa_flags before device lookup in inet6_rtm_newaddr().
    https://git.kernel.org/netdev/net-next/c/2f1ace4127fd
  - [v2,net-next,09/11] ipv6: Move lifetime validation to inet6_rtm_newaddr().
    https://git.kernel.org/netdev/net-next/c/867b385251ea
  - [v2,net-next,10/11] ipv6: Convert inet6_rtm_newaddr() to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/82a1e6aa8f6c
  - [v2,net-next,11/11] ipv6: Convert inet6_rtm_deladdr() to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/7bcf45ddb8bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



