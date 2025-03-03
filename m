Return-Path: <netdev+bounces-171423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D610FA4CF5C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28D71888B68
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 23:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C5323E33C;
	Mon,  3 Mar 2025 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNWTd/tL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4C23C8A7
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044940; cv=none; b=gYvKyEuj9LPgW7qAeWGwhOtet38G/IB1338p/lYBEsL9miLrGBr5eTNyqP9ivhGWO/66xre8Cr1tRHWmm2jd+CKZkvsqEBX/q9LBZ3NSbZ4Tpu/K6VHJ6V3kmk/dEjoTcJPoNbLb+pfBPNtlhL9vDA+BTXkMTPRtgO2QSHeUSwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044940; c=relaxed/simple;
	bh=7roKFqyrSsHTf2YzToN1DDkPoQQkcxK5QzAS3A0suYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MsooxYfK9LG/xUQmHC6ew8Tcmc6B65peF70jsJrQEwVTodd5gs60gQZdc1HUQjn2tXIoHowyvaKZkrTqbbeUJA7p26eRD2hAg0OC/mtOeF0ozZfoKYvSBXGTnamJe5y3fHO3Vnql5l8gBxrDzS91n18l/lIsIfJO9txCTbIStpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNWTd/tL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E15C4CEE8;
	Mon,  3 Mar 2025 23:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741044939;
	bh=7roKFqyrSsHTf2YzToN1DDkPoQQkcxK5QzAS3A0suYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eNWTd/tL6LZWmyDx8IbjBBh21oA0mDIq2Jpq6VU4vov3t+v5lnPy41Hxz/BfLjL+X
	 2SlS8WXYn3EmqCQe+11li+fEdB+henL1TURZTdvIbNE1/Pn88uiGXwe7G/XA3fFuqy
	 D2giu1xVsJi3/pz+axwjsTip6ZzD2VDF1eAB4CV4ZewZ1ze0C/vwszrnxnP2PPjDeo
	 BhfHAnn2vSQhHIsbMp2rUmsiQRfGHZvPEeqO3SaC1THgGbBn1oo7gNxWubFRR668U4
	 IkbYHwp72hmbR9o5Go2UgoC+7RDH2cG6cHaRHJL73j5p2tf+MPmNzZsz9JgeNIM70d
	 Bz8YCw8Ak4PGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB08F3809A8F;
	Mon,  3 Mar 2025 23:36:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 00/12] ipv4: fib: Convert RTM_NEWROUTE and
 RTM_DELROUTE to per-netns RTNL.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174104497248.3745415.4897167452368422553.git-patchwork-notify@kernel.org>
Date: Mon, 03 Mar 2025 23:36:12 +0000
References: <20250228042328.96624-1-kuniyu@amazon.com>
In-Reply-To: <20250228042328.96624-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Feb 2025 20:23:16 -0800 you wrote:
> Patch 1 is misc cleanup.
> Patch 2 ~ 8 converts two fib_info hash tables to per-netns.
> Patch 9 ~ 12 converts rtnl_lock() to rtnl_net_lcok().
> 
> 
> Changes:
>   v3:
>     * Add Eric's and David's tags
>     * Patch 2
>       * Use kvcalloc() instead of kvmalloc_array(, __GFP_ZERO)
> 
> [...]

Here is the summary with links:
  - [v3,net-next,01/12] ipv4: fib: Use cached net in fib_inetaddr_event().
    https://git.kernel.org/netdev/net-next/c/e5bf1c39e894
  - [v3,net-next,02/12] ipv4: fib: Allocate fib_info_hash[] and fib_info_laddrhash[] by kvcalloc().
    https://git.kernel.org/netdev/net-next/c/fa336adc100e
  - [v3,net-next,03/12] ipv4: fib: Allocate fib_info_hash[] during netns initialisation.
    https://git.kernel.org/netdev/net-next/c/cfc47029fa12
  - [v3,net-next,04/12] ipv4: fib: Make fib_info_hashfn() return struct hlist_head.
    https://git.kernel.org/netdev/net-next/c/84c75e94ecee
  - [v3,net-next,05/12] ipv4: fib: Remove fib_info_laddrhash pointer.
    https://git.kernel.org/netdev/net-next/c/0dbca8c269ba
  - [v3,net-next,06/12] ipv4: fib: Remove fib_info_hash_size.
    https://git.kernel.org/netdev/net-next/c/d6306b9d9885
  - [v3,net-next,07/12] ipv4: fib: Add fib_info_hash_grow().
    https://git.kernel.org/netdev/net-next/c/b79bcaf7d952
  - [v3,net-next,08/12] ipv4: fib: Namespacify fib_info hash tables.
    https://git.kernel.org/netdev/net-next/c/9f7f3ebeba93
  - [v3,net-next,09/12] ipv4: fib: Hold rtnl_net_lock() for ip_fib_net_exit().
    https://git.kernel.org/netdev/net-next/c/af5cd2a8f078
  - [v3,net-next,10/12] ipv4: fib: Hold rtnl_net_lock() in ip_rt_ioctl().
    https://git.kernel.org/netdev/net-next/c/c0ebe1cdc2cf
  - [v3,net-next,11/12] ipv4: fib: Move fib_valid_key_len() to rtm_to_fib_config().
    https://git.kernel.org/netdev/net-next/c/254ba7e6032d
  - [v3,net-next,12/12] ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/1dd2af7963e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



