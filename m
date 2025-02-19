Return-Path: <netdev+bounces-167581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C810FA3AF70
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47663A2850
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550AD187553;
	Wed, 19 Feb 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRnpynao"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A635953
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931611; cv=none; b=WP6BphSusqhhkuCvYYkG55pxeMsJJWXYwS75jiKxWXEYHBLLeB18zUQQSNmYidQtw/lr603uaq1Yn3PHKniD1bRakuLjFkdqBpxgNHBh1pyanoWBnENdSlxWhjODTnNVc2mOHnID+gu/HRMy34yGStIsM1gLyoRl8wtd9u5xvkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931611; c=relaxed/simple;
	bh=AasZ/cjCiU6sYv+FAo/NOhB6rWcjksVd0o7BL9eoByI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vo2Q9cv8ZrWTu1pQ5Zli1JfHQJZNyFqgmb2+yEAP20iixIXutKYQhFNCOpKEy4o1Tzwhb53EqueKN9h8+fdTUdBlB/+JI3hP8QI1OMFnIQsPEYtYPuASfr+SAqeoYmBCY9DJ7/tHJLg/378laGWmcjszyXvKkSYbmdAlsJ0vcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRnpynao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CDBC4CEE2;
	Wed, 19 Feb 2025 02:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739931610;
	bh=AasZ/cjCiU6sYv+FAo/NOhB6rWcjksVd0o7BL9eoByI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FRnpynaoLbAlxZ6r6CHdmT8crnAXurzK3VCkcgeo6FPujaDCh+aEatGcGVY73jmZd
	 wTJemRtqoeb9iGRJ5yxrE/Sp2bGoYciipzDCF228PgWcm47K+urbtCtThkhk7U5oO6
	 j6TJOnIP1RjpL3hnAeA3HLkwjLWlIQDaWmXuqpORhtAqdeI8/1IKttJy4zCt3ceNym
	 EWzDvTimRGBaUl2hfeo7xYfz1GIgt/oagKxiFkAsMl/ymT8SSLznNk/jJHV5k9JRg5
	 /QuOrpa5gSaozu9GRbQ69hECLkTgFSVd5W0QLBPqkcHKjEDdbys49dmwlG6dhIjy8z
	 xRhAOIEVm+/hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E2A380AAE9;
	Wed, 19 Feb 2025 02:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: phy: improve and simplify EEE handling in
 phylib
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993164070.106119.8776440793383341066.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:20:40 +0000
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
In-Reply-To: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Feb 2025 22:14:56 +0100 you wrote:
> This series improves and simplifies phylib's EEE handling.
> 
> Heiner Kallweit (6):
>   net: phy: move definition of phy_is_started before
>     phy_disable_eee_mode
>   net: phy: improve phy_disable_eee_mode
>   net: phy: remove disabled EEE modes from advertising in phy_probe
>   net: phy: c45: Don't silently remove disabled EEE modes any longer
>     when writing advertisement register
>   net: phy: c45: use cached EEE advertisement in
>     genphy_c45_ethtool_get_eee
>   net: phy: c45: remove local advertisement parameter from
>     genphy_c45_eee_is_active
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: phy: move definition of phy_is_started before phy_disable_eee_mode
    https://git.kernel.org/netdev/net-next/c/8a6a77bb5a41
  - [net-next,2/6] net: phy: improve phy_disable_eee_mode
    https://git.kernel.org/netdev/net-next/c/a9b6a860d778
  - [net-next,3/6] net: phy: remove disabled EEE modes from advertising_eee in phy_probe
    https://git.kernel.org/netdev/net-next/c/7f33fea6bb53
  - [net-next,4/6] net: phy: c45: Don't silently remove disabled EEE modes any longer when writing advertisement register
    https://git.kernel.org/netdev/net-next/c/aa951feb5426
  - [net-next,5/6] net: phy: c45: use cached EEE advertisement in genphy_c45_ethtool_get_eee
    https://git.kernel.org/netdev/net-next/c/199d0ce385ad
  - [net-next,6/6] net: phy: c45: remove local advertisement parameter from genphy_c45_eee_is_active
    https://git.kernel.org/netdev/net-next/c/809265fe96fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



