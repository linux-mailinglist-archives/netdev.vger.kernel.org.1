Return-Path: <netdev+bounces-221492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E24AB50A43
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C05E7B6EC2
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E6F1DE2BF;
	Wed, 10 Sep 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5hDLAuS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA0517B50A
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757467813; cv=none; b=DfE4XDqO7omIFH8u2wXNgbf/0YHyNEyAdSbweK59VIG+xwPpzdhNHe6/v5EbbELQMbD3qH3u1V49xp7Jt/KMLQwybCdHBWDm+sRlh3iBLuEIUQ0yXN964a5lL+KKo5lybgYq4ZHzLUFf0wcsGF40VaTekABSm5nlm0I4VNo4ig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757467813; c=relaxed/simple;
	bh=+2UTKQ0DPeez/v+5qTrw+oetedJXSvGiHUxMhbNF4PI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ftHfkTL/mowOVBpuUvRNR809beeo16nHVFpmVg7E17HtquKo75deC74QdsNe/W8aaJmb/Mc/tLuXu6j04aKR//+XPPYx5BJ5GnOO2qs34ybyao27+6Ij1bnS+knpf1jDcLnq9W1XYPo8AjK6UMgjczViOHg+eMslE8d5dcjc9Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5hDLAuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58955C4CEF4;
	Wed, 10 Sep 2025 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757467813;
	bh=+2UTKQ0DPeez/v+5qTrw+oetedJXSvGiHUxMhbNF4PI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H5hDLAuSTZM9Spqet+b2q+sM/GOLV8Kfvm2Te81joTvpE3N3W955e0g0fqVnggVq6
	 9x8hjeVAR5loLYNfmSfzrePsfgbziHrAOQbrlPq16q1IRpy+5WgTX5XdAdBrJ6o1PH
	 zmmVFvgc+y7RpwAyunYyCsJSLhvsTjTGhSBbadmoVhqQ09gzCZzXuHHoMYO65GPWLg
	 c7Ns7Selpu/kx5m304+ystnuwvYy0d5AXH15PwNcMlc+6jw95gLFkcU3smb57FqiVC
	 PvoIQz4f9P2LwhgachiZB4k9B2R9uSBWysBpoizrNC+S0Bpnx6KvC3m8YN5H0OGbGF
	 UamEELOwF6beQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC7383BF69;
	Wed, 10 Sep 2025 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: phy: fixed_phy: improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175746781623.866782.2553216760639444994.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 01:30:16 +0000
References: <e81be066-cc23-4055-aed7-2fbc86da1ff7@gmail.com>
In-Reply-To: <e81be066-cc23-4055-aed7-2fbc86da1ff7@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 6 Sep 2025 23:59:18 +0200 you wrote:
> This series contains a number of improvements.
> No functional change intended.
> 
> Heiner Kallweit (4):
>   net: phy: fixed_phy: remove unused interrupt support
>   net: phy: fixed_phy: remove member no_carrier from struct fixed_phy
>   net: phy: fixed_phy: add helper fixed_phy_find
>   net: phy: fixed_phy: remove struct fixed_mdio_bus
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: phy: fixed_phy: remove unused interrupt support
    https://git.kernel.org/netdev/net-next/c/fecf7087f0a3
  - [net-next,2/4] net: phy: fixed_phy: remove member no_carrier from struct fixed_phy
    https://git.kernel.org/netdev/net-next/c/0625b3bfbb7f
  - [net-next,3/4] net: phy: fixed_phy: add helper fixed_phy_find
    https://git.kernel.org/netdev/net-next/c/f8db55c8eb8e
  - [net-next,4/4] net: phy: fixed_phy: remove struct fixed_mdio_bus
    https://git.kernel.org/netdev/net-next/c/298382557935

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



