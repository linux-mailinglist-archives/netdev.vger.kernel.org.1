Return-Path: <netdev+bounces-220195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0C7B44B7F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112E317C6F4
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0132B2135B8;
	Fri,  5 Sep 2025 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+CpAc9/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6D14E2F2
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038211; cv=none; b=IJbzTLpxkWi1/xmzzqgNbywi4vNVrX/UcpMYV+6P7+5fKutd73OTzxoo/FSQsJko2pOlCzeg6aJf0U7rKcO4u4RO5r/dNy7eKq0kVpfTdP9uMTQfPuO9DxcIj/CyPYgyOw+8/qGham5DxccD6B9qr1+6UV1MVsqzinBhoFKBIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038211; c=relaxed/simple;
	bh=C/1pL4S1UKdlQs+lSFcnjyU82GWliqM57P6PiTwFl+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XpXEGZO/+oSy4h7ZqNXs7bl5mQnyX8LPiYi16JOjzvhsPcoOLWKZkn4tkvI7acJ6+chUsf7ythZODSDR3pf16lsn8aTebmDEUurpydiBlDtrqWyF+lqj2or2fFwV3chhrXCuMgWQNIMaU6r5KAuCGvJX3Faq6LDM7qFc4OZLBs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+CpAc9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4516EC4CEF0;
	Fri,  5 Sep 2025 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757038211;
	bh=C/1pL4S1UKdlQs+lSFcnjyU82GWliqM57P6PiTwFl+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q+CpAc9/WYnVyGZ7SCrNyXKdShMoYlYWmovttuS6zs9On2HyHPOlJGh8xTmntoOGB
	 qdzr5PKx1sBJdd5yzlzVdeR5Sq6CmvdAOLS6bAbtRWhBoqfKVXTf1coDKBLS/+CF4b
	 oDmjKXMnwJe8ZuEjq/kPXt6gPErACIdOXQWGSt54WAazt29JGlAOVHWpLirkM7WSd8
	 0T0N5jPS+MARQ69H7F2tSkdVWvXgC8vtL7iUHPHIqixp5upeMRu4n5qEB49E58GygZ
	 bKSFBLeM4tkaM70WNrTPqd6KPRpJHlQPwCPYu4PuNgLbyWLvF4vqRhcEXBmeQK8NjZ
	 551YNb9+oCWKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C06383BF69;
	Fri,  5 Sep 2025 02:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9][pull request] Intel Wired LAN Driver Updates
 2025-09-03 (ixgbe, igbvf, e1000, e1000e, igb, igbvf, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175703821600.2008509.2358820485696383439.git-patchwork-notify@kernel.org>
Date: Fri, 05 Sep 2025 02:10:16 +0000
References: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250903202536.3696620-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  3 Sep 2025 13:25:26 -0700 you wrote:
> Piotr allows for 2.5Gb and 5Gb autoneg for ixgbe E610 devices.
> 
> Jedrzej refactors reading of OROM data to be more efficient on ixgbe.
> 
> Kohei Enju adds reporting of loopback Tx packets and bytes on igbvf. He
> also removes redundant reporting of Rx bytes.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] ixgbe: add the 2.5G and 5G speeds in auto-negotiation for E610
    https://git.kernel.org/netdev/net-next/c/8ee0c9109763
  - [net-next,2/9] ixgbe: reduce number of reads when getting OROM data
    https://git.kernel.org/netdev/net-next/c/08a1af326a80
  - [net-next,3/9] igbvf: add lbtx_packets and lbtx_bytes to ethtool statistics
    https://git.kernel.org/netdev/net-next/c/86526aa57f3f
  - [net-next,4/9] igbvf: remove redundant counter rx_long_byte_count from ethtool statistics
    https://git.kernel.org/netdev/net-next/c/d07176252a43
  - [net-next,5/9] e1000: drop unnecessary constant casts to u16
    https://git.kernel.org/netdev/net-next/c/fa8a9346f95a
  - [net-next,6/9] e1000e: drop unnecessary constant casts to u16
    https://git.kernel.org/netdev/net-next/c/7e93136459dd
  - [net-next,7/9] igb: drop unnecessary constant casts to u16
    https://git.kernel.org/netdev/net-next/c/b45d082d910b
  - [net-next,8/9] igc: drop unnecessary constant casts to u16
    https://git.kernel.org/netdev/net-next/c/d45dda4914e9
  - [net-next,9/9] ixgbe: drop unnecessary casts to u16 / int
    https://git.kernel.org/netdev/net-next/c/396a788bca86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



