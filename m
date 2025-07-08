Return-Path: <netdev+bounces-205117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5E1AFD6E7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1939A582D6E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EF22DC321;
	Tue,  8 Jul 2025 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2eLOEUk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12838488
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001789; cv=none; b=qJ7suIYxmPCPzV23QT/4jAu7uhxJV7aUnvldS41/6cdML8e0AY8RVhv0PFwGtc20JDScIziFfaKMo3bB8ZXuANGxoNIsd4k1Q1xtuvwAVTvaCIu414Gsaiu6T0bS+jtVhc+leHc3WPyFpqHytyHISWWsHWNnFu7nfApnwhCLfAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001789; c=relaxed/simple;
	bh=/kVHR0e197cCBmawHHl7jZp87XpvsAVR4cbHS6G8Cn4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OXgwSsLuigSyc0jEop1TsOCsWY4PHksXBNDaSGMIi/UYiDJRSDLXr+i2OJUHwq0BNnA+Ad39yqBoMCXoWX8fS3qauPEugyrSBhhcm8Ap9qMrFJgMRcBZJZLPtoDcSK5hgxzAixXdvIkqz29yMwNeCD5NMqS9VrBKF2LZ2364aQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2eLOEUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0BEC4CEED;
	Tue,  8 Jul 2025 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752001789;
	bh=/kVHR0e197cCBmawHHl7jZp87XpvsAVR4cbHS6G8Cn4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X2eLOEUk0uXZfOhiADomLO1tOZMxM1NYZiu9y+rtpyKUh7QxWbNLFuy49AVVO5qfw
	 tEPNz+e497q1rx1Dkxn6C1GGwegnCx5fuARKdP2nQOHkGgWZ8CalcI+/NmoTiNOtb9
	 WoBw4yjPv7lQjuOEV92Q6qYkTWXVFMkRxbUYRQtbIHNl6se0Krb7yj2sBkM4+HCc5C
	 n1F5TP4+B3xN/lrqP9edFK6Bz9qu4Fbl70EIgXW4gNR6PWZ3vVzveqrqCfAq+WLakr
	 YhcW5zMoMFIKbcjJX2TFmBHcrkthwRBXUJ1HxPpujl8B0v1vYOCEKTNMaLbGmwsPAs
	 rVZpbhBw35LaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DFC380DBEE;
	Tue,  8 Jul 2025 19:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] net: migrate remaining drivers to
 dedicated
 _rxfh_context ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175200181226.4175688.12771755410694123575.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 19:10:12 +0000
References: <20250707184115.2285277-1-kuba@kernel.org>
In-Reply-To: <20250707184115.2285277-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 gal@nvidia.com, ecree.xilinx@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Jul 2025 11:41:10 -0700 you wrote:
> Around a year ago Ed added dedicated ops for managing RSS contexts.
> This significantly improved the clarity of the driver facing API.
> Migrate the remaining 3 drivers and remove the old way of muxing
> the RSS context operations via .set_rxfh().
> 
> v3:
>  - [mlx5] fix compilation
>  - [patch 4] remove more branches
>  - [patch 5] reformat
> v2: https://lore.kernel.org/20250702030606.1776293-1-kuba@kernel.org
>  - [mlx5] remove hfunc local var in mlx5e_rxfh_hfunc_check()
>  - [mlx5] make the get functions void and add WARN_ON_ONCE()
>  - [patch 4] remove rxfh struct in netdev_rss_contexts_free()
> v1: https://lore.kernel.org/20250630160953.1093267-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] eth: otx2: migrate to the *_rxfh_context ops
    https://git.kernel.org/netdev/net-next/c/62e01d8c4170
  - [net-next,v3,2/5] eth: ice: drop the dead code related to rss_contexts
    https://git.kernel.org/netdev/net-next/c/be78c83a8bbb
  - [net-next,v3,3/5] eth: mlx5: migrate to the *_rxfh_context ops
    https://git.kernel.org/netdev/net-next/c/afc55a0659a6
  - [net-next,v3,4/5] net: ethtool: remove the compat code for _rxfh_context ops
    https://git.kernel.org/netdev/net-next/c/4e655028c29f
  - [net-next,v3,5/5] net: ethtool: reduce indent for _rxfh_context ops
    https://git.kernel.org/netdev/net-next/c/cd7e8841b61f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



