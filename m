Return-Path: <netdev+bounces-72668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E48591DC
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 19:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6ED1C221F8
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 18:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A8E7E564;
	Sat, 17 Feb 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvJFMC7l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A27E11C
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708195827; cv=none; b=LxtO0dajroAIGiyeJ7vetjkDEUf0ghVN1GZOyuqs7C41kFbDX1Qb6N4w5gwRjXB7UnATFCaA0aghHa0bDcL/QiedcY26Y2o7nN3P9/3AdgYPNwahacyzXyK5aJzHYWWxCYIS/oHSjwYvRbkKkCd/VGmEFn2yllyZEIg6sQo0sns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708195827; c=relaxed/simple;
	bh=+mfWOp0t69vcsebXWOwjjO3A6FjD6AfQ4lnVEjLwx/M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c2D7bd0hojlVfavs3YmgUMrO+NpD2XIqglhbNmQqk+xKKHoEmCKDIxGYKO/eGolhP5zRugrYEYlpnLmog7SSVw8O1L8w1o9GjIVjdd+j6e69Tc3tLoIDTaeTLh8p5jFgvqbGGyQ4x63/cZ6ib9T6DPFnMbW2oCMy19m+gHi+2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvJFMC7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E59FAC43390;
	Sat, 17 Feb 2024 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708195826;
	bh=+mfWOp0t69vcsebXWOwjjO3A6FjD6AfQ4lnVEjLwx/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LvJFMC7lahjMNXXkUauwVbaHMsgTmUGkM3iOLNJgy9CdC/g1ua5cFBcw0MmABmzxf
	 kCwFOLGnIZMEkOwnROarB7F3qQlqRI+6b3En1/E/2+FzjxKn7Wqk8B27yAdcQRuMw3
	 T7DU7BmVktnlqOL9ggqM9vfiRh7tuMg8AmATfrPmd4UTC0Yb+kUOZOcF4hilOJg3GR
	 CHhKRWX1YbmK35cFoqzF2T76HcCq/UTlt961/gQgeMNjY5Rp7/UhaWqziKb5pi04QV
	 JmDa81ebMXzL1KlSRTjc1OH+VPAwqy1dz0dhcdhJHdU7qMp44q2ASXeMuhnH7mJlU4
	 tbDyEBiNH3lxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D202EC04E24;
	Sat, 17 Feb 2024 18:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: phy: add support for the EEE 2 registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170819582685.11703.13036425492207082914.git-patchwork-notify@kernel.org>
Date: Sat, 17 Feb 2024 18:50:26 +0000
References: <558e122f-e900-4a17-a03a-2b9ec4fed124@gmail.com>
In-Reply-To: <558e122f-e900-4a17-a03a-2b9ec4fed124@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com,
 edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 14 Feb 2024 21:15:31 +0100 you wrote:
> This series adds support for the EEE 2 registers. Most relevant and
> for now the only supported modes are 2500baseT and 5000baseT.
> 
> Heiner Kallweit (5):
>   net: mdio: add helpers for accessing the EEE CAP2 registers
>   net: phy: add PHY_EEE_CAP2_FEATURES
>   net: phy: c45: add and use genphy_c45_read_eee_cap2
>   net: phy: c45: add support for EEE link partner ability 2 to
>     genphy_c45_read_eee_lpa
>   net: phy: c45: add support for MDIO_AN_EEE_ADV2
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: mdio: add helpers for accessing the EEE CAP2 registers
    https://git.kernel.org/netdev/net-next/c/80e4021c25d8
  - [net-next,2/5] net: phy: add PHY_EEE_CAP2_FEATURES
    https://git.kernel.org/netdev/net-next/c/ef6ee3a31bdc
  - [net-next,3/5] net: phy: c45: add and use genphy_c45_read_eee_cap2
    https://git.kernel.org/netdev/net-next/c/b63584c86edb
  - [net-next,4/5] net: phy: c45: add support for EEE link partner ability 2 to genphy_c45_read_eee_lpa
    https://git.kernel.org/netdev/net-next/c/1bbe04e305fb
  - [net-next,5/5] net: phy: c45: add support for MDIO_AN_EEE_ADV2
    https://git.kernel.org/netdev/net-next/c/9a1e31299dec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



