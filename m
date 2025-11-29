Return-Path: <netdev+bounces-242657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69167C93793
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C7264E170E
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 03:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFBB20DD51;
	Sat, 29 Nov 2025 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djbI2opD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5D1C701F;
	Sat, 29 Nov 2025 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764388385; cv=none; b=C+Ni3Ru15/ETNAka/PbghrArHvhhb0VPqHrOM2gHSw2cdyXMC8Uft0qLS410/LPpP2Zp/oNSlhtPcanGtZQO0h+u2c3NDLqkwjWhWu6i+oEfvj2lw1WLiHfWDtZAdGjmsocdWi77RFPpJJsT/xXtvtXxwgnqFuZfNkAAU+bbEC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764388385; c=relaxed/simple;
	bh=zayIHl3sV1RqJldd+BdPSA4Vl97m26XCFE1wNUlBqDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gAybLu0CQ5GXTiAc96zmWkC03zQ9qQT1VTUof5Narfz3Y1DLoEOBx99jeuj4eVxsAQmYj9yZ09VD2lLH4wBs7gcpaBoB73amwMdCD9sS4IBZ79qyRqL+vpjb/X5ARn++Ft7XQkrK9UPVS8vID9ZccgvztEHUbmkZXR7npuIVcOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djbI2opD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665DDC4CEF7;
	Sat, 29 Nov 2025 03:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764388384;
	bh=zayIHl3sV1RqJldd+BdPSA4Vl97m26XCFE1wNUlBqDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=djbI2opDugElxiH/p1b6XA8RHBJ6cWhHzWKRbsJLYCwNu6VndDjuWBdTDfNUK/ge9
	 Sl28u4Uf9hVLz3SUMgLMG3A/LrCtJStSjcsyT2mWvVJ6H67PWRUcc4+RSmwnSnuDUG
	 sq/CXsS2JwsxlJFxfL5c7nyRHn2ep2nBPdsbH9c4m5R5DObplln8605cgfvxgnLZvm
	 POb3reTdqO8iOUYED/otf6CBVIE5CnQNGtetwiNfLFVsWE24r/KlYS2R0P0zu/2g8X
	 ktJFEw8ajNoHCbzruphcG35Aab50dshkZxBKc4mAXPVORklRxgFxDEAfvHb9P1fyO7
	 z1nsqgYC/lxjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B979380692B;
	Sat, 29 Nov 2025 03:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: aquantia: check for NVMEM deferral
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176438820604.886304.2589073560221522060.git-patchwork-notify@kernel.org>
Date: Sat, 29 Nov 2025 03:50:06 +0000
References: <20251127114514.460924-1-robimarko@gmail.com>
In-Reply-To: <20251127114514.460924-1-robimarko@gmail.com>
To: Robert Marko <robimarko@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Nov 2025 12:44:35 +0100 you wrote:
> Currently, if NVMEM provider is probed later than Aquantia, loading the
> firmware will fail with -EINVAL.
> 
> To fix this, simply check for -EPROBE_DEFER when NVMEM is attempted and
> return it.
> 
> Fixes: e93984ebc1c8 ("net: phy: aquantia: add firmware load support")
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: phy: aquantia: check for NVMEM deferral
    https://git.kernel.org/netdev/net/c/a6c121a2432e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



