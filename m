Return-Path: <netdev+bounces-234216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767F6C1DF01
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDA3189CD76
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921921D5AA;
	Thu, 30 Oct 2025 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pvlds19b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243F221CC51
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784854; cv=none; b=ZR3G0LSRFd2viVAGP26VqBQIECfChePrHAUzdhe4T1dR/D1PGSm7/moTP6s6Bvn1WgFRE2bNjWdTq9RdJ2g2Mx+enqZx7hgRwz9Yri+wPxhv40rruzRuY76Ev6Lu0hMUJ2XYj2yB8LqXJXXMRAoA3UJbSc6su3hluqSGHu1TqGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784854; c=relaxed/simple;
	bh=WnHc6ofQRTVfax7dOuZYG4Ak/UQlKmdoxjXzMEKOsCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MvdoEjxnbDG2Dn5YrlX8Su9QruLfpedlsjsFntMS8iJCLW4/rd+JRt98P302E14ip5lwF7B5wqVcwh8jMn1fKFKjirCSa5J1Pmie1l3/Zl4Da7e4Lx2m/W8Lme+JzD3CCwGoJJ7auqGwho6Kgjul10kz/AtEdMMKE59begCMcsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pvlds19b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A7AC113D0;
	Thu, 30 Oct 2025 00:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761784853;
	bh=WnHc6ofQRTVfax7dOuZYG4Ak/UQlKmdoxjXzMEKOsCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pvlds19baPW1qFoXyBzjErAHdMq04Bg+cYJDUrhZZWralkMfKJv5siEpbhot/xiK0
	 I9Yq5b2QFurD16JQtkit7RacEMVubL+zSgIiWKGmAKA4WBO/Xbub4Ua07cpJr8bteY
	 33Ip1LaVdeHot416TmAur0J0PrRnRQ+HwTW8bfImQFtstXZ1/2RyEB6J3FUmiy2H4O
	 di594hw8FawE6QqwyDGJ+bisr5oQr8TGUL3uYzWqwO5DCTbt7Vkz4MTSWN+FzzcvRj
	 qv7AXdW15diy6yo9VcedPn398xm+RRvZStdawJjHW+IjkGYgwNI6V21U0K9wKyea++
	 +VHUm4sepXS+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADEE3A55EC7;
	Thu, 30 Oct 2025 00:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2025-10-28 (ice, ixgbe, igb, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178483073.3264893.2100050257551719073.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 00:40:30 +0000
References: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 28 Oct 2025 13:25:05 -0700 you wrote:
> For ice, Grzegorz fixes setting of PHY lane number and logical PF ID for
> E82x devices. He also corrects access of CGU (Clock Generation Unit) on
> dual complex devices.
> 
> Kohei Enju resolves issues with error path cleanup for probe when in
> recovery mode on ixgbe and ensures PHY is powered on for link testing
> on igc. Lastly, he converts incorrect use of -ENOTSUPP to -EOPNOTSUPP
> on igb, igc, and ixgbe.
> 
> [...]

Here is the summary with links:
  - [net,1/8] ice: fix lane number calculation
    https://git.kernel.org/netdev/net/c/e9840461317e
  - [net,2/8] ice: fix destination CGU for dual complex E825
    https://git.kernel.org/netdev/net/c/45076413063c
  - [net,3/8] ice: fix usage of logical PF id
    https://git.kernel.org/netdev/net/c/9a0f81fc64b2
  - [net,4/8] ixgbe: fix memory leak and use-after-free in ixgbe_recovery_probe()
    https://git.kernel.org/netdev/net/c/85308d999c4b
  - [net,5/8] igc: power up the PHY before the link test
    https://git.kernel.org/netdev/net/c/81fb1fe75c67
  - [net,6/8] igb: use EOPNOTSUPP instead of ENOTSUPP in igb_get_sset_count()
    https://git.kernel.org/netdev/net/c/bc73c5885c60
  - [net,7/8] igc: use EOPNOTSUPP instead of ENOTSUPP in igc_ethtool_get_sset_count()
    https://git.kernel.org/netdev/net/c/21d08d1c4c29
  - [net,8/8] ixgbe: use EOPNOTSUPP instead of ENOTSUPP in ixgbe_ptp_feature_enable()
    https://git.kernel.org/netdev/net/c/f82acf6fb421

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



